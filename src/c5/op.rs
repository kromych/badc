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
    /// `fma(x, y, z)` -- C99 7.12.13.1, `x*y + z` rounded once. The
    /// call-site lowering produces `Inst::Fma` directly rather than an
    /// `Inst::Intrinsic`, so the three operands reach codegen as a
    /// single fused node. Double precision.
    Fma = 8,
    /// `fmaf(x, y, z)` -- the single-precision partner of [`Fma`]; the
    /// operands and result are `float`.
    Fmaf = 9,
    /// `__builtin_trap()` -- execute an architecture trap instruction
    /// (`ud2` on x86_64, `brk #0` on AArch64) that raises an illegal-
    /// instruction / breakpoint exception. Takes no argument, produces
    /// no value, and does not return to its caller. The VM aborts the
    /// process.
    Trap = 10,
    /// `sqrt(x)` / `sqrtf(x)` -- C99 7.12.7.5, the correctly-rounded
    /// square root. Lowered to `Inst::FUnary { op: Sqrt }` so it emits
    /// the hardware instruction (`fsqrt` / `sqrtsd` / `sqrtss`) rather
    /// than a library call. `Sqrt` is double, `Sqrtf` single precision.
    Sqrt = 11,
    Sqrtf = 12,
    /// `fabs(x)` / `fabsf(x)` -- C99 7.12.7.2, absolute value. Lowered to
    /// `Inst::FUnary { op: Abs }`, which clears the IEEE 754 sign bit.
    Fabs = 13,
    Fabsf = 14,
    /// `floor` / `ceil` / `trunc` and their single-precision partners --
    /// C99 7.12.9.2 / 7.12.9.1 / 7.12.9.8. Each lowers to one rounding
    /// instruction (x86-64 ROUNDSD/ROUNDSS with the rounding-mode
    /// immediate, AArch64 FRINTM/FRINTP/FRINTZ).
    Floor = 15,
    Floorf = 16,
    Ceil = 17,
    Ceilf = 18,
    Trunc = 19,
    Truncf = 20,
    /// `__builtin_clz(x)` / `__builtin_clzll(x)` -- count leading zero
    /// bits of a 32-bit / 64-bit unsigned value. `__builtin_ctz` /
    /// `__builtin_ctzll` count trailing zeros; `__builtin_popcount` /
    /// `__builtin_popcountll` count set bits. The result is `int`. The
    /// value at zero is undefined for clz / ctz (GCC); the walker's
    /// branchless lowering returns the bit width there. Lowered in the
    /// walker to a portable shift / mask / add sequence rather than a
    /// dedicated instruction, so the behavior is identical across the
    /// interpreter and every target.
    Clz = 21,
    Ctz = 22,
    Popcount = 23,
    Clzll = 24,
    Ctzll = 25,
    Popcountll = 26,
    /// `__builtin_bswap16` / `bswap32` / `bswap64` -- reverse the byte
    /// order of a 16- / 32- / 64-bit value. The result type matches the
    /// operand width. Lowered in the walker to a portable shift / mask /
    /// or sequence rather than a dedicated instruction.
    Bswap16 = 27,
    Bswap32 = 28,
    Bswap64 = 29,
    /// `__builtin_frame_address(0)` -- the current frame pointer (x29 /
    /// rbp), returned as a `void *`. Only level 0 is supported; a
    /// non-zero level (a caller's frame) is not. Used for stack-depth /
    /// stack-overflow checks.
    FrameAddress = 30,
    /// CPU spin-loop relax hint, the lowering of an operand-free
    /// inline-asm spin hint (`asm volatile("pause")` on x86-64,
    /// `asm volatile("yield")` on AArch64). Emits the target hint
    /// instruction (`pause` = F3 90, `yield` = 0xD503203F); a no-op
    /// for correctness, so the interpreter ignores it. Takes no
    /// argument and produces no value.
    CpuRelax = 31,
    /// C11 7.17 atomic generic operations. Declared by `<stdatomic.h>`
    /// via `#pragma intrinsic` and lowered at the call site to an
    /// ordinary load / store / read-modify-write on the pointee width
    /// of the first argument (see `Compiler::parse_atomic_builtin` and
    /// `ast::AtomicKind`), so they never reach the `Inst::Intrinsic`
    /// dispatch -- the same arrangement as the bit-count builtins above.
    AtomicLoad = 32,
    AtomicStore = 33,
    AtomicExchange = 34,
    AtomicFetchAdd = 35,
    AtomicFetchSub = 36,
    AtomicFetchAnd = 37,
    AtomicFetchOr = 38,
    AtomicFetchXor = 39,
    AtomicCompareExchangeStrong = 40,
    /// `asm("fnstcw %0" : "=m"(cw))` -- store the x87 FPU control word to
    /// the 16-bit memory operand. The op takes the operand's address;
    /// codegen emits `fnstcw m16` (x86_64 only). The interpreter writes
    /// the default control word (0x037f) since it evaluates floats with
    /// host doubles.
    X87StoreControlWord = 41,
    /// `asm("fldcw %0" : : "m"(cw))` -- load the x87 FPU control word from
    /// the 16-bit memory operand. The op takes the operand's address;
    /// codegen emits `fldcw m16` (x86_64 only). A no-op in the
    /// interpreter.
    X87LoadControlWord = 42,
    /// `__atomic_thread_fence` / `__atomic_signal_fence` /
    /// `__sync_synchronize` -- a full memory barrier (C11 7.17.4,
    /// GCC `__sync`/`__atomic` builtins). Emits `dmb ish` (AArch64) /
    /// `mfence` (x86_64); takes no argument and produces no value.
    /// A no-op in the single-threaded interpreter.
    AtomicThreadFence = 43,
    /// `asm("cpuid" : "=a"(o0), "=b"(o1), "=c"(o2), "=d"(o3) : "a"(leaf),
    /// "c"(sub))` -- x86 CPU identification. The six args are, in order,
    /// the four output addresses (eax/ebx/ecx/edx destinations) then the
    /// two input values (eax = leaf, ecx = subleaf). x86_64 only. The
    /// interpreter zeroes the outputs (no host CPUID).
    Cpuid = 44,
    /// `asm("xgetbv" : "=a"(lo), "=d"(hi) : "c"(reg))` -- read an extended
    /// control register. Three args: the low and high output addresses
    /// (eax/edx destinations) then the input value (ecx = register index).
    /// x86_64 only. The interpreter zeroes the outputs.
    Xgetbv = 45,
    /// Read the current stack pointer (the VM's frame bump cursor).
    /// Takes no argument, returns the value. Snapshots the stack on
    /// entry to a block that declares a variable-length array (C99
    /// 6.7.6.2) so the storage is reclaimed on block exit.
    AllocaSave = 46,
    /// Restore the stack pointer to a value a prior `AllocaSave`
    /// captured. One argument (the saved value); returns nothing.
    /// Reclaims a VLA block's storage on exit.
    AllocaRestore = 47,
    /// `__builtin_clrsb(x)` / `__builtin_clrsbll(x)` -- count leading
    /// redundant sign bits of a 32-bit / 64-bit signed value: the number
    /// of bits after the sign bit that equal it. The result is `int`.
    /// Lowered in the walker as `clz(x ^ (x >> (w-1))) - 1`.
    Clrsb = 48,
    Clrsbll = 49,
    /// `__builtin_parity(x)` / `__builtin_parityll(x)` -- 1 when the value
    /// has an odd number of set bits, else 0. Lowered as `popcount(x) & 1`.
    Parity = 50,
    Parityll = 51,
    /// `asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d))` --
    /// x86-64 unsigned 128/64 division (the `udiv_qrnnd` assembly-macro
    /// shape). Five args: the quotient output address, the remainder
    /// output address, the dividend low (`n0`), the dividend high (`n1`),
    /// and the divisor (`d`). Computes `(n1:n0) / d` -> quotient and
    /// `(n1:n0) % d` -> remainder. x86_64 only (the source gates it on
    /// `__x86_64__`); the interpreter uses 128-bit host arithmetic.
    Divq128 = 52,
    /// `asm volatile("rdtsc" : "=a"(low), "=d"(high))` -- x86-64 read the
    /// timestamp counter. Two args: the
    /// low (eax) and high (edx) 32-bit output addresses. x86_64 only; the
    /// interpreter zeroes the outputs (no host clock).
    Rdtsc = 53,
    /// AArch64 cache maintenance and barriers, each a fixed-encoding
    /// instruction. `ReadCacheType` = `mrs %0,
    /// ctr_el0` (one output address); `DcCvau` = `dc cvau, %0` and
    /// `IcIvau` = `ic ivau, %0` (one pointer input each); `DsbIsh` =
    /// `dsb ish` and `Isb` = `isb` (no operands). AArch64 only; the
    /// interpreter treats the barriers and cache ops as no-ops and
    /// returns a fixed CTR_EL0 for the read.
    AArch64ReadCacheType = 54,
    AArch64DcCvau = 55,
    AArch64IcIvau = 56,
    AArch64DsbIsh = 57,
    AArch64Isb = 58,
    /// `__builtin_ffs(x)` / `__builtin_ffsll(x)` -- one plus the index of
    /// the least-significant set bit, or 0 when `x` is 0 (POSIX `ffs`, GCC
    /// builtin). The result is `int`. Lowered in the walker as
    /// `(ctz(x) + 1) * (x != 0)`, reusing the portable ctz sequence; the
    /// `(x != 0)` factor forces the zero case (ctz(0) is the bit width).
    Ffs = 59,
    Ffsll = 60,
    /// 128-bit atomic read-modify-write via the AArch64 `ldaxp`/`stlxp`
    /// exclusive-pair retry loop (the shape GCC/clang inline asm emits for
    /// `Int128` atomics, since aarch64 has no native 128-bit CAS through
    /// gcc 10). Each takes a pointer to the 128-bit object, the addresses
    /// of the two 64-bit halves of the prior value (written back), and the
    /// operand halves as inputs: `CmpXchg` compares against `cmp{l,h}` and
    /// stores `new{l,h}` on a match; `Xchg` stores unconditionally;
    /// `FetchAnd`/`FetchOr` store `old & new` / `old | new`. AArch64 only.
    Atomic128CmpXchg = 61,
    Atomic128Xchg = 62,
    Atomic128FetchAnd = 63,
    Atomic128FetchOr = 64,
    /// 128-bit atomic load / store, the AArch64 inline-asm idiom for a
    /// 16-byte access with no native LSE2 support. `Load`/`Store` are the
    /// plain `LDP`/`STP` forms; `LoadEx`/`StoreEx` are the pre-LSE2 forms
    /// built from an `LDXP`/`STXP` exclusive-pair retry loop. Loads take a
    /// pointer to the object and the addresses of the two 64-bit result
    /// halves (written back); stores take the pointer and the two halves as
    /// inputs. AArch64 only.
    Atomic128Load = 65,
    Atomic128Store = 66,
    Atomic128LoadEx = 67,
    Atomic128StoreEx = 68,
    /// `__builtin_return_address(0)` -- the current function's return
    /// address, read from the saved slot just above the frame pointer
    /// (`[fp + 8]` under both the AAPCS64 and SysV prologues). Only level
    /// 0 is supported. The interpreter returns a stable per-frame proxy.
    ReturnAddress = 69,
    /// 128-bit masked store-insert: `*mem = (*mem & ~msk) | val`, built from
    /// an `LDXP` / `BIC` / `ORR` / `STXP` exclusive retry loop. Takes the
    /// pointer and the value and mask halves (`vl`, `vh`, `ml`, `mh`) as
    /// inputs; there is no result. AArch64 only.
    Atomic128StoreInsert = 70,
    /// `asm("fxsave %0" : "=m"(buf))` -- save the x87/SSE state to the
    /// 512-byte memory operand. The op takes the operand's address;
    /// codegen emits `fxsave m` (0F AE /0, x86_64 only). A no-op in the
    /// interpreter (no modelled FPU/SSE state).
    X86FxSave = 71,
    /// `asm("fxrstor %0" : : "m"(buf))` -- restore the x87/SSE state from
    /// the 512-byte memory operand. Codegen emits `fxrstor m` (0F AE /1,
    /// x86_64 only). A no-op in the interpreter.
    X86FxRestore = 72,
    /// x86 descriptor-table / clflush forms, each with a single memory
    /// operand (the op takes its address, like the x87 control-word forms).
    /// `sgdt`/`sidt`/`sldt`/`str` store the GDTR/IDTR/LDTR/TR; `lgdt`/`lidt`
    /// load the GDTR/IDTR; `clflush` flushes a cache line. All x86_64 only;
    /// the interpreter stores zero (loads / flushes are no-ops).
    X86Sgdt = 73,
    X86Sidt = 74,
    X86Sldt = 75,
    X86Str = 76,
    X86Lgdt = 77,
    X86Lidt = 78,
    X86Clflush = 79,
    /// `asm("lldtw %0" : : "g"(Ldtr))` -- load the LDTR from the 16-bit
    /// operand (0F 00 /2). The op takes the operand's address; the
    /// interpreter treats it as a no-op (no modelled LDTR).
    X86Lldt = 80,
    /// Read of a `register T name asm("rsp"/"sp")` variable -- the
    /// current stack pointer, as a `void *`-shaped value. No arguments.
    /// The interpreter returns the frame's arena base (the same proxy
    /// `FrameAddress` uses); native code reads rsp / sp directly.
    StackPointer = 81,
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
            8 => Some(Intrinsic::Fma),
            9 => Some(Intrinsic::Fmaf),
            10 => Some(Intrinsic::Trap),
            11 => Some(Intrinsic::Sqrt),
            12 => Some(Intrinsic::Sqrtf),
            13 => Some(Intrinsic::Fabs),
            14 => Some(Intrinsic::Fabsf),
            15 => Some(Intrinsic::Floor),
            16 => Some(Intrinsic::Floorf),
            17 => Some(Intrinsic::Ceil),
            18 => Some(Intrinsic::Ceilf),
            19 => Some(Intrinsic::Trunc),
            20 => Some(Intrinsic::Truncf),
            21 => Some(Intrinsic::Clz),
            22 => Some(Intrinsic::Ctz),
            23 => Some(Intrinsic::Popcount),
            24 => Some(Intrinsic::Clzll),
            25 => Some(Intrinsic::Ctzll),
            26 => Some(Intrinsic::Popcountll),
            27 => Some(Intrinsic::Bswap16),
            28 => Some(Intrinsic::Bswap32),
            29 => Some(Intrinsic::Bswap64),
            30 => Some(Intrinsic::FrameAddress),
            31 => Some(Intrinsic::CpuRelax),
            32 => Some(Intrinsic::AtomicLoad),
            33 => Some(Intrinsic::AtomicStore),
            34 => Some(Intrinsic::AtomicExchange),
            35 => Some(Intrinsic::AtomicFetchAdd),
            36 => Some(Intrinsic::AtomicFetchSub),
            37 => Some(Intrinsic::AtomicFetchAnd),
            38 => Some(Intrinsic::AtomicFetchOr),
            39 => Some(Intrinsic::AtomicFetchXor),
            40 => Some(Intrinsic::AtomicCompareExchangeStrong),
            41 => Some(Intrinsic::X87StoreControlWord),
            42 => Some(Intrinsic::X87LoadControlWord),
            43 => Some(Intrinsic::AtomicThreadFence),
            44 => Some(Intrinsic::Cpuid),
            45 => Some(Intrinsic::Xgetbv),
            46 => Some(Intrinsic::AllocaSave),
            47 => Some(Intrinsic::AllocaRestore),
            48 => Some(Intrinsic::Clrsb),
            49 => Some(Intrinsic::Clrsbll),
            50 => Some(Intrinsic::Parity),
            51 => Some(Intrinsic::Parityll),
            52 => Some(Intrinsic::Divq128),
            53 => Some(Intrinsic::Rdtsc),
            54 => Some(Intrinsic::AArch64ReadCacheType),
            55 => Some(Intrinsic::AArch64DcCvau),
            56 => Some(Intrinsic::AArch64IcIvau),
            57 => Some(Intrinsic::AArch64DsbIsh),
            58 => Some(Intrinsic::AArch64Isb),
            59 => Some(Intrinsic::Ffs),
            60 => Some(Intrinsic::Ffsll),
            61 => Some(Intrinsic::Atomic128CmpXchg),
            62 => Some(Intrinsic::Atomic128Xchg),
            63 => Some(Intrinsic::Atomic128FetchAnd),
            64 => Some(Intrinsic::Atomic128FetchOr),
            65 => Some(Intrinsic::Atomic128Load),
            66 => Some(Intrinsic::Atomic128Store),
            67 => Some(Intrinsic::Atomic128LoadEx),
            68 => Some(Intrinsic::Atomic128StoreEx),
            69 => Some(Intrinsic::ReturnAddress),
            70 => Some(Intrinsic::Atomic128StoreInsert),
            71 => Some(Intrinsic::X86FxSave),
            72 => Some(Intrinsic::X86FxRestore),
            73 => Some(Intrinsic::X86Sgdt),
            74 => Some(Intrinsic::X86Sidt),
            75 => Some(Intrinsic::X86Sldt),
            76 => Some(Intrinsic::X86Str),
            77 => Some(Intrinsic::X86Lgdt),
            78 => Some(Intrinsic::X86Lidt),
            79 => Some(Intrinsic::X86Clflush),
            80 => Some(Intrinsic::X86Lldt),
            81 => Some(Intrinsic::StackPointer),
            _ => None,
        }
    }

    /// Byte-swap builtins: one integer argument, a result of the same
    /// width, lowered in the walker to a portable shift / mask sequence.
    pub fn is_bswap(self) -> bool {
        matches!(
            self,
            Intrinsic::Bswap16 | Intrinsic::Bswap32 | Intrinsic::Bswap64
        )
    }

    /// Integer bit-count builtins: one integer argument, an `int`
    /// result, lowered in the walker to a portable shift / mask
    /// sequence. The `ll` forms operate on 64 bits, the rest on 32.
    pub fn is_int_bit_unary(self) -> bool {
        matches!(
            self,
            Intrinsic::Clz
                | Intrinsic::Ctz
                | Intrinsic::Popcount
                | Intrinsic::Clzll
                | Intrinsic::Ctzll
                | Intrinsic::Popcountll
                | Intrinsic::Clrsb
                | Intrinsic::Clrsbll
                | Intrinsic::Parity
                | Intrinsic::Parityll
                | Intrinsic::Ffs
                | Intrinsic::Ffsll
        )
    }

    /// True for the 64-bit (`ll`) bit-count forms; the rest operate
    /// on a 32-bit value.
    pub fn is_bit_unary_64(self) -> bool {
        matches!(
            self,
            Intrinsic::Clzll
                | Intrinsic::Ctzll
                | Intrinsic::Popcountll
                | Intrinsic::Clrsbll
                | Intrinsic::Parityll
                | Intrinsic::Ffsll
        )
    }

    /// Count-leading-redundant-sign-bits forms. Unlike the other
    /// bit-count builtins these take a signed operand (the sign bit
    /// drives the count), so the argument is sign-extended, not zero-
    /// extended.
    pub fn is_clrsb(self) -> bool {
        matches!(self, Intrinsic::Clrsb | Intrinsic::Clrsbll)
    }

    /// Unary FP math intrinsics: one floating argument, a floating
    /// result of the same precision, lowered to one hardware
    /// instruction via `Inst::Intrinsic`.
    pub fn is_fp_unary(self) -> bool {
        matches!(
            self,
            Intrinsic::Sqrt
                | Intrinsic::Sqrtf
                | Intrinsic::Fabs
                | Intrinsic::Fabsf
                | Intrinsic::Floor
                | Intrinsic::Floorf
                | Intrinsic::Ceil
                | Intrinsic::Ceilf
                | Intrinsic::Trunc
                | Intrinsic::Truncf
        )
    }

    /// True for the single-precision (`float`) intrinsic forms; the
    /// rest operate on `double`.
    pub fn is_single_precision(self) -> bool {
        matches!(
            self,
            Intrinsic::Fmaf
                | Intrinsic::Sqrtf
                | Intrinsic::Fabsf
                | Intrinsic::Floorf
                | Intrinsic::Ceilf
                | Intrinsic::Truncf
        )
    }

    /// True for intrinsics whose result depends on the enclosing
    /// function's own frame, stack pointer, or return / setjmp landing.
    /// Cloning one into a caller (the inliner splice) would report the
    /// caller's frame or reclaim the caller's stack, changing behavior,
    /// so such an intrinsic keeps its function out of line. Every other
    /// intrinsic is a leaf reproduced by operand remap. `VaStart` reads
    /// the enclosing variadic save area; a body holding it is variadic
    /// and already ineligible, but it is listed for completeness.
    pub fn is_frame_bound(self) -> bool {
        matches!(
            self,
            Intrinsic::Alloca
                | Intrinsic::SetjmpAArch64
                | Intrinsic::LongjmpAArch64
                | Intrinsic::VaStart
                | Intrinsic::FrameAddress
                | Intrinsic::AllocaSave
                | Intrinsic::AllocaRestore
                | Intrinsic::ReturnAddress
                | Intrinsic::StackPointer
        )
    }
}
