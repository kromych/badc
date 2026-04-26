use super::{C4, C4Error, Op, Symbol, Token, Ty};

impl C4 {
    pub(super) fn init_symbols(&mut self) {
        let keywords = [
            ("char", Token::Char),
            ("else", Token::Else),
            ("enum", Token::Enum),
            ("for", Token::For),
            ("if", Token::If),
            ("int", Token::Int),
            ("return", Token::Return),
            ("sizeof", Token::Sizeof),
            ("while", Token::While),
            ("do", Token::Do),
            ("break", Token::Break),
            ("continue", Token::Continue),
            ("goto", Token::Goto),
            ("switch", Token::Switch),
            ("case", Token::Case),
            ("default", Token::Default),
            ("open", Token::Id),
            ("read", Token::Id),
            ("close", Token::Id),
            ("printf", Token::Id),
            ("malloc", Token::Id),
            ("free", Token::Id),
            ("memset", Token::Id),
            ("memcmp", Token::Id),
            ("exit", Token::Id),
            ("void", Token::Char),
            ("main", Token::Id),
        ];

        let lib_ops = [
            ("open", Op::Open),
            ("read", Op::Read),
            ("close", Op::Clos),
            ("printf", Op::Prtf),
            ("malloc", Op::Malc),
            ("free", Op::Free),
            ("memset", Op::Mset),
            ("memcmp", Op::Mcmp),
            ("exit", Op::Exit),
        ];

        for (name, tok) in keywords.iter() {
            self.add_keyword(name, *tok as i64);
        }

        for (name, op) in lib_ops.iter() {
            let idx = self.find_symbol(name).unwrap();
            self.symbols[idx].class = Token::Sys as i64;
            self.symbols[idx].type_ = Ty::Int as i64;
            self.symbols[idx].val = *op as i64;
        }

        let _ = self.find_symbol("main").unwrap();
    }

    fn add_keyword(&mut self, name: &str, token: i64) {
        let hash = self.hash_name(name.as_bytes());
        self.symbols.push(Symbol {
            name: name.to_string(),
            hash,
            token,
            ..Default::default()
        });
    }

    pub fn hash_name(&self, name: &[u8]) -> i64 {
        let mut h: i64 = 0;
        for &b in name {
            h = h.wrapping_mul(147).wrapping_add(b as i64);
        }
        h
    }

    pub fn find_symbol(&self, name: &str) -> Option<usize> {
        self.symbols.iter().position(|s| s.name == name)
    }

    pub fn resolve_symbol(&mut self, name: &[u8], hash: i64) -> usize {
        for (i, s) in self.symbols.iter().enumerate().rev() {
            if s.hash == hash && s.token != 0 && s.name.as_bytes() == name {
                return i;
            }
        }

        let sym = Symbol {
            name: String::from_utf8_lossy(name).to_string(),
            hash,
            token: Token::Id as i64,
            ..Default::default()
        };
        self.symbols.push(sym);
        self.symbols.len() - 1
    }

