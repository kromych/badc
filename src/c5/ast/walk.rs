//! `Ast` -> `FunctionSsa` walker.
//!
//! Drives `SsaBuilder` from a per-function AST. Stops at the first
//! unsupported shape and surfaces the offending node through
//! `WalkError` so the shadow-validator can tag exactly which AST
//! shape the dual-emit hasn't wired yet.
//!
//! Covers every expression variant the parser already populates in
//! Phase C2 (literals, identifiers, unary, binary, assignment) and
//! the matching `Stmt::Return`. Variants that the parser hasn't
//! wired yet -- Call, Member, Index, Cast, Ternary, PreInc /
//! PostInc, CompoundAssign, Sizeof, Comma, Intrinsic, plus every
//! statement other than Return -- come back as `Unsupported`.
//!
//! The walker doesn't manage control-flow blocks beyond what the
//! Phase C2 surface needs; the for / while / if / switch
//! lowerings land alongside their parser-side dual-emit in
//! follow-on patches.

#![allow(dead_code)]

use alloc::string::String;

use super::super::codegen::Target;
use super::super::ir::{BinOp, FunctionSsa, LoadKind, StoreKind};
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::{Expr, ExprId, Stmt, StmtId, UnOp};

/// Diagnostic for a shape the walker can't lower yet. Carries
/// enough context to point at the offending AST node so the
/// shadow-validator can route the dual-emit gap back to a parser
/// site.
#[derive(Debug)]
pub(crate) enum WalkError {
    UnsupportedExpr { id: ExprId, kind: &'static str },
    UnsupportedStmt { id: StmtId, kind: &'static str },
    UnknownSymbolClass { sym: u32, class: i64 },
    UnsupportedSymbolShape { sym: u32, reason: &'static str },
}

impl core::fmt::Display for WalkError {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        match self {
            WalkError::UnsupportedExpr { id, kind } => {
                write!(f, "ast::walk: expression #{id} ({kind}) not yet supported")
            }
            WalkError::UnsupportedStmt { id, kind } => {
                write!(f, "ast::walk: statement #{id} ({kind}) not yet supported")
            }
            WalkError::UnknownSymbolClass { sym, class } => {
                write!(f, "ast::walk: symbol #{sym} class {class} not recognised",)
            }
            WalkError::UnsupportedSymbolShape { sym, reason } => {
                write!(f, "ast::walk: symbol #{sym}: {reason}")
            }
        }
    }
}

impl WalkError {
    pub(crate) fn into_string(self) -> String {
        alloc::format!("{self}")
    }
}

/// Run a per-function AST through `SsaBuilder` and return the
/// resulting `FunctionSsa`. `n_params` and `is_variadic` come from
/// the function's declarator; `n_locals` is the post-parse local
/// slot count (`max_loc_offs`). `ent_pc` is the function's
/// bytecode-tier entry PC -- the SSA emit threads it through to
/// keep call-site fixups byte-for-byte compatible with the lift.
///
/// During Phase C2 the AST is incomplete: stmts other than
/// `Return` aren't pushed yet, control-flow nesting isn't built,
/// and many expression shapes are missing. The walker iterates
/// `ast.stmts` flat (no nested blocks) and returns the first
/// unsupported shape rather than fabricating a value.
#[allow(clippy::too_many_arguments)]
pub(crate) fn walk_function(
    ast: &super::Ast,
    symbols: &[Symbol],
    structs: &[crate::c5::compiler::StructDef],
    target: Target,
    ent_pc: usize,
    n_params: usize,
    is_variadic: bool,
    n_locals: i64,
    param_tys: &[i64],
    param_local_slots: &[i64],
    returns_struct: bool,
    return_struct_size: i64,
    alloca_top_slot: i64,
) -> Result<FunctionSsa, WalkError> {
    let mut b = super::super::codegen::ssa_build::SsaBuilder::new(ent_pc, n_params, is_variadic);
    // C99 6.8: the function's stack frame holds the declared
    // locals plus, when the body calls `alloca`, the per-frame
    // arena. The arena occupies the slots above the alloca-top
    // bookkeeping slot; its size is `ALLOCA_ARENA_SLOTS` per the
    // parser's Ent patch in `run_compile`. Without this addition
    // the codegen prologue reserves too little stack and alloca
    // writes scribble over the caller's frame.
    let effective_locals = if alloca_top_slot > 0 {
        alloca_top_slot + super::super::op::ALLOCA_ARENA_SLOTS
    } else {
        n_locals
    };
    if effective_locals != 0 {
        b.set_locals(effective_locals);
    }
    // Mirror the bytecode tier's per-function `Op::AllocaInit`.
    // `alloca_top_slot == 0` means the body has no `alloca` call;
    // the per-arch emit short-circuits a zero slot without
    // writing native code. A non-zero slot tells the codegen to
    // reserve the per-frame arena and store the running top into
    // the named local slot per the bytecode-tier shape.
    b.alloca_init(alloca_top_slot);
    // C99 6.5.2.2 + the c5 calling convention: for each
    // struct-by-value parameter, the caller passes the
    // source's address in slot `i + base` (base = 2, or 3
    // when a struct-returning callee uses slot 2 as the
    // hidden out-pointer). The callee's prologue copies the
    // struct into a fresh local; the parser allocated the
    // local and recorded its offset in `param_local_slots[i]`,
    // shifted the symbol's `val` to point at it, and emitted
    // the matching Mcpy on the bytecode side. Walker replays
    // the Mcpy so the AST-driven SSA matches.
    // Argument-slot base: 2 for ordinary callees, 3 when the
    // function returns a struct value (slot 2 holds the hidden
    // out-pointer the caller pushed in front of the declared
    // args). The parser's symbol-table assignment uses the same
    // base, so this index matches the `val` the parser stored
    // for each declared param.
    let arg_slot_base: i64 = if returns_struct { 3 } else { 2 };
    for i in 0..param_tys.len() {
        let pty = param_tys[i];
        let local_slot = param_local_slots[i];
        if local_slot >= 0 {
            continue;
        }
        if !((pty & !(1i64 << 30)) >= STRUCT_BASE
            && (((pty & !(1i64 << 30)) - STRUCT_BASE) % STRUCT_STRIDE) / 2 == 0)
        {
            continue;
        }
        let stripped = pty & !(1i64 << 30);
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        if id >= structs.len() {
            continue;
        }
        let size = structs[id].size as i64;
        let arg_slot = (i as i64) + arg_slot_base;
        let dst = b.local_addr(local_slot);
        let src = b.load_local(arg_slot, super::super::ir::LoadKind::I64);
        b.mcpy(dst, src, size);
    }
    let mut ctx = Walker {
        ast,
        symbols,
        structs,
        target,
        loop_ctx: alloc::vec::Vec::new(),
        label_blocks: alloc::vec::Vec::new(),
        returns_struct,
        return_struct_size,
    };
    // Walk the function body's root statement (a Compound built
    // at function-end by the parser's `parse_block_stmt` /
    // function-body loop). If absent (no body was parsed),
    // synthesize a `return 0` for a well-formed FunctionSsa.
    let terminated = match ast.body {
        Some(root) => ctx.walk_stmt(&mut b, root)?,
        None => false,
    };
    // If the body fell off the end (no Return reached), the
    // current block is still open; close it with `return 0`
    // per C99 5.1.2.2.3 (main returning 0 by default) and the
    // general "well-formed FunctionSsa" guarantee.
    if !terminated && b.is_block_open() {
        let zero = b.imm(0);
        b.return_(zero);
    }
    // Pre-allocated branch / loop targets (after-If with both
    // arms terminating, dead post-Break tails, label blocks
    // that nothing ever reached) close with a synthetic
    // `return 0` so `finish()` doesn't panic on an open block.
    // Unreachable in practice; the SSA DCE folds the dead arm
    // away.
    b.close_dead_blocks();
    Ok(b.finish())
}

/// Per-walk context. Mutable so the walker can stack break /
/// continue targets across nested loops + switches and intern
/// `LabelId -> BlockId` for cross-stmt gotos.
struct Walker<'a> {
    ast: &'a super::Ast,
    symbols: &'a [Symbol],
    structs: &'a [crate::c5::compiler::StructDef],
    target: Target,
    /// Stack of `(break_target, continue_target)` block ids, one
    /// frame per enclosing loop / switch. Break/Continue stmts
    /// jump to the top-of-stack entries.
    loop_ctx: alloc::vec::Vec<(super::super::ir::BlockId, super::super::ir::BlockId)>,
    /// Interned mapping from AST `LabelId` to the SSA `BlockId`
    /// reserved for that label's body. Allocated lazily by either
    /// a Goto's forward reference or the matching Labeled stmt --
    /// both sides see the same block.
    label_blocks: alloc::vec::Vec<(super::super::ast::LabelId, super::super::ir::BlockId)>,
    /// True when the function's declared return type is a struct
    /// value. `return s;` lowers as: load the hidden out-pointer
    /// from `slot 2`, Mcpy `return_struct_size` bytes from `s`'s
    /// address into it, then return the out-pointer -- matching
    /// the bytecode-tier shape the parser emits in
    /// `Stmt::Return`.
    returns_struct: bool,
    /// Byte size of the struct return type when `returns_struct`
    /// is true. Zero otherwise.
    return_struct_size: i64,
}

impl<'a> Walker<'a> {
    /// Live `ent_pc` for a `Token::Fun` symbol. The parser
    /// stored the pre-optimization PC in `Expr::Ident.val`; the
    /// bytecode optimizer can shift `Op::Ent` and updates
    /// `Symbol::val` in place. Looking it up here lets every
    /// `Expr::Call` resolve to the post-opt PC the SSA emit's
    /// `bytecode_to_native` table holds, without re-walking the
    /// AST after `optimize::optimize`. Sys trampolines have
    /// their `val` patched late by `emit_sys_trampolines`;
    /// the same live-read fits both cases.
    fn live_fun_val(&self, sym: u32, fallback_val: i64) -> i64 {
        let idx = sym as usize;
        if idx < self.symbols.len()
            && self.symbols[idx].class == Token::Fun as i64
        {
            self.symbols[idx].val
        } else {
            fallback_val
        }
    }

