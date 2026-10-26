//! The ARM64 unwind codes and `.xdata` record of a badc function's prologue
//! (Microsoft, "ARM64 exception handling"). After an optional `paciasp` and a
//! Windows variadic callee's register area, a frame is `stp x29, x30, [sp,
//! #-16]!; mov x29, sp`, or a callee save pre-indexing it, the other saves
//! (`nop`s), then `stp x29, x30, [sp, #k]; add x29, sp, #k`. The prolog ends
//! where x29 is set: `set_fp` / `add_fp` recover sp from it, so what the body
//! allocates and saves after is undescribed. TODO: epilog scopes.

use alloc::vec::Vec;

const NOP: u8 = 0xE3;
pub(crate) const END: u8 = 0xE4;

/// One prologue instruction, as the unwinder sees it.
enum Insn {
    Pac,
    SubSp(u32),
    /// A store with sp as its base: `pre` holds a pre-index's allocation.
    StoreSp {
        pre: Option<u32>,
        fp_lr: bool,
        off: u32,
    },
    /// `add x29, sp, #n`.
    AddFp(u32),
    Other,
}

fn classify(w: u32) -> Insn {
    let (rt, rn, rt2) = (w & 31, (w >> 5) & 31, (w >> 10) & 31);
    let simm =
        |v: u32, bits: u32, scale: i64| ((i64::from(v) << (64 - bits)) >> (64 - bits)) * scale;
    let store = |pre: bool, off: i64, fp_lr: bool| match (pre, off) {
        (true, o) if o < 0 => Insn::StoreSp {
            pre: Some(-o as u32),
            fp_lr,
            off: 0,
        },
        (false, o) if o >= 0 => Insn::StoreSp {
            pre: None,
            fp_lr,
            off: o as u32,
        },
        _ => Insn::Other,
    };
    if w == 0xD503_233F {
        return Insn::Pac;
    }
    if rn != 31 {
        return Insn::Other;
    }
    match w & 0xFFC0_0000 {
        // STP Xt, Xt2 / Dt, Dt2: pre-indexed, then signed offset.
        0xA980_0000 | 0x6D80_0000 => {
            let fp_lr = w & 0xFFC0_0000 == 0xA980_0000 && rt == 29 && rt2 == 30;
            return store(true, simm((w >> 15) & 0x7F, 7, 8), fp_lr);
        }
        0xA900_0000 | 0x6D00_0000 => {
            let fp_lr = w & 0xFFC0_0000 == 0xA900_0000 && rt == 29 && rt2 == 30;
            return store(false, simm((w >> 15) & 0x7F, 7, 8), fp_lr);
        }
        // STR Xt / Dt, unsigned scaled offset.
        0xF900_0000 | 0xFD00_0000 => return store(false, i64::from((w >> 10) & 0xFFF) * 8, false),
        _ => {}
    }
    // STR Xt / Dt, pre-indexed.
    if matches!(w & 0xFFE0_0C00, 0xF800_0C00 | 0xFC00_0C00) {
        return store(true, simm((w >> 12) & 0x1FF, 9, 1), false);
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

/// The unwind codes of the prologue at `start` in `text` before `limit`, last
/// first and `end` excluded; `None` for a frameless function or another shape.
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
    if let Insn::Pac = insn {
        fwd.push(alloc::vec![0xFC]);
        insn = next()?;
    }
    if let Insn::SubSp(n) = insn {
        fwd.push(alloc(n)?);
        insn = next()?;
        while let Insn::StoreSp {
            pre: None,
            fp_lr: false,
            ..
        } = insn
        {
            fwd.push(alloc::vec![NOP]);
            insn = next()?;
        }
    }
    match insn {
        Insn::StoreSp {
            pre: Some(16),
            fp_lr: true,
            ..
        } => {
            fwd.push(alloc::vec![0x81]);
            let Insn::AddFp(0) = next()? else {
                return None;
            };
            fwd.push(alloc::vec![0xE1]);
        }
        Insn::StoreSp {
            pre: Some(n),
            fp_lr: false,
            ..
        } => {
            fwd.push(alloc(n)?);
            let k = loop {
                match next()? {
                    Insn::StoreSp {
                        pre: None,
                        fp_lr: false,
                        ..
                    } => fwd.push(alloc::vec![NOP]),
                    Insn::StoreSp {
                        pre: None,
                        fp_lr: true,
                        off,
                    } if off <= 504 => break off,
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
            Some(alloc::vec![0xE2, 10, 0x4A, 0x06])
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
}
