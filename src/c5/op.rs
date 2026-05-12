/// Virtual Machine Operations (Opcodes)
/// These represent the low-level instructions executed by the VM.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Op {
    /// Load Effective Address: Calculates address of a local variable.
    Lea = 0x7f00_0000_0000_0001,
    /// Load Immediate: Loads a constant value into the accumulator.
    Imm,
    /// Jump: Unconditional jump to a specific text address.
    Jmp,
    /// Jump to Subroutine: Pushes return address and jumps.
    Jsr,
    /// Jump to Subroutine indirect.
    Jsri,
    /// Branch if Zero: Jumps if the accumulator is 0.
    Bz,
    /// Branch if Not Zero: Jumps if the accumulator is not 0.
    Bnz,
    /// Enter Subroutine: Sets up the stack frame for a new function.
    Ent,
    /// Adjust Stack: Cleans up arguments from the stack after a call.
    Adj,
    /// Leave Subroutine: Restores previous stack frame and returns.
    Lev,
    /// Load Integer: Loads an i64 from the address in the accumulator.
    Li,
    /// Load Character: Loads a u8 from the address in the accumulator,
    /// zero-extending into the 64-bit accumulator. Used for bare
    /// `char` (which c5 treats as unsigned) and `unsigned char`.
    Lc,
    /// Load Character Signed: Loads an i8 from the address in the
    /// accumulator, sign-extending into the 64-bit accumulator. Used
    /// for `signed char` lvalue reads -- C signed-char semantics
    /// require the high bit to propagate so that values outside
    /// [0, 127] stay negative.
    Lcs,
    /// Store Integer: Stores the accumulator into the address on top of stack.
    Si,
    /// Store Character: Stores the lower byte of accumulator into address on stack.
    Sc,
    /// Load Word: Loads a 32-bit signed value from the address in the
    /// accumulator, sign-extending into the 64-bit accumulator. Used
    /// for signed `int` lvalue reads where `int` is a 4-byte
    /// storage slot.
    Lw,
    /// Load Word Unsigned: Loads a 32-bit value from the address in
    /// the accumulator, zero-extending into the 64-bit accumulator.
    /// Used for `unsigned int` lvalue reads -- the high half must
    /// stay zero so that `(unsigned int)-1` compares correctly
    /// against `0xffffffff` and so that `1u - 2u` wraps to
    /// `0xffffffff` rather than reading back as signed -1.
    Lwu,
    /// Store Word: Stores the low 32 bits of the accumulator into the
    /// address on top of stack. Companion to [`Op::Lw`] / [`Op::Lwu`]
    /// for 4-byte int writes (signed and unsigned share the same
    /// store semantics; only the load differs).
    Sw,
    /// Load Half: Loads a 16-bit signed value from the address in
    /// the accumulator, sign-extending into the 64-bit accumulator.
    /// Used for `short` lvalue reads where `short` is a 2-byte
    /// storage slot. ARM64 `LDRSH`, x86_64 `MOVSX r64, m16`.
    Lh,
    /// Load Half Unsigned: Loads a 16-bit value from the address in
    /// the accumulator, zero-extending into the 64-bit accumulator.
    /// Used for `unsigned short` / `u16` reads and for explicit
    /// `*(u16*)p` packed-buffer reads. ARM64 `LDRH`, x86_64
    /// `MOVZX r64, m16`.
    Lhu,
    /// Store Half: Stores the low 16 bits of the accumulator into
    /// the address on top of stack. Companion to [`Op::Lh`] /
    /// [`Op::Lhu`] for 2-byte short writes (signed and unsigned
    /// share the same store; only the load differs).
    Sh,
    /// Push: Pushes the accumulator onto the stack.
    Psh,
    /// External library call. Followed by one operand: the index
    /// (into the program's flattened `#pragma binding(...)` table)
    /// of the binding to call. Args are already on the VM stack
    /// (in 16-byte slots, as for a regular `Jsri`); the trailing
    /// `Op::Adj N` after the call gives the runtime / lowering the
    /// arg count to drop.
    ///
    /// Replaces the old per-symbol `Op::Open` / `Op::Prtf` / ... set:
    /// the lexer no longer carries a fixed table of libc names,
    /// each header's `#pragma binding` fills the table dynamically,
    /// and a call site lowers the same way regardless of which
    /// dylib's symbol is on the other end.
    JsrExt,
    /// Bitwise OR
    Or,
    /// Bitwise XOR
    Xor,
    /// Bitwise AND
    And,
    /// Equality `==`
    Eq,
    /// Inequality `!=`
    Ne,
    /// Less Than `<` (signed)
    Lt,
    /// Greater Than `>` (signed)
    Gt,
    /// Less Than or Equal `<=` (signed)
    Le,
    /// Greater Than or Equal `>=` (signed)
    Ge,
    /// Less Than `<` (unsigned). Emitted whenever at least one
    /// operand of a relational compare has an unsigned integer type
    /// (`unsigned int`, `unsigned long`, typedefs onto u32/u64, etc.).
    /// Treats both operands as u64 -- the high-bit-set bit pattern
    /// is interpreted as a large positive, not a negative.
    Ult,
    /// Greater Than `>` (unsigned). See [`Op::Ult`].
    Ugt,
    /// Less Than or Equal `<=` (unsigned). See [`Op::Ult`].
    Ule,
    /// Greater Than or Equal `>=` (unsigned). See [`Op::Ult`].
    Uge,
    /// Shift Left `<<`
    Shl,
    /// Shift Right `>>` (arithmetic / sign-extending). Emitted when
    /// the LHS has a signed integer type.
    Shr,
    /// Shift Right `>>` (logical / zero-extending). Emitted when the
    /// LHS has an unsigned integer type. ARM64 `LSR`, x86_64 `SHR`.
    Shru,
    /// Addition `+`
    Add,
    /// Subtraction `-`
    Sub,
    /// Multiplication `*`
    Mul,
    /// Division `/` (signed). Emitted when both operands are signed.
    /// ARM64 `SDIV`, x86_64 `IDIV`.
    Div,
    /// Modulo `%` (signed). Emitted when both operands are signed.
    Mod,
    /// Division `/` (unsigned). Emitted when at least one operand has
    /// an unsigned integer type, per C99 6.3.1.8 common-type rules.
    /// Treats both operands as u64 -- the high-bit-set bit pattern is
    /// interpreted as a large positive, not a negative. ARM64 `UDIV`,
    /// x86_64 `DIV` (with `xor edx, edx` instead of `CQO`).
    Divu,
    /// Modulo `%` (unsigned). See [`Op::Divu`].
    Modu,

    // --- Immediate-form arithmetic / comparison ---
    //
    // Each takes one operand `N`. They fuse the common `Psh; Imm N; <op>`
    // sequence emitted for `<expr> <op> <constant>` patterns into a
    // single dispatch -- `a = a <op> N`. The optimizer pass produces them;
    // the compiler never emits them directly.
    /// `a = a + N`
    AddI,
    /// `a = a - N`
    SubI,
    /// `a = a * N`
    MulI,
    /// `a = a & N`
    AndI,
    /// `a = a | N`
    OrI,
    /// `a = a ^ N`
    XorI,
    /// `a = a << N`
    ShlI,
    /// `a = a >> N` (arithmetic / sign-extending)
    ShrI,
    /// `a = a >> N` (logical / zero-extending). Emitted when the
    /// LHS has an unsigned integer type. ARM64 `LSR`, x86_64 `SHR`.
    ShruI,
    /// `a = (a == N) as i64`
    EqI,
    /// `a = (a != N) as i64`
    NeI,
    /// `a = (a < N) as i64` (signed)
    LtI,
    /// `a = (a > N) as i64` (signed)
    GtI,
    /// `a = (a <= N) as i64` (signed)
    LeI,
    /// `a = (a >= N) as i64` (signed)
    GeI,
    /// `a = ((a as u64) < (N as u64)) as i64`
    UltI,
    /// `a = ((a as u64) > (N as u64)) as i64`
    UgtI,
    /// `a = ((a as u64) <= (N as u64)) as i64`
    UleI,
    /// `a = ((a as u64) >= (N as u64)) as i64`
    UgeI,

    // --- Load-local fusion ---
    /// `a = *(i64*)(bp + N*8)` -- fused `Lea N; Li`.
    LdLocI,
    /// `a = *(u8*)(bp + N*8)` -- fused `Lea N; Lc`.
    LdLocC,
    /// `*(i64*)(bp + N*8) = a` -- store accumulator into a local
    /// frame slot at the given offset, without disturbing the c5
    /// stack or the accumulator. The compiler emits this when it
    /// needs to spill a freshly-computed value (e.g. an indirect
    /// call's function-pointer source) to a temp before the
    /// surrounding code clobbers `a`. The regular `Lea N; Si`
    /// pattern can't express this safely because `Lea` clobbers
    /// `a` first.
    StLocI,

    // --- Floating-point arithmetic and comparison ---
    //
    // Both `float` and `double` flow through the same f64 ops; the
    // c5 stack stores every FP value in a single 8-byte slot (the
    // 32-bit narrowing the C standard prescribes for `float` only
    // matters at FP-register ABI boundaries, which c5-internal
    // arithmetic never crosses). The accumulator and stack top
    // carry the `f64::to_bits()` representation so reads and writes
    // share the integer Li/Si paths; only the arithmetic dispatches
    // care about the bit-pattern interpretation.
    /// `a = (top + acc)` as f64. Pops top.
    Fadd,
    /// `a = (top - acc)` as f64. Pops top.
    Fsub,
    /// `a = (top * acc)` as f64. Pops top.
    Fmul,
    /// `a = (top / acc)` as f64. Pops top.
    Fdiv,
    /// `a = -acc` as f64.
    Fneg,
    /// `a = (top == acc) ? 1 : 0` as i64.
    Feq,
    /// `a = (top != acc) ? 1 : 0` as i64.
    Fne,
    /// `a = (top <  acc) ? 1 : 0` as i64.
    Flt,
    /// `a = (top >  acc) ? 1 : 0` as i64.
    Fgt,
    /// `a = (top <= acc) ? 1 : 0` as i64.
    Fle,
    /// `a = (top >= acc) ? 1 : 0` as i64.
    Fge,
    /// `a = (i64)(f64::from_bits(acc))` -- truncating float-to-int
    /// cast. Used by `(int)f` and by promotions before integer ops
    /// that take a float operand.
    Fcvtfi,
    /// `a = ((i64)acc as f64).to_bits()` -- int-to-float cast. Used
    /// by `(float)i` / `(double)i` and by integer-side operands of
    /// a mixed FP expression.
    Fcvtif,
    /// Load Float: reads a 32-bit IEEE-754 single-precision value
    /// from the address in the accumulator, widens it to f64, and
    /// leaves `f64::to_bits()` in `a`. Used for scalar `float`
    /// lvalue reads where the field / variable storage is 4 bytes
    /// (`sizeof(float) == 4` post-fix). Companion to [`Op::Sf`].
    /// The c5 arithmetic ops (`Op::Fadd`, ...) still operate in
    /// f64 land; the widening here is the only narrowing crossing
    /// at the load boundary. ARM64 sequence is
    /// `ldr s0, [x19]; fcvt d0, s0; fmov x19, d0`; x86_64 is
    /// `mov eax, [rbx]; movd xmm0, eax; cvtss2sd xmm0, xmm0;
    /// movq rbx, xmm0`.
    Lf,
    /// Store Float: takes the accumulator (`f64::to_bits()`),
    /// narrows the bit pattern to single-precision, and stores
    /// the resulting 4 bytes at the address on top of stack.
    /// Companion to [`Op::Lf`] for 4-byte float writes. The
    /// narrow-then-widen-back rounding is a single-precision
    /// `fcvt s, d` on ARM64 (`cvtsd2ss` on x86_64); subsequent
    /// loads through `Op::Lf` reproduce the same f64 bit pattern
    /// as long as the stored value fit single-precision exactly.
    Sf,

    /// Memory copy. Operand: size in bytes (compile-time constant).
    /// Stack top: destination address. Accumulator: source address
    /// (the parser leaves it there because the RHS struct-value
    /// expression terminates with the address in `a`). Copies the
    /// given byte count from src to dst, then sets `a` to dst so
    /// the op behaves as `memcpy(dst, src, n)` does (returns dst).
    /// Used to lower whole-struct assignment without forcing the
    /// program to `#include <string.h>` and bind libc memcpy.
    Mcpy,

    /// Thread-Local Storage address load. Operand: byte offset
    /// within the TLS block of the variable being addressed. The
    /// codegen materialises the TLS-base + offset address into
    /// `a` using the platform's local-exec sequence:
    ///   * Linux/aarch64: `mrs x19, tpidr_el0; add x19, x19, imm`
    ///     (variant-1 layout: TLS sits AFTER the TCB head, so the
    ///     emitted offset is `TCB_HEAD + var_offset`).
    ///   * Linux/x86_64: `mov r13, qword ptr fs:[0]; sub r13, imm`
    ///     (variant-2 layout: TLS sits BEFORE the FS base, so the
    ///     emitted offset is `tls_total_size - var_offset`).
    ///   * macOS arm64 / Win64: not yet supported -- compile-time
    ///     reject in the writer's TLS-fixup application path.
    ///
    /// The VM allocates a per-Program TLS region and treats the
    /// op as a plain `Op::Imm tls_base + offset` (no real per-
    /// thread isolation; the VM is single-threaded).
    TlsLea,
    /// Tail-jump to an external library symbol. Followed by one
    /// operand: the binding-table index. Used as the entire body
    /// of the per-Sys-symbol address-take trampoline -- the
    /// trampoline lives at the bytecode-PC stamped on the
    /// synthetic Token::Fun's `val`, and the codegen lowers
    /// `Op::TailExt` to a single `jmp [rip+iat_disp32]`-shape
    /// instruction (or its aarch64 equivalent). The host's
    /// argument registers and shadow-space stack args -- already
    /// prepared by the caller's `Op::Jsri` lowering -- are
    /// forwarded straight through, so the libc fn sees exactly
    /// what the caller's `Adj N` declared. There's no `Ent`,
    /// no c5-stack push/pop, and no `Lev` after this op: the
    /// libc fn's `ret` returns directly to the caller's
    /// post-Jsri continuation.
    ///
    /// Replaces the multi-op trampoline body
    /// (`Ent / Lea / Li / Psh / JsrExt / Adj / Lev`) for libc
    /// symbols whose address gets taken; the old shape forwarded
    /// only as many args as the binding's prototype declared,
    /// which broke when a dispatch-table entry cast a libc fn to
    /// a different-arity function-pointer type at the call site.
    /// The tail-jump shape is independent of the binding's
    /// declared arity. Placed at the end of the enum so the
    /// `OPS[]` lookup table's tail entry matches the enum
    /// discriminant -- adding new ops elsewhere requires keeping
    /// the two in lockstep.
    TailExt,

    /// Compiler-builtin intrinsic. Operand: the [`Intrinsic`]
    /// discriminant cast to `i64`. The accumulator carries the
    /// single integer argument on entry; the lowered sequence
    /// leaves the result in the accumulator. Used for
    /// architecture-specific shapes (`alloca`, future atomics
    /// / cpuid / vector-builtin surface) that can't sit behind a
    /// regular dynamic-binding `Op::JsrExt` call -- e.g.
    /// `alloca` has to bump the *caller's* stack pointer and
    /// return a pointer into the same frame, which a normal
    /// function call can't do. The frontend tags an intrinsic
    /// callee by setting `Symbol::intrinsic` (driven by
    /// `#pragma intrinsic("name")`); call-site lowering then
    /// emits this op instead of the regular push/jsr/adj
    /// sequence.
    Intrinsic,

    /// Companion to `Op::Intrinsic(Alloca)` -- initialises the
    /// per-frame alloca arena's top pointer at function entry.
    /// Operand: the FP-slot index of the alloca-top slot
    /// (positive, in 8-byte units). Zero means "this function
    /// doesn't use alloca" and codegen emits nothing.
    ///
    /// The compiler emits an `AllocaInit 0` placeholder right
    /// after every `Op::Ent`. If the function body later emits
    /// an `Op::Intrinsic(Alloca)`, the compiler backpatches both
    /// the Ent's local count (to reserve the arena) and this
    /// AllocaInit's operand (to point at the bookkeeping slot
    /// just below the regular locals). The arena sits below the
    /// slot at slots `[idx+1, idx+ARENA_SLOTS]`; alloca calls
    /// bump the slot's stored value down per call and return
    /// the new value. The whole arena is freed implicitly when
    /// the function's epilogue tears down the frame.
    AllocaInit,
}

