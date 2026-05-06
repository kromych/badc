//! Statement parser.
//!
//! Hosts the recursive-descent statement family that c5 dispatches
//! through `stmt()`:
//!
//!   * The control-flow shapes -- `if` / `if-else`, `while`,
//!     `do-while`, `for`, `switch` (+ `case`/`default` label
//!     handlers), `goto`, `break`, `continue`, `return`, `;`
//!     (empty stmt) -- plus the expression-statement default.
//!   * The block statement `{ ... }` and its block-scope
//!     declaration handlers (`parse_block_typedef`,
//!     `parse_block_local_decl`) which save shadowed bindings
//!     into a per-block vector and restore them on exit.
//!   * `consume(byte, msg)` -- the canonical single-byte-token
//!     consumer with a labelled error on mismatch. Used from
//!     every statement-shape parser plus a handful of expression
//!     paths in expr().
//!
//! Lives next to declarator / locals / aggregate / etc. because
//! the statement family is a coherent chunk that doesn't reach
//! into the rest of the parser's internals beyond the standard
//! Compiler state (text / symbols / lex / loop_breaks / etc.).

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::op::Op;
use super::super::token::Token;
use super::Compiler;
use super::types::{is_struct_ty, struct_ptr_depth};

impl Compiler {
    /// `for (init; cond; step) body`. The body is emitted between the
    /// condition (which falls through to it) and the step (which the
    /// body's tail jumps back to). `continue` patches into the step
    /// position; `break` patches past the loop end.
    pub(super) fn parse_for_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        // Initialization (optional). Comma operator: `for(i=0,j=0; ...)`.
        if self.lex.tk != ';' as i64 {
            self.expr(Token::Assign as i64)?;
            while self.lex.tk == ',' as i64 {
                self.next()?;
                self.expr(Token::Assign as i64)?;
            }
        }
        self.consume(b';', "semicolon expected after for-init")?;

        // Condition (optional -- empty means `1`).
        let cond_pc = self.text.len();
        if self.lex.tk != ';' as i64 {
            self.expr(Token::Assign as i64)?;
        } else {
            self.emit_imm(1);
        }
        self.emit_op(Op::Bz);
        let end_jmp_pc = self.text.len();
        self.emit_val(0);

        self.emit_op(Op::Jmp);
        let body_jmp_pc = self.text.len();
        self.emit_val(0);

        self.consume(b';', "semicolon expected after for-cond")?;

        // Step (optional). Compiled before the body so the body can jump
        // back to it; the body itself is reached via the `body_jmp_pc`
        // patched a few lines below. Comma operator: `i++, k--`.
        let step_pc = self.text.len();
        if self.lex.tk != ')' as i64 {
            self.expr(Token::Assign as i64)?;
            while self.lex.tk == ',' as i64 {
                self.next()?;
                self.expr(Token::Assign as i64)?;
            }
        }
        self.emit_jmp(cond_pc as i64);

        self.consume(b')', "close paren expected")?;

        // Body -- patched to start at the current PC.
        self.text[body_jmp_pc] = self.text.len() as i64;
        self.enter_loop();
        self.stmt()?;

        self.patch_loop_continues(step_pc);
        self.emit_jmp(step_pc as i64);

