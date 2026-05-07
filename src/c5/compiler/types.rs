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

use super::super::op::Op;
use super::super::token::{Token, Ty};

/// Base of the struct-tag namespace. Every primitive (including
/// the long band at 300) sits below this.
pub(super) const STRUCT_BASE: i64 = 1000;
/// Per-struct stride. Struct id `N` occupies `[STRUCT_BASE +
/// N*STRIDE, STRUCT_BASE + (N+1)*STRIDE)`.
pub(super) const STRUCT_STRIDE: i64 = 1000;

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
pub(super) const UNSIGNED_BIT: i64 = 1 << 30;

/// `true` if `ty`'s underlying integer is tagged unsigned.
pub(super) fn is_unsigned_ty(ty: i64) -> bool {
    (ty & UNSIGNED_BIT) != 0
}

/// Drop the unsigned bit. Use to recover the bare band-encoded type
/// before consulting a helper that classifies by band. Most of the
/// helpers in this module call this at their entry; outside callers
/// only need it when storing a type tag where a non-bit-flagged tag
/// is expected (e.g., switch-table comparisons against `Ty::Int as
/// i64`).
pub(super) fn strip_unsigned(ty: i64) -> i64 {
    ty & !UNSIGNED_BIT
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

pub(super) fn is_struct_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    ty >= STRUCT_BASE
}

pub(super) fn struct_id_of(ty: i64) -> usize {
    let ty = strip_unsigned(ty);
    ((ty - STRUCT_BASE) / STRUCT_STRIDE) as usize
}

pub(super) fn struct_ptr_depth(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    ((ty - STRUCT_BASE) % STRUCT_STRIDE) / Ty::Ptr as i64
}

pub(super) fn struct_ty_for(id: usize) -> i64 {
    STRUCT_BASE + (id as i64) * STRUCT_STRIDE
}

pub(super) fn is_float_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    let base = Ty::Float as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

pub(super) fn is_double_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    let base = Ty::Double as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// `ty` is a `long` (or pointer to one). Long lives in its own
/// 100-wide band starting at `Ty::Long`; the same +2-per-`*`
/// scheme as the integer family applies inside the band, so
/// `long*` = 302, `long**` = 304, etc.
pub(super) fn is_long_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    let base = Ty::Long as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// Pointer depth within the long band. Returns 0 for a scalar
/// `long`, 1 for `long*`, 2 for `long**`, etc.
pub(super) fn long_ptr_depth(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if is_long_ty(ty) {
        (ty - Ty::Long as i64) / Ty::Ptr as i64
    } else {
        0
    }
}

/// C99 6.3.1.1 integer promotions: any operand whose rank is below
/// `int` (i.e. char or short, signed or unsigned) is converted to
/// `int` for the purpose of arithmetic. The signed-int range can
/// hold every value of the original type because c5's int is 4
/// bytes vs char's 1 / short's 2, so the result is always the
/// signed `Ty::Int` -- the "convert to unsigned int" branch of the
/// C99 rule never fires here.
fn integer_promote(ty: i64) -> i64 {
    let stripped = strip_unsigned(ty);
    if stripped == Ty::Char as i64 || stripped == Ty::Short as i64 {
        Ty::Int as i64
    } else {
        ty
    }
}