const OPS: [Op; 88] = [
    Op::Lea,
    Op::Imm,
    Op::Jmp,
    Op::Jsr,
    Op::Jsri,
    Op::Bz,
    Op::Bnz,
    Op::Ent,
    Op::Adj,
    Op::Lev,
    Op::Li,
    Op::Lc,
    Op::Lcs,
    Op::Si,
    Op::Sc,
    Op::Lw,
    Op::Lwu,
    Op::Sw,
    Op::Lh,
    Op::Lhu,
    Op::Sh,
    Op::Psh,
    Op::JsrExt,
    Op::Or,
    Op::Xor,
    Op::And,
    Op::Eq,
    Op::Ne,
    Op::Lt,
    Op::Gt,
    Op::Le,
    Op::Ge,
    Op::Ult,
    Op::Ugt,
    Op::Ule,
    Op::Uge,
    Op::Shl,
    Op::Shr,
    Op::Shru,
    Op::Add,
    Op::Sub,
    Op::Mul,
    Op::Div,
    Op::Mod,
    Op::Divu,
    Op::Modu,
    // Immediate-form ops (optimizer-emitted).
    Op::AddI,
    Op::SubI,
    Op::MulI,
    Op::AndI,
    Op::OrI,
    Op::XorI,
    Op::ShlI,
    Op::ShrI,
    Op::ShruI,
    Op::EqI,
    Op::NeI,
    Op::LtI,
    Op::GtI,
    Op::LeI,
    Op::GeI,
    Op::UltI,
    Op::UgtI,
    Op::UleI,
    Op::UgeI,
    Op::LdLocI,
    Op::LdLocC,
    Op::StLocI,
    // Floating-point arithmetic / comparison / casts.
    Op::Fadd,
    Op::Fsub,
    Op::Fmul,
    Op::Fdiv,
    Op::Fneg,
    Op::Feq,
    Op::Fne,
    Op::Flt,
    Op::Fgt,
    Op::Fle,
    Op::Fge,
    Op::Fcvtfi,
    Op::Fcvtif,
    Op::Lf,
    Op::Sf,
    Op::Mcpy,
    Op::TlsLea,
    Op::TailExt,
    Op::Intrinsic,
    Op::AllocaInit,
];

