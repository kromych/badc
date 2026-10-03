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
pub(super) use crate::c5::layout::round_up;

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

/// High-bit flag marking a character type spelled plain `char`. C99
/// 6.2.5p15 makes it a type distinct from `signed char` and `unsigned
/// char` with the representation of one of them, so the tag keeps the
/// target's [`UNSIGNED_BIT`] for loads, stores and promotions and this
/// bit for identity: generic selection, compatibility and type names
/// see three types. Stripped by [`strip_unsigned`] like the other
/// markers. Sits above [`CONST_BIT`].
pub(crate) const PLAIN_CHAR_BIT: i64 = 1 << 61;

/// The tag of plain `char`, `signed` on a target whose plain char is.
pub(crate) fn plain_char_ty(signed: bool) -> i64 {
    let ty = Ty::Char as i64 | PLAIN_CHAR_BIT;
    if signed { ty } else { ty | UNSIGNED_BIT }
}

/// High-bit flag marking an enumerated type (C99 6.7.2.2). The tag keeps
/// the band and bits of the integer type the enum's definition chose, which
/// loads, stores, promotions and conversions read, and carries the enum's
/// tag-registry id for identity: generic selection, compatibility and type
/// names tell two enumerated types apart, while each is compatible with
/// its integer type (6.7.2.2p4). The id takes the bits above the scalar
/// bands, which end below `1 << ENUM_ID_SHIFT`, and is meaningful only
/// under this flag, which no aggregate tag carries. Stripped by
/// [`strip_unsigned`] like the other markers.
pub(crate) const ENUM_BIT: i64 = 1 << 62;
const ENUM_ID_SHIFT: i64 = 10;
const ENUM_ID_BITS: i64 = 18;
const ENUM_ID_MASK: i64 = ((1 << ENUM_ID_BITS) - 1) << ENUM_ID_SHIFT;

/// The tag of the enumerated type with registry id `id` over the integer
/// type `underlying`. TODO: an id past the field keeps the integer type
/// alone.
pub(crate) fn enum_ty(underlying: i64, id: usize) -> i64 {
    let id = id as i64;
    if id >> ENUM_ID_BITS != 0 {
        return underlying;
    }
    without_enum(underlying) | ENUM_BIT | (id << ENUM_ID_SHIFT)
}

/// The registry id of the enumerated type `ty` is or is derived from.
pub(crate) fn enum_id_of(ty: i64) -> Option<usize> {
    (ty & ENUM_BIT != 0).then_some(((ty & ENUM_ID_MASK) >> ENUM_ID_SHIFT) as usize)
}

/// `ty` with its enumerated type replaced by the compatible integer type.
pub(crate) fn without_enum(ty: i64) -> i64 {
    if ty & ENUM_BIT != 0 {
        ty & !(ENUM_BIT | ENUM_ID_MASK)
    } else {
        ty
    }
}

/// C99 6.2.7p1 over two tags that may name enumerated types: equal, or
/// equal once the one enumerated type is replaced by its integer type
/// (6.7.2.2p4). Two enumerated types are compatible only with themselves.
pub(crate) fn enum_compatible(a: i64, b: i64) -> bool {
    a == b
        || (without_enum(a) == without_enum(b)
            && (enum_id_of(a).is_none() || enum_id_of(b).is_none()))
}

/// High-bit flag marking a type tag `volatile`-qualified at some level
/// (C99 6.7.3), the conservative reading code generation takes: every
/// access *through* such a tag is a volatile access, so the bit stays
/// when a dereference drops the qualified level (extra volatility only
/// inhibits optimization; 5.1.2.3p2 forbids eliding or coalescing an
/// access to a volatile object). Orthogonal to the band scheme like
/// [`UNSIGNED_BIT`] and stripped by [`strip_unsigned`]. The levels the
/// qualifier applies to are [`VOL_LVL_MASK`]'s; type identity reads them
/// and never this bit.
pub(crate) const VOLATILE_BIT: i64 = 1 << 29;

/// `true` if `ty` carries the volatile qualifier at any level.
pub(crate) fn is_volatile_ty(ty: i64) -> bool {
    (ty & VOLATILE_BIT) != 0
}

/// `true` if the object a declaration gives this tag is itself
/// volatile-qualified (`volatile T x`, `T *volatile p`), as opposed to
/// one that merely points at volatile data (`volatile T *p`). Governs
/// whether the object's own storage is a volatile lvalue; accesses
/// *through* the tag stay on [`is_volatile_ty`]. A level past the field
/// takes the conservative answer.
pub(crate) fn is_volatile_object_ty(ty: i64) -> bool {
    match volatile_level_bit(ptr_depth_of(ty)) {
        0 => is_volatile_ty(ty),
        bit => ty & bit != 0,
    }
}

/// Every volatile marker. Sites that move the qualifier onto a rebuilt
/// tag, or that must ignore volatility entirely, take them as a unit.
pub(crate) const VOLATILE_MASK: i64 = VOLATILE_BIT | VOL_LVL_MASK;

/// The bits qualifying a tag's derivations level by level -- `const`,
/// `volatile` and a named address space -- rather than naming its type.
pub(crate) const DERIVATION_QUAL_MASK: i64 =
    VOLATILE_MASK | CONST_LVL_MASK | SEG_MASK | SEG_LVL_MASK;

/// Add one pointer derivation level. The pointer object is unqualified
/// until a post-`*` qualifier says otherwise.
pub(crate) fn add_ptr_level(ty: i64) -> i64 {
    ty + Ty::Ptr as i64
}

/// `ty` with derivation level `level` removed: the function level of a
/// function-type typedef's tag, which stands for the function as a pointer
/// one level above its return type, absorbed by the first `*` applied to
/// it. The qualifiers recorded for the levels above move down with them;
/// the return type's, below it, stay.
pub(crate) fn absorb_function_level(ty: i64, level: i64) -> i64 {
    let drop_level = |mask: i64, shift: i64| {
        let levels = (ty & mask) >> shift;
        let below = levels & ((1 << level) - 1);
        ((below | ((levels >> (level + 1)) << level)) << shift) & mask
    };
    let quals =
        drop_level(CONST_LVL_MASK, CONST_LVL_SHIFT) | drop_level(VOL_LVL_MASK, VOL_LVL_SHIFT);
    let mut out = ((ty & !(CONST_LVL_MASK | VOL_LVL_MASK)) - Ty::Ptr as i64) | quals;
    let seg_level = (ty & SEG_LVL_MASK) >> SEG_LVL_SHIFT;
    if ty & SEG_MASK != 0 && seg_level > level {
        out = (out & !SEG_LVL_MASK) | ((seg_level - 1) << SEG_LVL_SHIFT);
    }
    out
}