    fn next(&mut self) -> Result<(), C4Error> {
        loop {
            if self.src_pos >= self.src.len() {
                self.tk = 0;
                return Ok(());
            }

            let c = self.src[self.src_pos] as char;
            self.src_pos += 1;

            if c == '\n' {
                self.line += 1;
            } else if c == '#' {
                while self.src_pos < self.src.len() && self.src[self.src_pos] as char != '\n' {
                    self.src_pos += 1;
                }
            } else if c.is_ascii_alphabetic() || c == '_' {
                let start = self.src_pos - 1;
                let mut hash: i64 = c as i64;
                while self.src_pos < self.src.len() {
                    let nc = self.src[self.src_pos] as char;
                    if !nc.is_ascii_alphanumeric() && nc != '_' {
                        break;
                    }
                    hash = hash.wrapping_mul(147).wrapping_add(nc as i64);
                    self.src_pos += 1;
                }
                let name_vec = self.src[start..self.src_pos].to_vec();
                self.curr_id_idx = self.resolve_symbol(&name_vec, hash);
                self.tk = self.symbols[self.curr_id_idx].token;
                return Ok(());
            } else if c.is_ascii_digit() {
                let mut val = (c as u8 - b'0') as i64;
                if val == 0
                    && self.src_pos < self.src.len()
                    && (self.src[self.src_pos] as char == 'x'
                        || self.src[self.src_pos] as char == 'X')
                {
                    self.src_pos += 1;
                    while self.src_pos < self.src.len() {
                        let nc = self.src[self.src_pos] as char;
                        if nc.is_ascii_digit() {
                            val = val * 16 + (nc as u8 - b'0') as i64;
                        } else if ('a'..='f').contains(&nc) {
                            val = val * 16 + (nc as u8 - b'a' + 10) as i64;
                        } else if ('A'..='F').contains(&nc) {
                            val = val * 16 + (nc as u8 - b'A' + 10) as i64;
                        } else {
                            break;
                        }
                        self.src_pos += 1;
                    }
                } else {
                    while self.src_pos < self.src.len() {
                        let nc = self.src[self.src_pos] as char;
                        if !nc.is_ascii_digit() {
                            break;
                        }
                        val = val * 10 + (nc as u8 - b'0') as i64;
                        self.src_pos += 1;
                    }
                }
                self.ival = val;
                self.tk = Token::Num as i64;
                return Ok(());
            } else if c == '/' {
                if self.src_pos < self.src.len() && self.src[self.src_pos] as char == '/' {
                    self.src_pos += 1;
                    while self.src_pos < self.src.len()
                        && self.src[self.src_pos] as char != '\n'
                    {
                        self.src_pos += 1;
                    }
                } else {
                    self.tk = Token::DivOp as i64;
                    return Ok(());
                }
            } else if c == '\'' || c == '"' {
                let start_data = self.data.len() as i64;
                while self.src_pos < self.src.len() && self.src[self.src_pos] as char != c {
                    let mut val = self.src[self.src_pos] as i64;
                    self.src_pos += 1;
                    if val == '\\' as i64 {
                        val = self.src[self.src_pos] as i64;
                        self.src_pos += 1;
                        if val == 'n' as i64 {
                            val = '\n' as i64;
                        }
                    }
                    if c == '"' {
                        self.data.push(val as u8);
                    } else {
                        self.ival = val;
                    }
                }
                self.src_pos += 1;
                if c == '"' {
                    self.data.push(0);
                    self.ival = start_data;
                    self.tk = '"' as i64;
                } else {
                    self.tk = Token::Num as i64;
                }
                return Ok(());
            } else {
                let next_char = if self.src_pos < self.src.len() {
                    self.src[self.src_pos] as char
                } else {
                    '\0'
                };
                match c {
                    '=' => {
                        if next_char == '=' {
                            self.src_pos += 1;
                            self.tk = Token::EqOp as i64;
                        } else {
                            self.tk = Token::Assign as i64;
                        }
                    }
                    '+' => {
                        if next_char == '+' {
                            self.src_pos += 1;
                            self.tk = Token::Inc as i64;
                        } else {
                            self.tk = Token::AddOp as i64;
                        }
                    }
                    '-' => {
                        if next_char == '-' {
                            self.src_pos += 1;
                            self.tk = Token::Dec as i64;
                        } else {
                            self.tk = Token::SubOp as i64;
                        }
                    }
                    '!' => {
                        if next_char == '=' {
                            self.src_pos += 1;
                            self.tk = Token::NeOp as i64;
                        } else {
                            self.tk = 0;
                        }
                    }
                    '<' => {
                        if next_char == '=' {
                            self.src_pos += 1;
                            self.tk = Token::LeOp as i64;
                        } else if next_char == '<' {
                            self.src_pos += 1;
                            self.tk = Token::ShlOp as i64;
                        } else {
                            self.tk = Token::LtOp as i64;
                        }
                    }
                    '>' => {
                        if next_char == '=' {
                            self.src_pos += 1;
                            self.tk = Token::GeOp as i64;
                        } else if next_char == '>' {
                            self.src_pos += 1;
                            self.tk = Token::ShrOp as i64;
                        } else {
                            self.tk = Token::GtOp as i64;
                        }
                    }
                    '|' => {
                        if next_char == '|' {
                            self.src_pos += 1;
                            self.tk = Token::Lor as i64;
                        } else {
                            self.tk = Token::OrOp as i64;
                        }
                    }
                    '&' => {
                        if next_char == '&' {
                            self.src_pos += 1;
                            self.tk = Token::Lan as i64;
                        } else {
                            self.tk = Token::AndOp as i64;
                        }
                    }
                    '^' => self.tk = Token::XorOp as i64,
                    '%' => self.tk = Token::ModOp as i64,
                    '*' => self.tk = Token::MulOp as i64,
                    '[' => self.tk = Token::Brak as i64,
                    '?' => self.tk = Token::Cond as i64,
                    _ => {
                        if "!~;{}()],:".contains(c) {
                            self.tk = c as i64;
                        } else {
                            continue;
                        }
                    }
                }
                return Ok(());
            }
        }
    }

