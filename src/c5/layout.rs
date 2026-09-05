//! Object-layout authority.
//!
//! One description of how a compiled unit's static data is measured,
//! aligned, serialised, and addressed. The image writers and the linker
//! read it for record serialisation and section padding, the
//! data-compaction pass for the offset surface it must rewrite, and the
//! symbol table for each object's extent.
//!
//! The offset surface is a trait rather than a list: every implementation
//! destructures its type without `..`, so a new field holding a `.data`
//! offset fails to compile until it is classified.

#[cfg(any(feature = "native-emit", feature = "full"))]
use alloc::vec::Vec;

// ------------------------------------------------------------------
// Image-layout primitives.
// ------------------------------------------------------------------

/// Unsigned width a layout cursor can be rounded on.
pub(crate) trait AlignInt: Copy {
    fn round_up_to(self, align: Self) -> Self;
}

macro_rules! impl_align_int {
    ($($t:ty),*) => {$(
        impl AlignInt for $t {
            fn round_up_to(self, align: Self) -> Self {
                if align == 0 { self } else { self.div_ceil(align) * align }
            }
        }
    )*};
}
impl_align_int!(u32, u64, usize);

/// Round `n` up to the next multiple of `align`; `align == 0` leaves `n`
/// unchanged. Overflow-free over the whole range, unlike the
/// `(n + align - 1) & !(align - 1)` form, and correct for a non-power-of-two
/// alignment, which that form silently mis-rounds.
pub(crate) fn round_up<T: AlignInt>(n: T, align: T) -> T {
    n.round_up_to(align)
}

/// Append a `Copy` record as raw host-order bytes. Callers pass
/// `#[repr(C)]` on-disk headers whose in-memory layout is the file
/// layout; badc's targets are little-endian, so no byte swap is needed.
#[cfg(any(feature = "native-emit", feature = "full"))]
pub(crate) fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "object writers assume a little-endian host; emit bytes manually to cross-build from big-endian"
    );
    // SAFETY: `value` is a live `T` the caller owns and `size_of::<T>()`
    // bounds the read exactly; the bytes are only copied out.
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Zero-pad `out` up to the next multiple of `align`.
#[cfg(any(feature = "native-emit", feature = "full"))]
pub(crate) fn pad_to_align(out: &mut Vec<u8>, align: usize) {
    out.resize(round_up(out.len(), align), 0);
}

// ------------------------------------------------------------------
// Data-object alignment.
// ------------------------------------------------------------------

/// Minimum alignment of the `.data` image. C99 6.2.8: an object must sit
/// at an address suitable for its type, and 8 is the widest scalar badc
/// places in `.data`.
pub(crate) const DATA_ALIGN_MIN: usize = 8;

/// Minimum alignment of the `.bss` image and of a compacted object's
/// packed base. Covers `_Alignas(16)` and 16-byte aggregates.
pub(crate) const BSS_ALIGN_MIN: usize = 16;

/// Alignment the `.data` image is placed at, given a unit's declared
/// requirement.
pub(crate) fn data_image_align(declared: usize) -> usize {
    declared.max(DATA_ALIGN_MIN)
}

/// Minimum alignment of the thread-local image: the boundary every
/// object wider than a byte is placed on.
pub(crate) const TLS_ALIGN_MIN: usize = 8;

/// Alignment of the thread-local image, given the largest alignment among
/// its objects. The loader places each thread's copy on it, so it is the
/// ELF `PT_TLS` `p_align` and the rounding of the block's offset from the
/// thread pointer.
pub(crate) fn tls_image_align(declared: usize) -> usize {
    declared.max(TLS_ALIGN_MIN)
}

/// Alignment the `.bss` image is placed at, given a unit's declared
/// requirement. Also the granularity of a compacted image's region
/// boundaries, and the ceiling on a packed object's own alignment.
pub(crate) fn bss_image_align(declared: usize) -> usize {
    declared.max(BSS_ALIGN_MIN).next_power_of_two()
}