/// The pointee type (C99 6.5.3.2p4): one level down, without the removed
/// level's `const`, `volatile` and object address space, which qualified
/// the pointer. [`VOLATILE_BIT`] stays.
pub(crate) fn pointee_ty(ty: i64) -> i64 {
    let mut ty = strip_object_const(ty) & !volatile_level_bit(ptr_depth_of(ty));
    if segment_of_object_ty(ty).is_some() {
        ty &= !(SEG_MASK | SEG_LVL_MASK);
    }
    ty - Ty::Ptr as i64
}

/// Fold type-qualifier bits into a tag. A `const` or a `volatile` is
/// recorded at the tag's current pointer depth in [`CONST_LVL_MASK`] or
/// [`VOL_LVL_MASK`], the latter beside [`VOLATILE_BIT`]. A segment
/// qualifier records the derivation it applies to by stamping the tag's
/// current pointer depth into [`SEG_LVL_MASK`].
pub(crate) fn apply_qual_bits(ty: i64, bits: i64) -> i64 {
    let mut ty = ty | bits;
    if bits & VOLATILE_BIT != 0 {
        ty |= volatile_level_bit(ptr_depth_of(ty));
    }
    if bits & CONST_BIT != 0 {
        ty = (ty & !CONST_BIT) | const_level_bit(ptr_depth_of(ty));
    }
    if bits & SEG_MASK != 0 {
        ty = (ty & !SEG_LVL_MASK) | (ptr_depth_of(ty) << SEG_LVL_SHIFT);
    }
    ty
}

/// High-bit flags marking a type tag qualified by an x86 named address
/// space (GCC `__seg_gs` / `__seg_fs`). An access to an object so
/// qualified rides a segment-override prefix (`%gs:` / `%fs:`).
/// Orthogonal to the band scheme like [`UNSIGNED_BIT`] and stripped by
/// [`strip_unsigned`]. x86-only; the two spellings never both appear on
/// one tag.
///
/// [`SEG_LVL_MASK`] records the pointer depth at which the qualifier
/// applies, as an absolute level: `int __seg_gs g` stores level 0,
/// `int __seg_gs *p` still stores level 0 while the tag's own depth is
/// 1, and `int * __seg_gs p` stores level 1. Band arithmetic
/// (`ty +/- Ty::Ptr`) leaves the field untouched, so a dereference or
/// an address-of moves the tag's depth relative to the fixed level and
/// [`segment_of_object_ty`] answers per derivation with no per-site
/// bookkeeping: the qualifier governs an access exactly when the tag's
/// depth equals the recorded level.
pub(crate) const SEG_GS_BIT: i64 = 1 << 31;
pub(crate) const SEG_FS_BIT: i64 = 1 << 32;
pub(crate) const SEG_MASK: i64 = SEG_GS_BIT | SEG_FS_BIT;

/// Pointer level the segment qualifier applies at (9 bits, covering
/// the deepest derivation any band encodes). Zero, and meaningless,
/// when no segment bit is set.
/// TODO: one level field per tag, so qualifying two derivations
/// (`int __seg_gs * __seg_gs p`) keeps only the outermost.
const SEG_LVL_SHIFT: i64 = 34;
const SEG_LVL_MASK: i64 = 0x1FF << SEG_LVL_SHIFT;

/// High-bit flag marking a type tag whose base type was spelled `void`.
/// `void` keeps `unsigned char`'s representation (1-byte `sizeof` under
/// the GNU extension, +1 `void *` arithmetic stride, U8 access width),
/// so the tag stays in the char band and this orthogonal bit carries
/// the distinct-incomplete-type identity C99 6.2.5p19 gives `void`.
/// Stripped by [`strip_unsigned`] like the other qualifier bits, so
/// band classifiers and codegen are unaffected; identity-sensitive
/// sites ([`is_void_ty`], [`is_void_ptr_ty`], the 6.5.15p6 conditional
/// rule, `_Generic` matching) test the bit.
pub(crate) const VOID_BIT: i64 = 1 << 28;

/// High-bit flag marking a type tag whose base type was spelled `long
/// double`: a `double`-band type whose storage follows the target
/// (`Target::long_double`, see doc/std-conformance.md). Stripped by
/// [`strip_unsigned`] like the other orthogonal markers, so band
/// classifiers see a `double`; the layout, the load and store kinds and
/// the identity-sensitive sites ([`is_long_double_ty`]) test the bit.
///
/// Sits above [`SEG_LVL_MASK`]'s 9-bit field (bits 34..43).
pub(crate) const LONG_DOUBLE_BIT: i64 = 1 << 43;

/// True when `ty`'s base type was spelled `long double`, at any
/// qualification or pointer depth.
pub(crate) fn is_long_double_ty(ty: i64) -> bool {
    (ty & LONG_DOUBLE_BIT) != 0
}

/// True for a scalar `long double` -- not a pointer to one.
pub(crate) fn is_long_double_scalar(ty: i64) -> bool {
    is_long_double_ty(ty) && strip_unsigned(ty) == Ty::Double as i64
}

