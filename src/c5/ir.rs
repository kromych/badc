//! Per-function SSA IR.
//!
//! The shape consumed by the linear-scan allocator
//! ([`super::codegen::ssa::reg_alloc::allocate`]) and the per-arch SSA
//! emitters. Two producers:
//!
//!   * The AST walker ([`super::ast::walk::walk_function`]) -- the
//!     canonical source for every parser-produced function.
//!   * The direct construction API
//!     ([`super::ssa_build::SsaBuilder`]) -- used by
//!     `emit_sys_trampolines` and other parser-side synthesis.
//!
//! Variants mirror the per-arch native instruction set wherever a
//! single Inst lowers to a single instruction (one ldr per Load,
//! one str per Store, ...). Where multiple variants pack identical
//! payload but differ in semantic meaning (`Inst::Imm` vs
//! `ImmData` vs `ImmCode`), the discriminator names the
//! relocation kind the writer applies. The in-memory shape stays
//! stable across producers so the allocator and emitters need no
//! parallel paths.

#![allow(dead_code)]

use alloc::vec::Vec;

/// Index into a function's instruction list.
pub(crate) type ValueId = u32;
pub(crate) const NO_VALUE: ValueId = u32::MAX;

/// Index into a function's block list.
pub(crate) type BlockId = u32;