/// Per-function alloca arena size, in 8-byte slots. Chosen
/// large enough to cover stb_vorbis's `inverse_mdct` (~4 KB
/// of float scratch) and the smaller `decode_residue` block-array
/// temporaries with headroom, without bloating every alloca-using
/// frame by a megabyte. Functions that need more than this end
/// up corrupting the saved-x19 / pool area below the arena --
/// bounds-checking is a future-work item.
pub const ALLOCA_ARENA_SLOTS: i64 = 1024;

/// Compiler-builtin intrinsic discriminant. Each lowering target
/// dispatches on this value to emit the per-arch sequence.
/// Keep the discriminants stable -- bytecode produced under an
/// older c5 may live in a vendor-deps archive and re-running it
/// would mis-decode the operand if these reshuffle.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(i64)]
pub enum Intrinsic {
    /// `alloca(n)` / `__builtin_alloca(n)` -- bumps the caller's
    /// native stack pointer down by `n` (rounded up to the
    /// platform's stack-alignment, typically 16) and returns
    /// the new SP as a `void *`. The memory is reclaimed when
    /// the caller's function returns. The VM runs this through
    /// a per-call-frame leak list -- malloc + remember to free
    /// at the matching `Op::Lev` -- because the VM doesn't
    /// have a real native stack to bump.
    Alloca = 1,
}

