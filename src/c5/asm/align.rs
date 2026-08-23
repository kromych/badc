//! The alignment directive family -- `.align`, `.p2align`, `.balign`
//! and their sized and fill-carrying spellings -- and the padding each
//! one emits: a byte pattern in data, the target's no-op encodings in
//! code.

use super::*;
use crate::c5::codegen::map_syms::MapClass;

/// The no-op forms an executable alignment gap's default fill takes: the
/// target's, and on x86 the encoding mode the directive stands in. `.code32`
/// and `.code64` share one set; the 16-bit forms are their own, since a
/// 32-bit no-op decodes to a different length under 16-bit addressing.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AlignNops {
    #[default]
    X86,
    X86Bits16,
    A64,
}

impl AlignNops {
    /// The set a target starts in, before any encoding-mode directive.
    pub(crate) fn of_target(is_aarch64: bool) -> Self {
        if is_aarch64 {
            AlignNops::A64
        } else {
            AlignNops::X86
        }
    }

    /// The x86 no-op forms by length: index `n - 1` holds the `n`-byte form.
    fn x86_forms(self) -> &'static [&'static [u8]] {
        match self {
            AlignNops::X86Bits16 => &X86_NOPS_16,
            _ => &X86_NOPS,
        }
    }

    /// Maximal-length no-ops GNU as lays in one gap before it jumps over the
    /// padding instead.
    fn x86_max_nops(self) -> usize {
        match self {
            AlignNops::X86Bits16 => X86_MAX_NOPS_16,
            _ => X86_MAX_NOPS,
        }
    }

    /// Opcode of the jump over padding whose displacement is 32-bit. In
    /// 16-bit mode the operand-size prefix selects that width.
    fn x86_jmp_rel32(self) -> &'static [u8] {
        match self {
            AlignNops::X86Bits16 => &[0x66, 0xe9],
            _ => &[0xe9],
        }
    }
}

/// How a target reads an alignment directive's first operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AlignKind {
    /// `.balign`: a byte count.
    Bytes,
    /// `.p2align`: a power-of-two exponent.
    Pow2,
    /// `.align`: a byte count on x86 ELF, an exponent on AArch64.
    Arch,
}

/// The alignment directive family and the width of the fill unit its
/// spelling selects. GNU as gives `.balign` and `.p2align` a `w` and an `l`
/// spelling padding with a 2- or 4-byte value; `.align` has neither.
pub(crate) fn align_directive(tok: &str) -> Option<(AlignKind, u8)> {
    let (base, width) = match tok.as_bytes().last() {
        Some(b'w') => (&tok[..tok.len() - 1], 2u8),
        Some(b'l') => (&tok[..tok.len() - 1], 4),
        _ => (tok, 1),
    };
    match (base, width) {
        (".align", 1) => Some((AlignKind::Arch, 1)),
        (".balign", _) => Some((AlignKind::Bytes, width)),
        (".p2align", _) => Some((AlignKind::Pow2, width)),
        _ => None,
    }
}

/// An alignment directive's explicit fill: the value and the width in bytes
/// of the unit repeated over the gap. The value is truncated to the width and
/// laid down little-endian.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct AlignFill {
    pub(crate) value: u32,
    pub(crate) width: u8,
}

impl AlignFill {
    /// Whether this is the one-byte x86 NOP, which GNU as pads with its
    /// NOP sequence rather than by repeating the byte.
    fn is_x86_nop(&self) -> bool {
        self.width == 1 && self.value as u8 == X86_NOP_OPCODE
    }
}

/// An alignment directive's first operand: a byte count, or an expression
/// over labels. GNU as requires the operand to reduce to a constant where
/// the directive stands, so only definitions the layout has already placed
/// resolve and a forward reference has no value.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AlignSpec {
    /// Already read under the directive's convention.
    Bytes(u32),
    /// Read under `pow2` -- the `.p2align` exponent convention -- once the
    /// expression resolves.
    Expr {
        text: alloc::string::String,
        pow2: bool,
    },
}

/// The byte alignment a resolved operand denotes: a power-of-two byte count,
/// or two raised to an exponent up to 12. A zero count is an alignment of
/// one, as GNU as reads it. `None` when the operand is out of range.
fn align_spec_value(v: i64, pow2: bool) -> Option<u32> {
    if pow2 {
        return (0..=12).contains(&v).then(|| 1u32 << v);
    }
    u32::try_from(v)
        .ok()
        .filter(|&n| n == 0 || n.is_power_of_two())
        .map(|n| n.max(1))
}