    /// Live data offset for a `Token::Glo` symbol. The linker
    /// has patched the merged `Symbol::val` to the canonical
    /// defining unit's absolute offset (see
    /// `linker::link.rs::merge`); the AST snapshot from a
    /// caller-unit `extern` decl carries the unit-local
    /// placeholder rebased by `Ast::rebase_data_offsets` and
    /// would land in the caller's data segment instead of the
    /// shared one. Trigger only when:
    ///   * `is_extern_decl == true` -- C99 6.7.1 extern
    ///     reference, no in-unit storage. A static local
    ///     (`linkage == None`) or a file-scope `static`
    ///     (`linkage == Internal`) never hits this path, so
    ///     the parser's shadow of `Symbol::val` across
    ///     same-named per-function statics doesn't reach the
    ///     walker through this read.
    ///   * `linkage == External`.
    ///   * `val != 0` -- the linker found a defining sibling
    ///     and rewrote `val`. If no def exists (the program
    ///     has only declarations and the linker would have
    ///     flagged a missing definition anyway), the AST
    ///     snapshot is no worse a guess than `0`.
    fn live_glo_val(&self, sym: u32, fallback_val: i64) -> i64 {
        use crate::c5::symbol::Linkage;
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.class == Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && s.val != 0
            {
                return s.val;
            }
        }
        fallback_val
    }

