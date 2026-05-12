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
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{is_struct_ty, struct_ptr_depth};

impl Compiler {
    /// `for (init; cond; step) body`. The body is emitted between the
    /// condition (which falls through to it) and the step (which the
    /// body's tail jumps back to). `continue` patches into the step
    /// position; `break` patches past the loop end.
    /// Parse a C99 6.5.17 `expression` -- a possibly comma-chained
    /// chain of assignment-expressions evaluated for side effects,
    /// yielding the value of the last. `expr(Assign)` stops at `,`
    /// because c5 also uses `,` as an argument / declarator
    /// separator; every statement-level expression context resumes
    /// the chain through this helper.
    pub(super) fn parse_full_expr(&mut self) -> Result<(), C5Error> {
        self.expr(Token::Assign as i64)?;
        while self.lex.tk == ',' {
            self.next()?;
            self.expr(Token::Assign as i64)?;
        }
        Ok(())
    }

    pub(super) fn parse_for_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        // C99 6.8.5.3 for-init is either an expression or a
        // declaration. The declared identifier's scope is the
        // entire for statement, so a fresh `block_symbols`
        // vector lets us shadow and restore in the same shape
        // as `parse_block_stmt`. `parse_block_local_decl`
        // consumes its own trailing `;`; the expression branch
        // does it explicitly.
        let mut for_init_symbols: Vec<(usize, i64, i64, i64)> = Vec::new();
        if self.lex.tk == ';' {
            self.next()?;
        } else if self.lex_is_type_start() {
            self.parse_block_local_decl(&mut for_init_symbols)?;
        } else {
            self.parse_full_expr()?;
            self.consume(b';', "semicolon expected after for-init")?;
        }