/// Bit fields marking the derivation levels a `const` and a `volatile`
/// qualify (C99 6.7.3), one bit per absolute level as [`SEG_LVL_MASK`]
/// counts them: `const T *` sets level 0, `T *const` level 1, and an
/// array's level 0 is its elements' (6.7.3p8). Band arithmetic leaves
/// the fields in place; [`pointee_ty`] drops the removed level's bits,
/// and [`is_const_object_ty`] / [`is_volatile_object_ty`] answer per
/// derivation. Bits 44..51 and 52..59, above [`LONG_DOUBLE_BIT`].
/// TODO: a qualifier past level 7 is not recorded.
const QUAL_LVL_BITS: i64 = 8;
const CONST_LVL_SHIFT: i64 = 44;
pub(crate) const CONST_LVL_MASK: i64 = ((1 << QUAL_LVL_BITS) - 1) << CONST_LVL_SHIFT;
const VOL_LVL_SHIFT: i64 = 52;
pub(crate) const VOL_LVL_MASK: i64 = ((1 << QUAL_LVL_BITS) - 1) << VOL_LVL_SHIFT;

/// The levels of [`CONST_LVL_MASK`] and [`VOL_LVL_MASK`] above the base:
/// the pointer derivations' own qualifiers, which a rebuilt
/// aggregate-backed tag carries over while the element's level lives in
/// the aggregate.
pub(crate) const QUAL_PTR_LVL_MASK: i64 =
    (CONST_LVL_MASK & !(1 << CONST_LVL_SHIFT)) | (VOL_LVL_MASK & !(1 << VOL_LVL_SHIFT));

/// The request `Compiler::lex_qualifier_bits` returns for `const`:
/// [`apply_qual_bits`] records it at the tag's current depth in
/// [`CONST_LVL_MASK`] and clears it, so no stored tag carries it.
pub(crate) const CONST_BIT: i64 = 1 << 60;

/// The [`CONST_LVL_MASK`] bit for `level`, 0 past the field.
fn const_level_bit(level: i64) -> i64 {
    if (0..QUAL_LVL_BITS).contains(&level) {
        1 << (CONST_LVL_SHIFT + level)
    } else {
        0
    }
}

/// The [`VOL_LVL_MASK`] bit for `level`, 0 past the field.
fn volatile_level_bit(level: i64) -> i64 {
    if (0..QUAL_LVL_BITS).contains(&level) {
        1 << (VOL_LVL_SHIFT + level)
    } else {
        0
    }
}

/// True if the object a declaration gives this tag is itself
/// const-qualified (`const T x`, `T *const p`), as opposed to one that
/// points at const data (`const T *p`).
pub(crate) fn is_const_object_ty(ty: i64) -> bool {
    ty & const_level_bit(ptr_depth_of(ty)) != 0
}

/// Drop the `const` on the type itself, keeping a pointee's: the
/// conversion C99 6.3.2.1p2 applies to an lvalue's value, 6.5.4p5 to a
/// cast's and 6.7.5.3p15 to a parameter's type, as far as the tag
/// records it exactly. `volatile` stays for the accesses the value
/// reaches; [`unqualified_version_ty`] drops it as well.
pub(crate) fn strip_object_const(ty: i64) -> i64 {
    ty & !const_level_bit(ptr_depth_of(ty))
}

/// The unqualified version of a type (C99 6.2.5p25) as C23 6.7.2.5
/// `typeof_unqual` names it: no `const` or `volatile` on the type
/// itself. The segment qualifier is kept. TODO: its lvalue conversion.
pub(crate) fn unqualified_version_ty(ty: i64) -> i64 {
    let ty = strip_object_const(ty) & !volatile_level_bit(ptr_depth_of(ty));
    exact_volatile_ty(ty)
}

/// `ty` with no qualifier on itself or on what it points to: the form in
/// which C99 6.5.6p3 compares the operands of a pointer difference,
/// pointers to qualified or unqualified versions of compatible types.
pub(crate) fn unqualified_pointee_ty(ty: i64) -> i64 {
    let depth = ptr_depth_of(ty);
    let ty = unqualified_version_ty(ty);
    if depth == 0 {
        return ty;
    }
    exact_volatile_ty(ty & !(const_level_bit(depth - 1) | volatile_level_bit(depth - 1)))
}

/// `ty` without [`VOLATILE_BIT`] when no level it records is volatile,
/// as a dereference of a volatile pointer level leaves it: the type
/// itself, rather than the conservative reading of its accesses.
pub(crate) fn exact_volatile_ty(ty: i64) -> i64 {
    if ty & VOL_LVL_MASK == 0 && volatile_level_bit(ptr_depth_of(ty)) != 0 {
        ty & !VOLATILE_BIT
    } else {
        ty
    }
}

/// The `const` and `volatile` of `from`'s pointee placed at `to`'s
/// pointee level, with `from`'s [`VOLATILE_BIT`]: the qualification
/// C99 6.5.15p6 carries from either arm onto the result pointer type.
pub(crate) fn pointee_qual_bits(from: i64, to: i64) -> i64 {
    let (from_depth, to_depth) = (ptr_depth_of(from), ptr_depth_of(to));
    if from_depth == 0 || to_depth == 0 {
        return 0;
    }
    let mut bits = from & VOLATILE_BIT;
    if from & const_level_bit(from_depth - 1) != 0 {
        bits |= const_level_bit(to_depth - 1);
    }
    if from & volatile_level_bit(from_depth - 1) != 0 {
        bits |= volatile_level_bit(to_depth - 1);
    }
    bits
}

/// The `const` and `volatile` of the type `ty` points to, an array's being
/// its elements' (C99 6.7.3p8); `None` when `ty` is no pointer.
fn pointee_quals(ty: i64, structs: &[super::StructDef]) -> Option<(bool, bool)> {
    let depth = ptr_depth_of(ty);
    if depth == 0 {
        return None;
    }
    let array = (depth == 1 && is_struct_ty(ty))
        .then(|| structs.get(struct_id_of(ty)).filter(|s| s.is_array))
        .flatten();
    let (ty, level) = match array {
        Some(s) => (s.fields[0].ty, ptr_depth_of(s.fields[0].ty)),
        None => (ty, depth - 1),
    };
    Some((
        ty & const_level_bit(level) != 0,
        ty & volatile_level_bit(level) != 0,
    ))
}

/// Whether converting a pointer of type `from` to type `to` drops the
/// `const`, and the `volatile`, of the pointed-to type, which C99
/// 6.5.16.1p1 requires `to`'s pointee to keep.
pub(crate) fn discarded_pointee_quals(
    to: i64,
    from: i64,
    structs: &[super::StructDef],
) -> (bool, bool) {
    match (pointee_quals(to, structs), pointee_quals(from, structs)) {
        (Some(t), Some(f)) => (f.0 && !t.0, f.1 && !t.1),
        _ => (false, false),
    }
}