    /// Byte size of the struct type encoded by `ty`. Looks up
    /// the struct id (via the same band scheme the parser uses)
    /// in the propagated `structs` slice. Returns 0 when the
    /// struct id is out of range (defensive -- the parser
    /// shouldn't emit such a type).
    fn struct_size(&self, ty: i64) -> i64 {
        let stripped = ty & !UNSIGNED_BIT;
        if stripped < STRUCT_BASE {
            return 0;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        if id < self.structs.len() {
            self.structs[id].size as i64
        } else {
            0
        }
    }
    /// Walk a statement. Returns `true` when the statement
    /// terminates the current block (an unconditional return /
    /// jmp), letting the caller stop iterating siblings that
    /// would otherwise emit dead code.
    fn walk_stmt(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: StmtId,
    ) -> Result<bool, WalkError> {
        match self.ast.stmt(id) {
            Stmt::Return(Some(e)) => {
                if self.returns_struct {
                    // C99 6.8.6.4 + the c5 ABI: a struct-returning
                    // callee receives the caller's result-temp
                    // address in `slot 2`. `return s;` copies
                    // `sizeof(struct T)` bytes from `s`'s address
                    // into that out-pointer and returns the
                    // out-pointer so the call site has a stable
                    // value to chain into the surrounding
                    // assignment / Mcpy.
                    let out_ptr = b
                        .load_local(2, super::super::ir::LoadKind::I64);
                    let src = self.walk_expr_rvalue(b, *e)?;
                    if self.return_struct_size > 0 {
                        b.mcpy(out_ptr, src, self.return_struct_size);
                    }
                    b.return_(out_ptr);
                    return Ok(true);
                }
                let v = self.walk_expr_rvalue(b, *e)?;
                b.return_(v);
                Ok(true)
            }
            Stmt::Return(None) => {
                let zero = b.imm(0);
                b.return_(zero);
                Ok(true)
            }
            Stmt::Expr(e) => {
                // C99 6.8.3: expression statement evaluates the
                // expression for side effects and discards the
                // value. The walker emits the side-effecting
                // chain; the SSA DCE pass drops the dead final
                // value if it has no other uses.
                let _ = self.walk_expr_rvalue(b, *e)?;
                Ok(false)
            }
            Stmt::Compound(items) => {
                for item in items {
                    match item {
                        super::BlockItem::Stmt(s) => {
                            // A previous item closed the current
                            // block (Return / Goto / Break /
                            // Continue / If-both-arms-return). If
                            // this item is a `Stmt::Labeled`, the
                            // walker below resumes at its label
                            // block so any earlier `goto label`
                            // lands somewhere walkable. Non-label
                            // dead code is skipped per C99 6.8.6
                            // (unreachable statements don't
                            // constrain control flow).
                            if !b.is_block_open()
                                && !matches!(self.ast.stmt(*s), Stmt::Labeled { .. })
                            {
                                continue;
                            }
                            if self.walk_stmt(b, *s)? {
                                continue;
                            }
                        }
                        super::BlockItem::Decl(d) => {
                            // Skip Decls in dead-code regions (a
                            // post-terminator declarator declares
                            // no live storage).
                            if !b.is_block_open() {
                                continue;
                            }
                            let d = *d;
                            self.walk_decl(b, d)?;
                        }
                    }
                }
                Ok(!b.is_block_open())
            }
            Stmt::If {
                cond,
                then_s,
                else_s,
            } => {
                let cond_v = self.walk_expr_rvalue(b, *cond)?;
                let then_blk = b.new_block();
                let after_blk = b.new_block();
                let else_blk = if else_s.is_some() {
                    b.new_block()
                } else {
                    after_blk
                };
                // C99 6.8.4.1: branch-when-zero to the else (or
                // after) block; fall through to then.
                b.branch_zero(cond_v, else_blk, then_blk);
                b.switch_to(then_blk);
                let then_id = *then_s;
                let else_id = *else_s;
                let then_terminated = self.walk_stmt(b, then_id)?;
                if !then_terminated {
                    b.jmp(after_blk);
                }
                if let Some(else_id) = else_id {
                    b.switch_to(else_blk);
                    let else_terminated = self.walk_stmt(b, else_id)?;
                    if !else_terminated {
                        b.jmp(after_blk);
                    }
                }
                b.switch_to(after_blk);
                Ok(false)
            }
            Stmt::While { cond, body } => {
                let header = b.new_block();
                let body_blk = b.new_block();
                let after = b.new_block();
                b.jmp(header);
                b.switch_to(header);
                let cond_v = self.walk_expr_rvalue(b, *cond)?;
                b.branch_zero(cond_v, after, body_blk);
                let body_id = *body;
                b.switch_to(body_blk);
                self.loop_ctx.push((after, header));
                let terminated = self.walk_stmt(b, body_id)?;
                self.loop_ctx.pop();
                if !terminated {
                    b.jmp(header);
                }
                b.switch_to(after);
                Ok(false)
            }
            Stmt::DoWhile { body, cond } => {
                let body_blk = b.new_block();
                let cond_blk = b.new_block();
                let after = b.new_block();
                b.jmp(body_blk);
                b.switch_to(body_blk);
                let body_id = *body;
                self.loop_ctx.push((after, cond_blk));
                let terminated = self.walk_stmt(b, body_id)?;
                self.loop_ctx.pop();
                if !terminated {
                    b.jmp(cond_blk);
                }
                b.switch_to(cond_blk);
                let cond_v = self.walk_expr_rvalue(b, *cond)?;
                b.branch_nonzero(cond_v, body_blk, after);
                b.switch_to(after);
                Ok(false)
            }
            Stmt::For {
                init,
                cond,
                post,
                body,
            } => {
                let init_clone = *init;
                let cond_clone = *cond;
                let post_clone = *post;
                let body_clone = *body;
                if let Some(super::BlockItem::Stmt(s)) = init_clone {
                    let _ = self.walk_stmt(b, s)?;
                }
                let header = b.new_block();
                let body_blk = b.new_block();
                let post_blk = b.new_block();
                let after = b.new_block();
                b.jmp(header);
                b.switch_to(header);
                let cond_v = match cond_clone {
                    Some(c) => self.walk_expr_rvalue(b, c)?,
                    None => b.imm(1),
                };
                b.branch_zero(cond_v, after, body_blk);
                b.switch_to(body_blk);
                self.loop_ctx.push((after, post_blk));
                let body_terminated = self.walk_stmt(b, body_clone)?;
                self.loop_ctx.pop();
                if !body_terminated {
                    b.jmp(post_blk);
                }
                b.switch_to(post_blk);
                if let Some(p) = post_clone {
                    let _ = self.walk_expr_rvalue(b, p)?;
                }
                b.jmp(header);
                b.switch_to(after);
                Ok(false)
            }
            Stmt::Break => {
                let Some(&(brk, _)) = self.loop_ctx.last() else {
                    return Err(WalkError::UnsupportedStmt { id, kind: "Break" });
                };
                b.jmp(brk);
                Ok(true)
            }
            Stmt::Continue => {
                let Some(&(_, cont)) = self.loop_ctx.last() else {
                    return Err(WalkError::UnsupportedStmt {
                        id,
                        kind: "Continue",
                    });
                };
                b.jmp(cont);
                Ok(true)
            }
            Stmt::Goto(label) => {
                let target = self.block_for_label(b, *label);
                b.jmp(target);
                Ok(true)
            }
            Stmt::Labeled { label, body } => {
                let label_blk = self.block_for_label(b, *label);
                // C99 6.8.1: a labeled statement is reachable from
                // both fall-through and any matching goto. When the
                // current block is open, splice it into the label
                // block with a jmp + switch_to. When it is closed
                // (the immediately-preceding stmt terminated --
                // typically a `goto label;` or a return), just
                // switch the cursor; the label block already has
                // its predecessors recorded by their jmps.
                if b.is_block_open() {
                    b.jmp(label_blk);
                }
                b.switch_to(label_blk);
                let body_id = *body;
                self.walk_stmt(b, body_id)
            }
            Stmt::Switch { disc, body } => {
                let disc_val = self.walk_expr_rvalue(b, *disc)?;
                let body_id = *body;

                // Flatten the body's top-level items into a list
                // for partitioning. A Compound's items become the
                // list directly; a singleton stmt becomes a one-
                // element list.
                let items: alloc::vec::Vec<super::BlockItem> = match self.ast.stmt(body_id) {
                    Stmt::Compound(its) => its.clone(),
                    _ => alloc::vec![super::BlockItem::Stmt(body_id)],
                };

                // Partition the items into (labels, stmts)
                // tuples. `labels` is empty for the pre-first-
                // case fall-in region (C99 6.8.4.2: reachable
                // only by goto-into-switch; the walker still
                // emits a block so outer goto has a target),
                // or a list of `Some(val)` (Case markers) and
                // `None` (Default marker) entries when one or
                // more case labels share the body that follows.
                // C99 6.8.4.2: a Case / Default marker labels
                // the following statement, so a chain like
                // `case 'a': case 'b': case 'c': body;` puts
                // three labels on the same body. The parser
                // builds those as nested `Stmt::Case`s on the
                // body field; peel them off so the dispatcher
                // emits one comparison per label that all
                // branch to the same case block.
                #[allow(clippy::type_complexity)]
                let mut partitions: alloc::vec::Vec<(
                    alloc::vec::Vec<Option<i64>>,
                    alloc::vec::Vec<super::BlockItem>,
                )> = alloc::vec::Vec::new();
                // C99 6.8.1: a `goto`-target label that wraps a
                // Case / Default marker resolves to the same
                // statement as the marker. The peel loop records
                // every such label id keyed by the partition it
                // ends up in; after the partitions' SSA blocks
                // are allocated below we register
                // `label_id -> block` so a downstream
                // `Stmt::Goto(label)` lands on the case block
                // instead of an orphan block that
                // `block_for_label` would otherwise materialise.
                let mut peeled_label_partition: alloc::vec::Vec<(
                    super::super::ast::LabelId,
                    usize,
                )> = alloc::vec::Vec::new();
                let mut current_labels: alloc::vec::Vec<Option<i64>> = alloc::vec::Vec::new();
                let mut current: alloc::vec::Vec<super::BlockItem> = alloc::vec::Vec::new();
                let mut pending_goto_labels: alloc::vec::Vec<super::super::ast::LabelId> =
                    alloc::vec::Vec::new();
                let flush = |partitions: &mut alloc::vec::Vec<(
                    alloc::vec::Vec<Option<i64>>,
                    alloc::vec::Vec<super::BlockItem>,
                )>,
                             current_labels: &mut alloc::vec::Vec<Option<i64>>,
                             current: &mut alloc::vec::Vec<super::BlockItem>| {
                    if !current.is_empty() || !current_labels.is_empty() {
                        partitions.push((
                            core::mem::take(current_labels),
                            core::mem::take(current),
                        ));
                    }
                };
                for item in &items {
                    if let super::BlockItem::Stmt(s) = item {
                        let mut s_id = *s;
                        let mut saw_marker = false;
                        // Peel nested Case / Default markers
                        // off the head until we hit a real
                        // statement. `Stmt::Labeled` is also
                        // unwrapped here when its body is itself
                        // a Case / Default marker (C99 6.8.1: a
                        // label labels the next statement, so
                        // `foo: case X:` makes `foo` an alias
                        // for the Case body). The label id is
                        // recorded; the case's SSA block is
                        // registered as the label's target after
                        // the partitions array is finalised.
                        loop {
                            match self.ast.stmt(s_id) {
                                Stmt::Case { val, body } => {
                                    if !saw_marker {
                                        flush(&mut partitions, &mut current_labels, &mut current);
                                        saw_marker = true;
                                    }
                                    current_labels.push(Some(*val));
                                    s_id = *body;
                                }
                                Stmt::Default { body } => {
                                    if !saw_marker {
                                        flush(&mut partitions, &mut current_labels, &mut current);
                                        saw_marker = true;
                                    }
                                    current_labels.push(None);
                                    s_id = *body;
                                }
                                Stmt::Labeled { label, body } => {
                                    let inner = self.ast.stmt(*body);
                                    if matches!(inner, Stmt::Case { .. } | Stmt::Default { .. }) {
                                        pending_goto_labels.push(*label);
                                        s_id = *body;
                                    } else {
                                        break;
                                    }
                                }
                                _ => break,
                            }
                        }
                        if saw_marker {
                            // Any goto-labels peeled in this
                            // partition's head now belong to the
                            // partition we're about to push.
                            let target_idx = partitions.len();
                            for lab in pending_goto_labels.drain(..) {
                                peeled_label_partition.push((lab, target_idx));
                            }
                            current.push(super::BlockItem::Stmt(s_id));
                            continue;
                        }
                        // Labeled-wrapping-non-marker fell out
                        // of the peel loop; the goto-label
                        // accumulator stays empty in that case
                        // because the break was taken on the
                        // first iteration without recording one.
                    }
                    current.push(*item);
                }
                flush(&mut partitions, &mut current_labels, &mut current);

                let after_blk = b.new_block();
                let blocks: alloc::vec::Vec<super::super::ir::BlockId> =
                    (0..partitions.len()).map(|_| b.new_block()).collect();
                for (label, idx) in &peeled_label_partition {
                    if idx < &blocks.len() {
                        self.label_blocks.push((*label, blocks[*idx]));
                    }
                }
                let default_idx = partitions
                    .iter()
                    .position(|(lbls, _)| lbls.iter().any(|l| l.is_none()));

                // Dispatcher chain: for each Case label across
                // all partitions, cmp disc against its val and
                // branch to the matching case block when equal;
                // fall through to the next comparison otherwise.
                // After the chain, jmp to default (if present)
                // or to after_blk.
                let mut next_dispatcher_blk = b.new_block();
                b.jmp(next_dispatcher_blk);
                for (i, (labels, _)) in partitions.iter().enumerate() {
                    for label in labels {
                        if let Some(val) = label {
                            b.switch_to(next_dispatcher_blk);
                            let val_v = b.imm(*val);
                            let eq = b.binop(BinOp::Eq, disc_val, val_v);
                            let next = b.new_block();
                            b.branch_nonzero(eq, blocks[i], next);
                            next_dispatcher_blk = next;
                        }
                    }
                }
                b.switch_to(next_dispatcher_blk);
                let final_target = match default_idx {
                    Some(idx) => blocks[idx],
                    None => after_blk,
                };
                b.jmp(final_target);

                // Push loop_ctx for break. Continue is invalid
                // inside a bare switch; propagate the outer
                // loop's continue target so nested switch-in-loop
                // works.
                let prev_continue = self.loop_ctx.last().map(|&(_, c)| c).unwrap_or(after_blk);
                self.loop_ctx.push((after_blk, prev_continue));

                // Walk each partition's stmts into its block;
                // fallthrough lands on the next partition's
                // block (or after_blk for the last partition).
                let n = partitions.len();
                for (i, (_, stmts)) in partitions.into_iter().enumerate() {
                    b.switch_to(blocks[i]);
                    let mut terminated = false;
                    for item in stmts {
                        if let super::BlockItem::Stmt(s) = item
                            && self.walk_stmt(b, s)?
                        {
                            terminated = true;
                            break;
                        }
                    }
                    if !terminated {
                        let next_block = if i + 1 < n { blocks[i + 1] } else { after_blk };
                        b.jmp(next_block);
                    }
                }

                self.loop_ctx.pop();
                b.switch_to(after_blk);
                Ok(false)
            }
            // Case / Default markers normally get consumed by the
            // enclosing Switch's partition pass. If a stray one
            // reaches the walker (e.g. inside a non-switch
            // Compound -- which would be a parser bug), treat it
            // as a transparent wrapper around its body.
            Stmt::Case { body, .. } | Stmt::Default { body, .. } => {
                let body_id = *body;
                self.walk_stmt(b, body_id)
            }
            Stmt::Asm { .. } => Err(WalkError::UnsupportedStmt { id, kind: "Asm" }),
            Stmt::Decl(d) => {
                let decl_id = *d;
                self.walk_decl(b, decl_id)?;
                Ok(false)
            }
        }
    }

    /// Walk a local declaration. Lowers based on the
    /// initializer's shape:
    /// * `LocalInit::None` -- no instruction (C99 6.7.8p10).
    /// * `LocalInit::Scalar(expr)` -- evaluate, `store_local`.
    /// * `LocalInit::Aggregate { src_data_off, size_bytes }` --
    ///   emit `Inst::Mcpy { dst = local_addr, src = imm_data,
    ///   size }` matching the bytecode tier's constant brace-
    ///   list path.
    fn walk_decl(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: super::super::ast::DeclId,
    ) -> Result<(), WalkError> {
        match self.ast.decl(id) {
            super::super::ast::Decl::Local {
                sym: _,
                ty,
                slot_off,
                init,
            } => {
                let slot = *slot_off;
                let ty = *ty;
                let init_clone = init.clone();
                match init_clone {
                    super::super::ast::LocalInit::None => Ok(()),
                    super::super::ast::LocalInit::Scalar(init_id) => {
                        let v = self.walk_expr_rvalue(b, init_id)?;
                        // C99 6.7.8p13 struct-value initializer:
                        // copy the source's bytes into the local
                        // slot via Mcpy. `v` is the source
                        // address (the walker's address-as-value
                        // routing for struct rvalues). Size comes
                        // from the local's declared struct type.
                        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                            let dst = b.local_addr(slot);
                            let size = self.struct_size(ty);
                            b.mcpy(dst, v, size);
                            return Ok(());
                        }
                        let kind = store_kind_for(ty, self.target);
                        // Match `lift_function`'s StoreLocal fuse:
                        // only I64 fuses into StoreLocal because
                        // the per-arch emit's StoreLocal handles
                        // only the 8-byte width. Narrower widths
                        // go through LocalAddr + Store.
                        if matches!(kind, super::super::ir::StoreKind::I64) {
                            b.store_local(slot, v, kind);
                        } else {
                            let addr = b.local_addr(slot);
                            b.store(addr, v, kind);
                        }
                        Ok(())
                    }
                    super::super::ast::LocalInit::Aggregate {
                        src_data_off,
                        size_bytes,
                    } => {
                        let dst = b.local_addr(slot);
                        let src = b.imm_data(src_data_off);
                        b.mcpy(dst, src, size_bytes);
                        Ok(())
                    }
                    super::super::ast::LocalInit::Runtime {
                        zero_init,
                        elements,
                    } => {
                        // C99 6.7.8p19 zero prelude (if the parser
                        // emitted one): Mcpy staged zero bytes
                        // before the per-element stores.
                        if let Some((src_data_off, size_bytes)) = zero_init {
                            let dst = b.local_addr(slot);
                            let src = b.imm_data(src_data_off);
                            b.mcpy(dst, src, size_bytes);
                        }
                        // Per-element stores: address = local_addr
                        // + offset, store(walked-value, kind).
                        for elem in &elements {
                            let v = self.walk_expr_rvalue(b, elem.value)?;
                            let base = b.local_addr(slot);
                            let addr = if elem.offset == 0 {
                                base
                            } else {
                                b.binop_imm(BinOp::Add, base, elem.offset)
                            };
                            let kind = store_kind_for(elem.ty, self.target);
                            b.store(addr, v, kind);
                        }
                        Ok(())
                    }
                }
            }
            super::super::ast::Decl::Vla { .. } => Err(WalkError::UnsupportedStmt {
                id: 0,
                kind: "Decl::Vla",
            }),
            super::super::ast::Decl::StaticLocal { .. } => {
                // C99 6.2.4p3 + 6.7.8p4: storage + initializer
                // live in the data segment; nothing to emit in
                // the function body. The matching symbol-table
                // entry survives through `self.symbols`, so any
                // ident reference still resolves through the Glo
                // path in `load_ident_rvalue` /
                // `ident_address`.
                Ok(())
            }
        }
    }

