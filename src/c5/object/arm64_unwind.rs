//! The ARM64 unwind codes and `.xdata` record of a badc function's prologue
//! (Microsoft, "ARM64 exception handling"). After the `bti c` landing pad and
//! the `-fpatchable-function-entry` NOPs, each taking a `nop` code, an
//! optional `paciasp` (all of a signed leaf's prolog) and a Windows variadic
//! callee's register area, a frame is `stp x29, x30, [sp, #-16]!; mov x29,
//! sp`, or a callee save pre-indexing it, the other saves, then `stp x29,
//! x30, [sp, #k]; add x29, sp, #k`. The prolog ends where x29 is set:
//! `set_fp` / `add_fp` recover sp from it, so what the body allocates after
//! is undescribed. TODO: epilog scopes.

use crate::c5::codegen::aarch64::encode::{BTI_C, NOP as NOP_INSN, PACIASP};
use alloc::vec::Vec;

const NOP: u8 = 0xE3;
pub(crate) const END: u8 = 0xE4;

/// One prologue instruction, as the unwinder sees it.
enum Insn {
    /// `bti c` or `nop`: no effect the unwinder reverses.
    Hint,
    Pac,
    SubSp(u32),
    /// A store with sp as its base: `pre` holds a pre-index's allocation,
    /// `rt2` a pair's second register, `fp` a d-register store.
    StoreSp {
        pre: Option<u32>,
        fp: bool,
        rt: u8,
        rt2: Option<u8>,
        off: u32,
    },
    /// `add x29, sp, #n`.
    AddFp(u32),
    Other,
}

impl Insn {
    /// The `stp x29, x30` of the frame record.
    fn fp_lr(&self) -> bool {
        matches!(
            self,
            Insn::StoreSp {
                fp: false,
                rt: 29,
                rt2: Some(30),
                ..
            }
        )
    }
}

fn classify(w: u32) -> Insn {
    let (rt, rn, rt2) = ((w & 31) as u8, (w >> 5) & 31, ((w >> 10) & 31) as u8);
    let simm =
        |v: u32, bits: u32, scale: i64| ((i64::from(v) << (64 - bits)) >> (64 - bits)) * scale;
    let fp = w & (1 << 26) != 0;
    let store = |pre: bool, off: i64, rt2: Option<u8>| match (pre, off) {
        (true, o) if o < 0 => Insn::StoreSp {
            pre: Some(-o as u32),
            fp,
            rt,
            rt2,
            off: 0,
        },
        (false, o) if o >= 0 => Insn::StoreSp {
            pre: None,
            fp,
            rt,
            rt2,
            off: o as u32,
        },
        _ => Insn::Other,
    };
    match w {
        BTI_C | NOP_INSN => return Insn::Hint,
        PACIASP => return Insn::Pac,
        _ => {}
    }
    if rn != 31 {
        return Insn::Other;
    }
    let pair = simm((w >> 15) & 0x7F, 7, 8);
    match w & 0xFFC0_0000 {
        // STP Xt, Xt2 / Dt, Dt2: pre-indexed, then signed offset.
        0xA980_0000 | 0x6D80_0000 => return store(true, pair, Some(rt2)),
        0xA900_0000 | 0x6D00_0000 => return store(false, pair, Some(rt2)),
        // STR Xt / Dt, unsigned scaled offset.
        0xF900_0000 | 0xFD00_0000 => return store(false, i64::from((w >> 10) & 0xFFF) * 8, None),
        _ => {}
    }
    // STR Xt / Dt, pre-indexed.
    if matches!(w & 0xFFE0_0C00, 0xF800_0C00 | 0xFC00_0C00) {
        return store(true, simm((w >> 12) & 0x1FF, 9, 1), None);
    }
    let imm = ((w >> 10) & 0xFFF) << (12 * ((w >> 22) & 1));
    match w & 0xFF80_0000 {
        0x9100_0000 if rt == 29 => Insn::AddFp(imm),
        0xD100_0000 if rt == 31 => Insn::SubSp(imm),
        _ => Insn::Other,
    }
}

/// `alloc_s` / `alloc_m` / `alloc_l` for `sub sp, sp, #bytes`.
fn alloc(bytes: u32) -> Option<Vec<u8>> {
    let x = bytes / 16;
    match x {
        _ if !bytes.is_multiple_of(16) => None,
        0..32 => Some(alloc::vec![x as u8]),
        32..2048 => Some(alloc::vec![0xC0 | (x >> 8) as u8, x as u8]),
        2048..0x0100_0000 => Some(alloc::vec![0xE0, (x >> 16) as u8, (x >> 8) as u8, x as u8]),
        _ => None,
    }
}

