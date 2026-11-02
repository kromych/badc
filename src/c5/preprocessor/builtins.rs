//! The compiler builtins badc provides.
//!
//! Two tables record how each name is supplied: the builtins badc lowers
//! or parses itself, and the library functions whose `__builtin_` spelling
//! is the function. The intrinsic registry seeded at preprocessor
//! construction, the `#pragma intrinsic` name lookup, `__has_builtin` and
//! the parser's library-alias binding are all derived from them, so they
//! cannot drift apart.

use crate::c5::codegen::Target;
use crate::c5::op::Intrinsic;

/// How badc supplies a builtin.
#[derive(Clone, Copy)]
pub(super) enum Supply {
    /// Intrinsic-registry entry seeded at construction, so the name is
    /// usable with no header (gcc/clang do the same).
    Registry(Intrinsic),
    /// Registry entry whose discriminant follows the target's `long`
    /// width: the `l`-suffixed bit builtins operate on `unsigned long`.
    RegistryByLong { lp64: Intrinsic, llp64: Intrinsic },
    /// Supplied without the registry -- recognized by the parser at the
    /// call site, or predefined as a macro. Also usable with no header.
    Direct,
    /// A library function that a bundled header binds with
    /// `#pragma intrinsic`; it is not a builtin until that header is
    /// included.
    Library(Intrinsic),
}

pub(super) struct Builtin {
    pub(super) name: &'static str,
    pub(super) supply: Supply,
}

const fn registry(name: &'static str, kind: Intrinsic) -> Builtin {
    Builtin {
        name,
        supply: Supply::Registry(kind),
    }
}

const fn by_long(name: &'static str, lp64: Intrinsic, llp64: Intrinsic) -> Builtin {
    Builtin {
        name,
        supply: Supply::RegistryByLong { lp64, llp64 },
    }
}

const fn direct(name: &'static str) -> Builtin {
    Builtin {
        name,
        supply: Supply::Direct,
    }
}

const fn library(name: &'static str, kind: Intrinsic) -> Builtin {
    Builtin {
        name,
        supply: Supply::Library(kind),
    }
}

