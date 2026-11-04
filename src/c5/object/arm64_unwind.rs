//! The ARM64 unwind codes and `.xdata` record of a badc function's prologue
//! and epilogues (Microsoft, "ARM64 exception handling"), from the steps the
//! emitter records ([`A64Step`]). After the `bti c` landing pad and the
//! `-fpatchable-function-entry` NOPs, each taking a `nop` code, an optional
//! `paciasp` (all of a signed leaf's prolog) and a Windows variadic callee's
//! register area, a frame is `stp x29, x30, [sp, #-16]!; mov x29, sp`, or a
//! callee save pre-indexing it, the other saves, then `stp x29, x30, [sp,
//! #k]; add x29, sp, #k`. The prolog ends where x29 is set: `set_fp` /
//! `add_fp` recover sp from it, so what the body allocates after is
//! undescribed. An epilog takes sp back from x29 and reverses the prolog
//! from there, each instruction the code of the one it reverses. The tests
//! read the same codes back from the emitted instructions.

use crate::c5::codegen::A64Step;
#[cfg(test)]
use crate::c5::codegen::aarch64::encode::{AUTIASP, BTI_C, NOP as NOP_INSN, PACIASP};
use alloc::vec::Vec;

const NOP: u8 = 0xE3;
pub(crate) const END: u8 = 0xE4;

/// The unwind codes of a prologue of `steps`, last first and `end`
/// excluded; `None` for a step no code describes.
#[cfg(test)]
pub(crate) fn codes(steps: &[A64Step]) -> Option<Vec<u8>> {
    Some(step_codes(steps)?.into_iter().rev().flatten().collect())
}

/// Each step's unwind code, in the order of `steps`; `None` for a step no
/// code describes.
pub(crate) fn step_codes(steps: &[A64Step]) -> Option<Vec<Vec<u8>>> {
    let scaled = |n: u32, max: u32| (n.is_multiple_of(8) && n / 8 <= max).then_some((n / 8) as u8);
    let mut fwd: Vec<Vec<u8>> = Vec::with_capacity(steps.len());
    for &step in steps {
        fwd.push(match step {
            A64Step::Nop => alloc::vec![NOP],
            A64Step::PacSignLr => alloc::vec![0xFC],
            A64Step::Alloc(n) => alloc(n)?,
            A64Step::SaveFpLrX(n) => alloc::vec![0x80 | scaled(n, 64)?.checked_sub(1)?],
            A64Step::SetFp => alloc::vec![0xE1],
            A64Step::SaveReg {
                fp,
                reg,
                reg2,
                pre,
                bytes,
            } if pre => save(fp, reg, reg2, Some(bytes), 0)?,
            A64Step::SaveReg {
                fp,
                reg,
                reg2,
                bytes,
                ..
            } => save(fp, reg, reg2, None, bytes)?,
            A64Step::SaveFpLr(off) => alloc::vec![0x40 | scaled(off, 63)?],
            A64Step::AddFp(off) => alloc::vec![0xE2, scaled(off, 255)?],
        });
    }
    Some(fwd)
}

/// One prologue instruction, as the unwinder sees it.
#[cfg(test)]
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

#[cfg(test)]
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

