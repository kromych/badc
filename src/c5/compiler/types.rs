//! Type-system helpers for the c5 compiler.
//!
//! Pulled out of `compiler/mod.rs` because they're all pure functions
//! over the `i64` type-tag encoding -- no `Compiler` access, no
//! mutable state -- and the parser, codegen lowering, and constant
//! folder all reach for them. Keeping the helpers in their own file
//! makes the parser entry points easier to scan; nothing else changed.
//!
//! ## Type-tag encoding
//!
//! Every value type in c5 is an `i64` tag whose layout is:
//!
//! ```text
//!   Ty::Char (= 0)         band: [0, 1) for scalars, +2 per `*` level
//!   Ty::Int  (= 1)         band: [1, 100) -- shares the integer band
//!                          with `char`, even/odd alternation by `*`
//!   Ty::Float  (= 100)     band: [100, 200)
//!   Ty::Double (= 200)     band: [200, 300)
//!   Ty::Long   (= 300)     band: [300, 400)
//!   <struct N>  (= 1000+N*1000)  STRUCT_BASE..; +2 per `*` inside band
//! ```
//!
//! Each non-integer band is 100 wide, supporting up to 50 `*` levels
//! per base type before the encoding wraps. Inside a band, the
//! existing `+= Ty::Ptr` arithmetic still adds one pointer level, so
//! `int*` = 3, `int**` = 5, `long*` = 302, `float**` = 104, etc.
//!
//! Struct types share the same `i64` namespace but live above
//! `STRUCT_BASE` (1000) with a 1000-wide stride per struct id. Within
//! a struct band, pointer depth still uses `+= Ty::Ptr`, so `struct
//! Foo *` is `STRUCT_BASE + N*STRIDE + 2`. The wide stride leaves
//! plenty of room for deeply-nested pointer levels without colliding
//! with the next struct id.

use super::super::ir::LoadKind;
use super::super::token::{Tok, Token, Ty};

/// Base of the struct-tag namespace. Every primitive (including
/// the long band at 300) sits below this.
pub(crate) const STRUCT_BASE: i64 = 1000;
/// Per-struct stride. Struct id `N` occupies `[STRUCT_BASE +
/// N*STRIDE, STRUCT_BASE + (N+1)*STRIDE)`.
pub(crate) const STRUCT_STRIDE: i64 = 1000;

/// Width of each non-struct band (float, double, long). 50 pointer
/// levels per band given the +2-per-`*` step.
const FP_BAND_SIZE: i64 = 100;

/// High-bit flag set on a type tag to mark its underlying integer
/// as unsigned. Orthogonal to the band scheme: stripped before any
/// band-classifier helper consults it (`is_pointer_ty`,
/// `is_long_ty`, `pointee_size_no_struct`, `load_op_for`, ...) so
/// the bit is invisible everywhere except the few sites that
/// directly query signedness (relational compares, signed/unsigned
/// load fixups). Set by `parse_decl_base_type` when the
/// declaration spelled `unsigned`, by typedef expansion of a
/// `typedef u32 ...` shape, and by struct-field type tagging.
///
/// Bit chosen well above the band ranges: `STRUCT_BASE +
/// N*STRIDE` for any plausible N stays under 1<<30, and the
/// non-struct bands max out at 400.
pub(crate) const UNSIGNED_BIT: i64 = 1 << 30;

/// `true` if `ty`'s underlying integer is tagged unsigned.
pub(crate) fn is_unsigned_ty(ty: i64) -> bool {
    (ty & UNSIGNED_BIT) != 0
}

/// High-bit flag marking a type tag `volatile`-qualified (C99 6.7.3).
/// Orthogonal to the band scheme like [`UNSIGNED_BIT`]: stripped by
/// [`strip_unsigned`] before any band classifier consults the tag. The
/// single bit does not record which indirection level carries the
/// qualifier, so `volatile T *`, `T * volatile`, and `volatile T`
/// all set it; every access through such a tag is treated as a
/// volatile access (a conservative over-approximation -- extra
/// volatility only inhibits optimization, per 5.1.2.3p2 an access to
/// a volatile object may not be elided or coalesced).
pub(crate) const VOLATILE_BIT: i64 = 1 << 29;

/// `true` if `ty` carries the volatile qualifier at any level.
pub(crate) fn is_volatile_ty(ty: i64) -> bool {
    (ty & VOLATILE_BIT) != 0
}