    /// Allocate or reuse the SSA block reserved for the given AST
    /// label id. Goto's forward reference and the matching Labeled
    /// stmt both look up through this so they share the same block.
    fn block_for_label(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        label: super::super::ast::LabelId,
    ) -> super::super::ir::BlockId {
        if let Some(&(_, blk)) = self.label_blocks.iter().find(|(l, _)| *l == label) {
            return blk;
        }
        let blk = b.new_block();
        self.label_blocks.push((label, blk));
        blk
    }

    /// Walk an expression in rvalue position. Returns the
    /// `ValueId` whose runtime value matches what the bytecode
    /// tier would have left in the c5 accumulator.
    fn walk_expr_rvalue(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Ok(b.imm(*val)),
            Expr::FloatLit { bits, .. } => Ok(b.imm(*bits as i64)),
            Expr::StrLit { data_off, .. } => Ok(b.imm_data(*data_off)),
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
                array_size,
            } => self.load_ident_rvalue(
                b,
                *sym,
                *ty,
                *class,
                *val,
                *is_thread_local,
                *array_size,
            ),
            Expr::Unary { op, child, ty } => self.walk_unary(b, *op, *child, *ty),
            Expr::Binary { op, lhs, rhs, ty } => {
                let mut lv = self.walk_expr_rvalue(b, *lhs)?;
                let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                let mask = unsigned_narrow_mask(*ty);
                // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo
                // at a narrower-than-register common type needs
                // each operand masked to that width *before* the
                // op. A signed operand promoted to the unsigned
                // common type carries its sign-extended high
                // half in the 64-bit register; without the mask,
                // `udiv` / `umod` operate on the wider pattern
                // and produce the wrong order of magnitude.
                if mask != 0 && matches!(*op, BinOp::Divu | BinOp::Modu) {
                    lv = b.binop_imm(BinOp::And, lv, mask);
                    rv = b.binop_imm(BinOp::And, rv, mask);
                }
                // The parser's `maybe_mask_to_unsigned_width`
                // already pushes the explicit narrow mask /
                // signed `Shl K; Shr K` pair as additional
                // `Expr::Binary` nodes through the dual-emit
                // binop tracker. Re-applying the narrowing here
                // would double-shift (or double-mask) the
                // result; walker just emits the raw `Binop` and
                // lets those wrapping Binary nodes do the rest.
                Ok(b.binop(*op, lv, rv))
            }
            Expr::BitfieldAssign {
                obj,
                field_off,
                bitfield,
                rhs,
                ..
            } => {
                // C99 6.7.2.1: bitfield write -- load the storage
                // unit, clear the destination slice, mask + shift
                // the new value into place, OR the cleared old
                // value with the shifted new, store back. The
                // walker mirrors `emit_bitfield_access` on the
                // bytecode side. Returns the combined word so an
                // outer expression chain keeps a stable rvalue.
                let bf = *bitfield;
                let base = self.walk_expr_rvalue(b, *obj)?;
                let addr = if *field_off != 0 {
                    b.binop_imm(BinOp::Add, base, *field_off)
                } else {
                    base
                };
                let (load_kind, store_kind) = match bf.unit_size {
                    1 => (
                        super::super::ir::LoadKind::U8,
                        super::super::ir::StoreKind::I8,
                    ),
                    2 => (
                        super::super::ir::LoadKind::U16,
                        super::super::ir::StoreKind::I16,
                    ),
                    4 => (
                        super::super::ir::LoadKind::U32,
                        super::super::ir::StoreKind::I32,
                    ),
                    _ => (
                        super::super::ir::LoadKind::I64,
                        super::super::ir::StoreKind::I64,
                    ),
                };
                let mask: i64 = if bf.bit_width >= 64 {
                    -1
                } else {
                    (1i64 << bf.bit_width) - 1
                };
                let clear_mask: i64 = !(mask << bf.bit_offset);
                let old = b.load(addr, load_kind);
                let cleared = b.binop_imm(BinOp::And, old, clear_mask);
                let rhs_v = self.walk_expr_rvalue(b, *rhs)?;
                let masked = b.binop_imm(BinOp::And, rhs_v, mask);
                let shifted = if bf.bit_offset > 0 {
                    b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
                } else {
                    masked
                };
                let combined = b.binop(BinOp::Or, cleared, shifted);
                b.store(addr, combined, store_kind);
                Ok(combined)
            }
            Expr::Assign { lhs, rhs, ty } => {
                // C99 6.5.16.1p1 + the c5 address-as-value rule:
                // a struct-typed assignment copies the bytes from
                // the source struct into the destination. The
                // walker walks both sides as lvalue / rvalue
                // address producers (struct rvalues land their
                // address on `ast_acc`, not a load) and emits
                // `Inst::Mcpy { dst, src, size }`. Returns the
                // dst address as the expression's value
                // (mirroring libc `memcpy`).
                if is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0 {
                    let dst = self.walk_expr_lvalue(b, *lhs)?;
                    let src = self.walk_expr_rvalue(b, *rhs)?;
                    let size = self.struct_size(*ty);
                    b.mcpy(dst, src, size);
                    return Ok(dst);
                }
                // Local-target shortcut: a Token::Loc-class
                // Ident lvalue lowers to a single `StoreLocal`
                // instead of `LocalAddr` + `Store`, but only for
                // the I64 width. `ssa::lift_function` performs
                // the same fuse on the bytecode side
                // (`Op::Lea N; Op::Psh; ...; Op::Si` -> a single
                // `StoreLocal { slot: N }`) and keeps narrower
                // widths as `Inst::Store` because the per-arch
                // emit's `StoreLocal` only handles 8-byte stores.
                // Mirroring the same gate keeps walker and lift
                // category histograms aligned.
                let kind = store_kind_for(*ty, self.target);
                if matches!(kind, StoreKind::I64)
                    && let Expr::Ident {
                        class,
                        val,
                        is_thread_local: false,
                        ..
                    } = self.ast.expr(*lhs)
                    && *class == Token::Loc as i64
                {
                    let slot = *val;
                    let value = self.walk_expr_rvalue(b, *rhs)?;
                    b.store_local(slot, value, kind);
                    return Ok(value);
                }
                let addr = self.walk_expr_lvalue(b, *lhs)?;
                let value = self.walk_expr_rvalue(b, *rhs)?;
                b.store(addr, value, kind);
                // C99 6.5.16p3: the assignment's value is the
                // value stored, after any conversion the rhs walker
                // already applied.
                Ok(value)
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ..
            } => {
                // C99 6.5.15: evaluate cond; depending on the
                // value, evaluate exactly one of then_e / else_e
                // and the conditional expression's value is that
                // arm's value. Same synthetic-local-slot phi
                // substitute the `ShortCircuit` arm uses -- both
                // arms `store_local` the arm result and the
                // merge block `load_local`s.
                let cond_v = self.walk_expr_rvalue(b, *cond)?;
                let then_blk = b.new_block();
                let else_blk = b.new_block();
                let after_blk = b.new_block();
                b.branch_zero(cond_v, else_blk, then_blk);
                let slot = b.alloc_synthetic_local();
                let kind_l = super::super::ir::LoadKind::I64;
                let kind_s = super::super::ir::StoreKind::I64;
                b.switch_to(then_blk);
                let then_v = self.walk_expr_rvalue(b, *then_e)?;
                b.store_local(slot, then_v, kind_s);
                b.jmp(after_blk);
                b.switch_to(else_blk);
                let else_v = self.walk_expr_rvalue(b, *else_e)?;
                b.store_local(slot, else_v, kind_s);
                b.jmp(after_blk);
                b.switch_to(after_blk);
                Ok(b.load_local(slot, kind_l))
            }
            Expr::Call { callee, args, ty } => {
                // Struct-returning c5-internal callee: allocate
                // a result temp on this frame, prepend its
                // address as the hidden out-pointer arg 0, run
                // the call, and return the temp's address as
                // the expression's value (the c5 ABI's
                // address-as-value rule for struct rvalues).
                if is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0 {
                    if let Expr::Ident { sym, class, val, .. } = self.ast.expr(*callee) {
                        if *class == Token::Fun as i64 {
                            let result_slot = b.alloc_synthetic_local();
                            // Spill the out-pointer through an
                            // int-typed temp so the codegen
                            // routes it via the host int arg
                            // register (matches what the lift
                            // does for FP / pointer args).
                            let addr = b.local_addr(result_slot);
                            let temp = b.alloc_synthetic_local();
                            b.store_local(
                                temp,
                                addr,
                                super::super::ir::StoreKind::I64,
                            );
                            let out_arg =
                                b.load_local(temp, super::super::ir::LoadKind::I64);
                            let mut all_args: alloc::vec::Vec<super::super::ir::ValueId> =
                                alloc::vec::Vec::with_capacity(args.len() + 1);
                            all_args.push(out_arg);
                            for a in args {
                                all_args.push(self.walk_expr_rvalue(b, *a)?);
                            }
                            let target_pc = self.live_fun_val(*sym, *val);
                            let _ = b.call(target_pc as usize, all_args);
                            return Ok(b.local_addr(result_slot));
                        }
                    }
                }
                // Lower each arg as an rvalue, then dispatch
                // through the callee's class. Direct
                // c5-internal (`Token::Fun`) calls go through
                // `b.call(target_pc, args)`; libc bindings
                // (`Token::Sys`) go through `b.call_ext`;
                // anything else routes through
                // `b.call_indirect` with the callee's value.
                let mut arg_vals: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                // C99 6.5.2.2p7 + ABI: each FP-typed argument
                // routes through d0..d7 (or the host's variadic
                // FP slot). Encode the per-arg FP-ness as a bit
                // mask so the codegen's `plan_call_args` places
                // each arg in the right register class. Walker
                // reads the arg's snapshotted `ty`; the post-
                // conversion type captured by the dual-emit
                // binop tracker already reflects the implicit
                // int->double lift the parser emitted at this
                // call site.
                let mut fp_arg_mask: u32 = 0;
                for (i, a) in args.iter().enumerate() {
                    arg_vals.push(self.walk_expr_rvalue(b, *a)?);
                    if expr_ty(self.ast.expr(*a))
                        .map(is_floating_scalar)
                        .unwrap_or(false)
                        && i < 32
                    {
                        fp_arg_mask |= 1u32 << i;
                    }
                }
                if let Expr::Ident { sym, class, val, .. } = self.ast.expr(*callee) {
                    if *class == Token::Fun as i64 {
                        // c5-internal calls pass every arg in
                        // an integer register slot (the callee
                        // reads them out of positive frame
                        // slots as i64 regardless of their
                        // C-level type). For FP args, the bit
                        // pattern has to round-trip through the
                        // int register class -- StoreLocal /
                        // LoadLocal -- so the codegen places
                        // the value in x0..x7 instead of
                        // d0..d7. Mirror what the lift
                        // produces for FP args at c5-internal
                        // call sites.
                        for (i, a) in args.iter().enumerate() {
                            let arg_is_fp = expr_ty(self.ast.expr(*a))
                                .map(is_floating_scalar)
                                .unwrap_or(false);
                            if arg_is_fp {
                                let slot = b.alloc_synthetic_local();
                                b.store_local(
                                    slot,
                                    arg_vals[i],
                                    super::super::ir::StoreKind::I64,
                                );
                                arg_vals[i] =
                                    b.load_local(slot, super::super::ir::LoadKind::I64);
                            }
                        }
                        let target_pc = self.live_fun_val(*sym, *val);
                        return Ok(b.call(target_pc as usize, arg_vals));
                    }
                    if *class == Token::Sys as i64 {
                        // The Ident's `val` is the binding's
                        // flat index across all `#pragma
                        // binding(...)` directives -- exactly
                        // what `Inst::CallExt::binding_idx`
                        // wants. `fp_arg_mask` is the per-arg
                        // FP-ness bit set we built above.
                        return Ok(b.call_ext(*val, arg_vals, fp_arg_mask));
                    }
                }
                let target = self.walk_expr_rvalue(b, *callee)?;
                Ok(b.call_indirect(target, arg_vals))
            }
            Expr::Member {
                obj,
                field_off,
                bitfield,
                ty,
                array_size,
            } => {
                if let Some(bf) = bitfield {
                    // C99 6.7.2.1: bitfield read. Address points at
                    // the field's storage unit (parser already
                    // included `field_off`); load the unit, shift
                    // the slice down to bit 0, mask, and sign-
                    // extend per 6.7.2.1p10 when the declared base
                    // type is signed.
                    let base = self.walk_expr_rvalue(b, *obj)?;
                    let addr = if *field_off != 0 {
                        b.binop_imm(BinOp::Add, base, *field_off)
                    } else {
                        base
                    };
                    let unit_kind = match bf.unit_size {
                        1 => super::super::ir::LoadKind::U8,
                        2 => super::super::ir::LoadKind::U16,
                        4 => super::super::ir::LoadKind::U32,
                        _ => super::super::ir::LoadKind::I64,
                    };
                    let mut v = b.load(addr, unit_kind);
                    if bf.bit_offset > 0 {
                        v = b.binop_imm(BinOp::Shr, v, bf.bit_offset as i64);
                    }
                    let mask: i64 = if bf.bit_width >= 64 {
                        -1
                    } else {
                        (1i64 << bf.bit_width) - 1
                    };
                    v = b.binop_imm(BinOp::And, v, mask);
                    if bf.signed && bf.bit_width < 64 {
                        let shift = 64i64 - (bf.bit_width as i64);
                        v = b.binop_imm(BinOp::Shl, v, shift);
                        v = b.binop_imm(BinOp::Shr, v, shift);
                    }
                    return Ok(v);
                }
                let base = self.walk_expr_rvalue(b, *obj)?;
                let addr = if *field_off != 0 {
                    b.binop_imm(BinOp::Add, base, *field_off)
                } else {
                    base
                };
                // C99 6.3.2.1p3: an array-typed field decays to a
                // pointer to its first element; the field's
                // address IS the rvalue. Same address-as-value
                // rule for a struct-value field (no `*` on the
                // declared type).
                if *array_size != 0
                    || (is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0)
                {
                    return Ok(addr);
                }
                let kind = load_kind_for(*ty, self.target);
                Ok(b.load(addr, kind))
            }
            Expr::Index { array, idx, ty } => {
                let arr = self.walk_expr_rvalue(b, *array)?;
                let i = self.walk_expr_rvalue(b, *idx)?;
                // The parser already scaled `idx` by the element
                // size (via `emit_binop_with_imm(Op::Mul, scale)`)
                // when the pointee size is non-trivial. The
                // resulting child `Binary{Mul, idx, scale}` rides
                // through `walk_expr_rvalue`; we just add.
                let addr = b.binop(BinOp::Add, arr, i);
                // C99 6.5.2.1p2 + the c5 address-as-value rule:
                // when `ty` is a struct value (non-pointer
                // struct), `arr[i]` produces the element's
                // address as its rvalue and no load runs. The
                // wrapping `.field` / `= rhs` site handles the
                // bytes from there.
                if is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0 {
                    return Ok(addr);
                }
                let kind = load_kind_for(*ty, self.target);
                Ok(b.load(addr, kind))
            }
            Expr::Cast { child, to_ty } => {
                let v = self.walk_expr_rvalue(b, *child)?;
                // C99 6.5.4: a cast performs a value-changing
                // conversion when the source/destination differ
                // in fp-ness. Same-class casts (int<->ptr,
                // float<->double) are bit-pattern-compatible and
                // need no op. Width-narrowing on integers is a
                // truncation the SSA emitter already handles
                // through the Store / Load kinds at the
                // surrounding sites.
                let src_ty = match self.ast.expr(*child) {
                    Expr::IntLit { ty, .. }
                    | Expr::FloatLit { ty, .. }
                    | Expr::Ident { ty, .. }
                    | Expr::Unary { ty, .. }
                    | Expr::Binary { ty, .. }
                    | Expr::Ternary { ty, .. }
                    | Expr::Call { ty, .. }
                    | Expr::Member { ty, .. }
                    | Expr::Index { ty, .. }
                    | Expr::Assign { ty, .. }
                    | Expr::BitfieldAssign { ty, .. }
                    | Expr::CompoundAssign { ty, .. }
                    | Expr::PreInc { ty, .. }
                    | Expr::PostInc { ty, .. }
                    | Expr::Comma { ty, .. }
                    | Expr::ShortCircuit { ty, .. } => *ty,
                    Expr::Cast { to_ty: t, .. } => *t,
                    Expr::Sizeof(s) => s.result_ty,
                    Expr::StrLit { ty, .. } => *ty,
                    Expr::Intrinsic { ty, .. } => *ty,
                };
                let target_is_fp = is_floating_scalar(*to_ty);
                let source_is_fp = is_floating_scalar(src_ty);
                if target_is_fp && !source_is_fp {
                    return Ok(b.fp_cast(super::super::ir::FpCastKind::IntToFp, v));
                } else if !target_is_fp && source_is_fp {
                    return Ok(b.fp_cast(super::super::ir::FpCastKind::FpToInt, v));
                }
                // FP-to-FP (float <-> double) is bit-pattern-
                // compatible in the accumulator -- the c5
                // accumulator carries f64 bits; narrowing /
                // widening between float and double happens at
                // the `Op::Sf` / `Op::Lf` boundary. No inline
                // conversion required.
                if target_is_fp && source_is_fp {
                    return Ok(v);
                }
                // Integer-to-integer cast. C99 6.3.1.3:
                //   * narrowing -> unsigned target: mask to the
                //     target storage width.
                //   * narrowing -> signed target (or same-width
                //     signed conversion of an unsigned source):
                //     shift-pair Shl K; Shr K to sign-extend the
                //     truncated value (clang / gcc-compatible UB
                //     handling).
                // Mirrors the bytecode tier's
                // `expr.rs::Token::LP` cast site so the walker
                // produces the same in-register pattern.
                let target_size = type_size_bytes(*to_ty, self.target);
                let source_size = type_size_bytes(src_ty, self.target);
                if target_size == 0 || target_size >= 8 {
                    return Ok(v);
                }
                let source_unsigned = (src_ty & UNSIGNED_BIT) != 0;
                let target_unsigned = (*to_ty & UNSIGNED_BIT) != 0;
                if target_unsigned {
                    let mask: i64 = match target_size {
                        1 => 0xff,
                        2 => 0xffff,
                        4 => 0xffff_ffff,
                        _ => return Ok(v),
                    };
                    Ok(b.binop_imm(BinOp::And, v, mask))
                } else {
                    let needs_extend = target_size < source_size
                        || (target_size == source_size && source_unsigned);
                    if needs_extend {
                        let bits = 64i64 - (target_size as i64) * 8;
                        let shifted = b.binop_imm(BinOp::Shl, v, bits);
                        Ok(b.binop_imm(BinOp::Shr, shifted, bits))
                    } else {
                        Ok(v)
                    }
                }
            }
            Expr::CompoundAssign { op, lhs, rhs, ty } => {
                // C99 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2`
                // with E1 evaluated once. Spill the lhs address,
                // load through it, apply the binop with rhs,
                // store back. The expression's value is the new
                // (post-op) value per the same clause.
                let addr = self.walk_expr_lvalue(b, *lhs)?;
                let load_kind = load_kind_for(*ty, self.target);
                let old = b.load(addr, load_kind);
                let rhs_val = self.walk_expr_rvalue(b, *rhs)?;
                let new_val = b.binop(*op, old, rhs_val);
                let store_kind = store_kind_for(*ty, self.target);
                b.store(addr, new_val, store_kind);
                Ok(new_val)
            }
            Expr::PreInc { lvalue, by, ty } => {
                let addr = self.walk_expr_lvalue(b, *lvalue)?;
                let kind = load_kind_for(*ty, self.target);
                let old = b.load(addr, kind);
                let stepped = b.binop_imm(BinOp::Add, old, *by);
                let store_kind = store_kind_for(*ty, self.target);
                b.store(addr, stepped, store_kind);
                Ok(stepped)
            }
            Expr::PostInc { lvalue, by, ty } => {
                let addr = self.walk_expr_lvalue(b, *lvalue)?;
                let kind = load_kind_for(*ty, self.target);
                let old = b.load(addr, kind);
                let stepped = b.binop_imm(BinOp::Add, old, *by);
                let store_kind = store_kind_for(*ty, self.target);
                b.store(addr, stepped, store_kind);
                // C99 6.5.2.4p3: the expression's value is the
                // pre-update value (`old`).
                Ok(old)
            }
            Expr::Sizeof(s) => Ok(b.imm(s.size_bytes)),
            Expr::Comma { lhs, rhs, .. } => {
                let _ = self.walk_expr_rvalue(b, *lhs)?;
                self.walk_expr_rvalue(b, *rhs)
            }
            Expr::ShortCircuit { op, lhs, rhs, .. } => {
                // C99 6.5.13 / 6.5.14. Evaluate lhs; if it
                // already determines the result, skip rhs and
                // jump to the merge block. Otherwise evaluate
                // rhs and jump to merge with rhs's value. Use a
                // synthetic local slot as a phi substitute --
                // both arms `store_local` into it and the merge
                // block `load_local`s the result. The slot
                // bumps `func.locals` so the per-arch frame
                // emit reserves it.
                let slot = b.alloc_synthetic_local();
                let kind_l = super::super::ir::LoadKind::I64;
                let kind_s = super::super::ir::StoreKind::I64;
                let lhs_val = self.walk_expr_rvalue(b, *lhs)?;
                b.store_local(slot, lhs_val, kind_s);
                let rhs_blk = b.new_block();
                let after_blk = b.new_block();
                match *op {
                    super::ShortCircuitOp::Lan => {
                        // `a && b`: skip rhs when lhs == 0.
                        b.branch_zero(lhs_val, after_blk, rhs_blk);
                    }
                    super::ShortCircuitOp::Lor => {
                        // `a || b`: skip rhs when lhs != 0.
                        b.branch_nonzero(lhs_val, after_blk, rhs_blk);
                    }
                }
                b.switch_to(rhs_blk);
                let rhs_val = self.walk_expr_rvalue(b, *rhs)?;
                b.store_local(slot, rhs_val, kind_s);
                b.jmp(after_blk);
                b.switch_to(after_blk);
                Ok(b.load_local(slot, kind_l))
            }
            Expr::Intrinsic { kind, args, .. } => {
                let intr_kind = *kind;
                let mut arg_vals: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                for a in args.clone() {
                    arg_vals.push(self.walk_expr_rvalue(b, a)?);
                }
                Ok(b.intrinsic(intr_kind, arg_vals))
            }
        }
    }

    /// Walk an expression in lvalue position -- the result is the
    /// `ValueId` of the lvalue's *address*. The `Assign` rhs and
    /// `Unary{AddrOf}` cases drive into this path; the rvalue
    /// walker re-enters from this address with a matching load.
    fn walk_expr_lvalue(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::Ident { .. } => self.ident_address(b, id),
            Expr::Unary {
                op: UnOp::Deref,
                child,
                ..
            } => self.walk_expr_rvalue(b, *child),
            // Pointer-arithmetic-derived lvalues: `t->f = v` lowers
            // to `*(t + field_off) = v`, the parser absorbs the
            // Deref into the address expression, and the Assign's
            // lhs reaches the walker as `Binary{Add, t, off}`.
            // The Binary's value IS the address per C99 6.5.6
            // pointer-plus-integer.
            Expr::Binary { .. } => self.walk_expr_rvalue(b, id),
            // Indexed lvalue: `arr[i] = v`. Compute the address
            // (`arr + i`) without the trailing load that
            // `walk_expr_rvalue` would emit.
            Expr::Index { array, idx, .. } => {
                let (array_id, idx_id) = (*array, *idx);
                let arr = self.walk_expr_rvalue(b, array_id)?;
                let i = self.walk_expr_rvalue(b, idx_id)?;
                Ok(b.binop(BinOp::Add, arr, i))
            }
            // Member lvalue: `s.f = v` / `p->f = v`. Address is
            // the object's address-producer plus the field
            // offset; no trailing load.
            Expr::Member { obj, field_off, .. } => {
                let obj_id = *obj;
                let off = *field_off;
                let base = self.walk_expr_rvalue(b, obj_id)?;
                if off != 0 {
                    Ok(b.binop_imm(BinOp::Add, base, off))
                } else {
                    Ok(base)
                }
            }
            other => Err(WalkError::UnsupportedExpr {
                id,
                kind: lvalue_shape_label(other),
            }),
        }
    }

    /// Walk a `Expr::Unary` rvalue. AddrOf hands off to the
    /// lvalue walk; Deref loads from the rvalue-shaped address;
    /// Neg / BitNot / LogNot lower to a binop against an
    /// immediate.
    fn walk_unary(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        op: UnOp,
        child: ExprId,
        ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match op {
            UnOp::Neg => {
                let v = self.walk_expr_rvalue(b, child)?;
                if is_floating_scalar(ty) {
                    Ok(b.fneg(v))
                } else {
                    let zero = b.imm(0);
                    Ok(b.binop(BinOp::Sub, zero, v))
                }
            }
            UnOp::BitNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                let all_ones = b.imm(-1);
                Ok(b.binop(BinOp::Xor, v, all_ones))
            }
            UnOp::LogNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                let zero = b.imm(0);
                Ok(b.binop(BinOp::Eq, v, zero))
            }
            UnOp::AddrOf => self.walk_expr_lvalue(b, child),
            UnOp::Deref => {
                let addr = self.walk_expr_rvalue(b, child)?;
                // C99 6.5.3.2p4 + the c5 address-as-value rule:
                // dereferencing a pointer to a struct value
                // produces an rvalue whose representation is the
                // struct's address. Skip the trailing load --
                // the enclosing site (struct Assign / Mcpy /
                // Member chain) consumes the address.
                if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                    return Ok(addr);
                }
                let kind = load_kind_for(ty, self.target);
                Ok(b.load(addr, kind))
            }
        }
    }

    /// Address-of for an identifier. Locals lower to a
    /// `local_addr` against the symbol's slot offset; globals to
    /// an `imm_data` against the symbol's data offset; functions
    /// to an `imm_code` against the function's bytecode PC.
    /// Token::Sys and TLS variants surface as unsupported until
    /// their walker arms land.
    fn ident_address(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let Expr::Ident {
            sym,
            class,
            val,
            is_thread_local,
            ..
        } = self.ast.expr(id)
        else {
            return Err(WalkError::UnsupportedExpr {
                id,
                kind: lvalue_shape_label(self.ast.expr(id)),
            });
        };
        if *class == Token::Loc as i64 {
            Ok(b.local_addr(*val))
        } else if *class == Token::Glo as i64 {
            if *is_thread_local {
                Ok(b.tls_addr(*val))
            } else {
                let live_val = self.live_glo_val(*sym, *val);
                Ok(b.imm_data(live_val))
            }
        } else if *class == Token::Fun as i64 {
            // Sys-trampoline symbols are added late and have
            // their `val` filled in by `emit_sys_trampolines`
            // -- AFTER `ast_emit_ident` snapshotted 0. Read
            // the live value off the symbol table (Token::Fun
            // is not shadowable so this is safe). The walker
            // sym is the same index the parser stored, so the
            // lookup hits the same entry the trampoline emit
            // updated.
            let live_val = if (*sym as usize) < self.symbols.len()
                && self.symbols[*sym as usize].class == Token::Fun as i64
            {
                self.symbols[*sym as usize].val
            } else {
                *val
            };
            Ok(b.imm_code(live_val as usize))
        } else {
            Err(WalkError::UnknownSymbolClass {
                sym: *sym,
                class: *class,
            })
        }
    }

    /// Identifier rvalue: take the address, load through the
    /// type-appropriate `LoadKind`. The bytecode tier's `Op::Lea
    /// N; Op::Li` (etc.) collapses into this one address + load
    /// pair on the SSA side. Reads `class` / `val` /
    /// `is_thread_local` straight off the snapshotted Ident node
    /// so a post-parse scope-exit that restored the symbol's
    /// pre-declaration tag doesn't invalidate the walker.
    fn load_ident_rvalue(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        _sym: u32,
        ty: i64,
        class: i64,
        val: i64,
        is_thread_local: bool,
        array_size: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        // The parser snapshotted `val` as the `Op::Ent` PC the
        // pre-optimizer saw. The bytecode optimizer can shift
        // `Op::Ent`; for `Token::Fun` references the live PC
        // lives on `self.symbols[sym].val`. Other classes
        // (`Token::Loc` / `Token::Glo` / `Token::Num`) carry
        // a stable per-frame slot / data offset / constant the
        // optimizer never rewrites, so the snapshot stays
        // correct.
        let val: i64 = if class == Token::Fun as i64 {
            self.live_fun_val(_sym, val)
        } else if class == Token::Glo as i64 && !is_thread_local {
            self.live_glo_val(_sym, val)
        } else {
            val
        };
        // C99 6.3.2.1p3 + c5's address-as-value rule: an lvalue
        // of array type, or a struct value (non-pointer struct
        // type), is consumed as its address rather than its
        // contents -- no trailing load. `array_size != 0` flags
        // arrays; the type tag indicates a struct value when
        // `is_struct_ty(ty) && struct_ptr_depth(ty) == 0`. Both
        // shapes route through the lvalue helper so the walker
        // emits just the address producer. The fields are
        // snapshotted at parse time on `Expr::Ident` so this
        // path keeps working after the function-end shadow
        // restoration unbinds the symbol's outer-scope value.
        let address_only =
            array_size != 0 || (is_struct_ty(ty) && struct_ptr_depth(ty) == 0);
        if address_only {
            if class == Token::Loc as i64 {
                return Ok(b.local_addr(val));
            } else if class == Token::Glo as i64 && !is_thread_local {
                return Ok(b.imm_data(val));
            } else if class == Token::Glo as i64 && is_thread_local {
                return Ok(b.tls_addr(val));
            }
        }
        if class == Token::Loc as i64 {
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local(val, kind))
        } else if class == Token::Glo as i64 && !is_thread_local {
            let addr = b.imm_data(val);
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr, kind))
        } else if class == Token::Glo as i64 && is_thread_local {
            let addr = b.tls_addr(val);
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr, kind))
        } else if class == Token::Fun as i64 {
            Ok(b.imm_code(val as usize))
        } else if class == Token::Num as i64 {
            // Enum constants and `#define`-via-const-decl idioms
            // both surface as `Token::Num`-class symbols; `val`
            // holds the resolved integer constant.
            Ok(b.imm(val))
        } else {
            Err(WalkError::UnknownSymbolClass { sym: _sym, class })
        }
    }
}

