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
    ty >= STRUCT_BASE
}

pub(super) fn struct_id_of(ty: i64) -> usize {
    ((ty - STRUCT_BASE) / STRUCT_STRIDE) as usize
}

pub(super) fn struct_ptr_depth(ty: i64) -> i64 {
    ((ty - STRUCT_BASE) % STRUCT_STRIDE) / Ty::Ptr as i64
}

pub(super) fn struct_ty_for(id: usize) -> i64 {
    STRUCT_BASE + (id as i64) * STRUCT_STRIDE
}

pub(super) fn is_float_ty(ty: i64) -> bool {
    let base = Ty::Float as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

pub(super) fn is_double_ty(ty: i64) -> bool {
    let base = Ty::Double as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// `ty` is a `long` (or pointer to one). Long lives in its own
/// 100-wide band starting at `Ty::Long`; the same +2-per-`*`
/// scheme as the integer family applies inside the band, so
/// `long*` = 302, `long**` = 304, etc.
pub(super) fn is_long_ty(ty: i64) -> bool {
    let base = Ty::Long as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// Pointer depth within the long band. Returns 0 for a scalar
/// `long`, 1 for `long*`, 2 for `long**`, etc.
pub(super) fn long_ptr_depth(ty: i64) -> i64 {
    if is_long_ty(ty) {
        (ty - Ty::Long as i64) / Ty::Ptr as i64
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
    ty == Ty::Float as i64 || ty == Ty::Double as i64
}

pub(super) fn fp_ptr_depth(ty: i64) -> i64 {
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
    if is_struct_ty(ty) {
        struct_ptr_depth(ty) > 0
    } else if is_floating_ty(ty) {
        fp_ptr_depth(ty) > 0
    } else if is_long_ty(ty) {
        long_ptr_depth(ty) > 0
    } else {
        ty >= Ty::Ptr as i64
    }
}

/// Element size in bytes of a pointee for the given pointer type
/// (without struct-table awareness).
///   * `char*` -> 1 byte (the original c4 case)
///   * one-level `int*` -> 4 bytes (M31: `int` is 32-bit)
///   * one-level `long*` -> 8 bytes
///   * deeper pointers (`int**`, `long**`, etc.) -> 8 bytes
///     (because the pointee is itself a pointer)
///   * `float*` / `double*` -> 8 (c5 keeps FP at 8 bytes; the
///     IEEE 754 single-precision narrowing is future work)
/// Pointer-to-struct goes through [`Compiler::pointee_size`]
/// instead so the scale picks up the struct's real size.
pub(super) fn pointee_size_no_struct(ty: i64) -> i64 {
    if ty == Ty::Ptr as i64 {
        1
    } else if ty == (Ty::Int as i64) + (Ty::Ptr as i64) {
        // Bare `int*` -- pointee is a 4-byte int.
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
/// `signed` and `long` modifiers carry semantic weight in c5
/// (`signed` affects `char`'s signedness; `long` selects the 64-bit
/// `Ty::Long` storage class under M31), but at the *modifier-loop*
/// level they're still consumed by `parse_decl_base_type` -- they
/// drive flag bits rather than producing a separate token stream.
pub(super) fn is_decl_modifier(tk: i64) -> bool {
    tk == Token::TypeQual as i64
        || tk == Token::IntMod as i64
        || tk == Token::Signed as i64
        || tk == Token::Long as i64
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
///   * `Ty::Char`           -> `Op::Lc`  (1-byte zero-extending)
///   * `Ty::Int` (scalar)   -> `Op::Lw`  (4-byte sign-extending; M31)
///   * everything else      -> `Op::Li`  (8-byte word load)
/// Pointers (any base type) go through `Op::Li` because every
/// pointer is 8 bytes regardless of its pointee width.
pub(super) fn load_op_for(ty: i64) -> Op {
    if ty == Ty::Char as i64 {
        Op::Lc
    } else if ty == Ty::Int as i64 {
        Op::Lw
    } else {
        Op::Li
    }
}

/// Mirror of [`load_op_for`] for stores.
///   * `Ty::Char`           -> `Op::Sc`  (1-byte)
///   * `Ty::Int` (scalar)   -> `Op::Sw`  (4-byte; M31)
///   * everything else      -> `Op::Si`  (8-byte)
pub(super) fn store_op_for(ty: i64) -> Op {
    if ty == Ty::Char as i64 {
        Op::Sc
    } else if ty == Ty::Int as i64 {
        Op::Sw
    } else {
        Op::Si
    }
}

/// True if `op_val` (the trailing word in `self.text`) is a scalar
/// memory-load op -- one of `Op::Lc` / `Op::Lw` / `Op::Li`. The
/// parser uses this in every "rewrite the trailing load into a Psh
/// so the address survives" path: assignments, compound
/// assignments, pre/post-inc/dec, address-of, etc. M31 added
/// `Op::Lw` to the set; without this helper each site had its own
/// `last == Op::Lc || last == Op::Li` predicate that silently
/// excluded the new 4-byte load.
pub(super) fn is_scalar_load_op_val(op_val: i64) -> bool {
    op_val == Op::Lc as i64 || op_val == Op::Lw as i64 || op_val == Op::Li as i64
}

/// Re-emit the same scalar load op that produced `op_val`. Caller
/// has just rewritten the trailing slot to `Op::Psh` and now needs
/// to load the same width again so the address-then-value pattern
/// the increment / compound-assignment lowering expects falls out.
pub(super) fn reemit_scalar_load(op_val: i64) -> Op {
    if op_val == Op::Lc as i64 {
        Op::Lc
    } else if op_val == Op::Lw as i64 {
        Op::Lw
    } else {
        Op::Li
    }
}