/// Every builtin badc provides, with its supply route.
pub(super) const BUILTINS: &[Builtin] = &[
    // Bit-count, byte-swap and control-flow builtins, as in gcc/clang.
    // `__builtin_unreachable` lowers to the trap intrinsic, so a reached
    // unreachable aborts rather than continuing.
    registry("__builtin_clz", Intrinsic::Clz),
    registry("__builtin_ctz", Intrinsic::Ctz),
    registry("__builtin_popcount", Intrinsic::Popcount),
    registry("__builtin_clzll", Intrinsic::Clzll),
    registry("__builtin_ctzll", Intrinsic::Ctzll),
    registry("__builtin_popcountll", Intrinsic::Popcountll),
    registry("__builtin_bswap16", Intrinsic::Bswap16),
    registry("__builtin_bswap32", Intrinsic::Bswap32),
    registry("__builtin_bswap64", Intrinsic::Bswap64),
    registry("__builtin_clrsb", Intrinsic::Clrsb),
    registry("__builtin_clrsbll", Intrinsic::Clrsbll),
    registry("__builtin_parity", Intrinsic::Parity),
    registry("__builtin_parityll", Intrinsic::Parityll),
    registry("__builtin_ffs", Intrinsic::Ffs),
    registry("__builtin_ffsll", Intrinsic::Ffsll),
    registry("__builtin_unreachable", Intrinsic::Trap),
    registry("__builtin_trap", Intrinsic::Trap),
    registry("__builtin_alloca", Intrinsic::Alloca),
    registry("__builtin_frame_address", Intrinsic::FrameAddress),
    registry("__builtin_return_address", Intrinsic::ReturnAddress),
    // Freestanding code typedefs `__builtin_va_list` and calls these
    // directly; <stdarg.h>'s va_* macros map onto the same names.
    registry("__builtin_va_start", Intrinsic::VaStart),
    registry("__builtin_va_arg", Intrinsic::VaArg),
    registry("__builtin_va_end", Intrinsic::VaEnd),
    registry("__builtin_va_copy", Intrinsic::VaCopy),
    // `unsigned long` is 8 bytes on LP64 (matching the `ll` forms) and 4
    // on LLP64 (matching the plain forms).
    by_long("__builtin_clzl", Intrinsic::Clzll, Intrinsic::Clz),
    by_long("__builtin_ctzl", Intrinsic::Ctzll, Intrinsic::Ctz),
    by_long(
        "__builtin_popcountl",
        Intrinsic::Popcountll,
        Intrinsic::Popcount,
    ),
    by_long("__builtin_clrsbl", Intrinsic::Clrsbll, Intrinsic::Clrsb),
    by_long("__builtin_parityl", Intrinsic::Parityll, Intrinsic::Parity),
    by_long("__builtin_ffsl", Intrinsic::Ffsll, Intrinsic::Ffs),
    // Parsed at the call site: the operand is unevaluated, or the result
    // type is the chosen operand's, so neither fits a registry call.
    direct("__builtin_constant_p"),
    direct("__builtin_choose_expr"),
    direct("__builtin_types_compatible_p"),
    direct("__builtin_object_size"),
    direct("__builtin_offsetof"),
    direct("__builtin_has_attribute"),
    direct("__builtin_add_overflow"),
    direct("__builtin_sub_overflow"),
    direct("__builtin_mul_overflow"),
    // The type-specific forms of the same family: the name fixes the
    // operand and result type instead of the result pointer's pointee.
    direct("__builtin_sadd_overflow"),
    direct("__builtin_saddl_overflow"),
    direct("__builtin_saddll_overflow"),
    direct("__builtin_uadd_overflow"),
    direct("__builtin_uaddl_overflow"),
    direct("__builtin_uaddll_overflow"),
    direct("__builtin_ssub_overflow"),
    direct("__builtin_ssubl_overflow"),
    direct("__builtin_ssubll_overflow"),
    direct("__builtin_usub_overflow"),
    direct("__builtin_usubl_overflow"),
    direct("__builtin_usubll_overflow"),
    direct("__builtin_smul_overflow"),
    direct("__builtin_smull_overflow"),
    direct("__builtin_smulll_overflow"),
    direct("__builtin_umul_overflow"),
    direct("__builtin_umull_overflow"),
    direct("__builtin_umulll_overflow"),
    // Memory transfers with an integer-constant-expression byte count,
    // expanded inline at the call site. A count the expansion declines
    // is emitted as a call to the library function of the same name.
    direct("__builtin_memcpy"),
    direct("__builtin_memmove"),
    direct("__builtin_memset"),
    // Values the call site forms from the operands: the hints with no
    // code-generation effect, the absolute values, the ASCII
    // classifications, the infinity and NaN constants and the
    // return-address conversions.
    direct("__builtin_expect"),
    direct("__builtin_abs"),
    direct("__builtin_labs"),
    direct("__builtin_llabs"),
    direct("__builtin_imaxabs"),
    direct("__builtin_fabs"),
    direct("__builtin_fabsf"),
    direct("__builtin_fabsl"),
    direct("__builtin_prefetch"),
    direct("__builtin_assume_aligned"),
    direct("__builtin_isdigit"),
    direct("__builtin_isascii"),
    direct("__builtin_toascii"),
    direct("__builtin_isgreater"),
    direct("__builtin_isgreaterequal"),
    direct("__builtin_isless"),
    direct("__builtin_islessequal"),
    direct("__builtin_islessgreater"),
    direct("__builtin_isunordered"),
    direct("__builtin_inf"),
    direct("__builtin_inff"),
    direct("__builtin_infl"),
    direct("__builtin_huge_val"),
    direct("__builtin_huge_valf"),
    direct("__builtin_huge_vall"),
    direct("__builtin_nan"),
    direct("__builtin_nanf"),
    direct("__builtin_extract_return_addr"),
    direct("__builtin_frob_return_addr"),
    // GCC's `__atomic` and `__sync` builtins, lowered at the call site onto
    // the C11 7.17 operations.
    direct("__atomic_load_n"),
    direct("__atomic_load"),
    direct("__atomic_store_n"),
    direct("__atomic_store"),
    direct("__atomic_exchange_n"),
    direct("__atomic_compare_exchange_n"),
    direct("__atomic_fetch_add"),
    direct("__atomic_fetch_sub"),
    direct("__atomic_fetch_and"),
    direct("__atomic_fetch_or"),
    direct("__atomic_fetch_xor"),
    direct("__atomic_add_fetch"),
    direct("__atomic_sub_fetch"),
    direct("__atomic_and_fetch"),
    direct("__atomic_or_fetch"),
    direct("__atomic_xor_fetch"),
    direct("__atomic_test_and_set"),
    direct("__atomic_clear"),
    direct("__atomic_thread_fence"),
    direct("__atomic_signal_fence"),
    direct("__atomic_is_lock_free"),
    direct("__atomic_always_lock_free"),
    direct("__sync_fetch_and_add"),
    direct("__sync_fetch_and_sub"),
    direct("__sync_fetch_and_and"),
    direct("__sync_fetch_and_or"),
    direct("__sync_fetch_and_xor"),
    direct("__sync_add_and_fetch"),
    direct("__sync_sub_and_fetch"),
    direct("__sync_and_and_fetch"),
    direct("__sync_or_and_fetch"),
    direct("__sync_xor_and_fetch"),
    direct("__sync_val_compare_and_swap"),
    direct("__sync_bool_compare_and_swap"),
    direct("__sync_lock_test_and_set"),
    direct("__sync_lock_release"),
    direct("__sync_synchronize"),
    // Library names a bundled header binds; a unit that has not included
    // the header may define its own function under the same name.
    library("alloca", Intrinsic::Alloca),
    library("fma", Intrinsic::Fma),
    library("fmaf", Intrinsic::Fmaf),
    library("sqrt", Intrinsic::Sqrt),
    library("sqrtf", Intrinsic::Sqrtf),
    library("fabs", Intrinsic::Fabs),
    library("fabsf", Intrinsic::Fabsf),
    library("floor", Intrinsic::Floor),
    library("floorf", Intrinsic::Floorf),
    library("ceil", Intrinsic::Ceil),
    library("ceilf", Intrinsic::Ceilf),
    library("trunc", Intrinsic::Trunc),
    library("truncf", Intrinsic::Truncf),
    // C11 7.17 generic atomics, lowered at the call site to
    // load / store / read-modify-write rather than to an intrinsic call.
    library("atomic_load", Intrinsic::AtomicLoad),
    library("atomic_store", Intrinsic::AtomicStore),
    library("atomic_exchange", Intrinsic::AtomicExchange),
    library("atomic_fetch_add", Intrinsic::AtomicFetchAdd),
    library("atomic_fetch_sub", Intrinsic::AtomicFetchSub),
    library("atomic_fetch_and", Intrinsic::AtomicFetchAnd),
    library("atomic_fetch_or", Intrinsic::AtomicFetchOr),
    library("atomic_fetch_xor", Intrinsic::AtomicFetchXor),
    library(
        "atomic_compare_exchange_strong",
        Intrinsic::AtomicCompareExchangeStrong,
    ),
    library("__c5_aarch64_setjmp", Intrinsic::SetjmpAArch64),
    library("__c5_aarch64_longjmp", Intrinsic::LongjmpAArch64),
    library("__c5_establisher_frame", Intrinsic::EstablisherFrame),
];