/// Apply a C99 6.3.1.3 integer conversion to a constant value:
/// narrow to `bytes` width and re-interpret by the target's
/// signedness. `_Bool` maps any nonzero value to 1 (6.3.1.2). An
/// 8-byte target keeps the full `i64` (pointers and `long long`
/// included). Used by the constant-expression evaluator so a cast
/// like `(int)UINT_MAX` folds to `-1` at parse time rather than
/// retaining the un-narrowed operand.
pub(crate) fn narrow_const_int(bytes: usize, unsigned: bool, is_bool: bool, v: i64) -> i64 {
    if is_bool {
        return (v != 0) as i64;
    }
    if bytes >= 8 {
        return v;
    }
    let bits = (bytes * 8) as u32;
    let mask: i64 = ((1u64 << bits) - 1) as i64;
    let truncated = v & mask;
    if unsigned {
        truncated
    } else {
        let sign_bit: i64 = 1i64 << (bits - 1);
        (truncated ^ sign_bit).wrapping_sub(sign_bit)
    }
}

/// Drop the qualifier bits (`UNSIGNED_BIT`, `VOLATILE_BIT`). Use to
/// recover the bare band-encoded type before consulting a helper that
/// classifies by band. Most of the helpers in this module call this at
/// their entry; outside callers only need it when storing a type tag
/// where a non-bit-flagged tag is expected (e.g., switch-table
/// comparisons against `Ty::Int as i64`).
pub(crate) fn strip_unsigned(ty: i64) -> i64 {
    ty & !(UNSIGNED_BIT | VOLATILE_BIT)
}

/// Round `x` up to the nearest multiple of `alignment` (which must
/// be a power of two). Used by struct-field layout, struct-tail
/// padding, bitfield-storage placement, and any other code that
/// needs `(x + alignment-1) & ~(alignment-1)` -- the helper makes
/// the intent explicit and centralises the +1/!mask off-by-one
/// trap in one place.
pub(super) fn round_up(x: usize, alignment: usize) -> usize {
    let mask = alignment - 1;
    (x + mask) & !mask
}

/// Render a c5 type tag back into a C-like spelling: `int`, `char *`,
/// `unsigned long **`, `struct ShellText *`, etc. Used by the
/// redeclaration-mismatch warning so the user can see the prior and
/// current signatures rather than just "different parameter list".
/// `structs` is the compiler's struct registry -- when supplied, the
/// renderer looks up the struct's source name; the fallback
/// `struct@N` shows up only when the table isn't reachable
/// (e.g. unit tests that build types by hand).
pub(super) fn format_type(ty: i64, structs: &[super::StructDef]) -> alloc::string::String {
    use alloc::format;
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    let bare = strip_unsigned(ty);
    let prefix = if unsigned { "unsigned " } else { "" };
    if bare >= STRUCT_BASE {
        let id = struct_id_of(bare);
        let depth = struct_ptr_depth(bare) as usize;
        let name = structs
            .get(id)
            .map(|s| s.name.as_str())
            .filter(|n| !n.is_empty())
            .map(alloc::string::ToString::to_string)
            .unwrap_or_else(|| format!("@{id}"));
        return format!("{prefix}struct {name}{}", "*".repeat(depth));
    }
    let (base, leaf) = if in_band(bare, Ty::Float as i64) {
        (Ty::Float as i64, "float")
    } else if in_band(bare, Ty::Double as i64) {
        (Ty::Double as i64, "double")
    } else if in_band(bare, Ty::Long as i64) {
        (Ty::Long as i64, "long")
    } else if in_band(bare, Ty::Short as i64) {
        (Ty::Short as i64, "short")
    } else if in_band(bare, Ty::LongLong as i64) {
        (Ty::LongLong as i64, "long long")
    } else if in_band(bare, Ty::Bool as i64) {
        (Ty::Bool as i64, "_Bool")
    } else if (0..100).contains(&bare) {
        // Integer family: char = 0, int = 1, then +2 per `*` level.
        let depth = (bare / 2) as usize;
        let leaf_char = bare % 2 == 0;
        let name = if leaf_char { "char" } else { "int" };
        return format!("{prefix}{name}{}", "*".repeat(depth));
    } else {
        return format!("{prefix}ty@{bare}");
    };
    let depth = ((bare - base) / 2) as usize;
    format!("{prefix}{leaf}{}", "*".repeat(depth))
}