/// A single SSA instruction. Each variant carries enough operand
/// metadata for the per-arch lowering to emit native code
/// directly.
#[derive(Debug, Clone)]
pub(crate) enum Inst {
    /// Plain integer immediate with no data / code segment
    /// provenance. Lowering uses `load_imm64`.
    Imm(i64),
    /// Integer immediate whose operand is a data-segment byte
    /// offset. The per-arch lowering emits an `adrp + add`
    /// placeholder pair and records a `DataFixup` so the writer
    /// can patch the page-relative immediate against
    /// `__data + offset`.
    ImmData(i64),
    /// Integer immediate whose operand is a function-pointer
    /// literal (`CODE_BASE + target_ent_pc`). The per-arch
    /// lowering emits an `adrp + add` placeholder pair and
    /// records a pending func-fixup so the writer can patch
    /// against the callee's body offset.
    ImmCode(usize),
    /// Address of a dynamically-imported function, by binding
    /// index. The operand is the same `Symbol::val` binding index a
    /// `Terminator::CallExt` carries. The per-arch lowering emits an
    /// address-materialization placeholder (`lea` rip-relative on
    /// x86_64, `adrp + add` on aarch64) and records an address-of
    /// PLT-call fixup so the writer resolves it to the import's
    /// shared per-import stub (the same `jmp [GOT]` / `adrp+ldr+br`
    /// stub a call to the import reaches). Taking `&strcmp` therefore
    /// yields the stub address rather than a per-TU forwarding
    /// trampoline; the deduped stub forwards every register class
    /// unchanged so an FP-returning import stays correct.
    ImmExtCode(i64),
    /// Address of a basic block within the current function, as a
    /// code pointer (GCC labels-as-values, `&&label`). The per-arch
    /// lowering materializes the block's native address with a
    /// PC-relative placeholder resolved against `pc_to_native` once
    /// the block offsets are final. The value is only stored, loaded,
    /// compared, and used as the operand of `Terminator::GotoIndirect`.
    BlockAddr(BlockId),
    /// Address of a local or parameter slot relative to the
    /// frame pointer. N is the c5-slot index; locals are
    /// negative, params >= 2.
    LocalAddr(i64),
    /// Address of a thread-local variable in the per-target TLS
    /// block.
    TlsAddr(i64),
    /// Load from `addr + disp`. Width / signedness driven by the
    /// source load op. `disp` is a byte offset folded from a constant
    /// pointer addition (a struct field offset) into the addressing
    /// mode; it is zero for a plain dereference. `volatile` marks an
    /// access to a volatile-qualified object (C99 6.7.3p6): the load
    /// must be performed strictly per the abstract machine, so no pass
    /// may delete, duplicate, or forward it (5.1.2.3p2).
    Load {
        addr: ValueId,
        disp: i32,
        kind: LoadKind,
        volatile: bool,
    },
    /// Store to `addr + disp`. The c5 semantics leave the stored value
    /// in the accumulator afterward; downstream uses of this
    /// instruction's id read that value. `disp` is a byte offset folded
    /// from a constant pointer addition, zero for a plain dereference.
    /// `volatile` as for [`Self::Load`].
    Store {
        addr: ValueId,
        disp: i32,
        value: ValueId,
        kind: StoreKind,
        volatile: bool,
    },
    /// Load from a local / parameter slot. Equivalent to a
    /// `LocalAddr(off)` followed by `Load { kind }`, but
    /// represented as a single instruction so the per-arch emit
    /// folds the address into the load's addressing mode and
    /// the allocator does not need to assign a register to the
    /// intermediate address. `volatile` as for [`Self::Load`]; a
    /// slot with any volatile access also stays out of mem2reg
    /// promotion and slot coalescing.
    LoadLocal {
        off: i64,
        kind: LoadKind,
        volatile: bool,
    },
    /// Store to a local / parameter slot. Same shape as
    /// [`Self::Store`] but with the address represented as a
    /// constant slot offset, so the emit folds it into the
    /// store's addressing mode.
    StoreLocal {
        off: i64,
        value: ValueId,
        kind: StoreKind,
        volatile: bool,
    },
    /// Load from `base + index * scale`. Folded form of
    /// `Add(base, Mul/Shl(index, scale))` followed by a `Load`,
    /// emitted as a single scaled-indexed memory instruction
    /// (`ldr Wt, [Xn, Xm, lsl #log2(scale)]` on aarch64, scaled
    /// SIB on x86_64). `scale` is in bytes and matches the
    /// natural width of `kind` (1 for I8/U8, 2 for I16/U16, 4 for
    /// I32/U32, 8 for I64). Carries no volatile flag: `index_fold`
    /// leaves volatile accesses on the plain `Load` / `Store` forms.
    LoadIndexed {
        base: ValueId,
        index: ValueId,
        scale: u8,
        kind: LoadKind,
    },
    /// Store to `base + index * scale`. Companion to
    /// [`Self::LoadIndexed`].
    StoreIndexed {
        base: ValueId,
        index: ValueId,
        scale: u8,
        value: ValueId,
        kind: StoreKind,
    },
    /// Binary arithmetic / comparison / shift. `lhs` is the value
    /// that was on top of the c5 stack at the op; `rhs` is the
    /// current accumulator (matches `a = pop() <op> a` semantics).
    Binop {
        op: BinOp,
        lhs: ValueId,
        rhs: ValueId,
    },
    /// Same as `Binop` but `rhs` is a literal immediate.
    BinopI {
        op: BinOp,
        lhs: ValueId,
        rhs_imm: i64,
    },
    /// Unary floating-point negation.
    Fneg(ValueId),
    /// Fused multiply-add computed with a single rounding (C99 6.5p8,
    /// FP_CONTRACT). The value is
    /// `(neg_product ? -(a*b) : a*b) + (neg_addend ? -c : c)`. Produced
    /// by `fma` from an `fadd` / `fsub` whose single-use operand is
    /// an `fmul` of the same floating-point width; the result's width
    /// follows the contracted `fadd` / `fsub` (tracked in `f32_values`).
    /// The four sign combinations map to the host fmadd / fmsub /
    /// fnmadd / fnmsub family.
    Fma {
        a: ValueId,
        b: ValueId,
        c: ValueId,
        neg_product: bool,
        neg_addend: bool,
    },
    /// Sign-extend the low bytes of `value` to 64 bits: discard the
    /// bits above `kind`'s width and replicate the sign bit, the fused
    /// `trunc; sext` that lowers to one `sxtb`/`sxth`/`sxtw` (AArch64)
    /// or `movsx`/`movsxd` (x86-64). The width comes from `kind`, one
    /// of the signed narrow kinds (`I8`, `I16`, `I32`). Two origins,
    /// one operation:
    ///   * widening a signed narrow load (C99 6.3.1.3) -- promotion
    ///     lifts a narrow local slot whose frame round-trip sign
    ///     extended, or a load feeds a 64-bit use;
    ///   * renormalizing a signed integer result to its declared
    ///     width after a 64-bit computation (C99 6.5p5) -- equivalent
    ///     to the `Shl K; Shr K` pair the builder folds here.
    Extend { value: ValueId, kind: LoadKind },
    /// Floating-point <-> integer cast.
    FpCast { kind: FpCastKind, value: ValueId },
    /// Direct call to a c5 user function at ent_pc `target_pc`.
    /// The call site marshals `args` per the host ABI; the per-arch
    /// emit picks per-arg placements. The instruction's defined
    /// value is the call's return slot.
    Call {
        target_pc: usize,
        args: Vec<ValueId>,
        /// Count of named (fixed) parameters the callee declares.
        /// For a variadic callee this is the prototype's
        /// pre-ellipsis parameter count; `args[fixed_args..]` are
        /// the variadic arguments. For a non-variadic callee it
        /// equals `args.len()`. The per-arch emit feeds it to
        /// `plan_call_args` so a host variadic ABI (macOS arm64:
        /// AAPCS64 6.4.1 for the named args, all-stack at 8-byte
        /// stride for the variadic tail) places the variadic
        /// arguments correctly.
        fixed_args: usize,
        /// True when the callee's return type is a floating-point
        /// scalar (C99 6.2.5p10). The return value lives in the FP
        /// return register (xmm0 / d0), so the call's result is
        /// FP-classed and read from there.
        fp_return: bool,
        /// Per-argument FP-ness mask: bit `i` set when argument `i`
        /// is a floating-point scalar passed in an FP argument
        /// register (System V AMD64 3.2.3 / AAPCS64 6.4.1). Derived
        /// from the argument's C type, not its register placement: a
        /// floating-point constant rides an integer register as its
        /// `Imm` bit pattern, so the placement alone cannot classify
        /// it. The per-arch emit feeds this to `plan_call_args`.
        fp_arg_mask: u32,
        /// Host-ABI aggregate metadata. Parallel to `args`:
        /// `arg_aggs[k] = Some(i)` marks `args[k]` as the address of
        /// an aggregate laid out by the function's `agg_descs[i]`,
        /// passed by value per the host ABI; `None` is a scalar arg.
        /// Empty (treated as all-`None`) for a scalar-only call.
        arg_aggs: Vec<Option<u32>>,
        /// `Some(i)` when the callee returns the aggregate
        /// `agg_descs[i]` by value; `None` for scalar / void.
        ret_agg: Option<u32>,
        /// Negative frame slot of the caller-allocated result
        /// temporary an aggregate return materialises into. A frame
        /// slot rather than a `ValueId` so it survives value
        /// renumbering. `0` unless `ret_agg` is set.
        ret_slot_local: i64,
    },
    /// Indirect call: the target's address comes from `target`
    /// (typically the loaded value of a function pointer). Args
    /// flow through the same planner.
    CallIndirect {
        target: ValueId,
        args: Vec<ValueId>,
        /// True when the pointed-to function's prototype is variadic.
        /// The walker reads it off the callee fn-pointer's declared
        /// type; an unprototyped or non-statically-typed callee
        /// defaults to false. Drives the per-arch emit's choice of
        /// the host variadic ABI vs the c5 cdecl stack-push shape.
        callee_variadic: bool,
        /// Named (fixed) parameter count of the pointed-to function;
        /// see [`Self::Call::fixed_args`]. Equals `args.len()` unless
        /// `callee_variadic`.
        fixed_args: usize,
        /// See [`Self::Call::fp_return`].
        fp_return: bool,
        /// See [`Self::Call::fp_arg_mask`].
        fp_arg_mask: u32,
        /// See [`Self::Call::arg_aggs`].
        arg_aggs: Vec<Option<u32>>,
        /// See [`Self::Call::ret_agg`].
        ret_agg: Option<u32>,
        /// See [`Self::Call::ret_slot_local`].
        ret_slot_local: i64,
    },
    /// External library call.
    CallExt {
        binding_idx: i64,
        args: Vec<ValueId>,
        fp_arg_mask: u32,
        /// True when the callee returns a floating-point scalar, so the
        /// result is delivered in the FP return register (d0 / xmm0) and
        /// the value is FP-classed. Mirrors [`Self::Call::fp_return`];
        /// without it an FP libc result is force-bridged through a GPR.
        fp_return: bool,
        /// Per-argument aggregate tags, as for [`Self::Call::arg_aggs`]:
        /// `arg_aggs[k] = Some(i)` marks `args[k]` as the address of a
        /// by-value struct laid out by `agg_descs[i]`, so the emitter packs
        /// its bytes into the platform-ABI argument registers. Empty for the
        /// common scalar-only libc call.
        arg_aggs: Vec<Option<u32>>,
        /// Host-ABI by-value struct return, as for [`Self::Call::ret_agg`]:
        /// `Some(i)` marks the callee as returning `agg_descs[i]` by value in
        /// the platform return registers, gathered into the result temp at
        /// `ret_slot_local`. `None` for a scalar / void return.
        ret_agg: Option<u32>,
        /// Frame slot of the aggregate-return result temp. `0` unless
        /// `ret_agg` is set.
        ret_slot_local: i64,
    },
    /// Tail-jump to an external symbol. Used only as the body
    /// of an address-take trampoline; never has a defined value
    /// (control transfers out).
    TailExt(i64),
    /// Whole-struct memory copy.
    /// TODO: carries no volatile flag; a copy of a volatile-qualified
    /// aggregate (C99 6.7.3p6) is not marked. Scalar volatile
    /// accesses ride `Load` / `Store`, which cover the defined uses.
    Mcpy {
        dst: ValueId,
        src: ValueId,
        size: i64,
    },
    /// Atomic read-modify-write on the `width`-byte object at `addr`
    /// (C11 7.17.7.2-7.17.7.5). `op` selects the operator; the operand
    /// is `value`. The defined value is the object's prior contents
    /// (C11 7.17.7p2). The per-arch lowering emits a genuine atomic
    /// sequence (Intel SDM Vol.2 LOCK XADD / XCHG / CMPXCHG retry on
    /// x86_64; ARM ARM LDAXR / STLXR retry on aarch64).
    AtomicRmw {
        op: AtomicRmwOp,
        addr: ValueId,
        value: ValueId,
        width: u8,
    },
    /// Atomic compare-and-exchange on the `width`-byte object at `addr`
    /// (C11 7.17.7.4). Compares `*addr` against `*expected_addr`; on a
    /// match stores `desired` and yields 1, otherwise stores the
    /// current `*addr` into `*expected_addr` and yields 0. Lowered to
    /// LOCK CMPXCHG on x86_64 and an LDAXR / STLXR retry on aarch64.
    AtomicCas {
        addr: ValueId,
        expected_addr: ValueId,
        desired: ValueId,
        width: u8,
    },
    /// Compiler-builtin intrinsic. The discriminant is the
    /// `Intrinsic` enum value. Single-arg intrinsics carry one
    /// element in `args`; two-arg intrinsics (longjmp, va_start,
    /// va_copy) carry two elements with `args[0]` the pushed
    /// first arg and `args[1]` the accumulator-resident second
    /// arg. Most intrinsics return a value (alloca's new pointer,
    /// setjmp's 0-on-initial-call); longjmp does not return at
    /// all.
    Intrinsic { kind: i64, args: Vec<ValueId> },
    /// GCC extended inline asm with operands (`asm(template : outputs :
    /// inputs : clobbers)`). `asm` carries the template, per-operand
    /// constraints, and clobbers; `args` is parallel to `asm.operands`
    /// and holds each operand's SSA value -- the destination address for
    /// an output, the value for an input. Every arg is a read for
    /// liveness; the instruction defines no SSA value (outputs are
    /// stored through their addresses). The per-arch lowering assigns a
    /// machine register to each register operand per its constraint,
    /// loads the inputs, encodes the register-concrete template, and
    /// stores the outputs back through their addresses.
    InlineAsm {
        asm: alloc::boxed::Box<AsmBlock>,
        args: Vec<ValueId>,
    },
    /// Per-frame alloca arena bookkeeping setup. Slot index is
    /// the alloca-top FP-slot offset. Produces no SSA value;
    /// emitted purely for the side effect.
    AllocaInit(i64),
    /// The i-th declared parameter's incoming value, tagged with
    /// the parameter's natural load width. The walker emits one
    /// per non-relocated integer parameter on a non-variadic,
    /// non-struct-returning function so mem2reg sees a reaching
    /// store to the c5 cdecl arg slot. The per-arch emit moves
    /// the incoming argument register into the allocator's
    /// chosen `Place` (x0..x7 on AAPCS64; rdi rsi rdx rcx r8 r9 on
    /// System V x86_64; rcx rdx r8 r9 on Win64), sign-extending
    /// the low `kind` bytes to 64 bits for narrow integer kinds
    /// so the value held in the register is canonically
    /// sign-extended per C99 6.3.1.3. Downstream `Inst::Extend`
    /// sites that mem2reg inserts for the LoadLocal -> Extend
    /// rewrite then collapse to a plain copy when their kind
    /// matches the ParamRef's kind.
    ParamRef { idx: u32, kind: LoadKind },
    /// SSA phi: at a join block where a promoted slot has more
    /// than one reaching definition, mem2reg synthesises one of
    /// these per slot to merge the predecessors' incoming
    /// values. `incoming` records one `(predecessor_block,
    /// reaching_value)` pair per predecessor in the same order
    /// as `Block::predecessors()` so the per-arch emit's
    /// predecessor-exit `mov phi_dst, source` lookup is
    /// positional. `kind` records the merged value's width so
    /// the allocator can pick the integer-vs-FP bank. The
    /// IR-position emit is a no-op: by the time control reaches
    /// the phi position the value is already in the phi's
    /// allocated `Place`, placed there by a `mov` emitted at
    /// each predecessor block's terminator. C99 6.9.1p11
    /// (parameters are modifiable lvalues) and the underlying
    /// SSA construction (Cytron et al.) justify the
    /// representation; the same shape covers any multiply-
    /// assigned scalar local.
    Phi {
        incoming: Vec<(BlockId, ValueId)>,
        kind: LoadKind,
    },
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) enum LoadKind {
    /// 8-byte signed integer.
    I64,
    /// 1-byte unsigned char, zero-extended.
    U8,
    /// 1-byte signed char, sign-extended.
    I8,
    /// 4-byte signed int, sign-extended.
    I32,
    /// 4-byte unsigned int, zero-extended.
    U32,
    /// 2-byte signed short, sign-extended.
    I16,
    /// 2-byte unsigned short, zero-extended.
    U16,
    /// 4-byte float widened to f64.
    F32,
    /// 8-byte double held in an FP register; loaded with a single
    /// FP move (no widen/narrow).
    F64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum StoreKind {
    /// 8-byte integer.
    I64,
    /// 1-byte char.
    I8,
    /// 4-byte int.
    I32,
    /// 2-byte short.
    I16,
    /// 4-byte float (narrowed from f64).
    F32,
    /// 8-byte double held in an FP register; stored with a single
    /// FP move (no widen/narrow).
    F64,
}

/// Integer / FP binary opcode. The planner's choice between
/// signed / unsigned forms is preserved (Div vs Divu, Shr vs
/// Shru).
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) enum BinOp {
    Or,
    Xor,
    And,
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
    Ult,
    Ugt,
    Ule,
    Uge,
    Shl,
    Shr,
    Shru,
    /// Bit-rotate right: `(x >> c) | (x << (W - c))` where W is
    /// the type width. The `rotate` pass folds the canonical
    /// shift / OR shape to this opcode so x86_64's `ror` and
    /// aarch64's `ror` lower to a single instruction.
    Ror,
    Add,
    Sub,
    Mul,
    Div,
    Mod,
    Divu,
    Modu,
    Fadd,
    Fsub,
    Fmul,
    Fdiv,
    Feq,
    Fne,
    Flt,
    Fgt,
    Fle,
    Fge,
}