/// Map a c5 type tag to the matching `LoadKind`. Mirrors
/// `compiler::types::load_op_for` but produces the SSA-side enum
/// directly so the walker doesn't have to round-trip through
/// `Op::*`.
fn load_kind_for(ty: i64, target: Target) -> LoadKind {
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return LoadKind::I64;
    }
    if stripped == Ty::Char as i64 {
        if unsigned { LoadKind::U8 } else { LoadKind::I8 }
    } else if stripped == Ty::Short as i64 {
        if unsigned {
            LoadKind::U16
        } else {
            LoadKind::I16
        }
    } else if stripped == Ty::Int as i64 {
        if unsigned {
            LoadKind::U32
        } else {
            LoadKind::I32
        }
    } else if stripped == Ty::Float as i64 {
        LoadKind::F32
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        if unsigned {
            LoadKind::U32
        } else {
            LoadKind::I32
        }
    } else {
        LoadKind::I64
    }
}

/// Mirror of [`load_kind_for`] for stores.
fn store_kind_for(ty: i64, target: Target) -> StoreKind {
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return StoreKind::I64;
    }
    if stripped == Ty::Char as i64 {
        StoreKind::I8
    } else if stripped == Ty::Short as i64 {
        StoreKind::I16
    } else if stripped == Ty::Int as i64 {
        StoreKind::I32
    } else if stripped == Ty::Float as i64 {
        StoreKind::F32
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        StoreKind::I32
    } else {
        StoreKind::I64
    }
}