/// Placement alignment of each `.data` object interval named by the
/// sorted `starts`, capped at `cap`, the section's own alignment.
///
/// C99 6.2.8: an object sits on a boundary suitable for its type. The
/// layout pads every allocation to `DATA_ALIGN_MIN` and records anything
/// stricter in the defining symbol's `data_align` and in
/// `Program::data_align_marks`, which also covers objects no symbol
/// surfaces at that point (a block-scope static). An interval runs to
/// the next recorded start, so every constraint recorded inside it binds
/// it: a base congruent to the interval's start modulo the value here
/// keeps each object in it on its boundary.
pub(crate) fn data_object_aligns(
    program: &crate::c5::program::Program,
    starts: &[i64],
    cap: usize,
) -> alloc::vec::Vec<i64> {
    let data_len = program.data.len() as i64;
    let cap = bss_image_align(cap) as i64;
    let mut aligns = alloc::vec![DATA_ALIGN_MIN as i64; starts.len()];
    let mut note = |off: i64, a: i64| {
        if a <= DATA_ALIGN_MIN as i64 || !(0..data_len).contains(&off) {
            return;
        }
        let i = match starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        };
        let a = ((a as usize).next_power_of_two() as i64).min(cap);
        if let Some(slot) = aligns.get_mut(i) {
            *slot = (*slot).max(a);
        }
    };
    for sym in &program.symbols {
        if sym.class == crate::c5::token::Token::Glo as i64
            && sym.defined_here
            && !sym.is_thread_local
        {
            note(sym.val, sym.data_align);
        }
    }
    for &(off, a) in &program.data_align_marks {
        note(off, a);
    }
    aligns
}

// ------------------------------------------------------------------
// Data-object extent.
// ------------------------------------------------------------------

/// Byte size of a defined data global.
///
/// The compiler records the laid-out size in `Symbol::data_byte_size`,
/// which covers aggregates; the width-based derivation below is the
/// fallback for a symbol that predates it (an archive-reloaded unit).
/// A struct or union with neither returns 0 -- its storage size needs
/// type layout the object writers do not carry, and consumers then see
/// an unsized symbol.
///
/// A zero-length array (`T x[] = {}`, `T x[0]`) is the one object whose
/// recorded size is a real zero rather than an absent record, so it is
/// answered before the fallback runs.
#[cfg(feature = "native-emit")]
pub(crate) fn data_object_byte_size(sym: &crate::c5::symbol::Symbol) -> u64 {
    use crate::c5::compiler::types::{is_pointer_ty, strip_unsigned};
    use crate::c5::token::Ty;
    if sym.data_byte_size > 0 {
        return sym.data_byte_size as u64;
    }
    if sym.is_zero_len_array {
        return 0;
    }
    let ty = sym.type_;
    let elem: u64 = if is_pointer_ty(ty) {
        8
    } else {
        let stripped = strip_unsigned(ty);
        if stripped == Ty::Char as i64 || stripped == Ty::Bool as i64 {
            1
        } else if stripped == Ty::Short as i64 {
            2
        } else if stripped == Ty::Int as i64 || stripped == Ty::Float as i64 {
            4
        } else if stripped == Ty::Long as i64
            || stripped == Ty::LongLong as i64
            || stripped == Ty::Double as i64
        {
            8
        } else {
            return 0;
        }
    };
    let count = if sym.array_size > 0 {
        sym.array_size as u64
    } else {
        1
    };
    elem * count
}

/// Storage a defined data global occupies in `.data`, and the bytes of it
/// that carry the object's own value.
///
/// `extent` is the reserved span, including the slot rounding the
/// tentative-definition path applies (C99 6.9.2); `copy` is the object's
/// own size, which is what moves when the object is carved out into a
/// named section. They differ only in the trailing padding.
#[cfg(feature = "native-emit")]
pub(crate) struct DataObjectExtent {
    pub copy: u64,
    pub extent: u64,
}

/// Measure a defined data global. Returns `None` for a symbol that
/// reserved no storage.
#[cfg(feature = "native-emit")]
pub(crate) fn data_object_extent(sym: &crate::c5::symbol::Symbol) -> Option<DataObjectExtent> {
    let computed = data_object_byte_size(sym);
    let extent = (sym.reserved_data_bytes as u64).max(computed);
    if extent == 0 {
        return None;
    }
    let copy = if computed > 0 {
        computed.min(extent)
    } else {
        extent
    };
    Some(DataObjectExtent { copy, extent })
}

// ------------------------------------------------------------------
// Data-offset surface.
// ------------------------------------------------------------------

/// How the compaction pass moves one data object.
pub(crate) trait DataRemap {
    /// Whether `off` names a byte of the image being repacked. An offset
    /// outside it (a TLS-image offset, an `ent_pc`, a sentinel) is not a
    /// `.data` reference and passes through untouched.
    fn in_data(&self, off: i64) -> bool;

    /// New offset for the byte at `off`, whose object is the one anchored
    /// at `anchor`. `None` when that object did not survive.
    fn remap(&self, off: i64, anchor: i64) -> Option<i64>;

