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
            if init_after > init_before {
                let ids: alloc::vec::Vec<super::super::ast::StmtId> = (init_before..init_after)
                    .map(|i| i as super::super::ast::StmtId)
                    .collect();
                let id = self.ast_wrap_block_items(&ids);
                init_ast = Some(super::super::ast::BlockItem::Stmt(id));
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
        self.ast_emit_for(init_ast, cond_ast, post_ast, body_s);

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

            self.accept(',')?;
        }
        self.next()?;
        Ok(())
    }

    /// `{ ... }`. C99 block-scope: declarations may appear anywhere a
    /// statement may. Each declaration's bindings shadow outer
    /// symbols for the duration of the block and are restored on
    /// exit.
    fn parse_block_stmt(&mut self) -> Result<super::super::ast::StmtId, C5Error> {
        self.next()?;
        // C99 6.2.1: a block introduces a new scope for struct,
        // union, and enum tags. Tag bindings declared in this block
        // shadow same-named tags in any enclosing scope and go out of
        // scope when the block exits.
        self.tag_scopes.push(alloc::vec::Vec::new());
        let mut block_symbols = Vec::new();

        let mut top_level_ids: alloc::vec::Vec<super::super::ast::StmtId> = alloc::vec::Vec::new();
        // C99 6.2.4p2: a VLA declared directly in this block has its
        // storage reclaimed on block exit. Track whether any appears so
        // the block is bracketed with the alloca-arena save / restore.
        let mut block_has_vla = false;
        while self.lex.tk != '}' {
            // C23 6.7.13 / 6.8: an attribute-specifier-sequence may
            // lead either a declaration or a statement at block scope.
            // Consume it, then dispatch on the following token.
            let mut leading_maybe_unused = false;
            if self.lex.tk == Token::Attribute
                || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
            {
                self.pending.attr_maybe_unused = false;
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
        // C99 6.2.4p2: bracket a VLA-declaring block so the arena top
        // is snapshotted on entry and restored on exit, reclaiming the
        // VLA storage (per iteration when the block is a loop body).
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
        let block = self.parse_block_stmt()?;
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

    /// Parse a GCC inline-asm statement. c5 supports the operand-free
    /// forms: an empty template (a compiler barrier, no instruction
    /// emitted) and a single known operand-free hint instruction
    /// (`pause` / `yield`, lowered to the target spin-loop hint).
    /// Operand constraints and other instructions are rejected.
    fn parse_asm_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?; // asm / __asm__ / __asm
        // Optional qualifiers (`volatile` / `__volatile__`, `inline`,
        // `goto`). c5 acts on none of them.
        while self.lex.tk == Token::TypeQual || self.lex.tk == Token::Inline {
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
        // The x87 FPU control-word forms carry exactly one memory operand.
        // Detect them from the template before the operand-rejection loop.
        let tmpl_lc = core::str::from_utf8(&template)
            .unwrap_or("")
            .trim()
            .trim_end_matches(';')
            .trim()
            .to_ascii_lowercase();
        let x87_kind = match tmpl_lc.as_str() {
            "fnstcw %0" => Some(super::super::op::Intrinsic::X87StoreControlWord),
            "fldcw %0" => Some(super::super::op::Intrinsic::X87LoadControlWord),
            _ => None,
        };
        if let Some(kind) = x87_kind {
            self.data.truncate(tstart);
            return self.parse_x87_control_word_asm(kind);
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
        // no-unroll / clobber idiom `__asm__("" :: "r"(p))`. It emits no
        // instruction, so its operands carry no machine effect; consume
        // the whole `: outputs : inputs : clobbers` region (operand
        // expressions included) and emit nothing. c5 does not reorder
        // memory accesses across the statement.
        if tmpl_lc.is_empty() {
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
            self.consume(b';', "`;` expected after `asm(...)`")?;
            self.data.truncate(tstart);
            return Ok(());
        }
        // Optional `: outputs : inputs : clobbers`. An operand binding
        // (`"constraint"(expr)`) introduces a `(` and is rejected; bare
        // clobber strings and the separating colons are accepted.
        while self.lex.tk != ')' {
            if self.lex.tk == '(' {
                self.data.truncate(tstart);
                return Err(self.compile_err("inline asm operands are not supported"));
            }
            if self.lex.tk == ':' || self.lex.tk == ',' || self.lex.tk == '"' {
                self.next()?;
                continue;
            }
            self.data.truncate(tstart);
            return Err(self.compile_err("unsupported inline asm syntax"));
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")?;
        self.data.truncate(tstart);
        let t = core::str::from_utf8(&template)
            .unwrap_or("")
            .trim()
            .trim_end_matches(';')
            .trim()
            .to_ascii_lowercase();
        // The spin-loop hint appears as `pause` / `yield` (x86 / arm) or
        // the `rep; nop` byte encoding of PAUSE on x86; normalize away the
        // whitespace and `;` so every spelling maps to the relax hint.
        let compact: alloc::string::String = t
            .chars()
            .filter(|c| !c.is_whitespace() && *c != ';')
            .collect();
        if compact == "pause" || compact == "yield" || compact == "repnop" {
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
        Err(self.compile_err(format!("inline asm instruction `{t}` is not supported")))
    }

    /// `asm("fnstcw %0":"=m"(cw))` / `asm("fldcw %0"::"m"(cw))` -- the two
    /// x87 control-word forms floating-point code reaches for. Parse the
    /// single memory operand, take its address, and emit the matching
    /// intrinsic. The constraint text is ignored: both forms reach the
    /// op as the operand's address.
    fn parse_x87_control_word_asm(
        &mut self,
        kind: super::super::op::Intrinsic,
    ) -> Result<(), C5Error> {
        // Skip the colons and constraint strings up to the `(operand)`.
        while self.lex.tk != '(' as i64 && self.lex.tk != ')' as i64 {
            if self.lex.tk == ':' as i64 || self.lex.tk == ',' as i64 || self.lex.tk == '"' as i64 {
                self.next()?;
            } else {
                return Err(self.compile_err("unsupported x87 control-word asm operand"));
            }
        }
        if self.lex.tk != '(' as i64 {
            return Err(self.compile_err("x87 control-word asm expects a memory operand"));
        }
        self.next()?; // consume '('
        self.ast_psh();
        self.expr(Token::Assign as i64)?;
        self.ty += Ty::Ptr as i64;
        self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
        let addr_id = self.ast_acc.take();
        self.consume(b')', "`)` expected after x87 asm operand")?;
        // Consume any remaining `: inputs : clobbers` up to the close.
        while self.lex.tk != ')' as i64 {
            self.next()?;
        }
        self.next()?; // consume ')'
        self.consume(b';', "`;` expected after `asm(...)`")?;
        let Some(addr) = addr_id else {
            return Err(self.compile_err("x87 control-word asm operand missing"));
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
    /// fixed order the codegen expects. On entry the template is consumed and
    /// the cursor is at the first `:`.
    fn parse_cpuid_xgetbv_asm(&mut self, is_cpuid: bool) -> Result<(), C5Error> {
        use super::super::ast::{Expr, UnOp};
        // Indexed by register letter: a=0, b=1, c=2, d=3.
        let mut out: [Option<super::super::ast::ExprId>; 4] = [None; 4];
        let mut inp: [Option<super::super::ast::ExprId>; 4] = [None; 4];
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
            // A clobber (the fourth section on) is a bare string with no
            // operand; skip it.
            if section >= 3 {
                continue;
            }
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
                        "cpuid requires =a,=b,=c,=d outputs with a,c inputs; \
                         xgetbv requires =a,=d outputs with a c input",
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
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            // C99 6.8.1p3: a label name must be unique within its
            // function (constraint). Two labeled statements with the same
            // name would intern one SSA block and re-terminate it in the
            // walker.
            if self.labels.iter().any(|n| n == &name) {
                return Err(self.compile_err(format!("redefinition of label `{name}`")));
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
                let target_name = self.symbols[self.lex.curr_id_idx].name.clone();
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
            self.ast_emit_break();
        } else if self.lex.tk == Token::Continue {
            self.next()?;
            if self.loop_continue_depth == 0 {
                return Err(self.compile_err("continue outside of loop"));
            }
            self.flush_pending_stores();
            self.consume(b';', "semicolon expected after continue")?;
            self.ast_emit_continue();
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
                    if let Some(reason) = Self::type_warning(ret_ty, self.ty, false) {
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
                    if let Some(reason) =
                        Self::type_warning_with_flags(ret_ty, self.ty, rhs_is_zero, rhs_is_untyped)
                    {
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
            self.ast_emit_return(return_value);
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