/// Library functions whose `__builtin_` spelling gcc or clang provide as the
/// function itself, among those the bundled headers declare or define. The
/// parser binds such a call to the function through the symbol table, so a
/// translation unit that defines a macro of the library name does not
/// capture the builtin spelling -- the guarantee gcc and clang give, and the
/// reason a fortified header can call the builtin to reach the unfortified
/// function. The string comparisons fold with constant arguments.
/// Excluded: `setjmp` / `longjmp`, whose builtins take gcc's five-word
/// buffer, the classification macros of <math.h>, and the builtins formed
/// at the call site, which the table supplies.
///
/// Each carries the prototype gcc gives the builtin, which declares the
/// function where the unit does not. `FILE *` and `const struct tm *` are
/// `void *` and `const void *` until a header declares the type, as in gcc.
/// Sorted for the binary search.
#[rustfmt::skip]
pub(super) const LIBRARY_BUILTINS: &[(&str, &str)] = &[
    ("__clear_cache", "void(void *, void *)"), ("_exit", "_Noreturn void(int)"),
    ("abort", "_Noreturn void(void)"),
    ("acos", "double(double)"), ("acosf", "float(float)"),
    ("acosh", "double(double)"), ("acoshf", "float(float)"),
    ("acoshl", "long double(long double)"), ("acosl", "long double(long double)"),
    ("aligned_alloc", "void *(size_t, size_t)"),
    ("asin", "double(double)"), ("asinf", "float(float)"),
    ("asinh", "double(double)"), ("asinhf", "float(float)"),
    ("asinhl", "long double(long double)"), ("asinl", "long double(long double)"),
    ("atan", "double(double)"), ("atan2", "double(double, double)"),
    ("atan2f", "float(float, float)"), ("atan2l", "long double(long double, long double)"),
    ("atanf", "float(float)"), ("atanh", "double(double)"), ("atanhf", "float(float)"),
    ("atanhl", "long double(long double)"), ("atanl", "long double(long double)"),
    ("bcmp", "int(const void *, const void *, size_t)"),
    ("bcopy", "void(const void *, void *, size_t)"), ("bzero", "void(void *, size_t)"),
    ("calloc", "void *(size_t, size_t)"),
    ("cbrt", "double(double)"), ("cbrtf", "float(float)"), ("cbrtl", "long double(long double)"),
    ("ceil", "double(double)"), ("ceilf", "float(float)"), ("ceill", "long double(long double)"),
    ("copysign", "double(double, double)"), ("copysignf", "float(float, float)"),
    ("copysignl", "long double(long double, long double)"),
    ("cos", "double(double)"), ("cosf", "float(float)"), ("cosh", "double(double)"),
    ("coshl", "long double(long double)"), ("cosl", "long double(long double)"),
    ("dcgettext", "char *(const char *, const char *, int)"),
    ("dgettext", "char *(const char *, const char *)"),
    ("erf", "double(double)"), ("erfc", "double(double)"), ("erfcf", "float(float)"),
    ("erfcl", "long double(long double)"), ("erff", "float(float)"),
    ("erfl", "long double(long double)"),
    ("execl", "int(const char *, const char *, ...)"),
    ("execle", "int(const char *, const char *, ...)"),
    ("execlp", "int(const char *, const char *, ...)"),
    ("execv", "int(const char *, char *const *)"),
    ("execve", "int(const char *, char *const *, char *const *)"),
    ("execvp", "int(const char *, char *const *)"),
    ("exit", "_Noreturn void(int)"),
    ("exp", "double(double)"), ("exp2", "double(double)"), ("exp2f", "float(float)"),
    ("exp2l", "long double(long double)"), ("expf", "float(float)"),
    ("expl", "long double(long double)"), ("expm1", "double(double)"),
    ("expm1f", "float(float)"), ("expm1l", "long double(long double)"),
    ("fdim", "double(double, double)"), ("fdimf", "float(float, float)"),
    ("fdiml", "long double(long double, long double)"),
    ("feclearexcept", "int(int)"), ("fegetround", "int(void)"), ("feraiseexcept", "int(int)"),
    ("fesetround", "int(int)"), ("fetestexcept", "int(int)"),
    ("floor", "double(double)"), ("floorf", "float(float)"),
    ("floorl", "long double(long double)"),
    ("fma", "double(double, double, double)"), ("fmaf", "float(float, float, float)"),
    ("fmal", "long double(long double, long double, long double)"),
    ("fmax", "double(double, double)"), ("fmaxf", "float(float, float)"),
    ("fmaxl", "long double(long double, long double)"),
    ("fmin", "double(double, double)"), ("fminf", "float(float, float)"),
    ("fminl", "long double(long double, long double)"),
    ("fmod", "double(double, double)"), ("fmodf", "float(float, float)"),
    ("fmodl", "long double(long double, long double)"),
    ("fork", "pid_t(void)"), ("fprintf", "int(FILE *, const char *, ...)"),
    ("fputc", "int(int, FILE *)"), ("fputs", "int(const char *, FILE *)"),
    ("free", "void(void *)"), ("frexp", "double(double, int *)"),
    ("frexpl", "long double(long double, int *)"),
    ("fscanf", "int(FILE *, const char *, ...)"),
    ("fwrite", "size_t(const void *, size_t, size_t, FILE *)"),
    ("gettext", "char *(const char *)"),
    ("hypot", "double(double, double)"), ("hypotf", "float(float, float)"),
    ("hypotl", "long double(long double, long double)"),
    ("ilogb", "int(double)"), ("ilogbf", "int(float)"), ("ilogbl", "int(long double)"),
    ("index", "char *(const char *, int)"),
    ("isalnum", "int(int)"), ("isalpha", "int(int)"), ("iscntrl", "int(int)"),
    ("isgraph", "int(int)"), ("islower", "int(int)"), ("isprint", "int(int)"),
    ("ispunct", "int(int)"), ("isspace", "int(int)"), ("isupper", "int(int)"),
    ("iswalnum", "int(wint_t)"), ("iswalpha", "int(wint_t)"), ("iswblank", "int(wint_t)"),
    ("iswcntrl", "int(wint_t)"), ("iswdigit", "int(wint_t)"), ("iswgraph", "int(wint_t)"),
    ("iswlower", "int(wint_t)"), ("iswprint", "int(wint_t)"), ("iswpunct", "int(wint_t)"),
    ("iswspace", "int(wint_t)"), ("iswupper", "int(wint_t)"), ("iswxdigit", "int(wint_t)"),
    ("isxdigit", "int(int)"),
    ("ldexp", "double(double, int)"), ("ldexpl", "long double(long double, int)"),
    ("llrint", "long long(double)"), ("llrintl", "long long(long double)"),
    ("llround", "long long(double)"), ("llroundl", "long long(long double)"),
    ("log", "double(double)"), ("log10", "double(double)"), ("log10f", "float(float)"),
    ("log10l", "long double(long double)"), ("log1p", "double(double)"),
    ("log1pf", "float(float)"), ("log1pl", "long double(long double)"),
    ("log2", "double(double)"), ("log2l", "long double(long double)"),
    ("logf", "float(float)"), ("logl", "long double(long double)"),
    ("lrint", "long(double)"), ("lrintl", "long(long double)"),
    ("lround", "long(double)"), ("lroundl", "long(long double)"),
    ("malloc", "void *(size_t)"), ("memchr", "void *(const void *, int, size_t)"),
    ("memcmp", "int(const void *, const void *, size_t)"),
    ("mempcpy", "void *(void *, const void *, size_t)"),
    ("modf", "double(double, double *)"), ("modfl", "long double(long double, long double *)"),
    ("nearbyint", "double(double)"), ("nearbyintf", "float(float)"),
    ("nearbyintl", "long double(long double)"),
    ("nextafter", "double(double, double)"), ("nextafterf", "float(float, float)"),
    ("nextafterl", "long double(long double, long double)"),
    ("posix_memalign", "int(void **, size_t, size_t)"),
    ("pow", "double(double, double)"), ("powf", "float(float, float)"),
    ("powl", "long double(long double, long double)"),
    ("printf", "int(const char *, ...)"), ("putc", "int(int, FILE *)"),
    ("putc_unlocked", "int(int, FILE *)"), ("putchar", "int(int)"),
    ("puts", "int(const char *)"), ("realloc", "void *(void *, size_t)"),
    ("remainder", "double(double, double)"), ("remainderf", "float(float, float)"),
    ("remainderl", "long double(long double, long double)"),
    ("rindex", "char *(const char *, int)"),
    ("rint", "double(double)"), ("rintf", "float(float)"), ("rintl", "long double(long double)"),
    ("round", "double(double)"), ("roundf", "float(float)"),
    ("roundl", "long double(long double)"),
    ("scalbln", "double(double, long)"), ("scalblnf", "float(float, long)"),
    ("scalblnl", "long double(long double, long)"),
    ("scalbn", "double(double, int)"), ("scalbnf", "float(float, int)"),
    ("scalbnl", "long double(long double, int)"),
    ("scanf", "int(const char *, ...)"),
    ("sin", "double(double)"), ("sinf", "float(float)"), ("sinh", "double(double)"),
    ("sinhl", "long double(long double)"), ("sinl", "long double(long double)"),
    ("snprintf", "int(char *, size_t, const char *, ...)"),
    ("sprintf", "int(char *, const char *, ...)"),
    ("sqrt", "double(double)"), ("sqrtf", "float(float)"), ("sqrtl", "long double(long double)"),
    ("sscanf", "int(const char *, const char *, ...)"),
    ("strcasecmp", "int(const char *, const char *)"),
    ("strcat", "char *(char *, const char *)"), ("strchr", "char *(const char *, int)"),
    ("strcmp", "int(const char *, const char *)"), ("strcpy", "char *(char *, const char *)"),
    ("strcspn", "size_t(const char *, const char *)"), ("strdup", "char *(const char *)"),
    ("strftime", "size_t(char *, size_t, const char *, const struct tm *)"),
    ("strlen", "size_t(const char *)"),
    ("strncasecmp", "int(const char *, const char *, size_t)"),
    ("strncat", "char *(char *, const char *, size_t)"),
    ("strncmp", "int(const char *, const char *, size_t)"),
    ("strncpy", "char *(char *, const char *, size_t)"),
    ("strndup", "char *(const char *, size_t)"), ("strnlen", "size_t(const char *, size_t)"),
    ("strpbrk", "char *(const char *, const char *)"), ("strrchr", "char *(const char *, int)"),
    ("strspn", "size_t(const char *, const char *)"),
    ("strstr", "char *(const char *, const char *)"),
    ("tan", "double(double)"), ("tanf", "float(float)"), ("tanh", "double(double)"),
    ("tanhl", "long double(long double)"), ("tanl", "long double(long double)"),
    ("tgamma", "double(double)"), ("tgammaf", "float(float)"),
    ("tgammal", "long double(long double)"),
    ("tolower", "int(int)"), ("toupper", "int(int)"),
    ("towlower", "wint_t(wint_t)"), ("towupper", "wint_t(wint_t)"),
    ("trunc", "double(double)"), ("truncf", "float(float)"),
    ("truncl", "long double(long double)"),
    ("vfprintf", "int(FILE *, const char *, va_list)"),
    ("vprintf", "int(const char *, va_list)"),
    ("vsnprintf", "int(char *, size_t, const char *, va_list)"),
    ("vsprintf", "int(char *, const char *, va_list)"),
    ("vsscanf", "int(const char *, const char *, va_list)"),
    ("wcschr", "wchar_t *(const wchar_t *, wchar_t)"),
    ("wcscmp", "int(const wchar_t *, const wchar_t *)"), ("wcslen", "size_t(const wchar_t *)"),
    ("wcsncmp", "int(const wchar_t *, const wchar_t *, size_t)"),
    ("wmemchr", "wchar_t *(const wchar_t *, wchar_t, size_t)"),
    ("wmemcmp", "int(const wchar_t *, const wchar_t *, size_t)"),
    ("wmemcpy", "wchar_t *(wchar_t *, const wchar_t *, size_t)"),
    ("wmemmove", "wchar_t *(wchar_t *, const wchar_t *, size_t)"),
];