/// Operator for an atomic read-modify-write (C11 7.17.7.2-7.17.7.5).
/// `Xchg` discards the prior contents in the new value; the others
/// combine the prior contents with the operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) enum AtomicRmwOp {
    Xchg,
    Add,
    Sub,
    And,
    Or,
    Xor,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) enum FpCastKind {
    /// Truncating f64 to signed i64.
    FpToInt,
    /// Truncating f64 to unsigned u64. A separate kind because a
    /// double in [2^63, 2^64) exceeds the signed range, where the
    /// signed truncate instruction saturates to the integer
    /// indefinite (C99 6.3.1.4). x86_64 SSE2 `cvttsd2si` is signed
    /// only, so the lowering subtracts 2^63 when the value is at or
    /// above it, truncates, and sets bit 63; aarch64 uses `FCVTZU`.
    UFpToInt,
    /// Signed i64 to f64.
    IntToFp,
    /// Unsigned u64 to f64. A separate kind because the unsigned
    /// value can exceed the signed 64-bit range, where the signed
    /// convert would produce a negative result (C99 6.3.1.4). x86_64
    /// SSE2 has no unsigned convert before AVX512, so the lowering
    /// tests the high bit and halves/doubles; aarch64 uses `UCVTF`.
    UIntToFp,
    /// Widen f32 to f64 (C99 6.3.1.5). The single-precision source
    /// value is converted to double; the result is f64. Emitted at a
    /// `float` operand mixed with a `double` operand, an explicit
    /// `(double)f` cast, and the variadic / default-argument
    /// promotion of `float` to `double` (6.5.2.2p6).
    F32ToF64,
    /// Narrow f64 to f32 (C99 6.3.1.5). The double source value is
    /// rounded to single precision; the result is f32. Emitted at an
    /// explicit `(float)d` cast and an assignment / return converting
    /// a `double` value to a `float` object.
    F64ToF32,
}

