/// Virtual Machine Operations (Opcodes)
/// These represent the low-level instructions executed by the VM.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Op {
    /// Load Integer: Loads an i64 from the address in the accumulator.
    Li = 0x7f00_0000_0000_0001,
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
}

/// Per-function alloca arena size, in 8-byte slots. Sized to
/// cover the FFT-class scratch buffer (~4 KB of float
/// temporaries) and smaller block-array workspaces with
/// headroom, without bloating every alloca-using frame to a
/// megabyte. Functions that need more than this end up
/// corrupting the saved-x19 / pool area below the arena.
/// TODO: bounds-check the alloca cursor against the arena.
pub const ALLOCA_ARENA_SLOTS: i64 = 1024;

/// Compiler-builtin intrinsic discriminant. Each lowering target
/// dispatches on this value to emit the per-arch sequence.
/// Keep the discriminants stable -- the `.o` SSA-body wire
/// format serialises `Inst::Intrinsic { kind, .. }` verbatim, so
/// an archive built with an older c5 would mis-decode the
/// operand if these reshuffle.
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
    /// `__c5_aarch64_setjmp(env)` -- AArch64 setjmp implemented
    /// as an inline expansion at the call site. Saves x19-x28,
    /// x29, the address of the instruction after the expansion
    /// (used as the longjmp return target), SP, and d8-d15 into
    /// `env`. Returns 0 on the initial call; on a matching
    /// longjmp the saved return address is branched back to with
    /// the caller-supplied value in x19. AArch64 lowering only;
    /// only emitted by Windows AArch64 headers because that
    /// target's msvcrt longjmp routes through SEH and refuses an
    /// SEH-free `jmp_buf` -- the Linux / macOS bindings continue
    /// to use the host libc setjmp.
    SetjmpAArch64 = 2,
    /// `__c5_aarch64_longjmp(env, val)` -- partner to
    /// `SetjmpAArch64`. Args reach this op as (env on the c5
    /// eval stack, val in x19); the expansion restores the
    /// callee-saved registers + SP from `env`, sets x19 to
    /// `val != 0 ? val : 1`, and branches to the saved return
    /// address. Does not return to its own caller.
    LongjmpAArch64 = 3,
    /// `__builtin_va_start(ap, last)`. Args reach the op as
    /// (`&ap` on the c5 eval stack, `&last` in accumulator).
    /// The expansion initialises `*ap` to point at the variadic
    /// region for the enclosing function. On AAPCS64 / SysV with
    /// the host variadic ABI this fills a struct (`__gr_top`,
    /// `__vr_top`, `__gr_offs`, `__vr_offs`, `__stack`); on
    /// Win64 / Win-arm64 it stores a single cursor pointer.
    /// Codegen consults the current function's variadic-save-area
    /// frame layout to compute the initial values.
    VaStart = 4,
    /// `__builtin_va_arg(ap, type_kind, byte_size)` -- read the
    /// next variadic argument. Args reach the op as (`&ap` on
    /// the c5 eval stack, a packed `(kind << 16) | size`
    /// descriptor in the accumulator). `kind` is 0 for integer /
    /// pointer, 1 for float / double. The expansion advances
    /// `*ap` per the host's variadic protocol and returns the
    /// value in the accumulator.
    VaArg = 5,
    /// `__builtin_va_end(ap)` -- terminates a `va_list`. A no-op
    /// on every supported host ABI but kept as an intrinsic so
    /// future hosts (real-mode / segmented / capability) can
    /// hook in.
    VaEnd = 6,
    /// `__builtin_va_copy(dst, src)` -- struct copy of one
    /// `va_list` to another. On AAPCS64 / SysV that's a 24-byte
    /// memcpy; on Win64 / Win-arm64 it's a pointer assignment.
    /// Codegen picks the right size from the target's `va_list`
    /// layout.
    VaCopy = 7,
}

impl Intrinsic {
    pub fn from_i64(v: i64) -> Option<Self> {
        match v {
            1 => Some(Intrinsic::Alloca),
            2 => Some(Intrinsic::SetjmpAArch64),
            3 => Some(Intrinsic::LongjmpAArch64),
            4 => Some(Intrinsic::VaStart),
            5 => Some(Intrinsic::VaArg),
            6 => Some(Intrinsic::VaEnd),
            7 => Some(Intrinsic::VaCopy),
            _ => None,
        }
    }
}
