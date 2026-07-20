//! `Ast` -> `FunctionSsa` walker.
//!
//! Drives `SsaBuilder` from a per-function AST. The walker is the
//! production SSA source for every parsed function. An AST shape
//! the walker can't lower comes back as `WalkError` so the
//! caller (`codegen::ssa::shadow::produce_ssa_funcs`) can surface
//! the offending node.

#![allow(dead_code)]

use alloc::string::String;

use super::super::codegen::Target;
use super::super::codegen::ssa::build::SsaBuilder;
use super::super::compiler::types::{
    STRUCT_BASE, STRUCT_STRIDE, UNSIGNED_BIT, VOLATILE_BIT, is_pointer_ty, is_struct_ty,
    is_vector_ty, is_volatile_ty, load_kind, strip_unsigned, struct_ptr_depth,
};
use super::super::ir::{AtomicRmwOp, BinOp, FunctionSsa, LoadKind, StoreKind, ValueId};
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::{AtomicKind, Expr, ExprId, Stmt, StmtId, UnOp};

/// The low and high 64-bit halves of a 128-bit value, in that order.
type Halves = (ValueId, ValueId);

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
    let mut b = super::super::codegen::ssa::build::SsaBuilder::new(ent_pc, n_params, is_variadic);
    b.set_end_pc(end_pc);
    // C99 6.8: the frame holds the declared locals; alloca / VLA
    // storage is carved from the stack at runtime (the per-arch
    // emit moves sp), so no extra slots are reserved for it. With
    // alloca the parser's Ent patch appends one reserved slot
    // (`alloca_top_slot = regular locals + 1`), which also covers
    // every regular slot.
    let effective_locals = if alloca_top_slot > 0 {
        alloca_top_slot
    } else {
        n_locals
    };
    if effective_locals != 0 {
        b.set_locals(effective_locals);
    }
    // `alloca_top_slot == 0` means the body has no `alloca` call.
    // A non-zero slot marks the function dynamic-sp for the
    // codegen: spill slots move to fp-based addressing and the
    // epilogue re-establishes sp.
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
    b.set_ret_type_tag(return_ty);
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
            let stripped = strip_unsigned(pty);
            if stripped == crate::c5::token::Ty::Float as i64
                || stripped == crate::c5::token::Ty::Double as i64
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
            let stripped = strip_unsigned(pty);
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
            // An unsigned-tagged parameter keeps the full 8-byte
            // store/load so the body's zero-extending reads see the
            // caller's extension rather than a sign-extended narrow
            // reload. Pointer tags land in the I64 default arm by
            // band value.
            use crate::c5::token::Ty;
            let unsigned = pty & UNSIGNED_BIT != 0;
            let (store_kind, load_kind) = if unsigned {
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
        let stripped = strip_unsigned(pty);
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
        alloc::vec::Vec<(i64, i64, super::super::ir::BlockId)>,
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
        // A variadic callee whose prototype was not recoverable from its
        // symbol -- a struct-field, array-element, or dereferenced
        // function pointer -- is recorded at parse time with its fixed
        // (pre-ellipsis) parameter count, keyed by the callee ExprId.
        if let Some(&(_, fixed)) = self
            .ast
            .variadic_indirect_callees
            .iter()
            .find(|(c, _)| *c == callee)
        {
            return (true, fixed as usize);
        }
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
            // Forward reference: a block-scope `extern int g;` parsed
            // before the same-TU `int g = ...;` definition (C99 6.2.2p4)
            // snapshots a stale 0 offset into the `Expr::Ident`, so the
            // access lands at the wrong `.data` address. When the live
            // symbol is now a defined global carrying a real offset,
            // use it. The `fallback_val == 0` guard keeps shadowed
            // same-named globals -- which snapshot their own distinct
            // nonzero offsets -- on the snapshot path.
            if s.class == Token::Glo as i64
                && s.defined_here
                && !s.is_extern_decl
                && fallback_val == 0
                && s.val != 0
            {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Resolved(fallback_val)
    }

    /// Resolve a block-scope `extern` reference that shadowed a bound
    /// name (recorded in `Ast::block_extern_refs`). The slot's class was
    /// restored to the shadowed binding at block exit, so its live state
    /// no longer reflects the external reference. When the name has a
    /// same-TU file-scope definition the shared slot carries its offset
    /// after all scope-exit restores (the definition is the slot's final
    /// writer); use it. Otherwise the reference is cross-TU and resolves
    /// by name through `extern_imm_data_refs`.
    fn block_extern_glo_addr(&self, sym: u32) -> GloAddr {
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.class == Token::Glo as i64 && s.defined_here {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Extern
    }

    /// Address class for a `_Thread_local` access. A pure extern
    /// reference (`extern _Thread_local T x;` with no definition here)
    /// resolves by symbol against the merged TLS block at link time;
    /// a unit-local definition uses its byte offset within this unit's
    /// TLS block. Mirrors `live_glo_addr` for the TLS template.
    fn live_tls_addr(&self, sym: u32, fallback_val: i64) -> GloAddr {
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.is_extern_decl && !s.defined_here {
                return GloAddr::Extern;
            }
            if s.defined_here {
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
        let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
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
    /// True when `ty` is the GCC 128-bit `__int128` as a value (not a
    /// pointer to one). It shares the struct machinery but a cast to or
    /// from a scalar converts the 128-bit value, unlike a plain struct
    /// whose value in a scalar context is just its address.
    fn is_int128_value_ty(&self, ty: i64) -> bool {
        let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
        if stripped < STRUCT_BASE || struct_ptr_depth(ty) != 0 {
            return false;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        self.structs.get(id).is_some_and(|s| s.name == "__int128")
    }
    /// True when the expression's type tag carries the volatile
    /// qualifier (C99 6.7.3); `false` for node shapes without a type.
    fn expr_is_volatile(&self, id: ExprId) -> bool {
        expr_ty(self.ast.expr(id)).is_some_and(is_volatile_ty)
    }

    /// Lower a bitwise operator (`^`/`&`/`|`) on two same-width GCC vector
    /// values into a result temporary. Bitwise ops carry no value between
    /// lanes, so the byte block is combined in the widest chunks that fit
    /// (8/4/2/1) regardless of the element width. Both operands are aggregate
    /// rvalues (their address lands on the accumulator); the result is a fresh
    /// synthetic aggregate whose address is returned, matching how a struct
    /// rvalue is produced.
    fn walk_vector_bitwise(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let lhs_addr = self.walk_expr_rvalue(b, lhs)?;
        let rhs_addr = self.walk_expr_rvalue(b, rhs)?;
        let size = self.struct_size(ty);
        let slot = b.alloc_synthetic_struct(size);
        let dst = b.local_addr(slot);
        // Widest-chunk cover: (width, load kind, store kind).
        const CHUNKS: [(i64, LoadKind, StoreKind); 4] = [
            (8, LoadKind::I64, StoreKind::I64),
            (4, LoadKind::U32, StoreKind::I32),
            (2, LoadKind::U16, StoreKind::I16),
            (1, LoadKind::U8, StoreKind::I8),
        ];
        let mut off = 0;
        while off < size {
            let remaining = size - off;
            let (w, lk, sk) = CHUNKS
                .iter()
                .find(|(w, ..)| *w <= remaining)
                .copied()
                .unwrap();
            let la = if off == 0 {
                lhs_addr
            } else {
                b.binop_imm(BinOp::Add, lhs_addr, off)
            };
            let ra = if off == 0 {
                rhs_addr
            } else {
                b.binop_imm(BinOp::Add, rhs_addr, off)
            };
            let da = if off == 0 {
                dst
            } else {
                b.binop_imm(BinOp::Add, dst, off)
            };
            let a = b.load(la, lk);
            let c = b.load(ra, lk);
            let r = b.binop(op, a, c);
            b.store(da, r, sk);
            off += w;
        }
        Ok(dst)
    }

    /// Load the two 64-bit halves of the 128-bit object at `addr`
    /// (little-endian: low half first).
    fn int128_load(&mut self, b: &mut SsaBuilder, addr: ValueId) -> Halves {
        let lo = b.load(addr, LoadKind::I64);
        let hi_addr = b.binop_imm(BinOp::Add, addr, 8);
        let hi = b.load(hi_addr, LoadKind::I64);
        (lo, hi)
    }

    /// Store a lo/hi half pair into the 128-bit object at `addr`.
    fn int128_store(&mut self, b: &mut SsaBuilder, addr: ValueId, (lo, hi): Halves) {
        b.store(addr, lo, StoreKind::I64);
        let hi_addr = b.binop_imm(BinOp::Add, addr, 8);
        b.store(hi_addr, hi, StoreKind::I64);
    }

    /// Materialise a half pair as a fresh 16-byte object and return its
    /// address (the struct-rvalue address-as-value rule).
    fn int128_materialize(&mut self, b: &mut SsaBuilder, pair: Halves) -> ValueId {
        let slot = b.alloc_synthetic_struct(16);
        let addr = b.local_addr(slot);
        self.int128_store(b, addr, pair);
        addr
    }

    /// Walk one operand of a 128-bit operation into a half pair. An
    /// int128-typed operand is an address to load through; a scalar
    /// converts per C99 6.3.1.3 (widen to 64 bits, then sign- or
    /// zero-fill the high half, mirroring `store_scalar_as_int128`).
    fn int128_operand(&mut self, b: &mut SsaBuilder, id: ExprId) -> Result<Halves, WalkError> {
        let ty = expr_ty(self.ast.expr(id)).unwrap_or(Ty::Int as i64);
        let is128 = self.expr_is_int128_value(id);
        let v = self.walk_expr_rvalue(b, id)?;
        if is128 {
            return Ok(self.int128_load(b, v));
        }
        let ty = if self.is_int128_value_ty(ty) {
            Ty::Int as i64
        } else {
            ty
        };
        let low_ty = Ty::LongLong as i64 | (ty & UNSIGNED_BIT);
        let lo = self.convert_scalar_value(b, v, ty, low_ty);
        let hi = if (ty & UNSIGNED_BIT) != 0 || is_pointer_ty(ty) {
            b.imm(0)
        } else {
            b.binop_imm(BinOp::Shr, lo, 63)
        };
        Ok((lo, hi))
    }

    /// 128-bit addition: 64-bit halves with the carry recovered from
    /// the unsigned low-half compare (`lo < a.lo` iff the add wrapped).
    fn int128_add(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let lo = b.binop(BinOp::Add, a.0, c.0);
        let carry = b.binop(BinOp::Ult, lo, a.0);
        let hi = b.binop(BinOp::Add, a.1, c.1);
        let hi = b.binop(BinOp::Add, hi, carry);
        (lo, hi)
    }

    /// 128-bit subtraction with the borrow from the unsigned low-half
    /// compare.
    fn int128_sub(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let borrow = b.binop(BinOp::Ult, a.0, c.0);
        let lo = b.binop(BinOp::Sub, a.0, c.0);
        let hi = b.binop(BinOp::Sub, a.1, c.1);
        let hi = b.binop(BinOp::Sub, hi, borrow);
        (lo, hi)
    }

    /// 128-bit two's-complement negation (`0 - a`).
    fn int128_neg(b: &mut SsaBuilder, a: Halves) -> Halves {
        let zero = b.imm(0);
        Self::int128_sub(b, (zero, zero), a)
    }

    /// `(a ^ m) - m` where `m` is 0 or all-ones in both halves: the
    /// branchless conditional negation used by the signed divide.
    fn int128_xor_sub(b: &mut SsaBuilder, a: Halves, m: ValueId) -> Halves {
        let lo = b.binop(BinOp::Xor, a.0, m);
        let hi = b.binop(BinOp::Xor, a.1, m);
        Self::int128_sub(b, (lo, hi), (m, m))
    }

    /// 128-bit shift by a runtime count. `op` is `Shl`, `Shru`, or
    /// `Shr` (arithmetic). The count is reduced mod 128 (matching the
    /// per-arch 64-bit shifter's mod-64 rule one level up); the two
    /// count ranges ([0,63] and [64,127]) are computed branchlessly and
    /// selected by mask. Sub-shifts stay in [0,63] so every 64-bit
    /// shift below is defined on all backends: `x >> (64-t)` is written
    /// `(x >> (63-t)) >> 1`, which is 0 at `t = 0` as required.
    fn int128_shift(b: &mut SsaBuilder, op: BinOp, a: Halves, count: ValueId) -> Halves {
        let s = b.binop_imm(BinOp::And, count, 127);
        let t = b.binop_imm(BinOp::And, s, 63);
        let inv = {
            let k = b.imm(63);
            b.binop(BinOp::Sub, k, t)
        };
        // big = 1 when the count is in [64,127]; mask = all-ones then.
        let big = b.binop_imm(BinOp::Shru, s, 6);
        let mask = {
            let zero = b.imm(0);
            b.binop(BinOp::Sub, zero, big)
        };
        let nmask = b.binop_imm(BinOp::Xor, mask, -1);
        let sel = |b: &mut SsaBuilder, small: ValueId, large: ValueId| {
            let x = b.binop(BinOp::And, small, nmask);
            let y = b.binop(BinOp::And, large, mask);
            b.binop(BinOp::Or, x, y)
        };
        match op {
            BinOp::Shl => {
                let l1 = b.binop(BinOp::Shl, a.0, t);
                let c = b.binop(BinOp::Shru, a.0, inv);
                let c = b.binop_imm(BinOp::Shru, c, 1);
                let h = b.binop(BinOp::Shl, a.1, t);
                let h1 = b.binop(BinOp::Or, h, c);
                let zero = b.imm(0);
                (sel(b, l1, zero), sel(b, h1, l1))
            }
            BinOp::Shru => {
                let h1 = b.binop(BinOp::Shru, a.1, t);
                let c = b.binop(BinOp::Shl, a.1, inv);
                let c = b.binop_imm(BinOp::Shl, c, 1);
                let l = b.binop(BinOp::Shru, a.0, t);
                let l1 = b.binop(BinOp::Or, l, c);
                let zero = b.imm(0);
                (sel(b, l1, h1), sel(b, h1, zero))
            }
            _ => {
                // Arithmetic: the emptied high half fills with the sign.
                let h1 = b.binop(BinOp::Shr, a.1, t);
                let c = b.binop(BinOp::Shl, a.1, inv);
                let c = b.binop_imm(BinOp::Shl, c, 1);
                let l = b.binop(BinOp::Shru, a.0, t);
                let l1 = b.binop(BinOp::Or, l, c);
                let sign = b.binop_imm(BinOp::Shr, a.1, 63);
                (sel(b, l1, h1), sel(b, h1, sign))
            }
        }
    }

    /// 128-bit shift by a constant count (folded form of
    /// [`Self::int128_shift`]).
    fn int128_shift_const(b: &mut SsaBuilder, op: BinOp, a: Halves, count: i64) -> Halves {
        let k = count & 127;
        if k == 0 {
            return a;
        }
        match op {
            BinOp::Shl => {
                if k < 64 {
                    let lo = b.binop_imm(BinOp::Shl, a.0, k);
                    let h = b.binop_imm(BinOp::Shl, a.1, k);
                    let c = b.binop_imm(BinOp::Shru, a.0, 64 - k);
                    (lo, b.binop(BinOp::Or, h, c))
                } else {
                    let zero = b.imm(0);
                    (zero, b.binop_imm(BinOp::Shl, a.0, k - 64))
                }
            }
            BinOp::Shru => {
                if k < 64 {
                    let hi = b.binop_imm(BinOp::Shru, a.1, k);
                    let l = b.binop_imm(BinOp::Shru, a.0, k);
                    let c = b.binop_imm(BinOp::Shl, a.1, 64 - k);
                    (b.binop(BinOp::Or, l, c), hi)
                } else {
                    let lo = b.binop_imm(BinOp::Shru, a.1, k - 64);
                    (lo, b.imm(0))
                }
            }
            _ => {
                if k < 64 {
                    let hi = b.binop_imm(BinOp::Shr, a.1, k);
                    let l = b.binop_imm(BinOp::Shru, a.0, k);
                    let c = b.binop_imm(BinOp::Shl, a.1, 64 - k);
                    (b.binop(BinOp::Or, l, c), hi)
                } else {
                    let lo = b.binop_imm(BinOp::Shr, a.1, k - 64);
                    (lo, b.binop_imm(BinOp::Shr, a.1, 63))
                }
            }
        }
    }

    /// High 64 bits of the unsigned 64x64 product, composed from the
    /// four 32-bit partial products. Built from ops every backend
    /// already has, so the VM, the JIT and both native targets agree by
    /// construction.
    // TODO: a widening-multiply opcode would fold this to one
    // instruction (x86_64 `mul`, aarch64 `umulh`).
    fn int128_mulhi_u(b: &mut SsaBuilder, x: ValueId, y: ValueId) -> ValueId {
        const LOW32: i64 = 0xffff_ffff;
        let x0 = b.binop_imm(BinOp::And, x, LOW32);
        let x1 = b.binop_imm(BinOp::Shru, x, 32);
        let y0 = b.binop_imm(BinOp::And, y, LOW32);
        let y1 = b.binop_imm(BinOp::Shru, y, 32);
        let carry = {
            let p = b.binop(BinOp::Mul, x0, y0);
            b.binop_imm(BinOp::Shru, p, 32)
        };
        let mid = {
            let p = b.binop(BinOp::Mul, x1, y0);
            b.binop(BinOp::Add, p, carry)
        };
        let mid_lo = b.binop_imm(BinOp::And, mid, LOW32);
        let mid_hi = b.binop_imm(BinOp::Shru, mid, 32);
        let mid2_hi = {
            let p = b.binop(BinOp::Mul, x0, y1);
            let s = b.binop(BinOp::Add, p, mid_lo);
            b.binop_imm(BinOp::Shru, s, 32)
        };
        let hi = b.binop(BinOp::Mul, x1, y1);
        let hi = b.binop(BinOp::Add, hi, mid_hi);
        b.binop(BinOp::Add, hi, mid2_hi)
    }

    /// 128-bit multiply. The low half is the 64-bit product of the low
    /// halves; the high half adds that product's carry-out to the two
    /// cross terms. The `a.hi * c.hi` term only reaches bit 128 and up,
    /// so it is dropped (C99 6.2.5p9: the result wraps mod 2^128).
    fn int128_mul(b: &mut SsaBuilder, a: Halves, c: Halves) -> Halves {
        let lo = b.binop(BinOp::Mul, a.0, c.0);
        let hi = Self::int128_mulhi_u(b, a.0, c.0);
        let cross0 = b.binop(BinOp::Mul, a.0, c.1);
        let cross1 = b.binop(BinOp::Mul, a.1, c.0);
        let hi = b.binop(BinOp::Add, hi, cross0);
        let hi = b.binop(BinOp::Add, hi, cross1);
        (lo, hi)
    }

    /// Unsigned 128-bit divide, returning `(quotient, remainder)`.
    ///
    /// Operands that both fit in 64 bits take the hardware divide. The
    /// general case is a restoring shift-subtract over the 128 bits:
    /// the dividend shifts left out of `n` into the running remainder
    /// while the quotient bits shift into `n` from below, so both
    /// results share one register pair. The body is branchless (the
    /// compare feeds a 0/-1 mask), leaving one loop-carried branch.
    ///
    /// This is lowered inline rather than as a call to a runtime helper
    /// because the same lowering then serves the VM, the JIT and both
    /// native targets, with no helper to link into freestanding images.
    ///
    /// A zero divisor is undefined (C99 6.5.5p5), as for the 64-bit
    /// operators: the hardware path traps and the loop yields all-ones.
    fn int128_udivmod(&mut self, b: &mut SsaBuilder, a: Halves, c: Halves) -> (Halves, Halves) {
        let q_lo = b.alloc_synthetic_local();
        let q_hi = b.alloc_synthetic_local();
        let r_lo = b.alloc_synthetic_local();
        let r_hi = b.alloc_synthetic_local();
        let sk = StoreKind::I64;
        let lk = LoadKind::I64;

        let wide = b.binop(BinOp::Or, a.1, c.1);
        let narrow_blk = b.new_block();
        let wide_blk = b.new_block();
        let done_blk = b.new_block();
        b.branch_zero(wide, narrow_blk, wide_blk);

        b.switch_to(narrow_blk);
        let q = b.binop(BinOp::Divu, a.0, c.0);
        let r = b.binop(BinOp::Modu, a.0, c.0);
        let zero = b.imm(0);
        b.store_local(q_lo, q, sk);
        b.store_local(q_hi, zero, sk);
        b.store_local(r_lo, r, sk);
        b.store_local(r_hi, zero, sk);
        b.jmp(done_blk);

        b.switch_to(wide_blk);
        let zero = b.imm(0);
        b.store_local(q_lo, a.0, sk);
        b.store_local(q_hi, a.1, sk);
        b.store_local(r_lo, zero, sk);
        b.store_local(r_hi, zero, sk);
        let counter = b.alloc_synthetic_local();
        let n = b.imm(128);
        b.store_local(counter, n, sk);
        let head_blk = b.new_block();
        let body_blk = b.new_block();
        b.jmp(head_blk);

        b.switch_to(head_blk);
        let i = b.load_local(counter, lk);
        b.branch_zero(i, done_blk, body_blk);

        b.switch_to(body_blk);
        let nl = b.load_local(q_lo, lk);
        let nh = b.load_local(q_hi, lk);
        let rl = b.load_local(r_lo, lk);
        let rh = b.load_local(r_hi, lk);
        let top = b.binop_imm(BinOp::Shru, nh, 63);
        let rem = Self::int128_shift_const(b, BinOp::Shl, (rl, rh), 1);
        let rem = (b.binop(BinOp::Or, rem.0, top), rem.1);
        let num = Self::int128_shift_const(b, BinOp::Shl, (nl, nh), 1);
        let fits = Self::int128_cmp(b, BinOp::Uge, rem, c);
        let mask = {
            let zero = b.imm(0);
            b.binop(BinOp::Sub, zero, fits)
        };
        let sub = (
            b.binop(BinOp::And, c.0, mask),
            b.binop(BinOp::And, c.1, mask),
        );
        let rem = Self::int128_sub(b, rem, sub);
        let num_lo = b.binop(BinOp::Or, num.0, fits);
        b.store_local(q_lo, num_lo, sk);
        b.store_local(q_hi, num.1, sk);
        b.store_local(r_lo, rem.0, sk);
        b.store_local(r_hi, rem.1, sk);
        let next = b.binop_imm(BinOp::Sub, i, 1);
        b.store_local(counter, next, sk);
        b.jmp(head_blk);

        b.switch_to(done_blk);
        let q = (b.load_local(q_lo, lk), b.load_local(q_hi, lk));
        let r = (b.load_local(r_lo, lk), b.load_local(r_hi, lk));
        (q, r)
    }

    /// Signed 128-bit divide, returning `(quotient, remainder)`.
    /// Divides the magnitudes and restores the signs: the quotient is
    /// negative when the operand signs differ and the remainder takes
    /// the dividend's sign (C99 6.5.5p6, truncation toward zero).
    fn int128_sdivmod(&mut self, b: &mut SsaBuilder, a: Halves, c: Halves) -> (Halves, Halves) {
        let sa = b.binop_imm(BinOp::Shr, a.1, 63);
        let sc = b.binop_imm(BinOp::Shr, c.1, 63);
        let ua = Self::int128_xor_sub(b, a, sa);
        let uc = Self::int128_xor_sub(b, c, sc);
        let (q, r) = self.int128_udivmod(b, ua, uc);
        let qs = b.binop(BinOp::Xor, sa, sc);
        let q = Self::int128_xor_sub(b, q, qs);
        let r = Self::int128_xor_sub(b, r, sa);
        (q, r)
    }

    /// 128-bit comparison, yielding 0/1. Equality folds the XOR of
    /// both halves; orderings decide on the high half and fall back to
    /// the unsigned low half on a tie (C99 6.5.8). The high-half
    /// compare is signed or unsigned per `op`.
    fn int128_cmp(b: &mut SsaBuilder, op: BinOp, a: Halves, c: Halves) -> ValueId {
        match op {
            BinOp::Eq | BinOp::Ne => {
                let xl = b.binop(BinOp::Xor, a.0, c.0);
                let xh = b.binop(BinOp::Xor, a.1, c.1);
                let x = b.binop(BinOp::Or, xl, xh);
                b.binop_imm(op, x, 0)
            }
            _ => {
                // Reduce to `<`: swap operands for Gt/Ugt, invert the
                // result for Ge/Le (a <= b iff !(b < a)).
                let (x, y, invert, hi_op) = match op {
                    BinOp::Lt => (a, c, false, BinOp::Lt),
                    BinOp::Gt => (c, a, false, BinOp::Lt),
                    BinOp::Ge => (a, c, true, BinOp::Lt),
                    BinOp::Le => (c, a, true, BinOp::Lt),
                    BinOp::Ult => (a, c, false, BinOp::Ult),
                    BinOp::Ugt => (c, a, false, BinOp::Ult),
                    BinOp::Uge => (a, c, true, BinOp::Ult),
                    _ => (c, a, true, BinOp::Ult), // Ule
                };
                let hi_lt = b.binop(hi_op, x.1, y.1);
                let hi_eq = b.binop(BinOp::Eq, x.1, y.1);
                let lo_lt = b.binop(BinOp::Ult, x.0, y.0);
                let tie = b.binop(BinOp::And, hi_eq, lo_lt);
                let lt = b.binop(BinOp::Or, hi_lt, tie);
                if invert {
                    b.binop_imm(BinOp::Xor, lt, 1)
                } else {
                    lt
                }
            }
        }
    }

    /// True when the expression's *value* is a 128-bit integer.
    fn expr_is_int128_value(&self, id: ExprId) -> bool {
        expr_ty(self.ast.expr(id)).is_some_and(|t| self.is_int128_value_ty(t))
    }

    /// True when either operand of a binary node is a 128-bit value, so
    /// the node lowers through [`Self::walk_int128_binary`].
    fn is_int128_binary(&self, lhs: ExprId, rhs: ExprId) -> bool {
        self.expr_is_int128_value(lhs) || self.expr_is_int128_value(rhs)
    }

    /// Lower `Expr::Binary` with a 128-bit operand. Comparisons yield a
    /// scalar 0/1; every other operator yields the address of a fresh
    /// 16-byte result object, matching how a struct rvalue is produced.
    /// The shift count stays scalar (C99 6.5.7 applies the integer
    /// promotions to each operand separately, not the usual arithmetic
    /// conversions across them); an int128-typed count contributes its
    /// low half.
    fn walk_int128_binary(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        match op {
            BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge => {
                let a = self.int128_operand(b, lhs)?;
                let c = self.int128_operand(b, rhs)?;
                Ok(Self::int128_cmp(b, op, a, c))
            }
            _ => {
                let a = self.int128_operand(b, lhs)?;
                let pair = self.int128_binary_pair(b, op, a, lhs, rhs)?;
                Ok(self.int128_materialize(b, pair))
            }
        }
    }

    /// Apply a value-producing 128-bit operator to an already-loaded
    /// left operand. Shared by `Expr::Binary` and the compound
    /// assignment, which differ only in where the left operand and the
    /// result live. `lhs` is carried for diagnostics only.
    fn int128_binary_pair(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        a: Halves,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<Halves, WalkError> {
        match op {
            BinOp::Shl | BinOp::Shr | BinOp::Shru => {
                let cnt = self.int128_shift_count(b, rhs)?;
                Ok(match b.peek_imm(cnt) {
                    Some(k) => Self::int128_shift_const(b, op, a, k),
                    None => Self::int128_shift(b, op, a, cnt),
                })
            }
            BinOp::Add | BinOp::Sub => {
                let c = self.int128_operand(b, rhs)?;
                Ok(if matches!(op, BinOp::Add) {
                    Self::int128_add(b, a, c)
                } else {
                    Self::int128_sub(b, a, c)
                })
            }
            BinOp::And | BinOp::Or | BinOp::Xor => {
                let c = self.int128_operand(b, rhs)?;
                let lo = b.binop(op, a.0, c.0);
                let hi = b.binop(op, a.1, c.1);
                Ok((lo, hi))
            }
            BinOp::Mul => {
                // The parser spells unary minus as `x * -1`; negation
                // is three ops where the full product is seventeen.
                if let Expr::IntLit { val: -1, .. } = self.ast.expr(rhs) {
                    return Ok(Self::int128_neg(b, a));
                }
                let c = self.int128_operand(b, rhs)?;
                Ok(Self::int128_mul(b, a, c))
            }
            BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu => {
                let c = self.int128_operand(b, rhs)?;
                let (q, r) = if matches!(op, BinOp::Div | BinOp::Mod) {
                    self.int128_sdivmod(b, a, c)
                } else {
                    self.int128_udivmod(b, a, c)
                };
                Ok(if matches!(op, BinOp::Div | BinOp::Divu) {
                    q
                } else {
                    r
                })
            }
            _ => Err(WalkError::UnsupportedExpr {
                id: lhs,
                kind: "128-bit operator",
            }),
        }
    }

    /// Lower `++E` / `--E` (and their postfix forms) on a 128-bit
    /// object. `by` carries the direction's sign, so both spellings are
    /// one 128-bit add. C99 6.5.2.4p2 / 6.5.3.1p2: the postfix form's
    /// value is the object's prior value, which is copied out before the
    /// update since a 128-bit value is carried as an address.
    fn walk_int128_inc(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        by: i64,
        postfix: bool,
    ) -> Result<ValueId, WalkError> {
        let addr = self.walk_expr_lvalue(b, lvalue)?;
        let old = self.int128_load(b, addr);
        let saved = postfix.then(|| self.int128_materialize(b, old));
        let step = {
            let lo = b.imm(by);
            (lo, b.imm(by >> 63))
        };
        let new = Self::int128_add(b, old, step);
        self.int128_store(b, addr, new);
        Ok(saved.unwrap_or(addr))
    }

    /// Lower `E1 op= E2` where `E1` is a 128-bit object: evaluate the
    /// lvalue once (C99 6.5.16.2p3), apply the operator to its value,
    /// and store back. The expression's value is the object's address,
    /// the same shape a 128-bit rvalue takes everywhere else.
    fn walk_int128_compound_assign(
        &mut self,
        b: &mut SsaBuilder,
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
    ) -> Result<ValueId, WalkError> {
        let addr = self.walk_expr_lvalue(b, lhs)?;
        let a = self.int128_load(b, addr);
        let pair = self.int128_binary_pair(b, op, a, lhs, rhs)?;
        self.int128_store(b, addr, pair);
        Ok(addr)
    }

    /// Shift count for a 128-bit shift: a scalar rvalue, or the low
    /// half of an int128-typed count.
    fn int128_shift_count(&mut self, b: &mut SsaBuilder, id: ExprId) -> Result<ValueId, WalkError> {
        let is128 = self.expr_is_int128_value(id);
        let v = self.walk_expr_rvalue(b, id)?;
        if is128 {
            return Ok(b.load(v, LoadKind::I64));
        }
        Ok(v)
    }

    /// Walk a statement. Returns `true` when the statement
    /// terminates the current block (an unconditional return /
    /// jmp), letting the caller stop iterating siblings that
    /// would otherwise emit dead code.
    fn walk_stmt(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
                // C99 6.8.6.4 / 6.3.1.1: the return value is converted to the
                // function's return type. A body evaluated in 64-bit registers
                // can leave bits above the type width set -- a signed constant
                // or arithmetic sign-extends past bit 31, an unsigned source
                // zero-extends -- so a char/short/int (and LLP64 long) return
                // is narrowed to its declared width: zero-extend when unsigned,
                // sign-extend when signed. Same-unit callers read the result
                // register directly and do not re-narrow. `_Bool` is excluded:
                // 6.3.1.2 already normalized it to 0/1.
                let stripped = self.scalar_return_ty & !(UNSIGNED_BIT | VOLATILE_BIT);
                let rs = type_size_bytes(self.scalar_return_ty, self.target);
                if !is_floating_scalar(self.scalar_return_ty)
                    && !is_pointer_ty(self.scalar_return_ty)
                    && stripped != Ty::Bool as i64
                    && (rs == 1 || rs == 2 || rs == 4)
                {
                    let unsigned = (self.scalar_return_ty & UNSIGNED_BIT) != 0;
                    let bits = 64i64 - (rs as i64) * 8;
                    let mask: i64 = match rs {
                        1 => 0xff,
                        2 => 0xffff,
                        _ => 0xffff_ffff,
                    };
                    if let Some(k) = b.peek_imm(v) {
                        // A constant is its own narrowing: fold it, and leave
                        // the value untouched when it already fits the type.
                        let narrowed = if unsigned {
                            k & mask
                        } else {
                            (k << bits) >> bits
                        };
                        if narrowed != k {
                            v = b.imm(narrowed);
                        }
                    } else if unsigned {
                        v = b.binop_imm(BinOp::And, v, mask);
                    } else {
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
                let e = *e;
                let _ = self.walk_expr_rvalue(b, e)?;
                // A direct call to a `noreturn` function ends the
                // block: the statements after it are unreachable
                // (C11 6.7.4p8) and the unreachable-block prune
                // drops them, so a dead tail's calls never reach
                // the object. Seal with `Unreachable` (not a return),
                // so the block is not counted as a return path -- a
                // guard like `if (x) noreturn_fn(); return v;` stays a
                // single-return, inlinable function.
                if let Expr::Call { callee, .. } = self.ast.expr(e)
                    && let Expr::Ident { sym, .. } = self.ast.expr(*callee)
                    && self
                        .symbols
                        .get(*sym as usize)
                        .is_some_and(|s| s.is_noreturn)
                {
                    b.unreachable();
                    return Ok(true);
                }
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
                // A constant controlling expression selects one branch
                // at translation time (C99 6.8.4.1); emit only that
                // branch so the dead branch's side effects and
                // undefined-symbol references are never emitted. Skip
                // the fold when the dead branch defines a label a goto
                // or switch could target -- dropping its block would
                // leave the jump unresolved. Matches gcc's front-end
                // fold at -O0.
                if let Some(c) = self.const_fold_int(*cond) {
                    let dead = if c != 0 { *else_s } else { Some(*then_s) };
                    if !dead.is_some_and(|s| self.stmt_defines_label(s)) {
                        if c != 0 {
                            return self.walk_stmt(b, *then_s);
                        }
                        return match *else_s {
                            Some(else_id) => self.walk_stmt(b, else_id),
                            None => Ok(false),
                        };
                    }
                }
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
            Stmt::AsmGoto(idx) => {
                // GCC `asm goto`: evaluate the inputs, then close the
                // block with `Terminator::AsmGoto`. Row entry 0 is the
                // fall-through successor; the label-block targets
                // follow in label-list order, sharing the C-label
                // machinery with `goto` (forward references included).
                let asm = self.ast.asm_blocks[*idx as usize].clone();
                let mut args: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(asm.operand_exprs.len());
                for &e in &asm.operand_exprs {
                    args.push(self.walk_expr_rvalue(b, e)?);
                }
                let fall = b.new_block();
                let mut targets = alloc::vec::Vec::with_capacity(1 + asm.labels.len());
                targets.push(fall);
                for &l in &asm.labels {
                    targets.push(self.block_for_label(b, l));
                }
                b.asm_goto(alloc::boxed::Box::new(asm.block), args, targets);
                b.switch_to(fall);
                Ok(false)
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
                let mut ranges: alloc::vec::Vec<(i64, i64, super::super::ir::BlockId)> =
                    alloc::vec::Vec::new();
                let mut default_blk: Option<super::super::ir::BlockId> = None;
                self.collect_switch_cases(b, body_id, &mut cases, &mut ranges, &mut default_blk);

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
                    // Signed controlling type: a 4-byte type promotes to
                    // itself and a sub-int type to signed `int`, so the
                    // label converts by sign-truncation to 32 bits --
                    // `case 0x80000000:` on an `int` switch must match
                    // the sign-extended INT_MIN discriminant. An 8-byte
                    // type keeps the full-width label.
                    if type_size_bytes(disc_ty, self.target) <= 4 {
                        for c in sorted.iter_mut() {
                            c.0 = (c.0 as i32) as i64;
                        }
                    }
                    sorted.sort_by_key(|p| p.0);
                }
                // Range cases (`case lo ... hi`): each is dispatched by an
                // explicit `lo <= disc <= hi` test before the single-value
                // search, so a wide range needs no per-value expansion. The
                // bounds convert to the promoted type exactly like the
                // single-value labels above.
                let (ge_op, le_op) = if disc_unsigned {
                    (BinOp::Uge, BinOp::Ule)
                } else {
                    (BinOp::Ge, BinOp::Le)
                };
                let disc_bytes = type_size_bytes(disc_ty, self.target);
                for &(mut lo, mut hi, blk) in &ranges {
                    if disc_unsigned {
                        if disc_bytes == 4 {
                            lo = (lo as u32) as i64;
                            hi = (hi as u32) as i64;
                        }
                    } else if disc_bytes <= 4 {
                        lo = (lo as i32) as i64;
                        hi = (hi as i32) as i64;
                    }
                    let ge_lo = b.binop_imm(ge_op, disc_val, lo);
                    let hi_chk = b.new_block();
                    let next = b.new_block();
                    b.branch_nonzero(ge_lo, hi_chk, next);
                    b.switch_to(hi_chk);
                    let le_hi = b.binop_imm(le_op, disc_val, hi);
                    b.branch_nonzero(le_hi, blk, next);
                    b.switch_to(next);
                }
                let lt_op = if disc_unsigned { BinOp::Ult } else { BinOp::Lt };
                if !self.emit_switch_table(b, disc_val, &sorted, deflt) {
                    self.emit_switch_search(b, disc_val, &sorted, lt_op, deflt);
                }

                // Walk the body linearly. The opening block is reachable
                // only by a goto into the switch ahead of the first case
                // (C99 6.8.1); the dispatcher never targets it.
                let fallin = b.new_block();
                b.switch_to(fallin);

                // `break` leaves the switch; `continue` is invalid in a
                // bare switch, so propagate the enclosing loop's target.
                let prev_continue = self.loop_ctx.last().map(|&(_, c)| c).unwrap_or(after_blk);
                self.loop_ctx.push((after_blk, prev_continue));
                self.switch_dispatch.push((cases, ranges, default_blk));
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
            Stmt::Case { val, body, .. } => {
                let val = *val;
                let body_id = *body;
                let blk = self.switch_dispatch.last().and_then(|d| {
                    d.0.iter()
                        .find(|(v, _)| *v == val)
                        .map(|&(_, b)| b)
                        .or_else(|| d.1.iter().find(|(lo, _, _)| *lo == val).map(|&(_, _, b)| b))
                });
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
                let blk = self.switch_dispatch.last().and_then(|d| d.2);
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
            // C99 6.2.4p2: snapshot the stack pointer on entry to a
            // VLA-declaring block, restore it on exit so the storage is
            // reclaimed (per loop iteration for a loop body).
            Stmt::VlaScopeEnter { save_slot } => {
                let slot = *save_slot;
                let top = b.intrinsic(
                    super::super::op::Intrinsic::AllocaSave as i64,
                    alloc::vec::Vec::new(),
                );
                b.store_local(slot, top, super::super::ir::StoreKind::I64);
                Ok(false)
            }
            Stmt::VlaScopeExit { save_slot } => {
                let saved = b.load_local(*save_slot, super::super::ir::LoadKind::I64);
                b.intrinsic(
                    super::super::op::Intrinsic::AllocaRestore as i64,
                    alloc::vec![saved],
                );
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
            super::super::ast::Decl::Vla {
                elem_size,
                ptr_slot,
                size_slot,
                dim,
                ..
            } => {
                // C99 6.7.6.2: allocate `count * sizeof(elem)` bytes
                // from the stack via the alloca intrinsic, store the
                // base pointer for decay and the byte count for `sizeof`.
                let elem_size = *elem_size;
                let ptr_slot = *ptr_slot;
                let size_slot = *size_slot;
                let dim = *dim;
                let n = self.walk_expr_rvalue(b, dim)?;
                let bytes = if elem_size == 1 {
                    n
                } else {
                    b.binop_imm(BinOp::Mul, n, elem_size)
                };
                b.store_local(size_slot, bytes, super::super::ir::StoreKind::I64);
                let ptr = b.intrinsic(
                    super::super::op::Intrinsic::Alloca as i64,
                    alloc::vec![bytes],
                );
                b.store_local(ptr_slot, ptr, super::super::ir::StoreKind::I64);
                Ok(())
            }
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
    /// Store a scalar `v` of type `src_ty` into the 16-byte `__int128`
    /// object at `dst_addr`: the source, converted to 64 bits, fills the
    /// low half and its sign fills the high half (C99 6.3.1.3/6.3.1.8
    /// widening). Shared by the cast, initializer, and assignment paths,
    /// which otherwise treat the scalar as a struct-rvalue address and
    /// copy 16 bytes from it.
    fn store_scalar_as_int128(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        dst_addr: super::super::ir::ValueId,
        v: super::super::ir::ValueId,
        src_ty: i64,
    ) {
        let low_ty = Ty::LongLong as i64 | (src_ty & UNSIGNED_BIT);
        let low = self.convert_scalar_value(b, v, src_ty, low_ty);
        let store_kind = store_kind_for(low_ty, self.target);
        b.store(dst_addr, low, store_kind);
        let zero_extend = (src_ty & UNSIGNED_BIT) != 0 || is_pointer_ty(src_ty);
        let high = if zero_extend {
            b.imm(0)
        } else {
            b.binop_imm(BinOp::Shr, low, 63)
        };
        let hi_addr = b.binop_imm(BinOp::Add, dst_addr, 8);
        b.store(hi_addr, high, store_kind);
    }

    fn emit_local_init(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        slot: i64,
        ty: i64,
        init: &super::super::ast::LocalInit,
    ) -> Result<(), WalkError> {
        match init {
            super::super::ast::LocalInit::None => Ok(()),
            super::super::ast::LocalInit::Scalar(init_id) => {
                let v = self.walk_expr_rvalue(b, *init_id)?;
                // C99 6.7.8p13 struct-value initializer: copy the source's
                // bytes into the slot via Mcpy. `v` is the source address
                // (the walker's address-as-value routing for struct
                // rvalues). A scalar source of a 128-bit `__int128` slot is
                // widened into it instead -- `v` is then a value, not an
                // address, so an Mcpy from it would fault.
                if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                    let dst = b.local_addr(slot);
                    let src_ty = expr_ty(self.ast.expr(*init_id)).unwrap_or(ty);
                    if self.is_int128_value_ty(ty) && !is_struct_ty(src_ty) {
                        self.store_scalar_as_int128(b, dst, v, src_ty);
                        return Ok(());
                    }
                    let size = self.struct_size(ty);
                    b.mcpy(dst, v, size);
                    return Ok(());
                }
                let kind = store_kind_for(ty, self.target);
                // A direct `StoreLocal` keeps the slot mem2reg-promotable.
                // The `F32` s-view store is narrowed by the per-arch emit
                // when the value is still double.
                b.store_local_vol(slot, v, kind, is_volatile_ty(ty));
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
                    // A bitfield member: read-modify-write the storage unit
                    // rather than a full-width store, so adjacent bitfields
                    // in the same unit are preserved (the slot was
                    // zero-seeded, so the field's own bits start clear).
                    if let Some(bf) = elem.bitfield {
                        self.store_into_bitfield(b, addr, bf, v, is_volatile_ty(elem.ty));
                        continue;
                    }
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
                    b.store_vol(addr, v, kind, is_volatile_ty(elem.ty));
                }
                Ok(())
            }
        }
    }

    /// Store `value`'s low `bf.bit_width` bits into the bitfield at
    /// `addr` (C99 6.7.2.1): load the storage unit, clear the field's
    /// slice, shift + mask the value into place, OR, and store back.
    fn store_into_bitfield(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        addr: super::super::ir::ValueId,
        bf: super::super::ast::BitfieldDesc,
        value: super::super::ir::ValueId,
        vol: bool,
    ) {
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
        let masked = b.binop_imm(BinOp::And, value, mask);
        let old = b.load_vol(addr, load_kind, vol);
        let cleared = b.binop_imm(BinOp::And, old, clear_mask);
        let shifted = if bf.bit_offset > 0 {
            b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
        } else {
            masked
        };
        let combined = b.binop(BinOp::Or, cleared, shifted);
        b.store_vol(addr, combined, store_kind, vol);
    }

    /// Allocate or reuse the SSA block reserved for the given AST
    /// label id. Goto's forward reference and the matching Labeled
    /// stmt both look up through this so they share the same block.
    fn block_for_label(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        label: super::super::ast::LabelId,
    ) -> super::super::ir::BlockId {
        if let Some(&(_, blk)) = self.label_blocks.iter().find(|(l, _)| *l == label) {
            return blk;
        }
        let blk = b.new_block();
        self.label_blocks.push((label, blk));
        blk
    }

    /// Emit a jump-table dispatcher for a dense case list: a bias
    /// subtract, an unsigned bounds check branching to `deflt`, and a
    /// `Terminator::JumpTable` indexed by the biased discriminant.
    /// Returns false (leaving the cursor untouched) when the case set
    /// is too small or too sparse; the caller falls back to the
    /// compare tree. `cases` is sorted with values already converted
    /// to the promoted controlling type, so consecutive entries differ
    /// by their true unsigned distance regardless of signedness.
    fn emit_switch_table(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        disc: super::super::ir::ValueId,
        cases: &[(i64, super::super::ir::BlockId)],
        deflt: super::super::ir::BlockId,
    ) -> bool {
        const MIN_CASES: usize = 8;
        if cases.len() < MIN_CASES {
            return false;
        }
        let lo = cases[0].0;
        let hi = cases[cases.len() - 1].0;
        // Exact unsigned span; wrapping covers the full i64 label
        // domain (hi >= lo in the sort order, so the difference is
        // < 2^64 and the wrapped subtraction is exact).
        let span = (hi as u64).wrapping_sub(lo as u64);
        // Density gate: at least half the table slots hold a real
        // case. The bound also caps the table at 2 * cases entries.
        if span >= 2 * cases.len() as u64 {
            return false;
        }
        let mut targets = alloc::vec![deflt; span as usize + 1];
        for &(v, blk) in cases {
            let slot = &mut targets[(v as u64).wrapping_sub(lo as u64) as usize];
            // First case wins on a converted-value collision, matching
            // the compare tree's first-match order.
            if *slot == deflt {
                *slot = blk;
            }
        }
        // idx = disc - lo; the wrapped 64-bit subtraction with the
        // unsigned bound accepts exactly disc in [lo, hi] for every
        // promoted width (the discriminant is already sign- or
        // zero-extended to the same domain as the labels).
        let idx = if lo != 0 {
            b.binop_imm(BinOp::Sub, disc, lo)
        } else {
            disc
        };
        let inb = b.binop_imm(BinOp::Ult, idx, span as i64 + 1);
        let dispatch = b.new_block();
        b.branch_zero(inb, deflt, dispatch);
        b.switch_to(dispatch);
        b.jump_table(idx, targets);
        true
    }

    /// Emit a balanced binary search over a sorted, distinct case list
    /// as the switch dispatcher. The cursor is at an open block on entry
    /// and the block is closed on return. Internal nodes branch on
    /// `lt_op` (`<`); a leaf tests equality and falls to `deflt` when the
    /// discriminant matches no case.
    fn emit_switch_search(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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

    /// Reserve a block for every `case` value and for `default` in a
    /// switch body, descending into nested statements but not into a
    /// nested switch (whose labels belong to it, C99 6.8.4.2). A
    /// duplicate case value keeps the first block; the parser already
    /// rejects duplicates.
    #[allow(clippy::type_complexity)]
    fn collect_switch_cases(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        stmt_id: super::super::ast::StmtId,
        cases: &mut alloc::vec::Vec<(i64, super::super::ir::BlockId)>,
        ranges: &mut alloc::vec::Vec<(i64, i64, super::super::ir::BlockId)>,
        default_blk: &mut Option<super::super::ir::BlockId>,
    ) {
        match self.ast.stmt(stmt_id) {
            Stmt::Case { val, hi, body } => {
                let val = *val;
                let hi = *hi;
                let body = *body;
                // Both a single `case v` and a range `case lo ... hi` reserve
                // one block; the body walker looks it up by `lo`. A single
                // value joins the sorted-dispatch list; a range is dispatched
                // by an explicit `lo <= disc <= hi` comparison so a wide range
                // (register-decode switches span millions of values) needs no
                // per-value expansion.
                let blk = b.new_block();
                if val == hi {
                    if !cases.iter().any(|(cv, _)| *cv == val) {
                        cases.push((val, blk));
                    }
                } else {
                    ranges.push((val, hi, blk));
                }
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            Stmt::Default { body } => {
                let body = *body;
                if default_blk.is_none() {
                    *default_blk = Some(b.new_block());
                }
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            Stmt::Compound(items) => {
                let items = items.clone();
                for item in items {
                    if let super::BlockItem::Stmt(s) = item {
                        self.collect_switch_cases(b, s, cases, ranges, default_blk);
                    }
                }
            }
            Stmt::If { then_s, else_s, .. } => {
                let then_s = *then_s;
                let else_s = *else_s;
                self.collect_switch_cases(b, then_s, cases, ranges, default_blk);
                if let Some(e) = else_s {
                    self.collect_switch_cases(b, e, cases, ranges, default_blk);
                }
            }
            Stmt::While { body, .. }
            | Stmt::DoWhile { body, .. }
            | Stmt::For { body, .. }
            | Stmt::Labeled { body, .. } => {
                let body = *body;
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            // A nested switch owns its own case labels; every other
            // statement carries none.
            _ => {}
        }
    }

    /// Lower a GCC `__builtin_{add,sub,mul}_overflow(a, b, dst)`. Stores
    /// the wrapped `a op b` through `dst` (pointee `elem_ty`) and yields
    /// the overflow flag (0 / 1). For widths under 8 bytes the operands
    /// are already extended in the 64-bit register, so `a op b` is exact
    /// and overflow is exactly the case where truncation changes it; the
    /// 64-bit case uses the carry / sign-overflow formulas, with a
    /// guarded division for the multiply.
    fn walk_checked_arith(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        op: i64,
        a_expr: ExprId,
        b_expr: ExprId,
        dst_expr: ExprId,
        elem_ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let store_kind = store_kind_for(elem_ty, self.target);
        let w = type_size_bytes(elem_ty, self.target);
        // The wrapped-value and overflow-flag formulas below operate on a
        // 1/2/4/8-byte scalar in a 64-bit register; a wider or aggregate
        // operand (a 128-bit `__int128`, sized 0 here) has no such form and
        // would yield a wrong flag / value. Reject it. TODO: 128-bit.
        if !matches!(w, 1 | 2 | 4 | 8) {
            return Err(WalkError::UnsupportedExpr {
                id: dst_expr,
                kind: "__builtin_*_overflow requires a 1/2/4/8-byte scalar type",
            });
        }
        let unsigned = (elem_ty & UNSIGNED_BIT) != 0;
        let bin = match op {
            0 => BinOp::Add,
            1 => BinOp::Sub,
            _ => BinOp::Mul,
        };
        let va = self.walk_expr_rvalue(b, a_expr)?;
        let vb = self.walk_expr_rvalue(b, b_expr)?;
        let addr = self.walk_expr_rvalue(b, dst_expr)?;

        if w < 8 {
            let raw = b.binop(bin, va, vb);
            let wrapped = self.extend_atomic_result(b, raw, elem_ty);
            b.store(addr, wrapped, store_kind);
            return Ok(b.binop(BinOp::Ne, raw, wrapped));
        }

        let wrapped = b.binop(bin, va, vb);
        b.store(addr, wrapped, store_kind);
        let flag = match (op, unsigned) {
            // Unsigned add carries out iff the sum is below an addend.
            (0, true) => b.binop(BinOp::Ult, wrapped, va),
            // Signed add overflows iff both addends share a sign that the
            // sum does not: `(a ^ s) & (b ^ s)` has its sign bit set.
            (0, false) => {
                let ax = b.binop(BinOp::Xor, va, wrapped);
                let bx = b.binop(BinOp::Xor, vb, wrapped);
                let m = b.binop(BinOp::And, ax, bx);
                let zero = b.imm(0);
                b.binop(BinOp::Lt, m, zero)
            }
            // Unsigned subtract borrows iff the minuend is the smaller.
            (1, true) => b.binop(BinOp::Ult, va, vb),
            // Signed subtract overflows iff the operands differ in sign
            // and the result's sign differs from the minuend's.
            (1, false) => {
                let ab = b.binop(BinOp::Xor, va, vb);
                let aw = b.binop(BinOp::Xor, va, wrapped);
                let m = b.binop(BinOp::And, ab, aw);
                let zero = b.imm(0);
                b.binop(BinOp::Lt, m, zero)
            }
            // Unsigned multiply overflows iff `a != 0 && product/a != b`.
            // The divisor is forced non-zero so the unused `a == 0` lane
            // does not divide by zero.
            (_, true) => {
                let zero = b.imm(0);
                let iszero = b.binop(BinOp::Eq, va, zero);
                let safe = b.binop(BinOp::Or, va, iszero);
                let q = b.binop(BinOp::Divu, wrapped, safe);
                let a_nz = b.binop(BinOp::Ne, va, zero);
                let mism = b.binop(BinOp::Ne, q, vb);
                b.binop(BinOp::And, a_nz, mism)
            }
            // Signed multiply: same division test, but the divisor is
            // forced to 1 for `a == 0` and `a == -1` so the `INT_MIN / -1`
            // trap is avoided; the `a == -1` overflow is `product == INT_MIN`.
            (_, false) => {
                let zero = b.imm(0);
                let neg1 = b.imm(-1);
                let one = b.imm(1);
                let iszero = b.binop(BinOp::Eq, va, zero);
                let isneg1 = b.binop(BinOp::Eq, va, neg1);
                let special = b.binop(BinOp::Or, iszero, isneg1);
                let not_special = b.binop(BinOp::Xor, special, one);
                let scaled = b.binop(BinOp::Mul, va, not_special);
                let safe = b.binop(BinOp::Add, scaled, special);
                let q = b.binop(BinOp::Div, wrapped, safe);
                let mism = b.binop(BinOp::Ne, q, vb);
                let normal = b.binop(BinOp::And, not_special, mism);
                let intmin = b.imm(i64::MIN);
                let is_intmin = b.binop(BinOp::Eq, wrapped, intmin);
                let neg1_ovf = b.binop(BinOp::And, isneg1, is_intmin);
                b.binop(BinOp::Or, normal, neg1_ovf)
            }
        };
        Ok(flag)
    }

    /// Lower a GCC statement expression `({ ... })`. Walks the
    /// block items exactly as `Stmt::Compound` does -- new-block on
    /// a closed predecessor, decls through `walk_decl` -- but keeps
    /// the value of the last expression-statement (GCC: the value
    /// of the whole construct). `block` is the enclosed compound,
    /// or the bare statement for a single-item block. Falls back to
    /// an immediate 0 when no expression-statement is present.
    fn walk_stmt_expr(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        block: StmtId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let items: alloc::vec::Vec<super::BlockItem> = match self.ast.stmt(block) {
            Stmt::Compound(items) => items.clone(),
            _ => alloc::vec![super::BlockItem::Stmt(block)],
        };
        let mut result: Option<super::super::ir::ValueId> = None;
        for item in items {
            if !b.is_block_open() {
                let dead = b.new_block();
                b.switch_to(dead);
            }
            match item {
                super::BlockItem::Stmt(s) => {
                    if let Stmt::Expr(e) = self.ast.stmt(s) {
                        let e = *e;
                        result = Some(self.walk_expr_rvalue(b, e)?);
                    } else {
                        let _ = self.walk_stmt(b, s)?;
                    }
                }
                super::BlockItem::Decl(d) => {
                    self.walk_decl(b, d)?;
                }
            }
        }
        match result {
            Some(v) => Ok(v),
            None => Ok(b.imm(0)),
        }
    }

    /// Walk an expression in rvalue position. Returns the
    /// `ValueId` whose runtime value is the C99 6.5p1 evaluation
    /// of the expression.
    fn walk_expr_rvalue(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
                    return Ok(b.imm_f32(f32_bits.to_bits()));
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
            } => self.load_ident_rvalue(
                b,
                id,
                *sym,
                *ty,
                *class,
                *val,
                *is_thread_local,
                *array_size,
            ),
            Expr::Unary { op, child, ty } => self.walk_unary(b, *op, *child, *ty),
            Expr::Binary { op, lhs, rhs, ty } => {
                // GCC vector extension: a bitwise operator on same-width vector
                // values is element-wise. The parser only tags a Binary node
                // with a vector type for `^`/`&`/`|`; lower it as wide chunks
                // into a result temporary (no inter-lane carry for bitwise ops).
                if is_vector_ty(self.structs, *ty) {
                    return self.walk_vector_bitwise(b, *op, *lhs, *rhs, *ty);
                }
                // A 128-bit operand makes the node a 128-bit operation,
                // whatever the node's own type: a comparison's result is
                // `int`, and the parser spells the unary operators as a
                // binop against a literal.
                if self.is_int128_binary(*lhs, *rhs) {
                    return self.walk_int128_binary(b, *op, *lhs, *rhs);
                }
                // A comparison whose operand is a floating-point value must
                // use the FP comparison. The parser tags the op from the
                // operand types; when that tracking is clouded by the
                // surrounding expression it can emit the integer variant
                // against an operand that lowers to an FP register, which
                // the integer paths cannot compare. Re-derive the op from
                // the operand types so the FP path below handles it.
                let op_remapped = {
                    // An operand's value is floating-point when its node
                    // carries a floating type tag -- except a comparison,
                    // whose result is `int` even though its node may carry
                    // the operand type. Treat a comparison operand as int.
                    let operand_is_fp = |id: ExprId| -> bool {
                        let e = self.ast.expr(id);
                        if let Expr::Binary { op, .. } = e
                            && is_comparison_op(*op)
                        {
                            return false;
                        }
                        expr_ty(e).is_some_and(is_floating_scalar)
                    };
                    let lhs_fp = operand_is_fp(*lhs);
                    let rhs_fp = operand_is_fp(*rhs);
                    if lhs_fp || rhs_fp {
                        match *op {
                            BinOp::Eq => BinOp::Feq,
                            BinOp::Ne => BinOp::Fne,
                            BinOp::Lt => BinOp::Flt,
                            BinOp::Gt => BinOp::Fgt,
                            BinOp::Le => BinOp::Fle,
                            BinOp::Ge => BinOp::Fge,
                            other => other,
                        }
                    } else {
                        *op
                    }
                };
                let op = &op_remapped;
                let mask = unsigned_narrow_mask(*ty);
                let needs_divmod_mask = mask != 0 && matches!(*op, BinOp::Divu | BinOp::Modu);
                // An unsigned relational compare at a common type narrower
                // than the register where one operand is signed: the signed
                // operand carries its sign-extended high bits in the 64-bit
                // register, but C99 6.3.1.8 converts it to the unsigned
                // common type (zero-extended), so those bits must be cleared
                // or the unsigned compare reads a huge value. The common
                // type is unsigned (the front end picked the U-op) and
                // 4-byte unless an operand is 8 bytes, in which case the
                // value already fills the register. Two unsigned operands
                // are already zero-extended and need no mask. Mask both
                // operands to the common width.
                let cmp_mask = if matches!(*op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge) {
                    // An operand carries sign-extended high bits only when it
                    // is signed and not a non-negative literal: an unsigned
                    // operand is zero-extended, and a non-negative constant
                    // has no high bits set. The latter keeps the common
                    // `unsigned < positive-literal` loop test on the
                    // immediate path.
                    let needs = |id: ExprId, this: &Self| -> (bool, usize) {
                        let e = this.ast.expr(id);
                        let ty = expr_ty(e);
                        let sz = ty.map_or(8, |t| type_size_bytes(t, this.target));
                        let signed = ty.is_some_and(|t| t & UNSIGNED_BIT == 0);
                        let nonneg_lit = matches!(e, Expr::IntLit { val, .. } if *val >= 0);
                        (signed && !nonneg_lit, sz)
                    };
                    let (l_needs, lsz) = needs(*lhs, self);
                    let (r_needs, rsz) = needs(*rhs, self);
                    if lsz <= 4 && rsz <= 4 && (l_needs || r_needs) {
                        0xffff_ffffi64
                    } else {
                        0
                    }
                } else {
                    0
                };
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
                let imm_safe_op = imm_safe_binop(*op);
                // Operands that need masking take the register path so the
                // mask below applies; the immediate fast paths skip it.
                let imm_safe_op = imm_safe_op && cmp_mask == 0;
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
                if needs_divmod_mask || cmp_mask != 0 {
                    let m = if needs_divmod_mask { mask } else { cmp_mask };
                    lv = b.binop_imm(BinOp::And, lv, m);
                    rv = b.binop_imm(BinOp::And, rv, m);
                }
                // Strength-reduce divide / modulo by a constant power of
                // two to shifts / masks. This is the only constant-
                // divisor fast path: the per-arch `BinopI` emit does not
                // lower Div / Mod, so they are otherwise excluded from
                // `imm_safe_op` and divide through the register path.
                if let Some(reduced) = b.divmod_pow2(*op, lv, rv) {
                    return Ok(reduced);
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
                ty,
            } => {
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*obj);
                // C99 6.7.2.1: bitfield write -- load the storage
                // unit, clear the destination slice, mask + shift
                // the new value into place, OR the cleared old
                // value with the shifted new, store back. The
                // assignment's own value (for an enclosing expression)
                // is the masked field value, not the storage word.
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
                // Evaluate the RHS before loading the storage unit: a
                // chained assignment whose RHS writes the same unit
                // (adjacent bitfields, `a.x = a.y = v`) must be observed by
                // this read-modify-write, else its store is clobbered.
                let rhs_v = self.walk_expr_rvalue(b, *rhs)?;
                let masked = b.binop_imm(BinOp::And, rhs_v, mask);
                let old = b.load_vol(addr, load_kind, vol);
                let cleared = b.binop_imm(BinOp::And, old, clear_mask);
                let shifted = if bf.bit_offset > 0 {
                    b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
                } else {
                    masked
                };
                let combined = b.binop(BinOp::Or, cleared, shifted);
                b.store_vol(addr, combined, store_kind, vol);
                // C99 6.5.16p3: the value of the assignment is the value
                // stored in the bitfield converted to its declared type --
                // the right-aligned masked field value, sign-extended for a
                // signed field -- not the whole storage word.
                if bf.signed && bf.bit_width < 64 {
                    let shift = 64i64 - (bf.bit_width as i64);
                    let up = b.binop_imm(BinOp::Shl, masked, shift);
                    Ok(b.binop_imm(BinOp::Shr, up, shift))
                } else {
                    Ok(masked)
                }
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
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*lhs);
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
                    b.store_local_vol(slot, value, kind, vol);
                    // C99 6.5.16p3: the assignment expression's value has
                    // the converted type of the left operand. The store
                    // truncated the stored bytes; the value carried
                    // forward to an enclosing expression must also be
                    // narrowed (the F32 case did so above).
                    let rhs_ty = expr_ty(self.ast.expr(*rhs)).unwrap_or(*ty);
                    return Ok(self.narrow_int_to_ty(b, value, rhs_ty, *ty));
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
                b.store_vol(addr, value, kind, vol);
                // C99 6.5.16p3: the assignment expression's value has the
                // converted type of the left operand. The store truncated
                // the stored bytes; the value carried forward to an
                // enclosing expression must also be narrowed (the F32 case
                // did so above). A dead value drops out in DCE.
                let rhs_ty = expr_ty(self.ast.expr(*rhs)).unwrap_or(*ty);
                Ok(self.narrow_int_to_ty(b, value, rhs_ty, *ty))
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ty,
                elvis,
            } => {
                // A constant controlling expression selects one arm at
                // translation time (C99 6.5.15); evaluate only that arm
                // so the dead arm's side effects and undefined-symbol
                // references are never emitted. Ternary arms are
                // expressions, so no label/goto concern applies. The
                // GNU `a ?: b` form keeps its runtime path. Matches
                // gcc's front-end fold at -O0.
                if !*elvis && let Some(c) = self.const_fold_int(*cond) {
                    let live = if c != 0 { *then_e } else { *else_e };
                    let v = self.walk_expr_rvalue(b, live)?;
                    let arm_ty = expr_ty(self.ast.expr(live)).unwrap_or(*ty);
                    return Ok(self.convert_scalar_value(b, v, arm_ty, *ty));
                }
                // C99 6.5.15: evaluate cond; depending on the
                // value, evaluate exactly one of then_e / else_e
                // and the conditional expression's value is that
                // arm's value. Same synthetic-local-slot phi
                // substitute the `ShortCircuit` arm uses -- both
                // arms store the arm result and the merge block
                // loads it. Width is taken from the result type:
                // an FP-typed ternary uses `StoreLocal { kind: F32 }` /
                // `LoadLocal { kind: F32 }` so the codegen routes
                // through the FP register class; everything else
                // stays on the I64 `StoreLocal` / `LoadLocal` fast
                // path the emit lowers in a single `stur` / `ldur`.
                //
                // The GNU `a ?: b` form evaluates the condition once and
                // reuses its value as the then-arm (converted to the result
                // type). The plain form evaluates the condition for its
                // truthiness only and evaluates a separate then-arm.
                let (cond_v, elvis_val) = if *elvis {
                    let v = self.walk_expr_rvalue(b, *cond)?;
                    (self.cond_truthy(b, v, *cond), Some(v))
                } else {
                    (self.walk_cond_value(b, *cond)?, None)
                };
                let then_blk = b.new_block();
                let else_blk = b.new_block();
                let after_blk = b.new_block();
                b.branch_zero(cond_v, else_blk, then_blk);
                let slot = b.alloc_synthetic_local();
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                // An FP-typed result rides the FP register class through
                // the fused `StoreLocal` / `LoadLocal` path: the emit
                // lowers `F32` (`movss` / `str s`, narrowing an f64 arm
                // per C99 6.3.1.5) and `F64` (`movsd` / `ldr d`) each in
                // a single instruction. The fused ops keep the synthetic
                // merge slot mem2reg-promotable, unlike `LocalAddr` +
                // `Store`. Everything else stays on the I64 fast path.
                let is_fp = matches!(
                    load_kind,
                    super::super::ir::LoadKind::F32 | super::super::ir::LoadKind::F64
                );
                let arm_store = |b: &mut super::super::codegen::ssa::build::SsaBuilder, v| {
                    let kind = if is_fp {
                        store_kind
                    } else {
                        super::super::ir::StoreKind::I64
                    };
                    b.store_local(slot, v, kind);
                };
                b.switch_to(then_blk);
                let then_v = if let Some(v) = elvis_val {
                    // Reuse the condition's value, converted from its own
                    // type to the conditional's result type.
                    let cond_ty = expr_ty(self.ast.expr(*cond)).unwrap_or(*ty);
                    self.convert_scalar_value(b, v, cond_ty, *ty)
                } else {
                    self.walk_expr_rvalue(b, *then_e)?
                };
                arm_store(b, then_v);
                b.jmp(after_blk);
                b.switch_to(else_blk);
                let else_v = self.walk_expr_rvalue(b, *else_e)?;
                arm_store(b, else_v);
                b.jmp(after_blk);
                b.switch_to(after_blk);
                let read_kind = if is_fp {
                    load_kind
                } else {
                    super::super::ir::LoadKind::I64
                };
                Ok(b.load_local(slot, read_kind))
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
                        let mut v = self.walk_expr_rvalue(b, *a)?;
                        // The all-integer cdecl carries each argument in an
                        // 8-byte integer slot, where the callee reads a
                        // floating-point parameter as a double. A `double`
                        // already occupies eight bytes; a `float` must be
                        // widened to that pattern and reloaded through an
                        // integer slot, or the marshal moves only its 4-byte
                        // form into the low half and the f64 read sees noise in
                        // the high half.
                        if expr_ty(self.ast.expr(*a)).map(is_float_ty).unwrap_or(false) {
                            let widened = b.fp_widen_to_f64(v);
                            let slot = b.alloc_synthetic_local();
                            b.store_local(slot, widened, super::super::ir::StoreKind::I64);
                            v = b.load_local(slot, super::super::ir::LoadKind::I64);
                        }
                        all_args.push(v);
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
                                // A variadic callee's named aggregate parameter
                                // rides the c5 by-address convention: the callee
                                // reads it from the passed address (its prologue
                                // does not scatter an incoming aggregate
                                // register pair into the parameter local). Host-
                                // ABI by-value placement for a named aggregate
                                // of a variadic callee is not yet lowered on the
                                // register-save variadic ABIs, so keep both ends
                                // on the by-address shape.
                                if callee_variadic && i < self.symbols[*sym as usize].params.len() {
                                    continue;
                                }
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
                            // An external (`target_pc == 0`) callee may per
                            // AAPCS leave a narrow return's high bits
                            // undefined; extend to keep the walker's
                            // sign/zero-extended-to-64-bits invariant. An
                            // intra-TU callee already returns full width.
                            return Ok(if !self.symbols[*sym as usize].defined_here {
                                extend_scalar_call_result(b, call, *ty, self.target)
                            } else {
                                call
                            });
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
                            // An external (`target_pc == 0`) callee may per
                            // AAPCS leave a narrow return's high bits
                            // undefined; extend to keep the walker's
                            // sign/zero-extended-to-64-bits invariant. An
                            // intra-TU callee already returns full width.
                            return Ok(if !self.symbols[*sym as usize].defined_here {
                                extend_scalar_call_result(b, call, *ty, self.target)
                            } else {
                                call
                            });
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
                        // An external (`target_pc == 0`) callee may per
                        // AAPCS leave a narrow return's high bits undefined;
                        // extend to keep the walker's sign/zero-extended-to-
                        // 64-bits invariant. An intra-TU callee already
                        // returns full width.
                        return Ok(if !self.symbols[*sym as usize].defined_here {
                            extend_scalar_call_result(b, call, *ty, self.target)
                        } else {
                            call
                        });
                    }
                    if *class == Token::Sys as i64 {
                        // A returns-twice callee (setjmp family /
                        // vfork) disables spill-slot sharing in this
                        // function; see FunctionSsa::has_returns_twice_call.
                        if crate::c5::ir::returns_twice_fn_name(&self.symbols[*sym as usize].name) {
                            b.mark_returns_twice();
                        }
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
                        // System V AMD64 MEMORY class / Win64 oversize
                        // (StructReturnAbi::OutPtr): the caller allocates the
                        // result buffer and passes its address as the hidden
                        // first integer argument; the callee writes through it
                        // and returns it in rax. Prepend the out-pointer to the
                        // argument vector and shift the FP-arg mask and the
                        // aggregate descriptors one slot to follow it. AArch64
                        // returns this size through x8 (StructReturnAbi::Indirect,
                        // handled by the ret_agg path below).
                        if is_struct_ty(*ty)
                            && struct_ptr_depth(*ty) == 0
                            && matches!(
                                crate::c5::compiler::struct_return_abi(
                                    self.structs,
                                    self.target,
                                    *ty
                                ),
                                crate::c5::compiler::StructReturnAbi::OutPtr
                            )
                        {
                            let result_size = self.struct_size(*ty);
                            let result_slot = b.alloc_synthetic_struct(result_size);
                            // Spill the out-pointer through an int temp so the
                            // codegen routes it via the host integer arg register.
                            let addr = b.local_addr(result_slot);
                            let temp = b.alloc_synthetic_local();
                            b.store_local(temp, addr, super::super::ir::StoreKind::I64);
                            let out_arg = b.load_local(temp, super::super::ir::LoadKind::I64);
                            let mut shifted: alloc::vec::Vec<super::super::ir::ValueId> =
                                alloc::vec::Vec::with_capacity(arg_vals.len() + 1);
                            shifted.push(out_arg);
                            shifted.extend_from_slice(&arg_vals);
                            let call = b.call_ext(*val, shifted, fp_arg_mask << 1, false);
                            if !ext_arg_aggs.is_empty() {
                                let mut s = alloc::vec![None; arg_vals.len() + 1];
                                for (i, a) in ext_arg_aggs.iter().enumerate() {
                                    s[i + 1] = *a;
                                }
                                b.set_call_arg_aggs(call, s);
                            }
                            return Ok(b.local_addr(result_slot));
                        }
                        // A by-value struct return follows the platform ABI:
                        // reserve the result temp and tag the call's
                        // `ret_agg` so the emitter gathers the return
                        // registers (HFA in v0..vN, x0/x1 for a small
                        // aggregate, x8 indirect for > 16 bytes). The Mcpy at
                        // the use site copies from this temp's address.
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
                        let fp_return = is_floating_scalar(*ty);
                        let call = b.call_ext(*val, arg_vals, fp_arg_mask, fp_return);
                        if !ext_arg_aggs.is_empty() {
                            b.set_call_arg_aggs(call, ext_arg_aggs);
                        }
                        if let Some((ridx, slot)) = ret_temp {
                            b.set_call_ret_agg(call, ridx, slot);
                            return Ok(b.local_addr(slot));
                        }
                        if is_float_ty(*ty) {
                            return Ok(b.mark_f32(call));
                        }
                        // A libc / bound (`Sys`) callee's narrow return is
                        // extended by `return_extension` at the CallExt
                        // lowering, keyed on the binding's declared return
                        // type -- which correctly leaves an unprototyped
                        // binding (return_type_tag == 0) unextended rather
                        // than truncating a value that is really a pointer.
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
                // Aggregate arguments through a function pointer classify by
                // the pointed-to prototype's parameter types (System V AMD64
                // 3.2.3 / AAPCS64 6.4 / 6.8.2). The parser narrows each
                // argument to its parameter type before the call, so the
                // argument's own type is that parameter type; classify from
                // it. A variadic aggregate keeps the by-address convention
                // (matching the direct-call variadic handling). Inert on the
                // ABIs / sizes / by-address aggregates the classifier
                // declines.
                let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                for i in 0..arg_vals.len() {
                    if callee_variadic && i >= callee_fixed {
                        continue;
                    }
                    let Some(aty) = expr_ty(self.ast.expr(args[i])) else {
                        continue;
                    };
                    if !(is_struct_ty(aty) && struct_ptr_depth(aty) == 0) {
                        continue;
                    }
                    if let Some(desc) =
                        crate::c5::compiler::host_abi_agg_desc(self.structs, self.target, aty)
                    {
                        if arg_aggs.is_empty() {
                            arg_aggs = alloc::vec![None; arg_vals.len()];
                        }
                        arg_aggs[i] = Some(b.intern_agg_desc(desc));
                    }
                }
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
                    // The all-integer cdecl reads a floating-point parameter as
                    // a double from its 8-byte integer slot. A `double` already
                    // occupies eight bytes; a `float` must be widened to that
                    // pattern and reloaded through an integer slot so it is not
                    // passed as its 4-byte form in the low half of the slot.
                    for i in 0..arg_vals.len() {
                        if expr_ty(self.ast.expr(args[i]))
                            .map(is_float_ty)
                            .unwrap_or(false)
                        {
                            let widened = b.fp_widen_to_f64(arg_vals[i]);
                            let slot = b.alloc_synthetic_local();
                            b.store_local(slot, widened, super::super::ir::StoreKind::I64);
                            arg_vals[i] = b.load_local(slot, super::super::ir::LoadKind::I64);
                        }
                    }
                    all_args.extend_from_slice(&arg_vals);
                    let fixed = all_args.len();
                    let call = b.call_indirect(target, all_args, false, fixed, false, 0);
                    if !arg_aggs.is_empty() {
                        // `all_args` prepends the hidden out-pointer, so the
                        // aggregate descriptors shift by one slot.
                        let mut shifted = alloc::vec![None; arg_aggs.len() + 1];
                        shifted[1..].clone_from_slice(&arg_aggs);
                        b.set_call_arg_aggs(call, shifted);
                    }
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
                    if !arg_aggs.is_empty() {
                        b.set_call_arg_aggs(call, arg_aggs);
                    }
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
                    return Ok(extend_scalar_call_result(b, call, *ty, self.target));
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
                    if !arg_aggs.is_empty() {
                        b.set_call_arg_aggs(call, arg_aggs);
                    }
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
                    return Ok(extend_scalar_call_result(b, call, *ty, self.target));
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
                if !arg_aggs.is_empty() {
                    b.set_call_arg_aggs(call, arg_aggs);
                }
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
                Ok(extend_scalar_call_result(b, call, *ty, self.target))
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
                    let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*obj);
                    let mut v = b.load_vol(addr, unit_kind, vol);
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
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*obj);
                Ok(b.load_vol(addr, kind, vol))
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
                Ok(b.load_vol(addr, kind, is_volatile_ty(*ty)))
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
                    Expr::VlaBase { ty, .. } => *ty,
                    Expr::VlaSizeof { .. } => Ty::Int as i64,
                    Expr::StmtExpr { ty, .. } => *ty,
                    Expr::CheckedArith { ty, .. } => *ty,
                    // `&&label` is a `void *` (char-pointer encoding).
                    Expr::LabelAddr(_) => {
                        crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64
                    }
                    // An asm statement yields no value; it is never a
                    // cast operand.
                    Expr::InlineAsm(_) => Ty::Int as i64,
                };
                // A 128-bit `__int128` rvalue is carried as its address
                // (the struct-rvalue address-as-value rule). A cast to an
                // integer or pointer loads the object's low 8 bytes (its
                // value mod 2^64); the convert then narrows to `to_ty`.
                // Without the load the address is used as the value.
                if self.is_int128_value_ty(src_ty)
                    && !is_struct_ty(*to_ty)
                    && !is_floating_scalar(*to_ty)
                {
                    let low_ty = Ty::LongLong as i64 | UNSIGNED_BIT;
                    let low = b.load(v, load_kind_for(low_ty, self.target));
                    return Ok(self.convert_scalar_value(b, low, low_ty, *to_ty));
                }
                // The reverse: a scalar cast to a 128-bit `__int128`
                // materialises a 16-byte object and yields its address per
                // the same address-as-value rule. Without this the scalar
                // value stands where an address is expected.
                if !is_struct_ty(src_ty) && self.is_int128_value_ty(*to_ty) {
                    let slot = b.alloc_synthetic_struct(16);
                    let addr = b.local_addr(slot);
                    self.store_scalar_as_int128(b, addr, v, src_ty);
                    return Ok(addr);
                }
                Ok(self.convert_scalar_value(b, v, src_ty, *to_ty))
            }
            Expr::CompoundAssign { op, lhs, rhs, ty } => {
                // C99 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2`
                // with E1 evaluated once. Spill the lhs address,
                // load through it, apply the binop with rhs,
                // store back. The expression's value is the new
                // (post-op) value per the same clause.
                if self.is_int128_value_ty(*ty) {
                    return self.walk_int128_compound_assign(b, *op, *lhs, *rhs);
                }
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*lhs);
                let place = self.rmw_place(b, *lhs)?;
                let old = place.load(b, load_kind, vol);
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
                        let mut rhs_val = self.walk_expr_rvalue(b, *rhs)?;
                        // The walked rhs may have constant-folded to
                        // an `Imm` even when the AST shape isn't an
                        // `IntLit`; route through `binop_imm` in that
                        // case for the same reason as the
                        // `Expr::Binary` arm.
                        if imm_safe && let Some(rk) = b.peek_imm(rhs_val) {
                            b.binop_imm(*op, old, rk)
                        } else {
                            let mut lv = old;
                            // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
                            // modulo at a narrower-than-register common
                            // type masks each operand first, mirroring
                            // the `Expr::Binary` lowering. Both operand
                            // types <= 4 bytes means the common type is
                            // 4 bytes (integer promotion floors at int).
                            if matches!(*op, BinOp::Divu | BinOp::Modu) {
                                let rhs_sz = expr_ty(self.ast.expr(*rhs))
                                    .map_or(8, |t| type_size_bytes(t, self.target));
                                if type_size_bytes(*ty, self.target) <= 4 && rhs_sz <= 4 {
                                    lv = b.binop_imm(BinOp::And, lv, 0xffff_ffff);
                                    rhs_val = b.binop_imm(BinOp::And, rhs_val, 0xffff_ffff);
                                }
                            }
                            b.binop(*op, lv, rhs_val)
                        }
                    };
                place.store(b, new_val, store_kind, vol);
                // C99 6.5.16.2p3: the value of `E1 op= E2` is the
                // post-update value of E1 in E1's type. For a
                // sub-64-bit lvalue the 64-bit binop result is not
                // narrowed; reload through `load_kind` so the
                // returned ValueId reflects what was actually
                // stored (with the kind's sign / zero extension).
                // A volatile lvalue is accessed exactly once per read
                // and once per write (C99 6.7.3p6); its result is the
                // stored value narrowed in a register, never a re-read.
                Ok(if matches!(load_kind, LoadKind::I64) {
                    new_val
                } else if vol {
                    if is_floating_scalar(*ty) {
                        new_val
                    } else {
                        self.narrow_int_to_ty(b, new_val, Ty::LongLong as i64, *ty)
                    }
                } else {
                    place.load(b, load_kind, false)
                })
            }
            Expr::PreInc { lvalue, by, ty } => {
                if self.is_int128_value_ty(*ty) {
                    return self.walk_int128_inc(b, *lvalue, *by, false);
                }
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*lvalue);
                let place = self.rmw_place(b, *lvalue)?;
                let old = place.load(b, kind, vol);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind, vol);
                // C99 6.5.3.1p3 + 6.5.16.2: the value of `++E` is
                // the post-update value of E in E's type. Reload
                // through `kind` for sub-64-bit lvalues so a
                // surrounding test like `(++p) == 0` sees the
                // wrapped u8/u16/u32 value rather than the wider
                // Add result that overflows past the storage width.
                // A floating result is already at storage width.
                // A volatile lvalue is not re-read (C99 6.7.3p6); the
                // result is the stored value narrowed in a register.
                Ok(
                    if matches!(kind, LoadKind::I64) || is_floating_scalar(*ty) {
                        stepped
                    } else if vol {
                        self.narrow_int_to_ty(b, stepped, Ty::LongLong as i64, *ty)
                    } else {
                        place.load(b, kind, false)
                    },
                )
            }
            Expr::PostInc { lvalue, by, ty } => {
                if self.is_int128_value_ty(*ty) {
                    return self.walk_int128_inc(b, *lvalue, *by, true);
                }
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*lvalue);
                let place = self.rmw_place(b, *lvalue)?;
                let old = place.load(b, kind, vol);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind, vol);
                // C99 6.5.2.4p3: the expression's value is the
                // pre-update value (`old`).
                Ok(old)
            }
            Expr::Sizeof(s) => Ok(b.imm(s.size_bytes)),
            // C99 6.3.2.1p3: a VLA lvalue decays to a pointer to its
            // first element -- the runtime base pointer the matching
            // `Decl::Vla` stored into `ptr_slot`.
            Expr::VlaBase { ptr_slot, .. } => {
                Ok(b.load_local(*ptr_slot, super::super::ir::LoadKind::I64))
            }
            // C99 6.5.3.4p2: `sizeof <vla>` is the runtime byte count
            // the matching `Decl::Vla` stored into `size_slot`.
            Expr::VlaSizeof { size_slot } => {
                Ok(b.load_local(*size_slot, super::super::ir::LoadKind::I64))
            }
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
                    Ok(b.load_local_vol(slot, kind, is_volatile_ty(ty)))
                }
            }
            Expr::Comma { lhs, rhs, .. } => {
                let _ = self.walk_expr_rvalue(b, *lhs)?;
                self.walk_expr_rvalue(b, *rhs)
            }
            // GCC statement expression `({ ... })`: emit the block for
            // its side effects; the value is that of the last
            // expression-statement.
            Expr::StmtExpr { block, .. } => {
                let block = *block;
                self.walk_stmt_expr(b, block)
            }
            // GCC `__builtin_{add,sub,mul}_overflow(a, b, dst)`.
            Expr::CheckedArith {
                op,
                a,
                b: rhs,
                dst,
                elem_ty,
                ..
            } => {
                let (op, a, rhs, dst, elem_ty) = (*op, *a, *rhs, *dst, *elem_ty);
                self.walk_checked_arith(b, op, a, rhs, dst, elem_ty)
            }
            // A short-circuit in value position: the result is used, so
            // normalize it to 0/1.
            Expr::ShortCircuit { .. } => self.walk_short_circuit(b, id, true),
            Expr::Intrinsic { kind, args, .. } => {
                let intr_kind = *kind;
                // The va_* intrinsics receive the ADDRESS of the va_list
                // storage. The `__va_list_self(ap)` macro spells this as
                // `(ap)` on System V / AAPCS64 (the array decays to its
                // address) and `&(ap)` on the cursor targets. When `ap`
                // is `*pva` (a va_list reached through a pointer) the
                // System V form is a bare deref whose rvalue would load
                // the list's first eightbyte; the address wanted is the
                // pointer itself, so take the deref's lvalue. Operand
                // positions: arg 0 for va_start / va_arg / va_end, args 0
                // and 1 for va_copy.
                use super::super::op::Intrinsic as VaI;
                let va_addr_operand = |i: usize| match VaI::from_i64(intr_kind) {
                    Some(VaI::VaStart) | Some(VaI::VaArg) | Some(VaI::VaEnd) => i == 0,
                    Some(VaI::VaCopy) => i == 0 || i == 1,
                    _ => false,
                };
                let mut arg_vals: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                for (i, a) in args.clone().into_iter().enumerate() {
                    let v = if va_addr_operand(i)
                        && matches!(
                            self.ast.expr(a),
                            Expr::Unary {
                                op: UnOp::Deref,
                                ..
                            }
                        ) {
                        self.walk_expr_lvalue(b, a)?
                    } else {
                        self.walk_expr_rvalue(b, a)?
                    };
                    arg_vals.push(v);
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
                        I::Clrsb | I::Clrsbll => lower_clrsb(b, x, w64),
                        I::Ffs | I::Ffsll => lower_ffs(b, x, w64),
                        I::Parity | I::Parityll => {
                            let pc = lower_popcount(b, x, w64);
                            b.binop_imm(BinOp::And, pc, 1)
                        }
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
            Expr::InlineAsm(idx) => {
                // GCC extended asm. Each operand expression is an output
                // destination address (the parser applied `&`) or an
                // input value; the block descriptor carries the template
                // and per-operand constraints for the per-arch lowering.
                let asm = self.ast.asm_blocks[*idx as usize].clone();
                let mut args: alloc::vec::Vec<super::super::ir::ValueId> =
                    alloc::vec::Vec::with_capacity(asm.operand_exprs.len());
                for &e in &asm.operand_exprs {
                    args.push(self.walk_expr_rvalue(b, e)?);
                }
                Ok(b.inline_asm(alloc::boxed::Box::new(asm.block), args))
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

    /// Lower a C11 7.17 atomic operation. A naturally-aligned scalar
    /// load and store is already atomic on the supported targets, so
    /// `atomic_load` / `atomic_store` lower to a plain load / store.
    /// The read-modify-write and compare-exchange forms lower to the
    /// dedicated `Inst::AtomicRmw` / `Inst::AtomicCas`, which the
    /// per-arch emit turns into a genuine atomic sequence (C11
    /// 7.17.7); `width` is the access size of the atomic object's
    /// element type in bytes.
    fn walk_atomic(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        kind: AtomicKind,
        args: &[ExprId],
        elem_ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let load_kind = load_kind_for(elem_ty, self.target);
        let store_kind = store_kind_for(elem_ty, self.target);
        let width = type_size_bytes(elem_ty, self.target) as u8;
        // Every atomic form here acts on a 1/2/4/8-byte scalar object; a
        // wider or aggregate one (a 128-bit `__int128`, sized 0 by
        // `type_size_bytes`) has no atomic form in the current emit and
        // would lower to a faulting / high-half-dropping access. Reject it.
        // TODO: 16-byte objects via cmpxchg16b / ldxp-stxp.
        if !matches!(width, 1 | 2 | 4 | 8) {
            return Err(WalkError::UnsupportedExpr {
                id: args[0],
                kind: "atomic operation requires a 1/2/4/8-byte scalar object",
            });
        }
        let addr = self.walk_expr_rvalue(b, args[0])?;
        match kind {
            AtomicKind::Load => Ok(b.load(addr, load_kind)),
            AtomicKind::Store => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                b.store(addr, value, store_kind);
                // Used in statement position; the value is discarded.
                Ok(b.imm(0))
            }
            // Generic `__atomic_load(p, ret, mo)`: load `*p`, write it
            // through `ret`. `__atomic_store(p, val, mo)`: load `*val`,
            // write it to `*p`. Both move the value through a pointer.
            AtomicKind::LoadInto => {
                let value = b.load(addr, load_kind);
                let ret = self.walk_expr_rvalue(b, args[1])?;
                b.store(ret, value, store_kind);
                Ok(b.imm(0))
            }
            AtomicKind::StoreFrom => {
                let val_addr = self.walk_expr_rvalue(b, args[1])?;
                let value = b.load(val_addr, load_kind);
                b.store(addr, value, store_kind);
                Ok(b.imm(0))
            }
            AtomicKind::Exchange
            | AtomicKind::FetchAdd
            | AtomicKind::FetchSub
            | AtomicKind::FetchAnd
            | AtomicKind::FetchOr
            | AtomicKind::FetchXor => {
                let value = self.walk_expr_rvalue(b, args[1])?;
                let op = match kind {
                    AtomicKind::Exchange => AtomicRmwOp::Xchg,
                    AtomicKind::FetchAdd => AtomicRmwOp::Add,
                    AtomicKind::FetchSub => AtomicRmwOp::Sub,
                    AtomicKind::FetchAnd => AtomicRmwOp::And,
                    AtomicKind::FetchOr => AtomicRmwOp::Or,
                    AtomicKind::FetchXor => AtomicRmwOp::Xor,
                    _ => unreachable!(),
                };
                // C11 7.17.7p2: the prior value of the object. The atomic
                // instruction sets only the low `width` bytes; normalize
                // to the element type's representation (C99 6.3.1.3), the
                // same sign / zero extension a load of `elem_ty` performs.
                let old = b.atomic_rmw(op, addr, value, width);
                Ok(self.extend_atomic_result(b, old, elem_ty))
            }
            AtomicKind::CompareExchangeStrong => {
                // C11 7.17.7.4: yield 1 on a match (after storing
                // `desired`), else store the current contents into
                // `*expected` and yield 0.
                let exp_addr = self.walk_expr_rvalue(b, args[1])?;
                let desired = self.walk_expr_rvalue(b, args[2])?;
                Ok(b.atomic_cas(addr, exp_addr, desired, width))
            }
            AtomicKind::AddFetch
            | AtomicKind::SubFetch
            | AtomicKind::AndFetch
            | AtomicKind::OrFetch
            | AtomicKind::XorFetch => {
                // GCC `__sync_*_and_fetch`: the read-modify-write yields the
                // prior value; recompute the post-operation value in plain
                // IR so a value with side effects is evaluated once.
                let value = self.walk_expr_rvalue(b, args[1])?;
                let (rmw, bin) = match kind {
                    AtomicKind::AddFetch => (AtomicRmwOp::Add, BinOp::Add),
                    AtomicKind::SubFetch => (AtomicRmwOp::Sub, BinOp::Sub),
                    AtomicKind::AndFetch => (AtomicRmwOp::And, BinOp::And),
                    AtomicKind::OrFetch => (AtomicRmwOp::Or, BinOp::Or),
                    AtomicKind::XorFetch => (AtomicRmwOp::Xor, BinOp::Xor),
                    _ => unreachable!(),
                };
                let old = b.atomic_rmw(rmw, addr, value, width);
                let old = self.extend_atomic_result(b, old, elem_ty);
                let new = b.binop(bin, old, value);
                Ok(self.extend_atomic_result(b, new, elem_ty))
            }
            AtomicKind::SyncCasVal | AtomicKind::SyncCasBool => {
                // GCC `__sync_val/bool_compare_and_swap(p, old, new)`. The
                // existing CAS expects the comparand by address and writes
                // the current `*p` back through it on failure, so after the
                // CAS the scratch slot holds the prior `*p` in both cases.
                let old_val = self.walk_expr_rvalue(b, args[1])?;
                let new_val = self.walk_expr_rvalue(b, args[2])?;
                let slot = b.alloc_synthetic_local();
                let exp_addr = b.local_addr(slot);
                b.store(exp_addr, old_val, store_kind);
                let swapped = b.atomic_cas(addr, exp_addr, new_val, width);
                if matches!(kind, AtomicKind::SyncCasBool) {
                    Ok(swapped)
                } else {
                    Ok(b.load(exp_addr, load_kind))
                }
            }
        }
    }

    /// Normalize a sub-`int` atomic read-modify-write result to its
    /// element type's representation (C99 6.3.1.3): zero-extend an
    /// unsigned narrow type, sign-extend a signed one. A 4- or 8-byte
    /// type and a pointer ride the register at full width unchanged.
    /// Narrow an integer value of type `src_ty` to `to_ty`'s storage
    /// width per C99 6.3.1.3. An unsigned target masks to width; a
    /// signed narrowing (or a same-width signed view of an unsigned
    /// source) sign-extends the truncated value via the shift pair.
    /// A wider-or-equal signed conversion, a non-integer target, or a
    /// target of 8 bytes or more needs no op. Shared by the cast path
    /// and by assignment / compound-assignment / increment expressions,
    /// whose value has the converted type of the left operand
    /// (6.5.16p3 / 6.5.16.2 / 6.5.2.4 / 6.5.3.1) and so must carry the
    /// narrowed value when a wider enclosing expression reads it.
    fn narrow_int_to_ty(
        &self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        v: super::super::ir::ValueId,
        src_ty: i64,
        to_ty: i64,
    ) -> super::super::ir::ValueId {
        if is_floating_scalar(to_ty) || is_struct_ty(to_ty) {
            return v;
        }
        let target_size = type_size_bytes(to_ty, self.target);
        let source_size = type_size_bytes(src_ty, self.target);
        if target_size == 0 || target_size >= 8 {
            return v;
        }
        let source_unsigned = (src_ty & UNSIGNED_BIT) != 0;
        let target_unsigned = (to_ty & UNSIGNED_BIT) != 0;
        if target_unsigned {
            let mask: i64 = match target_size {
                1 => 0xff,
                2 => 0xffff,
                4 => 0xffff_ffff,
                _ => return v,
            };
            b.binop_imm(BinOp::And, v, mask)
        } else {
            let needs_extend =
                target_size < source_size || (target_size == source_size && source_unsigned);
            if needs_extend {
                let bits = 64i64 - (target_size as i64) * 8;
                let shifted = b.binop_imm(BinOp::Shl, v, bits);
                b.binop_imm(BinOp::Shr, shifted, bits)
            } else {
                v
            }
        }
    }

    fn extend_atomic_result(
        &self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        v: super::super::ir::ValueId,
        elem_ty: i64,
    ) -> super::super::ir::ValueId {
        if is_pointer_ty(elem_ty) {
            return v;
        }
        let rs = type_size_bytes(elem_ty, self.target);
        if rs >= 8 {
            return v;
        }
        // The atomic instruction defines only the low `rs` bytes of the
        // prior value; canonicalize the rest per C99 6.3.1.3. `int` and
        // `long` are 4 bytes on LLP64, so every sub-8-byte width needs this.
        if (elem_ty & UNSIGNED_BIT) != 0 {
            let mask: i64 = (1i64 << (rs as i64 * 8)) - 1;
            b.binop_imm(BinOp::And, v, mask)
        } else {
            let bits = 64i64 - (rs as i64) * 8;
            let shifted = b.binop_imm(BinOp::Shl, v, bits);
            b.binop_imm(BinOp::Shr, shifted, bits)
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
    /// non-thread-local `Token::Loc` Ident keeps its frame slot so
    /// mem2reg can promote it; every non-local lvalue materializes an
    /// address through `walk_expr_lvalue`. Mirrors the `Expr::Assign`
    /// local-target shortcut so `i++` / `i += k` keep the counter
    /// register-resident, not just `i = i + k`.
    fn rmw_place(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        lvalue: ExprId,
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
        if let Expr::Ident {
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
            // C99 6.5.2.5p4: a compound literal is an lvalue naming an
            // unnamed object. In lvalue position (`&(T){...}`) emit the
            // initializer into the reserved slot and yield the slot's
            // address. The rvalue path handles the value-position case,
            // where a scalar literal loads the slot instead.
            Expr::CompoundLiteral {
                slot_off, ty, init, ..
            } => {
                let (slot, ty, init) = (*slot_off, *ty, init.clone());
                self.emit_local_init(b, slot, ty, &init)?;
                Ok(b.local_addr(slot))
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
    /// True when `cond` is observed for truthiness as a floating value,
    /// i.e. the C99 controlling-expression comparison is `!= 0.0`. A
    /// comparison's result is `int`, so it is excluded even though its
    /// node may carry the operand type.
    fn cond_is_float(&self, cond: ExprId) -> bool {
        let e = self.ast.expr(cond);
        if let Expr::Binary { op, .. } = e
            && is_comparison_op(*op)
        {
            return false;
        }
        expr_ty(e).is_some_and(is_floating_scalar)
    }

    /// Fold `id` to a compile-time integer constant when it is an
    /// integer constant expression the walker can evaluate without
    /// runtime state (C99 6.6). Returns None for any operand that
    /// needs a load, a call, or an operator outside the handled set.
    /// Used to select the live arm of a constant-condition `?:` /
    /// `if` so the dead arm's side effects -- including references to
    /// undefined symbols -- are never emitted, matching the front-end
    /// fold gcc performs even at -O0. Identifiers are not resolved, so
    /// only literal-rooted expressions fold.
    fn const_fold_int(&self, id: ExprId) -> Option<i64> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Some(*val),
            Expr::Unary { op, child, .. } => {
                let v = self.const_fold_int(*child)?;
                match op {
                    UnOp::Neg => Some(v.wrapping_neg()),
                    UnOp::BitNot => Some(!v),
                    UnOp::LogNot => Some((v == 0) as i64),
                    UnOp::AddrOf | UnOp::Deref => None,
                }
            }
            Expr::Binary { op, lhs, rhs, .. } => {
                // Integer `/` and `%` are integer constant expressions
                // (C99 6.6) but are not immediate-foldable operators, so
                // the imm-safe predicate (shared with the BinopI rvalue
                // fold) excludes them; accept them here for the pure
                // compile-time evaluation. A zero divisor is undefined
                // and thus not a constant, so the fold declines it.
                let divmod = matches!(*op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu);
                if !imm_safe_binop(*op) && !divmod {
                    return None;
                }
                let l = self.const_fold_int(*lhs)?;
                let r = self.const_fold_int(*rhs)?;
                if divmod && r == 0 {
                    return None;
                }
                Some(fold_int_binop(*op, l, r))
            }
            Expr::ShortCircuit { op, lhs, rhs, .. } => {
                let l = self.const_fold_int(*lhs)?;
                match op {
                    super::ShortCircuitOp::Lan if l == 0 => Some(0),
                    super::ShortCircuitOp::Lan => Some((self.const_fold_int(*rhs)? != 0) as i64),
                    super::ShortCircuitOp::Lor if l != 0 => Some(1),
                    super::ShortCircuitOp::Lor => Some((self.const_fold_int(*rhs)? != 0) as i64),
                }
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                elvis,
                ..
            } => {
                let c = self.const_fold_int(*cond)?;
                if *elvis {
                    if c != 0 {
                        Some(c)
                    } else {
                        self.const_fold_int(*else_e)
                    }
                } else if c != 0 {
                    self.const_fold_int(*then_e)
                } else {
                    self.const_fold_int(*else_e)
                }
            }
            Expr::Cast { child, to_ty } => {
                let v = self.const_fold_int(*child)?;
                let to = *to_ty;
                if is_floating_scalar(to) {
                    return None;
                }
                if is_bool_scalar(to) {
                    return Some((v != 0) as i64);
                }
                if type_size_bytes(to, self.target) == 0 {
                    return None;
                }
                Some(narrow_const_to_ty(v, to, self.target))
            }
            _ => None,
        }
    }

    /// Whether the statement subtree defines a label reachable from
    /// outside it: a `goto` target (`Labeled`) anywhere within, or a
    /// `case` / `default` belonging to a `switch` that encloses the
    /// subtree. A constant-condition `if` may drop its dead branch
    /// only when that branch defines none, since the branch's block
    /// would otherwise never be emitted for the jump to reach. A
    /// `switch` wholly inside the branch owns its case labels -- its
    /// dispatch drops with the branch -- so those don't pin it.
    fn stmt_defines_label(&self, id: StmtId) -> bool {
        self.stmt_defines_external_label(id, false)
    }

    fn stmt_defines_external_label(&self, id: StmtId, cases_owned: bool) -> bool {
        match self.ast.stmt(id) {
            Stmt::Labeled { .. } => true,
            Stmt::Case { body, .. } | Stmt::Default { body } => {
                !cases_owned || self.stmt_defines_external_label(*body, cases_owned)
            }
            Stmt::Compound(items) => items.iter().any(|it| match it {
                super::BlockItem::Stmt(s) => self.stmt_defines_external_label(*s, cases_owned),
                super::BlockItem::Decl(_) => false,
            }),
            Stmt::If { then_s, else_s, .. } => {
                self.stmt_defines_external_label(*then_s, cases_owned)
                    || else_s.is_some_and(|e| self.stmt_defines_external_label(e, cases_owned))
            }
            Stmt::While { body, .. } | Stmt::DoWhile { body, .. } | Stmt::For { body, .. } => {
                self.stmt_defines_external_label(*body, cases_owned)
            }
            Stmt::Switch { body, .. } => self.stmt_defines_external_label(*body, true),
            _ => false,
        }
    }

    /// Convert an already-evaluated scalar value from `src_ty` to
    /// `to_ty` (C99 6.3.1). Shared by the `Cast` lowering and the GNU
    /// `?:` then-arm, which reuses the condition's value.
    fn convert_scalar_value(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        v: super::super::ir::ValueId,
        src_ty: i64,
        to_ty: i64,
    ) -> super::super::ir::ValueId {
        let target_is_fp = is_floating_scalar(to_ty);
        let source_is_fp = is_floating_scalar(src_ty);
        // C99 6.3.1.2: a conversion to `_Bool` yields 0 when the source
        // compares equal to 0, else 1. This holds for every scalar
        // source, so it precedes the width/fp-ness conversions below.
        if is_bool_scalar(to_ty) {
            if source_is_fp {
                let d = b.fp_widen_to_f64(v);
                let zero = b.imm(0);
                return b.binop(BinOp::Fne, d, zero);
            }
            return b.binop_imm(BinOp::Ne, v, 0);
        }
        if target_is_fp && !source_is_fp {
            // Integer -> FP (C99 6.3.1.4), one rounding to the target
            // type. An unsigned 64-bit source can exceed the signed
            // range, where the signed convert yields a negative result,
            // so it takes the unsigned converter. Narrower unsigned
            // types fit the signed range zero-extended.
            let stripped = src_ty & !(UNSIGNED_BIT | VOLATILE_BIT);
            let unsigned_64 = (src_ty & UNSIGNED_BIT) != 0
                && (stripped == Ty::Long as i64 || stripped == Ty::LongLong as i64);
            let to_float = is_float_ty(to_ty);
            // Fold a constant operand to the converted FP constant.
            if let Some(k) = b.peek_imm(v) {
                if to_float {
                    let f = if unsigned_64 {
                        k as u64 as f32
                    } else {
                        k as f32
                    };
                    return b.imm_f32(f.to_bits());
                }
                let d = if unsigned_64 {
                    k as u64 as f64
                } else {
                    k as f64
                };
                return b.imm(d.to_bits() as i64);
            }
            let kind = if unsigned_64 {
                super::super::ir::FpCastKind::UIntToFp
            } else {
                super::super::ir::FpCastKind::IntToFp
            };
            // A `float` target converts directly to single precision; a
            // `double` target stays f64.
            if to_float {
                return b.fp_cast_to_f32(kind, v);
            }
            return b.fp_cast(kind, v);
        } else if !target_is_fp && source_is_fp {
            // FP -> integer (C99 6.3.1.4) truncates toward zero. An
            // unsigned 64-bit target can hold a value in [2^63, 2^64),
            // which the signed truncate would saturate, so it takes the
            // unsigned converter (a `float` source widens to f64 for it).
            let stripped_to = to_ty & !(UNSIGNED_BIT | VOLATILE_BIT);
            let target_unsigned_64 = (to_ty & UNSIGNED_BIT) != 0
                && (stripped_to == Ty::Long as i64 || stripped_to == Ty::LongLong as i64);
            if target_unsigned_64 {
                let d = b.fp_widen_to_f64(v);
                return b.fp_cast(super::super::ir::FpCastKind::UFpToInt, d);
            }
            return b.fp_cast(super::super::ir::FpCastKind::FpToInt, v);
        }
        // FP-to-FP cast (C99 6.3.1.5): `(double)f` widens, `(float)d`
        // narrows; a no-op when the source already has the target width.
        if target_is_fp && source_is_fp {
            if is_float_ty(to_ty) {
                return b.fp_narrow_to_f32(v);
            }
            return b.fp_widen_to_f64(v);
        }
        // Integer-to-integer cast (C99 6.3.1.3): narrow to the target
        // storage width, sign- or zero-extending per the target's sign.
        self.narrow_int_to_ty(b, v, src_ty, to_ty)
    }

    /// Value to test against zero for `cond`'s truthiness. A floating
    /// operand is reduced to `cond != 0.0` (0 or 1) so `-0.0` reads as
    /// false; an integer operand passes through and is tested directly.
    fn cond_truthy(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        val: super::super::ir::ValueId,
        cond: ExprId,
    ) -> super::super::ir::ValueId {
        if self.cond_is_float(cond) {
            let d = b.fp_widen_to_f64(val);
            let zero = b.imm(0);
            return b.binop(BinOp::Fne, d, zero);
        }
        // A 128-bit operand is carried as its object's address; testing
        // that address would read every value as true. Test the value:
        // it is non-zero when either half is.
        if self.expr_is_int128_value(cond) {
            let (lo, hi) = self.int128_load(b, val);
            return b.binop(BinOp::Or, lo, hi);
        }
        val
    }

    fn walk_short_circuit(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
        // The deciding value is the lhs truthiness; a floating operand
        // compares against 0.0 so `-0.0` is false rather than a non-zero
        // bit pattern.
        let lhs_t = self.cond_truthy(b, lhs_val, lhs);
        // On the short-circuit path the lhs truthiness is the result, so
        // in branch context that value suffices.
        let short_val = if normalize {
            match op {
                super::ShortCircuitOp::Lor => b.imm(1),
                super::ShortCircuitOp::Lan => b.imm(0),
            }
        } else {
            lhs_t
        };
        b.store_local(slot, short_val, kind_s);
        let rhs_blk = b.new_block();
        let after_blk = b.new_block();
        match op {
            // `a && b`: skip rhs when lhs == 0.
            super::ShortCircuitOp::Lan => b.branch_zero(lhs_t, after_blk, rhs_blk),
            // `a || b`: skip rhs when lhs != 0.
            super::ShortCircuitOp::Lor => b.branch_nonzero(lhs_t, after_blk, rhs_blk),
        }
        b.switch_to(rhs_blk);
        let rhs_val = self.walk_expr_rvalue(b, rhs)?;
        let rhs_t = self.cond_truthy(b, rhs_val, rhs);
        let stored = if normalize {
            b.binop_imm(super::super::ir::BinOp::Ne, rhs_t, 0)
        } else {
            rhs_t
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        cond: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        if matches!(self.ast.expr(cond), Expr::ShortCircuit { .. }) {
            return self.walk_short_circuit(b, cond, false);
        }
        // C99 6.8.4.1 / 6.8.5: a controlling expression is compared
        // against 0. A floating operand uses the FP comparison
        // `v != 0.0`; testing the register bits directly would read
        // `-0.0` (sign bit set) as true.
        let v = self.walk_expr_rvalue(b, cond)?;
        Ok(self.cond_truthy(b, v, cond))
    }

    /// Neg / BitNot / LogNot lower to a binop against an
    /// immediate.
    fn walk_unary(
        &mut self,
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
                Ok(b.load_vol(addr, kind, is_volatile_ty(ty)))
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
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
                match self.live_tls_addr(*sym, *val) {
                    GloAddr::Extern => Ok(b.tls_addr_extern(*sym)),
                    GloAddr::Resolved(off) => Ok(b.tls_addr(off)),
                }
            } else {
                let addr = if self.ast.block_extern_refs.contains(&id) {
                    self.block_extern_glo_addr(*sym)
                } else {
                    self.live_glo_addr(*sym, *val)
                };
                match addr {
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
        } else if *class == Token::Sys as i64 {
            // Address of a dynamically-imported function (`&strcmp`,
            // `fp = strcmp`). The Ident's `val` is the binding's flat
            // index across all `#pragma binding(...)` directives, the
            // same value `Inst::CallExt` carries. The address resolves
            // to the import's shared PLT stub.
            Ok(b.imm_ext_code(*val))
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        id: ExprId,
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
            Some(if self.ast.block_extern_refs.contains(&id) {
                self.block_extern_glo_addr(_sym)
            } else {
                self.live_glo_addr(_sym, val)
            })
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
                return Ok(match self.live_tls_addr(_sym, val) {
                    GloAddr::Extern => b.tls_addr_extern(_sym),
                    GloAddr::Resolved(off) => b.tls_addr(off),
                });
            }
        }
        let vol = is_volatile_ty(ty);
        if class == Token::Loc as i64 {
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local_vol(val, kind, vol))
        } else if let Some(addr) = glo_addr {
            let addr_v = match addr {
                GloAddr::Extern => b.imm_data_extern(_sym),
                GloAddr::Resolved(off) => b.imm_data(off),
            };
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_vol(addr_v, kind, vol))
        } else if class == Token::Glo as i64 && is_thread_local {
            let addr = match self.live_tls_addr(_sym, val) {
                GloAddr::Extern => b.tls_addr_extern(_sym),
                GloAddr::Resolved(off) => b.tls_addr(off),
            };
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_vol(addr, kind, vol))
        } else if class == Token::Fun as i64 {
            if val == 0 {
                Ok(b.imm_code_extern(_sym))
            } else {
                Ok(b.imm_code(val as usize))
            }
        } else if class == Token::Sys as i64 {
            // Bare imported-function rvalue (`fp = strcmp`). `val` is
            // the binding index; the address resolves to the import's
            // shared PLT stub. See `address_of_ident`.
            Ok(b.imm_ext_code(val))
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        kind: LoadKind,
        vol: bool,
    ) -> super::super::ir::ValueId {
        match *self {
            RmwPlace::Slot(off) => b.load_local_vol(off, kind, vol),
            RmwPlace::Addr(addr) => b.load_vol(addr, kind, vol),
            RmwPlace::Bitfield { addr, bf } => {
                // C99 6.7.2.1: load the unit, shift the slice to bit 0,
                // mask, and sign-extend when the field type is signed.
                let unit_kind = match bf.unit_size {
                    1 => LoadKind::U8,
                    2 => LoadKind::U16,
                    4 => LoadKind::U32,
                    _ => LoadKind::I64,
                };
                let mut v = b.load_vol(addr, unit_kind, vol);
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
        b: &mut super::super::codegen::ssa::build::SsaBuilder,
        value: super::super::ir::ValueId,
        kind: StoreKind,
        vol: bool,
    ) {
        match *self {
            RmwPlace::Slot(off) => {
                b.store_local_vol(off, value, kind, vol);
            }
            RmwPlace::Addr(addr) => {
                b.store_vol(addr, value, kind, vol);
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
                let old = b.load_vol(addr, load_kind, vol);
                let cleared = b.binop_imm(BinOp::And, old, clear_mask);
                let masked = b.binop_imm(BinOp::And, value, mask);
                let shifted = if bf.bit_offset > 0 {
                    b.binop_imm(BinOp::Shl, masked, bf.bit_offset as i64)
                } else {
                    masked
                };
                let combined = b.binop(BinOp::Or, cleared, shifted);
                b.store_vol(addr, combined, store_kind, vol);
            }
        }
    }
}

/// Map a c5 type tag to the matching `LoadKind`. Mirrors
/// `compiler::types::load_op_for`.
fn load_kind_for(ty: i64, target: Target) -> LoadKind {
    // The SSA backend loads a `double` into an FP register.
    load_kind(ty, target, LoadKind::F64)
}

/// Mirror of [`load_kind_for`] for stores.
fn store_kind_for(ty: i64, target: Target) -> StoreKind {
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
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

/// True for a relational or equality operator (integer or
/// floating-point). The result is `int` (C99 6.5.8 / 6.5.9) regardless
/// of operand type.
pub(crate) fn is_comparison_op(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
            | BinOp::Feq
            | BinOp::Fne
            | BinOp::Flt
            | BinOp::Fgt
            | BinOp::Fle
            | BinOp::Fge
    )
}

/// Test for floating-point scalar types.
fn is_floating_scalar(ty: i64) -> bool {
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
    stripped == Ty::Float as i64 || stripped == Ty::Double as i64
}

/// True for the scalar `float` type. C99 6.3.1.8 leaves `float op
/// float` at type `float` (single precision); the walker tags the
/// result and feeds the single-precision codegen path.
fn is_float_ty(ty: i64) -> bool {
    (ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Float as i64
}

/// True for the scalar `_Bool` type (not a pointer to one). Used by
/// the cast lowering to apply the C99 6.3.1.2 conversion (any
/// nonzero scalar becomes 1).
fn is_bool_scalar(ty: i64) -> bool {
    (ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Bool as i64
}

/// Sign- or zero-extend a scalar call result to the full 64-bit
/// accumulator per its declared return type. A c5-compiled callee
/// already returns a 64-bit-correct value, and a direct libc call
/// (`Inst::CallExt`) is widened in the emitter from the binding's
/// return type. A call through a function pointer to a host library
/// routine has neither: the routine leaves only its natural-width
/// register set (`strcmp` returns a 32-bit result in `eax` with
/// undefined high bits), so a call through an `int (*)()` pointer
/// must widen the result before the caller reads it at 64 bits
/// (C99 6.3.1.1 / 6.5.2.2). Idempotent for an already-extended
/// value. Floating-point, pointer, `_Bool`, struct, and full-width
/// integer results are left unchanged.
fn extend_scalar_call_result(
    b: &mut super::super::codegen::ssa::build::SsaBuilder,
    v: super::super::ir::ValueId,
    ty: i64,
    target: Target,
) -> super::super::ir::ValueId {
    use super::super::ir::BinOp;
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
    let rs = type_size_bytes(ty, target);
    if is_floating_scalar(ty) || is_pointer_ty(ty) || !(rs == 1 || rs == 2 || rs == 4) {
        return v;
    }
    // A `_Bool` return is defined only in the low byte per the psABI
    // (a callee compiled by another toolchain may leave garbage in the
    // high bits, e.g. `sete %al` with no zero-extend). Zero-extend it
    // like an unsigned char so a full-width test / `!` reads 0 or 1.
    if (ty & UNSIGNED_BIT) != 0 || stripped == Ty::Bool as i64 {
        let mask: i64 = match rs {
            1 => 0xff,
            2 => 0xffff,
            _ => 0xffff_ffff,
        };
        b.binop_imm(BinOp::And, v, mask)
    } else {
        let bits = 64i64 - (rs as i64) * 8;
        let shifted = b.binop_imm(BinOp::Shl, v, bits);
        b.binop_imm(BinOp::Shr, shifted, bits)
    }
}

// Portable lowering of the GCC bit-count builtins (`__builtin_clz` /
// `ctz` / `popcount` and the 64-bit `ll` forms). Each expands to a
// branchless shift / mask sequence over the SSA builder so the result
// matches across the interpreter and every target without a dedicated
// instruction. `w64` selects the 64-bit forms; the rest operate on the
// low 32 bits (the operand reaches here zero-extended from the parser's
// unsigned cast).

type Bld = super::super::codegen::ssa::build::SsaBuilder;
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
/// Count leading redundant sign bits: `clz(x ^ (x >> (w-1))) - 1`, with
/// an arithmetic shift forming the all-sign mask. XORing it clears the
/// leading run of sign bits to zeros (and always the sign bit itself),
/// so `clz` of the result is that run length plus one. `x` is sign-
/// extended into the register, so its high half mirrors the sign in the
/// 32-bit case and the XOR leaves the upper bits zero.
fn lower_clrsb(b: &mut Bld, x: Val, w64: bool) -> Val {
    let sign = b.binop_imm(BinOp::Shr, x, if w64 { 63 } else { 31 });
    let folded = b.binop(BinOp::Xor, x, sign);
    let clz = lower_clz(b, folded, w64);
    b.binop_imm(BinOp::Sub, clz, 1)
}

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

// POSIX / GCC `ffs`: one plus the index of the least-significant set bit,
// 0 for a zero input. `lower_ctz` returns the bit width at zero, so the
// `(x != 0)` factor forces the zero case to 0.
fn lower_ffs(b: &mut Bld, x: Val, w64: bool) -> Val {
    let ctz = lower_ctz(b, x, w64);
    let cp1 = b.binop_imm(BinOp::Add, ctz, 1);
    let nz = b.binop_imm(BinOp::Ne, x, 0);
    b.binop(BinOp::Mul, cp1, nz)
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

/// Read the type tag off an expression node. Returns `None` for
/// shapes that don't carry one (`Sizeof` is constant-evaluated
/// and the walker doesn't peek into the result; intrinsics carry
/// their own `ty`).
pub(crate) fn expr_ty(e: &Expr) -> Option<i64> {
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
        | Expr::Atomic { ty, .. }
        | Expr::VlaBase { ty, .. }
        | Expr::StmtExpr { ty, .. }
        | Expr::CheckedArith { ty, .. } => Some(*ty),
        Expr::Cast { to_ty, .. } => Some(*to_ty),
        Expr::Sizeof(s) => Some(s.result_ty),
        // `sizeof <vla>` is a runtime `size_t`; c5 types it as `int`.
        Expr::VlaSizeof { .. } => Some(crate::c5::token::Ty::Int as i64),
        Expr::CompoundLiteral { ty, .. } => Some(*ty),
        // `&&label` is a `void *` (char-pointer encoding).
        Expr::LabelAddr(_) => {
            Some(crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64)
        }
        // An asm statement carries no value type.
        Expr::InlineAsm(_) => None,
    }
}

/// Byte size of a C type tag at the active target. Mirrors
/// `compiler::types::size_of_type` for the scalar / pointer / FP
/// cases the walker handles. Returns 0 for types whose width
/// the walker can't compute (struct types, function types -- the
/// walker doesn't currently consume those in cast positions).
fn type_size_bytes(ty: i64, target: Target) -> usize {
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
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
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
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

/// Ops whose two-constant fold and per-arch `BinopI` immediate
/// lowering are both defined: arithmetic, bitwise, shift, and
/// integer comparison. Excludes Div / Divu / Mod / Modu (which
/// `fold_int_binop` evaluates but the immediate path does not
/// cover) and every FP op.
pub(crate) fn imm_safe_binop(op: BinOp) -> bool {
    matches!(
        op,
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
    )
}

/// Narrow a folded integer constant to the storage width and
/// signedness of `ty` (C99 6.3.1.3). Widths above 4 bytes and
/// types `type_size_bytes` can't size keep the full 64-bit value.
fn narrow_const_to_ty(v: i64, ty: i64, target: Target) -> i64 {
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    match type_size_bytes(ty, target) {
        1 => {
            if unsigned {
                v as u8 as i64
            } else {
                v as i8 as i64
            }
        }
        2 => {
            if unsigned {
                v as u16 as i64
            } else {
                v as i16 as i64
            }
        }
        4 => {
            if unsigned {
                v as u32 as i64
            } else {
                v as i32 as i64
            }
        }
        _ => v,
    }
}

/// Fold an integer binop on two constant operands. C99 6.6
/// permits this at translation time. Covers arithmetic, bitwise,
/// shift, integer comparison, and integer divide / modulo; FP
/// and the non-integer opcodes are rejected. A zero divisor is
/// the caller's responsibility (`const_fold_int` declines it);
/// signed `INT_MIN / -1` wraps to `INT_MIN` rather than trapping.
/// Shifts at out-of-range amounts produce 0 (matches what `lsl
/// xd, xn, xm` with `xm >= 64` would land on; signed `asr` on a
/// non-negative operand likewise saturates to 0, and on a
/// negative operand to -1, so the model picks the closer of the
/// two for the rhs's sign).
pub(crate) fn fold_int_binop(op: BinOp, lhs: i64, rhs: i64) -> i64 {
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
        BinOp::Div => lhs.wrapping_div(rhs),
        BinOp::Mod => lhs.wrapping_rem(rhs),
        BinOp::Divu => ((lhs as u64) / (rhs as u64)) as i64,
        BinOp::Modu => ((lhs as u64) % (rhs as u64)) as i64,
        _ => unreachable!("fold_int_binop reached on a non-integer op"),
    }
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
        Expr::VlaBase { .. } => "VlaBase",
        Expr::VlaSizeof { .. } => "VlaSizeof",
        Expr::StmtExpr { .. } => "StmtExpr",
        Expr::CheckedArith { .. } => "CheckedArith",
        Expr::InlineAsm(_) => "InlineAsm",
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
                Inst::LoadLocal { off, kind, .. } => Some((*off, *kind)),
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