/// The x86 named address space a type tag carries.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum Segment {
    Gs,
    Fs,
}

/// The named address space qualifying `ty` at any derivation level,
/// or `None`.
pub(crate) fn segment_of_ty(ty: i64) -> Option<Segment> {
    if ty & SEG_GS_BIT != 0 {
        Some(Segment::Gs)
    } else if ty & SEG_FS_BIT != 0 {
        Some(Segment::Fs)
    } else {
        None
    }
}

/// The named address space an access to an object of type `ty` rides,
/// or `None` when the tag is unqualified or the qualifier sits on a
/// pointee below the outermost derivation (`int __seg_gs *p`: `p`
/// itself is a generic-space object; `*p` is not).
pub(crate) fn segment_of_object_ty(ty: i64) -> Option<Segment> {
    let seg = segment_of_ty(ty)?;
    if (ty & SEG_LVL_MASK) >> SEG_LVL_SHIFT == ptr_depth_of(ty) {
        Some(seg)
    } else {
        None
    }
}

/// Drop the qualifiers an assignment does not carry. C99 6.3.2.1p2
/// gives the value of an lvalue the unqualified version of the
/// lvalue's type, and 6.5.16.1p1 constrains only the pointed-to
/// types, so a qualifier on the object itself never takes part in
/// compatibility. `const` and `volatile` go at every level, the
/// constraint on a pointee's qualification being undiagnosed (TODO); a
/// named address space records its level and is dropped only when it
/// qualifies the object.
pub(crate) fn unqualified_object_ty(ty: i64) -> i64 {
    let ty = ty & !(VOLATILE_MASK | CONST_LVL_MASK);
    if segment_of_object_ty(ty).is_some() {
        ty & !(SEG_MASK | SEG_LVL_MASK)
    } else {
        ty
    }
}

/// The segment-qualifier bit pattern of `ty` when the qualifier
/// applies to the object itself, else 0. For re-application onto a
/// derived tag through [`apply_qual_bits`].
pub(crate) fn object_segment_bits(ty: i64) -> i64 {
    if segment_of_object_ty(ty).is_some() {
        ty & SEG_MASK
    } else {
        0
    }
}

/// Pointer-derivation depth of a tag, across every band.
pub(crate) fn ptr_depth_of(ty: i64) -> i64 {
    let ty = strip_unsigned(ty);
    if is_struct_ty(ty) {
        struct_ptr_depth(ty)
    } else if is_floating_ty(ty) {
        fp_ptr_depth(ty)
    } else if is_long_long_ty(ty) {
        long_long_ptr_depth(ty)
    } else if is_long_ty(ty) {
        long_ptr_depth(ty)
    } else if is_short_ty(ty) {
        short_ptr_depth(ty)
    } else if is_bool_ty(ty) {
        bool_ptr_depth(ty)
    } else {
        ty / Ty::Ptr as i64
    }
}

/// Apply a C99 6.3.1.3 integer conversion to a constant value:
/// narrow to `bytes` width and re-interpret by the target's
/// signedness. `_Bool` maps any nonzero value to 1 (6.3.1.2). An
/// 8-byte target keeps the full `i64` (pointers and `long long`
/// included). Used by the constant-expression evaluator so a cast
/// like `(int)UINT_MAX` folds to `-1` at parse time rather than
/// retaining the un-narrowed operand.
pub(crate) fn narrow_const_int(bytes: usize, unsigned: bool, is_bool: bool, v: i128) -> i128 {
    if is_bool {
        return (v != 0) as i128;
    }
    if bytes >= 16 {
        return v;
    }
    let bits = (bytes * 8) as u32;
    let mask: i128 = ((1u128 << bits) - 1) as i128;
    let truncated = v & mask;
    if unsigned {
        truncated
    } else {
        let sign_bit: i128 = 1i128 << (bits - 1);
        (truncated ^ sign_bit).wrapping_sub(sign_bit)
    }
}

/// Drop the qualifier bits (`UNSIGNED_BIT`, `PLAIN_CHAR_BIT`,
/// `VOLATILE_BIT`, `VOID_BIT`, the segment, `const` and `volatile`
/// fields, the enumerated-type identity).
/// Use to recover the bare band-encoded type before
/// consulting a helper that classifies by band. Most of the helpers in
/// this module call this at their entry; outside callers only need it
/// when storing a type tag where a non-bit-flagged tag is expected
/// (e.g., switch-table comparisons against `Ty::Int as i64`).
pub(crate) fn strip_unsigned(ty: i64) -> i64 {
    without_enum(ty)
        & !(UNSIGNED_BIT
            | PLAIN_CHAR_BIT
            | VOLATILE_BIT
            | VOL_LVL_MASK
            | SEG_MASK
            | SEG_LVL_MASK
            | VOID_BIT
            | LONG_DOUBLE_BIT
            | CONST_LVL_MASK
            | CONST_BIT)
}

/// `ty`, declared through an enum tag before its definition and so built on
/// the tag's incomplete entry `id`, over the integer type `underlying` the
/// definition chose: the enumerated type at the same derivations and
/// qualifiers. A type built on anything else is returned unchanged.
pub(crate) fn rebase_enum_placeholder(ty: i64, id: usize, underlying: i64) -> i64 {
    if !is_struct_ty(ty) || struct_id_of(ty) != id {
        return ty;
    }
    let bare = strip_unsigned(ty);
    let rebased = (bare - struct_ty_for(id) + strip_unsigned(underlying))
        | (ty ^ bare)
        | (underlying & UNSIGNED_BIT);
    enum_ty(rebased, id)
}

/// The scalar `void` type tag.
pub(crate) fn void_ty() -> i64 {
    Ty::Char as i64 | UNSIGNED_BIT | VOID_BIT
}

/// The `void *` type tag.
pub(crate) fn void_ptr_ty() -> i64 {
    void_ty() + Ty::Ptr as i64
}