/// The library functions builtins formed at the call site call where they
/// decline to expand, with gcc's prototypes.
pub(super) const FALLBACK_FUNCTIONS: &[(&str, &str)] = &[
    ("memcpy", "void *(void *, const void *, size_t)"),
    ("memmove", "void *(void *, const void *, size_t)"),
    ("memset", "void *(void *, int, size_t)"),
    ("nan", "double(const char *)"),
    ("nanf", "float(const char *)"),
];

/// Whether `name` is an MSVC intrinsic `target` lowers at the call site.
pub(crate) fn is_ms_intrinsic(name: &str, target: Target) -> bool {
    crate::c5::ms_intrinsic::lookup(name, target).is_some()
}

fn lookup(name: &str) -> Option<&'static Builtin> {
    BUILTINS.iter().find(|b| b.name == name)
}

fn registry_id(supply: Supply, target: Target) -> Option<i64> {
    match supply {
        Supply::Registry(kind) | Supply::Library(kind) => Some(kind as i64),
        Supply::RegistryByLong { lp64, llp64 } => Some(if target.long_width_bytes() == 8 {
            lp64 as i64
        } else {
            llp64 as i64
        }),
        Supply::Direct => None,
    }
}

/// The registry entries seeded at preprocessor construction: every
/// builtin usable with no header that lowers through the registry.
pub(super) fn preseeded(target: Target) -> impl Iterator<Item = (&'static str, i64)> {
    BUILTINS.iter().filter_map(move |b| match b.supply {
        Supply::Registry(_) | Supply::RegistryByLong { .. } => {
            registry_id(b.supply, target).map(|id| (b.name, id))
        }
        Supply::Direct | Supply::Library(_) => None,
    })
}

