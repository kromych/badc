use std::collections::HashMap;

use super::error::C4Error;
use super::lexer::{self, Lexer};
use super::op::Op;
use super::program::Program;
use super::symbol::Symbol;
use super::token::{Token, Ty};

/// Single-pass C compiler. Holds the lexer, the symbol table, and the
/// codegen scaffolding. `compile(self)` consumes the compiler and produces
/// a [`Program`] ready for the VM.
pub struct Compiler {
    lex: Lexer,
    symbols: Vec<Symbol>,

    // --- Codegen state ---
    text: Vec<i64>,
    data: Vec<u8>,
    /// Type of the current expression — set by `expr` callees, read by callers
    /// to decide between byte and word loads/stores and for pointer scaling.
    ty: i64,
    /// Number of local-variable slots currently reserved in the active stack
    /// frame; patched into `Op::Ent` at the end of the function.
    loc_offs: i64,

    // --- Patch lists ---
    loop_breaks: Vec<Vec<usize>>,
    loop_continues: Vec<Vec<usize>>,
    labels: HashMap<String, usize>,
    unresolved_gotos: Vec<(String, usize)>,
    switch_cases: Vec<Vec<(i64, usize)>>,
    switch_defaults: Vec<Option<usize>>,
}

impl Compiler {
    pub fn new(source: String) -> Self {
        let mut symbols = Vec::new();
        lexer::init_symbols(&mut symbols);
        Self {
            lex: Lexer::new(source),
            symbols,
            text: Vec::new(),
            data: Vec::new(),
            ty: 0,
            loc_offs: 0,
            loop_breaks: Vec::new(),
            loop_continues: Vec::new(),
            labels: HashMap::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
        }
    }

    /// Compile the source. On success, the returned `Program` contains the
    /// bytecode, the static data segment, and the PC of `main`.
    pub fn compile(mut self) -> Result<Program, C4Error> {
        self.run_compile()?;
        let main_idx = lexer::find_symbol(&self.symbols, "main")
            .ok_or_else(|| C4Error::Compile("main() not defined".to_string()))?;
        if self.symbols[main_idx].class != Token::Fun as i64 {
            return Err(C4Error::Compile("main() not defined".to_string()));
        }
        let entry_pc = self.symbols[main_idx].val as usize;
        Ok(Program {
            text: self.text,
            data: self.data,
            entry_pc,
        })
    }

    // ---- Lexer plumbing ----

    fn next(&mut self) -> Result<(), C4Error> {
        self.lex.next(&mut self.symbols, &mut self.data)
    }

    // ---- Code emission ----

    fn emit_op(&mut self, op: Op) {
        self.text.push(op as i64);
    }

    fn emit_val(&mut self, val: i64) {
        self.text.push(val);
    }

    // ---- Recursive descent ----