    fn expr(&mut self, lev: i64) -> Result<(), C4Error> {
        let mut t: i64;

        if self.tk == 0 {
            return Err(C4Error::Compile(format!(
                "{}: unexpected eof in expression",
                self.line
            )));
        } else if self.tk == Token::Num as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.ival);
            self.next()?;
            self.ty = Ty::Int as i64;
        } else if self.tk == '"' as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.ival);
            self.next()?;
            while self.tk == '"' as i64 {
                self.next()?;
            }
            self.ty = Ty::Ptr as i64;
        } else if self.tk == Token::Sizeof as i64 {
            self.next()?;
            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected in sizeof",
                    self.line
                )));
            }
            self.ty = Ty::Int as i64;
            if self.tk == Token::Int as i64 {
                self.next()?;
            } else if self.tk == Token::Char as i64 {
                self.next()?;
                self.ty = Ty::Char as i64;
            }
            while self.tk == Token::MulOp as i64 {
                self.next()?;
                self.ty += Ty::Ptr as i64;
            }
            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected in sizeof",
                    self.line
                )));
            }
            self.emit_op(Op::Imm);
            self.emit_val(if self.ty == Ty::Char as i64 { 1 } else { 8 });
            self.ty = Ty::Int as i64;
        } else if self.tk == Token::Id as i64 {
            let id_idx = self.curr_id_idx;
            self.next()?;
            if self.tk == '(' as i64 {
                self.next()?;
                let mut nargs = 0;
                while self.tk != ')' as i64 {
                    self.expr(Token::Assign as i64)?;
                    self.emit_op(Op::Psh);
                    nargs += 1;
                    if self.tk == ',' as i64 {
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
                        self.line
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
                        self.line, self.symbols[id_idx].name
                    )));
                }
                self.ty = self.symbols[id_idx].type_;
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Lc
                } else {
                    Op::Li
                });
            }
        } else if self.tk == '(' as i64 {
            self.next()?;
            if self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                t = if self.tk == Token::Int as i64 {
                    Ty::Int as i64
                } else {
                    Ty::Char as i64
                };
                self.next()?;
                while self.tk == Token::MulOp as i64 {
                    self.next()?;
                    t += Ty::Ptr as i64;
                }
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!("{}: bad cast", self.line)));
                }
                self.expr(Token::Inc as i64)?;
                self.ty = t;
            } else {
                self.expr(Token::Assign as i64)?;
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }
            }
        } else if self.tk == Token::MulOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if self.ty > Ty::Int as i64 {
                self.ty -= Ty::Ptr as i64;
            } else {
                return Err(C4Error::Compile(format!("{}: bad dereference", self.line)));
            }
            self.emit_op(if self.ty == Ty::Char as i64 {
                Op::Lc
            } else {
                Op::Li
            });
        } else if self.tk == Token::AndOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = self.text.pop().unwrap();
            if last != Op::Lc as i64 && last != Op::Li as i64 {
                return Err(C4Error::Compile(format!("{}: bad address-of", self.line)));
            }
            self.ty += Ty::Ptr as i64;
        } else if self.tk == '!' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(0);
            self.emit_op(Op::Eq);
            self.ty = Ty::Int as i64;
        } else if self.tk == '~' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(-1);
            self.emit_op(Op::Xor);
            self.ty = Ty::Int as i64;
        } else if self.tk == Token::AddOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.ty = Ty::Int as i64;
        } else if self.tk == Token::SubOp as i64 {
            self.next()?;
            self.emit_op(Op::Imm);
            if self.tk == Token::Num as i64 {
                self.emit_val(-self.ival);
                self.next()?;
            } else {
                self.emit_val(-1);
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mul);
            }
            self.ty = Ty::Int as i64;
        } else if self.tk == Token::Inc as i64 || self.tk == Token::Dec as i64 {
            t = self.tk;
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
                    self.line
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
                self.line, self.tk
            )));
        }

        while self.tk >= lev {
            t = self.ty;
            if self.tk == Token::Assign as i64 {
                self.next()?;
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 || last == Op::Li as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in assignment",
                        self.line
                    )));
                }
                self.expr(Token::Assign as i64)?;
                self.ty = t;
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Sc
                } else {
                    Op::Si
                });
            } else if self.tk == Token::Cond as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                if self.tk == ':' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: conditional missing colon",
                        self.line
                    )));
                }
                let b_end_val = (self.text.len() + 2) as i64;
                self.text[b_else] = b_end_val;
                self.emit_op(Op::Jmp);
                let b_end = self.text.len();
                self.emit_val(0);
                self.expr(Token::Cond as i64)?;
                self.text[b_end] = self.text.len() as i64;
            } else if self.tk == Token::Lor as i64 {
                self.next()?;
                self.emit_op(Op::Bnz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::Lan as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::Lan as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::OrOp as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::OrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::XorOp as i64)?;
                self.emit_op(Op::Or);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::XorOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AndOp as i64)?;
                self.emit_op(Op::Xor);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::AndOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::EqOp as i64)?;
                self.emit_op(Op::And);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::EqOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                self.emit_op(Op::Eq);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::NeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                self.emit_op(Op::Ne);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::LtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Lt);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::GtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Gt);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::LeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Le);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::GeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Ge);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::ShlOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shl);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::ShrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shr);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::AddOp as i64 {
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
            } else if self.tk == Token::SubOp as i64 {
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
            } else if self.tk == Token::MulOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mul);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::DivOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Div);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::ModOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mod);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::Inc as i64 || self.tk == Token::Dec as i64 {
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
                        self.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                self.emit_op(if self.tk == Token::Inc as i64 {
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
                self.emit_op(if self.tk == Token::Inc as i64 {
                    Op::Sub
                } else {
                    Op::Add
                });
                self.next()?;
            } else if self.tk == Token::Brak as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Assign as i64)?;
                if self.tk == ']' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close bracket expected",
                        self.line
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
                        self.line
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
                    self.line, self.tk
                )));
            }
        }
        Ok(())
    }

    fn stmt(&mut self) -> Result<(), C4Error> {
        if self.tk == Token::Id as i64 {
            let mut p = self.src_pos;
            while p < self.src.len() && self.src[p].is_ascii_whitespace() {
                p += 1;
            }
            if p < self.src.len() && self.src[p] == b':' {
                let name = self.symbols[self.curr_id_idx].name.clone();
                self.labels.insert(name, self.text.len());
                self.next()?; // consume Id
                self.next()?; // consume ':'
                self.stmt()?;
                return Ok(());
            }
        }

        if self.tk == Token::If as i64 {
            self.next()?;
            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected",
                    self.line
                )));
            }
            self.expr(Token::Assign as i64)?;
            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected",
                    self.line
                )));
            }
            self.emit_op(Op::Bz);
            let b = self.text.len();
            self.emit_val(0);
            self.stmt()?;
            if self.tk == Token::Else as i64 {
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
        } else if self.tk == Token::While as i64 {
            self.next()?;
            let cond_pc = self.text.len();
            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected",
                    self.line
                )));
            }
            self.expr(Token::Assign as i64)?;
            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected",
                    self.line
                )));
            }
            self.emit_op(Op::Bz);
            let bz_pc = self.text.len();
            self.emit_val(0);

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            // Patch continues
            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            self.emit_op(Op::Jmp);
            self.emit_val(cond_pc as i64);

            // Patch condition end / breaks
            self.text[bz_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.tk == Token::Do as i64 {
            self.next()?;
            let start_pc = self.text.len();

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            if self.tk == Token::While as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: while expected after do",
                    self.line
                )));
            }

            let cond_pc = self.text.len();
            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected",
                    self.line
                )));
            }
            self.expr(Token::Assign as i64)?;
            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected",
                    self.line
                )));
            }

            self.emit_op(Op::Bnz);
            self.emit_val(start_pc as i64);

            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after do-while",
                    self.line
                )));
            }

            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.tk == Token::For as i64 {
            self.next()?;
            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected",
                    self.line
                )));
            }

            // Initialization
            if self.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after for-init",
                    self.line
                )));
            }

            // Condition
            let cond_pc = self.text.len();
            if self.tk != ';' as i64 {
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

            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after for-cond",
                    self.line
                )));
            }

            // Step
            let step_pc = self.text.len();
            if self.tk != ')' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            self.emit_op(Op::Jmp);
            self.emit_val(cond_pc as i64);

            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected",
                    self.line
                )));
            }

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

            // End of loop / Patch Breaks
            self.text[end_jmp_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.tk == Token::Switch as i64 {
            self.next()?;
            if self.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected",
                    self.line
                )));
            }

            self.loc_offs += 1;
            let switch_val_offset = -self.loc_offs;
            self.emit_op(Op::Lea);
            self.emit_val(switch_val_offset);
            self.emit_op(Op::Psh);

            self.expr(Token::Assign as i64)?;
            if self.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: close paren expected",
                    self.line
                )));
            }

            self.emit_op(Op::Si);

            // 1. Jump immediately to the dispatcher (the case checks)
            self.emit_op(Op::Jmp);
            let disp_pc_patch = self.text.len();
            self.emit_val(0);

            self.switch_cases.push(Vec::new());
            self.switch_defaults.push(None);
            self.loop_breaks.push(Vec::new());

            // 2. Parse the body (the case labels and code)
            self.stmt()?;

            // 3. After the body, if we haven't broken out, jump to the end of the switch
            self.emit_op(Op::Jmp);
            let end_switch_patch = self.text.len();
            self.emit_val(0);

            // 4. Define the dispatcher block
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

            // 5. If no cases match, jump to default or the end
            if let Some(dpc) = default_pc {
                self.emit_op(Op::Jmp);
                self.emit_val(dpc as i64);
            } else {
                // If no default, jump to the end
                self.emit_op(Op::Jmp);
                self.emit_val(0); // Will be patched below
                self.loop_breaks
                    .last_mut()
                    .unwrap()
                    .push(self.text.len() - 1);
            }

            // 6. Patch the jump that skips the dispatcher and the breaks
            self.text[end_switch_patch] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.tk == Token::Case as i64 {
            self.next()?;
            if self.tk != Token::Num as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: invalid case value",
                    self.line
                )));
            }
            let val = self.ival;
            self.next()?;
            if self.tk != ':' as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: expected colon after case",
                    self.line
                )));
            }
            self.next()?;
            if let Some(cases) = self.switch_cases.last_mut() {
                cases.push((val, self.text.len()));
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: case outside switch",
                    self.line
                )));
            }
            self.stmt()?;
        } else if self.tk == Token::Default as i64 {
            self.next()?;
            if self.tk != ':' as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: expected colon after default",
                    self.line
                )));
            }
            self.next()?;
            if let Some(def) = self.switch_defaults.last_mut() {
                *def = Some(self.text.len());
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: default outside switch",
                    self.line
                )));
            }
            self.stmt()?;
        } else if self.tk == Token::Goto as i64 {
            self.next()?;
            if self.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: expected identifier after goto",
                    self.line
                )));
            }
            let target_name = self.symbols[self.curr_id_idx].name.clone();
            self.next()?;

            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);

            if let Some(&target) = self.labels.get(&target_name) {
                self.text[pc] = target as i64;
            } else {
                self.unresolved_gotos.push((target_name, pc));
            }

            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after goto",
                    self.line
                )));
            }
        } else if self.tk == Token::Break as i64 {
            self.next()?;
            if self.loop_breaks.is_empty() {
                return Err(C4Error::Compile(format!(
                    "{}: break outside of loop or switch",
                    self.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_breaks.last_mut().unwrap().push(pc);

            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after break",
                    self.line
                )));
            }
        } else if self.tk == Token::Continue as i64 {
            self.next()?;
            if self.loop_continues.is_empty() {
                return Err(C4Error::Compile(format!(
                    "{}: continue outside of loop",
                    self.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_continues.last_mut().unwrap().push(pc);

            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected after continue",
                    self.line
                )));
            }
        } else if self.tk == Token::Return as i64 {
            self.next()?;
            if self.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
            }
            self.emit_op(Op::Lev);
            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected",
                    self.line
                )));
            }
        } else if self.tk == '{' as i64 {
            self.next()?;
            let mut block_symbols = Vec::new();

            // Parse block-scoped local variables
            while self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                let lbt = if self.tk == Token::Int as i64 {
                    Ty::Int as i64
                } else {
                    Ty::Char as i64
                };
                self.next()?;
                while self.tk != ';' as i64 {
                    self.ty = lbt;
                    while self.tk == Token::MulOp as i64 {
                        self.next()?;
                        self.ty += Ty::Ptr as i64;
                    }
                    if self.tk != Token::Id as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad local declaration",
                            self.line
                        )));
                    }
                    let loc_idx = self.curr_id_idx;

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
                    if self.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                self.next()?;
            }

            while self.tk != '}' as i64 {
                self.stmt()?;
            }
            self.next()?;

            // Restore shadowed variables
            for (idx, class, ty, val) in block_symbols.into_iter().rev() {
                self.symbols[idx].class = class;
                self.symbols[idx].type_ = ty;
                self.symbols[idx].val = val;
            }
        } else if self.tk == ';' as i64 {
            self.next()?;
        } else {
            self.expr(Token::Assign as i64)?;
            if self.tk == ';' as i64 {
                self.next()?;
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: semicolon expected",
                    self.line
                )));
            }
        }
        Ok(())
    }

    fn parse_enum_decl(&mut self) -> Result<(), C4Error> {
        self.next()?;
        if self.tk != '{' as i64 {
            self.next()?;
        }
        if self.tk == '{' as i64 {
            self.next()?;
            let mut i = 0;
            while self.tk != '}' as i64 {
                if self.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad enum identifier",
                        self.line
                    )));
                }
                let idx = self.curr_id_idx;
                self.next()?;
                if self.tk == Token::Assign as i64 {
                    self.next()?;
                    if self.tk != Token::Num as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad enum initializer",
                            self.line
                        )));
                    }
                    i = self.ival;
                    self.next()?;
                }
                self.symbols[idx].class = Token::Num as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.symbols[idx].val = i;
                i += 1;
                if self.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }

    fn parse_function_params(&mut self) -> Result<Vec<usize>, C4Error> {
        let mut args = Vec::new();
        while self.tk != ')' as i64 {
            self.ty = Ty::Int as i64;
            if self.tk == Token::Int as i64 {
                self.next()?;
            } else if self.tk == Token::Char as i64 {
                self.next()?;
                self.ty = Ty::Char as i64;
            }
            while self.tk == Token::MulOp as i64 {
                self.next()?;
                self.ty += Ty::Ptr as i64;
            }
            if self.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: bad parameter declaration",
                    self.line
                )));
            }
            let param_idx = self.curr_id_idx;
            if self.symbols[param_idx].class == Token::Loc as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: duplicate parameter definition",
                    self.line
                )));
            }

            self.symbols[param_idx].h_class = self.symbols[param_idx].class;
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].h_type = self.symbols[param_idx].type_;
            self.symbols[param_idx].type_ = self.ty;
            self.symbols[param_idx].h_val = self.symbols[param_idx].val;

            args.push(param_idx);

            self.next()?;
            if self.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?;
        Ok(args)
    }

    pub fn compile(&mut self) -> Result<(), C4Error> {
        self.next()?;
        while self.tk != 0 {
            let mut bt = Ty::Int as i64;
            if self.tk == Token::Int as i64 {
                self.next()?;
                bt = Ty::Int as i64;
            } else if self.tk == Token::Char as i64 {
                self.next()?;
                bt = Ty::Char as i64;
            } else if self.tk == Token::Enum as i64 {
                self.parse_enum_decl()?;
            }

            while self.tk != ';' as i64 && self.tk != '}' as i64 {
                self.ty = bt;
                while self.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.ty += Ty::Ptr as i64;
                }
                if self.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad global declaration",
                        self.line
                    )));
                }
                let id_idx = self.curr_id_idx;
                if self.symbols[id_idx].class != 0 {
                    return Err(C4Error::Compile(format!(
                        "{}: duplicate global definition",
                        self.line
                    )));
                }
                self.next()?;
                self.symbols[id_idx].type_ = self.ty;

                if self.tk == '(' as i64 {
                    self.symbols[id_idx].class = Token::Fun as i64;
                    self.symbols[id_idx].val = self.text.len() as i64;
                    self.next()?;

                    let args = self.parse_function_params()?;

                    if self.tk != '{' as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad function definition",
                            self.line
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

                    while self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                        let lbt = if self.tk == Token::Int as i64 {
                            Ty::Int as i64
                        } else {
                            Ty::Char as i64
                        };
                        self.next()?;
                        while self.tk != ';' as i64 {
                            self.ty = lbt;
                            while self.tk == Token::MulOp as i64 {
                                self.next()?;
                                self.ty += Ty::Ptr as i64;
                            }
                            if self.tk != Token::Id as i64 {
                                return Err(C4Error::Compile(format!(
                                    "{}: bad local declaration",
                                    self.line
                                )));
                            }
                            let loc_idx = self.curr_id_idx;
                            if self.symbols[loc_idx].class == Token::Loc as i64 {
                                return Err(C4Error::Compile(format!(
                                    "{}: duplicate local definition",
                                    self.line
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
                            if self.tk == ',' as i64 {
                                self.next()?;
                            }
                        }
                        self.next()?;
                    }

                    let ent_pc = self.text.len();
                    self.emit_op(Op::Ent);
                    self.emit_val(0); // Placeholder patched at the end of function body

                    while self.tk != '}' as i64 {
                        self.stmt()?;
                    }
                    self.emit_op(Op::Lev);

                    // Patch the 'Ent' placeholder instruction
                    self.text[ent_pc + 1] = self.loc_offs;

                    // Resolve pending gotos against recorded function labels
                    for (name, pc) in &self.unresolved_gotos {
                        if let Some(&target) = self.labels.get(name) {
                            self.text[*pc] = target as i64;
                        } else {
                            return Err(C4Error::Compile(format!(
                                "unresolved label: {}",
                                name
                            )));
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
                if self.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }
}