        self.text[end_jmp_pc] = self.text.len() as i64;
        let end_pc = self.text.len();
        self.patch_loop_breaks(end_pc);
        Ok(())
    }

    /// `switch (expr) { ... }`. Three phases: stash the scrutinee in a
    /// fresh local slot, parse the body (which records `case`/`default`
    /// label positions in `switch_cases`/`switch_defaults`), then emit a
    /// trailing dispatcher that compares the stashed value against each
    /// case label and jumps. Breaks inside the body are pushed onto
    /// `loop_breaks` and patched to land just past the dispatcher.
    pub(super) fn parse_switch_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        self.loc_offs += 1;
        let switch_val_offset = -self.loc_offs;
        self.emit_lea(switch_val_offset);
        self.emit_op(Op::Psh);

        self.expr(Token::Assign as i64)?;
        self.consume(b')', "close paren expected")?;

        self.emit_op(Op::Si);

        // Jump past the body to the dispatcher emitted at the end.
        self.emit_op(Op::Jmp);
        let disp_pc_patch = self.text.len();
        self.emit_val(0);

        self.switch_cases.push(Vec::new());
        self.switch_defaults.push(None);
        self.enter_switch();

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
            self.emit_lea(switch_val_offset);
            self.emit_op(Op::Li);
            self.emit_binop_with_imm(Op::Eq, val);
            self.emit_op(Op::Bnz);
            self.emit_val(pc as i64);
        }

        if let Some(dpc) = default_pc {
            self.emit_jmp(dpc as i64);
        } else {
            // No default: fall through to the end (patched below
            // alongside explicit `break`s).
            self.emit_jmp(0);
            self.record_break_jmp(self.text.len() - 1);
        }

        self.text[end_switch_patch] = self.text.len() as i64;
        let end_pc = self.text.len();
        self.patch_loop_breaks(end_pc);
        Ok(())
    }

    /// Parse a `typedef` at block scope. Same shape as the file-
    /// scope handler in run_compile, just routed here so block-
    /// local typedefs (e.g. sqlite's `typedef void(*LOGFUNC_t)(...)`
    /// inside a switch case) bind without bouncing through the
    /// declaration parser.
    fn parse_block_typedef(
        &mut self,
        block_symbols: &mut Vec<(usize, i64, i64, i64)>,
    ) -> Result<(), C5Error> {
        self.next()?; // consume `typedef`
        let lbt = self.parse_decl_base_type()?;
        while self.lex.tk != ';' as i64 {
            let (id_idx, ty, _) = self.parse_declarator(lbt)?;
            if id_idx == usize::MAX {
                return Err(C5Error::Compile(format!(
                    "{}: typedef requires a name",
                    self.lex.line
                )));
            }
            block_symbols.push((
                id_idx,
                self.symbols[id_idx].class,
                self.symbols[id_idx].type_,
                self.symbols[id_idx].val,
            ));
            self.symbols[id_idx].class = Token::Typedef as i64;
            self.symbols[id_idx].type_ = ty;
            self.symbols[id_idx].val = 0;
            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?; // consume `;`
        Ok(())
    }

    /// Parse a single block-scope declaration line:
    ///   `int x = 1, *p = q, c;`
    /// Each declarator is recorded in `block_symbols` so the enclosing
    /// `parse_block_stmt` can restore shadowed bindings on exit. An
    /// optional `= initializer` after each declarator emits the
    /// matching store sequence via `emit_local_init_store`.
    fn parse_block_local_decl(
        &mut self,
        block_symbols: &mut Vec<(usize, i64, i64, i64)>,
    ) -> Result<(), C5Error> {
        // Storage-class prefixes. `extern` is a no-op (c5 has no
        // separate translation units); `static` at function scope
        // promotes the declarator to a Glo symbol with persistent
        // data-segment storage.
        let mut is_static = false;
        while self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64 {
            if self.lex.tk == Token::Static as i64 {
                is_static = true;
            }
            self.next()?;
        }
        let lbt = self.parse_decl_base_type()?;
        while self.lex.tk != ';' as i64 {
            let (loc_idx, ty, array_size) = self.parse_declarator(lbt)?;
            self.ty = ty;

            block_symbols.push((
                loc_idx,
                self.symbols[loc_idx].class,
                self.symbols[loc_idx].type_,
                self.symbols[loc_idx].val,
            ));

            if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                self.allocate_static_local(loc_idx, ty, array_size)?;
            } else {
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.allocate_local_with_init(loc_idx, ty, array_size)?;
            }

            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?;
        Ok(())
    }

    /// `{ ... }`. C99 block-scope: declarations may appear anywhere a
    /// statement may. Each declaration's bindings shadow outer
    /// symbols for the duration of the block and are restored on
    /// exit.
    fn parse_block_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        let mut block_symbols = Vec::new();

        while self.lex.tk != '}' as i64 {
            if self.lex.tk == Token::Typedef as i64 {
                self.parse_block_typedef(&mut block_symbols)?;
            } else if self.lex_is_type_start() {
                self.parse_block_local_decl(&mut block_symbols)?;
            } else {
                self.stmt()?;
            }
        }
        self.next()?;

        // Restore shadowed bindings on block exit.
        for (idx, class, ty, val) in block_symbols.into_iter().rev() {
            self.symbols[idx].class = class;
            self.symbols[idx].type_ = ty;
            self.symbols[idx].val = val;
        }
        Ok(())
    }

    pub(super) fn stmt(&mut self) -> Result<(), C5Error> {
        if self.lex.tk == Token::Id as i64 && self.lex.peek_after_whitespace(b':') {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.labels.push((name, self.text.len()));
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

            self.enter_loop();
            self.stmt()?;
            self.patch_loop_continues(cond_pc);

            self.emit_jmp(cond_pc as i64);

            self.text[bz_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            self.patch_loop_breaks(end_pc);
        } else if self.lex.tk == Token::Do as i64 {
            self.next()?;
            let start_pc = self.text.len();

            self.enter_loop();
            self.stmt()?;

            if self.lex.tk == Token::While as i64 {
                self.next()?;
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: while expected after do",
                    self.lex.line
                )));
            }

            let cond_pc = self.text.len();
            self.patch_loop_continues(cond_pc);

            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;

            self.emit_op(Op::Bnz);
            self.emit_val(start_pc as i64);

            self.consume(b';', "semicolon expected after do-while")?;

            let end_pc = self.text.len();
            self.patch_loop_breaks(end_pc);
        } else if self.lex.tk == Token::For as i64 {
            self.parse_for_stmt()?;
        } else if self.lex.tk == Token::Switch as i64 {
            self.parse_switch_stmt()?;
        } else if self.lex.tk == Token::Case as i64 {
            self.next()?;
            // Case label is a constant expression: integer literal,
            // negated literal, parenthesised literal, enum / `#define`d
            // constant. parse_const_expr_or covers all of these and the
            // `(-16)` / `0x10|0x20` shapes sqlite uses.
            let val = self.parse_const_expr_or()?;
            self.consume(b':', "expected colon after case")?;
            let Some(cases) = self.switch_cases.last_mut() else {
                return Err(C5Error::Compile(format!(
                    "{}: case outside switch",
                    self.lex.line
                )));
            };
            cases.push((val, self.text.len()));
            self.stmt()?;
        } else if self.lex.tk == Token::Default as i64 {
            self.next()?;
            self.consume(b':', "expected colon after default")?;
            let Some(def) = self.switch_defaults.last_mut() else {
                return Err(C5Error::Compile(format!(
                    "{}: default outside switch",
                    self.lex.line
                )));
            };
            *def = Some(self.text.len());
            self.stmt()?;
        } else if self.lex.tk == Token::Goto as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: expected identifier after goto",
                    self.lex.line
                )));
            }
            let target_name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;

            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);

            match self.labels.iter().find(|(n, _)| n == &target_name) {
                Some(&(_, target)) => self.text[pc] = target as i64,
                None => self.unresolved_gotos.push((target_name, pc)),
            }

            self.consume(b';', "semicolon expected after goto")?;
        } else if self.lex.tk == Token::Break as i64 {
            self.next()?;
            if self.loop_breaks.is_empty() {
                return Err(C5Error::Compile(format!(
                    "{}: break outside of loop or switch",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.record_break_jmp(pc);
            self.consume(b';', "semicolon expected after break")?;
        } else if self.lex.tk == Token::Continue as i64 {
            self.next()?;
            if self.loop_continues.is_empty() {
                return Err(C5Error::Compile(format!(
                    "{}: continue outside of loop",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.record_continue_jmp(pc);
            self.consume(b';', "semicolon expected after continue")?;
        } else if self.lex.tk == Token::Return as i64 {
            self.next()?;
            let ret_ty = self.current_func_return_ty;
            let returns_struct = is_struct_ty(ret_ty) && struct_ptr_depth(ret_ty) == 0;
            if self.lex.tk != ';' as i64 {
                if returns_struct {
                    // Push the hidden out-pointer (loaded from
                    // val=2 -- the slot the caller pushed before
                    // the declared args) and emit Mcpy to copy
                    // the source struct's bytes into the caller's
                    // result temp. Then Lev. The accumulator
                    // value Lev returns is overwritten by the
                    // call site's `Lea result_temp` after the
                    // call so the assignment has a stable
                    // address to copy from.
                    self.emit_lea(2);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: returning a non-struct value from a \
                             struct-returning function",
                            self.lex.line
                        )));
                    }
                    let size = self.size_of_type(ret_ty);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                } else {
                    self.expr(Token::Assign as i64)?;
                }
            }
            self.emit_op(Op::Lev);
            self.consume(b';', "semicolon expected")?;
        } else if self.lex.tk == '{' as i64 {
            self.parse_block_stmt()?;
        } else if self.lex.tk == ';' as i64 {
            self.next()?;
        } else {
            self.expr(Token::Assign as i64)?;
            // Comma operator at expression-statement level:
            // `(void)x, (void)y;`. Each expression evaluates for
            // its side effects; the value of the chain is the
            // last subexpression. expr(Assign) deliberately stops
            // at `,` because c5's argument parser uses `,` as a
            // separator -- we resume the chain here.
            while self.lex.tk == ',' as i64 {
                self.next()?;
                self.expr(Token::Assign as i64)?;
            }
            self.consume(b';', "semicolon expected")?;
        }
        Ok(())
    }

    /// Consume a single-byte token, returning a labelled compile error otherwise.
    pub(super) fn consume(&mut self, expected: u8, msg: &str) -> Result<(), C5Error> {
        if self.lex.tk == expected as i64 {
            self.next()?;
            Ok(())
        } else {
            Err(C5Error::Compile(format!(
                "{}: {} (got tk={}, id={:?})",
                self.lex.line,
                msg,
                self.lex.tk,
                if self.lex.tk == Token::Id as i64 {
                    Some(self.symbols[self.lex.curr_id_idx].name.clone())
                } else {
                    None
                }
            )))
        }
    }
}