/// Render a function signature: `<return> (<params>[, ...])`. Used by
/// the redeclaration-mismatch warning to print the prior and current
/// shapes side-by-side. `structs` plumbs through to `format_type` so
/// struct-typed parameters render as `struct Name *` instead of
/// `struct@N *`.
pub(super) fn format_signature(
    return_ty: i64,
    params: &[i64],
    is_variadic: bool,
    structs: &[super::StructDef],
) -> alloc::string::String {
    use alloc::format;
    use alloc::string::ToString;
    let mut parts: alloc::vec::Vec<alloc::string::String> =
        params.iter().map(|&p| format_type(p, structs)).collect();
    if is_variadic {
        parts.push("...".to_string());
    }
    let inside = if parts.is_empty() {
        // Empty here means "explicit zero-param" at the call site --
        // C99's "no information" prototype is filtered out before
        // we get here; just print `(void)` for clarity.
        "void".to_string()
    } else {
        parts.join(", ")
    };
    format!("{} ({inside})", format_type(return_ty, structs))
}

pub(crate) fn is_struct_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    ty >= STRUCT_BASE
}

pub(crate) fn struct_id_of(ty: i64) -> usize {
    let ty = strip_unsigned(ty);
    ((ty - STRUCT_BASE) / STRUCT_STRIDE) as usize
}

pub(crate) fn struct_ptr_depth(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    ((ty - STRUCT_BASE) % STRUCT_STRIDE) / Ty::Ptr as i64
}

pub(super) fn struct_ty_for(id: usize) -> i64 {
    STRUCT_BASE + (id as i64) * STRUCT_STRIDE
}