    fn expr(&mut self, lev: i64) -> Result<(), C4Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(C4Error::Compile(format!(
                "{}: unexpected eof in expression",
                self.lex.line
            )));
        } else if self.lex.tk == Token::Num as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.lex.ival);
            self.next()?;
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '"' as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.lex.ival);
            self.next()?;
            while self.lex.tk == '"' as i64 {
                self.next()?;
            }
            self.ty = Ty::Ptr as i64;
        } else if self.lex.tk == Token::Sizeof as i64 {
            self.next()?;
            if self.lex.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected in sizeof",
                    self.lex.line
                )));
            }
            self.ty = Ty::Int as i64;
            if self.lex.tk == Token::Int as i64 {
                self.next()?;
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                self.ty = Ty::Char as i64;
            }
            while self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                self.ty += Ty::Ptr as i64;
            }
            if self.lex.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected in sizeof",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Imm);
            self.emit_val(if self.ty == Ty::Char as i64 { 1 } else { 8 });
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::Id as i64 {
            let id_idx = self.lex.curr_id_idx;
            self.next()?;
            if self.lex.tk == '(' as i64 {
                self.next()?;
                let mut nargs = 0;
                while self.lex.tk != ')' as i64 {
                    self.expr(Token::Assign as i64)?;
                    self.emit_op(Op::Psh);
                    nargs += 1;
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                self.next()?;
                if self.symbols[id_idx].class == Token::Sys as i64 {
                    self.emit_op(Op::from_i64(self.symbols[id_idx].val).unwrap());
                } else if self.symbols[id_idx].class == Token::Fun as i64 {
                    self.emit_op(Op::Jsr);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Loc as i64
                    || self.symbols[id_idx].class == Token::Glo as i64
                {
                    if self.symbols[id_idx].class == Token::Loc as i64 {
                        self.emit_op(Op::Lea);
                        self.emit_val(self.symbols[id_idx].val);
                    } else {
                        self.emit_op(Op::Imm);
                        self.emit_val(self.symbols[id_idx].val);
                    }
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Jsri);
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad function call",
                        self.lex.line
                    )));
                }
                if nargs > 0 {
                    self.emit_op(Op::Adj);
                    self.emit_val(nargs);
                }
                self.ty = self.symbols[id_idx].type_;
            } else if self.symbols[id_idx].class == Token::Num as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(self.symbols[id_idx].val);
                self.ty = Ty::Int as i64;
            } else if self.symbols[id_idx].class == Token::Fun as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(self.symbols[id_idx].val);
                self.ty = Ty::Ptr as i64;
            } else {
                if self.symbols[id_idx].class == Token::Loc as i64 {
                    self.emit_op(Op::Lea);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_op(Op::Imm);
                    self.emit_val(self.symbols[id_idx].val);
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: undefined variable {}",
                        self.lex.line, self.symbols[id_idx].name
                    )));
                }
                self.ty = self.symbols[id_idx].type_;
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Lc
                } else {
                    Op::Li
                });
            }
        } else if self.lex.tk == '(' as i64 {
            self.next()?;
            if self.lex.tk == Token::Int as i64 || self.lex.tk == Token::Char as i64 {
                t = if self.lex.tk == Token::Int as i64 {
                    Ty::Int as i64
                } else {
                    Ty::Char as i64
                };
                self.next()?;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    t += Ty::Ptr as i64;
                }
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!("{}: bad cast", self.lex.line)));
                }
                self.expr(Token::Inc as i64)?;
                self.ty = t;
            } else {
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.lex.line
                    )));
                }
            }
        } else if self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if self.ty > Ty::Int as i64 {
                self.ty -= Ty::Ptr as i64;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: bad dereference",
                    self.lex.line
                )));
            }
            self.emit_op(if self.ty == Ty::Char as i64 {
                Op::Lc
            } else {
                Op::Li
            });
        } else if self.lex.tk == Token::AndOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = self.text.pop().unwrap();
            if last != Op::Lc as i64 && last != Op::Li as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: bad address-of",
                    self.lex.line
                )));
            }
            self.ty += Ty::Ptr as i64;
        } else if self.lex.tk == '!' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(0);
            self.emit_op(Op::Eq);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '~' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(-1);
            self.emit_op(Op::Xor);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::AddOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::SubOp as i64 {
            self.next()?;
            self.emit_op(Op::Imm);
            if self.lex.tk == Token::Num as i64 {
                self.emit_val(-self.lex.ival);
                self.next()?;
            } else {
                self.emit_val(-1);
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mul);
            }
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::Inc as i64 || self.lex.tk == Token::Dec as i64 {
            t = self.lex.tk;
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = *self.text.last().unwrap();
            if last == Op::Lc as i64 {
                *self.text.last_mut().unwrap() = Op::Psh as i64;
                self.emit_op(Op::Lc);
            } else if last == Op::Li as i64 {
                *self.text.last_mut().unwrap() = Op::Psh as i64;
                self.emit_op(Op::Li);
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: bad lvalue in pre-increment",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
            self.emit_op(if t == Token::Inc as i64 {
                Op::Add
            } else {
                Op::Sub
            });
            self.emit_op(if self.ty == Ty::Char as i64 {
                Op::Sc
            } else {
                Op::Si
            });
        } else {
            return Err(C4Error::Compile(format!(
                "{}: bad expression tk={}",
                self.lex.line, self.lex.tk
            )));
        }

        while self.lex.tk >= lev {
            t = self.ty;
            if self.lex.tk == Token::Assign as i64 {
                self.next()?;
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 || last == Op::Li as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in assignment",
                        self.lex.line
                    )));
                }
                self.expr(Token::Assign as i64)?;
                self.ty = t;
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Sc
                } else {
                    Op::Si
                });
            } else if self.lex.tk == Token::Cond as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ':' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: conditional missing colon",
                        self.lex.line
                    )));
                }
                let b_end_val = (self.text.len() + 2) as i64;
                self.text[b_else] = b_end_val;
                self.emit_op(Op::Jmp);
                let b_end = self.text.len();
                self.emit_val(0);
                self.expr(Token::Cond as i64)?;
                self.text[b_end] = self.text.len() as i64;
            } else if self.lex.tk == Token::Lor as i64 {
                self.next()?;
                self.emit_op(Op::Bnz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::Lan as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Lan as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::OrOp as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::OrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::XorOp as i64)?;
                self.emit_op(Op::Or);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::XorOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AndOp as i64)?;
                self.emit_op(Op::Xor);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::AndOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::EqOp as i64)?;
                self.emit_op(Op::And);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::EqOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                self.emit_op(Op::Eq);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::NeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                self.emit_op(Op::Ne);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Lt);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Gt);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Le);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Ge);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShlOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shl);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shr);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::AddOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if t > Ty::Ptr as i64 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                }
                self.emit_op(Op::Add);
                self.ty = t;
            } else if self.lex.tk == Token::SubOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if t > Ty::Ptr as i64 && t == self.ty {
                    self.emit_op(Op::Sub);
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Div);
                    self.ty = Ty::Int as i64;
                } else if t > Ty::Ptr as i64 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                    self.emit_op(Op::Sub);
                    self.ty = t;
                } else {
                    self.emit_op(Op::Sub);
                    self.ty = t;
                }
            } else if self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mul);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::DivOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Div);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ModOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mod);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Inc as i64 || self.lex.tk == Token::Dec as i64 {
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Lc);
                } else if last == Op::Li as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Li);
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in post-increment",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                self.emit_op(if self.lex.tk == Token::Inc as i64 {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Sc
                } else {
                    Op::Si
                });
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                self.emit_op(if self.lex.tk == Token::Inc as i64 {
                    Op::Sub
                } else {
                    Op::Add
                });
                self.next()?;
            } else if self.lex.tk == Token::Brak as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ']' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close bracket expected",
                        self.lex.line
                    )));
                }
                if t > Ty::Ptr as i64 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                } else if t < Ty::Ptr as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: pointer type expected",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Add);
                self.ty = t - Ty::Ptr as i64;
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Lc
                } else {
                    Op::Li
                });
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: compiler error tk={}",
                    self.lex.line, self.lex.tk
                )));
            }
        }
        Ok(())
    }

    fn stmt(&mut self) -> Result<(), C4Error> {
        if self.lex.tk == Token::Id as i64 && self.lex.peek_after_whitespace(b':') {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.labels.insert(name, self.text.len());
            self.next()?; // consume Id
            self.next()?; // consume ':'
            self.stmt()?;
            return Ok(());
        }

        if self.lex.tk == Token::If as i64 {
            self.next()?;
            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;
            self.emit_op(Op::Bz);
            let b = self.text.len();
            self.emit_val(0);
            self.stmt()?;
            if self.lex.tk == Token::Else as i64 {
                self.text[b] = (self.text.len() + 2) as i64;
                self.emit_op(Op::Jmp);
                let b_else = self.text.len();
                self.emit_val(0);
                self.next()?;
                self.stmt()?;
                self.text[b_else] = self.text.len() as i64;
            } else {
                self.text[b] = self.text.len() as i64;
            }
        } else if self.lex.tk == Token::While as i64 {
            self.next()?;
            let cond_pc = self.text.len();
            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;
            self.emit_op(Op::Bz);
            let bz_pc = self.text.len();
            self.emit_val(0);

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            self.emit_op(Op::Jmp);
            self.emit_val(cond_pc as i64);

            self.text[bz_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::Do as i64 {
            self.next()?;
            let start_pc = self.text.len();

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            if self.lex.tk == Token::While as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: while expected after do",
                    self.lex.line
                )));
            }

            let cond_pc = self.text.len();
            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;

            self.emit_op(Op::Bnz);
            self.emit_val(start_pc as i64);

            self.consume(b';', "semicolon expected after do-while")?;

            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::For as i64 {
            self.next()?;
            self.consume(b'(', "open paren expected")?;

            // Initialization
            if self.lex.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            self.consume(b';', "semicolon expected after for-init")?;

            // Condition
            let cond_pc = self.text.len();
            if self.lex.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
            } else {
                self.emit_op(Op::Imm);
                self.emit_val(1);
            }
            self.emit_op(Op::Bz);
            let end_jmp_pc = self.text.len();
            self.emit_val(0);

            self.emit_op(Op::Jmp);
            let body_jmp_pc = self.text.len();
            self.emit_val(0);

            self.consume(b';', "semicolon expected after for-cond")?;

            // Step
            let step_pc = self.text.len();
            if self.lex.tk != ')' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            self.emit_op(Op::Jmp);
            self.emit_val(cond_pc as i64);

            self.consume(b')', "close paren expected")?;

            // Body
            self.text[body_jmp_pc] = self.text.len() as i64;

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = step_pc as i64;
            }

            self.emit_op(Op::Jmp);
            self.emit_val(step_pc as i64);

            self.text[end_jmp_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::Switch as i64 {
            self.next()?;
            self.consume(b'(', "open paren expected")?;

            self.loc_offs += 1;
            let switch_val_offset = -self.loc_offs;
            self.emit_op(Op::Lea);
            self.emit_val(switch_val_offset);
            self.emit_op(Op::Psh);

            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;

            self.emit_op(Op::Si);

            // Jump to the dispatcher emitted after the body.
            self.emit_op(Op::Jmp);
            let disp_pc_patch = self.text.len();
            self.emit_val(0);

            self.switch_cases.push(Vec::new());
            self.switch_defaults.push(None);
            self.loop_breaks.push(Vec::new());

            self.stmt()?;

            // Fall-through past the body skips the dispatcher entirely.
            self.emit_op(Op::Jmp);
            let end_switch_patch = self.text.len();
            self.emit_val(0);

            // Dispatcher block.
            self.text[disp_pc_patch] = self.text.len() as i64;
            let cases = self.switch_cases.pop().unwrap();
            let default_pc = self.switch_defaults.pop().unwrap();

            for (val, pc) in cases {
                self.emit_op(Op::Lea);
                self.emit_val(switch_val_offset);
                self.emit_op(Op::Li);
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(val);
                self.emit_op(Op::Eq);
                self.emit_op(Op::Bnz);
                self.emit_val(pc as i64);
            }

            if let Some(dpc) = default_pc {
                self.emit_op(Op::Jmp);
                self.emit_val(dpc as i64);
            } else {
                // No default: fall to the end (patched below alongside breaks).
                self.emit_op(Op::Jmp);
                self.emit_val(0);
                self.loop_breaks
                    .last_mut()
                    .unwrap()
                    .push(self.text.len() - 1);
            }

            self.text[end_switch_patch] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::Case as i64 {
            self.next()?;
            if self.lex.tk != Token::Num as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: invalid case value",
                    self.lex.line
                )));
            }
            let val = self.lex.ival;
            self.next()?;
            self.consume(b':', "expected colon after case")?;
            if let Some(cases) = self.switch_cases.last_mut() {
                cases.push((val, self.text.len()));
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: case outside switch",
                    self.lex.line
                )));
            }
            self.stmt()?;
        } else if self.lex.tk == Token::Default as i64 {
            self.next()?;
            self.consume(b':', "expected colon after default")?;
            if let Some(def) = self.switch_defaults.last_mut() {
                *def = Some(self.text.len());
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: default outside switch",
                    self.lex.line
                )));
            }
            self.stmt()?;
        } else if self.lex.tk == Token::Goto as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: expected identifier after goto",
                    self.lex.line
                )));
            }
            let target_name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;

            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);

            if let Some(&target) = self.labels.get(&target_name) {
                self.text[pc] = target as i64;
            } else {
                self.unresolved_gotos.push((target_name, pc));
            }

            self.consume(b';', "semicolon expected after goto")?;
        } else if self.lex.tk == Token::Break as i64 {
            self.next()?;
            if self.loop_breaks.is_empty() {
                return Err(C4Error::Compile(format!(
                    "{}: break outside of loop or switch",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_breaks.last_mut().unwrap().push(pc);
            self.consume(b';', "semicolon expected after break")?;
        } else if self.lex.tk == Token::Continue as i64 {
            self.next()?;
            if self.loop_continues.is_empty() {
                return Err(C4Error::Compile(format!(
                    "{}: continue outside of loop",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_continues.last_mut().unwrap().push(pc);
            self.consume(b';', "semicolon expected after continue")?;
        } else if self.lex.tk == Token::Return as i64 {
            self.next()?;
            if self.lex.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            self.emit_op(Op::Lev);
            self.consume(b';', "semicolon expected")?;
        } else if self.lex.tk == '{' as i64 {
            self.next()?;
            let mut block_symbols = Vec::new();

            // Block-scoped local variables (declared at the top of the block).
            while self.lex.tk == Token::Int as i64 || self.lex.tk == Token::Char as i64 {
                let lbt = if self.lex.tk == Token::Int as i64 {
                    Ty::Int as i64
                } else {
                    Ty::Char as i64
                };
                self.next()?;
                while self.lex.tk != ';' as i64 {
                    self.ty = lbt;
                    while self.lex.tk == Token::MulOp as i64 {
                        self.next()?;
                        self.ty += Ty::Ptr as i64;
                    }
                    if self.lex.tk != Token::Id as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad local declaration",
                            self.lex.line
                        )));
                    }
                    let loc_idx = self.lex.curr_id_idx;

                    block_symbols.push((
                        loc_idx,
                        self.symbols[loc_idx].class,
                        self.symbols[loc_idx].type_,
                        self.symbols[loc_idx].val,
                    ));

                    self.symbols[loc_idx].class = Token::Loc as i64;
                    self.symbols[loc_idx].type_ = self.ty;
                    self.loc_offs += 1;
                    self.symbols[loc_idx].val = -self.loc_offs;

                    self.next()?;
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                self.next()?;
            }

            while self.lex.tk != '}' as i64 {
                self.stmt()?;
            }
            self.next()?;

            // Restore shadowed bindings.
            for (idx, class, ty, val) in block_symbols.into_iter().rev() {
                self.symbols[idx].class = class;
                self.symbols[idx].type_ = ty;
                self.symbols[idx].val = val;
            }
        } else if self.lex.tk == ';' as i64 {
            self.next()?;
        } else {
            self.expr(Token::Assign as i64)?;
            self.consume(b';', "semicolon expected")?;
        }
        Ok(())
    }

    /// Consume a single-byte token, returning a labelled compile error otherwise.
    fn consume(&mut self, expected: u8, msg: &str) -> Result<(), C4Error> {
        if self.lex.tk == expected as i64 {
            self.next()?;
            Ok(())
        } else {
            Err(C4Error::Compile(format!("{}: {}", self.lex.line, msg)))
        }
    }

    fn parse_enum_decl(&mut self) -> Result<(), C4Error> {
        self.next()?;
        if self.lex.tk != '{' as i64 {
            self.next()?;
        }
        if self.lex.tk == '{' as i64 {
            self.next()?;
            let mut i = 0;
            while self.lex.tk != '}' as i64 {
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad enum identifier",
                        self.lex.line
                    )));
                }
                let idx = self.lex.curr_id_idx;
                self.next()?;
                if self.lex.tk == Token::Assign as i64 {
                    self.next()?;
                    if self.lex.tk != Token::Num as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad enum initializer",
                            self.lex.line
                        )));
                    }
                    i = self.lex.ival;
                    self.next()?;
                }
                self.symbols[idx].class = Token::Num as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.symbols[idx].val = i;
                i += 1;
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }

    fn parse_function_params(&mut self) -> Result<Vec<usize>, C4Error> {
        let mut args = Vec::new();
        while self.lex.tk != ')' as i64 {
            self.ty = Ty::Int as i64;
            if self.lex.tk == Token::Int as i64 {
                self.next()?;
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                self.ty = Ty::Char as i64;
            }
            while self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                self.ty += Ty::Ptr as i64;
            }
            if self.lex.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: bad parameter declaration",
                    self.lex.line
                )));
            }
            let param_idx = self.lex.curr_id_idx;
            if self.symbols[param_idx].class == Token::Loc as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: duplicate parameter definition",
                    self.lex.line
                )));
            }

            self.symbols[param_idx].h_class = self.symbols[param_idx].class;
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].h_type = self.symbols[param_idx].type_;
            self.symbols[param_idx].type_ = self.ty;
            self.symbols[param_idx].h_val = self.symbols[param_idx].val;

            args.push(param_idx);

            self.next()?;
            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?;
        Ok(args)
    }

    fn run_compile(&mut self) -> Result<(), C4Error> {
        self.next()?;
        while self.lex.tk != 0 {
            let mut bt = Ty::Int as i64;
            if self.lex.tk == Token::Int as i64 {
                self.next()?;
                bt = Ty::Int as i64;
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                bt = Ty::Char as i64;
            } else if self.lex.tk == Token::Enum as i64 {
                self.parse_enum_decl()?;
            }

            while self.lex.tk != ';' as i64 && self.lex.tk != '}' as i64 {
                self.ty = bt;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.ty += Ty::Ptr as i64;
                }
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad global declaration",
                        self.lex.line
                    )));
                }
                let id_idx = self.lex.curr_id_idx;
                if self.symbols[id_idx].class != 0 {
                    return Err(C4Error::Compile(format!(
                        "{}: duplicate global definition",
                        self.lex.line
                    )));
                }
                self.next()?;
                self.symbols[id_idx].type_ = self.ty;

                if self.lex.tk == '(' as i64 {
                    self.symbols[id_idx].class = Token::Fun as i64;
                    self.symbols[id_idx].val = self.text.len() as i64;
                    self.next()?;

                    let args = self.parse_function_params()?;

                    if self.lex.tk != '{' as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad function definition",
                            self.lex.line
                        )));
                    }
                    self.next()?;

                    let nargs = args.len() as i64;
                    for (i, &idx) in args.iter().enumerate() {
                        self.symbols[idx].val = nargs - (i as i64) + 1;
                    }

                    self.loc_offs = 0;
                    self.labels.clear();
                    self.unresolved_gotos.clear();

                    while self.lex.tk == Token::Int as i64 || self.lex.tk == Token::Char as i64 {
                        let lbt = if self.lex.tk == Token::Int as i64 {
                            Ty::Int as i64
                        } else {
                            Ty::Char as i64
                        };
                        self.next()?;
                        while self.lex.tk != ';' as i64 {
                            self.ty = lbt;
                            while self.lex.tk == Token::MulOp as i64 {
                                self.next()?;
                                self.ty += Ty::Ptr as i64;
                            }
                            if self.lex.tk != Token::Id as i64 {
                                return Err(C4Error::Compile(format!(
                                    "{}: bad local declaration",
                                    self.lex.line
                                )));
                            }
                            let loc_idx = self.lex.curr_id_idx;
                            if self.symbols[loc_idx].class == Token::Loc as i64 {
                                return Err(C4Error::Compile(format!(
                                    "{}: duplicate local definition",
                                    self.lex.line
                                )));
                            }

                            self.symbols[loc_idx].h_class = self.symbols[loc_idx].class;
                            self.symbols[loc_idx].class = Token::Loc as i64;
                            self.symbols[loc_idx].h_type = self.symbols[loc_idx].type_;
                            self.symbols[loc_idx].type_ = self.ty;
                            self.symbols[loc_idx].h_val = self.symbols[loc_idx].val;

                            self.loc_offs += 1;
                            self.symbols[loc_idx].val = -self.loc_offs;

                            self.next()?;
                            if self.lex.tk == ',' as i64 {
                                self.next()?;
                            }
                        }
                        self.next()?;
                    }

                    let ent_pc = self.text.len();
                    self.emit_op(Op::Ent);
                    self.emit_val(0); // patched below

                    while self.lex.tk != '}' as i64 {
                        self.stmt()?;
                    }
                    self.emit_op(Op::Lev);

                    self.text[ent_pc + 1] = self.loc_offs;

                    for (name, pc) in &self.unresolved_gotos {
                        if let Some(&target) = self.labels.get(name) {
                            self.text[*pc] = target as i64;
                        } else {
                            return Err(C4Error::Compile(format!("unresolved label: {}", name)));
                        }
                    }

                    for sym in self.symbols.iter_mut() {
                        if sym.class == Token::Loc as i64 {
                            sym.class = sym.h_class;
                            sym.type_ = sym.h_type;
                            sym.val = sym.h_val;
                        }
                    }
                } else {
                    self.symbols[id_idx].class = Token::Glo as i64;
                    self.symbols[id_idx].val = self.data.len() as i64;
                    for _ in 0..8 {
                        self.data.push(0);
                    }
                }
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }
}