impl AlignSpec {
    /// The byte alignment requested. `resolve` values a label reference, and
    /// only for a definition already placed.
    pub(crate) fn bytes(
        &self,
        resolve: &dyn Fn(&str) -> Option<i64>,
    ) -> Result<u32, alloc::string::String> {
        let (text, pow2) = match self {
            AlignSpec::Bytes(n) => return Ok(*n),
            AlignSpec::Expr { text, pow2 } => (text, *pow2),
        };
        // A numeric forward reference names a definition the layout has not
        // placed yet, which GNU as has no value for here.
        let placed = |t: &str| {
            let fwd = t.ends_with('f') && numeric_label_digits(t).is_some();
            (!fwd).then(|| resolve(t)).flatten()
        };
        let v = eval_asm_expr_with_labels(text, &placed).ok_or_else(|| {
            alloc::format!("inline asm: alignment `{text}` is not constant where it stands")
        })?;
        align_spec_value(v, pow2)
            .ok_or_else(|| alloc::format!("inline asm: bad alignment `{text}` ({v})"))
    }
}

/// An alignment item with its operand resolved to a byte count, so the
/// padding, the section alignment and the mapping state all read one value.
/// `None` when the item needs no resolution.
pub(crate) fn resolve_align_item(
    item: &AsmSectionItem,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Result<Option<AsmSectionItem>, alloc::string::String> {
    let AsmSectionItem::Align {
        spec: spec @ AlignSpec::Expr { .. },
        fill,
        max,
        nops,
    } = item
    else {
        return Ok(None);
    };
    Ok(Some(AsmSectionItem::Align {
        spec: AlignSpec::Bytes(spec.bytes(resolve)?),
        fill: *fill,
        max: *max,
        nops: *nops,
    }))
}

/// Parse the operands of an alignment directive: `spec[, fill[, max]]`.
/// GNU as allows an empty fill field (`.p2align e,,max`) to keep the default
/// fill while giving a max skip. `fill_width` is the directive spelling's
/// fill unit width. Returns the alignment operand's text, the optional fill,
/// and the optional maximum bytes to skip.
pub(crate) fn parse_align_operands(
    rest: &str,
    fill_width: u8,
) -> Option<(&str, Option<AlignFill>, Option<u32>)> {
    let mut fields = rest.split(',').map(str::trim);
    let spec = fields.next().filter(|s| !s.is_empty())?;
    let field = |f: Option<&str>| -> Option<Option<i64>> {
        match f {
            Some(s) if !s.is_empty() => Some(Some(parse_raw_int(s)?)),
            _ => Some(None),
        }
    };
    let fill = field(fields.next())?.map(|v| AlignFill {
        value: v as u32,
        width: fill_width,
    });
    let max = match field(fields.next())? {
        Some(v) => Some(u32::try_from(v).ok()?),
        None => None,
    };
    if fields.next().is_some() {
        return None;
    }
    Some((spec, fill, max))
}

/// Parse an alignment directive to its section item. `kind` selects the
/// operand's convention -- `.align`'s is the target's -- and `width` the
/// fill unit. A non-literal operand is kept as an expression the layout
/// resolves where the directive stands, as GNU as resolves one.
pub(crate) fn parse_align_item(
    kind: AlignKind,
    width: u8,
    rest: &str,
    is_aarch64: bool,
) -> Result<AsmSectionItem, alloc::string::String> {
    let bad = || alloc::format!("inline asm: bad alignment `{rest}`");
    let pow2 = match kind {
        AlignKind::Bytes => false,
        AlignKind::Pow2 => true,
        AlignKind::Arch => is_aarch64,
    };
    let (text, fill, max) = parse_align_operands(rest, width).ok_or_else(bad)?;
    let spec = match parse_raw_int(text) {
        Some(v) => AlignSpec::Bytes(align_spec_value(v, pow2).ok_or_else(bad)?),
        None if is_asm_layout_expr(text) => AlignSpec::Expr {
            text: alloc::string::String::from(text),
            pow2,
        },
        None => return Err(bad()),
    };
    Ok(AsmSectionItem::Align {
        spec,
        fill,
        max,
        nops: AlignNops::of_target(is_aarch64),
    })
}

/// Bytes needed to advance `at` to the next multiple of `align`, or zero when
/// GNU as would drop the alignment because the gap exceeds the `max` skip.
pub(crate) fn align_gap(at: i64, align: i64, max: Option<u32>) -> i64 {
    let gap = (align - at.rem_euclid(align)).rem_euclid(align);
    match max {
        Some(m) if gap > m as i64 => 0,
        _ => gap,
    }
}

/// The byte pattern that fills an alignment gap. An explicit fill unit is
/// repeated little-endian. With no explicit fill GNU as pads an executable
/// section with the target NOP encoding (single-byte on x86, the 4-byte
/// instruction on AArch64) and a data section with zero. The pattern cycles
/// by absolute section offset: an accepted gap starts on a multiple of the
/// fill width, so that is also the gap-relative order, and the AArch64 NOP
/// lands instruction-aligned.
pub(crate) fn align_fill_pattern(
    fill: Option<AlignFill>,
    exec: bool,
    nops: AlignNops,
) -> ([u8; 4], usize) {
    match (fill, exec, nops) {
        (Some(f), _, _) => (f.value.to_le_bytes(), f.width as usize),
        (None, false, _) => ([0, 0, 0, 0], 1),
        (None, true, AlignNops::A64) => (A64_NOP, A64_NOP.len()),
        (None, true, _) => ([X86_NOP_OPCODE, 0, 0, 0], 1),
    }
}

/// Lay an alignment gap's padding at the end of `out`, whose length is a
/// section offset, and report how it splits for the mapping symbols: the
/// leading run's length, which is data, then the rest in the returned class.
/// `after_insn` reports whether the byte before the gap came from an
/// instruction, which the x86 NOP sequence depends on.
///
/// GNU as requires the gap to be a whole number of fill units, so a `.balignl`
/// or `.p2alignw` whose padding does not divide by its width is an error
/// rather than a truncated unit.
pub(crate) fn push_align_fill(
    out: &mut alloc::vec::Vec<u8>,
    gap: usize,
    fill: Option<AlignFill>,
    exec: bool,
    nops: AlignNops,
    after_insn: bool,
) -> Result<(usize, MapClass), alloc::string::String> {
    if let Some(f) = fill
        && !gap.is_multiple_of(f.width as usize)
    {
        return Err(alloc::format!(
            "inline asm: alignment padding ({gap} bytes) not a multiple of {}",
            f.width
        ));
    }
    let aarch64 = nops == AlignNops::A64;
    // The sub-word remainder of an AArch64 code gap is data and the whole
    // words are NOPs.
    if fill.is_none() && exec && aarch64 {
        return Ok((push_a64_exec_align_fill(out, gap), MapClass::Code));
    }
    let nop_fill = fill.is_none_or(|f| f.is_x86_nop());
    if nop_fill && exec && !aarch64 {
        push_x86_exec_align_fill(out, gap, after_insn, nops);
        return Ok((0, MapClass::Code));
    }
    let (pat, plen) = align_fill_pattern(fill, exec, nops);
    for _ in 0..gap {
        out.push(pat[out.len() % plen]);
    }
    // The padding holds instructions where the fill is the target NOP, and on
    // AArch64 also where it is explicit, which GNU as leaves in the
    // instruction state.
    Ok((
        0,
        if exec && (aarch64 || nop_fill) {
            MapClass::Code
        } else {
            MapClass::Data
        },
    ))
}

/// The AArch64 NOP, `d503201f`. Its length is the instruction size, the
/// boundary code and alignment padding split on.
pub(crate) const A64_NOP: [u8; 4] = [0x1f, 0x20, 0x03, 0xd5];

/// Fill an AArch64 executable alignment gap as GNU as does: the gap's
/// sub-word remainder as zeros, then whole NOPs. Returns the zero run's
/// length, which is data where the NOPs are code.
pub(crate) fn push_a64_exec_align_fill(out: &mut alloc::vec::Vec<u8>, gap: usize) -> usize {
    let zeros = gap % A64_NOP.len();
    out.resize(out.len() + zeros, 0);
    for _ in 0..(gap - zeros) / A64_NOP.len() {
        out.extend_from_slice(&A64_NOP);
    }
    zeros
}

/// Bytes before an instruction: GNU as brings an AArch64 executable
/// section's counter to the instruction size only out of the data mapping
/// state, so an instruction after an alignment directive or an odd `.org`
/// stays where the counter is. The padding belongs to the data run, and
/// the labels already placed keep their unaligned values. x86-64 never
/// pads.
pub(crate) fn insn_align_gap(
    at: i64,
    state: Option<MapClass>,
    exec: bool,
    align_is_p2: bool,
) -> i64 {
    if align_is_p2 && exec && state == Some(MapClass::Data) {
        align_gap(at, A64_NOP.len() as i64, None)
    } else {
        0
    }
}

/// The x86-64 multi-byte NOP of each length GNU as pads executable
/// alignment gaps with, lengths 1..=11.
pub(crate) const X86_NOPS: [&[u8]; 11] = [
    &[0x90],
    &[0x66, 0x90],
    &[0x0f, 0x1f, 0x00],
    &[0x0f, 0x1f, 0x40, 0x00],
    &[0x0f, 0x1f, 0x44, 0x00, 0x00],
    &[0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
    &[0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
    &[0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[
        0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
    ],
];

/// The 16-bit no-op of each length GNU as pads a `.code16` executable
/// alignment gap with, lengths 1..=5.
pub(crate) const X86_NOPS_16: [&[u8]; 5] = [
    &[0x90],
    &[0x89, 0xf6],
    &[0x8d, 0x74, 0x00],
    &[0x8d, 0xb4, 0x00, 0x00],
    &[0x2e, 0x8d, 0xb4, 0x00, 0x00],
];

/// Maximal-length NOPs GNU as lays in one alignment gap before it jumps over
/// the padding instead. The threshold is on the count, so the byte gap it
/// falls at is this times the longest NOP of the mode's set.
pub(crate) const X86_MAX_NOPS: usize = 7;

/// The same count under the 16-bit no-op forms.
pub(crate) const X86_MAX_NOPS_16: usize = 2;

/// Fill an x86 executable alignment gap with multi-byte NOPs, as GNU as
/// does: the sub-maximal remainder first, then maximal-length NOPs.
///
/// `after_insn` reports whether the byte before the gap came from an
/// instruction. When it did not -- the gap opens after a data directive,
/// which the assembler cannot assume ends on an instruction boundary --
/// GNU as leads with the one-byte NOP and fills the rest by the same
/// scheme. An alignment directive's own fill does not establish a
/// boundary, so consecutive alignments after data each take the leading
/// byte.
///
/// A gap needing more than [`X86_MAX_NOPS`] maximal NOPs opens with a jump
/// over the rest, so falling through the padding costs one branch instead of
/// the whole run.
pub(crate) fn push_x86_exec_align_fill(
    out: &mut alloc::vec::Vec<u8>,
    gap: usize,
    after_insn: bool,
    nops: AlignNops,
) {
    let forms = nops.x86_forms();
    let mut gap = gap;
    if !after_insn && gap > 0 {
        out.extend_from_slice(forms[0]);
        gap -= 1;
    }
    if gap / forms.len() > nops.x86_max_nops() {
        gap -= push_x86_pad_jump(out, gap, nops);
    }
    let rem = gap % forms.len();
    if rem > 0 {
        out.extend_from_slice(forms[rem - 1]);
    }
    for _ in 0..gap / forms.len() {
        out.extend_from_slice(forms[forms.len() - 1]);
    }
}

/// Lay a jump over the remaining `gap` bytes of alignment padding and report
/// the bytes it took. GNU as takes the `rel8` form while the distance past it
/// fits a signed byte and the 32-bit-displacement form otherwise; a distance
/// neither reaches leaves the gap to the NOPs.
fn push_x86_pad_jump(out: &mut alloc::vec::Vec<u8>, gap: usize, nops: AlignNops) -> usize {
    const JMP_REL8: u8 = 0xeb;
    if let Ok(disp) = i8::try_from(gap as i64 - 2) {
        out.extend_from_slice(&[JMP_REL8, disp as u8]);
        return 2;
    }
    let opcode = nops.x86_jmp_rel32();
    let len = opcode.len() + 4;
    match i32::try_from(gap as i64 - len as i64) {
        Ok(disp) => {
            out.extend_from_slice(opcode);
            out.extend_from_slice(&disp.to_le_bytes());
            len
        }
        Err(_) => 0,
    }
}

/// GNU as routes a code-section alignment whose explicit fill byte is the
/// one-byte NOP through the NOP-sequence path rather than repeating the
/// byte, so `.balign n, 0x90` pads like a fill-less `.balign n`.
pub(crate) const X86_NOP_OPCODE: u8 = 0x90;