/// True for scalar `void`, at any qualification.
pub(crate) fn is_void_ty(ty: i64) -> bool {
    (ty & VOID_BIT) != 0 && strip_unsigned(ty) == Ty::Char as i64
}

/// True for a depth-1 `void *`, at any qualification. Exact: character
/// pointers carry no [`VOID_BIT`] and answer false.
pub(crate) fn is_void_ptr_ty(ty: i64) -> bool {
    (ty & VOID_BIT) != 0 && strip_unsigned(ty) == Ty::Char as i64 + Ty::Ptr as i64
}

/// Render the derivation suffix of a tag with `depth` pointer levels:
/// one `*` per level, with any named-address-space keyword written at
/// the derivation [`SEG_LVL_MASK`] records. Two tags that differ only
/// in that qualifier must not render alike.
/// The qualifier keywords `ty` records at derivation `level`, each
/// followed by a space.
fn level_quals(ty: i64, level: i64) -> &'static str {
    let is_const = ty & const_level_bit(level) != 0;
    match (is_const, ty & volatile_level_bit(level) != 0) {
        (true, true) => "const volatile ",
        (true, false) => "const ",
        (false, true) => "volatile ",
        (false, false) => "",
    }
}

/// The `*` of each pointer level of `ty` in `levels`, each followed by the
/// `const` and `volatile` that qualify that level.
fn qualified_stars(ty: i64, levels: core::ops::Range<usize>) -> alloc::string::String {
    let mut s = alloc::string::String::new();
    for level in levels {
        if s.ends_with("const") || s.ends_with("volatile") {
            s.push(' ');
        }
        s.push('*');
        let quals = level_quals(ty, level as i64);
        if !quals.is_empty() {
            s.push(' ');
            s.push_str(quals.trim_end());
        }
    }
    s
}

/// The `*` run of a spelled type: a `const` and a `volatile` after each
/// level they qualify and the segment keyword at the level it applies to.
fn ptr_suffix(ty: i64, depth: usize) -> alloc::string::String {
    let stars = |levels: core::ops::Range<usize>| qualified_stars(ty, levels);
    let Some(seg) = segment_of_ty(ty) else {
        return stars(1..depth + 1);
    };
    let kw = match seg {
        Segment::Gs => " __seg_gs",
        Segment::Fs => " __seg_fs",
    };
    let lvl = (((ty & SEG_LVL_MASK) >> SEG_LVL_SHIFT) as usize).min(depth);
    let (below, above) = (stars(1..lvl + 1), stars(lvl + 1..depth + 1));
    if above.is_empty() {
        alloc::format!("{below}{kw}")
    } else {
        alloc::format!("{below}{kw} {above}")
    }
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
    let base_const = level_quals(ty, 0);
    let prefix = format!("{base_const}{}", if unsigned { "unsigned " } else { "" });
    if (ty & VOID_BIT) != 0 && (0..100).contains(&bare) {
        return format!("{base_const}void{}", ptr_suffix(ty, (bare / 2) as usize));
    }
    if let Some(id) = enum_id_of(ty) {
        let name = structs
            .get(id)
            .map(|s| s.name.as_str())
            .filter(|n| !n.is_empty())
            .unwrap_or("<anonymous>");
        let depth = ptr_depth_of(ty) as usize;
        return format!("{base_const}enum {name}{}", ptr_suffix(ty, depth));
    }
    if bare >= STRUCT_BASE {
        let id = struct_id_of(bare);
        let depth = struct_ptr_depth(bare) as usize;
        // The aggregate that models a pointer-to-array pointee.
        if let Some(f) = structs.get(id).filter(|s| s.is_array).map(|s| &s.fields[0]) {
            let dims = if f.array_dims.len() >= 2 {
                f.array_dims.clone()
            } else {
                alloc::vec![f.array_size]
            };
            let dim = |&d: &i64| if d < 0 { "[]".into() } else { format!("[{d}]") };
            let dims: alloc::string::String = dims.iter().map(dim).collect();
            return format!(
                "{} ({}){dims}",
                format_type(f.ty, structs),
                ptr_suffix(ty, depth)
            );
        }
        // A GNU vector, spelled as its lane type and the attribute that
        // declares it; its interned name encodes the lane type's tag.
        if let Some(s) = structs.get(id).filter(|s| s.is_vector) {
            let lane = format_type(s.fields[0].ty, structs);
            return format!(
                "{base_const}{lane} __attribute__((vector_size({}))){}",
                s.size,
                ptr_suffix(ty, depth)
            );
        }
        let name = structs
            .get(id)
            .map(|s| s.name.as_str())
            .filter(|n| !n.is_empty())
            .map(alloc::string::ToString::to_string)
            .unwrap_or_else(|| format!("@{id}"));
        let kw = structs.get(id).map_or("struct", |s| s.keyword());
        return format!("{prefix}{kw} {name}{}", ptr_suffix(ty, depth));
    }
    let (base, leaf) = if in_band(bare, Ty::Float as i64) {
        (Ty::Float as i64, "float")
    } else if in_band(bare, Ty::Double as i64) {
        let long = ty & LONG_DOUBLE_BIT != 0;
        (
            Ty::Double as i64,
            if long { "long double" } else { "double" },
        )
    } else if in_band(bare, Ty::Long as i64) {
        (Ty::Long as i64, "long")
    } else if in_band(bare, Ty::Short as i64) {
        (Ty::Short as i64, "short")
    } else if in_band(bare, Ty::LongLong as i64) {
        (Ty::LongLong as i64, "long long")
    } else if in_band(bare, Ty::Bool as i64) {
        (Ty::Bool as i64, "_Bool")
    } else if (0..100).contains(&bare) {
        // Integer family: char = 0, int = 1, then +2 per `*` level. Each
        // character type spells its own signedness.
        let depth = (bare / 2) as usize;
        let suffix = ptr_suffix(ty, depth);
        if bare % 2 != 0 {
            return format!("{prefix}int{suffix}");
        }
        let name = if ty & PLAIN_CHAR_BIT != 0 {
            "char"
        } else if unsigned {
            "unsigned char"
        } else {
            "signed char"
        };
        return format!("{base_const}{name}{suffix}");
    } else {
        return format!("{prefix}ty@{bare}");
    };
    let depth = ((bare - base) / 2) as usize;
    format!("{prefix}{leaf}{}", ptr_suffix(ty, depth))
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
    alloc::format!(
        "{} ({})",
        format_type(return_ty, structs),
        format_params(params, is_variadic, structs)
    )
}