/// True when `ty` (unsigned bit stripped) lands in the 100-wide band
/// starting at `base`. Each non-integer scalar family (`_Bool`, float,
/// double, long, long long, short) reserves its own band; the +2-per-`*`
/// scheme places pointers inside it.
fn in_band(ty: i64, base: i64) -> bool {
    let ty = strip_unsigned(ty);
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// Pointer depth within the band starting at `base`: 0 for the scalar,
/// 1 for `*`, 2 for `**`, ...; 0 when `ty` is not in the band.
fn band_ptr_depth(ty: i64, base: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if in_band(ty, base) {
        (ty - base) / Ty::Ptr as i64
    } else {
        0
    }
}

/// `ty` is a `_Bool` (or pointer to one). `_Bool` lives in its own
/// 100-wide band starting at `Ty::Bool` (600); the same +2-per-`*`
/// scheme as the integer family applies inside the band, so
/// `_Bool*` = 602, `_Bool**` = 604, etc.
pub(crate) fn is_bool_ty(ty: i64) -> bool {
    in_band(ty, Ty::Bool as i64)
}

/// Pointer depth within the bool band. Returns 0 for a scalar
/// `_Bool`, 1 for `_Bool*`, etc.
pub(super) fn bool_ptr_depth(ty: i64) -> i64 {
    band_ptr_depth(ty, Ty::Bool as i64)
}

pub(crate) fn is_float_ty(ty: i64) -> bool {
    in_band(ty, Ty::Float as i64)
}

pub(crate) fn is_double_ty(ty: i64) -> bool {
    in_band(ty, Ty::Double as i64)
}

/// `ty` is a `long` (or pointer to one). Long lives in its own
/// 100-wide band starting at `Ty::Long`; the same +2-per-`*`
/// scheme as the integer family applies inside the band, so
/// `long*` = 302, `long**` = 304, etc.
pub(crate) fn is_long_ty(ty: i64) -> bool {
    in_band(ty, Ty::Long as i64)
}

/// Pointer depth within the long band. Returns 0 for a scalar
/// `long`, 1 for `long*`, 2 for `long**`, etc.
pub(super) fn long_ptr_depth(ty: i64) -> i64 {
    band_ptr_depth(ty, Ty::Long as i64)
}

/// `ty` is a `long long` (or pointer to one). Long-long lives in
/// its own 100-wide band starting at `Ty::LongLong` (500); the
/// same +2-per-`*` scheme as the integer family applies inside
/// the band, so `long long*` = 502, `long long**` = 504, etc.
pub(crate) fn is_long_long_ty(ty: i64) -> bool {
    in_band(ty, Ty::LongLong as i64)
}

/// Pointer depth within the long-long band. Returns 0 for a
/// scalar `long long`, 1 for `long long*`, etc.
pub(super) fn long_long_ptr_depth(ty: i64) -> i64 {
    band_ptr_depth(ty, Ty::LongLong as i64)
}

/// C99 6.3.1.1 integer promotions: any operand whose rank is below
/// `int` (i.e. char or short, signed or unsigned) is converted to
/// `int` for the purpose of arithmetic. The signed-int range can
/// hold every value of the original type because c5's int is 4
/// bytes vs char's 1 / short's 2, so the result is always the
/// signed `Ty::Int` -- the "convert to unsigned int" branch of the
/// C99 rule never fires here.
pub(super) fn integer_promote(ty: i64) -> i64 {
    let stripped = strip_unsigned(ty);
    // `_Bool` (6.3.1.1) and the sub-int integer types all have a
    // rank below `int` and every value they hold fits in a signed
    // `int`, so they promote to signed `int`.
    if stripped == Ty::Char as i64 || stripped == Ty::Short as i64 || stripped == Ty::Bool as i64 {
        Ty::Int as i64
    } else {
        ty
    }
}

/// C99 integer-conversion rank for the post-integer-promotion
/// types c5 supports. Higher number = higher rank; the actual
/// values are arbitrary, only ordering matters.
///   int        -> 1
///   long       -> 2
///   long long  -> 3
fn integer_rank(ty: i64) -> u8 {
    let stripped = strip_unsigned(ty);
    if is_long_long_ty(stripped) {
        3
    } else if is_long_ty(stripped) {
        2
    } else {
        // Already integer-promoted, so int / unsigned int.
        1
    }
}

/// True if a signed type of `signed_rank` can represent every value
/// of an unsigned type at `unsigned_rank` on `target`.
///
/// On LP64 (`long` is 8 bytes), signed long holds all uint values.
/// On LLP64 (`long` is 4 bytes), signed long is the same width as
/// unsigned int, so it can't represent uint's high half. Long long
/// (always 8 bytes) holds all uint values everywhere; it also holds
/// all unsigned long values on LLP64 but not on LP64 (where ulong
/// is also 8 bytes).
fn signed_holds_unsigned(signed_rank: u8, unsigned_rank: u8, target: super::super::Target) -> bool {
    if target.is_windows() {
        // LLP64: int=4, long=4, long long=8.
        // signed long long (rank 3) holds unsigned int (rank 1) and
        //   unsigned long (rank 2).
        // signed long (rank 2) is same width as unsigned int (rank 1)
        //   -- cannot hold its high values.
        // signed int (rank 1) is same width as unsigned int (rank 1)
        //   -- already same rank, doesn't hit this path.
        signed_rank == 3 && unsigned_rank <= 2
    } else {
        // LP64: int=4, long=8, long long=8.
        // signed long (rank 2) holds unsigned int (rank 1).
        // signed long long (rank 3) holds unsigned int (rank 1).
        // signed long long (rank 3) does NOT hold unsigned long
        //   (rank 2) -- they're the same width.
        signed_rank >= 2 && unsigned_rank == 1
    }
}

/// C99 6.3.1.8 usual arithmetic conversions: pick the common type
/// for a binary integer operation. Used by relational compares to
/// decide between the signed (`BinOp::Lt/Gt/Le/Ge`) and unsigned
/// (`BinOp::Ult/Ugt/Ule/Uge`) variants, and by arithmetic to tag the
/// result type so subsequent shifts / compares route correctly.
///
/// Algorithm:
///   1. Apply integer promotions to both operands (char / short
///      -> int).
///   2. If both promoted operands have the same signedness, the
///      common type is the higher-rank one with the same
///      signedness.
///   3. If mixed signedness:
///      a. If the unsigned operand's rank >= the signed operand's,
///         the common type is unsigned at the unsigned rank.
///      b. Else if the signed type can hold every value of the
///         unsigned type (depends on the target's data model),
///         the common type is signed at the signed rank.
///      c. Otherwise the common type is unsigned at the signed
///         operand's rank.
///
/// The data-model-dependent step is rule (b): on LP64 a signed
/// long can hold all unsigned int values (long is wider); on LLP64
/// it can't (long and unsigned int are both 32-bit), so unsigned
/// wins. `Ty::LongLong` wins everywhere it appears.
pub(super) fn usual_arith_common_ty(a: i64, b: i64, target: super::super::Target) -> i64 {
    let a = integer_promote(a);
    let b = integer_promote(b);
    let a_unsigned = is_unsigned_ty(a);
    let b_unsigned = is_unsigned_ty(b);
    let a_rank = integer_rank(a);
    let b_rank = integer_rank(b);
    let max_rank = a_rank.max(b_rank);

    let (result_rank, result_unsigned) = if a_unsigned == b_unsigned {
        // Same signedness: higher rank wins, signedness preserved.
        (max_rank, a_unsigned)
    } else {
        // Mixed signedness. Identify the (rank, signedness) of
        // each operand class.
        let (u_rank, s_rank) = if a_unsigned {
            (a_rank, b_rank)
        } else {
            (b_rank, a_rank)
        };
        if u_rank >= s_rank {
            // Unsigned wins.
            (u_rank, true)
        } else if signed_holds_unsigned(s_rank, u_rank, target) {
            // Signed wins (signed type can hold all unsigned values).
            (s_rank, false)
        } else {
            // Signed has higher rank but can't hold the unsigned's
            // values: result is unsigned at the signed's rank.
            (s_rank, true)
        }
    };

    let base = match result_rank {
        3 => Ty::LongLong as i64,
        2 => Ty::Long as i64,
        _ => Ty::Int as i64,
    };
    if result_unsigned {
        base | UNSIGNED_BIT
    } else {
        base
    }
}

/// `ty` is a `short` (or pointer to one). Short lives in its own
/// 100-wide band starting at `Ty::Short` (400); the same +2-per-`*`
/// scheme as the integer family applies inside the band, so
/// `short*` = 402, `short**` = 404, etc.
pub(super) fn is_short_ty(ty: i64) -> bool {
    in_band(ty, Ty::Short as i64)
}

/// Pointer depth within the short band. Returns 0 for a scalar
/// `short`, 1 for `short*`, 2 for `short**`, etc.
pub(super) fn short_ptr_depth(ty: i64) -> i64 {
    band_ptr_depth(ty, Ty::Short as i64)
}

/// `ty` is a value of any floating-point type (or pointer to one).
pub(super) fn is_floating_ty(ty: i64) -> bool {
    is_float_ty(ty) || is_double_ty(ty)
}

/// `ty` is a *scalar* float/double -- not a pointer to one.
pub(super) fn is_floating_scalar(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    ty == Ty::Float as i64 || ty == Ty::Double as i64
}

pub(super) fn fp_ptr_depth(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if is_float_ty(ty) {
        (ty - Ty::Float as i64) / Ty::Ptr as i64
    } else if is_double_ty(ty) {
        (ty - Ty::Double as i64) / Ty::Ptr as i64
    } else {
        0
    }
}

/// True if `ty` represents a pointer (any base type, any depth).
/// Used everywhere the integer-family `>= Ty::Ptr` test was the
/// quick proxy for "is a pointer"; the bands for floats, longs,
/// and structs have their own depth predicates that this helper
/// unifies.
pub(crate) fn is_pointer_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    if is_struct_ty(ty) {
        struct_ptr_depth(ty) > 0
    } else if is_floating_ty(ty) {
        fp_ptr_depth(ty) > 0
    } else if is_long_long_ty(ty) {
        long_long_ptr_depth(ty) > 0
    } else if is_long_ty(ty) {
        long_ptr_depth(ty) > 0
    } else if is_short_ty(ty) {
        short_ptr_depth(ty) > 0
    } else if is_bool_ty(ty) {
        bool_ptr_depth(ty) > 0
    } else {
        ty >= Ty::Ptr as i64
    }
}