/// Register-name size for an inline-asm template `%`-reference, from a
/// GCC operand-size modifier (`%b`/`%w`/`%k`/`%q` -> byte/word/long/quad
/// sub-register name). Absent modifier defaults to the operand's width.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmRegSize {
    Byte,
    Word,
    Long,
    Quad,
}

impl AsmRegSize {
    pub(crate) fn from_width(width: u8) -> AsmRegSize {
        match width {
            1 => AsmRegSize::Byte,
            2 => AsmRegSize::Word,
            4 => AsmRegSize::Long,
            _ => AsmRegSize::Quad,
        }
    }
    pub(crate) fn bytes(self) -> u8 {
        match self {
            AsmRegSize::Byte => 1,
            AsmRegSize::Word => 2,
            AsmRegSize::Long => 4,
            AsmRegSize::Quad => 8,
        }
    }
}

/// Constraint on one GCC extended-asm operand (x86_64 register classes).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmConstraint {
    /// Any allocatable general register (`r`, or the register arm of
    /// `rm`/`g`).
    Reg,
    /// Any allocatable SIMD/FP register (AArch64 `w`): the operand value is
    /// held in a `d`/`s` register and `%N` resolves to it.
    Fp,
    /// A specific general register named by a class letter (`a`->rax,
    /// `b`->rbx, `c`->rcx, `d`->rdx, `S`->rsi, `D`->rdi); the value is
    /// the architectural register number.
    Fixed(u8),
    /// Matching constraint (`"0".."9"`): shares the register assigned to
    /// the operand at that index (an earlier output).
    Match(u8),
    /// Immediate-or-register (`ci`): a compile-time-constant operand is
    /// used as an immediate, otherwise the value is loaded into the
    /// register of the given class.
    RegOrImm(u8),
    /// Immediate-only (`i`, `n`).
    Imm,
    /// A memory operand (`m`, `=m`, `+m`): the operand argument is the
    /// object's address, and the template `%N` is a memory reference
    /// through it (not a register). Assigned a register to hold the
    /// address; the instruction dereferences that register.
    Mem,
}