impl Intrinsic {
    pub fn from_i64(v: i64) -> Option<Self> {
        match v {
            1 => Some(Intrinsic::Alloca),
            _ => None,
        }
    }
}

impl Op {
    pub fn from_i64(val: i64) -> Option<Self> {
        // Opcodes carry a non-zero discriminant base so that legitimate
        // operand values (PCs, immediates, stack slot counts) can never be
        // mistaken for an instruction. Translate back into the OPS index.
        let base = Op::Lea as i64;
        let idx = val.checked_sub(base)?;
        if (0..OPS.len() as i64).contains(&idx) {
            Some(OPS[idx as usize])
        } else {
            None
        }
    }

    /// Number of operand i64 words that follow this op in the
    /// bytecode. Single source of truth -- every bytecode walker
    /// (the optimizer's decode pass, the regalloc analyzer, the
    /// codegen lowering, the import resolver, the disassembler)
    /// reads its operand-skip count from here. Adding a new
    /// operand-bearing op only requires an entry in this match.
    pub fn operand_count(self) -> usize {
        use Op::*;
        match self {
            // Single-operand ops: control flow, frame setup, libc
            // dispatch, and the optimizer's immediate-form
            // arithmetic / comparison ops.
            Lea | Imm | Jmp | Jsr | Bz | Bnz | Ent | Adj | JsrExt | TailExt | AddI | SubI
            | MulI | AndI | OrI | XorI | ShlI | ShrI | ShruI | EqI | NeI | LtI | GtI | LeI
            | GeI | UltI | UgtI | UleI | UgeI | LdLocI | LdLocC | StLocI | Mcpy | TlsLea
            | Intrinsic | AllocaInit => 1,
            // Everything else -- arithmetic, loads/stores, push,
            // indirect-jump, return, etc. -- is encoded in a
            // single word with no operand.
            _ => 0,
        }
    }

    /// Total i64 words this op occupies in the bytecode (op + its
    /// operand). `1 + operand_count()`.
    pub fn word_size(self) -> usize {
        1 + self.operand_count()
    }
}