        // Condition (optional -- empty means `1`). The C99 grammar
        // makes the condition a full `expression`, so a comma chain
        // is legal here too -- the value of the last subexpression
        // becomes the loop predicate.
        let cond_pc = self.text.len();
        if self.lex.tk != ';' {
            self.parse_full_expr()?;
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
        if self.lex.tk != ')' {
            self.parse_full_expr()?;
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

        // Restore symbols shadowed by the for-init declaration so
        // the binding's scope ends with the for statement
        // (C99 6.8.5.3 / 6.8p3). Restore in reverse order to
        // unwind multiple shadows in declaration order.
        for (idx, class, ty, val) in for_init_symbols.into_iter().rev() {
            self.symbols[idx].class = class;
            self.symbols[idx].type_ = ty;
            self.symbols[idx].val = val;
        }
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

        self.parse_full_expr()?;
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
        // The pair was pushed by the matching `switch_cases.push` /
        // `switch_defaults.push(None)` just before `enter_switch`
        // above, so a missing entry would be an internal parser
        // bug; `unwrap_or_default` + `flatten` keep the codegen
        // forward-progressing in that case rather than panicking.
        let cases = self.switch_cases.pop().unwrap_or_default();
        let default_pc = self.switch_defaults.pop().flatten();

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
    /// local typedefs (e.g. `typedef void(*LOGFUNC_t)(...)` inside
    /// a switch case) bind without bouncing through the
    /// declaration parser.
    fn parse_block_typedef(
        &mut self,
        block_symbols: &mut Vec<(usize, i64, i64, i64)>,
    ) -> Result<(), C5Error> {
        self.next()?; // consume `typedef`
        let lbt = self.parse_decl_base_type()?;
        while self.lex.tk != ';' {
            let (id_idx, ty, _) = self.parse_declarator(lbt)?;
            if id_idx == usize::MAX {
                return Err(self.compile_err("typedef requires a name"));
            }
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            // C99 function-type typedef: `typedef RET NAME(args);`
            // declared at block scope. Same handling as run_compile's
            // file-scope branch -- parse the `(args)` and bind the
            // typedef as a function-pointer alias. parse_function_params
            // binds each named parameter as a Loc; with no body to put
            // them into scope for, we restore the shadowed binding
            // immediately.
            let (typedef_ty, typedef_fpi, typedef_params) = if self.lex.tk == '(' {
                self.next()?; // consume `(`
                let pp = self.parse_function_params()?;
                for &p in &pp.indices {
                    Compiler::restore_shadowed_symbol(&mut self.symbols[p]);
                }
                let fty = ty + Ty::Ptr as i64;
                (fty, 1i64, Some(pp))
            } else {
                (ty, fn_ptr_indirection, None)
            };
            block_symbols.push((
                id_idx,
                self.symbols[id_idx].class,
                self.symbols[id_idx].type_,
                self.symbols[id_idx].val,
            ));
            self.symbols[id_idx].class = Token::Typedef as i64;
            self.symbols[id_idx].type_ = typedef_ty;
            self.symbols[id_idx].val = 0;
            if typedef_fpi > 0 {
                self.symbols[id_idx].fn_ptr_indirection = typedef_fpi;
            }
            if let Some(pp) = typedef_params {
                self.symbols[id_idx].params = pp.types;
                self.symbols[id_idx].is_variadic = pp.is_variadic;
            }
            if self.lex.tk == ',' {
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
        while self.lex.tk == Token::Extern || self.lex.tk == Token::Static {
            if self.lex.tk == Token::Static {
                is_static = true;
            }
            self.next()?;
        }
        let lbt = self.parse_decl_base_type()?;
        // Function-prototype declaration at block scope:
        // `extern int foo(int);` -- the name is an identifier, the
        // next token is `(`, and what follows is a parameter list
        // ending with `);`. c5 has no separate translation units,
        // so the whole declaration is a no-op; the linker /
        // codegen-side import resolution finds the symbol via its
        // own table. Skip to the matching `;` and return.
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b'(') {
            // Counted-paren skip from the name. Walk past the
            // identifier, then the `(`, then balance braces until
            // the matching `)`. Function-pointer declarators
            // (`int (*fn)(int)`) don't reach this branch -- they
            // start with `(` rather than an identifier.
            self.next()?; // consume name
            self.next()?; // consume `(`
            let mut depth: i64 = 1;
            while depth > 0 && self.lex.tk != 0 {
                if self.lex.tk == '(' {
                    depth += 1;
                } else if self.lex.tk == ')' {
                    depth -= 1;
                    if depth == 0 {
                        self.next()?;
                        break;
                    }
                }
                self.next()?;
            }
            // Trailing `;` plus an optional comma-separated list
            // of further function prototypes are skipped: the
            // standard form is one declaration per `;`, but the
            // C grammar would in principle allow `int foo(int),
            // bar(int);`. Skip until the terminator.
            while self.lex.tk != ';' && self.lex.tk != 0 {
                self.next()?;
            }
            self.next()?;
            return Ok(());
        }
        while self.lex.tk != ';' {
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

            if self.lex.tk == ',' {
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

        while self.lex.tk != '}' {
            if self.lex.tk == Token::Typedef {
                self.parse_block_typedef(&mut block_symbols)?;
            } else if self.lex.tk == Token::StaticAssert {
                // C11 6.7.10 allows `static_assert` anywhere a
                // declaration may appear -- including block scope.
                self.parse_static_assert()?;
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
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b':') {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.labels.push((name, self.text.len()));
            self.next()?; // consume Id
            self.next()?; // consume ':'
            self.stmt()?;
            return Ok(());
        }

        if self.lex.tk == Token::If {
            self.next()?;
            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
            self.consume(b')', "close paren expected")?;
            self.emit_op(Op::Bz);
            let b = self.text.len();
            self.emit_val(0);
            self.stmt()?;
            if self.lex.tk == Token::Else {
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
        } else if self.lex.tk == Token::While {
            self.next()?;
            let cond_pc = self.text.len();
            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
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
        } else if self.lex.tk == Token::Do {
            self.next()?;
            let start_pc = self.text.len();

            self.enter_loop();
            self.stmt()?;

            if self.lex.tk == Token::While {
                self.next()?;
            } else {
                return Err(self.compile_err("while expected after do"));
            }

            let cond_pc = self.text.len();
            self.patch_loop_continues(cond_pc);

            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
            self.consume(b')', "close paren expected")?;

            self.emit_op(Op::Bnz);
            self.emit_val(start_pc as i64);

            self.consume(b';', "semicolon expected after do-while")?;

            let end_pc = self.text.len();
            self.patch_loop_breaks(end_pc);
        } else if self.lex.tk == Token::For {
            self.parse_for_stmt()?;
        } else if self.lex.tk == Token::Switch {
            self.parse_switch_stmt()?;
        } else if self.lex.tk == Token::Case {
            self.next()?;
            // Case label is a constant expression: integer literal,
            // negated literal, parenthesised literal, enum / `#define`d
            // constant. The C99 grammar allows the full conditional-
            // expression chain (`a ? b : c`), so we go in at the top.
            let val = self.parse_constant_int()?;
            self.consume(b':', "expected colon after case")?;
            let Some(cases) = self.switch_cases.last_mut() else {
                return Err(self.compile_err("case outside switch"));
            };
            cases.push((val, self.text.len()));
            self.stmt()?;
        } else if self.lex.tk == Token::Default {
            self.next()?;
            self.consume(b':', "expected colon after default")?;
            let Some(def) = self.switch_defaults.last_mut() else {
                return Err(self.compile_err("default outside switch"));
            };
            *def = Some(self.text.len());
            self.stmt()?;
        } else if self.lex.tk == Token::Goto {
            self.next()?;
            if self.lex.tk != Token::Id {
                return Err(self.compile_err("expected identifier after goto"));
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
        } else if self.lex.tk == Token::Break {
            self.next()?;
            if self.loop_breaks.is_empty() {
                return Err(self.compile_err("break outside of loop or switch"));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.record_break_jmp(pc);
            self.consume(b';', "semicolon expected after break")?;
        } else if self.lex.tk == Token::Continue {
            self.next()?;
            if self.loop_continues.is_empty() {
                return Err(self.compile_err("continue outside of loop"));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.record_continue_jmp(pc);
            self.consume(b';', "semicolon expected after continue")?;
        } else if self.lex.tk == Token::Return {
            self.next()?;
            let ret_ty = self.current_func_return_ty;
            let returns_struct = is_struct_ty(ret_ty) && struct_ptr_depth(ret_ty) == 0;
            let returns_void = self.current_func_returns_void;
            if self.lex.tk != ';' {
                if returns_void {
                    // C99 6.8.6.4p1: `return <expr>;` in a function
                    // returning `void` is a constraint violation.
                    // Reject here rather than silently dropping
                    // the value -- gcc and clang both diagnose this
                    // at the strict level.
                    return Err(self.compile_err(
                        "`return` with a value in a function returning `void` \
                         (C99 6.8.6.4p1)",
                    ));
                }
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
                        return Err(self.compile_err(
                            "returning a non-struct value from a \
                             struct-returning function",
                        ));
                    }
                    let size = self.size_of_type(ret_ty);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                } else {
                    self.parse_full_expr()?;
                }
            } else if returns_void {
                // Bare `return;` in a void function. Zero the
                // accumulator so the matching `Op::Lev` leaves a
                // predictable value, matching the synthetic
                // function-end Lev in run_compile.
                self.emit_op(Op::Imm);
                self.emit_val(0);
            }
            self.emit_op(Op::Lev);
            self.consume(b';', "semicolon expected")?;
        } else if self.lex.tk == '{' {
            self.parse_block_stmt()?;
        } else if self.lex.tk == ';' {
            self.next()?;
        } else {
            self.parse_full_expr()?;
            self.consume(b';', "semicolon expected")?;
        }
        Ok(())
    }

    /// Consume a single-byte token, returning a labelled compile error otherwise.
    pub(super) fn consume(&mut self, expected: u8, msg: &str) -> Result<(), C5Error> {
        if self.lex.tk == expected {
            self.next()?;
            Ok(())
        } else {
            let id_suffix = if self.lex.tk == Token::Id {
                format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
            } else {
                alloc::string::String::new()
            };
            Err(self.compile_err(format!(
                "{msg} (got {}{id_suffix})",
                super::super::token::describe(self.lex.tk),
            )))
        }
    }
}