/// One operand of a GCC extended-asm statement.
#[derive(Debug, Clone, Copy)]
pub(crate) struct AsmOperand {
    pub constraint: AsmConstraint,
    /// `=`/`+` output: the operand argument is the destination address.
    pub is_output: bool,
    /// `+` read-write output: the current value is loaded into the
    /// operand register before the instruction and stored after.
    pub is_rw: bool,
    /// Operand access width in bytes (from the C operand type). Drives
    /// the default register-name size of a `%N` reference and the width
    /// of the load / store through an output address.
    pub width: u8,
}

/// A parsed GCC extended-asm statement (`asm(template : outputs :
/// inputs : clobbers)`). The template's `%N` / `%<size>N` references
/// are substituted with the operands' assigned registers at emit time.
#[derive(Debug, Clone)]
pub(crate) struct AsmBlock {
    /// Template bytes, adjacent-literal concatenation already resolved.
    pub template: Vec<u8>,
    /// Operands in `%N` numbering order (outputs first, then inputs).
    pub operands: Vec<AsmOperand>,
    /// Registers preserved across the statement (explicit clobbers plus
    /// the operand registers), as a bitmask over register numbers 0..15.
    pub clobber_regs: u32,
    /// SIMD/FP registers named in the clobber list, as a bitmask over the FP
    /// register file (independent of `clobber_regs`). Empty for x86 targets,
    /// whose FP clobbers ride the shared mask.
    pub clobber_fp_regs: u32,
    /// A `"memory"` clobber was listed: an ordering barrier for memory
    /// accesses (C practice for `asm volatile("" ::: "memory")`).
    pub clobber_memory: bool,
    /// The statement carried the `volatile` qualifier.
    pub volatile: bool,
}