/// Render function type `f` with `depth` pointer levels above it, whose
/// innermost return type is `ret`: `double (*)(double)`, `int (*)()` for
/// one with no prototype. The outermost levels carry the qualifiers `tag`
/// records for its top `depth` levels: `void (* const *)(void)`.
pub(super) fn format_fn_type(
    ret: i64,
    f: &crate::c5::symbol::FnType,
    (tag, depth): (i64, i64),
    structs: &[super::StructDef],
) -> alloc::string::String {
    let top = ptr_depth_of(tag) as usize;
    let mut decl = alloc::string::String::new();
    let mut level = Some((f, depth));
    while let Some((f, depth)) = level {
        let params = if f.params.prototyped {
            format_params(&f.params.types, f.params.variadic, structs)
        } else {
            alloc::string::String::new()
        };
        let depth = depth as usize;
        let stars = if decl.is_empty() && depth <= top {
            qualified_stars(tag, top + 1 - depth..top + 1)
        } else {
            "*".repeat(depth)
        };
        decl = if depth == 0 && decl.is_empty() {
            alloc::format!("({params})")
        } else {
            alloc::format!("({stars}{decl})({params})")
        };
        level = f.ret.as_ref().map(|(r, d)| (&**r, *d));
    }
    alloc::format!("{} {decl}", format_type(ret, structs))
}