/// C99 6.3.1.8 usual arithmetic conversions: pick the common type
/// for a binary integer operation. Used by relational compares to
/// decide between the signed (`Op::Lt/Gt/Le/Ge`) and unsigned
/// (`Op::Ult/Ugt/Ule/Uge`) variants, and by arithmetic to tag the
/// result type so subsequent shifts / compares route correctly.
///
/// Algorithm:
///   1. Apply integer promotions to both operands (char / short
///      -> int).
///   2. If both promoted operands are signed or both are unsigned:
///      result is the larger-rank type with the same signedness.
///   3. If mixed: the unsigned operand "wins" when its rank is
///      greater than or equal to the signed operand's. When the
///      signed type has strictly higher rank, c5's signed long
///      can hold every unsigned int value (since long is 8 bytes
///      vs unsigned int's 4), so the signed type wins.
///
/// For c5, the only ranks that come up after integer promotion
/// are int (4) and long (8).
pub(super) fn usual_arith_common_ty(a: i64, b: i64) -> i64 {
    let a = integer_promote(a);
    let b = integer_promote(b);
    let a_unsigned = is_unsigned_ty(a);
    let b_unsigned = is_unsigned_ty(b);
    let a_long = is_long_ty(strip_unsigned(a));
    let b_long = is_long_ty(strip_unsigned(b));
    let max_long = a_long || b_long;
    let result_unsigned = if a_unsigned == b_unsigned {
        // Same signedness: keep it.
        a_unsigned
    } else {
        // Mixed: who has the higher rank?
        let (u_long, s_long) = if a_unsigned {
            (a_long, b_long)
        } else {
            (b_long, a_long)
        };
        // unsigned wins if its rank >= signed's. Otherwise signed
        // wins (c5's int and long widths guarantee long-signed can
        // hold every unsigned int value).
        if u_long || !s_long {
            true
        } else {
            // Signed long + unsigned int -> signed long.
            false
        }
    };
    let base = if max_long {
        Ty::Long as i64
    } else {
        Ty::Int as i64
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
    let ty = strip_unsigned(ty);
    let base = Ty::Short as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// Pointer depth within the short band. Returns 0 for a scalar
/// `short`, 1 for `short*`, 2 for `short**`, etc.
pub(super) fn short_ptr_depth(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if is_short_ty(ty) {
        (ty - Ty::Short as i64) / Ty::Ptr as i64
    } else {
        0
    }
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
pub(super) fn is_pointer_ty(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    if is_struct_ty(ty) {
        struct_ptr_depth(ty) > 0
    } else if is_floating_ty(ty) {
        fp_ptr_depth(ty) > 0
    } else if is_long_ty(ty) {
        long_ptr_depth(ty) > 0
    } else if is_short_ty(ty) {
        short_ptr_depth(ty) > 0
    } else {
        ty >= Ty::Ptr as i64
    }
}

/// Element size in bytes of a pointee for the given pointer type
/// (without struct-table awareness).
///   * `char*` -> 1 byte (the original c4 case)
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
pub(super) fn is_decl_modifier(tk: i64) -> bool {
    tk == Token::TypeQual as i64
        || tk == Token::IntMod as i64
        || tk == Token::Signed as i64
        || tk == Token::Unsigned as i64
        || tk == Token::Long as i64
        || tk == Token::Short as i64
        || tk == Token::FuncSpec as i64
}

/// True for any token that may start a c5 declaration -- a base-type
/// keyword, a struct prefix, a storage-class prefix, or any of the
/// no-op modifiers above. Used by the parser to decide whether the
/// next statement at block/file scope is a declaration or an
/// expression / control-flow statement.
pub(super) fn is_type_start_token(tk: i64) -> bool {
    tk == Token::Int as i64
        || tk == Token::Char as i64
        || tk == Token::Float as i64
        || tk == Token::Double as i64
        || tk == Token::Struct as i64
        || tk == Token::Union as i64
        || tk == Token::Enum as i64
        || tk == Token::Extern as i64
        || tk == Token::Static as i64
        || is_decl_modifier(tk)
}

/// Pick the right load op for the given `ty`.
///   * `Ty::Char` (scalar)  -> `Op::Lc` / `Op::Lcs` (1-byte zero- / sign-ext)
///   * `Ty::Short` (scalar) -> `Op::Lh` / `Op::Lhu` (2-byte sign- / zero-ext)
///   * `Ty::Int` (scalar)   -> `Op::Lw`  (4-byte sign-extending; M31)
///   * everything else      -> `Op::Li`  (8-byte word load)
/// Pointers (any base type) go through `Op::Li` because every
/// pointer is 8 bytes regardless of its pointee width.
///
/// The signed / unsigned split for `char` mirrors the pattern for
/// short and int: bare `char` is unsigned in c5 (loads zero-ext
/// via `Lc`), `signed char` loads sign-ext via `Lcs`. The store
/// path is the same byte-store either way.
pub(super) fn load_op_for(ty: i64) -> Op {
    let unsigned = is_unsigned_ty(ty);
    let ty = strip_unsigned(ty);
    if ty == Ty::Char as i64 {
        if unsigned { Op::Lc } else { Op::Lcs }
    } else if ty == Ty::Short as i64 {
        // 2-byte slot. Sign vs zero extension splits like Lw / Lwu.
        if unsigned { Op::Lhu } else { Op::Lh }
    } else if ty == Ty::Int as i64 {
        // Pick zero-extending vs sign-extending 32-bit load
        // by signedness. The store path (Op::Sw) doesn't care:
        // it writes the low 32 bits regardless.
        if unsigned { Op::Lwu } else { Op::Lw }
    } else {
        Op::Li
    }
}

/// Mirror of [`load_op_for`] for stores.
///   * `Ty::Char`           -> `Op::Sc`  (1-byte)
///   * `Ty::Short` (scalar) -> `Op::Sh`  (2-byte)
///   * `Ty::Int` (scalar)   -> `Op::Sw`  (4-byte; M31)
///   * everything else      -> `Op::Si`  (8-byte)
pub(super) fn store_op_for(ty: i64) -> Op {
    let ty = strip_unsigned(ty);
    if ty == Ty::Char as i64 {
        Op::Sc
    } else if ty == Ty::Short as i64 {
        Op::Sh
    } else if ty == Ty::Int as i64 {
        Op::Sw
    } else {
        Op::Si
    }
}

/// True if `op_val` (the trailing word in `self.text`) is a scalar
/// memory-load op -- one of `Op::Lc` / `Op::Lw` / `Op::Lwu` /
/// `Op::Li`. The parser uses this in every "rewrite the trailing
/// load into a Psh so the address survives" path: assignments,
/// compound assignments, pre/post-inc/dec, address-of, etc. The
/// helper centralises the predicate so adding a new scalar load op
/// is a one-line change here rather than an audit of every lvalue
/// rewrite site.
pub(super) fn is_scalar_load_op_val(op_val: i64) -> bool {
    op_val == Op::Lc as i64
        || op_val == Op::Lcs as i64
        || op_val == Op::Lh as i64
        || op_val == Op::Lhu as i64
        || op_val == Op::Lw as i64
        || op_val == Op::Lwu as i64
        || op_val == Op::Li as i64
}

/// Re-emit the same scalar load op that produced `op_val`. Caller
/// has just rewritten the trailing slot to `Op::Psh` and now needs
/// to load the same width again so the address-then-value pattern
/// the increment / compound-assignment lowering expects falls out.
pub(super) fn reemit_scalar_load(op_val: i64) -> Op {
    if op_val == Op::Lc as i64 {
        Op::Lc
    } else if op_val == Op::Lcs as i64 {
        Op::Lcs
    } else if op_val == Op::Lh as i64 {
        Op::Lh
    } else if op_val == Op::Lhu as i64 {
        Op::Lhu
    } else if op_val == Op::Lw as i64 {
        Op::Lw
    } else if op_val == Op::Lwu as i64 {
        Op::Lwu
    } else {
        Op::Li
    }
}
