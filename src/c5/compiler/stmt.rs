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
use super::super::token::{Tok, Token, Ty};
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
            // C99 6.5.17: comma operator evaluates the lhs for
            // side effects, discards the value, then evaluates
            // the rhs. Build `Expr::Comma { lhs, rhs }` so the
            // walker visits the lhs before producing the rhs's
            // value as the chain's result.
            let lhs_ast = self.ast_acc;
            self.expr(Token::Assign as i64)?;
            let rhs_ast = self.ast_acc;
            if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                let pos = self.ast_src_pos();
                let ty = self.ty;
                let id = self
                    .ast
                    .push_expr(super::super::ast::Expr::Comma { lhs, rhs, ty }, pos);
                self.ast_acc = Some(id);
            }
        }
        Ok(())
    }

    pub(super) fn parse_for_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        // C99 6.8.5.3: a for-init `__attribute__((cleanup))` variable's
        // scope is the whole for statement. Push a cleanup scope so the
        // init declaration registers into it; it is run where control
        // leaves the loop (below) rather than at the enclosing block.
        self.cleanup_scopes.push(alloc::vec::Vec::new());

        // C99 6.8.5.3 for-init is either an expression or a
        // declaration. The declared identifier's scope is the
        // entire for statement, so a fresh `block_symbols`
        // vector lets us shadow and restore in the same shape
        // as `parse_block_stmt`. `parse_block_local_decl`
        // consumes its own trailing `;`; the expression branch
        // does it explicitly.
        let mut for_init_symbols: Vec<(usize, i64, i64, i64)> = Vec::new();
        let mut init_ast: Option<super::super::ast::BlockItem> = None;
        if self.lex.tk == ';' {
            self.next()?;
        } else if self.lex_is_type_start() {
            // C99 6.8.5.3p1 admits `declaration` as the for-init.
            // `parse_block_local_decl` pushes one or more
            // `Stmt::Decl(d)` wrappers onto the AST stmt arena;
            // capture them into a single BlockItem so the walker
            // gets the same shape it would for an expression
            // init. Without this the walker sees `init: None`
            // and the declared counter never reaches the
            // SSA prologue.
            let init_before = self.ast_stmts_snapshot();
            self.parse_block_local_decl(&mut for_init_symbols)?;
            let init_after = self.ast.stmts.len();
            // C99 6.7p1: a declaration's init-declarator-list may name
            // several declarators (`for (int i = 0, l = n; ...)`).
            // `parse_block_local_decl` pushes one top-level `Stmt::Decl`
            // per declarator, so every pushed id must reach the walker.
            // `ast_wrap_stmts_since` keeps only the last arena entry
            // (correct for a single nested statement, not for sibling
            // decls), which drops every initializer but the last.
            // A statement-expression initializer interleaves its own
            // sub-statements here (e.g. the `while` of a `qatomic_read`
            // build-assert); skip them as `parse_block_stmt` does, else
            // the wrapped for-init Compound lists a nested `while`'s body
            // as a sibling and the walker runs it unconditionally.
            if init_after > init_before {
                let ids: alloc::vec::Vec<super::super::ast::StmtId> = (init_before..init_after)
                    .filter(|&i| !self.in_stmt_expr_range(i))
                    .map(|i| i as super::super::ast::StmtId)
                    .collect();
                self.stmt_expr_arena_ranges
                    .retain(|&(s, _)| s < init_before);
                if !ids.is_empty() {
                    let id = self.ast_wrap_block_items(&ids);
                    init_ast = Some(super::super::ast::BlockItem::Stmt(id));
                }
            }
        } else {
            let init_before = self.ast_stmts_snapshot();
            self.parse_full_expr()?;
            let init_expr = self.ast_acc;
            // Treat the init expression as an Expr statement.
            if let Some(e) = init_expr {
                let pos = self.ast_src_pos();
                let stmt_id = self.ast.push_stmt(super::super::ast::Stmt::Expr(e), pos);
                init_ast = Some(super::super::ast::BlockItem::Stmt(stmt_id));
            } else {
                // Drain any stmts the init expression pushed
                // (e.g. a sub-call inside the comma chain) into
                // a Compound so the for-init slot has a single
                // BlockItem.
                let added = self.ast.stmts.len().saturating_sub(init_before);
                if added > 0 {
                    let id = self.ast_wrap_stmts_since(init_before);
                    init_ast = Some(super::super::ast::BlockItem::Stmt(id));
                }
            }
            self.consume(b';', "semicolon expected after for-init")?;
        }

        // Condition (optional -- empty means `1`). The C99 grammar
        // makes the condition a full `expression`, so a comma chain
        // is legal here too -- the value of the last subexpression
        // becomes the loop predicate.
        let cond_ast: Option<super::super::ast::ExprId> = if self.lex.tk != ';' {
            self.parse_full_expr()?;
            self.ast_acc
        } else {
            self.emit_imm(1);
            None
        };
        self.flush_pending_stores();

        self.consume(b';', "semicolon expected after for-cond")?;

        // Step (optional). Comma operator: `i++, k--`.
        let post_ast: Option<super::super::ast::ExprId> = if self.lex.tk != ')' {
            self.parse_full_expr()?;
            self.ast_acc
        } else {
            None
        };
        self.flush_pending_stores();

        self.consume(b')', "close paren expected")?;

        self.enter_loop();
        let body_before = self.ast_stmts_snapshot();
        self.stmt()?;
        let body_s = self.ast_wrap_stmts_since(body_before);

        self.close_loop_continues();
        self.flush_pending_stores();

        self.close_loop_breaks();

        // C99 6.8.5.3: a `for` with no controlling expression has
        // `1` as its condition (an infinite loop terminated by
        // `break` / `return` / `goto`). Emit `Stmt::For` even when
        // every header slot is empty so the walker sees the loop
        // wrapper and pushes the matching break / continue
        // context. Without it, a Break inside the body would
        // bubble up to the enclosing function as a sibling stmt
        // with no loop_ctx.
        let for_stmt_start = self.ast.stmts.len();
        self.ast_emit_for(init_ast, cond_ast, post_ast, body_s);

        // Run the for-init scope's cleanups after the loop: control
        // reaches here on both normal exit and `break` (both land in the
        // loop's after-block). `return` cleans the scope inline through
        // the scope stack; `continue` keeps the object (it persists
        // across iterations, C99 6.8.5.3). The calls are read while the
        // init binding is still live -- before the restore below.
        if self.cleanup_scopes.last().is_some_and(|s| !s.is_empty()) {
            let pairs: alloc::vec::Vec<(usize, usize)> = self
                .cleanup_scopes
                .last()
                .unwrap()
                .iter()
                .rev()
                .cloned()
                .collect();
            for (var_sym, fn_sym) in pairs {
                self.push_cleanup_call(var_sym, fn_sym);
            }
            self.coalesce_exit_since(for_stmt_start);
        }
        self.cleanup_scopes.pop();

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

    /// `switch (expr) { ... }`. The walker reads the discriminant
    /// and the case set off `Stmt::Switch`; this parser only has
    /// to capture the scrutinee expression, prime the per-switch
    /// scope stacks so `case` / `default` labels know they're
    /// inside one, recurse into the body, then emit the AST node.
    /// Breaks inside the body decrement the break depth at switch
    /// exit through [`Self::close_loop_breaks`].
    pub(super) fn parse_switch_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;
        self.parse_full_expr()?;
        let disc_ast = self.ast_acc;
        self.consume(b')', "close paren expected")?;

        // Conservative drop of any pending dead-store entries at
        // the switch entry boundary, matching the flush a
        // control-flow op would have produced through emit_cf_op.
        self.flush_pending_stores();
        self.switch_cases.push(Vec::new());
        self.switch_defaults.push(false);
        self.enter_switch();

        let body_before = self.ast_stmts_snapshot();
        self.stmt()?;
        let body_s = self.ast_wrap_stmts_since(body_before);

        // Same conservative drop at the body-exit boundary.
        self.flush_pending_stores();
        self.switch_cases.pop();
        self.switch_defaults.pop();
        self.close_loop_breaks();
        if let Some(disc) = disc_ast {
            self.ast_emit_switch(disc, body_s);
        }
        Ok(())
    }

    /// Parse a `typedef` declaration at function/block scope (C99
    /// 6.7.7, 6.2.1), routed here so block-local typedefs (e.g.
    /// `typedef void(*LOGFUNC_t)(...)` inside a switch case) bind
    /// without bouncing through the file-scope declaration parser.
    /// `block_symbols == Some` records the prior binding for an
    /// enclosing `parse_block_stmt` to restore on block exit;
    /// `block_symbols == None` (function-body top level) shadows the
    /// prior binding and marks `is_scope_typedef` so the function-exit
    /// cleanup restores it.
    pub(super) fn parse_block_typedef(
        &mut self,
        mut block_symbols: Option<&mut Vec<(usize, i64, i64, i64)>>,
    ) -> Result<(), C5Error> {
        self.next()?; // consume `typedef`
        let lbt = self.parse_decl_base_type()?;
        while self.lex.tk != ';' {
            let (id_idx, mut ty, mut td_array) = self.parse_declarator(lbt)?;
            if id_idx == usize::MAX {
                return Err(self.compile_err("typedef requires a name"));
            }
            // `__attribute__((vector_size(N)))` on the typedef rebuilds its type
            // into a GCC vector here, matching the file-scope path. Without it
            // the attribute leaked to the first subsequent declaration and was
            // then consumed, so a second use of the typedef resolved as a scalar.
            if self.pending.attr_vector_size > 0 {
                let n = core::mem::take(&mut self.pending.attr_vector_size);
                ty = self.make_vector_type(ty, n);
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
            if let Some(bs) = block_symbols.as_deref_mut() {
                bs.push((
                    id_idx,
                    self.symbols[id_idx].class,
                    self.symbols[id_idx].type_,
                    self.symbols[id_idx].val,
                ));
            } else {
                self.shadow_symbol(id_idx);
                self.symbols[id_idx].is_scope_typedef = true;
            }
            self.symbols[id_idx].class = Token::Typedef as i64;
            self.symbols[id_idx].type_ = typedef_ty;
            self.symbols[id_idx].val = 0;
            // Preserve an array / vector typedef's element count (C99 6.7.7):
            // the file-scope path stores this (run_compile), but the block-scope
            // path dropped it, so a second declaration using the typedef
            // (`typedef int A4[4]; A4 a; A4 b;`) resolved A4 as a scalar. Fold
            // in a base-typedef dimension too (`typedef A4 B;`).
            let typedef_dim = self.pending.typedef_base_array_size;
            if typedef_dim != 0 && td_array == 0 {
                td_array = typedef_dim;
            }
            self.symbols[id_idx].array_size = td_array;
            if typedef_fpi > 0 {
                self.symbols[id_idx].fn_ptr_indirection = typedef_fpi;
            }
            if let Some(pp) = typedef_params {
                self.symbols[id_idx].params = pp.types;
                self.symbols[id_idx].is_variadic = pp.is_variadic;
            } else if let Some((proto_fixed, proto_variadic)) = self.pending.typedef_fn_proto.take()
            {
                // `typedef RET (*NAME)(args)` at block scope: the
                // declarator captured the pointee prototype. Record it
                // as the file-scope branch does, so an indirect call
                // through a variable of this typedef narrows arguments
                // and routes a variadic tail per the host ABI.
                self.symbols[id_idx].params = self
                    .pending
                    .fn_ptr_param_types
                    .take()
                    .unwrap_or_else(|| alloc::vec![0i64; proto_fixed]);
                self.symbols[id_idx].is_variadic = proto_variadic;
            }
            self.accept(',')?;
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
        // Storage-class prefixes. `static` at function scope promotes
        // the declarator to a Glo symbol with persistent data-segment
        // storage; `extern` (C99 6.2.2p4) gives it external linkage
        // referring to a definition in this or another unit, with no
        // local storage.
        let mut is_static = false;
        let mut is_extern = false;
        // Block-scope `_Thread_local` / `__thread` gives a `static` object
        // thread storage duration (C11 6.7.1); an automatic thread-local is
        // ill-formed, so it always pairs with `static`.
        let mut is_thread_local = false;
        // Reset the const carrier for this declaration; `parse_decl_base_type`
        // below records `const` as it consumes the base specifiers.
        self.pending.base_is_const = false;
        self.pending.saw_register_storage = false;
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::ThreadLocal
        {
            if self.lex.tk == Token::Static {
                is_static = true;
            } else if self.lex.tk == Token::Extern {
                is_extern = true;
            } else {
                is_thread_local = true;
            }
            self.next()?;
        }
        // A block-scope thread-local has static storage duration (C11 6.7.1):
        // `__thread T x;` behaves as `static __thread T x;`.
        if is_thread_local && !is_extern {
            is_static = true;
        }
        let lbt = self.parse_decl_base_type()?;
        // C99 6.7.1: a storage-class specifier may trail the type specifier
        // (`INTN STATIC x;`), so consume any that follow the base type. The
        // leading run above handles the usual `static INTN x;` order.
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::ThreadLocal
        {
            if self.lex.tk == Token::Static {
                is_static = true;
            } else if self.lex.tk == Token::Extern {
                is_extern = true;
            } else {
                is_thread_local = true;
            }
            self.next()?;
        }
        if is_thread_local && !is_extern {
            is_static = true;
        }
        // A function-pointer typedef base type contributes its lineage to
        // every declarator in the list; the per-declarator symbol creation
        // consumes these pending fields, so capture and re-seed each one.
        let base_fn_ptr_indirection = self.pending.fn_ptr_indirection;
        let base_is_function_type = self.pending.base_is_function_type;
        let base_typedef_fn_proto = self.pending.typedef_fn_proto;
        let base_fn_ptr_param_types = self.pending.fn_ptr_param_types.clone();
        // C99 6.7p1 / 6.2.2p5: a block-scope `[*]name(params);` is a
        // function declaration with external (internal if `static`)
        // linkage; bind it and let the call resolve at link time.
        if self.try_parse_block_fn_prototype(lbt, is_static)? {
            return Ok(());
        }
        // A `__attribute__((cleanup(fn)))` written before the type applies to
        // every declarator in the list (the scope-guard / auto-cleanup
        // idiom); one written after a declarator applies to it alone.
        let leading_cleanup = self.pending.attr_cleanup.take();
        while self.lex.tk != ';' {
            self.pending.fn_ptr_indirection = base_fn_ptr_indirection;
            self.pending.base_is_function_type = base_is_function_type;
            self.pending.typedef_fn_proto = base_typedef_fn_proto;
            self.pending.fn_ptr_param_types = base_fn_ptr_param_types.clone();
            // C99 6.7.6.2: a non-constant array dimension at block scope
            // is a variable-length array.
            self.pending.vla_allowed = true;
            let (loc_idx, ty, mut array_size) = self.parse_declarator(lbt)?;
            self.pending.vla_allowed = false;
            let asm_reg = self.parse_register_asm_binding(is_static, is_extern)?;
            // Trailing cleanup wins for this declarator; otherwise the
            // leading one (if any) applies.
            let cleanup_fn = self.pending.attr_cleanup.take().or(leading_cleanup);
            // C99 6.3.2.1p4: a function-pointer rvalue auto-decays
            // through any unary `*` chain. The `Symbol::fn_ptr_indirection`
            // side-channel records how many indirection levels sit between
            // the variable's loaded value and the function pointer itself
            // so the unary-`*` handler can recognise the decay. The
            // function-body-top path picks this up in `parse_function_body_local_decl`;
            // an inside-block decl (`else { fn_ptr_t kf = ...; }`) reaches
            // here and the lineage must propagate equivalently or downstream
            // `(*kf)(...)` is lowered as `Load { kind = result_tag }` and
            // dereferences the function pointer's bit pattern.
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            // Capture the function-pointer prototype before the initializer
            // is parsed: an initializer cast (`= (void *)f`) runs a base-type
            // parse that clears these pending fields, so a variadic
            // fn-pointer declared with an initializer would otherwise lose
            // its prototype and emit the indirect call as non-variadic.
            let fnptr_proto = self.pending.typedef_fn_proto.take();
            let fnptr_param_types = self.pending.fn_ptr_param_types.take();
            // C99 6.7.7p3 + 6.7.6.1: an array typedef contributes
            // its dimension only when the declarator stayed at
            // the typedef's element type. A `*` in the declarator
            // names a pointer-to-element-type; the array
            // dimension is part of the pointee and must not be
            // re-applied to the declarator. Peek without
            // clearing so the rest of the comma list keeps the
            // dimension; the carrier is reset on the next
            // declaration.
            let typedef_dim = self.pending.typedef_base_array_size;
            if typedef_dim > 0 && array_size == 0 && self.pending.declarator_leading_ptr_count == 0
            {
                array_size = typedef_dim;
                self.apply_typedef_array_dims(loc_idx);
            }
            self.ty = ty;

            // A block-scope `extern` converts the slot to a Glo external
            // reference for the block. Three prior states differ (C99
            // 6.2.1p4 / 6.2.2p4):
            //   * an existing file-scope `Glo` / function `Fun` binding --
            //     the extern names the same entity; nothing is converted
            //     and the slot restores normally.
            //   * a fresh, never-declared name (`Id` class) -- the slot is
            //     left `Glo`/extern past the block so a later `&name`
            //     resolves through `live_glo_addr` and the linker emits an
            //     undefined data symbol keyed by name (this is the only
            //     binding of the name, so leaking it is harmless).
            //   * a *bound* enclosing name (a local, parameter, or enum
            //     constant) -- converting in place would destroy it. Save
            //     the prior binding for restore at block exit and mark the
            //     slot so in-block references resolve by name (or to the
            //     same-TU definition) through `Ast::block_extern_refs`,
            //     independent of the restored class at walk time.
            let prior_class = self.symbols[loc_idx].class;
            let convert_extern =
                is_extern && prior_class != Token::Glo as i64 && prior_class != Token::Fun as i64;
            let extern_shadows_binding = convert_extern && prior_class != Token::Id as i64;
            if !convert_extern || extern_shadows_binding {
                block_symbols.push((
                    loc_idx,
                    self.symbols[loc_idx].class,
                    self.symbols[loc_idx].type_,
                    self.symbols[loc_idx].val,
                ));
            }

            if is_extern {
                if convert_extern {
                    self.symbols[loc_idx].class = Token::Glo as i64;
                    self.symbols[loc_idx].type_ = ty;
                    // A block-scope `extern T name[N];` names an array object;
                    // record its dimension so a subscript in the block sees an
                    // array (6.7.6.2), not a scalar. `inner_array_size` for a
                    // multi-dimensional extern is already set on the symbol by
                    // the declarator parse. Only the freshly converted `Glo`
                    // needs this; an extern naming an existing file-scope
                    // binding keeps that binding's dimension.
                    self.symbols[loc_idx].array_size = array_size.max(0);
                    if extern_shadows_binding {
                        // Carry no in-unit offset; the prior binding's
                        // `is_extern_decl` / `linkage` stay untouched so the
                        // block-exit restore is exact. References resolve
                        // through `block_extern_refs`.
                        self.symbols[loc_idx].val = 0;
                        self.symbols[loc_idx].block_extern_active = true;
                    } else {
                        // External linkage routes `&name` through
                        // `live_glo_addr`'s `GloAddr::Extern` arm to a
                        // name-keyed relocation; without it every block-scope
                        // extern collapses onto the same `.data` base.
                        self.symbols[loc_idx].is_extern_decl = true;
                        self.symbols[loc_idx].linkage = crate::c5::symbol::Linkage::External;
                    }
                }
            } else if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].is_thread_local = is_thread_local;
                // A nested-block `static const` integer folds its value in
                // later constant expressions (read from `.data`).
                self.symbols[loc_idx].is_const_qualified = self.pending.base_is_const
                    && array_size == 0
                    && super::types::is_integer_scalar_ty(ty);
                self.allocate_static_local(loc_idx, ty, array_size)?;
                self.ast_emit_static_local_decl(loc_idx as u32);
            } else {
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].was_referenced = false;
                self.symbols[loc_idx].decl_line = self.lex.line;
                let decl_file = self.intern_source_file() as u32;
                self.symbols[loc_idx].decl_file = decl_file;
                self.symbols[loc_idx].decl_in_main_source = self.in_main_source();
                // Unconditional write so a reused symbol slot does not
                // leak a stale binding from an outer name.
                self.symbols[loc_idx].asm_register = asm_reg;
                self.check_register_asm_init(asm_reg)?;
                // Save any enclosing aggregate's in-progress initializer
                // carriers -- this declaration can be nested inside one when
                // an aggregate element is a statement expression that
                // declares a local -- so this declaration's finalize does not
                // drain the outer aggregate's runtime elements. `take_*`
                // leaves the carriers empty for this declaration.
                let saved = self.take_pending_local_carriers();
                let r = self.allocate_local_with_init(loc_idx, ty, array_size);
                if r.is_ok() {
                    self.finalize_local_init(loc_idx);
                }
                self.restore_pending_local_carriers(saved);
                r?;
            }
            // A deferred-size local (`T x[]`) whose initializer resolved to
            // zero elements keeps its array-ness (decay, sizeof 0) through
            // this flag; the `array_size == 0` encoding alone reads as a
            // scalar. Assigned unconditionally so a reused symbol slot does
            // not leak a stale flag (mirrors the function-body decl path).
            self.symbols[loc_idx].is_zero_len_array =
                array_size == -1 && self.symbols[loc_idx].array_size == 0;
            // Write the lineage tag after `allocate_local_with_init`
            // (which may have parsed an initializer) so it can't be
            // clobbered by the init expression's symbol lookups.
            // Static locals (promoted to Glo class) carry the same
            // tag -- the codegen reads it at the same Ident-load
            // site regardless of storage class.
            self.symbols[loc_idx].fn_ptr_indirection = fn_ptr_indirection;
            // Inherit a variadic function-pointer prototype onto the
            // local so an indirect call through it knows the callee's
            // named-parameter count and routes the variadic tail per
            // the host variadic ABI. Only variadic prototypes are
            // recorded (see the equivalent site in
            // `parse_function_body_local_decl`).
            if let Some(types) = fnptr_param_types {
                self.symbols[loc_idx].params = types;
                self.symbols[loc_idx].is_variadic = matches!(fnptr_proto, Some((_, true)));
            } else if let Some((proto_fixed, true)) = fnptr_proto {
                self.symbols[loc_idx].params = alloc::vec![0i64; proto_fixed];
                self.symbols[loc_idx].is_variadic = true;
            }

            // Register the cleanup after the binding is final (the
            // automatic-storage branch above resets `was_referenced`).
            // C99 6.7.2.1 has no such attribute; GCC/Clang require an
            // object with automatic storage, so a `static` / `extern`
            // declarator's cleanup is inert.
            if let Some(fn_sym) = cleanup_fn
                && !is_static
                && !is_extern
            {
                self.register_cleanup_var(loc_idx, fn_sym);
            }

            if self.pending.auto_type_single_declarator && self.lex.tk == ',' {
                return Err(self.compile_err("`__auto_type` declaration takes a single declarator"));
            }
            self.accept(',')?;
        }
        self.next()?;
        self.pending.auto_type_single_declarator = false;
        Ok(())
    }

    /// Register a `__attribute__((cleanup(fn)))` variable in the current
    /// block scope. `fn(&var)` then runs on every exit from the scope.
    /// The variable and the function are marked referenced so neither
    /// draws an unused diagnostic.
    pub(super) fn register_cleanup_var(&mut self, var_sym: usize, fn_sym: usize) {
        self.symbols[var_sym].was_read = true;
        self.symbols[var_sym].was_referenced = true;
        self.symbols[fn_sym].was_referenced = true;
        if let Some(scope) = self.cleanup_scopes.last_mut() {
            scope.push((var_sym, fn_sym));
        }
    }

    /// Build the `Stmt::Expr` for one cleanup call `fn(&var)` and push it
    /// into the AST statement stream.
    pub(super) fn push_cleanup_call(&mut self, var_sym: usize, fn_sym: usize) {
        use super::super::ast::{Expr, Stmt, UnOp};
        let pos = self.ast_src_pos();
        let var_ty = self.symbols[var_sym].type_;
        let ident = self.ast_emit_ident(var_sym as u32, var_ty);
        let ptr_ty = var_ty + Ty::Ptr as i64;
        let addr = self.ast.push_expr(
            Expr::Unary {
                op: UnOp::AddrOf,
                child: ident,
                ty: ptr_ty,
            },
            pos,
        );
        let ret_ty = self.symbols[fn_sym].type_;
        let callee = self.ast_synthesize_callee(fn_sym as u32, ret_ty);
        let call = self.ast.push_expr(
            Expr::Call {
                callee,
                args: alloc::vec![addr],
                ty: ret_ty,
            },
            pos,
        );
        self.ast.push_stmt(Stmt::Expr(call), pos);
    }

    /// Emit the cleanup calls for the scopes at index `from` and above
    /// (innermost scope cleaned first; each scope's variables in reverse
    /// declaration order, C++-style, matching GCC). Used before a
    /// `return` (`from == 0`), `break`, or `continue`.
    fn emit_cleanups_above(&mut self, from: usize) {
        let mut pending: alloc::vec::Vec<(usize, usize)> = alloc::vec::Vec::new();
        for scope in self.cleanup_scopes[from..].iter().rev() {
            for &(var_sym, fn_sym) in scope.iter().rev() {
                pending.push((var_sym, fn_sym));
            }
        }
        for (var_sym, fn_sym) in pending {
            self.push_cleanup_call(var_sym, fn_sym);
        }
    }

    /// True when any cleanup scope at index `from` and above holds a
    /// variable, i.e. a `return` / `break` / `continue` here must run
    /// cleanup functions.
    fn has_cleanups_above(&self, from: usize) -> bool {
        self.cleanup_scopes[from..].iter().any(|s| !s.is_empty())
    }

    /// Coalesce the sibling statements pushed since `start` (a spill, the
    /// cleanup calls, and the jump / return) into one Compound. The
    /// one-statement-per-body contexts (`if` / loop bodies, the block-item
    /// loop) capture a body by its last arena entry, so a bare `return`
    /// under a cleanup must resolve to a single statement carrying all of
    /// them, not just the trailing jump.
    fn coalesce_exit_since(&mut self, start: usize) {
        if self.ast.stmts.len().saturating_sub(start) > 1 {
            let ids: alloc::vec::Vec<super::super::ast::StmtId> = (start..self.ast.stmts.len())
                .map(|i| i as super::super::ast::StmtId)
                .collect();
            self.ast_wrap_block_items(&ids);
        }
    }

    /// Spill `value` (already converted to `ty`) into a fresh unnamed
    /// stack temporary and return an lvalue-ident that reloads it. Used
    /// so a `return <expr>;` under an active cleanup evaluates the value
    /// before the cleanup functions run (C's scope-exit order): e.g.
    /// `return dup(s)` copies before a scope-guarded local `s` is freed.
    fn spill_expr_to_temp(
        &mut self,
        value: super::super::ast::ExprId,
        ty: i64,
    ) -> super::super::ast::ExprId {
        use super::super::ast::{Expr, Stmt};
        let slot = self.reserve_slots(self.local_storage_slots(ty, 1));
        let sym_idx = self.symbols.len();
        // The shadow fields mirror the live ones so the function-exit
        // `restore_shadowed_symbol` leaves this compiler-generated local
        // a `Loc`, rather than resetting its class to the zero default.
        self.symbols.push(crate::c5::symbol::Symbol {
            class: Token::Loc as i64,
            type_: ty,
            val: slot,
            h_class: Token::Loc as i64,
            h_type: ty,
            h_val: slot,
            ..Default::default()
        });
        // The symbol index runs a hash array in lockstep with `symbols`;
        // a push without a matching `record` desyncs it and the next
        // interned identifier lands at the wrong index. The empty name is
        // never the target of a source-level lookup.
        self.symbol_index.record(crate::c5::lexer::hash_name(b""));
        let pos = self.ast_src_pos();
        let mk_ident = |c: &mut Self| {
            c.ast.push_expr(
                Expr::Ident {
                    sym: sym_idx as u32,
                    ty,
                    class: Token::Loc as i64,
                    val: slot,
                    is_thread_local: false,
                    array_size: 0,
                },
                pos,
            )
        };
        let lhs = mk_ident(self);
        let assign = self.ast.push_expr(
            Expr::Assign {
                lhs,
                rhs: value,
                ty,
            },
            pos,
        );
        self.ast.push_stmt(Stmt::Expr(assign), pos);
        mk_ident(self)
    }

    /// `{ ... }`. C99 block-scope: declarations may appear anywhere a
    /// statement may. Each declaration's bindings shadow outer
    /// symbols for the duration of the block and are restored on
    /// exit.
    /// Parse `__label__ name, ... ;` and bind each name in the block
    /// whose scope is currently innermost. GCC requires the declaration
    /// to lead its block, before any other declaration or statement;
    /// the callers enforce that by only dispatching here while no other
    /// item has been parsed.
    pub(super) fn parse_local_label_decl(&mut self) -> Result<(), C5Error> {
        self.next()?; // consume `__label__`
        loop {
            if self.lex.tk != Token::Id {
                return Err(self.compile_err("label name expected in `__label__` declaration"));
            }
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            let scope = self
                .local_label_scopes
                .last()
                .expect("a block scope is open while parsing its `__label__` declaration");
            if scope.iter().any(|(declared, _)| declared == &name) {
                return Err(self.compile_err(format!("duplicate local label declaration `{name}`")));
            }
            let key = format!("{name}#{}", self.local_label_seq);
            self.local_label_seq += 1;
            self.local_label_scopes
                .last_mut()
                .expect("a block scope is open while parsing its `__label__` declaration")
                .push((name, key));
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            break;
        }
        self.consume(b';', "semicolon expected after `__label__` declaration")?;
        Ok(())
    }

    fn parse_block_stmt(&mut self) -> Result<super::super::ast::StmtId, C5Error> {
        self.next()?;
        self.cleanup_scopes.push(alloc::vec::Vec::new());
        // C99 6.2.1: a block introduces a new scope for struct,
        // union, and enum tags. Tag bindings declared in this block
        // shadow same-named tags in any enclosing scope and go out of
        // scope when the block exits.
        self.tag_scopes.push(alloc::vec::Vec::new());
        // GCC local labels declared by this block; see
        // `Compiler::resolve_label_name`.
        self.local_label_scopes.push(alloc::vec::Vec::new());
        let mut block_symbols = Vec::new();

        let mut top_level_ids: alloc::vec::Vec<super::super::ast::StmtId> = alloc::vec::Vec::new();
        // C99 6.2.4p2: a VLA declared directly in this block has its
        // storage reclaimed on block exit. Track whether any appears so
        // the block is bracketed with the stack save / restore.
        let mut block_has_vla = false;
        let mut at_block_start = true;
        while self.lex.tk != '}' {
            if self.lex.tk == Token::LocalLabel {
                if !at_block_start {
                    return Err(
                        self.compile_err("`__label__` must appear at the start of its block")
                    );
                }
                self.parse_local_label_decl()?;
                continue;
            }
            at_block_start = false;
            // C23 6.7.13 / 6.8: an attribute-specifier-sequence may
            // lead either a declaration or a statement at block scope.
            // Consume it, then dispatch on the following token.
            let mut leading_maybe_unused = false;
            if self.at_attribute_specifier() {
                self.pending.attr_maybe_unused = false;
                // Clear per-item so a `cleanup` attribute leading a
                // statement (not a declaration) cannot leak onto the next
                // declaration; the declaration path re-reads it after this.
                self.pending.attr_cleanup = None;
                self.skip_attribute_specifiers()?;
                leading_maybe_unused = self.pending.attr_maybe_unused;
                if self.lex.tk == '}' {
                    break;
                }
            }
            if self.lex.tk == Token::Typedef {
                self.parse_block_typedef(Some(&mut block_symbols))?;
            } else if self.lex.tk == Token::StaticAssert {
                // C11 6.7.10 allows `static_assert` anywhere a
                // declaration may appear -- including block scope.
                self.parse_static_assert()?;
            } else if self.lex_is_type_start() {
                let item_before = self.ast_stmts_snapshot();
                let sym_before = block_symbols.len();
                let vla_before = self.func_vla_decls;
                self.parse_block_local_decl(&mut block_symbols)?;
                if self.func_vla_decls > vla_before {
                    block_has_vla = true;
                }
                if leading_maybe_unused {
                    // C23 6.7.13.5: `[[maybe_unused]]` on a declaration
                    // suppresses the unused diagnostics for the names it
                    // introduces.
                    for &(idx, _, _, _) in &block_symbols[sym_before..] {
                        self.symbols[idx].maybe_unused = true;
                    }
                }
                let item_after = self.ast.stmts.len();
                // A local decl pushes one stmt-id-wrapping Decl
                // per declarator; capture every one as a top-
                // level item. A statement-expression initializer
                // interleaves its own sub-statements here -- skip
                // those; they are reached through the Decl's
                // `Expr::StmtExpr` node.
                for id in item_before..item_after {
                    if self.in_stmt_expr_range(id) {
                        continue;
                    }
                    top_level_ids.push(id as super::super::ast::StmtId);
                }
                self.stmt_expr_arena_ranges
                    .retain(|&(s, _)| s < item_before);
            } else {
                let item_before = self.ast_stmts_snapshot();
                self.stmt()?;
                let item_after = self.ast.stmts.len();
                let item_id = if item_after > item_before + 1 {
                    self.ast_wrap_stmts_since(item_before)
                } else if item_after > item_before {
                    (item_after - 1) as super::super::ast::StmtId
                } else {
                    // Inner parse pushed nothing (e.g. `;` empty
                    // statement) -- nothing to bind to the
                    // surrounding Compound either. Skip.
                    continue;
                };
                top_level_ids.push(item_id);
            }
        }
        // Fall-through exit: run this block's `__attribute__((cleanup))`
        // functions in reverse declaration order, before any VLA arena
        // reclaim below (a cleanup may read VLA storage). When the block
        // ends in a terminator these are emitted after it and the walker
        // never reaches them; the terminator's own path already cleaned.
        if self.cleanup_scopes.last().is_some_and(|s| !s.is_empty()) {
            let pairs: alloc::vec::Vec<(usize, usize)> = self
                .cleanup_scopes
                .last()
                .unwrap()
                .iter()
                .rev()
                .cloned()
                .collect();
            for (var_sym, fn_sym) in pairs {
                let before = self.ast.stmts.len();
                self.push_cleanup_call(var_sym, fn_sym);
                for id in before..self.ast.stmts.len() {
                    top_level_ids.push(id as super::super::ast::StmtId);
                }
            }
        }
        self.cleanup_scopes.pop();
        // C99 6.2.4p2: bracket a VLA-declaring block so the stack
        // pointer is snapshotted on entry and restored on exit,
        // reclaiming the VLA storage (per iteration for a loop body).
        if block_has_vla {
            let save_slot = self.reserve_slots(1);
            let pos = self.ast_src_pos();
            let enter = self
                .ast
                .push_stmt(super::super::ast::Stmt::VlaScopeEnter { save_slot }, pos);
            let exit = self
                .ast
                .push_stmt(super::super::ast::Stmt::VlaScopeExit { save_slot }, pos);
            let mut bracketed = alloc::vec::Vec::with_capacity(top_level_ids.len() + 2);
            bracketed.push(enter);
            bracketed.extend_from_slice(&top_level_ids);
            bracketed.push(exit);
            top_level_ids = bracketed;
        }
        // Wrap the collected top-level stmt ids into a
        // `Stmt::Compound`. Only this Compound references the
        // top-level stmts -- inner wrappers are dead AST entries
        // that the walker never visits (it iterates the
        // Compound's items, which point at the canonical top-
        // level ids).
        let block_id = self.ast_wrap_block_items(&top_level_ids);
        self.next()?;

        // Emit the unused-variable / unused-value diagnostics for
        // each Token::Loc declared in this block. Run before the
        // loop below restores the outer bindings -- once `class`
        // is overwritten the Token::Loc test no longer holds.
        // Parameter slots (val >= 2) cannot be declared inside a
        // `{ ... }` block; their diagnostic is emitted at function
        // exit. Names starting with `_` are suppressed (gcc /
        // clang `-Wunused` convention).
        for (idx, _, _, _) in &block_symbols {
            let sym = &self.symbols[*idx];
            if sym.class != Token::Loc as i64
                || sym.val >= 0
                || !sym.decl_in_main_source
                || sym.address_escaped
                || sym.was_read
                || sym.maybe_unused
                || sym.name.starts_with('_')
            {
                continue;
            }
            let name = sym.name.clone();
            let line = sym.decl_line;
            // `was_referenced` is true when the parser emitted any
            // expression mention (assignment LHS, increment, ...).
            // Without it the only "write" possible is the
            // declaration initializer, which the dead-store
            // diagnostic should treat as "unused" rather than
            // "set but never used".
            let msg = if sym.was_referenced && sym.was_written {
                alloc::format!("variable `{name}` set but never used")
            } else {
                alloc::format!("unused variable `{name}`")
            };
            self.warn_at(line, msg);
        }

        // Capture block-scoped locals for DWARF before the restore
        // below unbinds them. The function-close collection walks the
        // symbol table, which no longer holds these bindings; without
        // this a debugger cannot inspect any local declared inside a
        // nested block or a `for` initializer. function_bc_pc is filled
        // in at function close (see run_compile.rs). Slots 0 and 1 are
        // the saved-frame area, not user names.
        for (idx, _, _, _) in &block_symbols {
            let sym = &self.symbols[*idx];
            if sym.class == Token::Loc as i64
                && sym.val != 0
                && sym.val != 1
                && !sym.name.is_empty()
            {
                self.pending_block_locals
                    .push(crate::c5::program::VariableInfo {
                        function_bc_pc: 0,
                        name: sym.name.clone(),
                        type_tag: sym.type_,
                        fp_slot: sym.val,
                        is_parameter: false,
                        decl_line: sym.decl_line as u32,
                        array_size: sym.array_size.max(0) as u32,
                        decl_file: sym.decl_file,
                    });
            }
        }

        // Restore shadowed bindings on block exit. A block-scope `extern`
        // that shadowed a bound name reverts to the saved class/type/val
        // and drops its `block_extern_active` mark; the marked references
        // already resolve through `Ast::block_extern_refs` independent of
        // this restored class.
        for (idx, class, ty, val) in block_symbols.into_iter().rev() {
            self.symbols[idx].class = class;
            self.symbols[idx].type_ = ty;
            self.symbols[idx].val = val;
            self.symbols[idx].block_extern_active = false;
        }
        // Pop this block's tag bindings; the StructDef storage in
        // `self.structs` stays reachable by id for any reference the
        // outer scope already holds.
        self.tag_scopes.pop();
        self.local_label_scopes.pop();
        Ok(block_id)
    }

    /// Parse the body of a GCC statement expression `({ ... })`. On
    /// entry the leading `(` has been consumed and the lexer is at
    /// `{`; `parse_block_stmt` handles the C99 6.2.1 block scope.
    /// The value type is that of the last expression-statement
    /// (`Ty::Int` fallback for an empty or non-expression tail);
    /// records the node as the current expression accumulator.
    pub(super) fn parse_stmt_expr_body(&mut self) -> Result<(), C5Error> {
        let arena_before = self.ast.stmts.len();
        // The block re-enters statement parsing from inside an
        // expression parse. Its statements must leave the expression
        // vstack net-unchanged (the block's value travels through
        // `ast_acc`); an aggregate local initializer inside may leave
        // residual transient entries -- same hazard the compound-
        // literal path guards against -- which would sit on top of the
        // enclosing operator's pushed operand and make it pop the
        // wrong slot. Restore the depth after the block parse.
        let vstack_depth = self.ast_vstack.len();
        let block = self.parse_block_stmt()?;
        self.ast_vstack.truncate(vstack_depth);
        let arena_after = self.ast.stmts.len();
        // The block's statements are sub-statements of this
        // expression, not top-level items of the enclosing block;
        // record the range so the decl-path capture skips them.
        self.stmt_expr_arena_ranges
            .push((arena_before, arena_after));
        self.consume(b')', "`)` expected to close statement expression")?;
        let ty = self.stmt_expr_result_ty(block);
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_expr(super::super::ast::Expr::StmtExpr { block, ty }, pos);
        self.ast_acc = Some(id);
        self.ty = ty;
        Ok(())
    }

    /// The value type of a statement expression: the type of its
    /// last expression-statement, or `Ty::Int` when the trailing
    /// block-item is not an expression statement.
    fn stmt_expr_result_ty(&self, block: super::super::ast::StmtId) -> i64 {
        use super::super::ast::{BlockItem, Stmt};
        let last = match self.ast.stmt(block) {
            // A single-item block yields the bare statement (see
            // `ast_wrap_block_items`); a multi-item block yields a
            // `Stmt::Compound` whose last item carries the value.
            Stmt::Compound(items) => match items.last() {
                Some(BlockItem::Stmt(s)) => *s,
                _ => return super::super::token::Ty::Int as i64,
            },
            _ => block,
        };
        if let Stmt::Expr(e) = self.ast.stmt(last) {
            return self.ast.expr_value_ty(*e);
        }
        super::super::token::Ty::Int as i64
    }

    /// True when statement-arena entry `id` belongs to a statement
    /// expression parsed in the current function -- i.e. it is a
    /// sub-statement reachable through an `Expr::StmtExpr`, not a
    /// top-level block item.
    pub(super) fn in_stmt_expr_range(&self, id: usize) -> bool {
        self.stmt_expr_arena_ranges
            .iter()
            .any(|&(s, e)| id >= s && id < e)
    }

    /// Shared head of an `asm` statement or a file-scope `asm`
    /// declaration: qualifiers, `(`, and the (concatenated) template
    /// string. Returns the template bytes, their start offset in the
    /// data section (the caller truncates once done), and the
    /// `volatile` / `goto` qualifier flags.
    pub(super) fn parse_asm_head(
        &mut self,
    ) -> Result<(alloc::vec::Vec<u8>, usize, bool, bool), C5Error> {
        self.next()?; // asm / __asm__ / __asm
        // Optional qualifiers (`volatile` / `__volatile__`, `inline`,
        // `goto`). `volatile` must not be elided and rides the parsed
        // asm block; `goto` selects the label-list grammar and is
        // implicitly volatile.
        let mut is_volatile = false;
        let mut is_goto = false;
        while self.lex.tk == Token::TypeQual
            || self.lex.tk == Token::Inline
            || self.lex.tk == Token::ForceInline
            || self.lex.tk == Token::Goto
        {
            if self.lex.tk == Token::TypeQual {
                is_volatile = true;
            }
            if self.lex.tk == Token::Goto {
                is_goto = true;
                is_volatile = true;
            }
            self.next()?;
        }
        self.consume(b'(', "`(` expected after `asm`")?;
        if self.lex.tk != '"' {
            return Err(self.compile_err("inline asm template string expected"));
        }
        // The lexer has appended the template bytes to the data
        // section; read them back, then drop them once parsing is done
        // so the template does not occupy the data section.
        let tstart = self.lex.ival as usize;
        self.next()?; // consume the first template string
        // C99 5.1.1.2 phase 6: adjacent string literals concatenate. The
        // lexer appends each narrow literal's bytes contiguously with no
        // interior NUL, so consuming the following `"` tokens extends the
        // template in place before it is read back.
        while self.lex.tk == '"' {
            self.next()?;
        }
        let template: alloc::vec::Vec<u8> = self.data[tstart..].to_vec();
        Ok((template, tstart, is_volatile, is_goto))
    }

    /// Parse a GCC inline-asm statement. c5 supports the operand-free
    /// forms: an empty template (a compiler barrier, no instruction
    /// emitted) and a single known operand-free hint instruction
    /// (`pause` / `yield`, lowered to the target spin-loop hint).
    /// Operand constraints and other instructions are rejected.
    fn parse_asm_stmt(&mut self) -> Result<(), C5Error> {
        let (template, tstart, is_volatile, is_goto) = self.parse_asm_head()?;
        // `asm goto` takes the general extended-asm path directly: the
        // operand-free template shortcuts below have no label grammar.
        if is_goto {
            self.data.truncate(tstart);
            return self.parse_extended_asm(template, is_volatile, true);
        }
        // The x87 FPU control-word forms carry exactly one memory operand.
        // Detect them from the template before the operand-rejection loop.
        // Collapse interior whitespace runs to a single space so templates
        // that differ only in spacing (`"sidt  %0"` vs `"sidt %0"`) match one
        // canonical form.
        let tmpl_lc: alloc::string::String = {
            let raw = core::str::from_utf8(&template)
                .unwrap_or("")
                .trim()
                .trim_end_matches(';')
                .trim()
                .to_ascii_lowercase();
            let mut s = alloc::string::String::with_capacity(raw.len());
            let mut prev_space = false;
            for ch in raw.chars() {
                if ch.is_ascii_whitespace() {
                    if !prev_space {
                        s.push(' ');
                    }
                    prev_space = true;
                } else {
                    s.push(ch);
                    prev_space = false;
                }
            }
            s
        };
        // Single-operand forms whose intrinsic takes the operand's *address*
        // (memory / register-held destination or source object).
        let by_addr_kind = match tmpl_lc.as_str() {
            "fnstcw %0" => Some(super::super::op::Intrinsic::X87StoreControlWord),
            "fldcw %0" => Some(super::super::op::Intrinsic::X87LoadControlWord),
            "fxsave %0" => Some(super::super::op::Intrinsic::X86FxSave),
            "fxrstor %0" => Some(super::super::op::Intrinsic::X86FxRestore),
            "sgdt %0" => Some(super::super::op::Intrinsic::X86Sgdt),
            "sidt %0" => Some(super::super::op::Intrinsic::X86Sidt),
            "sldt %0" => Some(super::super::op::Intrinsic::X86Sldt),
            "str %0" => Some(super::super::op::Intrinsic::X86Str),
            "lgdt %0" => Some(super::super::op::Intrinsic::X86Lgdt),
            "lidt %0" => Some(super::super::op::Intrinsic::X86Lidt),
            "lldtw %0" => Some(super::super::op::Intrinsic::X86Lldt),
            _ => None,
        };
        if let Some(kind) = by_addr_kind {
            self.data.truncate(tstart);
            return self.parse_single_operand_asm(kind, true);
        }
        // `clflush (%0)`: the `"r"(ptr)` operand value is itself the address.
        if tmpl_lc == "clflush (%0)" {
            self.data.truncate(tstart);
            return self.parse_single_operand_asm(super::super::op::Intrinsic::X86Clflush, false);
        }
        // `cpuid` / `xgetbv` carry register-constrained operands. The
        // template is just the mnemonic (the PIC `xchg`-wrapped form is
        // x86-32 only, which c5 does not target).
        let cpuid_is_cpuid = match tmpl_lc.as_str() {
            "cpuid" => Some(true),
            "xgetbv" => Some(false),
            _ => None,
        };
        if let Some(is_cpuid) = cpuid_is_cpuid {
            self.data.truncate(tstart);
            return self.parse_cpuid_xgetbv_asm(is_cpuid);
        }
        // `divq %4` -- x86-64 unsigned 128/64 division (the `udiv_qrnnd`
        // assembly-macro shape). The register-tied operands are handled
        // specially, like cpuid.
        if tmpl_lc == "divq %4" {
            self.data.truncate(tstart);
            return self.parse_divq_asm();
        }
        // `rdtsc` -- x86-64 read timestamp counter: two register-tied
        // outputs, no inputs.
        if tmpl_lc == "rdtsc" {
            self.data.truncate(tstart);
            return self.parse_rdtsc_asm();
        }
        // AArch64 cache maintenance + barriers. Match the
        // whitespace-free template so tabs / spaces are
        // irrelevant; each maps to a fixed-encoding intrinsic.
        {
            use super::super::op::Intrinsic as I;
            let tmpl_ws: alloc::string::String =
                tmpl_lc.chars().filter(|c| !c.is_whitespace()).collect();
            let reg_op = match tmpl_ws.as_str() {
                "mrs%0,ctr_el0" => Some((I::AArch64ReadCacheType, true)),
                "dccvau,%0" => Some((I::AArch64DcCvau, false)),
                "icivau,%0" => Some((I::AArch64IcIvau, false)),
                _ => None,
            };
            if let Some((kind, is_output)) = reg_op {
                self.data.truncate(tstart);
                return self.parse_aarch64_reg_asm(kind, is_output);
            }
            let barrier = match tmpl_ws.as_str() {
                "dsbish" => Some(I::AArch64DsbIsh),
                "isb" => Some(I::AArch64Isb),
                _ => None,
            };
            if let Some(kind) = barrier {
                self.data.truncate(tstart);
                return self.parse_aarch64_barrier_asm(kind);
            }
            // AArch64 128-bit atomic RMW: the `ldaxp`/`stlxp` exclusive-pair
            // retry loop GCC/clang inline asm uses for `Int128` atomics (no
            // native 128-bit CAS through gcc 10). All four shapes share the
            // load / store / retry skeleton; the inner op selects the kind.
            if tmpl_ws.starts_with("0:ldaxp%[oldl],%[oldh],%[mem]")
                && tmpl_ws.contains("stlxp%w[tmp],")
                && tmpl_ws.contains(",%[mem]")
                && tmpl_ws.contains("cbnz%w[tmp],0b")
            {
                let kind = if tmpl_ws.contains("ccmp%[oldh],%[cmph],#0,eq") {
                    I::Atomic128CmpXchg
                } else if tmpl_ws.contains("and%[tmpl],%[oldl],%[newl]") {
                    I::Atomic128FetchAnd
                } else if tmpl_ws.contains("orr%[tmpl],%[oldl],%[newl]") {
                    I::Atomic128FetchOr
                } else {
                    I::Atomic128Xchg
                };
                self.data.truncate(tstart);
                return self.parse_atomic128_asm(kind);
            }
            // AArch64 128-bit atomic load / store: the plain `ldp`/`stp`
            // forms and the pre-LSE2 `ldxp`/`stxp` exclusive-pair loops used
            // when there is no native 16-byte atomic access. Same operand
            // grammar as the RMW shapes; the template selects the kind.
            let ldst_kind = if tmpl_ws == "ldp%[l],%[h],%[mem]" || tmpl_ws == "ldp%0,%1,%2" {
                // Named form, and the positional form used by the aligned
                // 128-bit load-extract (`ldp %0, %1, %2` with two `=r`
                // outputs and an `"m"` input) -- both load a register pair.
                Some(I::Atomic128Load)
            } else if tmpl_ws == "stp%[l],%[h],%[mem]" || tmpl_ws == "stp%0,%1,%2" {
                Some(I::Atomic128Store)
            } else if tmpl_ws.starts_with("0:ldxp%[l],%[h],%[mem]")
                && tmpl_ws.contains("stxp%w[tmp],%[l],%[h],%[mem]")
                && tmpl_ws.contains("cbnz%w[tmp],0b")
            {
                Some(I::Atomic128LoadEx)
            } else if tmpl_ws.starts_with("0:ldxp%[t1],%[t2],%[mem]")
                && tmpl_ws.contains("stxp%w[t1],%[l],%[h],%[mem]")
                && tmpl_ws.contains("cbnz%w[t1],0b")
            {
                Some(I::Atomic128StoreEx)
            } else if tmpl_ws.starts_with("0:ldxp%[l],%[h],%[mem]")
                && tmpl_ws.contains("bic%[l],%[l],%[ml]")
                && tmpl_ws.contains("bic%[h],%[h],%[mh]")
                && tmpl_ws.contains("orr%[l],%[l],%[vl]")
                && tmpl_ws.contains("orr%[h],%[h],%[vh]")
                && tmpl_ws.contains("stxp%w[f],%[l],%[h],%[mem]")
                && tmpl_ws.contains("cbnz%w[f],0b")
            {
                // Masked 128-bit store-insert: `*mem = (*mem & ~msk) | val`.
                Some(I::Atomic128StoreInsert)
            } else {
                None
            };
            if let Some(kind) = ldst_kind {
                self.data.truncate(tstart);
                return self.parse_atomic128_asm(kind);
            }
        }
        // An empty template is a compiler barrier: `__asm__("")`, or the
        // no-unroll / clobber idiom `__asm__("" :: "r"(p))`. It encodes
        // no machine instruction, but it must still reach the IR as an
        // `Inst::InlineAsm` so the SSA passes and the builder's CSE
        // cache treat it as an ordering barrier: no load / store may be
        // forwarded or merged across it. The general parser below
        // handles it; the empty template emits zero bytes.
        // The spin-loop hint appears as `pause` / `yield` (x86 / arm) or
        // the `rep; nop` byte encoding of PAUSE on x86; normalize away the
        // whitespace and `;` so every spelling maps to the relax hint. It
        // carries no operand (only an optional `"memory"` clobber), so it
        // is recognised before the general operand parser.
        let compact: alloc::string::String = tmpl_lc
            .chars()
            .filter(|c| !c.is_whitespace() && *c != ';')
            .collect();
        if compact == "pause" || compact == "yield" || compact == "repnop" {
            self.skip_asm_operand_region()?;
            self.data.truncate(tstart);
            self.mark_emit_other();
            self.ty = Ty::Int as i64;
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                super::super::ast::Expr::Intrinsic {
                    kind: super::super::op::Intrinsic::CpuRelax as i64,
                    args: alloc::vec::Vec::new(),
                    ty: Ty::Int as i64,
                },
                pos,
            );
            self.ast_acc = Some(id);
            let _ = self.ast_emit_expr_stmt();
            return Ok(());
        }
        // General GCC extended asm: parse the `: outputs : inputs :
        // clobbers` operand lists into an `AsmBlock`. The template bytes
        // are dropped from the data section; the parsed block references
        // its operand expressions by AST id.
        self.data.truncate(tstart);
        self.parse_extended_asm(template, is_volatile, false)
    }

    /// Consume the `: outputs : inputs : clobbers` region and the
    /// closing `)` and `;` of an operand-free asm statement, discarding
    /// the tokens. Used for the spin-loop hint, whose only operand-list
    /// content is a clobber with no machine effect.
    fn skip_asm_operand_region(&mut self) -> Result<(), C5Error> {
        let mut depth = 0i32;
        while !(self.lex.tk == ')' && depth == 0) {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
            }
            self.next()?;
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")
    }

    /// Parse the operand lists of a GCC extended-asm statement into an
    /// [`ast::AsmBlockAst`] and emit an [`ast::Expr::InlineAsm`] (or an
    /// [`ast::Stmt::AsmGoto`] for `asm goto`). The grammar is
    /// `: outputs : inputs : clobbers`, plus `: labels` for `asm goto`;
    /// each operand is a constraint string and a parenthesised
    /// expression (an lvalue for an output, an rvalue for an input); a
    /// clobber is a bare string; a label is an identifier naming a C
    /// label of the enclosing function. On entry the template is
    /// consumed and the cursor is at the first `:` (or `)` when there
    /// is no operand list).
    fn parse_extended_asm(
        &mut self,
        template: alloc::vec::Vec<u8>,
        volatile: bool,
        is_goto: bool,
    ) -> Result<(), C5Error> {
        use super::super::ast::{AsmBlockAst, Expr, UnOp};
        use super::super::ir::{AsmBlock, AsmConstraint, AsmOperand};
        let mut operands: alloc::vec::Vec<AsmOperand> = alloc::vec::Vec::new();
        let mut operand_names: alloc::vec::Vec<Option<alloc::string::String>> =
            alloc::vec::Vec::new();
        let mut operand_exprs: alloc::vec::Vec<super::super::ast::ExprId> = alloc::vec::Vec::new();
        let mut clobber_regs: u32 = 0;
        let mut clobber_fp_regs: u32 = 0;
        let mut clobber_memory = false;
        let mut n_outputs = 0usize;
        let mut label_ids: alloc::vec::Vec<super::super::ast::LabelId> = alloc::vec::Vec::new();
        let mut label_names: alloc::vec::Vec<alloc::string::String> = alloc::vec::Vec::new();
        // Section 1 = outputs, 2 = inputs, 3 = clobbers; 4 = labels
        // for `asm goto` (3+ folds into clobbers otherwise).
        let mut section: u8 = 0;
        let data_base = self.data.len();
        while self.lex.tk != ')' {
            if self.lex.tk == ':' {
                section += 1;
                if is_goto && section > 4 {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("inline asm goto: too many `:` sections"));
                }
                self.next()?;
                continue;
            }
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            if is_goto && section >= 4 {
                // Label list: identifiers naming C labels (forward
                // references allowed, as for `goto`).
                if self.lex.tk != Token::Id {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("inline asm goto: label identifier expected"));
                }
                let name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                // `label_names` stays the name as written: the template
                // references it as `%l[name]`. Only the binding resolves
                // through the local-label scopes.
                let key = self.resolve_label_name(&name);
                if !self.labels.iter().any(|n| n == &key) {
                    self.unresolved_gotos.push(key.clone());
                }
                label_ids.push(self.ast_label_by_name(&key));
                label_names.push(name);
                continue;
            }
            // GCC named operand: `[name]` before the constraint string.
            // The name is addressable in the template as `%[name]`.
            let mut op_name: Option<alloc::string::String> = None;
            if self.lex.tk == Token::Brak && section <= 2 {
                self.next()?; // `[`
                if self.lex.tk != Token::Id {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("inline asm: operand name expected after `[`"));
                }
                op_name = Some(self.symbols[self.lex.curr_id_idx].name.clone());
                self.next()?; // name
                self.consume(b']', "`]` expected after asm operand name")?;
            }
            if self.lex.tk != '"' {
                self.data.truncate(data_base);
                return Err(self.compile_err("inline asm: constraint string expected"));
            }
            // The lexer appended the constraint bytes to the data
            // section; copy them out and drop them.
            let cstart = self.lex.ival as usize;
            self.next()?; // consume the constraint string
            // C99 5.1.1.2 phase 6: adjacent string literals concatenate, as
            // for the template above. Condition-code output macros are
            // commonly spelled `"=@cc" "c"`, so the constraint is only
            // complete once the following `"` tokens are consumed.
            while self.lex.tk == '"' {
                self.next()?;
            }
            let cbytes: alloc::vec::Vec<u8> = self.data[cstart..].to_vec();
            self.data.truncate(cstart);
            let cstr = core::str::from_utf8(&cbytes).unwrap_or("");
            if section >= 3 {
                // Clobber list: a bare register name, `"cc"`, or
                // `"memory"`. A named register is preserved across the
                // asm; `cc` (flags) needs no action since no value is
                // kept in flags across the statement.
                let name = cstr.trim_start_matches('%');
                if name == "memory" {
                    clobber_memory = true;
                } else if name != "cc" && !name.is_empty() {
                    // The register-name spelling is arch-specific; badc knows the
                    // target, so AArch64 clobbers resolve through the AArch64
                    // names (GP and the independent SIMD/FP file), x86 through its.
                    if self.target.is_aarch64() {
                        if let Some((is_fp, num)) =
                            super::super::codegen::aarch64::asm::clobber_reg_name(name)
                        {
                            if is_fp {
                                clobber_fp_regs |= 1 << num;
                            } else {
                                clobber_regs |= 1 << num;
                            }
                        }
                    } else if let Some((reg, _)) =
                        super::super::codegen::x86_64::asm::reg_by_name(name)
                    {
                        // clobber_regs is the GP mask (0..15); clobber_fp_regs the
                        // XMM mask. Other register marks (MMX/CR/DR/SEG) are not
                        // tracked.
                        use super::super::codegen::x86_64::asm::XMM_BASE;
                        if reg < 16 {
                            clobber_regs |= 1 << reg;
                        } else if (XMM_BASE..XMM_BASE + 16).contains(&reg) {
                            clobber_fp_regs |= 1 << (reg - XMM_BASE);
                        }
                    }
                }
                continue;
            }
            let is_output = section == 1;
            let is_x86 = !self.target.is_aarch64();
            let (constraint, is_rw) =
                match Self::parse_asm_constraint(cstr, is_output, n_outputs, is_x86) {
                    Some(c) => c,
                    None => {
                        self.data.truncate(data_base);
                        return Err(self.compile_err(alloc::format!(
                            "inline asm: unsupported constraint `{cstr}`"
                        )));
                    }
                };
            if self.lex.tk != '(' {
                self.data.truncate(data_base);
                return Err(self.compile_err("inline asm: `(` expected after constraint"));
            }
            self.next()?; // consume `(`
            // A storage-less register variable (the stack / frame pointer)
            // named alone as the operand binds to that register; detected
            // before the parse, since its expression is indistinguishable
            // from `__builtin_frame_address(0)` afterwards.
            let bound_reg = self.asm_operand_bound_register()?;
            // `*(T (*)[N])p` reaches the array itself, which decays to the
            // element pointer (C99 6.3.2.1p3): the deref emits no node and the
            // accumulator already holds the object's address. The decay marker
            // distinguishes that from an ordinary rvalue.
            let saved_decay_bytes = core::mem::take(&mut self.pending.last_array_decay_bytes);
            self.expr(Token::Assign as i64)?;
            let decayed_array =
                core::mem::replace(&mut self.pending.last_array_decay_bytes, saved_decay_bytes) > 0;
            let width = self.size_of_type(self.ty).min(8) as u8;
            // `A` on a value too wide for one register would need the
            // `rdx:rax` pair, which this constraint does not model; rejecting
            // keeps it from silently using the low half.
            if cstr.trim_start_matches(['=', '+', '&', '%']) == "A"
                && !self.target.is_aarch64()
                && self.size_of_type(self.ty) > 8
            {
                self.data.truncate(data_base);
                return Err(self
                    .compile_err("inline asm: `A` operand wider than a register is unsupported"));
            }
            // The x86 `x` operand path moves a full 128-bit value (movups), so
            // it requires a 16-byte operand (a __m128i / vector). A scalar
            // float / double `x` operand is not yet supported and is rejected
            // rather than over-reading / over-writing its storage. AArch64 `w`
            // has its own (scalar-double) width check in the emitter.
            if matches!(constraint, AsmConstraint::Fp)
                && !self.target.is_aarch64()
                && self.size_of_type(self.ty) != 16
            {
                self.data.truncate(data_base);
                return Err(self
                    .compile_err("inline asm: only 16-byte (__m128i) `x` operands are supported"));
            }
            // A `register T v asm("reg")` variable used as a plain
            // register operand pins the operand to its named register --
            // the GNU-documented purpose of a local register variable.
            // TODO: the aarch64 asm surface is pattern-matched, not
            // constraint-based; pinning applies there once it is.
            let constraint = if let AsmConstraint::Reg = constraint
                && let Some(Expr::Ident { sym, .. }) = self.ast_acc.map(|a| self.ast.expr(a))
                && self.symbols[*sym as usize].class == Token::Loc as i64
                && let Some(crate::c5::symbol::AsmRegister::Gp(r)) =
                    self.symbols[*sym as usize].asm_register
            {
                // A register variable with storage keeps its slot; the
                // operand is pinned to the named register and the value
                // round-trips through the slot like any other operand.
                AsmConstraint::Fixed(r)
            } else if let (AsmConstraint::Reg, Some(r)) = (constraint, bound_reg) {
                // The stack / frame pointer has no storage behind it, so
                // the operand IS the register: nothing is loaded into it
                // and nothing is written back out of it.
                AsmConstraint::Bound(r)
            } else {
                constraint
            };
            // A bound operand names a register, which is its own storage:
            // there is no object to address and nothing to store back. Its
            // current value is carried in as a plain input so the operand
            // still occupies its `%N` slot. Writing such a variable is
            // rejected in the expression path, so an asm that leaves the
            // register changed is equally unsupported.
            let is_bound = matches!(constraint, AsmConstraint::Bound(_));
            let stores_back = is_output && !is_bound;
            let is_rw = is_rw && !is_bound;
            // Outputs pass the destination address; a memory operand (input or
            // output) is likewise reached through its address, so it must be an
            // lvalue. A non-lvalue (a call / cast / arithmetic result) is not
            // directly addressable; reject it with a diagnostic rather than
            // taking the address of an rvalue, which the walker cannot lower
            // (it would reach `walk_expr_lvalue`'s unsupported-expression path
            // as an internal error). Matches GCC ("... is not directly
            // addressable" / an output operand must be an lvalue). An empty
            // accumulator falls through to the "operand expression expected"
            // check below.
            if (is_output || matches!(constraint, AsmConstraint::Mem | AsmConstraint::MemBase))
                && !is_bound
            {
                let addressable = decayed_array
                    || match self.ast_acc {
                        Some(id) => {
                            use super::super::ast::Expr;
                            matches!(
                                self.ast.expr(id),
                                Expr::Ident { .. }
                                    | Expr::Index { .. }
                                    | Expr::Member { .. }
                                    | Expr::CompoundLiteral { .. }
                                    | Expr::Binary { .. }
                                    | Expr::Unary {
                                        op: UnOp::Deref,
                                        ..
                                    }
                            )
                        }
                        None => true,
                    };
                if !addressable {
                    self.data.truncate(data_base);
                    return Err(self.compile_err(if stores_back {
                        "inline asm: output operand must be an lvalue"
                    } else {
                        "inline asm: memory operand is not directly addressable (must be an lvalue)"
                    }));
                }
                // A decayed array operand is already an address; taking it
                // again would yield the address of the pointer value.
                if !decayed_array {
                    self.ty += Ty::Ptr as i64;
                    self.ast_apply_unary(UnOp::AddrOf);
                }
            }
            let e = match self.ast_acc.take() {
                Some(e) => e,
                None => {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("inline asm: operand expression expected"));
                }
            };
            // A range-restricted immediate constraint admits only an integer
            // constant within its range (GCC machine constraints). The
            // constraint resolved to a pure immediate, so there is no
            // register alternative to fall back on: a non-constant or
            // out-of-range operand cannot be satisfied. The letters and their
            // ranges are target-specific.
            if matches!(constraint, AsmConstraint::Imm) {
                let ibody = cstr.trim_start_matches(['=', '+', '&', '%']);
                let letter = if is_x86 {
                    Self::x86_imm_constraint_letter(ibody)
                } else {
                    Self::aarch64_imm_constraint_letter(ibody)
                };
                if let Some(letter) = letter {
                    let v = self.expr_const_int(e);
                    let accepts = |v| {
                        if is_x86 {
                            Self::x86_imm_constraint_accepts(letter, v)
                        } else {
                            Self::aarch64_imm_constraint_accepts(letter, v)
                        }
                    };
                    if !v.is_some_and(accepts) {
                        let range = if is_x86 {
                            Self::x86_imm_constraint_range_text(letter)
                        } else {
                            Self::aarch64_imm_constraint_range_text(letter)
                        };
                        return Err(self.compile_err(match v {
                            Some(v) => alloc::format!(
                                "inline asm: value {v} out of range for constraint \
                                 `{letter}` (expected {range})"
                            ),
                            None => alloc::format!(
                                "inline asm: constraint `{letter}` requires an \
                                 integer constant (expected {range})"
                            ),
                        }));
                    }
                }
            }
            operand_exprs.push(e);
            operand_names.push(op_name);
            operands.push(AsmOperand {
                constraint,
                is_output: stores_back,
                is_rw,
                width,
            });
            if is_output {
                n_outputs += 1;
            }
            if self.lex.tk != ')' {
                self.data.truncate(data_base);
                return Err(self.compile_err("inline asm: `)` expected after operand"));
            }
            self.next()?; // consume the operand's `)`
        }
        self.next()?; // consume the outer `)`
        self.consume(b';', "`;` expected after `asm(...)`")?;
        // Keep any operand data emitted above: a string-literal operand
        // (`"i"(__FILE__)`) is interned into `self.data` while lexing and its
        // offset is baked into the `Expr::StrLit` the walk lowers to an
        // `ImmData`; truncating here would leave that reference dangling. Only
        // the error paths roll the data back.

        // Every register operand is preserved across the statement.
        for (op, _) in operands.iter().zip(operand_exprs.iter()) {
            // A `Bound` operand is deliberately excluded: preserving the
            // register the asm was asked to see and affect would defeat
            // the binding.
            if let AsmConstraint::Fixed(r) | AsmConstraint::RegOrImm(r) = op.constraint {
                clobber_regs |= 1 << r;
            }
        }
        // Canonicalize `%[name]` / `%<modifier>[name]` operand references
        // to their positional `%N` / `%<modifier>N` forms while the names
        // are at hand, so the per-arch template parsers see one spelling.
        let template = if operand_names.iter().any(Option::is_some) {
            match Self::rewrite_named_operand_refs(&template, &operand_names) {
                Ok(t) => t,
                Err(m) => return Err(self.compile_err(m)),
            }
        } else {
            template
        };
        // `asm goto` requires a label list; canonicalize the template's
        // `%l[name]` / `%lN` references to label-list indices while the
        // names and operand count are at hand.
        let template = if is_goto {
            if label_ids.is_empty() {
                return Err(self.compile_err("inline asm goto: at least one label is required"));
            }
            match Self::rewrite_goto_label_refs(&template, &label_names, operands.len()) {
                Ok(t) => t,
                Err(m) => return Err(self.compile_err(m)),
            }
        } else {
            template
        };
        let block = AsmBlock {
            template,
            operands,
            clobber_regs,
            clobber_fp_regs,
            clobber_memory,
            volatile,
        };
        let idx = self.ast.asm_blocks.len() as u32;
        self.ast.asm_blocks.push(AsmBlockAst {
            block,
            operand_exprs,
            labels: label_ids,
        });
        self.mark_emit_other();
        if is_goto {
            // A statement with successors, not an expression: the
            // walker closes the block with `Terminator::AsmGoto`.
            self.flush_pending_stores();
            let pos = self.ast_src_pos();
            self.ast
                .push_stmt(super::super::ast::Stmt::AsmGoto(idx), pos);
            return Ok(());
        }
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::InlineAsm(idx), pos);
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// Canonicalize `asm goto` label references: `%l[name]` and `%lN`
    /// (GCC numbers labels after all operands) both become `%lK` with
    /// `K` the label-list index, so the per-arch template parsers need
    /// no operand-count context. Unknown names and out-of-range
    /// numbers are rejected here, where the source position is known.
    fn rewrite_goto_label_refs(
        template: &[u8],
        label_names: &[alloc::string::String],
        n_operands: usize,
    ) -> Result<alloc::vec::Vec<u8>, alloc::string::String> {
        let mut out: alloc::vec::Vec<u8> = alloc::vec::Vec::with_capacity(template.len());
        let mut i = 0usize;
        while i < template.len() {
            if template[i] != b'%' {
                out.push(template[i]);
                i += 1;
                continue;
            }
            if template.get(i + 1) == Some(&b'%') {
                out.extend_from_slice(&template[i..i + 2]);
                i += 2;
                continue;
            }
            if template.get(i + 1) != Some(&b'l') {
                out.push(template[i]);
                i += 1;
                continue;
            }
            if template.get(i + 2) == Some(&b'[') {
                let start = i + 3;
                let Some(len) = template[start..].iter().position(|&c| c == b']') else {
                    return Err(alloc::string::String::from(
                        "inline asm goto: unterminated `%l[` label reference",
                    ));
                };
                let name = core::str::from_utf8(&template[start..start + len]).unwrap_or("");
                let Some(k) = label_names.iter().position(|n| n == name) else {
                    return Err(alloc::format!(
                        "inline asm goto: `%l[{name}]` names no listed label"
                    ));
                };
                out.extend_from_slice(alloc::format!("%l{k}").as_bytes());
                i = start + len + 1;
                continue;
            }
            let ds = i + 2;
            let mut de = ds;
            while template.get(de).is_some_and(u8::is_ascii_digit) {
                de += 1;
            }
            if de == ds {
                return Err(alloc::string::String::from(
                    "inline asm goto: `%l` needs a number or `[name]`",
                ));
            }
            let n: usize = core::str::from_utf8(&template[ds..de])
                .ok()
                .and_then(|s| s.parse().ok())
                .ok_or_else(|| {
                    alloc::string::String::from("inline asm goto: bad `%l` label number")
                })?;
            if n < n_operands || n - n_operands >= label_names.len() {
                return Err(alloc::format!(
                    "inline asm goto: `%l{n}` is out of range \
                     ({n_operands} operands, {} labels)",
                    label_names.len()
                ));
            }
            out.extend_from_slice(alloc::format!("%l{}", n - n_operands).as_bytes());
            i = de;
        }
        Ok(out)
    }

    /// Canonicalize named operand references: `%[name]` and
    /// `%<modifier>[name]` (one modifier letter, e.g. `%c[x]` / `%w[x]`)
    /// become `%N` / `%<modifier>N` with `N` the operand's position.
    /// `%l[label]` is the `asm goto` label reference and is left for
    /// [`Self::rewrite_goto_label_refs`]. Unknown names are rejected here,
    /// where the source position is known.
    fn rewrite_named_operand_refs(
        template: &[u8],
        names: &[Option<alloc::string::String>],
    ) -> Result<alloc::vec::Vec<u8>, alloc::string::String> {
        let mut out: alloc::vec::Vec<u8> = alloc::vec::Vec::with_capacity(template.len());
        let mut i = 0usize;
        while i < template.len() {
            if template[i] != b'%' {
                out.push(template[i]);
                i += 1;
                continue;
            }
            if template.get(i + 1) == Some(&b'%') {
                out.extend_from_slice(&template[i..i + 2]);
                i += 2;
                continue;
            }
            // `%[name]` or `%<modifier>[name]`; `%l[` is a goto label.
            let (modifier, bstart) = match template.get(i + 1) {
                Some(&b'[') => (None, i + 2),
                Some(&m)
                    if m.is_ascii_alphabetic()
                        && m != b'l'
                        && template.get(i + 2) == Some(&b'[') =>
                {
                    (Some(m), i + 3)
                }
                _ => {
                    out.push(template[i]);
                    i += 1;
                    continue;
                }
            };
            let Some(len) = template[bstart..].iter().position(|&c| c == b']') else {
                return Err(alloc::string::String::from(
                    "inline asm: unterminated `%[` operand reference",
                ));
            };
            let name = core::str::from_utf8(&template[bstart..bstart + len]).unwrap_or("");
            let Some(n) = names.iter().position(|o| o.as_deref() == Some(name)) else {
                return Err(alloc::format!("inline asm: `%[{name}]` names no operand"));
            };
            out.push(b'%');
            if let Some(m) = modifier {
                out.push(m);
            }
            out.extend_from_slice(alloc::format!("{n}").as_bytes());
            i = bstart + len + 1;
        }
        Ok(out)
    }

    /// Classify a GCC operand constraint string into an
    /// [`ir::AsmConstraint`] and whether it is a read-write (`+`)
    /// output. `is_output` selects the output vs input grammar;
    /// `n_outputs` is the count of outputs already parsed, so a digit
    /// (matching) constraint resolves to an earlier output. `is_x86`
    /// selects the target-specific letters: the flag-output form on
    /// x86_64, `Q` on AArch64. Returns `None` for a constraint the
    /// codegen does not model.
    ///
    /// A constraint naming several alternatives (`rm`, `=qm`, `ri`) is
    /// satisfied by the register alternative whenever the constraint
    /// admits one, in both input and output position: a register
    /// operand is always a legal choice for such a constraint and needs
    /// no addressing-mode analysis to place. Only a constraint with no
    /// register alternative at all (`m`, `=m`) takes the memory path.
    /// The architectural register an asm operand binds to when the
    /// operand is exactly one identifier naming a storage-less
    /// `register T v asm("reg")` variable -- the stack or frame
    /// pointer. GCC guarantees such an operand is that register.
    ///
    /// On entry the operand's `(` is consumed. The lexer is left where
    /// it was: the operand is parsed normally afterwards, and only the
    /// constraint changes.
    ///
    /// A register variable with storage is not reported here; it keeps
    /// its slot and is pinned through `AsmConstraint::Fixed`.
    fn asm_operand_bound_register(&mut self) -> Result<Option<u8>, C5Error> {
        use crate::c5::symbol::AsmRegister as R;
        if self.lex.tk != Token::Id {
            return Ok(None);
        }
        let sym = self.lex.curr_id_idx;
        let reg = match self.symbols[sym].asm_register {
            Some(R::StackPointer) | Some(R::FramePointer)
                if self.symbols[sym].class == Token::Loc as i64 =>
            {
                self.symbols[sym].asm_register
            }
            _ => return Ok(None),
        };
        // Only a bare `(v)` binds; any larger expression is an ordinary
        // rvalue computed from the register's value.
        let snap = self.lex.snapshot();
        self.next()?;
        let bare = self.lex.tk == ')';
        self.lex.restore(snap);
        if !bare {
            return Ok(None);
        }
        if self.target.is_aarch64() {
            // TODO: the aarch64 asm surface is pattern-matched rather
            // than constraint-based, so a bound operand cannot be
            // resolved there yet. Reject instead of mis-encoding.
            return Err(self.compile_err(
                "inline asm: a stack- or frame-pointer register variable \
                 operand is not supported on this target",
            ));
        }
        let name = match reg {
            Some(R::StackPointer) => "rsp",
            Some(R::FramePointer) => "rbp",
            _ => return Ok(None),
        };
        Ok(super::super::codegen::x86_64::asm::reg_by_name(name).map(|(r, _)| r))
    }

    /// The x86 range-restricted immediate constraint letters (GCC "Machine
    /// Constraints", i386 family). Each admits only an integer constant in
    /// the stated range; `text` is the range as it appears in a diagnostic.
    /// `L` admits a three-value set rather than an interval, so it carries
    /// no bounds and is tested against [`X86_IMM_L_VALUES`]. The band
    /// `I`..`P` is reserved for machine-dependent immediates; x86 leaves
    /// `P` undefined, so it stays unrecognized here.
    const X86_IMM_CONSTRAINTS: &'static [(char, i64, i64, &'static str)] = &[
        // 32-bit shift counts.
        ('I', 0, 31, "0..31"),
        // 64-bit shift counts.
        ('J', 0, 63, "0..63"),
        // A signed 8-bit value.
        ('K', -128, 127, "-128..127"),
        // `lea` scale-factor shift counts.
        ('M', 0, 3, "0..3"),
        // An unsigned 8-bit value (`in` / `out` port numbers).
        ('N', 0, 255, "0..255"),
        // 128-bit shift counts.
        ('O', 0, 127, "0..127"),
    ];

    /// The values GCC's x86 `L` constraint admits: the and-masks that turn
    /// a masking `and` into a zero-extending move.
    const X86_IMM_L_VALUES: [i64; 3] = [0xFF, 0xFFFF, 0xFFFF_FFFF];

    /// The x86 range-restricted immediate letter `body` selects, if any.
    /// Only meaningful once the constraint has resolved to a pure
    /// immediate: a register or memory alternative alongside the letter
    /// (`"Ir"`) lets the operand be loaded, which lifts the restriction.
    fn x86_imm_constraint_letter(body: &str) -> Option<char> {
        body.chars()
            .find(|&c| c == 'L' || Self::X86_IMM_CONSTRAINTS.iter().any(|&(l, ..)| l == c))
    }

    /// True when `v` satisfies the x86 immediate constraint `letter`.
    pub(crate) fn x86_imm_constraint_accepts(letter: char, v: i64) -> bool {
        if letter == 'L' {
            return Self::X86_IMM_L_VALUES.contains(&v);
        }
        Self::X86_IMM_CONSTRAINTS
            .iter()
            .find(|&&(l, ..)| l == letter)
            .is_some_and(|&(_, lo, hi, _)| (lo..=hi).contains(&v))
    }

    /// The admissible values of the x86 immediate constraint `letter`,
    /// spelled for a diagnostic.
    fn x86_imm_constraint_range_text(letter: char) -> &'static str {
        if letter == 'L' {
            return "0xff, 0xffff or 0xffffffff";
        }
        Self::X86_IMM_CONSTRAINTS
            .iter()
            .find(|&&(l, ..)| l == letter)
            .map_or("", |&(.., text)| text)
    }

    /// The AArch64 range-restricted immediate letter `body` selects, if any
    /// (GCC machine constraints I, J, K, L, M, N). Only meaningful once the
    /// constraint has resolved to a pure immediate: a register or memory
    /// alternative alongside the letter (`"rI"`) lets the operand be loaded,
    /// which lifts the restriction. A multi-letter `U` / `D` / `v` class
    /// (`UsM`, `vsN`, `DL`) embeds these letters without being an immediate,
    /// so such bodies are excluded.
    fn aarch64_imm_constraint_letter(body: &str) -> Option<char> {
        if body.contains(['U', 'D', 'v']) {
            return None;
        }
        body.chars()
            .find(|c| matches!(c, 'I' | 'J' | 'K' | 'L' | 'M' | 'N'))
    }

    /// A 12-bit unsigned `add` / `sub` operand: the value fits the low 12
    /// bits, or the next 12 bits with a left shift of 12.
    fn aarch64_uimm12_shift(x: u64) -> bool {
        (x & !0xFFF) == 0 || (x & !0xFF_F000) == 0
    }

    /// A single-`movz` immediate: one non-zero 16-bit lane, the lane count
    /// being 2 for a 32-bit and 4 for a 64-bit move.
    fn aarch64_movz_imm(x: u64, is64: bool) -> bool {
        let lanes: u32 = if is64 { 4 } else { 2 };
        (0..lanes).any(|i| (x & !(0xFFFFu64 << (16 * i))) == 0)
    }

    /// A single-instruction `mov` immediate: `movz`, `movn` (the complement
    /// as a `movz`), or a logical bitmask (`orr` with the zero register).
    fn aarch64_mov_imm(x: u64, is64: bool) -> bool {
        let mask = if is64 { u64::MAX } else { 0xFFFF_FFFF };
        Self::aarch64_movz_imm(x, is64)
            || Self::aarch64_movz_imm(!x & mask, is64)
            || super::super::codegen::aarch64::table::encode_logical_imm(x, is64).is_some()
    }

    /// True when `v` satisfies the AArch64 immediate constraint `letter`
    /// (GCC machine constraints; validated against gcc 16 and clang 22).
    pub(crate) fn aarch64_imm_constraint_accepts(letter: char, v: i64) -> bool {
        use super::super::codegen::aarch64::table::encode_logical_imm;
        let u = v as u64;
        match letter {
            'I' => Self::aarch64_uimm12_shift(u),
            'J' => Self::aarch64_uimm12_shift(u.wrapping_neg()),
            'K' => encode_logical_imm(u & 0xFFFF_FFFF, false).is_some(),
            'L' => encode_logical_imm(u, true).is_some(),
            'M' => Self::aarch64_mov_imm(u & 0xFFFF_FFFF, false),
            'N' => Self::aarch64_mov_imm(u, true),
            _ => false,
        }
    }

    /// The admissible values of the AArch64 immediate constraint `letter`,
    /// spelled for a diagnostic.
    fn aarch64_imm_constraint_range_text(letter: char) -> &'static str {
        match letter {
            'I' => "a 12-bit unsigned value, optionally shifted left by 12 (add/sub)",
            'J' => "the negation of an `I` value (sub)",
            'K' => "a 32-bit logical-instruction bitmask",
            'L' => "a 64-bit logical-instruction bitmask",
            'M' => "a 32-bit move immediate",
            'N' => "a 64-bit move immediate",
            _ => "",
        }
    }

    pub(crate) fn parse_asm_constraint(
        cstr: &str,
        is_output: bool,
        n_outputs: usize,
        is_x86: bool,
    ) -> Option<(super::super::ir::AsmConstraint, bool)> {
        use super::super::ir::AsmConstraint;
        let is_rw = cstr.starts_with('+');
        let body = cstr.trim_start_matches(['=', '+', '&', '%']);
        // Flag output (`=@cc<cond>`): the block's condition flags are the
        // operand. Outputs only, and x86_64 only -- the condition names and
        // the `setcc` materialization are that target's.
        if let Some(cond) = body.strip_prefix("@cc") {
            // Write-only: the flags are produced by the template, so there is
            // no prior value to load, and `+` has no meaning here.
            if !is_output || !is_x86 || is_rw {
                return None;
            }
            let cc = super::super::codegen::x86_64::asm::flag_cond_code(cond)?;
            return Some((AsmConstraint::Flags(cc), is_rw));
        }
        // No other `@` form is modelled; without this the letters after it
        // would be read as ordinary class letters.
        if body.contains('@') {
            return None;
        }
        // AArch64 `Q`: a base-register-only memory operand. `Qo` / `Qm`
        // broaden it with the offsettable / any-memory classes; the operand's
        // address is captured into the base register and rendered `[xN]` for
        // every form, so all map alike. The x86 `Q` (the legacy high-byte
        // register class) is not modeled.
        if !is_x86 && body.contains('Q') && body.bytes().all(|c| matches!(c, b'Q' | b'o' | b'm')) {
            return Some((AsmConstraint::MemBase, is_rw));
        }
        // `p`: an address operand. The operand expression is a valid address
        // taken by value into a general register, so unlike `m` it accepts any
        // pointer-valued rvalue and forces no addressing mode. The `%a`
        // modifier renders that register as an address reference. Matched
        // exactly: the aarch64 `U`-prefixed memory classes spell their own
        // multi-letter names and must keep reaching the `m` path below.
        if body == "p" {
            return Some((AsmConstraint::Reg, is_rw));
        }
        // x86 `A`. On i386 this names the `edx:eax` pair; on x86-64 it is the
        // `a` or `d` register (a value wider than a register has no pair form
        // here and is rejected at the operand). GCC and clang both allocate
        // `rax` for it, which `Fixed(0)` spells.
        if is_x86 && body == "A" {
            return Some((AsmConstraint::Fixed(0), is_rw));
        }
        // A matching constraint ties an input to an earlier output.
        if let Some(d) = body.chars().find(|c| c.is_ascii_digit()) {
            let idx = d as u8 - b'0';
            if (idx as usize) < n_outputs {
                return Some((AsmConstraint::Match(idx), is_rw));
            }
            return None;
        }
        // Fixed-register class letters.
        let fixed = |c: char| -> Option<u8> {
            Some(match c {
                'a' => 0,
                'b' => 3,
                'c' => 1,
                'd' => 2,
                'S' => 6,
                'D' => 7,
                _ => return None,
            })
        };
        // `i` / `n` take any integer constant; the range-restricted letters
        // additionally bound its value, which the operand site checks once
        // the constant is in hand. The letters are target-specific: x86 and
        // aarch64 each give `I`..`N` their own ranges.
        let has_imm = body.contains(['i', 'n'])
            || (is_x86 && Self::x86_imm_constraint_letter(body).is_some())
            || (!is_x86 && Self::aarch64_imm_constraint_letter(body).is_some());
        // A memory-only constraint (`m`, `=m`, `+m`): the operand is accessed
        // through a memory reference. `g` / `rm` also permit memory but prefer
        // a register, which the register path below handles.
        if body.contains('m')
            && !body.contains(['r', 'q', 'g'])
            && !has_imm
            && !body
                .chars()
                .any(|c| matches!(c, 'a' | 'b' | 'c' | 'd' | 'S' | 'D'))
        {
            return Some((AsmConstraint::Mem, is_rw));
        }
        // A general-register alternative subsumes any specific-register or
        // FP letter alongside it: `"rax"` is the multi-alternative r|a|x,
        // not a register name, and GCC may satisfy it with any GP register.
        let has_general = body.contains(['r', 'q', 'g']);
        let has_reg = has_general || body.contains('m');
        // A specific-register letter (possibly combined with `i` as in
        // `ci`: the value takes that register, or an immediate).
        if !has_general && let Some(reg) = body.chars().find_map(fixed) {
            if has_imm {
                return Some((AsmConstraint::RegOrImm(reg), is_rw));
            }
            return Some((AsmConstraint::Fixed(reg), is_rw));
        }
        // A SIMD/FP-register value: AArch64 `w`, or x86 `x` (an XMM register).
        // Neither letter collides with the register/immediate/memory classes
        // handled above, so the mapping is target-independent; the backend
        // emitter reads the constraint to pick the v-register or xmm file.
        if !has_general && (body.contains('w') || body.contains('x')) {
            return Some((AsmConstraint::Fp, is_rw));
        }
        if has_reg {
            return Some((AsmConstraint::Reg, is_rw));
        }
        if has_imm && !is_output {
            return Some((AsmConstraint::Imm, is_rw));
        }
        None
    }

    /// The single-memory-operand asm forms (`fnstcw`/`fldcw`, `fxsave`,
    /// `sgdt`/`sidt`/`lgdt`/`lidt`/`sldt`/`str`, `clflush`). Each parses one
    /// `(operand)`; the intrinsic receives an address. When `by_address` is
    /// set the operand is a memory / register-held object and the op takes its
    /// address (the `m`/`=m`/`=r`/`=g` forms); otherwise the operand value is
    /// itself the address (`clflush`'s `"r"(ptr)` with a `(%0)` reference).
    /// Any constraint text is ignored.
    fn parse_single_operand_asm(
        &mut self,
        kind: super::super::op::Intrinsic,
        by_address: bool,
    ) -> Result<(), C5Error> {
        // Skip the colons and constraint strings up to the `(operand)`.
        while self.lex.tk != '(' as i64 && self.lex.tk != ')' as i64 {
            if self.lex.tk == ':' as i64 || self.lex.tk == ',' as i64 || self.lex.tk == '"' as i64 {
                self.next()?;
            } else {
                return Err(self.compile_err("unsupported single-operand asm operand"));
            }
        }
        if self.lex.tk != '(' as i64 {
            return Err(self.compile_err("single-operand asm expects one operand"));
        }
        self.next()?; // consume '('
        self.ast_psh();
        self.expr(Token::Assign as i64)?;
        if by_address {
            self.ty += Ty::Ptr as i64;
            self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
        }
        let addr_id = self.ast_acc.take();
        self.consume(b')', "`)` expected after asm operand")?;
        // Consume any remaining `: inputs : clobbers` up to the close.
        while self.lex.tk != ')' as i64 {
            self.next()?;
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")?;
        let Some(addr) = addr_id else {
            return Err(self.compile_err("single-operand asm operand missing"));
        };
        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            super::super::ast::Expr::Intrinsic {
                kind: kind as i64,
                args: alloc::vec![addr],
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// `asm("cpuid" : "=a"(o0),"=b"(o1),"=c"(o2),"=d"(o3) : "a"(leaf),"c"(sub))`
    /// and `asm("xgetbv" : "=a"(lo),"=d"(hi) : "c"(reg))`. Each operand is a
    /// register-letter constraint and a parenthesised expression: an output
    /// (`=`) contributes the destination's address, an input contributes its
    /// value. Operands are mapped by their constraint letter so the order
    /// they appear does not matter; the intrinsic args are then built in the
    /// fixed order the codegen expects. Each implicitly written register must
    /// be an output operand or a clobber; a clobbered register with no output
    /// operand stores to a synthesized scratch slot, and a cpuid with no `c`
    /// input runs with subleaf 0. On entry the template is consumed and the
    /// cursor is at the first `:`.
    fn parse_cpuid_xgetbv_asm(&mut self, is_cpuid: bool) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        // Register slot covered by a clobber name, indexed like `out`.
        fn clobber_reg_slot(name: &[u8]) -> Option<usize> {
            match name {
                b"rax" | b"eax" | b"ax" => Some(0),
                b"rbx" | b"ebx" | b"bx" => Some(1),
                b"rcx" | b"ecx" | b"cx" => Some(2),
                b"rdx" | b"edx" | b"dx" => Some(3),
                _ => None,
            }
        }
        // Indexed by register letter: a=0, b=1, c=2, d=3.
        let mut out: [Option<super::super::ast::ExprId>; 4] = [None; 4];
        let mut inp: [Option<super::super::ast::ExprId>; 4] = [None; 4];
        let mut clobbered = [false; 4];
        // Register slot of each output operand in declaration order, so a
        // matching constraint (`"0"` -> output operand 0's register) resolves.
        let mut out_order: alloc::vec::Vec<usize> = alloc::vec::Vec::new();
        // The asm grammar is `template : outputs : inputs : clobbers`, so a
        // colon precedes each section: section 1 is outputs, 2 is inputs.
        let mut section: u8 = 0;
        let data_base = self.data.len();
        while self.lex.tk != ')' {
            if self.lex.tk == ':' {
                section += 1;
                self.next()?;
                continue;
            }
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            if self.lex.tk != '"' {
                self.data.truncate(data_base);
                return Err(self.compile_err("unsupported cpuid / xgetbv asm syntax"));
            }
            // Constraint string: the last alphabetic byte is the register
            // letter (`=a` -> a). The lexer appended its bytes to the data
            // segment; read the letter, then drop them.
            let cstart = self.lex.ival as usize;
            // A clobber (the fourth section on) is a bare string with no
            // operand; record which implicit register it covers.
            if section >= 3 {
                if let Some(slot) = clobber_reg_slot(&self.data[cstart..]) {
                    clobbered[slot] = true;
                }
                self.next()?;
                self.data.truncate(cstart);
                continue;
            }
            let (letter, match_digit) = {
                let cbytes = &self.data[cstart..];
                let letter = cbytes
                    .iter()
                    .rev()
                    .find(|b| b.is_ascii_alphabetic())
                    .copied();
                // A digit-only constraint (`"0"` .. `"9"`) is a matching
                // constraint: the operand shares that output operand's
                // register.
                let digit = if letter.is_none() {
                    cbytes
                        .iter()
                        .find(|b| b.is_ascii_digit())
                        .map(|b| (b - b'0') as usize)
                } else {
                    None
                };
                (letter, digit)
            };
            self.next()?; // consume the constraint string
            self.data.truncate(cstart);
            let slot = match letter {
                Some(b'a') => 0usize,
                Some(b'b') => 1,
                Some(b'c') => 2,
                Some(b'd') => 3,
                _ => match match_digit.and_then(|d| out_order.get(d).copied()) {
                    Some(s) => s,
                    None => {
                        self.data.truncate(data_base);
                        return Err(self.compile_err("cpuid / xgetbv: unsupported asm constraint"));
                    }
                },
            };
            if section == 1 {
                out_order.push(slot);
            }
            if self.lex.tk != '(' {
                self.data.truncate(data_base);
                return Err(self.compile_err("cpuid / xgetbv: `(` expected after constraint"));
            }
            self.next()?; // consume `(`
            self.expr(Token::Assign as i64)?;
            if section == 1 {
                // Output: take the destination's address.
                self.ty += Ty::Ptr as i64;
                self.ast_apply_unary(UnOp::AddrOf);
                out[slot] = self.ast_acc.take();
            } else {
                inp[slot] = self.ast_acc.take();
            }
            if self.lex.tk != ')' {
                self.data.truncate(data_base);
                return Err(self.compile_err("cpuid / xgetbv: `)` expected after asm operand"));
            }
            self.next()?; // consume the operand's `)`
        }
        self.next()?; // consume the outer `)`
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.data.truncate(data_base);

        // Each implicitly written register must be captured by an output
        // operand or listed as a clobber; a clobber's value is discarded
        // into a synthesized scratch slot.
        let out_slots: &[usize] = if is_cpuid { &[0, 1, 2, 3] } else { &[0, 3] };
        for &slot in out_slots {
            if out[slot].is_none() {
                if !clobbered[slot] {
                    return Err(self.compile_err(
                        "cpuid / xgetbv: each implicitly written register \
                         (cpuid a,b,c,d; xgetbv a,d) must be an output \
                         operand or a clobber",
                    ));
                }
                out[slot] = Some(self.synth_scratch_addr());
            }
        }
        // A cpuid with no `c` operand runs the leaf's base form: every
        // leaf that reads ecx defines subleaf 0, so default the input.
        if is_cpuid && inp[2].is_none() {
            let pos = self.ast_src_pos();
            inp[2] = Some(self.ast.push_expr(
                Expr::IntLit {
                    val: 0,
                    ty: Ty::Int as i64,
                },
                pos,
            ));
        }

        // Build the args in the order the codegen reads them.
        let (kind, parts): (
            super::super::op::Intrinsic,
            [Option<super::super::ast::ExprId>; 6],
        ) = if is_cpuid {
            (
                super::super::op::Intrinsic::Cpuid,
                [out[0], out[1], out[2], out[3], inp[0], inp[2]],
            )
        } else {
            (
                super::super::op::Intrinsic::Xgetbv,
                [out[0], out[3], inp[2], None, None, None],
            )
        };
        let need = if is_cpuid { 6 } else { 3 };
        let mut args: alloc::vec::Vec<super::super::ast::ExprId> = alloc::vec::Vec::new();
        for p in parts.iter().take(need) {
            match p {
                Some(id) => args.push(*id),
                None => {
                    return Err(self.compile_err(
                        "cpuid requires an `a` (leaf) input; \
                         xgetbv requires a `c` input",
                    ));
                }
            }
        }

        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Intrinsic {
                kind: kind as i64,
                args,
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// Reserve a frame slot and yield its address, shaped as the address
    /// of an uninitialized `int` compound literal: the store target for an
    /// implicit asm output the source discards through a clobber.
    fn synth_scratch_addr(&mut self) -> super::super::ast::ExprId {
        use super::super::ast::{Expr, LocalInit, UnOp};
        let slot = self.reserve_slots(1);
        self.commit_block_slot(slot);
        let pos = self.ast_src_pos();
        let cl = self.ast.push_expr(
            Expr::CompoundLiteral {
                slot_off: slot,
                ty: Ty::Int as i64,
                array_size: 0,
                init: LocalInit::None,
            },
            pos,
        );
        self.ast.push_expr(
            Expr::Unary {
                op: UnOp::AddrOf,
                child: cl,
                ty: Ty::Int as i64 + Ty::Ptr as i64,
            },
            pos,
        )
    }

    /// Parse `asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1),
    /// "rm"(d))` (the `udiv_qrnnd` assembly-macro shape) into an
    /// `Intrinsic::Divq128`. The template mnemonic was already consumed.
    /// `"=a"` names the quotient output, `"=d"` the remainder output; the
    /// matching inputs `"0"` / `"1"` are the dividend's low / high halves
    /// and the remaining input is the divisor.
    fn parse_divq_asm(&mut self) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        let mut q_addr = None;
        let mut rem_addr = None;
        let mut n0 = None;
        let mut n1 = None;
        let mut divisor = None;
        let mut section: u8 = 0;
        let data_base = self.data.len();
        while self.lex.tk != ')' {
            if self.lex.tk == ':' {
                section += 1;
                self.next()?;
                continue;
            }
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            if self.lex.tk != '"' {
                self.data.truncate(data_base);
                return Err(self.compile_err("unsupported divq asm syntax"));
            }
            let cstart = self.lex.ival as usize;
            let (letter, digit) = {
                let cbytes = &self.data[cstart..];
                let letter = cbytes
                    .iter()
                    .rev()
                    .find(|b| b.is_ascii_alphabetic())
                    .copied();
                let digit = if letter.is_none() {
                    cbytes
                        .iter()
                        .find(|b| b.is_ascii_digit())
                        .map(|b| (b - b'0') as usize)
                } else {
                    None
                };
                (letter, digit)
            };
            self.next()?; // consume the constraint string
            self.data.truncate(cstart);
            if section >= 3 {
                continue; // clobbers carry no operand
            }
            if self.lex.tk != '(' {
                self.data.truncate(data_base);
                return Err(self.compile_err("divq: `(` expected after constraint"));
            }
            self.next()?; // consume `(`
            self.expr(Token::Assign as i64)?;
            if section == 1 {
                // Output: take the destination's address.
                self.ty += Ty::Ptr as i64;
                self.ast_apply_unary(UnOp::AddrOf);
                match letter {
                    Some(b'a') => q_addr = self.ast_acc.take(),
                    Some(b'd') => rem_addr = self.ast_acc.take(),
                    _ => {
                        self.data.truncate(data_base);
                        return Err(self.compile_err("divq: outputs must be `=a` and `=d`"));
                    }
                }
            } else {
                let v = self.ast_acc.take();
                match digit {
                    Some(0) => n0 = v, // matches the `=a` (rax) output
                    Some(1) => n1 = v, // matches the `=d` (rdx) output
                    _ => divisor = v,  // `rm` / `r` divisor
                }
            }
            if self.lex.tk != ')' {
                self.data.truncate(data_base);
                return Err(self.compile_err("divq: `)` expected after asm operand"));
            }
            self.next()?; // consume the operand's `)`
        }
        self.next()?; // consume the outer `)`
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.data.truncate(data_base);

        let (q, rem, n0, n1, d) = match (q_addr, rem_addr, n0, n1, divisor) {
            (Some(q), Some(rem), Some(n0), Some(n1), Some(d)) => (q, rem, n0, n1, d),
            _ => {
                return Err(
                    self.compile_err("divq requires `=a`,`=d` outputs and `0`,`1`,`rm` inputs")
                );
            }
        };
        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Intrinsic {
                kind: super::super::op::Intrinsic::Divq128 as i64,
                args: alloc::vec![q, rem, n0, n1, d],
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// Parse the operand lists of the AArch64 128-bit atomic inline asm --
    /// the `ldaxp`/`stlxp` RMW shapes and the `ldp`/`stp`, `ldxp`/`stxp`
    /// load / store shapes. GCC named operands (`[name] "constraint"(expr)`)
    /// are mapped by name and section, not position, since the layout
    /// differs across shapes: `mem`'s memory operand yields the object
    /// pointer; a register operand in the output section is a result lvalue
    /// (its address is taken), one in the input section is a value;
    /// `tmp`/`tmpl`/`tmph`/`t1`/`t2` are asm scratch with no C effect. The
    /// intrinsic args are `[ptr, out-addrs..., in-values...]`. On entry the
    /// template is consumed and the cursor is at the first `:`.
    fn parse_atomic128_asm(&mut self, kind: super::super::op::Intrinsic) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        use super::super::op::Intrinsic as I;
        // Role of a named operand, decided from its `[name]` spelling.
        enum Role {
            Mem,     // the 128-bit object, via a memory constraint
            Scratch, // asm-only temporary, no C effect
            Reg,     // register operand: address if output, value if input
        }
        let mut ptr = None;
        let mut out_addrs: alloc::vec::Vec<super::super::ast::ExprId> = alloc::vec::Vec::new();
        let mut in_vals: alloc::vec::Vec<super::super::ast::ExprId> = alloc::vec::Vec::new();
        let mut section: u8 = 0;
        let data_base = self.data.len();
        while self.lex.tk != ')' {
            if self.lex.tk == ':' {
                section += 1;
                self.next()?;
                continue;
            }
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            // GCC named operand: `[name]` precedes the constraint. Classify
            // by the identifier spelling before advancing past it.
            let mut role = Role::Reg;
            if self.lex.tk == Token::Brak {
                self.next()?; // `[`
                if self.lex.tk != Token::Id {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("128-bit atomic asm: operand name expected"));
                }
                role = match self.symbols[self.lex.curr_id_idx].name.as_str() {
                    "mem" => Role::Mem,
                    "tmp" | "tmpl" | "tmph" | "t1" | "t2" => Role::Scratch,
                    _ => Role::Reg,
                };
                self.next()?; // name
                self.consume(b']', "`]` expected after asm operand name")?;
            }
            if self.lex.tk != '"' {
                self.data.truncate(data_base);
                return Err(self.compile_err("unsupported 128-bit atomic asm operand"));
            }
            let cstart = self.lex.ival as usize;
            self.next()?; // consume the constraint string
            // Classify an unnamed operand by its constraint: a memory
            // constraint (`"m"` / `"+m"`) names the 128-bit object, matching
            // the `[mem]` role the named-operand shapes use. Register
            // constraints (`"r"` / `"=r"`) carry no `m`, so the positional
            // `ldp %0, %1, %2` shape resolves its `"m"(*ptr)` input correctly.
            if matches!(role, Role::Reg) && self.data[cstart..].contains(&b'm') {
                role = Role::Mem;
            }
            self.data.truncate(cstart);
            // The masked store-insert has no C output: its section-1 register
            // operands (`[f]`, `[l]`, `[h]`) are asm scratch, unlike the load
            // shapes whose section-1 `[l]`/`[h]` are result lvalues.
            if matches!(kind, I::Atomic128StoreInsert) && matches!(role, Role::Reg) && section == 1
            {
                role = Role::Scratch;
            }
            // Clobbers (fourth section on) are bare strings with no operand.
            if section >= 3 {
                continue;
            }
            if self.lex.tk != '(' {
                self.data.truncate(data_base);
                return Err(self.compile_err("128-bit atomic asm: `(` expected after constraint"));
            }
            self.next()?; // `(`
            self.expr(Token::Assign as i64)?;
            match role {
                // `"m"(*ptr)` / `"+m"(*ptr)`: &*ptr is the object pointer.
                Role::Mem => {
                    self.ty += Ty::Ptr as i64;
                    self.ast_apply_unary(UnOp::AddrOf);
                    ptr = self.ast_acc.take();
                }
                Role::Scratch => {
                    let _ = self.ast_acc.take();
                }
                // Output register: the loaded half is stored to this lvalue.
                Role::Reg if section == 1 => {
                    self.ty += Ty::Ptr as i64;
                    self.ast_apply_unary(UnOp::AddrOf);
                    match self.ast_acc.take() {
                        Some(id) => out_addrs.push(id),
                        None => {
                            self.data.truncate(data_base);
                            return Err(
                                self.compile_err("128-bit atomic asm: empty output operand")
                            );
                        }
                    }
                }
                // Input register: its value feeds the sequence.
                Role::Reg => match self.ast_acc.take() {
                    Some(id) => in_vals.push(id),
                    None => {
                        self.data.truncate(data_base);
                        return Err(self.compile_err("128-bit atomic asm: empty input operand"));
                    }
                },
            }
            if self.lex.tk != ')' {
                self.data.truncate(data_base);
                return Err(self.compile_err("128-bit atomic asm: `)` expected after operand"));
            }
            self.next()?; // operand `)`
        }
        self.next()?; // outer `)`
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.data.truncate(data_base);

        // Expected result-address and input-value counts per shape.
        let (want_out, want_in) = match kind {
            I::Atomic128CmpXchg => (2, 4),
            I::Atomic128Xchg | I::Atomic128FetchAnd | I::Atomic128FetchOr => (2, 2),
            I::Atomic128Load | I::Atomic128LoadEx => (2, 0),
            I::Atomic128Store | I::Atomic128StoreEx => (0, 2),
            // Masked store-insert: ptr + (vl, vh, ml, mh); no result address.
            I::Atomic128StoreInsert => (0, 4),
            _ => (0, 0),
        };
        let ptr = match ptr {
            Some(p) => p,
            None => return Err(self.compile_err("128-bit atomic asm: missing mem operand")),
        };
        if out_addrs.len() != want_out || in_vals.len() != want_in {
            return Err(self.compile_err("128-bit atomic asm: unexpected operand count"));
        }
        let mut args = alloc::vec::Vec::with_capacity(1 + want_out + want_in);
        args.push(ptr);
        args.extend_from_slice(&out_addrs);
        args.extend_from_slice(&in_vals);

        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Intrinsic {
                kind: kind as i64,
                args,
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// Parse `asm volatile("rdtsc" : "=a"(low), "=d"(high))` into an
    /// `Intrinsic::Rdtsc`. The template was
    /// already consumed. `"=a"` names the low 32 bits, `"=d"` the high.
    fn parse_rdtsc_asm(&mut self) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        let mut low_addr = None;
        let mut high_addr = None;
        let mut section: u8 = 0;
        let data_base = self.data.len();
        while self.lex.tk != ')' {
            if self.lex.tk == ':' {
                section += 1;
                self.next()?;
                continue;
            }
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            if self.lex.tk != '"' {
                self.data.truncate(data_base);
                return Err(self.compile_err("unsupported rdtsc asm syntax"));
            }
            let cstart = self.lex.ival as usize;
            let letter = self.data[cstart..]
                .iter()
                .rev()
                .find(|b| b.is_ascii_alphabetic())
                .copied();
            self.next()?; // consume the constraint string
            self.data.truncate(cstart);
            if section >= 3 {
                continue; // clobbers
            }
            if section != 1 {
                self.data.truncate(data_base);
                return Err(self.compile_err("rdtsc takes no input operands"));
            }
            if self.lex.tk != '(' {
                self.data.truncate(data_base);
                return Err(self.compile_err("rdtsc: `(` expected after constraint"));
            }
            self.next()?; // consume `(`
            self.expr(Token::Assign as i64)?;
            self.ty += Ty::Ptr as i64;
            self.ast_apply_unary(UnOp::AddrOf);
            match letter {
                Some(b'a') => low_addr = self.ast_acc.take(),
                Some(b'd') => high_addr = self.ast_acc.take(),
                _ => {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("rdtsc: outputs must be `=a` and `=d`"));
                }
            }
            if self.lex.tk != ')' {
                self.data.truncate(data_base);
                return Err(self.compile_err("rdtsc: `)` expected after asm operand"));
            }
            self.next()?; // consume the operand's `)`
        }
        self.next()?; // consume the outer `)`
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.data.truncate(data_base);

        let (low, high) = match (low_addr, high_addr) {
            (Some(l), Some(h)) => (l, h),
            _ => return Err(self.compile_err("rdtsc requires `=a` and `=d` outputs")),
        };
        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Intrinsic {
                kind: super::super::op::Intrinsic::Rdtsc as i64,
                args: alloc::vec![low, high],
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// `asm volatile("mrs %0, ctr_el0" : "=r"(out))`, `asm volatile("dc
    /// cvau, %0" :: "r"(p) : "memory")`, or the `ic ivau` form -- one
    /// register operand. An output (`is_output`) contributes the
    /// destination's address (the read is stored through it); an input
    /// contributes its value. The template was consumed; the cursor is at
    /// the first `:`.
    fn parse_aarch64_reg_asm(
        &mut self,
        kind: super::super::op::Intrinsic,
        is_output: bool,
    ) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        // Skip the colons and constraint strings up to the `(operand)`.
        while self.lex.tk != '(' as i64 && self.lex.tk != ')' as i64 {
            if self.lex.tk == ':' as i64 || self.lex.tk == ',' as i64 || self.lex.tk == '"' as i64 {
                self.next()?;
            } else {
                return Err(self.compile_err("unsupported aarch64 asm operand"));
            }
        }
        if self.lex.tk != '(' as i64 {
            return Err(self.compile_err("aarch64 asm expects one register operand"));
        }
        self.next()?; // consume '('
        self.expr(Token::Assign as i64)?;
        if is_output {
            // The read is stored through the output operand's address.
            self.ty += Ty::Ptr as i64;
            self.ast_apply_unary(UnOp::AddrOf);
        }
        let arg_id = self.ast_acc.take();
        self.consume(b')', "`)` expected after aarch64 asm operand")?;
        // Consume any remaining `: inputs : clobbers` up to the close.
        while self.lex.tk != ')' {
            self.next()?;
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")?;
        let Some(arg) = arg_id else {
            return Err(self.compile_err("aarch64 asm operand missing"));
        };
        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Intrinsic {
                kind: kind as i64,
                args: alloc::vec![arg],
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    /// `asm volatile("dsb ish" ::: "memory")` / `asm volatile("isb" :::
    /// "memory")` -- a barrier with clobbers but no in/out operands. Consume
    /// the operand region and emit the fixed intrinsic. The template was
    /// consumed; the cursor is at the first `:` (or `)`).
    fn parse_aarch64_barrier_asm(
        &mut self,
        kind: super::super::op::Intrinsic,
    ) -> Result<(), C5Error> {
        // A barrier carries no in/out operand; a `(` would introduce one.
        while self.lex.tk != ')' {
            if self.lex.tk == '(' {
                return Err(self.compile_err("aarch64 barrier asm takes no operands"));
            }
            self.next()?;
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.mark_emit_other();
        self.ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            super::super::ast::Expr::Intrinsic {
                kind: kind as i64,
                args: alloc::vec::Vec::new(),
                ty: Ty::Int as i64,
            },
            pos,
        );
        self.ast_acc = Some(id);
        let _ = self.ast_emit_expr_stmt();
        Ok(())
    }

    pub(super) fn stmt(&mut self) -> Result<(), C5Error> {
        self.with_nesting("statement", |c| c.stmt_inner())
    }

    fn stmt_inner(&mut self) -> Result<(), C5Error> {
        // Function-pointer callee parameters captured for a postfix
        // indirect call never span a statement: drop any left set by a
        // producer whose call did not consume them so they cannot reach an
        // unrelated call in a later statement.
        self.pending.indirect_callee_params = None;
        self.pending.indirect_callee_is_variadic = false;
        // The function-pointer-decay depth (C99 6.3.2.1p4) is intra-
        // expression state: a function name used as a call argument seeds
        // it, and without this reset it leaks into the next statement's
        // unary `*`, which would mis-apply the decay no-op and drop the
        // load an assignment lvalue needs.
        self.pending.fn_ptr_chain_depth = -1;
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b':') {
            let name = self.resolve_label_name(&self.symbols[self.lex.curr_id_idx].name.clone());
            // C99 6.8.1p3: a label name must be unique within its
            // function (constraint), and a `__label__` name within the
            // block that declares it. Two labeled statements with the
            // same name would intern one SSA block and re-terminate it
            // in the walker.
            if self.labels.iter().any(|n| n == &name) {
                return Err(self.compile_err(format!(
                    "redefinition of label `{}`",
                    super::emit::label_display_name(&name)
                )));
            }
            self.labels.push(name.clone());
            let label = self.ast_label_by_name(&name);
            self.next()?; // consume Id
            self.next()?; // consume ':'
            let body_before = self.ast_stmts_snapshot();
            self.stmt()?;
            let body_s = self.ast_wrap_stmts_since(body_before);
            self.ast_emit_labeled(label, body_s);
            return Ok(());
        }

        if self.lex.tk == Token::Asm {
            return self.parse_asm_stmt();
        }

        if self.lex.tk == Token::If {
            // Capture the `if` keyword position before consuming
            // the rest of the statement; `ast_src_pos()` advances
            // with the lexer.
            let if_pos = self.ast_src_pos();
            self.next()?;
            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
            let cond_id = self.ast_acc;
            self.consume(b')', "close paren expected")?;
            self.flush_pending_stores();
            let then_before = self.ast_stmts_snapshot();
            self.stmt()?;
            let then_s = self.ast_wrap_stmts_since(then_before);
            let else_s = if self.lex.tk == Token::Else {
                self.flush_pending_stores();
                self.next()?;
                let else_before = self.ast_stmts_snapshot();
                self.stmt()?;
                let id = self.ast_wrap_stmts_since(else_before);
                Some(id)
            } else {
                None
            };
            if let Some(cond) = cond_id {
                self.ast_emit_if(cond, then_s, else_s, if_pos);
            }
        } else if self.lex.tk == Token::While {
            self.next()?;
            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
            let cond_id = self.ast_acc;
            self.consume(b')', "close paren expected")?;
            self.flush_pending_stores();

            self.enter_loop();
            let body_before = self.ast_stmts_snapshot();
            self.stmt()?;
            let body_s = self.ast_wrap_stmts_since(body_before);
            self.close_loop_continues();

            self.flush_pending_stores();

            self.close_loop_breaks();
            if let Some(cond) = cond_id {
                self.ast_emit_while(cond, body_s);
            }
        } else if self.lex.tk == Token::Do {
            self.next()?;

            self.enter_loop();
            let body_before = self.ast_stmts_snapshot();
            self.stmt()?;
            let body_s = self.ast_wrap_stmts_since(body_before);

            if self.lex.tk == Token::While {
                self.next()?;
            } else {
                return Err(self.compile_err("while expected after do"));
            }

            self.close_loop_continues();

            self.consume(b'(', "open paren expected")?;
            self.parse_full_expr()?;
            let cond_id = self.ast_acc;
            self.consume(b')', "close paren expected")?;

            self.flush_pending_stores();

            self.consume(b';', "semicolon expected after do-while")?;

            self.close_loop_breaks();
            if let Some(cond) = cond_id {
                self.ast_emit_do_while(body_s, cond);
            }
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
            let lo = self.parse_constant_int()?;
            // GNU case range `case lo ... hi:` (C extension): the label
            // covers every value in [lo, hi]. `hi == lo` for a single label.
            let hi = if self.lex.tk == Token::Ellipsis {
                self.next()?;
                self.parse_constant_int()?
            } else {
                lo
            };
            self.consume(b':', "expected colon after case")?;
            if hi < lo {
                return Err(self.compile_err(format!(
                    "case range `{lo} ... {hi}` is empty (low bound exceeds high)"
                )));
            }
            // C99 6.8.4.2p3: the case constant expressions in one switch
            // must be distinct (constraint). A single label is tracked for
            // duplicate detection; a `lo ... hi` range is dispatched by a
            // bounds comparison (walk.rs) with no per-value expansion, so it
            // is not enumerated here and an overlap involving a range is not
            // diagnosed (a permitted relaxation of the constraint check).
            match self.switch_cases.last_mut() {
                Some(cases) => {
                    if lo == hi {
                        if cases.contains(&lo) {
                            return Err(
                                self.compile_err(format!("duplicate case value {lo} in switch"))
                            );
                        }
                        cases.push(lo);
                    }
                }
                None => return Err(self.compile_err("case outside switch")),
            }
            let body_before = self.ast_stmts_snapshot();
            // C23 6.8.1: a label may precede a declaration. badc parses
            // block-local declarations in the enclosing block loop, where
            // scope is tracked, so a case whose body is a declaration is
            // given an empty body and the declaration is parsed as the
            // next block item; a preceding case still falls through into it.
            if !(self.lex.tk == Token::Typedef
                || self.lex.tk == Token::StaticAssert
                || self.lex_is_type_start())
            {
                self.stmt()?;
            }
            let body_s = self.ast_wrap_stmts_since(body_before);
            self.ast_emit_case(lo, hi, body_s);
        } else if self.lex.tk == Token::Default {
            self.next()?;
            self.consume(b':', "expected colon after default")?;
            // C99 6.8.4.2p3: at most one default label per switch
            // (constraint). A second default would resolve to the first's
            // block and re-terminate it in the walker.
            let dup_default = match self.switch_defaults.last_mut() {
                Some(def) => {
                    let seen = *def;
                    *def = true;
                    seen
                }
                None => return Err(self.compile_err("default outside switch")),
            };
            if dup_default {
                return Err(self.compile_err("multiple default labels in one switch"));
            }
            let body_before = self.ast_stmts_snapshot();
            // C23 6.8.1: a declaration may follow the `default` label;
            // give the label an empty body and let the enclosing block
            // loop parse the declaration with correct scope.
            if !(self.lex.tk == Token::Typedef
                || self.lex.tk == Token::StaticAssert
                || self.lex_is_type_start())
            {
                self.stmt()?;
            }
            let body_s = self.ast_wrap_stmts_since(body_before);
            self.ast_emit_default(body_s);
        } else if self.lex.tk == Token::Goto {
            self.next()?;
            if self.lex.tk == Token::MulOp {
                // GCC computed goto: `goto *expr;` branches to the
                // label address that `expr` evaluates to.
                self.next()?; // consume '*'
                self.parse_full_expr()?;
                let target = self.ast_acc;
                self.flush_pending_stores();
                self.consume(b';', "semicolon expected after computed goto")?;
                if let Some(t) = target {
                    self.ast_emit_goto_indirect(t);
                }
            } else {
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("expected identifier after goto"));
                }
                let target_name =
                    self.resolve_label_name(&self.symbols[self.lex.curr_id_idx].name.clone());
                self.next()?;

                self.flush_pending_stores();

                if !self.labels.iter().any(|n| n == &target_name) {
                    self.unresolved_gotos.push(target_name.clone());
                }

                self.consume(b';', "semicolon expected after goto")?;
                let label = self.ast_label_by_name(&target_name);
                self.ast_emit_goto(label);
            }
        } else if self.lex.tk == Token::Break {
            self.next()?;
            if self.loop_break_depth == 0 {
                return Err(self.compile_err("break outside of loop or switch"));
            }
            self.flush_pending_stores();
            self.consume(b';', "semicolon expected after break")?;
            // Run the cleanup functions of every scope opened inside the
            // loop / switch being left (C++-style scope-exit order).
            let start = self.ast.stmts.len();
            let depth = self.break_cleanup_depths.last().copied().unwrap_or(0);
            self.emit_cleanups_above(depth);
            self.ast_emit_break();
            self.coalesce_exit_since(start);
        } else if self.lex.tk == Token::Continue {
            self.next()?;
            if self.loop_continue_depth == 0 {
                return Err(self.compile_err("continue outside of loop"));
            }
            self.flush_pending_stores();
            self.consume(b';', "semicolon expected after continue")?;
            let start = self.ast.stmts.len();
            let depth = self.continue_cleanup_depths.last().copied().unwrap_or(0);
            self.emit_cleanups_above(depth);
            self.ast_emit_continue();
            self.coalesce_exit_since(start);
        } else if self.lex.tk == Token::Return {
            let line = self.lex.line;
            self.next()?;
            let ret_ty = self.current_func_return_ty;
            let returns_struct = is_struct_ty(ret_ty) && struct_ptr_depth(ret_ty) == 0;
            let returns_void = self.current_func_returns_void;
            let mut return_value: Option<super::super::ast::ExprId> = None;
            if self.lex.tk != ';' {
                if returns_void {
                    // `return <expr>;` in a void function: C allows a
                    // void-typed expression (gcc/clang accept it); c5 has
                    // no void type tag, so evaluate it for side effects
                    // and return no value.
                    self.parse_full_expr()?;
                    return_value = self.ast_acc;
                } else if returns_struct {
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
                    self.mark_emit_other();
                    self.ast_psh();
                    self.expr(Token::Assign as i64)?;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(self.compile_err(
                            "returning a non-struct value from a \
                             struct-returning function",
                        ));
                    }
                    // C99 6.8.6.4p3: the returned value is converted as
                    // if by assignment. Diagnose a return of an
                    // incompatible struct type, matching the assignment
                    // path.
                    if let Some(reason) = Self::type_warning(&self.structs, ret_ty, self.ty, false)
                    {
                        let want = super::types::format_type(ret_ty, &self.structs);
                        let got = super::types::format_type(self.ty, &self.structs);
                        self.warn_at(
                            line,
                            format!("{reason} in return (declared={want}, returned={got})"),
                        );
                    }
                    self.mark_emit_other();
                    // Mirror the rhs expression into the walker's
                    // `Stmt::Return(Some(_))` so the AST-driven
                    // SSA sees the source struct and can emit the
                    // Mcpy into the slot-2 out-pointer: load slot
                    // 2, copy `size_of(ret_ty)` bytes from the
                    // source expression's address into it, then
                    // return.
                    return_value = self.ast_acc;
                } else {
                    self.parse_full_expr()?;
                    // C99 6.8.6.4p3 + 6.5.16.1: the value is converted
                    // to the return type as if by assignment. Diagnose
                    // the same incompatible pointer / integer cases the
                    // assignment path flags, before the conversion
                    // rewrites `self.ty`.
                    let rhs_is_zero = self.last_emit_is_zero();
                    let rhs_is_untyped = self.last_emit_was_indirect_call();
                    if let Some(reason) = Self::type_warning_with_flags(
                        &self.structs,
                        ret_ty,
                        self.ty,
                        rhs_is_zero,
                        rhs_is_untyped,
                    ) {
                        let want = super::types::format_type(ret_ty, &self.structs);
                        let got = super::types::format_type(self.ty, &self.structs);
                        self.warn_at(
                            line,
                            format!("{reason} in return (declared={want}, returned={got})"),
                        );
                    }
                    // Reuse `convert_assign_rhs` so an `int`-typed
                    // `return` from a `double`-returning function lifts
                    // through the int-to-float cast rather than landing
                    // the integer's bit pattern in the FP slot.
                    self.convert_assign_rhs(ret_ty);
                    return_value = self.ast_acc;
                }
            } else if returns_void {
                // Bare `return;` in a void function. Zero the
                // accumulator so a downstream peek detector that
                // examines the trailing emit sees a predictable
                // value, matching the synthetic function-end Lev
                // in run_compile.
                self.emit_imm(0);
            } else {
                // Bare `return;` in a function returning non-void.
                // C99 leaves the returned value indeterminate (6.9.1p12
                // -- undefined behaviour if the caller uses it); C23
                // 6.8.6.4 and every current toolchain reject it. Error.
                return Err(
                    self.compile_err("`return` with no value in a function returning non-void")
                );
            }
            self.emit_dead_stores_and_flush();
            // Run every enclosing scope's `__attribute__((cleanup))`
            // functions before leaving the function. C's scope-exit order
            // evaluates the returned value first, so spill a returned value
            // to a temporary and run the cleanups between its evaluation
            // and the return; a void return's expression is evaluated for
            // side effects first, then discarded.
            let start = self.ast.stmts.len();
            if self.has_cleanups_above(0) {
                if returns_void {
                    if let Some(v) = return_value {
                        let pos = self.ast_src_pos();
                        self.ast.push_stmt(super::super::ast::Stmt::Expr(v), pos);
                        return_value = None;
                    }
                } else if let Some(v) = return_value {
                    return_value = Some(self.spill_expr_to_temp(v, ret_ty));
                }
                self.emit_cleanups_above(0);
            }
            self.ast_emit_return(return_value);
            self.coalesce_exit_since(start);
            self.consume(b';', "semicolon expected")?;
        } else if self.lex.tk == '{' {
            self.parse_block_stmt()?;
        } else if self.lex.tk == ';' {
            self.next()?;
        } else {
            self.parse_full_expr()?;
            // C99 6.8.3 expression statement: bind the parsed
            // expression's id to a `Stmt::Expr` so the walker
            // descends through it. No-op when the expression
            // shape has no AST-side dual-emit yet.
            let _ = self.ast_emit_expr_stmt();
            self.consume(b';', "semicolon expected")?;
        }
        Ok(())
    }

    /// Advance past the current token when it equals `t`; return
    /// whether it matched. Generic over the comparison so callers pass
    /// a `Token` or a single-byte char, as `consume` does.
    pub(super) fn accept<T>(&mut self, t: T) -> Result<bool, C5Error>
    where
        Tok: PartialEq<T>,
    {
        if self.lex.tk == t {
            self.next()?;
            Ok(true)
        } else {
            Ok(false)
        }
    }

    /// Consume the separator between declarators of one declaration.
    /// C99 6.7p1: an init-declarator-list is comma-separated and the
    /// declaration ends at `;`. A declarator followed by anything else --
    /// typically a second identifier, which is how an unrecognized type
    /// qualifier reads -- is a syntax error, not the start of another
    /// declarator.
    pub(super) fn accept_declarator_separator(&mut self) -> Result<(), C5Error> {
        if self.lex.tk == ',' {
            self.next()?;
        } else if self.lex.tk != ';' && self.lex.tk != '}' && self.lex.tk != 0 {
            return Err(self.compile_err(alloc::format!(
                "expected `,` or `;` after declarator (got {})",
                super::super::token::describe(self.lex.tk)
            )));
        }
        Ok(())
    }

    /// Capture the data-segment offset of the current string literal,
    /// then step past it and any adjacent string literals (the lexer
    /// has already concatenated their bytes into one run, C99 5.1.1.2).
    /// Returns the offset of the first byte.
    pub(super) fn take_concat_string_literal(&mut self) -> Result<usize, C5Error> {
        let start = self.lex.ival as usize;
        self.next()?;
        while self.lex.tk == '"' {
            self.next()?;
        }
        Ok(start)
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