/// The library function a `__builtin_*` name stands for, or `None` when
/// the name is not one of the aliases. The parser binds a call site to
/// that function directly, which is what keeps the builtin out of reach
/// of a translation unit's macro of the library name.
pub(crate) fn library_alias(name: &str) -> Option<&'static str> {
    let fn_name = name.strip_prefix("__builtin_")?;
    let at = LIBRARY_BUILTINS
        .binary_search_by(|(f, _)| (*f).cmp(fn_name))
        .ok()?;
    Some(LIBRARY_BUILTINS[at].0)
}

/// The prototype gcc gives the builtin calling library function
/// `fn_name`, in the tables' C spelling.
pub(crate) fn library_prototype(fn_name: &str) -> Option<&'static str> {
    LIBRARY_BUILTINS
        .iter()
        .chain(FALLBACK_FUNCTIONS)
        .find(|(f, _)| *f == fn_name)
        .map(|&(_, proto)| proto)
}

/// The intrinsic a `__builtin_` alias lowers to whatever the unit
/// declares: the one its library function's header binds.
pub(crate) fn library_alias_intrinsic(name: &str) -> Option<Intrinsic> {
    let fn_name = library_alias(name)?;
    match lookup(fn_name)?.supply {
        Supply::Library(kind) => Some(kind),
        _ => None,
    }
}