    /// New `[lo, hi)` byte span. `None` when the span does not survive
    /// whole -- it names a dropped object, or straddles an object boundary
    /// whose two sides no longer sit together.
    fn remap_span(&self, lo: i64, hi: i64) -> Option<(i64, i64)>;
}

/// Every stored byte offset into `Program::data`.
///
/// Implementations destructure their type exhaustively, so a new
/// offset-bearing field is a compile error rather than an offset the
/// compaction pass leaves pointing into repacked bytes.
pub(crate) trait DataOffsets {
    fn remap_data_offsets(&mut self, r: &dyn DataRemap);
}

/// Rewrite a self-anchored offset, collapsing a dropped object to 0 --
/// the offset of the leading NULL guard, which every image keeps.
pub(crate) fn remap_self(off: &mut i64, r: &dyn DataRemap) {
    if r.in_data(*off) {
        *off = r.remap(*off, *off).unwrap_or(0);
    }
}

/// `remap_self` for a `u64`-typed offset.
pub(crate) fn remap_self_u64(off: &mut u64, r: &dyn DataRemap) {
    let mut v = *off as i64;
    remap_self(&mut v, r);
    *off = v as u64;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn round_up_aligns_correctly() {
        assert_eq!(round_up(0u32, 0x200), 0);
        assert_eq!(round_up(1u32, 0x200), 0x200);
        assert_eq!(round_up(0x200u32, 0x200), 0x200);
        assert_eq!(round_up(0x201u32, 0x200), 0x400);
        assert_eq!(round_up(7usize, 8), 8);
        assert_eq!(round_up(9u64, 8), 16);
    }

    /// A zero alignment is a no-op rather than a division fault; the
    /// mask form this replaced would have underflowed.
    #[test]
    fn round_up_tolerates_zero_alignment() {
        assert_eq!(round_up(5u64, 0), 5);
    }

    /// A non-power-of-two alignment rounds to a real multiple. The mask
    /// form silently produced a non-multiple.
    #[test]
    fn round_up_handles_non_power_of_two() {
        assert_eq!(round_up(10u64, 3), 12);
        assert_eq!(round_up(12u64, 3), 12);
    }

    /// `copy` never exceeds `extent`: the bytes moved into a named section
    /// always fit the storage vacated for them. The two used to be derived
    /// at separate sites and could disagree.
    #[test]
    #[cfg(feature = "native-emit")]
    fn object_extent_covers_its_copy() {
        let mut sym = crate::c5::symbol::Symbol {
            data_byte_size: 12,
            reserved_data_bytes: 16,
            ..Default::default()
        };
        let e = data_object_extent(&sym).expect("sized");
        assert_eq!((e.copy, e.extent), (12, 16));
        assert!(e.copy <= e.extent);

        // A reservation shorter than the object still vacates the object.
        sym.reserved_data_bytes = 4;
        let e = data_object_extent(&sym).expect("sized");
        assert_eq!((e.copy, e.extent), (12, 12));

        // A symbol with no storage is not an object.
        sym.data_byte_size = 0;
        sym.reserved_data_bytes = 0;
        sym.type_ = crate::c5::token::Ty::Int as i64 + 1000;
        assert!(data_object_extent(&sym).is_none());
    }

    /// A zero-length array records a size of zero, which is not the
    /// "no size recorded" that the width fallback answers. It reserves
    /// no storage, so it is not a placeable object and cannot be given
    /// a range that runs into the object sharing its start offset.
    #[test]
    #[cfg(feature = "native-emit")]
    fn zero_length_array_reserves_no_storage() {
        let mut sym = crate::c5::symbol::Symbol {
            type_: crate::c5::token::Ty::Int as i64,
            is_zero_len_array: true,
            ..Default::default()
        };
        assert_eq!(data_object_byte_size(&sym), 0);
        assert!(data_object_extent(&sym).is_none());

        // Without the flag the same symbol is an unrecorded scalar, and
        // the width fallback answers one element.
        sym.is_zero_len_array = false;
        assert_eq!(data_object_byte_size(&sym), 4);
    }

    #[test]
    fn image_alignment_floors() {
        assert_eq!(data_image_align(1), DATA_ALIGN_MIN);
        assert_eq!(data_image_align(64), 64);
        assert_eq!(bss_image_align(1), BSS_ALIGN_MIN);
        assert_eq!(bss_image_align(64), 64);
        // A declared alignment that is not a power of two still yields a
        // usable section alignment.
        assert_eq!(bss_image_align(24), 32);
    }
}