/// Test for a pointer-shaped type tag. Mirrors
/// `compiler::types::is_pointer_ty` -- each non-integer family
/// (float, double, long, short, long long) reserves its own band
/// and adds +2 per pointer level; the integer family (char / int)
/// shares the base band so `char*` is encoded as `Ty::Ptr` (2),
/// `int*` as `Ty::Int + Ty::Ptr` (3), `char**` as 4, `int**` as 5,
/// and any `ty >= Ty::Ptr` in the base band is a pointer
/// regardless of the parity. Earlier `(off % 2) == 0` test
/// misclassified `int*` (off=3) as a non-pointer.
fn is_pointer_ty(ty: i64) -> bool {
    let stripped = ty & !UNSIGNED_BIT;
    let base = stripped - (stripped % 100);
    let off = stripped - base;
    if base == 0 {
        // char / int family: any tag at or beyond `Ty::Ptr` is a
        // pointer (`char*`=2, `int*`=3, `char**`=4, `int**`=5, ...).
        off >= Ty::Ptr as i64
    } else {
        // float / double / long / short / longlong: pointer levels
        // are even offsets >= 2 from the band base.
        off >= 2 && (off % 2) == 0
    }
}

/// Test for floating-point scalar types.
fn is_floating_scalar(ty: i64) -> bool {
    let stripped = ty & !UNSIGNED_BIT;
    stripped == Ty::Float as i64 || stripped == Ty::Double as i64
}