/// A parameter list as a prototype spells it; an empty one is `void`.
fn format_params(
    params: &[i64],
    is_variadic: bool,
    structs: &[super::StructDef],
) -> alloc::string::String {
    let mut parts: alloc::vec::Vec<alloc::string::String> =
        params.iter().map(|&p| format_type(p, structs)).collect();
    if is_variadic {
        parts.push("...".into());
    }
    if parts.is_empty() {
        "void".into()
    } else {
        parts.join(", ")
    }
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

/// True when `ty` names an aggregate *value* -- a struct, union, GCC
/// vector or 128-bit integer object -- rather than a pointer to one. The
/// distinction decides whether a type is copied by extent or held in a
/// register, so it gates aggregate assignment, argument passing, member
/// access and the initializer traversal.
pub(crate) fn is_struct_value_ty(ty: i64) -> bool {
    is_struct_ty(ty) && struct_ptr_depth(ty) == 0
}

/// True when `ty` is a character type (C99 6.2.5p3: `char`, `signed
/// char`, `unsigned char`) rather than a pointer to one. The `-fstack-
/// protector` buffer-size rule applies to arrays of these only.
pub(crate) fn is_char_value_ty(ty: i64) -> bool {
    strip_unsigned(ty) == Ty::Char as i64
}

/// What an automatic object of type `ty` -- an array of `array_size`
/// elements when that is non-zero, `multi_dim` when the declaration had
/// more than one dimension -- contributes to the function's stack-protector
/// classification. `elem_size` gives the byte size of `ty`; the caller owns
/// the target-dependent sizing. Mirrors gcc's `stack_protect_classify_type`:
/// an array whose element type is a character type counts by its byte
/// extent, an array of anything else counts as an array, and an aggregate
/// contributes whatever its members do. A multidimensional array's element
/// type is the inner array, not the character type, so it counts as an
/// array only -- gcc classifies it the same way.
pub(crate) fn ssp_classify(
    structs: &[super::StructDef],
    ty: i64,
    array_size: i64,
    multi_dim: bool,
    elem_size: &dyn Fn(i64) -> usize,
) -> crate::c5::ir::SspFacts {
    // A struct cannot contain itself by value, so the walk terminates; the
    // bound only keeps a malformed table from recursing without end.
    fn walk(
        structs: &[super::StructDef],
        ty: i64,
        array_size: i64,
        multi_dim: bool,
        elem_size: &dyn Fn(i64) -> usize,
        depth: u32,
        out: &mut crate::c5::ir::SspFacts,
    ) {
        if depth > 16 {
            return;
        }
        if array_size > 0 {
            out.has_array = true;
            if is_char_value_ty(ty) && !multi_dim {
                let bytes = (elem_size(ty) as i64).saturating_mul(array_size);
                out.char_array_bytes = out
                    .char_array_bytes
                    .max(bytes.clamp(0, u32::MAX as i64) as u32);
            }
        }
        if !is_struct_value_ty(ty) {
            return;
        }
        let Some(def) = structs.get(struct_id_of(ty)) else {
            return;
        };
        for f in &def.fields {
            walk(
                structs,
                f.ty,
                f.array_size,
                f.array_dims.len() > 1,
                elem_size,
                depth + 1,
                out,
            );
        }
    }
    let mut out = crate::c5::ir::SspFacts::default();
    walk(structs, ty, array_size, multi_dim, elem_size, 0, &mut out);
    out
}

pub(super) fn struct_ty_for(id: usize) -> i64 {
    STRUCT_BASE + (id as i64) * STRUCT_STRIDE
}

/// `true` when `ty` is a GCC vector type: an aggregate *value* (not a
/// pointer to one) whose synthesized `StructDef` carries `is_vector`.
pub(crate) fn is_vector_ty(structs: &[super::StructDef], ty: i64) -> bool {
    if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 {
        return false;
    }
    let id = struct_id_of(ty);
    id < structs.len() && structs[id].is_vector
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
/// C99 rule never fires here. An enumerated type yields its integer
/// type, at every rank as gcc and clang convert one.
pub(super) fn integer_promote(ty: i64) -> i64 {
    let stripped = strip_unsigned(ty);
    // `_Bool` (6.3.1.1) and the sub-int integer types all have a
    // rank below `int` and every value they hold fits in a signed
    // `int`, so they promote to signed `int`.
    if stripped == Ty::Char as i64 || stripped == Ty::Short as i64 || stripped == Ty::Bool as i64 {
        Ty::Int as i64
    } else {
        without_enum(ty)
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

/// True for a scalar integer type (`char` / `short` / `int` / `long` /
/// `long long` / `_Bool`, signed or unsigned) with no pointer level --
/// i.e. a value that folds to an `i64`. Excludes pointers, structs, and
/// floating types. Used to gate `const`-object value folding.
pub(crate) fn is_integer_scalar_ty(ty: i64) -> bool {
    !is_pointer_ty(ty) && !is_struct_ty(ty) && !is_floating_scalar(ty)
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

/// Result type for a binary operation with a floating operand: C99
/// 6.3.1.8p1 takes `long double` if either operand is one, else `double`
/// if either is, else `float`.
pub(super) fn fp_result_ty(lhs: i64, rhs: i64) -> i64 {
    if is_long_double_scalar(lhs) || is_long_double_scalar(rhs) {
        return Ty::Double as i64 | LONG_DOUBLE_BIT;
    }
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
        || tk == Token::ForceInline
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
        || tk == Token::AutoType
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
        let stripped = strip_unsigned(ty);
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
    fn void_identity_is_exact() {
        let uchar = Ty::Char as i64 | UNSIGNED_BIT;
        let ptr = Ty::Ptr as i64;
        assert!(is_void_ty(void_ty()));
        assert!(is_void_ty(void_ty() | VOLATILE_BIT));
        assert!(!is_void_ty(uchar));
        assert!(!is_void_ty(void_ty() + ptr));
        assert!(is_void_ptr_ty(void_ty() + ptr));
        assert!(is_void_ptr_ty((void_ty() + ptr) | VOLATILE_BIT));
        assert!(!is_void_ptr_ty(uchar + ptr));
        assert!(!is_void_ptr_ty(Ty::Char as i64 + ptr));
        assert!(!is_void_ptr_ty(void_ty() + 2 * ptr));
        // Representation: strips to unsigned char, so size / load /
        // arithmetic classifiers are unaffected.
        assert_eq!(strip_unsigned(void_ty()), Ty::Char as i64);
        assert!(is_unsigned_ty(void_ty()));
        assert_eq!(pointee_size_no_struct(strip_unsigned(void_ty() + ptr)), 1);
    }

    /// The declarator's qualifier algebra: `apply_qual_bits` records a
    /// volatile at the derivation built so far, which `add_ptr_level`
    /// leaves below the new one.
    #[test]
    fn volatile_object_tracks_the_outermost_derivation() {
        let int = Ty::Int as i64;
        let vol = VOLATILE_BIT;
        // `volatile T x` -- the object is volatile.
        assert!(is_volatile_object_ty(apply_qual_bits(int, vol)));
        // `volatile T *p` -- the pointee is, `p` is not.
        let pointee_vol = add_ptr_level(apply_qual_bits(int, vol));
        assert!(is_volatile_ty(pointee_vol));
        assert!(!is_volatile_object_ty(pointee_vol));
        // `T *volatile p` -- the pointer object is.
        let obj_vol = apply_qual_bits(add_ptr_level(int), vol);
        assert!(is_volatile_object_ty(obj_vol));
        // `volatile T *volatile p` -- both.
        assert!(is_volatile_object_ty(apply_qual_bits(pointee_vol, vol)));
        // `volatile T **p` -- neither pointer level is qualified.
        assert!(!is_volatile_object_ty(add_ptr_level(pointee_vol)));
        // `volatile T *volatile *p` -- the inner pointer is, `p` is not.
        assert!(!is_volatile_object_ty(add_ptr_level(apply_qual_bits(
            pointee_vol,
            vol
        ))));
        assert_eq!(add_ptr_level(int), int + Ty::Ptr as i64);
        assert_eq!(strip_unsigned(pointee_vol), int + Ty::Ptr as i64);
        // Band classifiers see through every marker.
        assert!(is_pointer_ty(pointee_vol));
        assert!(is_pointer_ty(obj_vol));
        // The level is part of the tag: `T *volatile *` and `volatile T **`
        // differ from each other and from `T **`.
        let inner_vol = add_ptr_level(obj_vol);
        let base_vol = add_ptr_level(pointee_vol);
        let plain = int + 2 * Ty::Ptr as i64;
        assert!(inner_vol != base_vol && inner_vol != plain && base_vol != plain);
        assert_eq!(strip_unsigned(inner_vol), plain);
        // A dereference drops the removed level's qualifier from the type
        // and keeps the conservative marker for the access.
        let deref = pointee_ty(obj_vol);
        assert!(!is_volatile_object_ty(deref) && is_volatile_ty(deref));
        assert_eq!(exact_volatile_ty(deref), int);
        assert_eq!(pointee_ty(inner_vol), obj_vol);
        // Past the recorded levels, the object takes the conservative answer.
        let deep = apply_qual_bits(int + 8 * Ty::Ptr as i64, vol);
        assert!(is_volatile_object_ty(deep) && is_volatile_object_ty(deep + Ty::Ptr as i64));
    }

    /// The segment qualifier records the derivation level it applies
    /// at, so plain band arithmetic (dereference, address-of, decay)
    /// keeps [`segment_of_object_ty`] exact with no per-site updates.
    #[test]
    fn segment_object_tracks_the_qualified_derivation() {
        let int = Ty::Int as i64;
        let ptr = Ty::Ptr as i64;
        // `int __seg_gs g` -- the object is in the named space.
        let gs_int = apply_qual_bits(int, SEG_GS_BIT);
        assert_eq!(segment_of_object_ty(gs_int), Some(Segment::Gs));
        // `int __seg_gs *p` -- `p` is generic, `*p` is not; `&*p`
        // (plain `+ Ty::Ptr`) restores the pointer reading.
        let p = add_ptr_level(gs_int);
        assert_eq!(segment_of_object_ty(p), None);
        assert_eq!(segment_of_ty(p), Some(Segment::Gs));
        assert_eq!(segment_of_object_ty(p - ptr), Some(Segment::Gs));
        assert_eq!(segment_of_object_ty(p - ptr + ptr), None);
        // `int __seg_gs **pp` -- only the second dereference is
        // qualified.
        let pp = add_ptr_level(p);
        assert_eq!(segment_of_object_ty(pp), None);
        assert_eq!(segment_of_object_ty(pp - ptr), None);
        assert_eq!(segment_of_object_ty(pp - 2 * ptr), Some(Segment::Gs));
        // `int * __seg_fs q` -- the pointer object is qualified, its
        // pointee is not.
        let q = apply_qual_bits(add_ptr_level(int), SEG_FS_BIT);
        assert_eq!(segment_of_object_ty(q), Some(Segment::Fs));
        assert_eq!(segment_of_object_ty(q - ptr), None);
        // A struct-band tag records its own depth the same way.
        let gs_struct = apply_qual_bits(STRUCT_BASE, SEG_GS_BIT);
        assert_eq!(segment_of_object_ty(gs_struct), Some(Segment::Gs));
        assert_eq!(segment_of_object_ty(gs_struct + ptr), None);
        // Band classifiers see through the qualifier and its level.
        assert!(is_pointer_ty(p));
        assert_eq!(strip_unsigned(p), int + ptr);
    }

    /// The `const` field records the derivation each qualifier applies
    /// to, so band arithmetic keeps `is_const_object_ty` exact and
    /// `strip_object_const` drops only the outermost one.
    #[test]
    fn const_tracks_the_qualified_derivation() {
        let int = Ty::Int as i64;
        let ptr = Ty::Ptr as i64;
        // `const int x` -- the object is const.
        let cint = apply_qual_bits(int, CONST_BIT);
        assert!(is_const_object_ty(cint));
        assert_eq!(strip_object_const(cint), int);
        // `const int *p` -- `p` is unqualified, `*p` is const, and
        // `&*p` (plain `+ Ty::Ptr`) restores the pointer reading.
        let p = add_ptr_level(cint);
        assert!(!is_const_object_ty(p));
        assert!(is_const_object_ty(p - ptr));
        assert!(!is_const_object_ty(p - ptr + ptr));
        assert_eq!(strip_object_const(p), p);
        assert_ne!(p, int + ptr);
        // `int *const q` -- the pointer object is const, its pointee not.
        let q = apply_qual_bits(add_ptr_level(int), CONST_BIT);
        assert!(is_const_object_ty(q));
        assert!(!is_const_object_ty(q - ptr));
        assert_eq!(strip_object_const(q), int + ptr);
        // `const int *const r` -- both levels; the value keeps the
        // pointee's.
        let r = apply_qual_bits(p, CONST_BIT);
        assert_eq!(strip_object_const(r), p);
        assert_eq!(pointee_qual_bits(r, int + ptr), p - (int + ptr));
        assert_eq!(pointee_qual_bits(q, int + ptr), 0);
        assert_eq!(pointee_qual_bits(int, int + ptr), 0);
        // A struct-band tag records its own depth the same way.
        let cs = apply_qual_bits(STRUCT_BASE, CONST_BIT);
        assert!(is_const_object_ty(cs));
        assert!(!is_const_object_ty(cs + ptr));
        assert!(is_const_object_ty(cs + ptr - ptr));
        // Band classifiers and the assignment view see through the
        // field, the request bit never survives, and the other markers
        // are untouched.
        assert!(is_pointer_ty(p));
        assert_eq!(strip_unsigned(r), int + ptr);
        assert_eq!(unqualified_object_ty(r), int + ptr);
        assert_eq!(r & CONST_BIT, 0);
        assert!(is_unsigned_ty(apply_qual_bits(
            int | UNSIGNED_BIT,
            CONST_BIT
        )));
        assert!(is_void_ty(apply_qual_bits(void_ty(), CONST_BIT)));
        assert_eq!(QUAL_PTR_LVL_MASK & r, q & CONST_LVL_MASK);
        // `volatile` is not the object-level const strip's to drop; the
        // unqualified version drops it at the type's own level only.
        let pv = apply_qual_bits(add_ptr_level(int), VOLATILE_BIT);
        assert_eq!(strip_object_const(pv), pv);
        assert_eq!(unqualified_version_ty(pv), int + ptr);
        let vp = add_ptr_level(apply_qual_bits(int, VOLATILE_BIT));
        assert_eq!(unqualified_version_ty(vp), vp);
        assert_eq!(unqualified_version_ty(r), p);
        assert_eq!(unqualified_version_ty(cint), int);
    }

    #[test]
    fn format_type_spells_const_at_its_level() {
        let int = Ty::Int as i64;
        let cint = apply_qual_bits(int, CONST_BIT);
        assert_eq!(format_type(cint, &[]), "const int");
        assert_eq!(format_type(add_ptr_level(cint), &[]), "const int*");
        let q = apply_qual_bits(add_ptr_level(int), CONST_BIT);
        assert_eq!(format_type(q, &[]), "int* const");
        assert_eq!(format_type(add_ptr_level(q), &[]), "int* const *");
        assert_eq!(
            format_type(apply_qual_bits(add_ptr_level(cint), CONST_BIT), &[]),
            "const int* const"
        );
        assert_eq!(
            format_type(add_ptr_level(apply_qual_bits(void_ty(), CONST_BIT)), &[]),
            "const void*"
        );
        assert_eq!(
            format_type(apply_qual_bits(int | UNSIGNED_BIT, CONST_BIT), &[]),
            "const unsigned int"
        );
        assert_eq!(format_type(add_ptr_level(int), &[]), "int*");
        // `volatile` is spelled at its level as `const` is.
        let v = VOLATILE_BIT;
        let pv = apply_qual_bits(add_ptr_level(int), v);
        assert_eq!(format_type(add_ptr_level(pv), &[]), "int* volatile *");
        assert_eq!(
            format_type(apply_qual_bits(cint, v), &[]),
            "const volatile int"
        );
        assert_eq!(
            format_type(apply_qual_bits(q, v), &[]),
            "int* const volatile"
        );
    }

    #[test]
    fn is_pointer_ty_matches_producible_tags() {
        for &ty in &producible_tags() {
            for u in [0i64, UNSIGNED_BIT, UNSIGNED_BIT | VOID_BIT] {
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
