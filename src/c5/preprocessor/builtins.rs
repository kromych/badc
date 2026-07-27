//! The compiler builtins badc provides.
//!
//! One table records how each name is supplied; the intrinsic registry
//! seeded at preprocessor construction, the `#pragma intrinsic` name
//! lookup and `__has_builtin` are all derived from it, so the three
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
    direct("__builtin_add_overflow"),
    direct("__builtin_sub_overflow"),
    direct("__builtin_mul_overflow"),
    // Hints with no code-generation effect: predefined as macros, either
    // by the preprocessor or by the auto-included <_builtins.h>.
    direct("__builtin_expect"),
    direct("__builtin_prefetch"),
    direct("__builtin_assume_aligned"),
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
];

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

/// `#pragma intrinsic(name)`: the registry discriminant to record, or
/// `None` when badc supplies the name without the registry. `None` and
/// [`is_builtin`] false differ: the first registers nothing, the second
/// is a diagnostic.
pub(super) fn intrinsic_id(name: &str, target: Target) -> Option<i64> {
    registry_id(lookup(name)?.supply, target)
}

/// Whether `name` is a builtin at all, in any supply route.
pub(super) fn is_builtin(name: &str) -> bool {
    lookup(name).is_some()
}

/// `__has_builtin(name)` (C23 6.10.1, clang/gcc practice): 1 when a
/// translation unit can use `name` with no `#include`.
pub(super) fn has_builtin(name: &str) -> bool {
    match lookup(name) {
        Some(b) => !matches!(b.supply, Supply::Library(_)),
        None => false,
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