/// Element size in bytes of a pointee for the given pointer type
/// (without struct-table awareness).
///   * `char*` -> 1 byte
///   * one-level `int*` -> 4 bytes (`int` is 32-bit)
///   * one-level `long*` -> 8 bytes
///   * deeper pointers (`int**`, `long**`, etc.) -> 8 bytes
///     (because the pointee is itself a pointer)
///   * `float*` / `double*` -> 8 (c5 keeps FP at 8 bytes; the
///     IEEE 754 single-precision narrowing is future work)
/// Pointer-to-struct goes through [`Compiler::pointee_size`]
/// instead so the scale picks up the struct's real size.
pub(super) fn pointee_size_no_struct(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if ty == Ty::Ptr as i64 {
        1
    } else if ty == (Ty::Int as i64) + (Ty::Ptr as i64) {
        // Bare `int*` -- pointee is a 4-byte int.
        4
    } else if ty == (Ty::Short as i64) + (Ty::Ptr as i64) {
        // Bare `short*` -- pointee is a 2-byte short.
        2
    } else if ty == (Ty::Bool as i64) + (Ty::Ptr as i64) {
        // Bare `_Bool*` -- pointee is a 1-byte `_Bool`.
        1
    } else if ty == (Ty::Float as i64) + (Ty::Ptr as i64) {
        // Bare `float*` -- pointee is a 4-byte single-precision
        // float; `(float *)p + 1` strides four bytes, and the
        // single-precision narrow-load `LoadKind::F32` reads the same
        // 4 bytes.
        4
    } else {
        8
    }
}