/// The `save_reg*` / `save_freg*` code of a callee save of x19-x28 or
/// d8-d15, alone or paired with the next register, at `[sp, #off]` or
/// pre-indexing `pre` bytes; `None` for a store no code describes.
fn save(fp: bool, rt: u8, rt2: Option<u8>, pre: Option<u32>, off: u32) -> Option<Vec<u8>> {
    let (first, count) = if fp { (8, 8) } else { (19, 10) };
    let x = rt.checked_sub(first).filter(|&x| x < count)?;
    let pair = match rt2 {
        None => false,
        Some(r) if r == rt + 1 && x + 1 < count => true,
        Some(_) => return None,
    };
    let bytes = pre.unwrap_or(off);
    if !bytes.is_multiple_of(8) {
        return None;
    }
    // A pre-index of n bytes is encoded as n / 8 - 1, an offset as off / 8.
    let z = (bytes / 8).checked_sub(u32::from(pre.is_some()))?;
    // The single pre-indexed forms carry a 5-bit offset after a wider
    // register field; the others a 6-bit offset.
    let (op, narrow) = match (fp, pair, pre.is_some()) {
        (false, true, false) => (0xC8, false),
        (false, true, true) => (0xCC, false),
        (false, false, false) => (0xD0, false),
        (false, false, true) => (0xD4, true),
        (true, true, false) => (0xD8, false),
        (true, true, true) => (0xDA, false),
        (true, false, false) => (0xDC, false),
        (true, false, true) => (0xDE, true),
    };
    match narrow {
        false if z < 64 => Some(alloc::vec![op | (x >> 2), (x & 3) << 6 | z as u8]),
        true if z < 32 => Some(alloc::vec![op | (x >> 3), (x & 7) << 5 | z as u8]),
        _ => None,
    }
}

/// The unwind codes of the prologue at `start` in `text` before `limit`, last
/// first and `end` excluded; `None` for an unsigned frameless function or
/// another shape.
pub(crate) fn prologue_codes(text: &[u8], start: u32, limit: u32) -> Option<Vec<u8>> {
    let mut at = start;
    let mut next = || -> Option<Insn> {
        if at >= limit {
            return None;
        }
        let bytes = text.get(at as usize..at as usize + 4)?;
        at += 4;
        Some(classify(u32::from_le_bytes(bytes.try_into().ok()?)))
    };
    let mut fwd: Vec<Vec<u8>> = Vec::new();
    let mut insn = next()?;
    while let Insn::Hint = insn {
        fwd.push(alloc::vec![NOP]);
        insn = next()?;
    }
    if let Insn::Pac = insn {
        fwd.push(alloc::vec![0xFC]);
        // A signed leaf's prolog ends at `paciasp`.
        match next() {
            Some(i) => insn = i,
            None => return Some(fwd.into_iter().rev().flatten().collect()),
        }
    }
    // The register area's stores home arguments and restore nothing.
    if let Insn::SubSp(n) = insn {
        fwd.push(alloc(n)?);
        insn = next()?;
        while matches!(insn, Insn::StoreSp { pre: None, .. }) && !insn.fp_lr() {
            fwd.push(alloc::vec![NOP]);
            insn = next()?;
        }
    }
    match insn {
        Insn::StoreSp { pre: Some(16), .. } if insn.fp_lr() => {
            fwd.push(alloc::vec![0x81]);
            let Insn::AddFp(0) = next()? else {
                return None;
            };
            fwd.push(alloc::vec![0xE1]);
        }
        Insn::StoreSp {
            pre: Some(n),
            fp,
            rt,
            rt2,
            ..
        } => {
            fwd.push(save(fp, rt, rt2, Some(n), 0)?);
            let k = loop {
                match next()? {
                    i @ Insn::StoreSp { pre: None, off, .. } if i.fp_lr() && off <= 504 => {
                        break off;
                    }
                    Insn::StoreSp {
                        pre: None,
                        fp,
                        rt,
                        rt2,
                        off,
                    } => fwd.push(save(fp, rt, rt2, None, off)?),
                    _ => return None,
                }
            };
            fwd.push(alloc::vec![0x40 | (k / 8) as u8]);
            if !matches!(next()?, Insn::AddFp(f) if f == k) {
                return None;
            }
            fwd.push(alloc::vec![0xE2, (k / 8) as u8]);
        }
        _ => return None,
    }
    Some(fwd.into_iter().rev().flatten().collect())
}