/// A basic block's terminator. Drives the block's control-flow
/// successor edges.
#[derive(Debug, Clone, Copy)]
pub(crate) enum Terminator {
    /// Unconditional branch to `target_block`.
    Jmp(BlockId),
    /// Conditional branch: if `cond` (the block's exit
    /// accumulator) is zero, jump to `target`; otherwise fall
    /// through to `fall_through`.
    Bz {
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    },
    /// Conditional branch: if `cond` is non-zero, jump to
    /// `target`; otherwise fall through.
    Bnz {
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    },
    /// Return the accumulator value. The per-arch lowering moves
    /// `value` into the host's int / FP return register.
    Return(ValueId),
    /// Tail-jump to a libc symbol. The trampoline shape doesn't
    /// return through here.
    TailExt(i64),
    /// Indirect branch to a code address held in `target` (GCC
    /// computed goto, `goto *expr`). The set of possible successor
    /// blocks is the function's `computed_goto_targets` (every block
    /// whose address is taken via `&&label`); the CFG treats this as
    /// a branch to all of them.
    GotoIndirect { target: ValueId },
    /// Indexed branch through a per-function jump table: control
    /// transfers to `jump_tables[table][idx]`. The switch lowering
    /// proves `idx` in range with an unsigned bounds check before
    /// this terminator, so no entry is out of bounds at runtime.
    /// The target list lives in [`FunctionSsa::jump_tables`]
    /// because `Terminator` is `Copy`.
    JumpTable { idx: ValueId, table: u32 },
    /// Synthetic fall-through to a successor block. Preserved
    /// on the variant for object-file round-trips of SSA bodies
    /// that already carry it; new IR producers should use the
    /// explicit branch terminators instead.
    FallThrough(BlockId),
    /// Control cannot reach here: the block's last real instruction
    /// diverges (a call to a `_Noreturn` function, C11 6.7.4p8). The
    /// block has no successor and yields no value; the per-arch
    /// lowering emits a trap so a mis-marked non-returning call faults
    /// rather than falling into the next block.
    Unreachable,
}

/// A single basic block of SSA instructions plus its terminator.
#[derive(Debug, Clone)]
pub(crate) struct Block {
    /// PC identifier of the block's first instruction. Useful
    /// for debug output and for the `pc_to_native` map the
    /// per-arch lowering builds.
    pub start_pc: usize,
    /// Instructions in execution order. Each entry's index within
    /// the function's flat `insts` list is its [`ValueId`]; the
    /// allocator and the per-arch lowering consume them in this
    /// order.
    pub inst_range: core::ops::Range<u32>,
    pub terminator: Terminator,
    /// Accumulator value at the end of the block (before the
    /// terminator's branch). For a `Return` block this is the
    /// returned value. `NO_VALUE` if the accumulator wasn't
    /// written in this block (rare; e.g. a block consisting of
    /// just an unconditional branch to a synthetic target).
    pub exit_acc: ValueId,
}

/// Layout of an aggregate (struct / union) value for host-ABI
/// argument / return classification. Interned per function in
/// [`FunctionSsa::agg_descs`] and referenced by index from the call
/// instructions' `arg_aggs` / `ret_agg` and the function's own
/// `param_aggs` / `ret_agg`. Built by the walker via
/// `Compiler::flatten_fields`; the per-arch emit feeds
/// `(size, align, fields)` to `abi_classify::classify_aggregate`.
#[derive(Debug, Clone)]
pub(crate) struct AggDesc {
    pub size: u32,
    pub align: u32,
    pub fields: Vec<crate::c5::codegen::abi_classify::FlatField>,
}

