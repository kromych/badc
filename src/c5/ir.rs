//! Per-function SSA IR.
//!
//! The shape consumed by the linear-scan allocator
//! ([`super::codegen::ssa_alloc::allocate`]) and the per-arch SSA
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
    /// Address of a local or parameter slot relative to the
    /// frame pointer. N is the c5-slot index; locals are
    /// negative, params >= 2.
    LocalAddr(i64),
    /// Address of a thread-local variable in the per-target TLS
    /// block.
    TlsAddr(i64),
    /// Load from memory. Width / signedness driven by the source
    /// load op.
    Load { addr: ValueId, kind: LoadKind },
    /// Store to memory. The c5 semantics leave the stored value
    /// in the accumulator afterward; downstream uses of this
    /// instruction's id read that value.
    Store {
        addr: ValueId,
        value: ValueId,
        kind: StoreKind,
    },
    /// Load from a local / parameter slot. Equivalent to a
    /// `LocalAddr(off)` followed by `Load { kind }`, but
    /// represented as a single instruction so the per-arch emit
    /// folds the address into the load's addressing mode and
    /// the allocator does not need to assign a register to the
    /// intermediate address.
    LoadLocal { off: i64, kind: LoadKind },
    /// Store to a local / parameter slot. Same shape as
    /// [`Self::Store`] but with the address represented as a
    /// constant slot offset, so the emit folds it into the
    /// store's addressing mode.
    StoreLocal {
        off: i64,
        value: ValueId,
        kind: StoreKind,
    },
    /// Load from `base + index * scale`. Folded form of
    /// `Add(base, Mul/Shl(index, scale))` followed by a `Load`,
    /// emitted as a single scaled-indexed memory instruction
    /// (`ldr Wt, [Xn, Xm, lsl #log2(scale)]` on aarch64, scaled
    /// SIB on x86_64). `scale` is in bytes and matches the
    /// natural width of `kind` (1 for I8/U8, 2 for I16/U16, 4 for
    /// I32/U32, 8 for I64).
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
    /// Sign-extend the low bytes of `value` to 64 bits, as a load of
    /// `kind` would after reading them from memory (C99 6.3.1.3). The
    /// width comes from `kind`, which is one of the signed narrow load
    /// kinds (`I8`, `I16`, `I32`). Produced when promotion lifts a
    /// signed narrow local slot whose frame round-trip performed the
    /// sign extension.
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
    },
    /// Indirect call: the target's address comes from `target`
    /// (typically the loaded value of a function pointer). Args
    /// flow through the same planner.
    CallIndirect { target: ValueId, args: Vec<ValueId> },
    /// External library call.
    CallExt {
        binding_idx: i64,
        args: Vec<ValueId>,
        fp_arg_mask: u32,
    },
    /// Tail-jump to an external symbol. Used only as the body
    /// of an address-take trampoline; never has a defined value
    /// (control transfers out).
    TailExt(i64),
    /// Whole-struct memory copy.
    Mcpy {
        dst: ValueId,
        src: ValueId,
        size: i64,
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

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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
    /// the type width. The `ssa_rotate` pass folds the canonical
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

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) enum FpCastKind {
    /// Truncating f64 to i64.
    FpToInt,
    /// i64 to f64.
    IntToFp,
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
    /// Synthetic fall-through to a successor block. Preserved
    /// on the variant for object-file round-trips of SSA bodies
    /// that already carry it; new IR producers should use the
    /// explicit branch terminators instead.
    FallThrough(BlockId),
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
    /// should honour at every -O level. Parser plumbing for the
    /// keyword is pending; for now the field is set via the
    /// `BADC_FORCE_INLINE=name1,name2,...` env var so the path is
    /// testable without touching every decl-spec call site.
    pub is_inline: bool,
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
}