/// The `.xdata` record, with no handler or epilog scope, of a function of `len`
/// bytes whose prologue takes `codes`; `None` past the 18-bit length.
pub(crate) fn xdata(len: u32, codes: &[u8]) -> Option<Vec<u8>> {
    let words = len / 4;
    if words >= 1 << 18 {
        return None;
    }
    let mut body = codes.to_vec();
    body.push(END);
    while !body.len().is_multiple_of(4) {
        body.push(END);
    }
    let code_words = (body.len() / 4) as u32;
    if code_words > 0xFF {
        return None;
    }
    let mut out = Vec::with_capacity(8 + body.len());
    if code_words < 32 {
        out.extend_from_slice(&(words | (code_words << 27)).to_le_bytes());
    } else {
        // Code Words and Epilog Count both zero select the extension word.
        out.extend_from_slice(&words.to_le_bytes());
        out.extend_from_slice(&((code_words & 0xFF) << 16).to_le_bytes());
    }
    out.extend_from_slice(&body);
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::{prologue_codes, xdata};

    fn words(ws: &[u32]) -> Vec<u8> {
        ws.iter().flat_map(|w| w.to_le_bytes()).collect()
    }

    /// Both frame shapes, a variadic area behind `paciasp`, a frameless body.
    #[test]
    fn each_prologue_shape_takes_its_codes() {
        // stp x29, x30, [sp, #-16]!; mov x29, sp; sub sp, sp, #16
        let t = words(&[0xA9BF_7BFD, 0x9100_03FD, 0xD100_43FF]);
        assert_eq!(prologue_codes(&t, 0, 12), Some(alloc::vec![0xE1, 0x81]));
        // str x20, [sp, #-0x60]!; stp x29, x30, [sp, #0x50]; add x29, sp, #0x50
        let t = words(&[0xF81A_0FF4, 0xA905_7BFD, 0x9101_43FD]);
        assert_eq!(
            prologue_codes(&t, 0, 12),
            Some(alloc::vec![0xE2, 10, 0x4A, 0xD4, 0x2B])
        );
        // paciasp; sub sp, sp, #64; str x0, [sp]; str x1, [sp, #8]; the frame
        let t = words(&[
            0xD503_233F,
            0xD101_03FF,
            0xF900_03E0,
            0xF900_07E1,
            0xA9BF_7BFD,
            0x9100_03FD,
        ]);
        let codes = alloc::vec![0xE1, 0x81, 0xE3, 0xE3, 0x04, 0xFC];
        assert_eq!(prologue_codes(&t, 0, 24), Some(codes));
        assert_eq!(
            prologue_codes(&words(&[0x9100_0400, 0xD65F_03C0]), 0, 8),
            None
        );
        assert_eq!(
            xdata(0x40, &[0xE1, 0x81]).unwrap(),
            [0x10, 0, 0, 0x08, 0xE1, 0x81, 0xE4, 0xE4]
        );
    }

    /// `bti c` and the patchable-entry NOPs ahead of the frame take a `nop`
    /// code each, as clang's `.seh_nop`, before or without `pac_sign_lr`.
    #[test]
    fn landing_pad_and_entry_nops_take_nop_codes() {
        let frame = [0xA9BF_7BFD, 0x9100_03FD];
        // bti c; the frame
        let t = words(&[&[0xD503_245F][..], &frame].concat());
        assert_eq!(
            prologue_codes(&t, 0, 12),
            Some(alloc::vec![0xE1, 0x81, 0xE3])
        );
        // bti c; nop; nop; paciasp; the frame
        let entry = [0xD503_245F, 0xD503_201F, 0xD503_201F, 0xD503_233F];
        let t = words(&[&entry[..], &frame].concat());
        let codes = alloc::vec![0xE1, 0x81, 0xFC, 0xE3, 0xE3, 0xE3];
        assert_eq!(prologue_codes(&t, 0, 24), Some(codes));
        // A frameless body behind the pad has no prolog; a signed one's
        // ends at `paciasp`, as clang's `-mbranch-protection=pac-ret+leaf`.
        let t = words(&[0xD503_245F, 0xD503_233F, 0x9100_0400, 0xD65F_03C0]);
        assert_eq!(prologue_codes(&t, 0, 4), None);
        assert_eq!(prologue_codes(&t, 0, 8), Some(alloc::vec![0xFC, 0xE3]));
        assert_eq!(prologue_codes(&t, 4, 8), Some(alloc::vec![0xFC]));
    }

    /// Each callee save before `add x29` takes its `save_*` code.
    #[test]
    fn every_callee_save_takes_its_code() {
        // stp d8, d9, [sp, #-0x70]!; stp d10, d11, [sp, #0x10];
        // str d12, [sp, #0x20]; stp x19, x20, [sp, #0x30];
        // str x21, [sp, #0x40]; stp x29, x30, [sp, #0x60]; add x29, sp, #0x60
        let t = words(&[
            0x6DB9_27E8,
            0x6D01_2FEA,
            0xFD00_13EC,
            0xA903_53F3,
            0xF900_23F5,
            0xA906_7BFD,
            0x9101_83FD,
        ]);
        let codes = [
            0xE2, 12, 0x4C, 0xD0, 0x88, 0xC8, 0x06, 0xDD, 0x04, 0xD8, 0x82, 0xDA, 0x0D,
        ];
        assert_eq!(prologue_codes(&t, 0, 28).as_deref(), Some(&codes[..]));
        // The single and pair pre-indexed forms: str d8, [sp, #-0x20]! and
        // stp x19, x20, [sp, #-0x20]!, then stp x29, x30, [sp, #0x10];
        // add x29, sp, #0x10.
        for (first, code) in [(0xFC1E_0FE8, [0xDE, 0x03]), (0xA9BE_53F3, [0xCC, 0x03])] {
            let t = words(&[first, 0xA901_7BFD, 0x9100_43FD]);
            let want = [0xE2, 2, 0x42, code[0], code[1]];
            assert_eq!(prologue_codes(&t, 0, 12).as_deref(), Some(&want[..]));
        }
        // No code names the pair x20, x22.
        let t = words(&[0xA9BE_53F3, 0xA901_5BF4, 0xA902_7BFD, 0x9100_83FD]);
        assert_eq!(prologue_codes(&t, 0, 16), None);
    }
}
