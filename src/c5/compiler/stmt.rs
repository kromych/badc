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
use super::types::{is_pointer_ty, is_struct_ty, struct_ptr_depth};

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
        while self.lex.tk == Token::Extern || self.lex.tk == Token::Static {
            if self.lex.tk == Token::Static {
                is_static = true;
            } else {
                is_extern = true;
            }
            self.next()?;
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
            let (loc_idx, ty, mut array_size) = self.parse_declarator(lbt)?;
            // C99 6.3.2.1p4: a function-pointer rvalue auto-decays
            // through any unary `*` chain. The `Symbol::fn_ptr_indirection`
            // side-channel records how many indirection levels sit between
            // the variable's loaded value and the function pointer itself
            // so the unary-`*` handler can recognise the decay. The
            // function-body-top path picks this up in `parse_function_body_local_decl`;
            // an inside-block decl (`else { lua_KFunction kf = ...; }`) reaches
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
            if typedef_dim > 0 && array_size == 0 && !is_pointer_ty(ty) {
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
                self.pending_local_init_ast = None;
                self.pending_local_aggregate_ast = None;
                self.pending_local_runtime_elements.clear();
                self.allocate_local_with_init(loc_idx, ty, array_size)?;
                self.finalize_local_init(loc_idx);
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
    fn parse_block_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        // C99 6.2.1: a block introduces a new scope for struct,
        // union, and enum tags. Tag bindings declared in this block
        // shadow same-named tags in any enclosing scope and go out of
        // scope when the block exits.
        self.tag_scopes.push(alloc::vec::Vec::new());
        let mut block_symbols = Vec::new();

        let mut top_level_ids: alloc::vec::Vec<super::super::ast::StmtId> = alloc::vec::Vec::new();
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
                self.parse_block_local_decl(&mut block_symbols)?;
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
                // level item.
                for id in item_before..item_after {
                    top_level_ids.push(id as super::super::ast::StmtId);
                }
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
        // Wrap the collected top-level stmt ids into a
        // `Stmt::Compound`. Only this Compound references the
        // top-level stmts -- inner wrappers are dead AST entries
        // that the walker never visits (it iterates the
        // Compound's items, which point at the canonical top-
        // level ids).
        let _ = self.ast_wrap_block_items(&top_level_ids);
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
        Ok(())
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
        let template: alloc::vec::Vec<u8> = self.data[tstart..].to_vec();
        self.next()?; // consume the template string
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
        if t == "pause" || t == "yield" {
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
    /// x87 control-word forms CPython's pymath reaches for. Parse the
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
            let letter = self.data[cstart..]
                .iter()
                .rev()
                .find(|b| b.is_ascii_alphabetic())
                .copied();
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
                _ => {
                    self.data.truncate(data_base);
                    return Err(self.compile_err("cpuid / xgetbv: unsupported asm constraint"));
                }
            };
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
            let val = self.parse_constant_int()?;
            self.consume(b':', "expected colon after case")?;
            // C99 6.8.4.2p3: the case constant expressions in one switch
            // must be distinct (constraint). Reject a duplicate rather
            // than dedup it into the first case's block, which would
            // re-terminate that block in the walker.
            let dup_case = match self.switch_cases.last_mut() {
                Some(cases) => {
                    if cases.contains(&val) {
                        true
                    } else {
                        cases.push(val);
                        false
                    }
                }
                None => return Err(self.compile_err("case outside switch")),
            };
            if dup_case {
                return Err(self.compile_err(format!("duplicate case value {val} in switch")));
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
            self.ast_emit_case(val, body_s);
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
