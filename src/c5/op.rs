/// Per-width scalar-load tag the parser leaves in
/// `Compiler::pending.trailing_scalar_load` to mark the most
/// recent emit. The lvalue-rewrite path consumes the tag through
/// `pop_trailing_scalar_load` -- `&expr`, `++/--`, compound
/// assignment, etc. -- to undo the trailing load and recover the
/// lvalue address. The discriminant base sits above any plausible
/// `i64` immediate value so a stray int operand can never be
/// mistaken for a load tag.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum ScalarLoadKind {
    /// `i64` lvalue read. Source widths: `long` / `long long` /
    /// pointer / `double` (the 8-byte slot holds the f64 bit
    /// pattern verbatim).
    Li = 0x7f00_0000_0000_0001,
    /// Unsigned `char` lvalue read. Zero-extends a `u8` into the
    /// 64-bit accumulator. C99 leaves `char`'s default signedness
    /// implementation-defined; c5 picks unsigned so a plain
    /// `char` reads compare equal to their bit pattern.
    Lc,
    /// Signed `char` lvalue read. Sign-extends an `i8` into the
    /// 64-bit accumulator so values outside `[0, 127]` keep the
    /// high bits.
    Lcs,
    /// Signed `int` lvalue read. Sign-extends an `i32` into the
    /// 64-bit accumulator. ARM64 `LDRSW`, x86_64 `MOVSXD`.
    Lw,
    /// Unsigned `int` lvalue read. Zero-extends a `u32` into the
    /// 64-bit accumulator so `(unsigned int)-1 == 0xFFFFFFFF`
    /// reads consistently and `1u - 2u` wraps to `0xFFFFFFFF`
    /// rather than back to `-1`.
    Lwu,
    /// Signed `short` lvalue read. Sign-extends an `i16` into the
    /// 64-bit accumulator. ARM64 `LDRSH`, x86_64 `MOVSX r64, m16`.
    Lh,
    /// Unsigned `short` / `u16` lvalue read. Zero-extends a `u16`
    /// into the 64-bit accumulator. ARM64 `LDRH`, x86_64
    /// `MOVZX r64, m16`. Also covers explicit `*(u16 *)p`
    /// packed-buffer reads.
    Lhu,
    /// Single-precision `float` lvalue read. Reads 32 bits,
    /// widens to f64, and leaves `f64::to_bits()` in the
    /// accumulator -- the c5 arithmetic ops operate in f64 land,
    /// so the widening is the only narrowing crossing at the
    /// load boundary. ARM64: `ldr s0, [x19]; fcvt d0, s0; fmov
    /// x19, d0`; x86_64: `mov eax, [rbx]; movd xmm0, eax;
    /// cvtss2sd xmm0, xmm0; movq rbx, xmm0`.
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
    /// at the matching `Terminator::Return` -- because the VM
    /// doesn't have a real native stack to bump.
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