#[cfg(test)]
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
    // `save_r19r20_x`, which the LLVM assembler takes for the pair it fits.
    if !fp && pair && x == 0 && pre.is_some() && bytes / 8 < 32 {
        return Some(alloc::vec![0x20 | (bytes / 8) as u8]);
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
/// first and `end` excluded, read from the instructions; `None` for an
/// unsigned frameless function or another shape. The tests check [`codes`]
/// against it.
#[cfg(test)]
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

/// The unwind codes of the epilog at `start` in `text`, in execution order
/// and `end` excluded, read from the instructions, and the offset of its
/// `ret`; `None` for another shape. The writes of sp ahead of the frame
/// record's load leave it at x29 less the load's offset once the last
/// completes, so they take `nop` codes and the last `set_fp` / `add_fp`.
/// The tests check [`step_codes`] against it.
#[cfg(test)]
pub(crate) fn epilogue_codes(text: &[u8], start: u32) -> Option<(Vec<u8>, u32)> {
    let word = |at: u32| -> Option<u32> {
        let b = text.get(at as usize..at as usize + 4)?;
        Some(u32::from_le_bytes(b.try_into().ok()?))
    };
    let simm = |v: u32, bits: u32| ((v << (32 - bits)) as i32) >> (32 - bits);
    let mut at = start;
    let mut writes = 0usize;
    loop {
        let w = word(at)?;
        // add / sub (immediate) to sp, mov{n,z,k} x16, add sp, sp, x16.
        let sets_sp = w & 0xBF80_001F == 0x9100_001F || w == 0x8B30_63FF;
        if !(sets_sp || w & 0x9F80_001F == 0x9280_0010) {
            break;
        }
        writes += 1;
        at += 4;
    }
    let mut out: Vec<u8> = alloc::vec![NOP; writes.saturating_sub(1)];
    let record = word(at)?;
    let off = simm((record >> 15) & 0x7F, 7) * 8;
    match record & 0xFFC0_7FFF {
        0xA940_7BFD if off >= 0 => {
            if writes > 0 {
                out.extend([0xE2, (off / 8) as u8]);
            }
            out.push(0x40 | (off / 8) as u8);
            at += 4;
        }
        0xA8C0_7BFD if off > 0 => {
            if writes > 0 {
                out.push(0xE1);
            }
            out.push(0x80 | (off / 8 - 1) as u8);
            at += 4;
        }
        // A signed leaf's `autiasp`.
        _ if writes == 0 => {}
        _ => return None,
    }
    loop {
        let w = word(at)?;
        let (rt, rn, rt2) = ((w & 31) as u8, (w >> 5) & 31, ((w >> 10) & 31) as u8);
        let fp = w & (1 << 26) != 0;
        let pair = u32::try_from(simm((w >> 15) & 0x7F, 7) * 8).ok();
        let code = match w {
            0xD65F_03C0 => return Some((out, at)),
            AUTIASP => alloc::vec![0xFC],
            _ if w & 0xFF80_03FF == 0x9100_03FF => {
                alloc(((w >> 10) & 0xFFF) << (12 * ((w >> 22) & 1)))?
            }
            _ if rn != 31 => return None,
            _ => match w & 0xFFC0_0000 {
                // LDP Xt, Xt2 / Dt, Dt2: signed offset, then post-indexed.
                0xA940_0000 | 0x6D40_0000 => save(fp, rt, Some(rt2), None, pair?)?,
                0xA8C0_0000 | 0x6CC0_0000 => save(fp, rt, Some(rt2), Some(pair?), 0)?,
                // LDR Xt / Dt, unsigned scaled offset.
                0xF940_0000 | 0xFD40_0000 => save(fp, rt, None, None, ((w >> 10) & 0xFFF) * 8)?,
                // LDR Xt / Dt, post-indexed.
                _ if matches!(w & 0xFFE0_0C00, 0xF840_0400 | 0xFC40_0400) => {
                    let n = u32::try_from(simm((w >> 12) & 0x1FF, 9)).ok()?;
                    save(fp, rt, None, Some(n), 0)?
                }
                _ => return None,
            },
        };
        out.extend(code);
        at += 4;
    }
}

/// The `.xdata` record, with no handler, of a function of `len` bytes whose
/// prolog takes `prolog`, each step's code in execution order, and whose
/// exits are `exits`, each an epilog's byte offset and its codes in the same
/// order; `None` past the format's fields.
///
/// The codes run last prolog step first, then `end`, then each epilog's
/// codes and `end`, padded with `nop`. An epilog takes the codes of the
/// prolog it reverses from some step on, or those of an earlier epilog it
/// repeats; a single epilog ending the function goes in the header (the E
/// bit) where its index fits without the extension word, as the LLVM
/// assembler and cl encode them.
pub(crate) fn xdata(
    len: u32,
    prolog: &[Vec<u8>],
    exits: &[(u32, Vec<Vec<u8>>)],
) -> Option<Vec<u8>> {
    let words = len / 4;
    if words >= 1 << 18 {
        return None;
    }
    let unwind: Vec<&Vec<u8>> = prolog.iter().rev().collect();
    let mut pool: Vec<u8> = unwind.iter().copied().flatten().copied().collect();
    pool.push(END);
    let mut appended: Vec<(&[Vec<u8>], usize)> = Vec::new();
    let mut scopes: Vec<(u32, usize)> = Vec::with_capacity(exits.len());
    for (at, epilog) in exits {
        let from = unwind.len().checked_sub(epilog.len());
        let mirrors = |&f: &usize| unwind[f..].iter().copied().eq(epilog.iter());
        let index = if let Some(from) = from.filter(mirrors) {
            unwind[..from].iter().map(|c| c.len()).sum()
        } else if let Some(&(_, i)) = appended.iter().find(|(e, _)| *e == &epilog[..]) {
            i
        } else {
            let i = pool.len();
            appended.push((epilog, i));
            pool.extend(epilog.iter().flatten());
            pool.push(END);
            i
        };
        scopes.push((at / 4, index));
    }
    while !pool.len().is_multiple_of(4) {
        pool.push(NOP);
    }
    let code_words = (pool.len() / 4) as u32;
    if code_words > 0xFF || scopes.len() > 0xFFFF || scopes.iter().any(|s| s.1 >= 1 << 10) {
        return None;
    }
    let packed = match (exits, &scopes[..]) {
        ([(at, epilog)], [(_, index)]) => {
            at + 4 * (epilog.len() as u32 + 1) == len && *index < 32 && code_words < 32
        }
        _ => false,
    };
    let mut out = Vec::with_capacity(8 + 4 * scopes.len() + pool.len());
    if packed {
        let index = scopes[0].1 as u32;
        out.extend_from_slice(&(words | 1 << 21 | index << 22 | code_words << 27).to_le_bytes());
    } else if scopes.len() < 32 && code_words < 32 {
        let count = scopes.len() as u32;
        out.extend_from_slice(&(words | count << 22 | code_words << 27).to_le_bytes());
    } else {
        // Code Words and Epilog Count both zero select the extension word.
        out.extend_from_slice(&words.to_le_bytes());
        out.extend_from_slice(&(scopes.len() as u32 | code_words << 16).to_le_bytes());
    }
    if !packed {
        for &(at, index) in &scopes {
            out.extend_from_slice(&(at | (index as u32) << 22).to_le_bytes());
        }
    }
    out.extend_from_slice(&pool);
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::{epilogue_codes, prologue_codes, xdata};

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
        let frame = [alloc::vec![0x81], alloc::vec![0xE1]];
        assert_eq!(
            xdata(0x40, &frame, &[]).unwrap(),
            [0x10, 0, 0, 0x08, 0xE1, 0x81, 0xE4, 0xE3]
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
        // The single and pair pre-indexed forms: str d8, [sp, #-0x20]!,
        // stp x21, x22, [sp, #-0x20]! and stp x19, x20, [sp, #-0x20]!
        // (`save_r19r20_x`), then stp x29, x30, [sp, #0x10]; add x29, sp,
        // #0x10.
        let pre: [(u32, &[u8]); 3] = [
            (0xFC1E_0FE8, &[0xDE, 0x03]),
            (0xA9BE_5BF5, &[0xCC, 0x83]),
            (0xA9BE_53F3, &[0x24]),
        ];
        for (first, code) in pre {
            let t = words(&[first, 0xA901_7BFD, 0x9100_43FD]);
            let want = [&[0xE2, 2, 0x42][..], code].concat();
            assert_eq!(prologue_codes(&t, 0, 12), Some(want));
        }
        // No code names the pair x20, x22.
        let t = words(&[0xA9BE_53F3, 0xA901_5BF4, 0xA902_7BFD, 0x9100_83FD]);
        assert_eq!(prologue_codes(&t, 0, 16), None);
    }

    /// Each epilogue shape reads back as the codes of the prologue
    /// instructions it reverses, in its own order, up to its `ret`.
    #[test]
    fn each_epilogue_shape_takes_its_codes() {
        let ret = 0xD65F_03C0;
        let shapes: [(&[u32], &[u8]); 5] = [
            // ldp x29, x30, [sp, #16]; ldp x19, x20, [sp], #32
            (&[0xA941_7BFD, 0xA8C2_53F3], &[0x42, 0x24]),
            // sub sp, x29, #16, then the same
            (
                &[0xD100_43BF, 0xA941_7BFD, 0xA8C2_53F3],
                &[0xE2, 2, 0x42, 0x24],
            ),
            // add sp, sp, #1, lsl #12; add sp, sp, #0x170;
            // ldp x29, x30, [sp], #16; add sp, sp, #64; autiasp
            (
                &[
                    0x9140_07FF,
                    0x9105_C3FF,
                    0xA8C1_7BFD,
                    0x9101_03FF,
                    0xD503_23BF,
                ],
                &[0xE3, 0xE1, 0x81, 0x04, 0xFC],
            ),
            // mov sp, x29; ldp x29, x30, [sp], #16
            (&[0x9100_03BF, 0xA8C1_7BFD], &[0xE1, 0x81]),
            // ldp x29, x30, [sp, #32]; ldr x19, [sp, #16]; ldp d8, d9, [sp], #48
            (
                &[0xA942_7BFD, 0xF940_0BF3, 0x6CC3_27E8],
                &[0x44, 0xD0, 0x02, 0xDA, 0x05],
            ),
        ];
        for (insns, codes) in shapes {
            let t = words(&[insns, &[ret]].concat());
            let at = 4 * insns.len() as u32;
            assert_eq!(epilogue_codes(&t, 0), Some((codes.to_vec(), at)));
        }
        assert_eq!(epilogue_codes(&words(&[0x9100_0400, ret]), 0), None);
        let signed_leaf = words(&[0xD503_23BF, ret]);
        assert_eq!(
            epilogue_codes(&signed_leaf, 0),
            Some((alloc::vec![0xFC], 4))
        );
    }

    /// The records of the shapes badc emits, byte for byte as the LLVM
    /// assembler encodes them from the same SEH directives: one exit ending
    /// the function goes in the header, at the index where the prolog's
    /// codes reverse it or after them; several, or one that code follows,
    /// take the scope list and share the prolog's codes or the first exit's.
    #[test]
    fn epilog_records_follow_the_llvm_assembler() {
        use crate::c5::codegen::A64Step as S;
        let pair = S::SaveReg {
            fp: false,
            reg: 19,
            reg2: Some(20),
            pre: true,
            bytes: 32,
        };
        let fold: &[S] = &[pair, S::SaveFpLr(16), S::AddFp(16)];
        let fold_exit: &[S] = &[S::SaveFpLr(16), pair];
        let top_exit: &[S] = &[S::AddFp(16), S::SaveFpLr(16), pair];
        let va2: &[S] = &[S::Alloc(64), S::Nop, S::Nop, S::SaveFpLrX(16), S::SetFp];
        let va1: &[S] = &[S::Alloc(64), S::Nop, S::SaveFpLrX(16), S::SetFp];
        let va_exit: &[S] = &[S::SaveFpLrX(16), S::Alloc(64)];
        let frame: &[S] = &[S::SaveFpLrX(16), S::SetFp];
        let bti: &[S] = &[S::Nop, S::SaveFpLrX(16), S::SetFp];
        let record_exit: &[S] = &[S::SaveFpLrX(16)];
        let shared: &[u8] = &[0xE2, 0x02, 0x42, 0x24, 0xE4, 0xE3, 0xE3, 0xE3];
        type Case<'a> = (u32, &'a [S], &'a [(u32, &'a [S])], &'a [&'a [u8]]);
        let cases: [Case; 8] = [
            (
                28,
                fold,
                &[(16, fold_exit)],
                &[&[0x07, 0x00, 0xA0, 0x10], shared],
            ),
            (
                36,
                fold,
                &[(20, top_exit)],
                &[&[0x09, 0x00, 0x20, 0x10], shared],
            ),
            (
                64,
                fold,
                &[(24, top_exit), (48, top_exit)],
                &[&[0x10, 0, 0x80, 0x10, 6, 0, 0, 0, 12, 0, 0, 0], shared],
            ),
            (
                48,
                fold,
                &[(20, fold_exit), (36, fold_exit)],
                &[&[0x0C, 0, 0x80, 0x10, 5, 0, 0x80, 0, 9, 0, 0x80, 0], shared],
            ),
            (
                56,
                va2,
                &[(28, va_exit), (44, va_exit)],
                &[
                    &[0x0E, 0, 0x80, 0x18, 7, 0, 0x80, 1, 11, 0, 0x80, 1],
                    &[
                        0xE1, 0x81, 0xE3, 0xE3, 0x04, 0xE4, 0x81, 0x04, 0xE4, 0xE3, 0xE3, 0xE3,
                    ],
                ],
            ),
            (
                32,
                va1,
                &[(20, va_exit)],
                &[&[
                    8, 0, 0x60, 0x11, 0xE1, 0x81, 0xE3, 0x04, 0xE4, 0x81, 0x04, 0xE4,
                ]],
            ),
            (
                28,
                frame,
                &[(12, record_exit)],
                &[&[7, 0, 0x40, 0x08, 3, 0, 0x40, 0, 0xE1, 0x81, 0xE4, 0xE3]],
            ),
            (
                24,
                bti,
                &[(16, record_exit)],
                &[&[
                    6, 0, 0x20, 0x11, 0xE1, 0x81, 0xE3, 0xE4, 0x81, 0xE4, 0xE3, 0xE3,
                ]],
            ),
        ];
        let codes = |s: &[S]| super::step_codes(s).expect("codes");
        for (len, prolog, exits, want) in cases {
            let exits: Vec<_> = exits.iter().map(|&(at, s)| (at, codes(s))).collect();
            let got = xdata(len, &codes(prolog), &exits);
            assert_eq!(got, Some(want.concat()), "{len:#x}: {prolog:?} {exits:x?}");
        }
    }

    /// Past 31 exits the counts move to the extension word, and an index
    /// past the header's five bits keeps a single final exit in the list.
    #[test]
    fn counts_past_the_header_fields_take_the_extension_word() {
        use crate::c5::codegen::A64Step as S;
        let codes = |s: &[S]| super::step_codes(s).expect("codes");
        let frame = codes(&[S::SaveFpLrX(16), S::SetFp]);
        let word = |x: &[u8], i: usize| u32::from_le_bytes(x[4 * i..4 * i + 4].try_into().unwrap());
        let exit = codes(&[S::SetFp, S::SaveFpLrX(16)]);
        let exits: Vec<_> = (0..33u32).map(|i| (16 + 8 * i, exit.clone())).collect();
        let x = xdata(0x200, &frame, &exits).expect("record");
        assert_eq!((word(&x, 0), word(&x, 1)), (0x80, 33 | 1 << 16));
        assert!((0..33).all(|i| word(&x, 2 + i as usize) == (4 + 2 * i)));
        assert_eq!(x[4 * 35..], [0xE1, 0x81, 0xE4, 0xE3]);
        // Forty entry NOPs put the exit's own codes at index 43.
        let nops = codes(&[[S::Nop; 40].as_slice(), &[S::SaveFpLrX(16), S::SetFp]].concat());
        let x = xdata(0x100, &nops, &[(0xF8, codes(&[S::SaveFpLrX(16)]))]).expect("record");
        assert_eq!(word(&x, 0), 0x40 | 1 << 22 | 12 << 27);
        assert_eq!(word(&x, 1), 62 | 43 << 22);
    }
}