/// `Token::Ty` unsigned-bit position. The compiler-side helper is
/// `pub(super)`-visible to the parser module only; the walker
/// keeps a local copy to avoid coupling to the compiler module.
const UNSIGNED_BIT: i64 = 1 << 30;

/// Struct-type band base + stride. Mirrors
/// `compiler::types::{STRUCT_BASE, STRUCT_STRIDE}` so the walker
/// can classify struct values without crossing the module boundary.
const STRUCT_BASE: i64 = 1000;
const STRUCT_STRIDE: i64 = 1000;

/// Read the type tag off an expression node. Returns `None` for
/// shapes that don't carry one (`Sizeof` is constant-evaluated
/// and the walker doesn't peek into the result; intrinsics carry
/// their own `ty`).
fn expr_ty(e: &Expr) -> Option<i64> {
    match e {
        Expr::IntLit { ty, .. }
        | Expr::FloatLit { ty, .. }
        | Expr::StrLit { ty, .. }
        | Expr::Ident { ty, .. }
        | Expr::Unary { ty, .. }
        | Expr::Binary { ty, .. }
        | Expr::Ternary { ty, .. }
        | Expr::Call { ty, .. }
        | Expr::Member { ty, .. }
        | Expr::Index { ty, .. }
        | Expr::Assign { ty, .. }
        | Expr::BitfieldAssign { ty, .. }
        | Expr::CompoundAssign { ty, .. }
        | Expr::PreInc { ty, .. }
        | Expr::PostInc { ty, .. }
        | Expr::Comma { ty, .. }
        | Expr::ShortCircuit { ty, .. }
        | Expr::Intrinsic { ty, .. } => Some(*ty),
        Expr::Cast { to_ty, .. } => Some(*to_ty),
        Expr::Sizeof(s) => Some(s.result_ty),
    }
}