/// Result type for a binary FP operation. Both operands are
/// floating-point scalars; if either is `double`, the result is
/// `double`, otherwise `float`. Mirrors the C standard's "usual
/// arithmetic conversions" for FP operands. Internally both flow
/// through f64 ops anyway -- the type is purely for downstream
/// type-warning bookkeeping.
pub(super) fn fp_result_ty(lhs: i64, rhs: i64) -> i64 {
    let lhs = strip_unsigned(lhs);
    let rhs = strip_unsigned(rhs);
    if lhs == Ty::Double as i64 || rhs == Ty::Double as i64 {
        Ty::Double as i64
    } else {
        Ty::Float as i64
    }
}

/// True for any token that may be freely consumed at a declaration
/// prefix as a no-op: type qualifiers (`const`/`volatile`/`restrict`),
/// integer-type modifiers (`signed`/`unsigned`/`short`/`long`/`_Bool`),
/// and function specifiers (`inline`/`register`/`auto`). The
/// `signed`, `unsigned`, and `long` modifiers carry semantic weight
/// (`signed` affects `char`'s signedness; `unsigned` flips the
/// type-tag bit that routes compares through unsigned ops; `long`
/// selects the 64-bit `Ty::Long` storage class), but at the
/// *modifier-loop* level they're still consumed by
/// `parse_decl_base_type` -- they drive flag bits rather than
/// producing a separate token stream.
pub(super) fn is_decl_modifier(tk: Tok) -> bool {
    tk == Token::TypeQual
        || tk == Token::IntMod
        || tk == Token::Signed
        || tk == Token::Unsigned
        || tk == Token::Long
        || tk == Token::Short
        || tk == Token::FuncSpec
        || tk == Token::Inline
        || tk == Token::Noreturn
        || tk == Token::Atomic
        || tk == Token::Attribute
}

/// True for any token that may start a c5 declaration -- a base-type
/// keyword, a struct prefix, a storage-class prefix, or any of the
/// no-op modifiers above. Used by the parser to decide whether the
/// next statement at block/file scope is a declaration or an
/// expression / control-flow statement.
pub(super) fn is_type_start_token(tk: Tok) -> bool {
    tk == Token::Int
        || tk == Token::Char
        || tk == Token::Void
        || tk == Token::Float
        || tk == Token::Double
        || tk == Token::Struct
        || tk == Token::Union
        || tk == Token::Enum
        || tk == Token::Extern
        || tk == Token::Static
        || tk == Token::Typeof
        || is_decl_modifier(tk)
}