/// `#pragma intrinsic(name)`: the registry discriminant to record, or
/// `None` when badc supplies the name without the registry. `None` and
/// [`is_builtin`] false differ: the first registers nothing, the second
/// is a diagnostic.
pub(super) fn intrinsic_id(name: &str, target: Target) -> Option<i64> {
    registry_id(lookup(name)?.supply, target)
}

/// Whether `name` is a builtin at all, in any supply route.
pub(super) fn is_builtin(name: &str) -> bool {
    lookup(name).is_some() || library_alias(name).is_some()
}

/// `__has_builtin(name)` (C23 6.10.1, clang/gcc practice): 1 when a
/// translation unit for `target` can use `name` with no `#include`. The
/// x86 vector builtins are the x86 targets' only.
pub(super) fn has_builtin(name: &str, target: Target) -> bool {
    if is_ms_intrinsic(name, target) {
        return true;
    }
    match lookup(name) {
        Some(b) => !matches!(b.supply, Supply::Library(_)),
        None => {
            library_alias(name).is_some()
                || (target.is_x86_64() && crate::c5::x86_simd::lookup(name).is_some())
        }
    }
}

/// The feature-test operators badc provides. They are not macros, but
/// `#ifdef` / `defined(...)` on their names reports true so headers can
/// guard the operator before using it.
pub(super) const OPERATORS: &[&str] = &[
    "__has_include",
    "__has_include_next",
    "__has_builtin",
    "__has_attribute",
];

pub(super) fn is_operator_name(name: &str) -> bool {
    OPERATORS.contains(&name)
}
