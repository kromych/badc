//! `Ast` -> `FunctionSsa` walker.
//!
//! Drives `SsaBuilder` from a per-function AST. The walker is the
//! production SSA source for every parsed function. An AST shape
//! the walker can't lower comes back as `WalkError` so the
//! caller (`codegen::ssa_shadow::produce_ssa_funcs`) can surface
//! the offending node.

#![allow(dead_code)]

use alloc::string::String;

use super::super::codegen::Target;
use super::super::ir::{BinOp, FunctionSsa, LoadKind, StoreKind};
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::{AtomicKind, Expr, ExprId, Stmt, StmtId, UnOp};

/// Diagnostic for a shape the walker can't lower yet. Carries
/// enough context to point at the offending AST node so the
/// caller can route the gap back to a parser site.
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
/// slot count (`max_loc_offs`). `ent_pc` is the function's entry
/// identifier -- the SSA emit threads it through so the
/// post-link codegen can resolve call-site fixups against the
/// same identifier the linker rebased.
#[allow(clippy::too_many_arguments)]
pub(crate) fn walk_function(
    ast: &super::Ast,
    symbols: &[Symbol],
    structs: &[crate::c5::compiler::StructDef],
    target: Target,
    ent_pc: usize,
    end_pc: usize,
    n_params: usize,
    is_variadic: bool,
    n_locals: i64,
    param_tys: &[i64],
    param_local_slots: &[i64],
    returns_struct: bool,
    return_struct_size: i64,
    return_ty: i64,
    alloca_top_slot: i64,
) -> Result<FunctionSsa, WalkError> {
    let mut b = super::super::codegen::ssa_build::SsaBuilder::new(ent_pc, n_params, is_variadic);
    b.set_end_pc(end_pc);
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
    // Per-function alloca-arena bookkeeping setup.
    // `alloca_top_slot == 0` means the body has no `alloca` call;
    // the per-arch emit short-circuits a zero slot without
    // writing native code. A non-zero slot tells the codegen to
    // reserve the per-frame arena and store the running top into
    // the named local slot.
    b.alloca_init(alloca_top_slot);
    // C99 6.8.6.4 + AAPCS64 6.9: classify the return convention. An
    // integer aggregate of at most 16 bytes returns in x0/x1; a larger
    // one returns through the caller-supplied x8 indirect-result
    // register. Both carry no hidden argument, so their parameters
    // start at slot 2. Every other aggregate keeps the c5 out-pointer
    // convention (hidden pointer at slot 2, parameters start at 3).
    use crate::c5::compiler::StructReturnAbi;
    let ret_abi = crate::c5::compiler::struct_return_abi(structs, target, return_ty);
    let ret_outptr = matches!(ret_abi, StructReturnAbi::OutPtr);
    let ret_in_regs = matches!(ret_abi, StructReturnAbi::Regs(_));
    let ret_indirect = matches!(ret_abi, StructReturnAbi::Indirect(_));
    if let StructReturnAbi::Regs(desc) | StructReturnAbi::Indirect(desc) = &ret_abi {
        let idx = b.intern_agg_desc(desc.clone());
        b.set_ret_agg(idx);
    }
    b.set_ret_is_fp(is_floating_scalar(return_ty));
    // A function returning > 16 bytes saves the incoming x8 result
    // pointer into a dedicated local for the codegen prologue; the
    // `return` lowering writes the value through it.
    let indirect_result_slot: i64 = if ret_indirect {
        let slot = b.alloc_synthetic_local();
        b.set_indirect_result_slot(slot);
        slot
    } else {
        0
    };
    // C99 6.5.2.2 + the host ABI (AAPCS64 6.8.2): a small aggregate
    // parameter arrives in argument registers rather than by the
    // caller's address. Classify each by-value struct parameter; a
    // tagged parameter gets no SSA entry-copy below -- the callee
    // prologue (native) and `run_func` (VM) write the incoming bytes
    // straight into the parser-reserved body local recorded in
    // `param_local_slots[i]`. Variadic and out-pointer-returning
    // callees keep the c5 by-address shape (the hidden out-pointer
    // shifts every parameter cell), so they are excluded; host-ABI
    // returns (registers / x8) leave the parameter slots unshifted.
    let mut param_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
    // Parallel per-parameter aggregate classification, consumed below by
    // the argument-register planner so the `ParamRef` seed loop knows
    // which scalar parameters an aggregate pushed past the argument
    // registers onto the host stack.
    let mut param_arg_aggs: alloc::vec::Vec<Option<crate::c5::codegen::ArgAgg>> =
        alloc::vec::Vec::new();
    if !is_variadic && !ret_outptr {
        param_aggs = alloc::vec![None; param_tys.len()];
        param_arg_aggs = alloc::vec![None; param_tys.len()];
        for (i, &pty) in param_tys.iter().enumerate() {
            if let Some(desc) = crate::c5::compiler::host_abi_agg_desc(structs, target, pty) {
                param_arg_aggs[i] = Some(crate::c5::codegen::ArgAgg {
                    class: crate::c5::codegen::abi_classify::classify_aggregate(
                        desc.size,
                        desc.align,
                        &desc.fields,
                        target.abi(),
                        false,
                    ),
                    size: desc.size,
                });
                let idx = b.intern_agg_desc(desc);
                param_aggs[i] = Some(idx);
            }
        }
    }
    let has_struct_params = param_aggs.iter().any(Option::is_some);
    if has_struct_params {
        b.set_param_aggs(param_aggs.clone(), param_local_slots.to_vec());
    }
    // C99 6.5.2.2 + the c5 calling convention: for each
    // struct-by-value parameter, the caller passes the
    // source's address in slot `i + base` (base = 2, or 3
    // when a struct-returning callee uses slot 2 as the
    // hidden out-pointer). The callee's prologue copies the
    // struct into a fresh local; the parser allocated the
    // local and recorded its offset in `param_local_slots[i]`,
    // and shifted the symbol's `val` to point at it. The walker
    // emits the matching `Inst::Mcpy` here so the SSA carries the
    // entry-copy semantics.
    // Argument-slot base: 2 for ordinary callees, 3 when the
    // function returns a struct value (slot 2 holds the hidden
    // out-pointer the caller pushed in front of the declared
    // args). The parser's symbol-table assignment uses the same
    // base, so this index matches the `val` the parser stored
    // for each declared param.
    let arg_slot_base: i64 = if ret_outptr { 3 } else { 2 };
    // C99 6.2.5p10 + the host ABI (System V AMD64 3.2.3 / AAPCS64
    // 6.4.1): a floating-point scalar parameter passed in an FP
    // argument register. Record the per-parameter FP mask so the
    // callee emit resolves each parameter's incoming register
    // through `plan_call_args`, the same ABI planner the caller
    // uses. Independent int / FP register banks mean an int
    // parameter after an FP parameter does not lose an int arg
    // register to the FP one. Variadic and struct-returning callees
    // keep the c5 cdecl shape (their args ride the c5 stack / a
    // hidden out-pointer shifts every cell), so they are excluded
    // here exactly as they are from the seed loop below.
    if !is_variadic && !ret_outptr {
        for (i, &pty) in param_tys.iter().enumerate() {
            let stripped = pty & !(1i64 << 30);
            let is_pointer = pty & (1i64 << 30) != 0;
            if !is_pointer
                && (stripped == crate::c5::token::Ty::Float as i64
                    || stripped == crate::c5::token::Ty::Double as i64)
            {
                b.mark_param_fp(i);
            }
        }
        // Clear the mask when the placement would interleave register
        // and host-stack parameters: the c5 cdecl cell layout requires a
        // contiguous register prefix, so such a function falls back to
        // the all-integer ABI. The caller applies the same predicate to
        // its `fp_arg_mask`, so the two ends stay in agreement.
        let eff = super::super::codegen::effective_fp_arg_mask(
            param_tys.len(),
            b.param_fp_mask(),
            target.abi(),
        );
        b.set_param_fp_mask(eff);
    }
    // Per-parameter incoming-register plan, resolved once for both the
    // integer/double seed loop and the float-narrow loop below. A
    // floating-point parameter is seeded with an FP `ParamRef` only
    // when the plan placed it in an FP register; one that overflowed to
    // the host stack reads its c5 cdecl cell instead.
    let param_plan = super::super::codegen::plan_param_regs_aggs(
        param_tys.len(),
        b.param_fp_mask(),
        target.abi(),
        &param_arg_aggs,
    );
    let param_in_fp_reg = |i: usize| -> bool {
        matches!(
            param_plan.placements.get(i),
            Some(super::super::codegen::ArgPlacement::FpReg(_))
        )
    };
    // Parameter-slot promotion seed: for each non-relocated,
    // non-struct, non-float-narrowed parameter, emit a `ParamRef`
    // + `StoreLocal` to the c5 cdecl arg slot. The store gives
    // mem2reg a single reaching def for the slot so per-use
    // `LoadLocal` reads in the body can be folded onto the
    // `ParamRef` value, eliminating the per-use ldursw / mov rN
    // reloads. Variadic functions skip this -- their args ride
    // the c5 stack, not host arg regs, and the prologue does
    // not spill into the host-arg-reg slots. Struct-returning
    // callees skip this -- the hidden out-pointer shifts every
    // declared param's incoming arg reg up by one, which
    // `Inst::ParamRef(i)`'s direct `int_arg_regs[i]` index does
    // not handle. This loop runs before the struct / float
    // entry-copy loop below so `Inst::ParamRef` reads the host
    // arg register while it still holds the caller-supplied
    // value: the struct mcpy emits scratch writes (its result
    // place can land on any caller-saved reg, including a host
    // arg reg) and any reordering would let those writes clobber
    // the incoming argument before its `ParamRef` materialised.
    if !is_variadic && !ret_outptr {
        for i in 0..param_tys.len() {
            let pty = param_tys[i];
            let local_slot = param_local_slots[i];
            if local_slot < 0 {
                continue;
            }
            let stripped = pty & !(1i64 << 30);
            let is_struct_value =
                stripped >= STRUCT_BASE && ((stripped - STRUCT_BASE) % STRUCT_STRIDE) / 2 == 0;
            if is_struct_value {
                continue;
            }
            // Floating-point params arrive in an FP argument register
            // (C99 6.2.5p10). A `double` keeps its original positive
            // cell (`param_local_slots[i] == 0`); seed it with an FP
            // `ParamRef { F64 }` + `StoreLocal { F64 }` so mem2reg has
            // a reaching def in the FP register file and the body's
            // `LoadLocal { F64 }` reads can fold onto it -- exactly the
            // promotion the integer path below performs. A `float`
            // param was repointed by the parser to a negative narrow-
            // storage local (`param_local_slots[i] < 0`, skipped at the
            // top of the loop); its entry narrow stays on the parser's
            // dance, fed by the prologue's widen-to-f64 spill of the
            // incoming s-register.
            let is_float = stripped == crate::c5::token::Ty::Float as i64;
            let is_double = stripped == crate::c5::token::Ty::Double as i64;
            if is_double {
                if param_in_fp_reg(i) {
                    let arg_slot = (i as i64) + arg_slot_base;
                    let pr = b.param_ref(i as u32, super::super::ir::LoadKind::F64);
                    b.store_local(arg_slot, pr, super::super::ir::StoreKind::F64);
                }
                continue;
            }
            if is_float {
                continue;
            }
            // Seed an integer `ParamRef` only when the planner placed this
            // parameter in an integer argument register. An aggregate
            // earlier in the list can consume several registers (or one
            // by-reference pointer register), pushing a later scalar that
            // would fit by position onto the host stack; such a parameter
            // has no incoming register and reads its c5 cdecl cell, which
            // the prologue restripes from the incoming stack.
            if !matches!(
                param_plan.placements.get(i),
                Some(super::super::codegen::ArgPlacement::IntReg(_))
            ) {
                continue;
            }
            // Pointer-typed parameters carry the pointer marker
            // bit; the body reads them as full-width pointers
            // (8 bytes), not as the base type's narrow width.
            // Without this check `char *fmt` would store only one
            // byte and the high bits would diverge from the
            // prologue's full-width spill.
            use crate::c5::token::Ty;
            let is_pointer = pty & (1i64 << 30) != 0;
            let (store_kind, load_kind) = if is_pointer {
                (
                    super::super::ir::StoreKind::I64,
                    super::super::ir::LoadKind::I64,
                )
            } else {
                match stripped {
                    s if s == Ty::Char as i64 => (
                        super::super::ir::StoreKind::I8,
                        super::super::ir::LoadKind::I8,
                    ),
                    s if s == Ty::Short as i64 => (
                        super::super::ir::StoreKind::I16,
                        super::super::ir::LoadKind::I16,
                    ),
                    s if s == Ty::Int as i64 => (
                        super::super::ir::StoreKind::I32,
                        super::super::ir::LoadKind::I32,
                    ),
                    _ => (
                        super::super::ir::StoreKind::I64,
                        super::super::ir::LoadKind::I64,
                    ),
                }
            };
            let arg_slot = (i as i64) + arg_slot_base;
            let pr = b.param_ref(i as u32, load_kind);
            b.store_local(arg_slot, pr, store_kind);
        }
    }
    for i in 0..param_tys.len() {
        let pty = param_tys[i];
        let local_slot = param_local_slots[i];
        if local_slot >= 0 {
            continue;
        }
        let stripped = pty & !(1i64 << 30);
        let is_struct_value =
            stripped >= STRUCT_BASE && ((stripped - STRUCT_BASE) % STRUCT_STRIDE) / 2 == 0;
        if is_struct_value {
            // Host-ABI register-passed parameter: no entry copy. The
            // backend scatters the incoming argument registers (native)
            // or copies the argument bytes (VM) straight into this
            // body local.
            if param_aggs.get(i).copied().flatten().is_some() {
                continue;
            }
            let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
            if id >= structs.len() {
                continue;
            }
            let size = structs[id].size as i64;
            let arg_slot = (i as i64) + arg_slot_base;
            let dst = b.local_addr(local_slot);
            let src = b.load_local(arg_slot, super::super::ir::LoadKind::I64);
            b.mcpy(dst, src, size);
            continue;
        }
        // `float`-by-value param. The parser repointed the symbol to a
        // 4-byte narrow-storage local (`local_slot < 0`).
        let is_float = stripped == crate::c5::token::Ty::Float as i64;
        if is_float {
            if !is_variadic && !ret_outptr && param_in_fp_reg(i) {
                // The argument arrives at single precision in an FP
                // argument register (C99 6.2.5p10). Seed an FP
                // `ParamRef { F32 }` (the s-register view) and store it
                // into the local with `StoreKind::F32`. The value never
                // round-trips through the positive c5 cdecl cell, so
                // that cell stays unobserved and the prologue's spill of
                // it is elided. A direct `StoreLocal` (not the
                // address-taken form) keeps the slot mem2reg-promotable.
                let pr = b.param_ref(i as u32, super::super::ir::LoadKind::F32);
                b.mark_f32(pr);
                b.store_local(local_slot, pr, super::super::ir::StoreKind::F32);
            } else if b.param_fp_mask() != 0 {
                // Host-stack-overflow `float` parameter (more than eight
                // preceding FP parameters) under the FP-register ABI: the
                // caller pushed it at single precision into the c5 cdecl
                // cell. Read the cell as `F32` (widening to f64) and
                // narrow back into the local.
                let arg_slot = (i as i64) + arg_slot_base;
                let val = b.load_local(arg_slot, super::super::ir::LoadKind::F32);
                b.store_local(local_slot, val, super::super::ir::StoreKind::F32);
            } else {
                // Variadic / struct-returning callees keep the c5 cdecl
                // shape: the caller widened the `float` to an 8-byte
                // double in the integer-passed cell. Read the cell as
                // I64 (preserving the bit pattern) and narrow back via a
                // `StoreKind::F32` into the local.
                let arg_slot = (i as i64) + arg_slot_base;
                let val = b.load_local(arg_slot, super::super::ir::LoadKind::I64);
                b.store_local(local_slot, val, super::super::ir::StoreKind::F32);
            }
        }
    }
    let mut ctx = Walker {
        ast,
        symbols,
        structs,
        target,
        loop_ctx: alloc::vec::Vec::new(),
        label_blocks: alloc::vec::Vec::new(),
        switch_dispatch: alloc::vec::Vec::new(),
        returns_struct,
        return_struct_size,
        ret_in_regs,
        ret_indirect,
        indirect_result_slot,
        scalar_return_ty: return_ty,
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

/// Resolution result for a `Token::Glo` address producer.
/// `Resolved(off)` selects `Inst::ImmData(off)`; `Extern`
/// selects `Inst::ImmData(0)` plus an entry in
/// `FunctionSsa::extern_imm_data_refs` so the linker patches
/// the slot from the merged symbol table.
#[derive(Clone, Copy)]
enum GloAddr {
    Resolved(i64),
    Extern,
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
    /// Per enclosing `switch` (innermost last): the block reserved for
    /// each `case` value and for `default`. A `case` / `default` marker
    /// reached while walking the switch body jumps to its block, so the
    /// dispatcher can target it wherever it sits -- including inside a
    /// loop nested in the switch (C99 6.8.4.2 admits a case label at any
    /// depth; the loop's back edge re-enters the body at its first case
    /// block). The blocks are allocated once by the case-collection pass
    /// before the dispatcher emits.
    #[allow(clippy::type_complexity)]
    switch_dispatch: alloc::vec::Vec<(
        alloc::vec::Vec<(i64, super::super::ir::BlockId)>,
        Option<super::super::ir::BlockId>,
    )>,
    /// True when the function's declared return type is a struct
    /// value returned through the c5 out-pointer convention. `return
    /// s;` loads the hidden out-pointer from `slot 2`, Mcpy
    /// `return_struct_size` bytes from `s`'s address into it, then
    /// returns the out-pointer. False for host-ABI returns.
    returns_struct: bool,
    /// Byte size of the struct return type when the function returns
    /// a struct by any convention. Zero otherwise.
    return_struct_size: i64,
    /// AAPCS64 register return (aggregate <= 16 bytes): `return s;`
    /// yields `s`'s address; the codegen scatters the eightbytes into
    /// x0/x1.
    ret_in_regs: bool,
    /// AAPCS64 indirect return (aggregate > 16 bytes via x8): `return
    /// s;` copies the value through the saved x8 pointer in
    /// `indirect_result_slot`, then returns that pointer.
    ret_indirect: bool,
    /// The function's declared scalar return type (C99 6.8.6.4). A
    /// `char` / `short` return is narrowed to this width before
    /// `Terminator::Return`.
    scalar_return_ty: i64,
    /// Body-local slot holding the saved x8 indirect-result pointer
    /// when `ret_indirect` is true; zero otherwise.
    indirect_result_slot: i64,
}

impl<'a> Walker<'a> {
    /// Live `ent_pc` for a `Token::Fun` symbol. Reading the
    /// symbol's current `val` lets every `Expr::Call` resolve to
    /// the matching `pc_to_native` slot the codegen will
    /// populate. Sys trampolines have their `val` patched late
    /// by `emit_sys_trampolines`; the same live-read fits both
    /// cases.
    fn live_fun_val(&self, sym: u32, fallback_val: i64) -> i64 {
        let idx = sym as usize;
        if idx < self.symbols.len() && self.symbols[idx].class == Token::Fun as i64 {
            self.symbols[idx].val
        } else {
            fallback_val
        }
    }

    /// True when the `Token::Fun` symbol is a variadic function. A
    /// variadic c5 callee keeps the c5 cdecl stack-push argument
    /// shape, so its floating-point arguments ride the integer
    /// register class as widened doubles rather than the FP bank.
    fn fun_is_variadic(&self, sym: u32) -> bool {
        let idx = sym as usize;
        idx < self.symbols.len()
            && self.symbols[idx].class == Token::Fun as i64
            && self.symbols[idx].is_variadic
    }

    /// Count of named (pre-ellipsis) parameters the `Token::Fun`
    /// symbol declares. The parser records the prototype's fixed
    /// parameter types in `Symbol::params`; a variadic callee's
    /// arguments past this count are the variadic tail. Used to
    /// split the call's arguments into the fixed (register-bank)
    /// prefix and the variadic (host-stack) tail for the macOS
    /// arm64 variadic ABI.
    fn fun_fixed_args(&self, sym: u32) -> usize {
        let idx = sym as usize;
        if idx < self.symbols.len() && self.symbols[idx].class == Token::Fun as i64 {
            self.symbols[idx].params.len()
        } else {
            0
        }
    }

    /// Resolve an indirect call's callee expression to the pointed-to
    /// function's `(is_variadic, fixed_arg_count)`. Three statically-
    /// typed callee shapes carry the prototype:
    ///   * a direct function name taken as a pointer (`Token::Fun`),
    ///   * a function-pointer variable whose declaration inherited the
    ///     prototype from a function-pointer typedef,
    ///   * the right operand of a comma operator (the `(side, fn)`
    ///     shape), resolved recursively.
    /// A callee with no statically-known prototype defaults to
    /// non-variadic with every argument fixed (`arg_count`), which
    /// keeps the host-ABI placement identical to a plain call.
    fn indirect_callee_proto(&self, callee: super::ExprId, arg_count: usize) -> (bool, usize) {
        match self.ast.expr(callee) {
            Expr::Ident { sym, .. } => {
                let idx = *sym as usize;
                if idx < self.symbols.len() && self.symbols[idx].is_variadic {
                    (true, self.symbols[idx].params.len())
                } else {
                    (false, arg_count)
                }
            }
            Expr::Comma { rhs, .. } => self.indirect_callee_proto(*rhs, arg_count),
            _ => (false, arg_count),
        }
    }

    /// Resolve a `Token::Glo` address producer to either an
    /// intra-unit data offset or a cross-TU symbol reference.
    ///
    /// * `GloAddr::Resolved(off)` -- use `Inst::ImmData(off)`.
    ///   The offset is unit-local pre-link (rebased by the
    ///   linker's merge) or the canonical defining unit's
    ///   absolute offset post-link.
    /// * `GloAddr::Extern` -- the symbol has no in-unit
    ///   storage in this TU. The walker emits
    ///   `Inst::ImmData(0)` and records the parser-symbol idx
    ///   in `FunctionSsa::extern_imm_data_refs`; the linker
    ///   patches the slot against the merged symbol table.
    ///
    /// A symbol with `is_extern_decl && !defined_here` takes the
    /// `GloAddr::Extern` arm and resolves through
    /// `extern_imm_data_refs` against the merged symbol table, so
    /// its parser-tentative `val` is never consulted. The AST
    /// `Expr::Ident` snapshot in `fallback_val` still carries that
    /// offset and is only used when nothing in the live entry
    /// updates it.
    fn live_glo_addr(&self, sym: u32, fallback_val: i64) -> GloAddr {
        use crate::c5::symbol::Linkage;
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.class == Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && !s.defined_here
            {
                return if s.val == 0 {
                    GloAddr::Extern
                } else {
                    GloAddr::Resolved(s.val)
                };
            }
            if s.class == Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && s.val != 0
            {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Resolved(fallback_val)
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
        let src = self.ast.stmt_src[id as usize];
        b.set_src(src.line, src.file as u32);
        match self.ast.stmt(id) {
            Stmt::Return(Some(e)) => {
                if self.ret_in_regs || self.ret_indirect {
                    // C99 6.8.6.4 + AAPCS64 6.9 host-ABI struct return:
                    // yield the struct's address. The codegen scatters
                    // the eightbytes into the result registers (<= 16
                    // bytes) or copies the value through the x8 result
                    // pointer (> 16 bytes); the VM copies it into the
                    // caller's result temp.
                    let v = self.walk_expr_rvalue(b, *e)?;
                    b.return_(v);
                    return Ok(true);
                }
                if self.returns_struct {
                    // C99 6.8.6.4 + the c5 out-pointer convention: the
                    // callee receives the caller's result-temp address
                    // in `slot 2`. `return s;` copies `sizeof(struct
                    // T)` bytes from `s`'s address into that
                    // out-pointer and returns it so the call site has a
                    // stable value to chain into the surrounding
                    // assignment / Mcpy.
                    let out_ptr = b.load_local(2, super::super::ir::LoadKind::I64);
                    let src = self.walk_expr_rvalue(b, *e)?;
                    if self.return_struct_size > 0 {
                        b.mcpy(out_ptr, src, self.return_struct_size);
                    }
                    b.return_(out_ptr);
                    return Ok(true);
                }
                let mut v = self.walk_expr_rvalue(b, *e)?;
                // C99 6.8.6.4 / 6.3.1.1: the returned value is converted to
                // the function's return type. For a `char` / `short` return
                // the ABI carries an `int`-promoted value, so a body result
                // wider than the declared type (e.g. `(x << 8) | (x >> 8)`
                // in a `uint16_t`-returning byte-swap) must be narrowed to
                // the type's width here; without it the caller reads the
                // un-narrowed bits. Integer-and-wider returns already ride
                // the result register at full width. `_Bool` is excluded: its
                // conversion is a boolean `!= 0` (6.3.1.2), not a width mask,
                // and the rvalue walk already normalizes it to 0/1.
                let stripped = self.scalar_return_ty & !UNSIGNED_BIT;
                let rs = type_size_bytes(self.scalar_return_ty, self.target);
                if !is_floating_scalar(self.scalar_return_ty)
                    && !is_pointer_ty(self.scalar_return_ty)
                    && stripped != Ty::Bool as i64
                    && (rs == 1 || rs == 2)
                {
                    if (self.scalar_return_ty & UNSIGNED_BIT) != 0 {
                        let mask: i64 = if rs == 1 { 0xff } else { 0xffff };
                        v = b.binop_imm(BinOp::And, v, mask);
                    } else {
                        let bits = 64i64 - (rs as i64) * 8;
                        let shifted = b.binop_imm(BinOp::Shl, v, bits);
                        v = b.binop_imm(BinOp::Shr, shifted, bits);
                    }
                }
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
                            // block so any earlier `goto label`,
                            // `case <val>:`, or `default:` lands
                            // somewhere walkable. Non-label dead
                            // code per C99 6.8.6 is still walked
                            // into a fresh synthetic block so the
                            // SSA covers the unreachable region;
                            // the resolver later prunes anything
                            // the codegen can elide.
                            if !b.is_block_open()
                                && !matches!(
                                    self.ast.stmt(*s),
                                    Stmt::Labeled { .. } | Stmt::Case { .. } | Stmt::Default { .. },
                                )
                            {
                                let dead = b.new_block();
                                b.switch_to(dead);
                            }
                            if self.walk_stmt(b, *s)? {
                                continue;
                            }
                        }
                        super::BlockItem::Decl(d) => {
                            // Decls in dead-code regions still go
                            // through walk_decl so the walker's
                            // local-slot bookkeeping mirrors what
                            // the parser stamped (per-decl
                            // initialiser side effects land in the
                            // same trailing dead block).
                            if !b.is_block_open() {
                                let dead = b.new_block();
                                b.switch_to(dead);
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
                let cond_v = self.walk_cond_value(b, *cond)?;
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
                let cond_v = self.walk_cond_value(b, *cond)?;
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
                let cond_v = self.walk_cond_value(b, *cond)?;
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
                // C99 6.8.5.3: for-init is either an expression
                // (`BlockItem::Stmt`) or a declaration
                // (`BlockItem::Decl`). The init runs once before
                // the cond / body / post loop; without walking
                // the declaration path the loop counter stays
                // uninitialised on every iteration.
                match init_clone {
                    Some(super::BlockItem::Stmt(s)) => {
                        let _ = self.walk_stmt(b, s)?;
                    }
                    Some(super::BlockItem::Decl(d)) => {
                        self.walk_decl(b, d)?;
                    }
                    None => {}
                }
                let header = b.new_block();
                let post_blk = b.new_block();
                let body_blk = b.new_block();
                let after = b.new_block();
                b.jmp(header);
                b.switch_to(header);
                let cond_v = match cond_clone {
                    Some(c) => self.walk_cond_value(b, c)?,
                    None => b.imm(1),
                };
                b.branch_zero(cond_v, after, body_blk);
                // C99 6.8.5.3 specifies the *evaluation* order
                // (cond, body, post) but leaves layout open. Walk
                // post before body so the SSA Inst ordering
                // matches the layout the call-fixup resolver
                // expects. Control flow is unaffected -- each
                // block's terminator routes execution in the C99
                // order regardless of inst-vec layout.
                b.switch_to(post_blk);
                if let Some(p) = post_clone {
                    let _ = self.walk_expr_rvalue(b, p)?;
                }
                b.jmp(header);
                b.switch_to(body_blk);
                self.loop_ctx.push((after, post_blk));
                let body_terminated = self.walk_stmt(b, body_clone)?;
                self.loop_ctx.pop();
                if !body_terminated {
                    b.jmp(post_blk);
                }
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
            Stmt::GotoIndirect(target) => {
                // GCC `goto *expr;`: evaluate the label-address operand
                // and close the block with an indirect branch.
                let v = self.walk_expr_rvalue(b, *target)?;
                b.goto_indirect(v);
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
                let after_blk = b.new_block();

                // Reserve a block for every case value and for default
                // (C99 6.8.4.2: case labels at any depth scope to the
                // nearest switch). The body walk below jumps to these
                // blocks at each marker, so a marker inside a nested
                // loop is still reachable from the dispatcher.
                let mut cases: alloc::vec::Vec<(i64, super::super::ir::BlockId)> =
                    alloc::vec::Vec::new();
                let mut default_blk: Option<super::super::ir::BlockId> = None;
                self.collect_switch_cases(b, body_id, &mut cases, &mut default_blk);

                // Dispatcher: a balanced binary search over the sorted
                // case values. Each internal node branches on `<` (one
                // conditional branch) and a leaf tests equality, so a
                // dispatch is O(log n) branches where a linear compare
                // chain is O(n). Case values are distinct (C99 6.8.4.2);
                // the discriminant's signedness selects the ordering and
                // the comparison so an unsigned discriminant with the
                // high bit set still sorts correctly.
                let deflt = default_blk.unwrap_or(after_blk);
                let disc_ty = expr_ty(self.ast.expr(*disc)).unwrap_or(Ty::Int as i64);
                let disc_unsigned = disc_ty & UNSIGNED_BIT != 0;
                let mut sorted = cases.clone();
                if disc_unsigned {
                    // C99 6.8.4.2p1 + p5: the controlling expression is
                    // integer-promoted, then each case label is converted to
                    // that promoted type. A 4-byte unsigned controlling type
                    // (`unsigned int`, and `unsigned long` on LLP64) promotes
                    // to itself, so a negative label wraps modulo 2^32 and
                    // must match the zero-extended discriminant -- mask it to
                    // 32 bits. An 8-byte unsigned type keeps the full-width
                    // value, which already matches. (Sub-`int` unsigned types
                    // promote to signed `int`, so a negative label stays
                    // negative and never matches a zero-extended value; those
                    // are reported as unsigned by `disc_ty` but take the plain
                    // path here with no masking.)
                    if type_size_bytes(disc_ty, self.target) == 4 {
                        for c in sorted.iter_mut() {
                            c.0 = (c.0 as u32) as i64;
                        }
                    }
                    sorted.sort_by_key(|p| p.0 as u64);
                } else {
                    sorted.sort_by_key(|p| p.0);
                }
                let lt_op = if disc_unsigned { BinOp::Ult } else { BinOp::Lt };
                self.emit_switch_search(b, disc_val, &sorted, lt_op, deflt);

                // Walk the body linearly. The opening block is reachable
                // only by a goto into the switch ahead of the first case
                // (C99 6.8.1); the dispatcher never targets it.
                let fallin = b.new_block();
                b.switch_to(fallin);

                // `break` leaves the switch; `continue` is invalid in a
                // bare switch, so propagate the enclosing loop's target.
                let prev_continue = self.loop_ctx.last().map(|&(_, c)| c).unwrap_or(after_blk);
                self.loop_ctx.push((after_blk, prev_continue));
                self.switch_dispatch.push((cases, default_blk));
                let terminated = self.walk_stmt(b, body_id)?;
                self.switch_dispatch.pop();
                self.loop_ctx.pop();
                if !terminated {
                    b.jmp(after_blk);
                }
                b.switch_to(after_blk);
                Ok(false)
            }
            // A case / default marker inside the active switch jumps to
            // the block the case-collection pass reserved for it, so the
            // dispatcher can target it and a preceding statement falls
            // through into it. Outside any switch (a parser bug) it is a
            // transparent wrapper around its body.
            Stmt::Case { val, body } => {
                let val = *val;
                let body_id = *body;
                let blk = self
                    .switch_dispatch
                    .last()
                    .and_then(|d| d.0.iter().find(|(v, _)| *v == val).map(|&(_, b)| b));
                if let Some(blk) = blk {
                    if b.is_block_open() {
                        b.jmp(blk);
                    }
                    b.switch_to(blk);
                }
                self.walk_stmt(b, body_id)
            }
            Stmt::Default { body } => {
                let body_id = *body;
                let blk = self.switch_dispatch.last().and_then(|d| d.1);
                if let Some(blk) = blk {
                    if b.is_block_open() {
                        b.jmp(blk);
                    }
                    b.switch_to(blk);
                }
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
    ///   size }` for a brace-list whose every element folded to
    ///   a compile-time constant.
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
                self.emit_local_init(b, slot, ty, &init_clone)
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

    /// Emit the initialization of a frame slot from a [`LocalInit`].
    /// Shared by local-variable declarations (`Decl::Local`) and
    /// block-scope compound literals (`Expr::CompoundLiteral`), both
    /// of which lower the same C99 6.7.8 / 6.5.2.5 initializer
    /// shapes into the same slot.
    fn emit_local_init(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        slot: i64,
        ty: i64,
        init: &super::super::ast::LocalInit,
    ) -> Result<(), WalkError> {
        match init {
            super::super::ast::LocalInit::None => Ok(()),
            super::super::ast::LocalInit::Scalar(init_id) => {
                let v = self.walk_expr_rvalue(b, *init_id)?;
                // C99 6.7.8p13 struct-value initializer: copy the
                // source's bytes into the slot via Mcpy. `v` is the
                // source address (the walker's address-as-value
                // routing for struct rvalues).
                if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                    let dst = b.local_addr(slot);
                    let size = self.struct_size(ty);
                    b.mcpy(dst, v, size);
                    return Ok(());
                }
                let kind = store_kind_for(ty, self.target);
                // A direct `StoreLocal` keeps the slot mem2reg-promotable.
                // The `F32` s-view store is narrowed by the per-arch emit
                // when the value is still double.
                b.store_local(slot, v, kind);
                Ok(())
            }
            super::super::ast::LocalInit::Aggregate {
                src_data_off,
                size_bytes,
            } => {
                let dst = b.local_addr(slot);
                let src = b.imm_data(*src_data_off);
                b.mcpy(dst, src, *size_bytes);
                Ok(())
            }
            super::super::ast::LocalInit::Runtime {
                zero_init,
                elements,
            } => {
                // C99 6.7.8p19 zero prelude (if the parser emitted
                // one): Mcpy staged zero bytes before the per-element
                // stores.
                if let Some((src_data_off, size_bytes)) = zero_init {
                    let dst = b.local_addr(slot);
                    let src = b.imm_data(*src_data_off);
                    b.mcpy(dst, src, *size_bytes);
                }
                for elem in elements {
                    let v = self.walk_expr_rvalue(b, elem.value)?;
                    let base = b.local_addr(slot);
                    let addr = if elem.offset == 0 {
                        base
                    } else {
                        b.binop_imm(BinOp::Add, base, elem.offset)
                    };
                    // C99 6.7.8p13: a struct/union member initialized by a
                    // single expression of compatible type copies the
                    // source's bytes. `v` is the source address (the
                    // walker's address-as-value routing for struct rvalues),
                    // so this needs an Mcpy, not a scalar store.
                    if is_struct_ty(elem.ty) && struct_ptr_depth(elem.ty) == 0 {
                        let size = self.struct_size(elem.ty);
                        b.mcpy(addr, v, size);
                        continue;
                    }
                    let kind = store_kind_for(elem.ty, self.target);
                    b.store(addr, v, kind);
                }
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

    /// Reserve a block for every `case` value and for `default` in a
    /// switch body, descending into nested statements but not into a
    /// nested switch (whose labels belong to it, C99 6.8.4.2). A
    /// duplicate case value keeps the first block; the parser already
    /// rejects duplicates.
    /// Emit a balanced binary search over a sorted, distinct case list
    /// as the switch dispatcher. The cursor is at an open block on entry
    /// and the block is closed on return. Internal nodes branch on
    /// `lt_op` (`<`); a leaf tests equality and falls to `deflt` when the
    /// discriminant matches no case.
    fn emit_switch_search(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        disc: super::super::ir::ValueId,
        cases: &[(i64, super::super::ir::BlockId)],
        lt_op: BinOp,
        deflt: super::super::ir::BlockId,
    ) {
        match cases {
            [] => b.jmp(deflt),
            [(val, blk)] => {
                let eq = b.binop_imm(BinOp::Eq, disc, *val);
                b.branch_nonzero(eq, *blk, deflt);
            }
            _ => {
                let mid = cases.len() / 2;
                let pivot = cases[mid].0;
                let lt = b.binop_imm(lt_op, disc, pivot);
                let left = b.new_block();
                let ge = b.new_block();
                b.branch_nonzero(lt, left, ge);
                b.switch_to(left);
                self.emit_switch_search(b, disc, &cases[..mid], lt_op, deflt);
                b.switch_to(ge);
                self.emit_switch_search(b, disc, &cases[mid..], lt_op, deflt);
            }
        }
    }

    fn collect_switch_cases(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        stmt_id: super::super::ast::StmtId,
        cases: &mut alloc::vec::Vec<(i64, super::super::ir::BlockId)>,
        default_blk: &mut Option<super::super::ir::BlockId>,
    ) {
        match self.ast.stmt(stmt_id) {
            Stmt::Case { val, body } => {
                let val = *val;
                let body = *body;
                if !cases.iter().any(|(v, _)| *v == val) {
                    let blk = b.new_block();
                    cases.push((val, blk));
                }
                self.collect_switch_cases(b, body, cases, default_blk);
            }
            Stmt::Default { body } => {
                let body = *body;
                if default_blk.is_none() {
                    *default_blk = Some(b.new_block());
                }
                self.collect_switch_cases(b, body, cases, default_blk);
            }
            Stmt::Compound(items) => {
                let items = items.clone();
                for item in items {
                    if let super::BlockItem::Stmt(s) = item {
                        self.collect_switch_cases(b, s, cases, default_blk);
                    }
                }
            }
            Stmt::If { then_s, else_s, .. } => {
                let then_s = *then_s;
                let else_s = *else_s;
                self.collect_switch_cases(b, then_s, cases, default_blk);
                if let Some(e) = else_s {
                    self.collect_switch_cases(b, e, cases, default_blk);
                }
            }
            Stmt::While { body, .. }
            | Stmt::DoWhile { body, .. }
            | Stmt::For { body, .. }
            | Stmt::Labeled { body, .. } => {
                let body = *body;
                self.collect_switch_cases(b, body, cases, default_blk);
            }
            // A nested switch owns its own case labels; every other
            // statement carries none.
            _ => {}
        }
    }

    /// Walk an expression in rvalue position. Returns the
    /// `ValueId` whose runtime value is the C99 6.5p1 evaluation
    /// of the expression.
    fn walk_expr_rvalue(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Ok(b.imm(*val)),
            Expr::FloatLit { bits, ty } => {
                // C99 6.4.4.2: an `f`-suffixed constant has type `float`
                // and is represented in single precision. The lexer
                // records the f64 bit pattern; narrow it to the f32 bit
                // pattern (parked in the low 32 bits of the immediate)
                // and tag the value f32 so the codegen reinterprets it
                // through a 32-bit move. A `double` constant keeps its
                // f64 bits untagged.
                if is_float_ty(*ty) {
                    let f32_bits = f64::from_bits(*bits) as f32;
                    let imm = f32_bits.to_bits() as i64;
                    let v = b.imm(imm);
                    return Ok(b.mark_f32(v));
                }
                Ok(b.imm(*bits as i64))
            }
            Expr::StrLit { data_off, .. } => Ok(b.imm_data(*data_off)),
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
                array_size,
            } => self.load_ident_rvalue(b, *sym, *ty, *class, *val, *is_thread_local, *array_size),
            Expr::Unary { op, child, ty } => self.walk_unary(b, *op, *child, *ty),
            Expr::Binary { op, lhs, rhs, ty } => {
                let mask = unsigned_narrow_mask(*ty);
                let needs_divmod_mask = mask != 0 && matches!(*op, BinOp::Divu | BinOp::Modu);
                // Constant-rhs short-circuit: when the AST rhs is
                // an integer literal and the per-arch BinopI
                // lowering covers `*op`, route through
                // `binop_imm`. The per-arch emit picks the
                // existing immediate-form peepholes
                // (`add r, imm`, `shl r, imm8`, sxtw/sxth/sxtb,
                // and so on) instead of materialising the literal
                // into a register first. Ops whose BinopI path
                // bails (Mod / Modu / Div / Divu / every FP op)
                // stay on the register-rhs path so the SSA emit
                // doesn't fall back to the pool path.
                let imm_safe_op = matches!(
                    *op,
                    BinOp::Add
                        | BinOp::Sub
                        | BinOp::Mul
                        | BinOp::And
                        | BinOp::Or
                        | BinOp::Xor
                        | BinOp::Shl
                        | BinOp::Shr
                        | BinOp::Shru
                        | BinOp::Eq
                        | BinOp::Ne
                        | BinOp::Lt
                        | BinOp::Gt
                        | BinOp::Le
                        | BinOp::Ge
                        | BinOp::Ult
                        | BinOp::Ugt
                        | BinOp::Ule
                        | BinOp::Uge
                );
                // C99 6.6: a constant expression evaluates at
                // translation time. The parser doesn't fold the
                // synthesised pointer-arithmetic scaling
                // (`arr[K]` lowers to `arr + (K * sizeof(*arr))`
                // with K and the size both literals), so do the
                // fold here. Skip ops the per-arch BinopI lowering
                // doesn't cover.
                if imm_safe_op
                    && let Expr::IntLit { val: lv_imm, .. } = *self.ast.expr(*lhs)
                    && let Expr::IntLit { val: rv_imm, .. } = *self.ast.expr(*rhs)
                {
                    return Ok(b.imm(fold_int_binop(*op, lv_imm, rv_imm)));
                }
                let mut lv = self.walk_expr_rvalue(b, *lhs)?;
                if imm_safe_op && let Expr::IntLit { val, .. } = self.ast.expr(*rhs) {
                    // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
                    // modulo at a narrower-than-register common
                    // type needs each operand masked first. The
                    // `imm_safe_op` set excludes Divu / Modu so
                    // this branch never carries the divmod mask
                    // path; the literal flows through unchanged.
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, lv, *val));
                }
                let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                // Floating-point binops (C99 6.3.1.8). `float op float`
                // is single precision; any `double` operand promotes the
                // op (and the other operand) to double. The parser
                // already chose Fadd/.../Feq and set `ty` to the result
                // type; the walker decides the operand / result width.
                if matches!(
                    *op,
                    BinOp::Fadd
                        | BinOp::Fsub
                        | BinOp::Fmul
                        | BinOp::Fdiv
                        | BinOp::Feq
                        | BinOp::Fne
                        | BinOp::Flt
                        | BinOp::Fgt
                        | BinOp::Fle
                        | BinOp::Fge
                ) {
                    // C99 6.3.1.8: the op is single precision only when
                    // both operands are already f32; any f64 operand
                    // promotes the op (and the f32 operand) to double.
                    // The walker tags each `float`-typed value f32 as it
                    // is produced, so the operands' f32 markers are the
                    // bit-accurate signal -- the operand AST's C type can
                    // diverge from the value's representation after an
                    // intervening widening.
                    let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
                    if op_is_f32 {
                        let res = b.binop(*op, lv, rv);
                        // Arithmetic produces a `float`; tag it. A
                        // comparison produces an `int` and is left
                        // untagged.
                        if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
                            return Ok(b.mark_f32(res));
                        }
                        return Ok(res);
                    }
                    // Double-precision op: any f32 operand widens to
                    // double first (6.3.1.5).
                    lv = b.fp_widen_to_f64(lv);
                    rv = b.fp_widen_to_f64(rv);
                    return Ok(b.binop(*op, lv, rv));
                }
                // The rhs AST shape isn't an `IntLit`, but walking
                // it may have constant-folded down to one (e.g.
                // `K * sizeof(*arr)` with both K and the size as
                // literals). Inspect the SSA value the walker
                // returned and route through `binop_imm` when it
                // names an `Imm`. The producing inst becomes dead
                // (use_counts drops to 0) and DCE skips it.
                if imm_safe_op && let Some(rk) = b.peek_imm(rv) {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, lv, rk));
                }
                // For commutative ops where the constant landed on
                // lhs (C99 source order `4 * i`), swap operands and
                // emit BinopI so the literal never spills to a
                // register. Bit ops Eq / Ne are commutative; ordered
                // comparisons Lt / Gt / Le / Ge / Ult / Ugt / Ule /
                // Uge are not, but swapping operands flips the
                // comparison direction, so `K < x` rewrites to
                // `x > K` (and so on), still routing through
                // BinopI.
                let commutative = matches!(
                    *op,
                    BinOp::Add
                        | BinOp::Mul
                        | BinOp::And
                        | BinOp::Or
                        | BinOp::Xor
                        | BinOp::Eq
                        | BinOp::Ne
                );
                let reversed_cmp = match *op {
                    BinOp::Lt => Some(BinOp::Gt),
                    BinOp::Gt => Some(BinOp::Lt),
                    BinOp::Le => Some(BinOp::Ge),
                    BinOp::Ge => Some(BinOp::Le),
                    BinOp::Ult => Some(BinOp::Ugt),
                    BinOp::Ugt => Some(BinOp::Ult),
                    BinOp::Ule => Some(BinOp::Uge),
                    BinOp::Uge => Some(BinOp::Ule),
                    _ => None,
                };
                if imm_safe_op
                    && commutative
                    && let Some(lk) = b.peek_imm(lv)
                {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, rv, lk));
                }
                if imm_safe_op
                    && let Some(swapped_op) = reversed_cmp
                    && let Some(lk) = b.peek_imm(lv)
                {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(swapped_op, rv, lk));
                }
                // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo
                // at a narrower-than-register common type needs
                // each operand masked to that width *before* the
                // op. A signed operand promoted to the unsigned
                // common type carries its sign-extended high
                // half in the 64-bit register; without the mask,
                // `udiv` / `umod` operate on the wider pattern
                // and produce the wrong order of magnitude.
                if needs_divmod_mask {
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
                // value with the shifted new, store back.
                // Returns the combined word so an outer expression
                // chain keeps a stable rvalue.
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
                // Local-target shortcut: a Token::Loc-class Ident
                // lvalue lowers to a single `StoreLocal` instead of
                // `LocalAddr` + `Store`, keeping the slot mem2reg-
                // promotable. The `F32` s-view is narrowed below before
                // the store so the assignment yields the f32 value.
                let kind = store_kind_for(*ty, self.target);
                if let Expr::Ident {
                    class,
                    val,
                    is_thread_local: false,
                    ..
                } = self.ast.expr(*lhs)
                    && *class == Token::Loc as i64
                {
                    let slot = *val;
                    let mut value = self.walk_expr_rvalue(b, *rhs)?;
                    // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned
                    // to a `float` object is narrowed to single precision;
                    // the assignment expression's value is the converted
                    // (f32) value.
                    if matches!(kind, StoreKind::F32) {
                        value = b.fp_narrow_to_f32(value);
                    }
                    b.store_local(slot, value, kind);
                    return Ok(value);
                }
                let addr = self.walk_expr_lvalue(b, *lhs)?;
                let mut value = self.walk_expr_rvalue(b, *rhs)?;
                // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned to a
                // `float` object is narrowed to single precision. The
                // parser inserts no float<->double cast (same type
                // class), so the walker narrows here when the stored
                // value is still double. The assignment expression's
                // value is the converted (f32) value.
                if matches!(kind, StoreKind::F32) {
                    value = b.fp_narrow_to_f32(value);
                }
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
                ty,
            } => {
                // C99 6.5.15: evaluate cond; depending on the
                // value, evaluate exactly one of then_e / else_e
                // and the conditional expression's value is that
                // arm's value. Same synthetic-local-slot phi
                // substitute the `ShortCircuit` arm uses -- both
                // arms store the arm result and the merge block
                // loads it. Width is taken from the result type:
                // FP-typed ternary uses `Store { kind: F32 }` /
                // `LoadLocal { kind: F32 }` so the codegen routes
                // through the FP register class; everything else
                // stays on the I64 `StoreLocal` / `LoadLocal` fast
                // path the emit lowers in a single `stur` / `ldur`.
                let cond_v = self.walk_cond_value(b, *cond)?;
                let then_blk = b.new_block();
                let else_blk = b.new_block();
                let after_blk = b.new_block();
                b.branch_zero(cond_v, else_blk, then_blk);
                let slot = b.alloc_synthetic_local();
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                // `float` keeps the value in an FP register but its
                // 4-byte storage width forces the `LocalAddr` + `Store`
                // path (the fused `StoreLocal { F32 }` is not lowered).
                // `double` rides the FP register class at its full
                // 8-byte width, so the fused `StoreLocal` / `LoadLocal`
                // F64 path lowers it in a single `movsd` / `ldr d`.
                let is_f32 = matches!(load_kind, super::super::ir::LoadKind::F32);
                let is_f64 = matches!(load_kind, super::super::ir::LoadKind::F64);
                let arm_store = |b: &mut super::super::codegen::ssa_build::SsaBuilder, v| {
                    if is_f32 {
                        let addr = b.local_addr(slot);
                        b.store(addr, v, store_kind);
                    } else if is_f64 {
                        b.store_local(slot, v, store_kind);
                    } else {
                        b.store_local(slot, v, super::super::ir::StoreKind::I64);
                    }
                };
                b.switch_to(then_blk);
                let then_v = self.walk_expr_rvalue(b, *then_e)?;
                arm_store(b, then_v);
                b.jmp(after_blk);
                b.switch_to(else_blk);
                let else_v = self.walk_expr_rvalue(b, *else_e)?;
                arm_store(b, else_v);
                b.jmp(after_blk);
                b.switch_to(after_blk);
                if is_f32 || is_f64 {
                    Ok(b.load_local(slot, load_kind))
                } else {
                    Ok(b.load_local(slot, super::super::ir::LoadKind::I64))
                }
            }
            Expr::Call { callee, args, ty } => {
                // Out-pointer-returning c5-internal callee: allocate a
                // result temp on this frame, prepend its address as the
                // hidden out-pointer arg 0, run the call, and return the
                // temp's address as the expression's value (the c5 ABI's
                // address-as-value rule for struct rvalues). Host-ABI
                // returns (registers / x8) carry no hidden argument and
                // fall through to the normal call path below, which
                // tags the call's `ret_agg` / `ret_slot`.
                if is_struct_ty(*ty)
                    && struct_ptr_depth(*ty) == 0
                    && matches!(
                        crate::c5::compiler::struct_return_abi(self.structs, self.target, *ty),
                        crate::c5::compiler::StructReturnAbi::OutPtr
                    )
                    && let Expr::Ident {
                        sym, class, val, ..
                    } = self.ast.expr(*callee)
                    && *class == Token::Fun as i64
                {
                    // The callee writes the whole struct through the
                    // out-pointer, so the result temp must hold
                    // `sizeof(struct)` bytes, not a single slot.
                    let result_size = self.struct_size(*ty);
                    let result_slot = b.alloc_synthetic_struct(result_size);
                    // Spill the out-pointer through an int-typed
                    // temp so the codegen routes it via the host
                    // int arg register, matching the way FP and
                    // pointer args are routed.
                    let addr = b.local_addr(result_slot);
                    let temp = b.alloc_synthetic_local();
                    b.store_local(temp, addr, super::super::ir::StoreKind::I64);
                    let out_arg = b.load_local(temp, super::super::ir::LoadKind::I64);
                    let mut all_args: alloc::vec::Vec<super::super::ir::ValueId> =
                        alloc::vec::Vec::with_capacity(args.len() + 1);
                    all_args.push(out_arg);
                    for a in args {
                        all_args.push(self.walk_expr_rvalue(b, *a)?);
                    }
                    let target_pc = self.live_fun_val(*sym, *val);
                    // Struct-returning callee: the result is an
                    // address (the c5 address-as-value rule), never
                    // an FP scalar, so `fp_return` is false. The callee
                    // keeps the c5 cdecl shape (excluded from
                    // `param_fp_mask` because the hidden out-pointer
                    // shifts every parameter cell), so its arguments
                    // ride the integer bank: `fp_arg_mask` is 0.
                    // The hidden out-pointer is a fixed argument. A
                    // variadic struct-returning callee (e.g. a printf-style
                    // error helper returning a 16-byte value) still passes
                    // its variadic tail on the host stack, so fixed_args
                    // counts the out-pointer plus the callee's named
                    // parameters; the emit detects the variadic callee from
                    // its target and places `args[fixed_args..]` per the
                    // host variadic ABI. A non-variadic callee keeps every
                    // argument fixed.
                    let fixed_args = if self.fun_is_variadic(*sym) {
                        1 + self.fun_fixed_args(*sym)
                    } else {
                        all_args.len()
                    };
                    if target_pc == 0 {
                        let _ = b.call_extern(*sym, all_args, fixed_args, false, 0);
                    } else {
                        let _ = b.call(target_pc as usize, all_args, fixed_args, false, 0);
                    }
                    return Ok(b.local_addr(result_slot));
                }
                // Lower each arg as an rvalue, then dispatch
                // through the callee's class. Direct
                // c5-internal (`Token::Fun`) calls go through
                // `b.call(target_pc, args)`; libc bindings
                // (`Token::Sys`) go through `b.call_ext`;
                // anything else routes through
                // `b.call_indirect` with the callee's value.
                //
                // Indirect-call shape splits by callee form:
                //   * Non-Ident callee (struct-field-then-call,
                //     `*fp(...)`, ...): the parser's Pratt loop
                //     evaluates the callee before reaching `(` and
                //     spills it to a temp through the store-local
                //     path. The walker evaluates the callee FIRST
                //     and stashes the resulting ValueId.
                //   * Ident callee of class Loc / Glo (simple
                //     function-pointer variable): the parser's
                //     dedicated `()`-after-identifier path
                //     evaluates args FIRST, then loads the
                //     callee's stored function-pointer value.
                //     The walker mirrors this by deferring the
                //     callee walk to after the args loop.
                // Token::Fun / Token::Sys never reach the
                // indirect-call site (the per-class branches
                // below dispatch to b.call / b.call_ext) so they
                // don't walk the callee at all.
                let indirect_target: Option<super::super::ir::ValueId> =
                    if let Expr::Ident { .. } = self.ast.expr(*callee) {
                        None
                    } else {
                        Some(self.walk_expr_rvalue(b, *callee)?)
                    };
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
                if let Expr::Ident {
                    sym, class, val, ..
                } = self.ast.expr(*callee)
                {
                    if *class == Token::Fun as i64 {
                        // C99 6.5.2.2p7 + the host ABI: a floating-point
                        // scalar argument rides an FP argument register
                        // (xmm0..xmm7 / d0..d7). The value left in
                        // `arg_vals[i]` is already FP-classed; the
                        // per-arch `marshal_args` places it in the FP
                        // bank per `plan_call_args` using `fp_arg_mask`.
                        // A `float` argument stays at single precision
                        // (no widen-to-double); the callee narrows back
                        // from the s-register view.
                        //
                        // A variadic c5 callee is the exception: it keeps
                        // the c5 cdecl stack shape (its prologue skips the
                        // host-arg-reg spill and reads args off the
                        // 16-byte-stride stack as raw 8-byte patterns).
                        // C99 6.5.2.2p6 default argument promotions widen
                        // a `float` argument to `double`; route every FP
                        // argument through the integer register class as a
                        // widened 8-byte double, matching what the callee
                        // reads back, and pass `fp_arg_mask = 0`.
                        let callee_variadic = self.fun_is_variadic(*sym);
                        let abi = self.target.abi();
                        // Named (fixed) parameter count of the callee.
                        // For a variadic callee the prototype records the
                        // pre-ellipsis parameters in `Symbol::params`;
                        // `args[fixed_args..]` are the variadic arguments.
                        // For a non-variadic callee every argument is
                        // fixed.
                        let fixed_args = if callee_variadic {
                            self.fun_fixed_args(*sym).min(args.len())
                        } else {
                            args.len()
                        };
                        // C99 6.5.2.2 + the host ABI: a struct passed as
                        // a variadic argument rides by value -- its
                        // eightbyte occupies the save area / stack slot
                        // `va_arg` reads -- not via the c5 address-as-
                        // value pointer that `walk_expr_rvalue` left in
                        // `arg_vals`. Replace each small struct variadic
                        // argument's address with its loaded eightbyte.
                        // A struct larger than one eightbyte is left on
                        // the address path. TODO: pass its second
                        // eightbyte.
                        // Host-ABI aggregate arguments (AAPCS64 6.8.2 /
                        // System V 3.2.3): tag each by-value struct argument
                        // with its layout so the caller marshals it into the
                        // argument registers / stack slots the callee reads.
                        // A fixed parameter classifies by its declared type;
                        // a variadic argument by its own type. A variadic
                        // struct of at most one eightbyte rides as a single
                        // loaded integer in the variadic slot (C99 6.5.2.2);
                        // a larger aggregate routes through the host-ABI
                        // placement so `plan_call_args_aggs` lays its
                        // eightbytes down all-or-nothing and the callee's
                        // `va_arg` reads them contiguously. Inert on ABIs /
                        // sizes the classifier declines.
                        let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                        {
                            let nparams = self.symbols[*sym as usize].params.len();
                            for i in 0..arg_vals.len() {
                                let agg_ty = if i < nparams {
                                    Some(self.symbols[*sym as usize].params[i])
                                } else {
                                    match expr_ty(self.ast.expr(args[i])) {
                                        Some(aty)
                                            if is_struct_ty(aty)
                                                && struct_ptr_depth(aty) == 0
                                                && self.struct_size(aty) <= 8 =>
                                        {
                                            arg_vals[i] = b
                                                .load(arg_vals[i], super::super::ir::LoadKind::I64);
                                            None
                                        }
                                        other => other,
                                    }
                                };
                                let Some(ty_tag) = agg_ty else {
                                    continue;
                                };
                                if let Some(desc) = crate::c5::compiler::host_abi_agg_desc(
                                    self.structs,
                                    self.target,
                                    ty_tag,
                                ) {
                                    if arg_aggs.is_empty() {
                                        arg_aggs = alloc::vec![None; arg_vals.len()];
                                    }
                                    arg_aggs[i] = Some(b.intern_agg_desc(desc));
                                }
                            }
                        }
                        // macOS arm64's variadic ABI (Apple "Writing
                        // ARM64 Code for Apple Platforms") passes the
                        // named arguments per AAPCS64 6.4.1 (int bank +
                        // FP bank) and every variadic argument on the
                        // stack at 8-byte stride. The codegen marshals
                        // this exactly like a libc variadic call, so the
                        // named FP arguments keep their FP-bank placement;
                        // only the variadic `float` arguments are widened
                        // to `double` per C99 6.5.2.2p6 (kept FP-classed
                        // so the 8-byte stack store reads back as a
                        // double).
                        if callee_variadic && abi.variadic_on_stack {
                            for (i, a) in args.iter().enumerate() {
                                if i < fixed_args {
                                    continue;
                                }
                                let arg_is_fp = expr_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                                }
                            }
                            let fp_return = is_floating_scalar(*ty);
                            let target_pc = self.live_fun_val(*sym, *val);
                            let call = if target_pc == 0 {
                                b.call_extern(*sym, arg_vals, fixed_args, fp_return, fp_arg_mask)
                            } else {
                                b.call(
                                    target_pc as usize,
                                    arg_vals,
                                    fixed_args,
                                    fp_return,
                                    fp_arg_mask,
                                )
                            };
                            if !arg_aggs.is_empty() {
                                b.set_call_arg_aggs(call, arg_aggs);
                            }
                            if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                            | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                                crate::c5::compiler::struct_return_abi(
                                    self.structs,
                                    self.target,
                                    *ty,
                                )
                            {
                                let ridx = b.intern_agg_desc(desc.clone());
                                let slot = b.alloc_synthetic_struct(desc.size as i64);
                                b.set_call_ret_agg(call, ridx, slot);
                                return Ok(b.local_addr(slot));
                            }
                            if is_float_ty(*ty) {
                                return Ok(b.mark_f32(call));
                            }
                            return Ok(call);
                        }
                        // Register-save host variadic ABI (System V AMD64
                        // on Linux x86_64, AAPCS64 on Linux aarch64): a
                        // variadic callee receives its floating-point
                        // arguments in the FP argument-register bank
                        // (xmm0..xmm7 / d0..d7), so the call passes the
                        // real `fp_arg_mask` rather than force-routing FP
                        // arguments through the integer bank. Variadic
                        // `float` arguments are still widened to `double`
                        // (C99 6.5.2.2p6 default argument promotions) but
                        // kept FP-classed so they ride an FP register.
                        if callee_variadic
                            && (abi.sysv_host_variadic() || abi.aarch64_host_variadic())
                        {
                            for (i, a) in args.iter().enumerate() {
                                if i < fixed_args {
                                    continue;
                                }
                                let arg_is_fp = expr_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                                }
                            }
                            let fp_return = is_floating_scalar(*ty);
                            let target_pc = self.live_fun_val(*sym, *val);
                            let call = if target_pc == 0 {
                                b.call_extern(*sym, arg_vals, fixed_args, fp_return, fp_arg_mask)
                            } else {
                                b.call(
                                    target_pc as usize,
                                    arg_vals,
                                    fixed_args,
                                    fp_return,
                                    fp_arg_mask,
                                )
                            };
                            if !arg_aggs.is_empty() {
                                b.set_call_arg_aggs(call, arg_aggs);
                            }
                            if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                            | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                                crate::c5::compiler::struct_return_abi(
                                    self.structs,
                                    self.target,
                                    *ty,
                                )
                            {
                                let ridx = b.intern_agg_desc(desc.clone());
                                let slot = b.alloc_synthetic_struct(desc.size as i64);
                                b.set_call_ret_agg(call, ridx, slot);
                                return Ok(b.local_addr(slot));
                            }
                            if is_float_ty(*ty) {
                                return Ok(b.mark_f32(call));
                            }
                            return Ok(call);
                        }
                        // A variadic callee reaching here is a
                        // `variadic_int_only` host (Win64 / Windows arm64,
                        // the Microsoft calling conventions): the macOS
                        // arm64 (`variadic_on_stack`) and System V /
                        // AAPCS64 register-save hosts returned above. Its
                        // named and variadic arguments ride the integer
                        // register bank -- a floating-point argument as its
                        // raw bit pattern -- so widen every FP argument to
                        // an 8-byte double in an integer slot, matching
                        // what the callee reads back, and pass
                        // `fp_arg_mask = 0`. The same widening covers a
                        // non-variadic callee whose register/stack
                        // placement would interleave.
                        let eff_fp_arg_mask = super::super::codegen::effective_fp_arg_mask(
                            args.len(),
                            fp_arg_mask,
                            abi,
                        );
                        let force_int =
                            callee_variadic || (fp_arg_mask != 0 && eff_fp_arg_mask == 0);
                        let call_fp_arg_mask = if force_int {
                            for (i, a) in args.iter().enumerate() {
                                let arg_is_fp = expr_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    let widened = b.fp_widen_to_f64(arg_vals[i]);
                                    let slot = b.alloc_synthetic_local();
                                    b.store_local(slot, widened, super::super::ir::StoreKind::I64);
                                    arg_vals[i] =
                                        b.load_local(slot, super::super::ir::LoadKind::I64);
                                }
                            }
                            0
                        } else {
                            eff_fp_arg_mask
                        };
                        // C99 6.2.5p10: a call to a function whose
                        // return type is a floating-point scalar
                        // yields its value in the FP return register.
                        // Tag the call so the codegen reads the result
                        // from there and FP-classes the value.
                        let fp_return = is_floating_scalar(*ty);
                        let target_pc = self.live_fun_val(*sym, *val);
                        // Host-ABI aggregate return (AAPCS64 6.9):
                        // reserve the result temp before the call. Its
                        // frame slot rides on the call instruction, so it
                        // survives value renumbering and needs no SSA
                        // operand.
                        let ret_temp = if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                        | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                            crate::c5::compiler::struct_return_abi(self.structs, self.target, *ty)
                        {
                            let ridx = b.intern_agg_desc(desc.clone());
                            let slot = b.alloc_synthetic_struct(desc.size as i64);
                            Some((ridx, slot))
                        } else {
                            None
                        };
                        let call = if target_pc == 0 {
                            b.call_extern(*sym, arg_vals, fixed_args, fp_return, call_fp_arg_mask)
                        } else {
                            b.call(
                                target_pc as usize,
                                arg_vals,
                                fixed_args,
                                fp_return,
                                call_fp_arg_mask,
                            )
                        };
                        if !arg_aggs.is_empty() {
                            b.set_call_arg_aggs(call, arg_aggs);
                        }
                        // Tag the call's `ret_agg` / `ret_slot` and yield
                        // the result temp's address. The codegen reads
                        // the eightbytes from x0/x1 (<= 16 bytes) or has
                        // the callee write through x8 (> 16 bytes); the
                        // VM copies the returned struct into the temp.
                        if let Some((ridx, slot)) = ret_temp {
                            b.set_call_ret_agg(call, ridx, slot);
                            return Ok(b.local_addr(slot));
                        }
                        // A `float`-returning callee yields a single-
                        // precision value (C99 6.2.5p10 / 6.3.1.8); tag it.
                        if is_float_ty(*ty) {
                            return Ok(b.mark_f32(call));
                        }
                        return Ok(call);
                    }
                    if *class == Token::Sys as i64 {
                        // The Ident's `val` is the binding's
                        // flat index across all `#pragma
                        // binding(...)` directives -- exactly
                        // what `Inst::CallExt::binding_idx`
                        // wants. `fp_arg_mask` is the per-arg
                        // FP-ness bit set we built above. A
                        // floating-point return is FP-classed (C99
                        // 6.2.5p10) so the result rides d0 / xmm0
                        // without a GPR bridge; a `float` result
                        // additionally carries the f32 tag.
                        // A by-value struct argument to a libc binding is
                        // packed into the platform-ABI argument registers
                        // (SysV / AAPCS64: <= 16 bytes), not passed by the
                        // c5-internal address convention. Tag each struct arg
                        // so the emitter classifies and marshals it.
                        let mut ext_arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                        let nparams = self.symbols[*sym as usize].params.len();
                        for i in 0..arg_vals.len() {
                            let arg_ty = if i < nparams {
                                self.symbols[*sym as usize].params[i]
                            } else {
                                match expr_ty(self.ast.expr(args[i])) {
                                    Some(t) => t,
                                    None => continue,
                                }
                            };
                            if is_struct_ty(arg_ty)
                                && struct_ptr_depth(arg_ty) == 0
                                && let Some(desc) = crate::c5::compiler::host_abi_agg_desc(
                                    self.structs,
                                    self.target,
                                    arg_ty,
                                )
                            {
                                if ext_arg_aggs.is_empty() {
                                    ext_arg_aggs = alloc::vec![None; arg_vals.len()];
                                }
                                ext_arg_aggs[i] = Some(b.intern_agg_desc(desc));
                            }
                        }
                        let fp_return = is_floating_scalar(*ty);
                        let call = b.call_ext(*val, arg_vals, fp_arg_mask, fp_return);
                        if !ext_arg_aggs.is_empty() {
                            b.set_call_arg_aggs(call, ext_arg_aggs);
                        }
                        if is_float_ty(*ty) {
                            return Ok(b.mark_f32(call));
                        }
                        return Ok(call);
                    }
                }
                // Determine the pointed-to function's variadic-ness
                // and named-parameter count from the callee's static
                // type. A fn-pointer Ident (`cb(...)` where `cb` is a
                // variadic-fn-pointer variable) carries the prototype
                // on its symbol (propagated from the typedef at
                // declaration). A callee with no statically-known
                // prototype (e.g. the result of a comma operator)
                // defaults to non-variadic, all-fixed.
                //
                // TODO: a variadic call through a function pointer whose
                // prototype is not statically recoverable here (a pointer
                // received as a parameter, or loaded through a non-typedef
                // path) takes the all-fixed default and, under the host
                // variadic ABI (`variadic_on_stack`), places the variadic
                // tail in registers rather than on the stack the callee's
                // va_arg walks. Carrying the prototype on the pointer's
                // type rather than the variable symbol would close this.
                let (callee_variadic, callee_fixed) =
                    self.indirect_callee_proto(*callee, args.len());
                let abi = self.target.abi();
                let target = match indirect_target {
                    Some(t) => t,
                    None => self.walk_expr_rvalue(b, *callee)?,
                };
                let fp_return = is_floating_scalar(*ty);
                // Host-ABI out-pointer struct return through a function
                // pointer (SysV x86_64 > 16 bytes, Win64 aggregates outside
                // {1,2,4,8} bytes). Mirror the direct-call path: allocate
                // the result temp, pass its address as a hidden first
                // integer argument, and yield the temp's address; the
                // callee writes the struct through the pointer and returns
                // it. An out-pointer-returning function uses the all-integer
                // cdecl (its prologue skips the FP bank), so the call is
                // non-variadic with FP mask 0.
                if matches!(
                    crate::c5::compiler::struct_return_abi(self.structs, self.target, *ty),
                    crate::c5::compiler::StructReturnAbi::OutPtr
                ) {
                    // The callee writes the whole struct through the
                    // out-pointer, so the result temp must hold
                    // `sizeof(struct)` bytes.
                    let result_size = self.struct_size(*ty);
                    let result_slot = b.alloc_synthetic_struct(result_size);
                    let addr = b.local_addr(result_slot);
                    let temp = b.alloc_synthetic_local();
                    b.store_local(temp, addr, super::super::ir::StoreKind::I64);
                    let out_arg = b.load_local(temp, super::super::ir::LoadKind::I64);
                    let mut all_args: alloc::vec::Vec<super::super::ir::ValueId> =
                        alloc::vec::Vec::with_capacity(arg_vals.len() + 1);
                    all_args.push(out_arg);
                    all_args.extend_from_slice(&arg_vals);
                    let fixed = all_args.len();
                    b.call_indirect(target, all_args, false, fixed, false, 0);
                    return Ok(b.local_addr(result_slot));
                }
                // Host-ABI aggregate return through a function pointer:
                // mirror the direct-call path. Reserve the result temp and
                // tag the call so the codegen reads the eightbytes from
                // x0/x1 (<= 16 bytes) or has the callee write through x8
                // (> 16 bytes on aarch64); the VM copies the returned
                // struct into the temp.
                let ret_temp = if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                    crate::c5::compiler::struct_return_abi(self.structs, self.target, *ty)
                {
                    let ridx = b.intern_agg_desc(desc.clone());
                    let slot = b.alloc_synthetic_struct(desc.size as i64);
                    Some((ridx, slot))
                } else {
                    None
                };
                if callee_variadic && abi.variadic_on_stack {
                    // macOS arm64 variadic ABI: named arguments follow
                    // AAPCS64 (int / FP bank), variadic arguments on the
                    // stack at 8-byte stride. Widen variadic `float`
                    // arguments to `double` per C99 6.5.2.2p6, kept
                    // FP-classed so the 8-byte stack store is a double;
                    // the named FP arguments keep their FP-bank
                    // placement through the real `fp_arg_mask`.
                    for (i, a) in args.iter().enumerate() {
                        if i < callee_fixed {
                            continue;
                        }
                        let arg_is_fp = expr_ty(self.ast.expr(*a))
                            .map(is_floating_scalar)
                            .unwrap_or(false);
                        if arg_is_fp {
                            arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                        }
                    }
                    let call = b.call_indirect(
                        target,
                        arg_vals,
                        true,
                        callee_fixed,
                        fp_return,
                        fp_arg_mask,
                    );
                    if let Some((ridx, slot)) = ret_temp {
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    // A `float`-returning callee yields a single-precision
                    // value (C99 6.2.5p10 / 6.3.1.8); tag it so the result
                    // store reads the s-register view instead of narrowing
                    // the d-register a second time.
                    if is_float_ty(*ty) {
                        return Ok(b.mark_f32(call));
                    }
                    return Ok(call);
                }
                // Register-save host variadic ABI (System V AMD64 on Linux
                // x86_64, AAPCS64 on Linux aarch64): a variadic callee
                // through a function pointer receives its floating-point
                // arguments in xmm0..xmm7 / d0..d7, so pass the real
                // `fp_arg_mask` and widen the variadic `float` arguments to
                // `double` (C99 6.5.2.2p6) kept FP-classed. On x86_64 the
                // emit sets `al` to the XMM-argument count at the call site.
                if callee_variadic && (abi.sysv_host_variadic() || abi.aarch64_host_variadic()) {
                    for (i, a) in args.iter().enumerate() {
                        if i < callee_fixed {
                            continue;
                        }
                        let arg_is_fp = expr_ty(self.ast.expr(*a))
                            .map(is_floating_scalar)
                            .unwrap_or(false);
                        if arg_is_fp {
                            arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                        }
                    }
                    let call = b.call_indirect(
                        target,
                        arg_vals,
                        true,
                        callee_fixed,
                        fp_return,
                        fp_arg_mask,
                    );
                    if let Some((ridx, slot)) = ret_temp {
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    // A `float`-returning callee yields a single-precision
                    // value (C99 6.2.5p10 / 6.3.1.8); tag it so the result
                    // store reads the s-register view instead of narrowing
                    // the d-register a second time.
                    if is_float_ty(*ty) {
                        return Ok(b.mark_f32(call));
                    }
                    return Ok(call);
                }
                // A function-pointer callee whose register/stack
                // placement would interleave keeps the all-integer c5
                // cdecl ABI (the pointed-to function applied the same
                // predicate to its `param_fp_mask`); widen its FP
                // arguments through the integer slots and pass mask 0.
                //
                // A variadic callee through a function pointer compiled
                // for a `variadic_int_only` host (Win64 x86_64 or Windows
                // aarch64) reads its named parameters from the integer
                // home / gr-save cells the prologue spills (its
                // `param_fp_mask` is 0) and the variadic tail rides the
                // integer register bank then the stack. Route every
                // floating-point argument through the integer registers
                // as a widened double so the call site and the callee
                // agree; SysV / Linux / macOS leave `variadic_int_only`
                // clear, so their variadic indirect lowering is
                // unchanged (macOS took the `variadic_on_stack` branch
                // above).
                let eff_fp_arg_mask =
                    super::super::codegen::effective_fp_arg_mask(args.len(), fp_arg_mask, abi);
                let force_int_indirect =
                    callee_variadic && abi.variadic_int_only && fp_arg_mask != 0;
                let call_fp_arg_mask =
                    if force_int_indirect || (fp_arg_mask != 0 && eff_fp_arg_mask == 0) {
                        for (i, a) in args.iter().enumerate() {
                            let arg_is_fp = expr_ty(self.ast.expr(*a))
                                .map(is_floating_scalar)
                                .unwrap_or(false);
                            if arg_is_fp {
                                let widened = b.fp_widen_to_f64(arg_vals[i]);
                                let slot = b.alloc_synthetic_local();
                                b.store_local(slot, widened, super::super::ir::StoreKind::I64);
                                arg_vals[i] = b.load_local(slot, super::super::ir::LoadKind::I64);
                            }
                        }
                        0
                    } else {
                        eff_fp_arg_mask
                    };
                // Non-macOS targets keep the c5 cdecl stack-push shape
                // for the indirect call regardless of `callee_variadic`
                // (`fixed_args` is unused there); pass the prototype
                // through so only the macOS path consults it.
                let call = b.call_indirect(
                    target,
                    arg_vals,
                    callee_variadic,
                    callee_fixed,
                    fp_return,
                    call_fp_arg_mask,
                );
                if let Some((ridx, slot)) = ret_temp {
                    b.set_call_ret_agg(call, ridx, slot);
                    return Ok(b.local_addr(slot));
                }
                // A `float`-returning callee yields a single-precision value
                // (C99 6.2.5p10 / 6.3.1.8); tag it so the result store reads
                // the s-register view instead of narrowing the d-register a
                // second time.
                if is_float_ty(*ty) {
                    return Ok(b.mark_f32(call));
                }
                Ok(call)
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
                if *array_size != 0 || (is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0) {
                    return Ok(addr);
                }
                let kind = load_kind_for(*ty, self.target);
                Ok(b.load(addr, kind))
            }
            Expr::Index { array, idx, ty } => {
                let arr = self.walk_expr_rvalue(b, *array)?;
                let i = self.walk_expr_rvalue(b, *idx)?;
                // The parser already scaled `idx` by the element
                // size (via `emit_binop_with_imm(BinOp::Mul, scale)`)
                // when the pointee size is non-trivial. The
                // resulting child `Binary{Mul, idx, scale}` rides
                // through `walk_expr_rvalue` above; for a
                // literal `K`, that walk folds to a single `Imm`,
                // so the address becomes `arr + Imm`. Route
                // through `binop_imm` in that case so the per-arch
                // emit picks `add r, imm12` / `add r, imm32`.
                let addr = match b.peek_imm(i) {
                    Some(k) => b.binop_imm(BinOp::Add, arr, k),
                    None => b.binop(BinOp::Add, arr, i),
                };
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
                    Expr::CompoundLiteral { ty, .. } => *ty,
                    Expr::StrLit { ty, .. } => *ty,
                    Expr::Intrinsic { ty, .. } => *ty,
                    Expr::Atomic { ty, .. } => *ty,
                    // `&&label` is a `void *` (char-pointer encoding).
                    Expr::LabelAddr(_) => {
                        crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64
                    }
                };
                let target_is_fp = is_floating_scalar(*to_ty);
                let source_is_fp = is_floating_scalar(src_ty);
                // C99 6.3.1.2: a conversion to `_Bool` yields 0 when
                // the source compares equal to 0, else 1. This holds
                // for every scalar source, so it precedes the
                // width/fp-ness conversions below.
                if is_bool_scalar(*to_ty) {
                    if source_is_fp {
                        let d = b.fp_widen_to_f64(v);
                        let zero = b.imm(0);
                        return Ok(b.binop(BinOp::Fne, d, zero));
                    }
                    return Ok(b.binop_imm(BinOp::Ne, v, 0));
                }
                if target_is_fp && !source_is_fp {
                    // Integer -> FP. `IntToFp` produces an f64; a `float`
                    // target then narrows to single precision (6.3.1.4).
                    let f = b.fp_cast(super::super::ir::FpCastKind::IntToFp, v);
                    if is_float_ty(*to_ty) {
                        return Ok(b.fp_narrow_to_f32(f));
                    }
                    return Ok(f);
                } else if !target_is_fp && source_is_fp {
                    // FP -> integer. `FpToInt` truncates an f64; a `float`
                    // source widens to f64 first so the same converter
                    // handles both precisions (6.3.1.4).
                    let d = b.fp_widen_to_f64(v);
                    return Ok(b.fp_cast(super::super::ir::FpCastKind::FpToInt, d));
                }
                // FP-to-FP cast (C99 6.3.1.5): `(double)f` widens,
                // `(float)d` narrows. The conversion is a no-op only when
                // the source already has the target precision.
                if target_is_fp && source_is_fp {
                    if is_float_ty(*to_ty) {
                        return Ok(b.fp_narrow_to_f32(v));
                    }
                    return Ok(b.fp_widen_to_f64(v));
                }
                // Integer-to-integer cast. C99 6.3.1.3:
                //   * narrowing -> unsigned target: mask to the
                //     target storage width.
                //   * narrowing -> signed target (or same-width
                //     signed conversion of an unsigned source):
                //     shift-pair Shl K; Shr K to sign-extend the
                //     truncated value (clang / gcc-compatible UB
                //     handling).
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
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lhs, store_kind)?;
                let old = place.load(b, load_kind);
                // Constant-rhs short-circuit (mirror of the
                // `Expr::Binary` path): an integer-literal rhs
                // routes through `binop_imm` so the per-arch
                // immediate-form peepholes fire and the literal
                // doesn't get materialised into a scratch first.
                // FP / Div / Divu / Mod / Modu stay on the
                // register-rhs path because the per-arch BinopI
                // lowering bails on them.
                let imm_safe = matches!(
                    *op,
                    BinOp::Add
                        | BinOp::Sub
                        | BinOp::Mul
                        | BinOp::And
                        | BinOp::Or
                        | BinOp::Xor
                        | BinOp::Shl
                        | BinOp::Shr
                        | BinOp::Shru
                );
                let new_val =
                    if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv)
                        && !is_floating_scalar(*ty)
                    {
                        // C99 6.5.16.2: an integer lvalue with a floating
                        // operand. The operation runs in the floating common
                        // type; convert the loaded integer up, apply the op,
                        // then convert the result back to the lvalue's
                        // integer type before the store.
                        let lv = b.fp_cast(super::super::ir::FpCastKind::IntToFp, old);
                        let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                        if b.is_f32(rv) {
                            rv = b.fp_widen_to_f64(rv);
                        }
                        let res = b.binop(*op, lv, rv);
                        b.fp_cast(super::super::ir::FpCastKind::FpToInt, res)
                    } else if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
                        // C99 6.5.16.2: `E1 op= E2` computes `E1 op E2` in
                        // the operands' common type, then converts to E1's
                        // type. `old` (the lvalue) is `float` when the store
                        // is F32; the rhs may be `float` or `double`. Match
                        // the `Expr::Binary` precision rules, then narrow the
                        // result to the store width.
                        let mut lv = old;
                        let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                        let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
                        if op_is_f32 {
                            let res = b.binop(*op, lv, rv);
                            b.mark_f32(res)
                        } else {
                            lv = b.fp_widen_to_f64(lv);
                            rv = b.fp_widen_to_f64(rv);
                            let res = b.binop(*op, lv, rv);
                            // Narrow the double result back to the lvalue's
                            // single precision (C99 6.3.1.5) before the store.
                            if matches!(store_kind, StoreKind::F32) {
                                b.fp_narrow_to_f32(res)
                            } else {
                                res
                            }
                        }
                    } else if imm_safe && let Expr::IntLit { val, .. } = self.ast.expr(*rhs) {
                        b.binop_imm(*op, old, *val)
                    } else {
                        let rhs_val = self.walk_expr_rvalue(b, *rhs)?;
                        // The walked rhs may have constant-folded to
                        // an `Imm` even when the AST shape isn't an
                        // `IntLit`; route through `binop_imm` in that
                        // case for the same reason as the
                        // `Expr::Binary` arm.
                        if imm_safe && let Some(rk) = b.peek_imm(rhs_val) {
                            b.binop_imm(*op, old, rk)
                        } else {
                            b.binop(*op, old, rhs_val)
                        }
                    };
                place.store(b, new_val, store_kind);
                // C99 6.5.16.2p3: the value of `E1 op= E2` is the
                // post-update value of E1 in E1's type. For a
                // sub-64-bit lvalue the 64-bit binop result is not
                // narrowed; reload through `load_kind` so the
                // returned ValueId reflects what was actually
                // stored (with the kind's sign / zero extension).
                Ok(if matches!(load_kind, LoadKind::I64) {
                    new_val
                } else {
                    place.load(b, load_kind)
                })
            }
            Expr::PreInc { lvalue, by, ty } => {
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lvalue, store_kind)?;
                let old = place.load(b, kind);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind);
                // C99 6.5.3.1p3 + 6.5.16.2: the value of `++E` is
                // the post-update value of E in E's type. Reload
                // through `kind` for sub-64-bit lvalues so a
                // surrounding test like `(++p) == 0` sees the
                // wrapped u8/u16/u32 value rather than the wider
                // Add result that overflows past the storage width.
                // A floating result is already at storage width.
                Ok(
                    if matches!(kind, LoadKind::I64) || is_floating_scalar(*ty) {
                        stepped
                    } else {
                        place.load(b, kind)
                    },
                )
            }
            Expr::PostInc { lvalue, by, ty } => {
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lvalue, store_kind)?;
                let old = place.load(b, kind);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind);
                // C99 6.5.2.4p3: the expression's value is the
                // pre-update value (`old`).
                Ok(old)
            }
            Expr::Sizeof(s) => Ok(b.imm(s.size_bytes)),
            Expr::CompoundLiteral {
                slot_off,
                ty,
                array_size,
                init,
            } => {
                let slot = *slot_off;
                let ty = *ty;
                let array_size = *array_size;
                let init = init.clone();
                self.emit_local_init(b, slot, ty, &init)?;
                // C99 6.5.2.5p4: a compound literal is an lvalue. An
                // array decays to (and a struct is passed by) the
                // object's address; a scalar literal yields the
                // loaded value.
                let address_only =
                    array_size != 0 || (is_struct_ty(ty) && struct_ptr_depth(ty) == 0);
                if address_only {
                    Ok(b.local_addr(slot))
                } else {
                    let kind = load_kind_for(ty, self.target);
                    Ok(b.load_local(slot, kind))
                }
            }
            Expr::Comma { lhs, rhs, .. } => {
                let _ = self.walk_expr_rvalue(b, *lhs)?;
                self.walk_expr_rvalue(b, *rhs)
            }
            // A short-circuit in value position: the result is used, so
            // normalize it to 0/1.
            Expr::ShortCircuit { .. } => self.walk_short_circuit(b, id, true),
            Expr::Intrinsic { kind, args, .. } => {
                let intr_kind = *kind;
                let mut arg_vals: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                for a in args.clone() {
                    arg_vals.push(self.walk_expr_rvalue(b, a)?);
                }
                // fma / fmaf (C99 7.12.13.1) lower to the fused node so
                // the three operands round once. The parser has already
                // coerced the arguments to the matching FP width.
                let fma_kind = super::super::op::Intrinsic::Fma as i64;
                let fmaf_kind = super::super::op::Intrinsic::Fmaf as i64;
                if intr_kind == fma_kind || intr_kind == fmaf_kind {
                    let v = b.fma(arg_vals[0], arg_vals[1], arg_vals[2], false, false);
                    if intr_kind == fmaf_kind {
                        return Ok(b.mark_f32(v));
                    }
                    return Ok(v);
                }
                // The integer bit-count builtins lower to a portable
                // shift / mask sequence here rather than a dedicated
                // instruction, so the result is identical across the
                // interpreter and every target. clz / ctz at zero are
                // undefined in GCC; this lowering returns the bit width.
                if let Some(i) = super::super::op::Intrinsic::from_i64(intr_kind)
                    && i.is_int_bit_unary()
                {
                    use super::super::op::Intrinsic as I;
                    let x = arg_vals[0];
                    let w64 = i.is_bit_unary_64();
                    return Ok(match i {
                        I::Clz | I::Clzll => lower_clz(b, x, w64),
                        I::Ctz | I::Ctzll => lower_ctz(b, x, w64),
                        _ => lower_popcount(b, x, w64),
                    });
                }
                if let Some(i) = super::super::op::Intrinsic::from_i64(intr_kind)
                    && i.is_bswap()
                {
                    use super::super::op::Intrinsic as I;
                    let bytes = match i {
                        I::Bswap16 => 2,
                        I::Bswap64 => 8,
                        _ => 4,
                    };
                    return Ok(lower_bswap(b, arg_vals[0], bytes));
                }
                // The unary FP math intrinsics produce an FP value; tag the
                // single-precision forms so the codegen picks the f32
                // instruction and width.
                let single = super::super::op::Intrinsic::from_i64(intr_kind)
                    .is_some_and(|i| i.is_single_precision());
                let v = b.intrinsic(intr_kind, arg_vals);
                if single {
                    return Ok(b.mark_f32(v));
                }
                Ok(v)
            }
            Expr::LabelAddr(label) => {
                // GCC `&&label`: materialize the address of the label's
                // block as a code pointer. block_addr records the block
                // as a computed-goto successor.
                let blk = self.block_for_label(b, *label);
                Ok(b.block_addr(blk))
            }
            Expr::Atomic {
                kind,
                args,
                elem_ty,
                ..
            } => {
                let kind = *kind;
                let elem_ty = *elem_ty;
                let args = args.clone();
                self.walk_atomic(b, kind, &args, elem_ty)
            }
        }
    }

    /// Lower a C11 7.17 atomic operation to ordinary load / store /
    /// read-modify-write on the pointee width. A naturally-aligned
    /// scalar load and store is already atomic on the supported
    /// targets, so `atomic_load` / `atomic_store` carry full
    /// semantics. The read-modify-write and compare-exchange forms
    /// lower to a non-atomic load-op-store sequence: correct for a
    /// single thread of execution but not yet inter-thread atomic.
    // TODO: emit the target's atomic read-modify-write (x86 lock
    // prefix / xchg / cmpxchg, AArch64 LSE or load-exclusive /
    // store-exclusive) for the RMW and compare-exchange forms.
    fn walk_atomic(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        kind: AtomicKind,
        args: &[ExprId],
        elem_ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let load_kind = load_kind_for(elem_ty, self.target);
        let store_kind = store_kind_for(elem_ty, self.target);
        let addr = self.walk_expr_rvalue(b, args[0])?;
        match kind {
            AtomicKind::Load => Ok(b.load(addr, load_kind)),
            AtomicKind::Store => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                b.store(addr, value, store_kind);
                // Used in statement position; the value is discarded.
                Ok(b.imm(0))
            }
            AtomicKind::Exchange
            | AtomicKind::FetchAdd
            | AtomicKind::FetchSub
            | AtomicKind::FetchAnd
            | AtomicKind::FetchOr
            | AtomicKind::FetchXor => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                let old = b.load(addr, load_kind);
                let new = match kind {
                    AtomicKind::Exchange => value,
                    AtomicKind::FetchAdd => b.binop(BinOp::Add, old, value),
                    AtomicKind::FetchSub => b.binop(BinOp::Sub, old, value),
                    AtomicKind::FetchAnd => b.binop(BinOp::And, old, value),
                    AtomicKind::FetchOr => b.binop(BinOp::Or, old, value),
                    AtomicKind::FetchXor => b.binop(BinOp::Xor, old, value),
                    _ => unreachable!(),
                };
                b.store(addr, new, store_kind);
                // C11 7.17.7: the prior value of the object.
                Ok(old)
            }
            AtomicKind::CompareExchangeStrong => {
                // C11 7.17.7.4. Branchless: a select via a 0/-1 mask
                // keeps the lowering free of basic-block management.
                // When the comparison fails the back-stores rewrite the
                // same bytes, a no-op for a single thread.
                let exp_addr = self.walk_expr_rvalue(b, args[1])?;
                let desired = self.walk_expr_rvalue(b, args[2])?;
                let cur = b.load(addr, load_kind);
                let ecur = b.load(exp_addr, load_kind);
                let eq = b.binop(BinOp::Eq, cur, ecur);
                let zero = b.imm(0);
                let mask = b.binop(BinOp::Sub, zero, eq); // 0 or -1
                // *p     = eq ? desired : cur
                let cxd = b.binop(BinOp::Xor, cur, desired);
                let sel_p = b.binop(BinOp::And, cxd, mask);
                let new_p = b.binop(BinOp::Xor, cur, sel_p);
                b.store(addr, new_p, store_kind);
                // *expected = eq ? *expected : cur
                let cxe = b.binop(BinOp::Xor, cur, ecur);
                let sel_e = b.binop(BinOp::And, cxe, mask);
                let new_e = b.binop(BinOp::Xor, cur, sel_e);
                b.store(exp_addr, new_e, store_kind);
                Ok(eq)
            }
        }
    }

    /// Walk an expression in lvalue position -- the result is the
    /// `ValueId` of the lvalue's *address*. The `Assign` rhs and
    /// `Unary{AddrOf}` cases drive into this path; the rvalue
    /// walker re-enters from this address with a matching load.
    /// Add `by` (+1 / -1) to a loaded scalar for `++` / `--`. Integer
    /// lvalues take the immediate-form add; a real floating lvalue (C99
    /// 6.5.3.1 / 6.5.2.4) adds `1.0` of its own precision through the FP
    /// path, since `BinOp::Add` would operate on the bit pattern.
    fn increment_value(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        old: super::super::ir::ValueId,
        by: i64,
        ty: i64,
    ) -> super::super::ir::ValueId {
        if !is_floating_scalar(ty) {
            return b.binop_imm(BinOp::Add, old, by);
        }
        // Run in double and narrow back for a `float`, matching the
        // compound-assign path (C99 6.3.1.5). A direct single-precision
        // `fadd` is correct on the native targets but the SSA interpreter
        // does not lower it, so route both precisions through the f64 add.
        let one = b.imm((by as f64).to_bits() as i64);
        if is_float_ty(ty) {
            let wide = b.fp_widen_to_f64(old);
            let res = b.binop(BinOp::Fadd, wide, one);
            b.fp_narrow_to_f32(res)
        } else {
            b.binop(BinOp::Fadd, old, one)
        }
    }

    /// Resolve where a read-modify-write operator targets its lvalue. A
    /// non-thread-local `Token::Loc` Ident of integer-class storage width
    /// keeps its frame slot so mem2reg can promote it; the float-stored
    /// case (`StoreKind::F32`, which the fused `StoreLocal` does not
    /// lower) and every non-local lvalue materialize an address through
    /// `walk_expr_lvalue`. Mirrors the `Expr::Assign` local-target
    /// shortcut so `i++` / `i += k` keep the counter register-resident,
    /// not just `i = i + k`.
    fn rmw_place(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        lvalue: ExprId,
        store_kind: StoreKind,
    ) -> Result<RmwPlace, WalkError> {
        // A bitfield member: compute the storage unit's address once so
        // the read and the write target the same unit (the object is
        // evaluated a single time per C99 6.5.2.4 / 6.5.16.2).
        if let Expr::Member {
            obj,
            field_off,
            bitfield: Some(bf),
            ..
        } = self.ast.expr(lvalue)
        {
            let bf = *bf;
            let obj = *obj;
            let field_off = *field_off;
            let base = self.walk_expr_rvalue(b, obj)?;
            let addr = if field_off != 0 {
                b.binop_imm(BinOp::Add, base, field_off)
            } else {
                base
            };
            return Ok(RmwPlace::Bitfield { addr, bf });
        }
        if !matches!(store_kind, StoreKind::F32)
            && let Expr::Ident {
                class,
                val,
                is_thread_local: false,
                ..
            } = self.ast.expr(lvalue)
            && *class == Token::Loc as i64
        {
            return Ok(RmwPlace::Slot(*val));
        }
        Ok(RmwPlace::Addr(self.walk_expr_lvalue(b, lvalue)?))
    }

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
                // Same constant-index fold as the rvalue Index
                // path above.
                match b.peek_imm(i) {
                    Some(k) => Ok(b.binop_imm(BinOp::Add, arr, k)),
                    None => Ok(b.binop(BinOp::Add, arr, i)),
                }
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
    /// Lower a `&&` / `||` expression (C99 6.5.13 / 6.5.14). Evaluate
    /// lhs; if it decides the result, skip rhs and jump to the merge
    /// block, otherwise evaluate rhs. A synthetic local slot stands in
    /// for the phi -- both arms store into it and the merge block loads
    /// it.
    ///
    /// `normalize` controls whether the stored value is reduced to 0/1.
    /// In value position the result is observed as an integer, so it
    /// must be `int` 0 or 1: store the constant the deciding lhs yields
    /// (`||` -> 1, `&&` -> 0) and `rhs != 0` on the evaluated path. In a
    /// branch condition only the truthiness is observed, so the raw
    /// operands are stored and the `!= 0` and the constant are skipped.
    fn walk_short_circuit(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
        normalize: bool,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let (op, lhs, rhs) = match self.ast.expr(id) {
            Expr::ShortCircuit { op, lhs, rhs, .. } => (*op, *lhs, *rhs),
            _ => unreachable!("walk_short_circuit on non-ShortCircuit"),
        };
        let slot = b.alloc_synthetic_local();
        let kind_l = super::super::ir::LoadKind::I64;
        let kind_s = super::super::ir::StoreKind::I64;
        let lhs_val = self.walk_expr_rvalue(b, lhs)?;
        // On the short-circuit path the lhs already carries the deciding
        // truth value, so in branch context its raw value suffices.
        let short_val = if normalize {
            match op {
                super::ShortCircuitOp::Lor => b.imm(1),
                super::ShortCircuitOp::Lan => b.imm(0),
            }
        } else {
            lhs_val
        };
        b.store_local(slot, short_val, kind_s);
        let rhs_blk = b.new_block();
        let after_blk = b.new_block();
        match op {
            // `a && b`: skip rhs when lhs == 0.
            super::ShortCircuitOp::Lan => b.branch_zero(lhs_val, after_blk, rhs_blk),
            // `a || b`: skip rhs when lhs != 0.
            super::ShortCircuitOp::Lor => b.branch_nonzero(lhs_val, after_blk, rhs_blk),
        }
        b.switch_to(rhs_blk);
        let rhs_val = self.walk_expr_rvalue(b, rhs)?;
        let stored = if normalize {
            b.binop_imm(super::super::ir::BinOp::Ne, rhs_val, 0)
        } else {
            rhs_val
        };
        b.store_local(slot, stored, kind_s);
        b.jmp(after_blk);
        b.switch_to(after_blk);
        Ok(b.load_local(slot, kind_l))
    }

    /// Walk an expression used as a branch condition, returning a value
    /// to test against zero. A top-level `&&` / `||` is lowered without
    /// normalizing its result, since only its truthiness is observed;
    /// any other expression is walked normally.
    fn walk_cond_value(
        &mut self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        cond: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        if matches!(self.ast.expr(cond), Expr::ShortCircuit { .. }) {
            self.walk_short_circuit(b, cond, false)
        } else {
            self.walk_expr_rvalue(b, cond)
        }
    }

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
                    // C99 6.3.1.8 / 6.5.3.3: `-x` keeps the operand's
                    // type. A `float` negation is single precision; tag
                    // the result so the codegen emits `fneg s`.
                    let neg = b.fneg(v);
                    if is_float_ty(ty) {
                        return Ok(b.mark_f32(neg));
                    }
                    Ok(neg)
                } else {
                    let zero = b.imm(0);
                    Ok(b.binop(BinOp::Sub, zero, v))
                }
            }
            UnOp::BitNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                Ok(b.binop_imm(BinOp::Xor, v, -1))
            }
            UnOp::LogNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                Ok(b.binop_imm(BinOp::Eq, v, 0))
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
    /// to an `imm_code` against the function's ent_pc.
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
                if *val == 0 {
                    Ok(b.tls_addr_extern(*sym))
                } else {
                    Ok(b.tls_addr(*val))
                }
            } else {
                match self.live_glo_addr(*sym, *val) {
                    GloAddr::Extern => Ok(b.imm_data_extern(*sym)),
                    GloAddr::Resolved(off) => Ok(b.imm_data(off)),
                }
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
            if live_val == 0 {
                Ok(b.imm_code_extern(*sym))
            } else {
                Ok(b.imm_code(live_val as usize))
            }
        } else {
            Err(WalkError::UnknownSymbolClass {
                sym: *sym,
                class: *class,
            })
        }
    }

    /// Identifier rvalue: take the address, load through the
    /// type-appropriate `LoadKind`. Reads `class` / `val` /
    /// `is_thread_local` straight off the snapshotted Ident node
    /// so a post-parse scope-exit that restored the symbol's
    /// pre-declaration tag doesn't invalidate the walker.
    #[allow(clippy::too_many_arguments)]
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
        // The parser snapshotted `val` as the function's
        // entry-PC at emit time; for `Token::Fun` references the
        // live PC lives on `self.symbols[sym].val` (sys
        // trampolines patch theirs late). Other classes
        // (`Token::Loc` / `Token::Glo` / `Token::Num`) carry a
        // stable per-frame slot / data offset / constant, so the
        // snapshot stays correct. Glo non-TLS routes through
        // `live_glo_addr` which discriminates a cross-TU extern
        // from an
        // intra-unit data offset without a 0 sentinel.
        let glo_addr = if class == Token::Glo as i64 && !is_thread_local {
            Some(self.live_glo_addr(_sym, val))
        } else {
            None
        };
        let val: i64 = if class == Token::Fun as i64 {
            self.live_fun_val(_sym, val)
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
        let address_only = array_size != 0 || (is_struct_ty(ty) && struct_ptr_depth(ty) == 0);
        if address_only {
            if class == Token::Loc as i64 {
                return Ok(b.local_addr(val));
            } else if let Some(addr) = glo_addr {
                return Ok(match addr {
                    GloAddr::Extern => b.imm_data_extern(_sym),
                    GloAddr::Resolved(off) => b.imm_data(off),
                });
            } else if class == Token::Glo as i64 && is_thread_local {
                if val == 0 {
                    return Ok(b.tls_addr_extern(_sym));
                }
                return Ok(b.tls_addr(val));
            }
        }
        if class == Token::Loc as i64 {
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local(val, kind))
        } else if let Some(addr) = glo_addr {
            let addr_v = match addr {
                GloAddr::Extern => b.imm_data_extern(_sym),
                GloAddr::Resolved(off) => b.imm_data(off),
            };
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr_v, kind))
        } else if class == Token::Glo as i64 && is_thread_local {
            let addr = if val == 0 {
                b.tls_addr_extern(_sym)
            } else {
                b.tls_addr(val)
            };
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr, kind))
        } else if class == Token::Fun as i64 {
            if val == 0 {
                Ok(b.imm_code_extern(_sym))
            } else {
                Ok(b.imm_code(val as usize))
            }
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

/// Where a read-modify-write operator (`++` / `--` / `op=`) reads and
/// writes its lvalue. A plain non-thread-local local of integer-class
/// storage width uses its frame slot directly (`LoadLocal` /
/// `StoreLocal`); every other lvalue -- a dereference, an array element,
/// a struct field, or a float-stored local -- routes through a
/// materialized address. The slot path takes no `LocalAddr`, so the slot
/// stays promotable in `promotable_slots`; the address path marks it
/// address-taken and pins it to memory.
enum RmwPlace {
    Slot(i64),
    Addr(super::super::ir::ValueId),
    /// A bitfield read-modify-write target: the storage unit's address
    /// and the field descriptor. `load` extracts the field value;
    /// `store` merges the new value back into the unit, preserving the
    /// other bits. The passed `LoadKind` / `StoreKind` are ignored; the
    /// unit width comes from the descriptor.
    Bitfield {
        addr: super::super::ir::ValueId,
        bf: super::super::ast::BitfieldDesc,
    },
}

impl RmwPlace {
    fn load(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        kind: LoadKind,
    ) -> super::super::ir::ValueId {
        match *self {
            RmwPlace::Slot(off) => b.load_local(off, kind),
            RmwPlace::Addr(addr) => b.load(addr, kind),
            RmwPlace::Bitfield { addr, bf } => {
                // C99 6.7.2.1: load the unit, shift the slice to bit 0,
                // mask, and sign-extend when the field type is signed.
                let unit_kind = match bf.unit_size {
                    1 => LoadKind::U8,
                    2 => LoadKind::U16,
                    4 => LoadKind::U32,
                    _ => LoadKind::I64,
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
                v
            }
        }
    }

    fn store(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        value: super::super::ir::ValueId,
        kind: StoreKind,
    ) {
        match *self {
            RmwPlace::Slot(off) => {
                b.store_local(off, value, kind);
            }
            RmwPlace::Addr(addr) => {
                b.store(addr, value, kind);
            }
            RmwPlace::Bitfield { addr, bf } => {
                // C99 6.7.2.1: load the unit, clear the slice, mask + shift
                // the new value into place, OR back, store.
                let (load_kind, store_kind) = match bf.unit_size {
                    1 => (LoadKind::U8, StoreKind::I8),
                    2 => (LoadKind::U16, StoreKind::I16),
                    4 => (LoadKind::U32, StoreKind::I32),
                    _ => (LoadKind::I64, StoreKind::I64),
                };
                let mask: i64 = if bf.bit_width >= 64 {
                    -1
                } else {
                    (1i64 << bf.bit_width) - 1
                };
                let clear_mask: i64 = !(mask << bf.bit_offset);
                let old = b.load(addr, load_kind);
                let cleared = b.binop_imm(BinOp::And, old, clear_mask);
                let masked = b.binop_imm(BinOp::And, value, mask);
                let shifted = if bf.bit_offset > 0 {
                    b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
                } else {
                    masked
                };
                let combined = b.binop(BinOp::Or, cleared, shifted);
                b.store(addr, combined, store_kind);
            }
        }
    }
}

/// Map a c5 type tag to the matching `LoadKind`. Mirrors
/// `compiler::types::load_op_for`.
fn load_kind_for(ty: i64, target: Target) -> LoadKind {
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return LoadKind::I64;
    }
    if stripped == Ty::Bool as i64 {
        // 1-byte `_Bool`, always zero-extends (holds only 0 / 1).
        LoadKind::U8
    } else if stripped == Ty::Char as i64 {
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
    } else if stripped == Ty::Double as i64 {
        LoadKind::F64
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
    if stripped == Ty::Bool as i64 || stripped == Ty::Char as i64 {
        StoreKind::I8
    } else if stripped == Ty::Short as i64 {
        StoreKind::I16
    } else if stripped == Ty::Int as i64 {
        StoreKind::I32
    } else if stripped == Ty::Float as i64 {
        StoreKind::F32
    } else if stripped == Ty::Double as i64 {
        StoreKind::F64
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

/// True for the scalar `float` type. C99 6.3.1.8 leaves `float op
/// float` at type `float` (single precision); the walker tags the
/// result and feeds the single-precision codegen path.
fn is_float_ty(ty: i64) -> bool {
    (ty & !UNSIGNED_BIT) == Ty::Float as i64
}

/// True for the scalar `_Bool` type (not a pointer to one). Used by
/// the cast lowering to apply the C99 6.3.1.2 conversion (any
/// nonzero scalar becomes 1).
fn is_bool_scalar(ty: i64) -> bool {
    (ty & !UNSIGNED_BIT) == Ty::Bool as i64
}

/// `Token::Ty` unsigned-bit position. The compiler-side helper is
/// `pub(super)`-visible to the parser module only; the walker
/// keeps a local copy to avoid coupling to the compiler module.
const UNSIGNED_BIT: i64 = 1 << 30;

// Portable lowering of the GCC bit-count builtins (`__builtin_clz` /
// `ctz` / `popcount` and the 64-bit `ll` forms). Each expands to a
// branchless shift / mask sequence over the SSA builder so the result
// matches across the interpreter and every target without a dedicated
// instruction. `w64` selects the 64-bit forms; the rest operate on the
// low 32 bits (the operand reaches here zero-extended from the parser's
// unsigned cast).

type Bld = super::super::codegen::ssa_build::SsaBuilder;
type Val = super::super::ir::ValueId;

/// Count set bits via the standard SWAR reduction. Right shifts are
/// logical (`BinOp::Shru`) so the masks see clean bits regardless of
/// the operand's sign. The result is at most the bit width, so the
/// final `& 0x7f` extracts it.
fn lower_popcount(b: &mut Bld, x: Val, w64: bool) -> Val {
    let su = BinOp::Shru;
    let and = BinOp::And;
    if w64 {
        let t = b.binop_imm(su, x, 1);
        let t = b.binop_imm(and, t, 0x5555_5555_5555_5555u64 as i64);
        let a = b.binop(BinOp::Sub, x, t);
        let lo = b.binop_imm(and, a, 0x3333_3333_3333_3333u64 as i64);
        let hi = b.binop_imm(su, a, 2);
        let hi = b.binop_imm(and, hi, 0x3333_3333_3333_3333u64 as i64);
        let a = b.binop(BinOp::Add, lo, hi);
        let s = b.binop_imm(su, a, 4);
        let a = b.binop(BinOp::Add, a, s);
        let a = b.binop_imm(and, a, 0x0f0f_0f0f_0f0f_0f0fu64 as i64);
        let s = b.binop_imm(su, a, 8);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 16);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 32);
        let a = b.binop(BinOp::Add, a, s);
        b.binop_imm(and, a, 0x7f)
    } else {
        let x = b.binop_imm(and, x, 0xffff_ffff);
        let t = b.binop_imm(su, x, 1);
        let t = b.binop_imm(and, t, 0x5555_5555);
        let a = b.binop(BinOp::Sub, x, t);
        let lo = b.binop_imm(and, a, 0x3333_3333);
        let hi = b.binop_imm(su, a, 2);
        let hi = b.binop_imm(and, hi, 0x3333_3333);
        let a = b.binop(BinOp::Add, lo, hi);
        let s = b.binop_imm(su, a, 4);
        let a = b.binop(BinOp::Add, a, s);
        let a = b.binop_imm(and, a, 0x0f0f_0f0f);
        let s = b.binop_imm(su, a, 8);
        let a = b.binop(BinOp::Add, a, s);
        let s = b.binop_imm(su, a, 16);
        let a = b.binop(BinOp::Add, a, s);
        b.binop_imm(and, a, 0x7f)
    }
}

/// Count leading zeros: smear the highest set bit down to fill the low
/// bits, then `width - popcount`. At zero the smear stays zero and the
/// result is the bit width.
fn lower_clz(b: &mut Bld, x: Val, w64: bool) -> Val {
    let su = BinOp::Shru;
    let or = BinOp::Or;
    let t = b.binop_imm(su, x, 1);
    let mut s = b.binop(or, x, t);
    for sh in [2, 4, 8, 16] {
        let t = b.binop_imm(su, s, sh);
        s = b.binop(or, s, t);
    }
    if w64 {
        let t = b.binop_imm(su, s, 32);
        s = b.binop(or, s, t);
    }
    let pc = lower_popcount(b, s, w64);
    let width = b.imm(if w64 { 64 } else { 32 });
    b.binop(BinOp::Sub, width, pc)
}

/// Count trailing zeros as `popcount((x - 1) & ~x)`: `x - 1` turns the
/// trailing zeros into ones and clears the lowest set bit, and `~x`
/// keeps only those positions. At zero the mask is all-ones and the
/// result is the bit width.
fn lower_ctz(b: &mut Bld, x: Val, w64: bool) -> Val {
    let xm1 = b.binop_imm(BinOp::Sub, x, 1);
    let notx = b.binop_imm(BinOp::Xor, x, -1);
    let m = b.binop(BinOp::And, xm1, notx);
    lower_popcount(b, m, w64)
}

/// Reverse the low `n` bytes of `x`: extract each byte with a logical
/// shift and mask, shift it to the mirrored position, and or the bytes
/// together. `n` is 2, 4, or 8.
fn lower_bswap(b: &mut Bld, x: Val, n: i64) -> Val {
    let mut acc: Option<Val> = None;
    for i in 0..n {
        let src_shift = i * 8;
        let dst_shift = (n - 1 - i) * 8;
        let shifted = if src_shift == 0 {
            x
        } else {
            b.binop_imm(BinOp::Shru, x, src_shift)
        };
        let byte = b.binop_imm(BinOp::And, shifted, 0xff);
        let placed = if dst_shift == 0 {
            byte
        } else {
            b.binop_imm(BinOp::Shl, byte, dst_shift)
        };
        acc = Some(match acc {
            None => placed,
            Some(a) => b.binop(BinOp::Or, a, placed),
        });
    }
    acc.unwrap_or(x)
}

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
        | Expr::Intrinsic { ty, .. }
        | Expr::Atomic { ty, .. } => Some(*ty),
        Expr::Cast { to_ty, .. } => Some(*to_ty),
        Expr::Sizeof(s) => Some(s.result_ty),
        Expr::CompoundLiteral { ty, .. } => Some(*ty),
        // `&&label` is a `void *` (char-pointer encoding).
        Expr::LabelAddr(_) => {
            Some(crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64)
        }
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
    if stripped == Ty::Bool as i64 || stripped == Ty::Char as i64 {
        1
    } else if stripped == Ty::Short as i64 {
        2
    } else if stripped == Ty::Int as i64 || stripped == Ty::Float as i64 {
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
/// signed type. Takes only the common type tag and lets the
/// walker apply the mask through `BinopI(And, _, mask)`.
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

/// Fold an integer binop on two constant operands. C99 6.6
/// permits this at translation time. Caller restricts `op` to
/// the set the per-arch BinopI lowering covers (no Div / Divu /
/// Mod / Modu, no FP), so the only well-defined surfaces are
/// arithmetic, bitwise, shift, and integer comparison. Shifts
/// at out-of-range amounts produce 0 (matches what `lsl xd, xn,
/// xm` with `xm >= 64` would land on; signed `asr` on a
/// non-negative operand likewise saturates to 0, and on a
/// negative operand to -1, so the model picks the closer of the
/// two for the rhs's sign).
fn fold_int_binop(op: BinOp, lhs: i64, rhs: i64) -> i64 {
    match op {
        BinOp::Add => lhs.wrapping_add(rhs),
        BinOp::Sub => lhs.wrapping_sub(rhs),
        BinOp::Mul => lhs.wrapping_mul(rhs),
        BinOp::And => lhs & rhs,
        BinOp::Or => lhs | rhs,
        BinOp::Xor => lhs ^ rhs,
        BinOp::Shl => {
            let s = rhs as u32 & 63;
            ((lhs as u64) << s) as i64
        }
        BinOp::Shr => {
            let s = rhs as u32 & 63;
            lhs >> s
        }
        BinOp::Shru => {
            let s = rhs as u32 & 63;
            ((lhs as u64) >> s) as i64
        }
        BinOp::Eq => (lhs == rhs) as i64,
        BinOp::Ne => (lhs != rhs) as i64,
        BinOp::Lt => (lhs < rhs) as i64,
        BinOp::Gt => (lhs > rhs) as i64,
        BinOp::Le => (lhs <= rhs) as i64,
        BinOp::Ge => (lhs >= rhs) as i64,
        BinOp::Ult => ((lhs as u64) < (rhs as u64)) as i64,
        BinOp::Ugt => ((lhs as u64) > (rhs as u64)) as i64,
        BinOp::Ule => ((lhs as u64) <= (rhs as u64)) as i64,
        BinOp::Uge => ((lhs as u64) >= (rhs as u64)) as i64,
        _ => unreachable!("fold_int_binop reached on non-imm-safe op"),
    }
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
        Expr::CompoundLiteral { .. } => "CompoundLiteral",
        Expr::Comma { .. } => "Comma",
        Expr::Intrinsic { .. } => "Intrinsic",
        Expr::ShortCircuit { .. } => "ShortCircuit",
        Expr::Atomic { .. } => "Atomic",
        Expr::LabelAddr(_) => "LabelAddr",
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

    /// `return 7 + 3;` -- both operands are integer literals,
    /// so C99 6.6 constant evaluation kicks in and the walker
    /// emits a single `Imm(10)` without producing the binop at
    /// all.
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

        let func = walk_function(
            &ast,
            &empty_symbols(),
            &[],
            Target::LinuxAarch64,
            0,
            0,
            0,
            false,
            0,
            &[],
            &[],
            false,
            0,
            Ty::Int as i64,
            0,
        )
        .expect("walk");
        let immediates: alloc::vec::Vec<i64> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(v) => Some(*v),
                _ => None,
            })
            .collect();
        // The walker folds `7 + 3` to the single value 10 -- no
        // binop, just one `Imm`.
        assert_eq!(immediates, alloc::vec![10i64]);
        let any_binop = func
            .insts
            .iter()
            .any(|i| matches!(i, Inst::Binop { .. } | Inst::BinopI { .. }));
        assert!(!any_binop, "constant-fold should leave no binop");
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

        let func = walk_function(
            &ast,
            &syms,
            &[],
            Target::LinuxAarch64,
            0,
            0,
            0,
            false,
            8,
            &[],
            &[],
            false,
            0,
            0,
            0,
        )
        .expect("walk");
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

    /// A scalar local assignment lowers to a single fused
    /// `StoreLocal` of the value's natural width.
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

        let func = walk_function(
            &ast,
            &syms,
            &[],
            Target::LinuxAarch64,
            0,
            0,
            0,
            false,
            8,
            &[],
            &[],
            false,
            0,
            0,
            0,
        )
        .expect("walk");
        let store_kinds: alloc::vec::Vec<_> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::StoreLocal { off, kind, .. } => Some((*off, *kind)),
                _ => None,
            })
            .collect();
        assert_eq!(store_kinds, alloc::vec![(-1, StoreKind::I32)]);
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

        let func = walk_function(
            &ast,
            &empty_symbols(),
            &[],
            Target::LinuxAarch64,
            0,
            0,
            0,
            false,
            0,
            &[],
            &[],
            false,
            0,
            0,
            0,
        )
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

        let err = walk_function(
            &ast,
            &empty_symbols(),
            &[],
            Target::LinuxAarch64,
            0,
            0,
            0,
            false,
            0,
            &[],
            &[],
            false,
            0,
            0,
            0,
        )
        .expect_err("Asm must surface as unsupported");
        assert!(matches!(
            err,
            WalkError::UnsupportedStmt { kind: "Asm", .. }
        ));
    }
}