/// Byte size of a C type tag at the active target. Mirrors
/// `compiler::types::size_of_type` for the scalar / pointer / FP
/// cases the walker handles. Returns 0 for types whose width
/// the walker can't compute (struct types, function types -- the
/// walker doesn't currently consume those in cast positions).
fn type_size_bytes(ty: i64, target: Target) -> usize {
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return 8;
    }
    if stripped == Ty::Char as i64 {
        1
    } else if stripped == Ty::Short as i64 {
        2
    } else if stripped == Ty::Int as i64 {
        4
    } else if stripped == Ty::Float as i64 {
        4
    } else if stripped == Ty::Double as i64 {
        8
    } else if stripped == Ty::Long as i64 {
        if target.is_windows() { 4 } else { 8 }
    } else if stripped == Ty::LongLong as i64 {
        8
    } else {
        0
    }
}

/// Return the AND mask needed to narrow an unsigned-typed
/// operand of an integer divide / modulo to its declared storage
/// width. Returns `0` (no mask) for I64-wide types and for any
/// signed type. Mirrors `convert.rs::maybe_mask_operands_to_unsigned_common`
/// but takes only the common type tag and lets the walker apply
/// the mask through `BinopI(And, _, mask)` rather than the c5
/// scratch-local sequence the bytecode tier uses.
fn unsigned_narrow_mask(ty: i64) -> i64 {
    let stripped = ty & !UNSIGNED_BIT;
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    if !unsigned {
        return 0;
    }
    if stripped == Ty::Char as i64 {
        0xff
    } else if stripped == Ty::Short as i64 {
        0xffff
    } else if stripped == Ty::Int as i64 {
        0xffff_ffff
    } else {
        0
    }
}

/// Test whether `ty` lands in the struct band.
fn is_struct_ty(ty: i64) -> bool {
    (ty & !UNSIGNED_BIT) >= STRUCT_BASE
}

/// Pointer-depth count inside the struct band. Mirrors
/// `compiler::types::struct_ptr_depth`. Zero means struct value;
/// >= 1 means a pointer to the struct (or deeper indirection).
fn struct_ptr_depth(ty: i64) -> i64 {
    let stripped = ty & !UNSIGNED_BIT;
    ((stripped - STRUCT_BASE) % STRUCT_STRIDE) / Ty::Ptr as i64
}

fn lvalue_shape_label(expr: &Expr) -> &'static str {
    match expr {
        Expr::IntLit { .. } => "IntLit",
        Expr::FloatLit { .. } => "FloatLit",
        Expr::StrLit { .. } => "StrLit",
        Expr::Ident { .. } => "Ident",
        Expr::Unary { .. } => "Unary",
        Expr::Binary { .. } => "Binary",
        Expr::Ternary { .. } => "Ternary",
        Expr::Call { .. } => "Call",
        Expr::Member { .. } => "Member",
        Expr::Index { .. } => "Index",
        Expr::Cast { .. } => "Cast",
        Expr::Assign { .. } => "Assign",
        Expr::BitfieldAssign { .. } => "BitfieldAssign",
        Expr::CompoundAssign { .. } => "CompoundAssign",
        Expr::PreInc { .. } => "PreInc",
        Expr::PostInc { .. } => "PostInc",
        Expr::Sizeof(_) => "Sizeof",
        Expr::Comma { .. } => "Comma",
        Expr::Intrinsic { .. } => "Intrinsic",
        Expr::ShortCircuit { .. } => "ShortCircuit",
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{BinOp, Inst};
    use super::super::super::symbol::Symbol;
    use super::super::super::token::Token;
    use super::super::Ast;
    use super::super::*;
    use super::*;

    fn empty_symbols() -> alloc::vec::Vec<Symbol> {
        alloc::vec::Vec::new()
    }

    /// `return 7 + 3;` -- walker produces two Imm + one Add binop
    /// and a Return terminator on the entry block. Locks the
    /// expression recursion + the basic Return wiring.
    #[test]
    fn return_constant_add() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let seven = ast.push_expr(Expr::IntLit { val: 7, ty: 1 }, src);
        let three = ast.push_expr(Expr::IntLit { val: 3, ty: 1 }, src);
        let add = ast.push_expr(
            Expr::Binary {
                op: BinOp::Add,
                lhs: seven,
                rhs: three,
                ty: 1,
            },
            src,
        );
        let __ret = ast.push_stmt(Stmt::Return(Some(add)), src);
        ast.body = Some(__ret);

        let func = walk_function(&ast, &empty_symbols(), &[], Target::LinuxAarch64, 0, 0, false, 0, &[], &[], false, 0, 0)
            .expect("walk");
        let immediates: alloc::vec::Vec<i64> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(v) => Some(*v),
                _ => None,
            })
            .collect();
        assert_eq!(immediates, alloc::vec![7i64, 3]);
        let binops: alloc::vec::Vec<BinOp> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Binop { op, .. } => Some(*op),
                _ => None,
            })
            .collect();
        assert_eq!(binops, alloc::vec![BinOp::Add]);
    }

    /// Identifier rvalue against a local symbol: walker emits a
    /// `LoadLocal { off, kind: I32 }` for an `int` local.
    #[test]
    fn local_int_ident_loads() {
        let mut syms = empty_symbols();
        syms.push(Symbol {
            name: alloc::string::String::from("x"),
            class: Token::Loc as i64,
            type_: Ty::Int as i64,
            val: -1,
            ..Default::default()
        });

        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let x = ast.push_expr(
            Expr::Ident {
                sym: 0,
                ty: Ty::Int as i64,
                class: Token::Loc as i64,
                val: -1,
                is_thread_local: false,
                array_size: 0,
            },
            src,
        );
        let __ret = ast.push_stmt(Stmt::Return(Some(x)), src);
        ast.body = Some(__ret);

        let func = walk_function(&ast, &syms, &[], Target::LinuxAarch64, 0, 0, false, 8, &[], &[], false, 0, 0).expect("walk");
        let loads: alloc::vec::Vec<_> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::LoadLocal { off, kind } => Some((*off, *kind)),
                _ => None,
            })
            .collect();
        assert_eq!(loads, alloc::vec![(-1, LoadKind::I32)]);
    }

    /// Assignment lowers as: address-of-lhs + value-of-rhs + Store.
    #[test]
    fn local_int_assign_emits_store() {
        let mut syms = empty_symbols();
        syms.push(Symbol {
            name: alloc::string::String::from("x"),
            class: Token::Loc as i64,
            type_: Ty::Int as i64,
            val: -1,
            ..Default::default()
        });

        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let lhs = ast.push_expr(
            Expr::Ident {
                sym: 0,
                ty: Ty::Int as i64,
                class: Token::Loc as i64,
                val: -1,
                is_thread_local: false,
                array_size: 0,
            },
            src,
        );
        let rhs = ast.push_expr(
            Expr::IntLit {
                val: 42,
                ty: Ty::Int as i64,
            },
            src,
        );
        let assign = ast.push_expr(
            Expr::Assign {
                lhs,
                rhs,
                ty: Ty::Int as i64,
            },
            src,
        );
        let __ret = ast.push_stmt(Stmt::Return(Some(assign)), src);
        ast.body = Some(__ret);

        let func = walk_function(&ast, &syms, &[], Target::LinuxAarch64, 0, 0, false, 8, &[], &[], false, 0, 0).expect("walk");
        let store_kinds: alloc::vec::Vec<_> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Store { kind, .. } => Some(*kind),
                _ => None,
            })
            .collect();
        assert_eq!(store_kinds, alloc::vec![StoreKind::I32]);
        // The Return's value should reach the same Imm 42 the
        // assignment used (C99 6.5.16p3 says the assignment
        // expression's value is the value stored).
        let immediates: alloc::vec::Vec<i64> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(v) => Some(*v),
                _ => None,
            })
            .collect();
        assert!(immediates.contains(&42));
    }

    /// Unary negation: walker lowers `-x` as `0 - x`. Locks the
    /// Neg dispatch path.
    #[test]
    fn unary_neg_lowers_to_sub() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let lit = ast.push_expr(
            Expr::IntLit {
                val: 5,
                ty: Ty::Int as i64,
            },
            src,
        );
        let neg = ast.push_expr(
            Expr::Unary {
                op: UnOp::Neg,
                child: lit,
                ty: Ty::Int as i64,
            },
            src,
        );
        let __ret = ast.push_stmt(Stmt::Return(Some(neg)), src);
        ast.body = Some(__ret);

        let func = walk_function(&ast, &empty_symbols(), &[], Target::LinuxAarch64, 0, 0, false, 0, &[], &[], false, 0, 0)
            .expect("walk");
        let binops: alloc::vec::Vec<BinOp> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Binop { op, .. } => Some(*op),
                _ => None,
            })
            .collect();
        assert_eq!(binops, alloc::vec![BinOp::Sub]);
    }

    /// An unsupported statement (`Asm`) surfaces as a
    /// `WalkError::UnsupportedStmt` so the validator can route
    /// the gap back to a parser site.
    #[test]
    fn unsupported_stmt_returns_error() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let asm_id = ast.push_stmt(
            Stmt::Asm {
                text: alloc::string::String::new(),
                clobbers: alloc::string::String::new(),
            },
            src,
        );
        ast.body = Some(asm_id);

        let err = walk_function(&ast, &empty_symbols(), &[], Target::LinuxAarch64, 0, 0, false, 0, &[], &[], false, 0, 0)
            .expect_err("Asm must surface as unsupported");
        assert!(matches!(
            err,
            WalkError::UnsupportedStmt { kind: "Asm", .. }
        ));
    }
}