/// Pick the right load op for the given `ty`, factoring in the
/// target's data model (LP64 vs LLP64 picks for `long`).
///   * `Ty::Char` (scalar)   -> `LoadKind::U8` / `LoadKind::I8` (1-byte)
///   * `Ty::Short` (scalar)  -> `LoadKind::I16` / `LoadKind::U16` (2-byte)
///   * `Ty::Int` (scalar)    -> `LoadKind::I32`  / `LoadKind::U32` (4-byte)
///   * `Ty::Long` (scalar)   -> 4-byte on Windows / 8-byte on Unix
///   * `Ty::LongLong` (scalar) -> always 8-byte (`LoadKind::I64`)
///   * everything else       -> `LoadKind::I64`
///
/// Pointers (any base type) go through `LoadKind::I64` because every
/// pointer is 8 bytes regardless of its pointee width or target.
///
/// The signed / unsigned split for `char` / `short` / `int`
/// picks between the sign- and zero-extending load ops; the
/// matching store widths (1 / 2 / 4 / 8 bytes) don't care
/// about signedness.
/// Load-instruction kind for a scalar `ty`. Every arm is
/// consumer-independent except the `double` leaf, which differs by
/// backend: the parser's trailing-load classifier carries the f64 bit
/// pattern in a GPR (it passes `LoadKind::I64`), while the SSA backend
/// loads a `double` into an FP register (it passes `LoadKind::F64`).
pub(crate) fn load_kind(ty: i64, target: super::super::Target, double_kind: LoadKind) -> LoadKind {
    let unsigned = is_unsigned_ty(ty);
    let stripped = strip_unsigned(ty);
    if is_pointer_ty(ty) {
        // Pointers are always 8 bytes; the Long-vs-LongLong and
        // Float-vs-Double distinctions must not narrow a pointer load.
        return LoadKind::I64;
    }
    if stripped == Ty::Bool as i64 {
        // `_Bool` is a 1-byte slot holding 0 or 1; always
        // zero-extends on load.
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
        // 4-byte single-precision load that widens to f64.
        LoadKind::F32
    } else if stripped == Ty::Double as i64 {
        double_kind
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        // LLP64: `long` is 32 bits, same load path as int.
        if unsigned {
            LoadKind::U32
        } else {
            LoadKind::I32
        }
    } else {
        LoadKind::I64
    }
}

pub(super) fn load_op_for(ty: i64, target: super::super::Target) -> LoadKind {
    // The parser carries a `double` as its 8-byte f64 bit pattern in a
    // GPR, so the double leaf is I64.
    load_kind(ty, target, LoadKind::I64)
}

#[cfg(test)]
mod ty_tag {
    use super::*;
    // The +2-per-level even-stride pointer encoding -- the shape the
    // AST->SSA walker and DWARF emitter open-coded before they shared
    // `is_pointer_ty`. The base band ([0, 100): char / int) admits any
    // offset >= Ty::Ptr; every other band reserves even offsets.
    fn pointer_by_even_stride(ty: i64) -> bool {
        let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
        let base = stripped - (stripped % 100);
        let off = stripped - base;
        if base == 0 {
            off >= Ty::Ptr as i64
        } else {
            off >= 2 && (off % 2) == 0
        }
    }

    // Every tag a declarator actually emits: the char/int base band,
    // and the float/double/long/short/longlong/bool/struct bands at the
    // +2-per-level even stride.
    fn producible_tags() -> alloc::vec::Vec<i64> {
        let mut tags = alloc::vec::Vec::new();
        for t in 0..100i64 {
            tags.push(t);
        }
        for band in [
            Ty::Float as i64,
            Ty::Double as i64,
            Ty::Long as i64,
            Ty::Short as i64,
            Ty::LongLong as i64,
            Ty::Bool as i64,
        ] {
            for d in 0..40i64 {
                tags.push(band + d * Ty::Ptr as i64);
            }
        }
        for id in 0..8i64 {
            let sb = STRUCT_BASE + id * STRUCT_STRIDE;
            for d in 0..40i64 {
                tags.push(sb + d * Ty::Ptr as i64);
            }
        }
        tags
    }

    #[test]
    fn is_pointer_ty_matches_producible_tags() {
        for &ty in &producible_tags() {
            for u in [0i64, UNSIGNED_BIT] {
                let t = ty | u;
                assert_eq!(
                    is_pointer_ty(t),
                    pointer_by_even_stride(t),
                    "is_pointer_ty disagrees on producible tag {t}"
                );
            }
        }
        // The even-stride approximation misreads a struct pointer whose
        // depth is a multiple of STRUCT_STRIDE / Ty::Ptr (50): the offset
        // wraps to 0 mod 100. is_pointer_ty decodes the struct band
        // directly and is correct. No declarator emits 50 levels, so the
        // difference is unreachable, but it pins the canonical answer.
        let deep = STRUCT_BASE + 50 * Ty::Ptr as i64;
        assert!(is_pointer_ty(deep));
        assert!(!pointer_by_even_stride(deep));
    }
}