/// Per-function SSA program. Consumed by the allocator and the
/// per-arch lowering.
#[derive(Debug, Clone, Default)]
pub(crate) struct FunctionSsa {
    /// Source-level function name. Empty for SSA functions built
    /// outside the parser (test fixtures, archive-reloaded units
    /// whose name field didn't round-trip yet). Codegen consumers
    /// use it as the canonical name for symbol-table and DWARF
    /// emission; fall back to a synthesized `fn_<ent_pc>` when
    /// empty.
    pub name: alloc::string::String,
    /// Function-entry PC in the parser's PC space; the per-arch
    /// `pc_to_native` table maps it to the native byte offset.
    pub ent_pc: usize,
    /// PC one past the function's last op (the start of
    /// whatever follows).
    pub end_pc: usize,
    /// Local-slot count for the function frame. Set by the
    /// producer; consumed by the per-arch frame layout.
    pub locals: i64,
    /// Declared parameter count.
    pub n_params: usize,
    /// True if the function's declarator ended in `...`.
    pub is_variadic: bool,
    /// True if the source declarator carried an `inline` /
    /// `__inline` / `__inline__` function specifier (C99 6.7.4) or
    /// `__attribute__((always_inline))`. The inliner bypasses the
    /// `--inline-cap=N` body-size gate for these, matching the
    /// gcc / clang policy that `inline` is a hint the optimiser
    /// should honour at every -O level. The `codegen_test`-only
    /// `BADC_FORCE_INLINE=name1,name2,...` env var sets this field for
    /// named functions so the path is testable.
    /// TODO: set this from the parsed `inline` function specifier.
    pub is_inline: bool,
    /// True if the function carried a *mandatory* inline request --
    /// `__attribute__((always_inline))` or MSVC `__forceinline` -- as
    /// opposed to the plain `inline` hint. Implies `is_inline`. The
    /// inliner warns when it cannot honour the request, matching the
    /// gcc / MSVC diagnostic; a plain `inline` that stays out of line is
    /// silent (it is only a hint).
    pub is_always_inline: bool,
    /// True if the function carried `__attribute__((naked))`: emit no
    /// prologue/epilogue and no implicit return; the body (inline asm) is the
    /// function's entire machine code. Used for interrupt service routines.
    pub is_naked: bool,
    /// Flat list of all SSA instructions in the function, indexed
    /// by [`ValueId`]. Each [`Block::inst_range`] is a contiguous
    /// slice of this list.
    pub insts: Vec<Inst>,
    /// Source position per `Inst`, parallel to `insts`. `(line,
    /// file_idx)` -- file_idx is an index into
    /// `Program::source_files`. `(0, 0)` means "no source
    /// information"; the DWARF line table skips those rows. Filled
    /// in by the walker as it lowers AST nodes; empty for SSA
    /// produced outside the walker (sys-trampolines, archive
    /// reloads).
    pub inst_src: Vec<(u32, u32)>,
    /// Basic blocks in source / execution order. Block 0 is the
    /// entry block.
    pub blocks: Vec<Block>,
    /// Per-Inst extern symbol references: `(inst_idx, sym_idx)`
    /// pairs where `sym_idx` is the parser-symbol index (into the
    /// unit's `parser_symbols`) for an `Inst::Call::target_pc`
    /// whose target lives in another translation unit. The walker
    /// records the sym at parse time; the linker resolves each
    /// pair after merging through the unit's `sym_remap` so
    /// `Inst::Call::target_pc` lands on the defining unit's
    /// `ent_pc`. Empty for functions built outside the walker.
    pub extern_call_refs: Vec<(u32, u32)>,
    /// Per-Inst extern symbol references for `Inst::ImmCode(pc)`.
    /// Same shape as `extern_call_refs`; the linker resolves the
    /// referenced sym to a `SymbolKind::Function`'s merged ent_pc.
    pub extern_imm_code_refs: Vec<(u32, u32)>,
    /// Per-Inst extern symbol references for `Inst::ImmData(off)`.
    /// Same shape as `extern_call_refs`; the linker resolves the
    /// referenced sym to a `SymbolKind::Data`'s merged data
    /// offset.
    pub extern_imm_data_refs: Vec<(u32, u32)>,
    /// Per-Inst extern symbol references for `Inst::TlsAddr(off)`.
    /// Same shape as `extern_call_refs`; the linker resolves the
    /// referenced sym to a `SymbolKind::TlsData`'s merged TLS
    /// offset.
    pub extern_tls_refs: Vec<(u32, u32)>,
    /// Per-Inst single-precision marker, parallel to `insts`. `true`
    /// when the value's FP register holds an `f32` (single) pattern in
    /// its low 32 bits rather than an `f64` (double). C99 6.3.1.8 does
    /// not promote `float` operands to `double` for the usual
    /// arithmetic conversions: `float op float` has type `float` and is
    /// computed in single precision. The per-arch emit consults this
    /// table to pick the single- vs double-precision encoder for FP
    /// binops, `Fneg`, and FP comparisons, and to reinterpret an
    /// f32-typed `Imm` constant through a 32-bit `fmov` / `movd`.
    /// Empty (treated as all-false) for SSA built outside the walker.
    pub f32_values: Vec<bool>,
    /// Per-parameter floating-point mask: bit `i` set when declared
    /// parameter `i` is a floating-point scalar passed in an FP
    /// argument register (C99 6.2.5p10). The callee resolves each
    /// parameter's incoming register by running the same
    /// `plan_call_args` the caller uses, so an interleaved int / FP
    /// parameter list assigns int and FP registers from independent
    /// banks rather than by absolute parameter index. Only the low 32
    /// parameters are tracked; parameters past the argument registers
    /// ride the stack where the class no longer selects a register.
    /// Zero for SSA built outside the walker.
    pub param_fp_mask: u32,
    /// Interned aggregate layouts referenced by the call
    /// instructions' `arg_aggs` / `ret_agg` and this function's
    /// `param_aggs` / `ret_agg`. Empty for SSA built outside the
    /// walker and for functions that neither pass nor return a
    /// struct by value through the host ABI. Passes that rebuild the
    /// function copy this through; the inliner concatenates the
    /// inlinee's table and offsets the inlined call indices.
    pub agg_descs: Vec<AggDesc>,
    /// Per declared parameter: `Some(i)` when parameter `k` is an
    /// aggregate passed by value (described by `agg_descs[i]`).
    /// Empty / all-`None` for functions with no struct parameters.
    pub param_aggs: Vec<Option<u32>>,
    /// Per declared parameter: the negative frame slot the parser
    /// reserved for a struct-by-value parameter's body-visible
    /// storage, or 0 when the parameter has no dedicated local.
    /// A register-passed aggregate parameter has no SSA entry-copy;
    /// the callee prologue (native) and `run_func` (VM) write the
    /// argument's bytes directly into this slot. Parallel to the
    /// declared parameter list; empty for SSA built outside the
    /// walker.
    pub param_local_slots: Vec<i64>,
    /// `Some(i)` when this function returns the aggregate
    /// `agg_descs[i]` by value through the host ABI; `None` for a
    /// scalar / void return.
    pub ret_agg: Option<u32>,
    /// True when the function returns a floating-point scalar (C99
    /// 6.2.5p10): the result is delivered in the FP return register
    /// (d0 / xmm0). This is the declared-type signal the return emit
    /// uses; a producing instruction's register file alone is
    /// insufficient because a bare FP constant materializes as an
    /// integer immediate in a GPR.
    pub ret_is_fp: bool,
    /// Declared return type tag (`Ty` encoding, unsigned bit OR'd in;
    /// 0 when not recorded). A function's epilogue extends a sub-word
    /// integer return to 64 bits per this type, and a caller reading
    /// the accumulator relies on that; the emit-time tail-call
    /// conversion compares the caller's and callee's recipes and
    /// keeps the regular call-then-extend path when they differ.
    pub ret_type_tag: i64,
    /// Negative frame slot holding the caller-supplied indirect-result
    /// address (AAPCS64 x8) for a function returning an aggregate
    /// larger than 16 bytes. The prologue stores x8 here; the callee
    /// writes the result through it. `0` when the function does not
    /// return through x8.
    pub indirect_result_slot: i64,
    /// Successor blocks of every `Terminator::GotoIndirect` in this
    /// function: each block whose address is taken via `&&label`
    /// (GCC computed goto). The CFG, liveness, and the allocator
    /// treat an indirect branch as a branch to all of these. Empty
    /// for functions with no computed goto.
    pub computed_goto_targets: Vec<BlockId>,
    /// Target-block lists for the function's `Terminator::JumpTable`
    /// terminators, keyed by the terminator's `table` index. Entry
    /// `i` is the successor for a runtime index of `i`; blocks may
    /// repeat (case-value holes point at the default block). Empty
    /// for functions with no jump table.
    pub jump_tables: Vec<Vec<BlockId>>,
    /// Boundary between the parser's declared local slots and the SSA
    /// builder's synthetic slots. `set_locals` records the declared-
    /// plus-alloca count here; every slot reserved afterward by
    /// `alloc_synthetic_local` / `alloc_synthetic_struct` has an offset
    /// magnitude greater than this. The declared/synthetic boundary:
    /// `ssa_slot_coalesce` confines itself to the synthetic range when
    /// debug info is emitted (preserving per-local `DW_OP_fbreg`
    /// locations); without debug info it coalesces the declared range
    /// too. 0 for SSA built outside the walker, which disables coalescing.
    pub synthetic_base: i64,
    /// `(base_offset, cells)` for each multi-cell slot group -- a declared
    /// aggregate / multi-cell scalar (seeded from the parser) or a synthetic
    /// aggregate (`alloc_synthetic_struct`). The group occupies `base_offset
    /// ..= base_offset + cells - 1` (base is the lowest address). Declared
    /// groups may overlap a reused slot across disjoint scopes.
    /// `ssa_slot_coalesce` reserves these so a coalesced scalar never lands on
    /// an interior cell, which is referenced by no instruction. Empty for SSA
    /// built outside the walker.
    pub multi_cell_slots: Vec<(i64, i64)>,
    /// True when the body calls a function that may return twice into
    /// this frame: the setjmp family (C99 7.13) or vfork(2). Ordinary
    /// liveness under-approximates storage lifetime here -- a value
    /// dead on the first-return path is still read after the second
    /// return (C99 7.13.2.1p3), and under vfork the child's writes
    /// land on the parent's stack. Spill-slot sharing and frame-slot
    /// coalescing are disabled when set, and the inliner keeps such a
    /// body out of line.
    pub has_returns_twice_call: bool,
    /// True once `passes::unroll` fully expanded at least one loop in this
    /// function. Set by the unroll pass; read by the post-inline scalar
    /// promotion (`passes::sroa`) to gate its mem2reg re-run to functions
    /// whose constant-trip loops turned array subscripts into constant
    /// offsets. False for every function the unroll pass left unchanged.
    pub did_unroll: bool,
}

/// External functions that may return twice into the caller's frame:
/// the setjmp family (C99 7.13.1.1) plus vfork(2). Matched on the
/// c5-side symbol name; `__c5_msvcrt_setjmp` is the target of the
/// Windows x86_64 `setjmp` macro (libc/include/setjmp.h). The
/// AArch64 inline setjmp is an intrinsic, recognised structurally by
/// `codegen::ssa::reg_alloc::is_setjmp_barrier`.
pub(crate) fn returns_twice_fn_name(name: &str) -> bool {
    matches!(
        name,
        "setjmp" | "_setjmp" | "sigsetjmp" | "__sigsetjmp" | "__c5_msvcrt_setjmp" | "vfork"
    )
}
