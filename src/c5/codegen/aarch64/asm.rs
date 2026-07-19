//! GCC extended inline-asm (AArch64): ARM-syntax template parsing and operand
//! assignment.
//!
//! [`parse_template`] turns a template into a sequence of [`AsmInsnA64`]s with
//! symbolic operand references (`%N` / `%wN` / `%xN`), explicit registers
//! (`x5`, `w5`, `sp`, `xzr`), and immediates (`#imm`). The emitter
//! ([`super::emit`]) assigns a machine register to each register operand per
//! [`assign_operand_regs`], resolves each reference, and encodes the
//! register-concrete instruction through the table encoder
//! ([`super::table`]). Raw-byte pieces (a `.byte` directive or a hex-byte run)
//! ride the same stream so a template may mix them with mnemonics.
//!
//! The VM does not interpret this path (its inline-asm evaluator is x86-only),
//! so AArch64 mnemonic inline asm is native-only.

#![allow(dead_code)]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::ssa::emit_common;

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmOpndA64 {
    /// `%N` / `%wN` / `%xN`: operand N of the statement, at the register width
    /// named by the modifier (or the operand's own width when unmodified).
    Ref { idx: u8, is64: Option<bool> },
    /// An explicit register: `x5` / `w5` / `sp` / `xzr` (`num == 31` is the
    /// zero register or SP, per the instruction).
    Reg { num: u8, is64: bool },
    /// A SIMD/FP register: `d5` (64-bit) or `s5` (32-bit). `is_d` selects the
    /// double vs single view; the register file is separate from the GP one.
    VReg { num: u8, is_d: bool },
    /// The 128-bit `q5` view of a SIMD register, used by the vector load/store
    /// forms (`ldr`/`str qN`).
    QReg(u8),
    /// A byte/half scalar-SIMD view `b5`/`h5` (`size` 0 or 1); `s`/`d` views are
    /// `VReg`. These name the scalar destination of the across-lane reductions.
    VScalar { num: u8, size: u8 },
    /// A SIMD vector-arrangement register view `v5.4s`: `size` is the element
    /// size log2 (byte 0, half 1, word 2, dword 3), `q` selects the 128- vs
    /// 64-bit register (16 vs 8 bytes).
    VecReg { num: u8, size: u8, q: bool },
    /// A single SIMD element `v5.s[3]`: `size` is the element-size log2, `index`
    /// the lane. Used by the lane-transfer forms (umov/smov/ins).
    VecElem { num: u8, size: u8, index: u8 },
    /// A SIMD register list `{v0.T, ..}` of `count` consecutive registers (1..4)
    /// starting at `first`, all of one arrangement. Used by ld1..ld4/st1..st4.
    VecList {
        first: u8,
        count: u8,
        size: u8,
        q: bool,
    },
    /// A literal immediate `#imm`.
    Imm(i64),
    /// A floating-point immediate `#1.5`, resolved at parse time to its 8-bit
    /// VFP encoding (`fmov Vd, #imm`).
    FpImm(u8),
    /// A `lsl #n` shift modifier (move-wide).
    Lsl(u32),
    /// A system register named in a `mrs` / `msr`, resolved to its 15-bit field.
    SysReg(u16),
    /// A `dc` / `ic` / `tlbi` system operation, resolved to its base word
    /// (`0xD5080000 | op1<<16 | CRn<<12 | CRm<<8 | op2<<5`, Rt absent). The
    /// encoder folds in the register operand (or xzr when there is none).
    SysOp(u32),
    /// A memory reference `[base, #off]` (the `off` defaults to 0). The base is
    /// an operand reference or an explicit register. `pre` marks the
    /// pre-index writeback form `[base, #off]!`; post-index (`[base], #off`)
    /// is the separate trailing-immediate operand shape the encoder folds in.
    Mem { base: MemBase, off: i64, pre: bool },
    /// A register-offset memory reference `[base, index, <ext> {#shift}]`. The
    /// `option` is the resolved 3-bit extend selector; `shift` is the written
    /// scale amount, checked against the access size by the encoder.
    MemReg {
        base: MemBase,
        index: MemBase,
        option: u8,
        shift: Option<u8>,
    },
    /// A condition code (`eq`, `ne`, ...) as its 4-bit encoding, for the
    /// conditional-select forms.
    Cond(u8),
    /// A local-label reference `Nb` / `Nf`: label number plus direction
    /// (`forward` selects the next definition after the branch, otherwise the
    /// most recent one at or before it).
    Label { num: u32, forward: bool },
}

/// The base register of a memory operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum MemBase {
    Ref(u8),
    Reg(u8),
}

/// The 15-bit `mrs`/`msr` system-register field for a name, or the generic
/// `s<op0>_<op1>_c<CRn>_c<CRm>_<op2>` spelling that names any register.
/// `field = (op0-2)<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`.
fn sysreg_field(name: &str) -> Option<u16> {
    fn pack(op0: u16, op1: u16, crn: u16, crm: u16, op2: u16) -> u16 {
        ((op0 - 2) << 14) | (op1 << 11) | (crn << 7) | (crm << 3) | op2
    }
    // Register names are case-insensitive in the architecture; normalize before
    // matching either the named table or the generic spelling.
    let name = name.to_ascii_lowercase();
    let name = name.as_str();
    // Common registers by name; extend as needed.
    let named = |n: &str| -> Option<(u16, u16, u16, u16, u16)> {
        Some(match n {
            "midr_el1" => (3, 0, 0, 0, 0),
            "mpidr_el1" => (3, 0, 0, 0, 5),
            "id_aa64isar0_el1" => (3, 0, 0, 6, 0),
            "ctr_el0" => (3, 3, 0, 0, 1),
            "dczid_el0" => (3, 3, 0, 0, 7),
            "fpcr" => (3, 3, 4, 4, 0),
            "fpsr" => (3, 3, 4, 4, 1),
            "tcr_el1" => (3, 0, 2, 0, 2),
            "ttbr0_el1" => (3, 0, 2, 0, 0),
            "ttbr1_el1" => (3, 0, 2, 0, 1),
            "mair_el1" => (3, 0, 10, 2, 0),
            "par_el1" => (3, 0, 7, 4, 0),
            "tpidr_el0" => (3, 3, 13, 0, 2),
            "tpidrro_el0" => (3, 3, 13, 0, 3),
            "tpidr_el1" => (3, 0, 13, 0, 4),
            "sctlr_el1" => (3, 0, 1, 0, 0),
            "vbar_el1" => (3, 0, 12, 0, 0),
            "daif" => (3, 3, 4, 2, 1),
            "nzcv" => (3, 3, 4, 2, 0),
            "cntfrq_el0" => (3, 3, 14, 0, 0),
            "cntpct_el0" => (3, 3, 14, 0, 1),
            "cntvct_el0" => (3, 3, 14, 0, 2),
            // Physical / virtual generic-timer control, timer-value, and
            // compare-value registers.
            "cntp_ctl_el0" => (3, 3, 14, 2, 1),
            "cntp_tval_el0" => (3, 3, 14, 2, 0),
            "cntp_cval_el0" => (3, 3, 14, 2, 2),
            "cntv_ctl_el0" => (3, 3, 14, 3, 1),
            "cntv_tval_el0" => (3, 3, 14, 3, 0),
            "cntv_cval_el0" => (3, 3, 14, 3, 2),
            "cntkctl_el1" => (3, 0, 14, 1, 0),
            "esr_el1" => (3, 0, 5, 2, 0),
            "far_el1" => (3, 0, 6, 0, 0),
            "elr_el1" => (3, 0, 4, 0, 1),
            "spsr_el1" => (3, 0, 4, 0, 0),
            "currentel" => (3, 0, 4, 2, 2),
            _ => return None,
        })
    };
    if let Some((op0, op1, crn, crm, op2)) = named(name) {
        return Some(pack(op0, op1, crn, crm, op2));
    }
    // Generic `sN_N_cN_cN_N` spelling.
    let p: Vec<&str> = name.split('_').collect();
    if p.len() == 5
        && let Some(op0) = p[0].strip_prefix('s').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op1) = p[1].parse::<u16>()
        && let Some(crn) = p[2].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Some(crm) = p[3].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op2) = p[4].parse::<u16>()
        && (2..=3).contains(&op0)
        && op1 <= 7
        && crn <= 15
        && crm <= 15
        && op2 <= 7
    {
        return Some(pack(op0, op1, crn, crm, op2));
    }
    None
}

/// The (op1, op2) selector of an MSR-immediate PSTATE field, or None if the
/// name is an ordinary system register. The immediate form is
/// `1101 0101 0000 0 op1 0100 CRm op2 11111` with CRm the 4-bit operand;
/// `daifset` / `daifclr` mask and unmask interrupts, the common handler idiom.
fn pstate_field(name: &str) -> Option<(u16, u16)> {
    Some(match name.to_ascii_lowercase().as_str() {
        "spsel" => (0, 5),
        "daifset" => (3, 6),
        "daifclr" => (3, 7),
        "uao" => (0, 3),
        "pan" => (0, 4),
        "dit" => (3, 2),
        "ssbs" => (3, 1),
        "tco" => (3, 4),
        "allint" => (1, 0),
        _ => return None,
    })
}

/// The base word of a `dc` / `ic` / `tlbi` system operation
/// (`0xD5080000 | op1<<16 | CRn<<12 | CRm<<8 | op2<<5`, no Rt), or None if the
/// mnemonic/op pair is not a known one. The (op1, CRn, CRm, op2) selectors are
/// the reference-assembler encodings.
fn sysop_base(mnem: &str, op: &str) -> Option<u32> {
    let (op1, crn, crm, op2): (u32, u32, u32, u32) = match (mnem, op.to_ascii_lowercase().as_str())
    {
        ("dc", "ivac") => (0, 7, 6, 1),
        ("dc", "isw") => (0, 7, 6, 2),
        ("dc", "csw") => (0, 7, 10, 2),
        ("dc", "cisw") => (0, 7, 14, 2),
        ("dc", "zva") => (3, 7, 4, 1),
        ("dc", "cvac") => (3, 7, 10, 1),
        ("dc", "cvau") => (3, 7, 11, 1),
        ("dc", "cvap") => (3, 7, 12, 1),
        ("dc", "civac") => (3, 7, 14, 1),
        ("ic", "ialluis") => (0, 7, 1, 0),
        ("ic", "iallu") => (0, 7, 5, 0),
        ("ic", "ivau") => (3, 7, 5, 1),
        ("tlbi", "vmalle1is") => (0, 8, 3, 0),
        ("tlbi", "vae1is") => (0, 8, 3, 1),
        ("tlbi", "aside1is") => (0, 8, 3, 2),
        ("tlbi", "vaae1is") => (0, 8, 3, 3),
        ("tlbi", "vale1is") => (0, 8, 3, 5),
        ("tlbi", "vaale1is") => (0, 8, 3, 7),
        ("tlbi", "vmalle1") => (0, 8, 7, 0),
        ("tlbi", "vae1") => (0, 8, 7, 1),
        ("tlbi", "aside1") => (0, 8, 7, 2),
        ("tlbi", "vaae1") => (0, 8, 7, 3),
        ("tlbi", "vale1") => (0, 8, 7, 5),
        ("tlbi", "vaale1") => (0, 8, 7, 7),
        ("tlbi", "alle1") => (4, 8, 7, 4),
        ("tlbi", "alle1is") => (4, 8, 3, 4),
        ("tlbi", "alle2") => (4, 8, 7, 0),
        ("tlbi", "alle3") => (6, 8, 7, 0),
        ("tlbi", "vae2") => (4, 8, 7, 1),
        ("tlbi", "vae3") => (6, 8, 7, 1),
        ("tlbi", "ipas2e1is") => (4, 8, 0, 1),
        ("tlbi", "vmalls12e1is") => (4, 8, 3, 6),
        _ => return None,
    };
    Some(0xD508_0000 | (op1 << 16) | (crn << 12) | (crm << 8) | (op2 << 5))
}

/// The 5-bit prefetch-operation code of a `prfm` op name
/// (`<pld|pli|pst><l1|l2|l3><keep|strm>` = type<<3 | target<<1 | policy), or
/// None if the name is not one.
fn prfop_code(name: &str) -> Option<u32> {
    let n = name.to_ascii_lowercase();
    if n.len() != 9 {
        return None;
    }
    let ty = match &n[0..3] {
        "pld" => 0u32,
        "pli" => 1,
        "pst" => 2,
        _ => return None,
    };
    let target = match &n[3..5] {
        "l1" => 0u32,
        "l2" => 1,
        "l3" => 2,
        _ => return None,
    };
    let policy = match &n[5..9] {
        "keep" => 0u32,
        "strm" => 1,
        _ => return None,
    };
    Some((ty << 3) | (target << 1) | policy)
}

/// One instruction of a parsed template.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsnA64 {
    /// Empty for a raw-byte piece (`bytes` carries the payload) and for a
    /// local-label definition (`label_def` carries the number).
    pub mnemonic: String,
    pub operands: Vec<AsmOpndA64>,
    /// Literal bytes for a raw-byte piece; empty for a mnemonic.
    pub bytes: Vec<u8>,
    /// A local-label definition `N:`; the emitter records the code offset it
    /// stands at.
    pub label_def: Option<u32>,
    /// For a direct `bl` / `b` to a bare identifier (`bl schedule`), the target
    /// symbol name; the emitter resolves it to a rel26 through the same fixup
    /// pass as a compiler-emitted call. `None` for every other instruction.
    pub sym_target: Option<String>,
}

/// A condition-code mnemonic to its 4-bit encoding.
pub(crate) fn cond_code(name: &str) -> Option<u8> {
    Some(match name {
        "eq" => 0,
        "ne" => 1,
        "cs" | "hs" => 2,
        "cc" | "lo" => 3,
        "mi" => 4,
        "pl" => 5,
        "vs" => 6,
        "vc" => 7,
        "hi" => 8,
        "ls" => 9,
        "ge" => 10,
        "lt" => 11,
        "gt" => 12,
        "le" => 13,
        "al" => 14,
        "nv" => 15,
        _ => return None,
    })
}

fn parse_reg(tok: &str) -> Option<(u8, bool)> {
    match tok {
        "sp" | "xzr" => return Some((31, true)),
        "wsp" | "wzr" => return Some((31, false)),
        _ => {}
    }
    let (is64, rest) = match tok.as_bytes().first()? {
        b'x' => (true, &tok[1..]),
        b'w' => (false, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 30).then_some((n, is64))
}

/// A SIMD/FP register: `d0`..`d31` (returns `is_d = true`) or `s0`..`s31`
/// (`is_d = false`). `sp`/`sN`-vs-`s` is disambiguated by the numeric parse.
fn parse_vreg(tok: &str) -> Option<(u8, bool)> {
    let (is_d, rest) = match tok.as_bytes().first()? {
        b'd' => (true, &tok[1..]),
        b's' => (false, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 31).then_some((n, is_d))
}

/// The 128-bit SIMD register `q0`..`q31`.
fn parse_qreg(tok: &str) -> Option<u8> {
    let n: u8 = tok.strip_prefix('q')?.parse().ok()?;
    (n <= 31).then_some(n)
}

/// A byte/half scalar-SIMD register `b0`..`b31` / `h0`..`h31` (the `s`/`d`
/// views are `VReg`). Returns the register number and the element-size log2.
fn parse_vscalar(tok: &str) -> Option<(u8, u8)> {
    let (size, rest) = match tok.as_bytes().first()? {
        b'b' => (0u8, &tok[1..]),
        b'h' => (1, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 31).then_some((n, size))
}

/// Parse a decimal floating-point immediate (e.g. `1.5`, `-2.0`) to its 8-bit
/// VFP encoding, or None if the value is not one of the representable
/// +/-(16+m)/16 * 2^e forms (m in 0..=15, e in -3..=4). Uses exact rational
/// arithmetic on the decimal (num/den, den a power of ten) to avoid rounding.
fn parse_fp_imm(s: &str) -> Option<u8> {
    let s = s.trim();
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s.strip_prefix('+').unwrap_or(s)),
    };
    let (int_part, frac_part) = s.split_once('.').unwrap_or((s, ""));
    if int_part.is_empty() && frac_part.is_empty() {
        return None;
    }
    let mut num: i64 = 0;
    for c in int_part.bytes().chain(frac_part.bytes()) {
        if !c.is_ascii_digit() {
            return None;
        }
        num = num.checked_mul(10)?.checked_add((c - b'0') as i64)?;
    }
    if num == 0 {
        return None; // 0.0 is not representable (its own fcmp marker elsewhere)
    }
    let mut den: i64 = 1;
    for _ in 0..frac_part.len() {
        den = den.checked_mul(10)?;
    }
    // value = num/den = (16+m) * 2^(e-4); for each e, num * 2^(4-e) must be a
    // multiple of den whose quotient is in 16..=31.
    for e in -3i32..=4 {
        let scaled = num.checked_mul(1i64 << (4 - e))?;
        if scaled % den != 0 {
            continue;
        }
        let q = scaled / den;
        if (16..=31).contains(&q) {
            let m = (q - 16) as u8;
            let exp3 = (if e <= 0 { 4u8 } else { 0 }) | (((e + 3) & 3) as u8);
            return Some((if neg { 0x80u8 } else { 0 }) | (exp3 << 4) | m);
        }
    }
    None
}

/// A SIMD vector-arrangement register `vN.T` (e.g. `v5.4s`): the register
/// number, the element-size log2, and the 128-bit flag.
fn parse_vec_reg(tok: &str) -> Option<(u8, u8, bool)> {
    let (num_s, arr) = tok.strip_prefix('v')?.split_once('.')?;
    let num: u8 = num_s.parse().ok()?;
    if num > 31 {
        return None;
    }
    let (size, q) = match arr {
        "8b" => (0, false),
        "16b" => (0, true),
        "4h" => (1, false),
        "8h" => (1, true),
        "2s" => (2, false),
        "4s" => (2, true),
        "1d" => (3, false),
        "2d" => (3, true),
        // The 128-bit single element `.1q` (size log2 4) exists only as the
        // pmull/pmull2 destination; other arms bound size to 0..3 and reject it.
        "1q" => (4, true),
        _ => return None,
    };
    Some((num, size, q))
}

/// Parse a single SIMD element `vN.T[index]` (e.g. `v5.s[3]`) into register
/// number, element-size log2, and lane index. The element letter selects the
/// size; the bracketed index selects the lane, checked against the lane count.
fn parse_vec_elem(tok: &str) -> Option<(u8, u8, u8)> {
    let (num_s, rest) = tok.strip_prefix('v')?.split_once('.')?;
    let num: u8 = num_s.parse().ok()?;
    if num > 31 {
        return None;
    }
    let (letter, idx_s) = rest.split_once('[')?;
    let size = match letter {
        "b" => 0u8,
        "h" => 1,
        "s" => 2,
        "d" => 3,
        _ => return None,
    };
    let index: u8 = idx_s.strip_suffix(']')?.trim().parse().ok()?;
    if index >= (16u8 >> size) {
        return None;
    }
    Some((num, size, index))
}

/// Parse a single-element register list with a lane `{v0.s}[2]` into the
/// register number, element-size log2, and lane index (as a `VecElem`). Used by
/// the single-structure lane load/store forms; the lane rides outside the
/// braces, unlike the arrangement lists `parse_vec_list` handles.
fn parse_vec_list_lane(tok: &str) -> Option<(u8, u8, u8)> {
    let (reg_part, lane_part) = tok.strip_prefix('{')?.split_once('}')?;
    let lane = lane_part
        .trim()
        .strip_prefix('[')?
        .strip_suffix(']')?
        .trim();
    let (num_s, letter) = reg_part.trim().strip_prefix('v')?.split_once('.')?;
    let num: u8 = num_s.trim().parse().ok()?;
    if num > 31 {
        return None;
    }
    let size = match letter.trim() {
        "b" => 0u8,
        "h" => 1,
        "s" => 2,
        "d" => 3,
        _ => return None,
    };
    let index: u8 = lane.parse().ok()?;
    if index >= (16u8 >> size) {
        return None;
    }
    Some((num, size, index))
}

/// Parse a SIMD register list `{v0.T, v1.T, ..}` or the range form
/// `{v0.T-v3.T}` into the first register number, the count (1..4), and the
/// shared arrangement. The registers must be consecutive (modulo 32) and share
/// one arrangement.
fn parse_vec_list(tok: &str) -> Option<(u8, u8, u8, bool)> {
    let inner = tok.strip_prefix('{')?.strip_suffix('}')?.trim();
    let regs: Vec<(u8, u8, bool)> = if let Some((lo, hi)) = inner.split_once('-') {
        let (f, fs, fq) = parse_vec_reg(lo.trim())?;
        let (l, ls, lq) = parse_vec_reg(hi.trim())?;
        if fs != ls || fq != lq {
            return None;
        }
        let count = (l.wrapping_sub(f) & 31) as usize + 1;
        (0..count)
            .map(|i| (f.wrapping_add(i as u8) & 31, fs, fq))
            .collect()
    } else {
        inner
            .split(',')
            .map(|p| parse_vec_reg(p.trim()))
            .collect::<Option<Vec<_>>>()?
    };
    if regs.is_empty() || regs.len() > 4 {
        return None;
    }
    let (first, size, q) = regs[0];
    for (i, &(n, s, qq)) in regs.iter().enumerate() {
        if s != size || qq != q || n != (first.wrapping_add(i as u8) & 31) {
            return None;
        }
    }
    Some((first, regs.len() as u8, size, q))
}

fn parse_int(s: &str) -> Option<i64> {
    let s = s.trim();
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let v = if let Some(h) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")) {
        i64::from_str_radix(h, 16).ok()?
    } else {
        s.parse::<i64>().ok()?
    };
    Some(if neg { -v } else { v })
}

/// Split an operand list on commas, but not commas inside `[...]` (a memory
/// operand carries its own comma, as in `[x1, #8]`).
fn split_operands(rest: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut depth, mut start) = (0i32, 0usize);
    for (i, c) in rest.char_indices() {
        match c {
            '[' | '{' => depth += 1,
            ']' | '}' => depth -= 1,
            ',' if depth == 0 => {
                out.push(rest[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    let last = rest[start..].trim();
    if !last.is_empty() {
        out.push(last);
    }
    out
}

/// Parse a `[base]` / `[base, #off]` memory reference; `pre` is the pre-index
/// writeback (`[base, #off]!`).
fn parse_mem(inner: &str, pre: bool) -> Result<AsmOpndA64, String> {
    let parts = split_operands(inner);
    if parts.is_empty() || parts.len() > 3 {
        return Err(format!("inline asm: bad memory operand `[{inner}]`"));
    }
    let mem_base = |tok: &str| match parse_operand(tok) {
        Ok(AsmOpndA64::Ref { idx, .. }) => Ok(MemBase::Ref(idx)),
        Ok(AsmOpndA64::Reg { num, .. }) => Ok(MemBase::Reg(num)),
        _ => Err(format!("inline asm: expected a register `[{inner}]`")),
    };
    let base = mem_base(parts[0])?;
    // A second part that is not a `#immediate` is a register index: the
    // register-offset form `[base, Rm{, <extend> #s}]`.
    if parts.len() >= 2 && !parts[1].starts_with('#') {
        if pre {
            return Err(format!(
                "inline asm: register offset has no writeback `[{inner}]`"
            ));
        }
        let (index, idx_is64) = match parse_operand(parts[1])? {
            AsmOpndA64::Reg { num, is64 } => (MemBase::Reg(num), is64),
            AsmOpndA64::Ref { idx, is64 } => (MemBase::Ref(idx), is64.unwrap_or(true)),
            _ => return Err(format!("inline asm: bad index register `{}`", parts[1])),
        };
        let (option, shift) = if parts.len() == 3 {
            parse_extend(parts[2], idx_is64)?
        } else if idx_is64 {
            (0b011, None) // LSL / UXTX #0
        } else {
            return Err(format!(
                "inline asm: a 32-bit index needs uxtw/sxtw `[{inner}]`"
            ));
        };
        return Ok(AsmOpndA64::MemReg {
            base,
            index,
            option,
            shift,
        });
    }
    let off = if parts.len() == 2 {
        parts[1]
            .strip_prefix('#')
            .and_then(parse_int)
            .ok_or_else(|| format!("inline asm: bad memory offset `{}`", parts[1]))?
    } else {
        0
    };
    Ok(AsmOpndA64::Mem { base, off, pre })
}

/// Parse the index extend of a register-offset memory operand (`<kw> {#amt}`).
/// The keyword resolves to the 3-bit option and must match the index width:
/// `uxtw`/`sxtw` take a 32-bit index, `lsl`/`uxtx`/`sxtx` a 64-bit one.
fn parse_extend(spec: &str, idx_is64: bool) -> Result<(u8, Option<u8>), String> {
    let mut it = spec.split_ascii_whitespace();
    let kw = it.next().unwrap_or("");
    let (option, want64) = match kw {
        "lsl" | "uxtx" => (0b011u8, true),
        "sxtx" => (0b111, true),
        "uxtw" => (0b010, false),
        "sxtw" => (0b110, false),
        _ => return Err(format!("inline asm: bad index extend `{kw}`")),
    };
    if want64 != idx_is64 {
        return Err(format!(
            "inline asm: extend `{kw}` does not match the index width"
        ));
    }
    let shift = match it.next() {
        Some(a) => Some(
            a.strip_prefix('#')
                .and_then(parse_int)
                .filter(|v| (0..=4).contains(v))
                .ok_or_else(|| format!("inline asm: bad index shift `{a}`"))? as u8,
        ),
        None => None,
    };
    Ok((option, shift))
}

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpndA64, String> {
    // `[...]` is an offset reference; `[...]!` a pre-index writeback.
    if let Some(inner) = tok.strip_prefix('[').and_then(|t| t.strip_suffix(']')) {
        return parse_mem(inner, false);
    }
    if let Some(inner) = tok
        .strip_prefix('[')
        .and_then(|t| t.strip_suffix('!'))
        .and_then(|t| t.strip_suffix(']'))
    {
        return parse_mem(inner, true);
    }
    if let Some(rest) = tok.strip_prefix('#') {
        if let Some(v) = parse_int(rest) {
            return Ok(AsmOpndA64::Imm(v));
        }
        // A floating-point zero (`#0.0`) is the immediate form of fcmp/fcmpe;
        // it carries no other value, so it maps to the integer marker 0.
        if rest.bytes().any(|c| c == b'0')
            && rest
                .bytes()
                .all(|c| matches!(c, b'0' | b'.' | b'+' | b'-' | b'e' | b'E'))
        {
            return Ok(AsmOpndA64::Imm(0));
        }
        // A representable floating-point immediate (`fmov Vd, #1.5`).
        if let Some(fp) = parse_fp_imm(rest) {
            return Ok(AsmOpndA64::FpImm(fp));
        }
        return Err(format!("inline asm: bad immediate `{tok}`"));
    }
    if let Some(rest) = tok.strip_prefix('%') {
        // `%N`, `%wN`, `%xN`.
        let (is64, digits) = match rest.as_bytes().first() {
            Some(b'w') => (Some(false), &rest[1..]),
            Some(b'x') => (Some(true), &rest[1..]),
            _ => (None, rest),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpndA64::Ref { idx, is64 });
    }
    // `lsl #n` shift modifier (the only shift kind the move-wide forms take).
    if let Some(rest) = tok.strip_prefix("lsl") {
        let amt = rest
            .trim()
            .strip_prefix('#')
            .and_then(parse_int)
            .ok_or_else(|| format!("inline asm: bad shift `{tok}`"))?;
        return Ok(AsmOpndA64::Lsl(amt as u32));
    }
    if let Some((num, size, index)) = parse_vec_list_lane(tok) {
        return Ok(AsmOpndA64::VecElem { num, size, index });
    }
    if let Some((first, count, size, q)) = parse_vec_list(tok) {
        return Ok(AsmOpndA64::VecList {
            first,
            count,
            size,
            q,
        });
    }
    if let Some((num, size, index)) = parse_vec_elem(tok) {
        return Ok(AsmOpndA64::VecElem { num, size, index });
    }
    if let Some((num, size, q)) = parse_vec_reg(tok) {
        return Ok(AsmOpndA64::VecReg { num, size, q });
    }
    if let Some((num, is_d)) = parse_vreg(tok) {
        return Ok(AsmOpndA64::VReg { num, is_d });
    }
    if let Some(num) = parse_qreg(tok) {
        return Ok(AsmOpndA64::QReg(num));
    }
    if let Some((num, size)) = parse_vscalar(tok) {
        return Ok(AsmOpndA64::VScalar { num, size });
    }
    if let Some((num, is64)) = parse_reg(tok) {
        return Ok(AsmOpndA64::Reg { num, is64 });
    }
    // A system-register name (for mrs / msr).
    if let Some(field) = sysreg_field(tok) {
        return Ok(AsmOpndA64::SysReg(field));
    }
    // A condition code (for csel and other conditional forms).
    if let Some(c) = cond_code(tok) {
        return Ok(AsmOpndA64::Cond(c));
    }
    // A local-label reference `Nb` / `Nf` (mnemonics never start with a digit).
    if let Some((digits, dir)) = tok
        .strip_suffix('b')
        .map(|d| (d, false))
        .or_else(|| tok.strip_suffix('f').map(|d| (d, true)))
        && !digits.is_empty()
        && digits.bytes().all(|c| c.is_ascii_digit())
        && let Ok(num) = digits.parse::<u32>()
    {
        return Ok(AsmOpndA64::Label { num, forward: dir });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Parse an AArch64 inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas. A piece
/// that is all raw bytes (a `.byte`-family directive or a hex-byte run) becomes
/// a raw-byte instruction.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsnA64>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // A leading `N:` defines a local label at this point; the rest of the
        // statement (possibly empty) follows on the same line.
        if let Some(colon) = piece.find(':')
            && colon > 0
            && piece.as_bytes()[..colon].iter().all(u8::is_ascii_digit)
        {
            let num: u32 = piece[..colon]
                .parse()
                .map_err(|_| format!("inline asm: bad label `{piece}`"))?;
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes: Vec::new(),
                label_def: Some(num),
                sym_target: None,
            });
            piece = piece[colon + 1..].trim();
            if piece.is_empty() {
                continue;
            }
        }
        // Reuse the shared raw-byte recognizer for a single piece.
        if let Some(bytes) = emit_common::parse_raw_template(piece.as_bytes()) {
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes,
                label_def: None,
                sym_target: None,
            });
            continue;
        }
        let (mnem, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        // `mov Rd, sp` / `mov sp, Rn` is `add Rd, Rn, #0` -- distinct from the
        // register move `mov Rd, Rm` (`orr Rd, xzr, Rm`), and only the raw
        // token tells `sp` from `xzr` (both parse to register 31). Rewrite the
        // stack-pointer forms here; a plain register / immediate `mov` stays and
        // is encoded by the alias arm in `super::table::encode`.
        if mnem == "mov" {
            let toks: Vec<&str> = split_operands(rest);
            if toks.len() == 2
                && (toks[0] == "sp" || toks[0] == "wsp" || toks[1] == "sp" || toks[1] == "wsp")
            {
                let dst = parse_operand(toks[0])?;
                let src = parse_operand(toks[1])?;
                insns.push(AsmInsnA64 {
                    mnemonic: String::from("add"),
                    operands: alloc::vec![dst, src, AsmOpndA64::Imm(0)],
                    bytes: Vec::new(),
                    label_def: None,
                    sym_target: None,
                });
                continue;
            }
        }
        // `cinc`/`cinv`/`cneg Xd, Xn, cond` are aliases of `csinc`/`csinv`/
        // `csneg Xd, Xn, Xn, invert(cond)` -- the same source twice, the
        // condition inverted. al/nv have no inverse and are rejected, as in the
        // reference assembler.
        if let "cinc" | "cinv" | "cneg" = mnem {
            let toks = split_operands(rest);
            if toks.len() == 3
                && let Some(c) = cond_code(toks[2])
            {
                if c >= 14 {
                    return Err(format!("inline asm: `{mnem}` condition must not be al/nv"));
                }
                let dst = parse_operand(toks[0])?;
                let src = parse_operand(toks[1])?;
                let base = match mnem {
                    "cinc" => "csinc",
                    "cinv" => "csinv",
                    _ => "csneg",
                };
                insns.push(AsmInsnA64 {
                    mnemonic: String::from(base),
                    operands: alloc::vec![dst, src.clone(), src, AsmOpndA64::Cond(c ^ 1)],
                    bytes: Vec::new(),
                    label_def: None,
                    sym_target: None,
                });
                continue;
            }
        }
        // `msr <pstate>, #imm` sets a PSTATE field. The immediate is a 4-bit
        // literal, never an operand reference, so the whole instruction is
        // constant and encodes to bytes here. `msr <sysreg>, Rn` (a register
        // move, e.g. `msr nzcv, %0`) names a system register, not a PSTATE
        // field, so it falls through to the operand parse.
        if mnem == "msr" {
            let toks = split_operands(rest);
            if toks.len() == 2
                && let Some((op1, op2)) = pstate_field(toks[0])
            {
                let AsmOpndA64::Imm(v) = parse_operand(toks[1])? else {
                    return Err(format!("inline asm: `msr {}` needs a #imm4", toks[0]));
                };
                if !(0..=15).contains(&v) {
                    return Err(format!(
                        "inline asm: `msr {}` immediate out of range",
                        toks[0]
                    ));
                }
                let word =
                    0xD500_401F | ((op1 as u32) << 16) | ((v as u32) << 8) | ((op2 as u32) << 5);
                insns.push(AsmInsnA64 {
                    mnemonic: String::new(),
                    operands: Vec::new(),
                    bytes: word.to_le_bytes().to_vec(),
                    label_def: None,
                    sym_target: None,
                });
                continue;
            }
        }
        // `dc` / `ic` / `tlbi` name a system operation as the first token and
        // take an optional address register. The op resolves to a base word; the
        // register -- explicit, an operand reference, or absent (xzr) -- is
        // folded in by the encoder. This is the general path; the frontend still
        // pattern-matches the bare `dc cvau, %0` / `ic ivau, %0` forms to
        // intrinsics before an inline-asm block reaches here.
        if matches!(mnem, "dc" | "ic" | "tlbi") {
            let toks = split_operands(rest);
            if toks.is_empty() || toks.len() > 2 {
                return Err(format!(
                    "inline asm: `{mnem}` takes an op and an optional register"
                ));
            }
            let Some(base) = sysop_base(mnem, toks[0]) else {
                return Err(format!("inline asm: unknown `{mnem}` op `{}`", toks[0]));
            };
            let mut operands = alloc::vec![AsmOpndA64::SysOp(base)];
            if let Some(reg) = toks.get(1) {
                operands.push(parse_operand(reg)?);
            }
            insns.push(AsmInsnA64 {
                mnemonic: String::from(mnem),
                operands,
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
            });
            continue;
        }
        // `prfm <prfop>, [Xn{, #off | , Rm}]` prefetches; the prfop name (or a
        // raw #imm5) fills the Rt slot, and the memory operand is parsed as for
        // a load. The encoder scales the immediate offset by 8.
        if mnem == "prfm" {
            let toks = split_operands(rest);
            if toks.len() != 2 {
                return Err(String::from(
                    "inline asm: `prfm` takes a prefetch op and a memory operand",
                ));
            }
            let code = match prfop_code(toks[0]) {
                Some(c) => c as i64,
                None => match parse_operand(toks[0])? {
                    AsmOpndA64::Imm(v) if (0..=31).contains(&v) => v,
                    _ => return Err(format!("inline asm: bad prefetch op `{}`", toks[0])),
                },
            };
            let mem = parse_operand(toks[1])?;
            if !matches!(mem, AsmOpndA64::Mem { .. } | AsmOpndA64::MemReg { .. }) {
                return Err(String::from("inline asm: `prfm` needs a memory operand"));
            }
            insns.push(AsmInsnA64 {
                mnemonic: String::from("prfm"),
                operands: alloc::vec![AsmOpndA64::Imm(code), mem],
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
            });
            continue;
        }
        // A direct `bl` / `b` to a bare identifier is a call / tail-branch to a
        // symbol (`bl schedule`); the target is resolved to a rel26 by the fixup
        // pass, not parsed as a register operand. A local-label branch (`b 1f`)
        // starts with a digit, so it is excluded.
        if matches!(mnem, "bl" | "b") {
            let is_bare_ident = !rest.is_empty()
                && rest
                    .bytes()
                    .next()
                    .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_')
                && rest.bytes().all(|c| c.is_ascii_alphanumeric() || c == b'_')
                && parse_reg(rest).is_none();
            if is_bare_ident {
                insns.push(AsmInsnA64 {
                    mnemonic: String::from(mnem),
                    operands: Vec::new(),
                    bytes: Vec::new(),
                    label_def: None,
                    sym_target: Some(String::from(rest)),
                });
                continue;
            }
        }
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in split_operands(rest) {
                operands.push(parse_operand(op)?);
            }
        }
        insns.push(AsmInsnA64 {
            mnemonic: String::from(mnem),
            operands,
            bytes: Vec::new(),
            label_def: None,
            sym_target: None,
        });
    }
    Ok(insns)
}

/// Assign an AArch64 register number to each register operand of the statement,
/// per its constraint. Returns a vector parallel to `operands`: `Some(reg)` for
/// a register operand, `None` for an immediate-only operand. `r` operands take
/// free registers from a pool of x0..x15 (the emitter saves and restores them,
/// and reserves x16 / x17 as bridge scratch); matching constraints alias the
/// register of the operand they name.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 32];
    // x0..x15 are the allocatable pool; x16/x17 are the emitter's scratch.
    let pool: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // SIMD/FP register pool for `w` operands (d0..d7). The GP and FP files are
    // independent, so a number here does not clash with a GP assignment; the
    // emitter tells them apart by the operand's constraint.
    let mut fp_used = [false; 32];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Fp) {
            let r = (0u8..8)
                .find(|&r| !fp_used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of FP registers for operands"))?;
            fp_used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    // Fixed / register-or-immediate constraints are x86-specific and do not
    // occur in AArch64 templates; reject them rather than mis-assign.
    for op in operands {
        if matches!(op.constraint, C::Fixed(_) | C::RegOrImm(_)) {
            return Err(String::from(
                "inline asm: fixed-register constraint not supported on AArch64",
            ));
        }
    }
    Ok(assigned)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_data_processing() {
        let insns = parse_template(b"add %0, %1, %2").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::Ref { idx: 1, is64: None },
                AsmOpndA64::Ref { idx: 2, is64: None },
            ]
        );
    }

    #[test]
    fn parse_regs_imms_shifts() {
        let insns = parse_template(b"movz x3, #0x1234, lsl #16; mov %w0, wzr").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].mnemonic, "movz");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 3, is64: true },
                AsmOpndA64::Imm(0x1234),
                AsmOpndA64::Lsl(16),
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::Ref {
                    idx: 0,
                    is64: Some(false)
                },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: false
                },
            ]
        );
    }

    #[test]
    fn parse_raw_piece_in_stream() {
        let insns = parse_template(b".byte 0x1f, 0x20, 0x03, 0xd5; add %0, %0, %1").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].bytes, [0x1f, 0x20, 0x03, 0xd5]);
        assert!(insns[0].mnemonic.is_empty());
        assert_eq!(insns[1].mnemonic, "add");
    }

    #[test]
    fn parse_mov_stack_pointer_rewrite() {
        // `mov Rd, sp` / `mov sp, Rn` become `add ..., #0` (only the raw token
        // separates `sp` from `xzr`); a register move stays `mov`.
        let insns = parse_template(b"mov x0, sp; mov sp, x1; mov x2, x3").unwrap();
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 0, is64: true },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: true
                },
                AsmOpndA64::Imm(0),
            ]
        );
        assert_eq!(insns[1].mnemonic, "add");
        assert_eq!(
            insns[1].operands[0],
            AsmOpndA64::Reg {
                num: 31,
                is64: true
            }
        );
        assert_eq!(insns[2].mnemonic, "mov"); // register move kept for the encoder
    }

    #[test]
    fn parse_memory_operands() {
        // A memory operand keeps its internal comma out of the operand split.
        let insns = parse_template(b"ldr %0, [%1, #8]; str x3, [x4]").unwrap();
        assert_eq!(insns[0].mnemonic, "ldr");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::Mem {
                    base: MemBase::Ref(1),
                    off: 8,
                    pre: false,
                },
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::Reg { num: 3, is64: true },
                AsmOpndA64::Mem {
                    base: MemBase::Reg(4),
                    off: 0,
                    pre: false,
                },
            ]
        );
        // A negative offset feeds the signed imm9 forms (ldur/ldtr/sttr).
        let insns = parse_template(b"ldtr w0, [x1, #-4]").unwrap();
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::Mem {
                base: MemBase::Reg(1),
                off: -4,
                pre: false,
            }
        );
        // A pre-index writeback `[base, #off]!`.
        let insns = parse_template(b"stp x0, x1, [sp, #-16]!").unwrap();
        assert_eq!(
            insns[0].operands[2],
            AsmOpndA64::Mem {
                base: MemBase::Reg(31),
                off: -16,
                pre: true,
            }
        );
    }

    #[test]
    fn parse_register_offset_operands() {
        // `[Xn, Rm]` is a register offset; a bare 64-bit index is LSL/UXTX #0.
        let insns = parse_template(b"ldr x0, [x1, x2]").unwrap();
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::MemReg {
                base: MemBase::Reg(1),
                index: MemBase::Reg(2),
                option: 0b011,
                shift: None,
            }
        );
        // A scaling shift and a 32-bit index with a sign/zero extend.
        let insns = parse_template(b"ldr x0, [x1, x2, lsl #3]; ldr x0, [x1, w2, sxtw]").unwrap();
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::MemReg {
                base: MemBase::Reg(1),
                index: MemBase::Reg(2),
                option: 0b011,
                shift: Some(3),
            }
        );
        assert!(matches!(
            insns[1].operands[1],
            AsmOpndA64::MemReg { option: 0b110, .. }
        ));
        // A bare 32-bit index is ambiguous without an extend; the extend must
        // match the index width; and the writeback form does not apply.
        assert!(parse_template(b"ldr x0, [x1, w2]").is_err());
        assert!(parse_template(b"ldr x0, [x1, x2, uxtw]").is_err());
        assert!(parse_template(b"ldr x0, [x1, x2]!").is_err());
    }

    #[test]
    fn parse_sysreg_operands() {
        // CTR_EL0 field 0x5801, cross-checked against the pattern-matched
        // encoding elsewhere; the generic `s3_3_c14_c0_2` names CNTVCT_EL0.
        assert_eq!(sysreg_field("ctr_el0"), Some(0x5801));
        assert_eq!(sysreg_field("s3_3_c0_c0_1"), Some(0x5801)); // == ctr_el0
        assert_eq!(sysreg_field("s3_3_c14_c0_2"), Some(0x5F02)); // cntvct_el0
        // Generic-timer registers (verified byte-identical to the assembler).
        assert_eq!(sysreg_field("cntv_ctl_el0"), Some(0x5F19));
        assert_eq!(sysreg_field("cntv_tval_el0"), Some(0x5F18));
        assert_eq!(sysreg_field("cntvct_el0"), Some(0x5F02));
        assert_eq!(sysreg_field("cntp_ctl_el0"), Some(0x5F11));
        assert_eq!(sysreg_field("tpidr_el1"), Some(0x4684)); // per-CPU pointer
        assert_eq!(sysreg_field("fpcr"), Some(0x5A20));
        assert_eq!(sysreg_field("tpidrro_el0"), Some(0x5E83));
        assert_eq!(sysreg_field("ttbr0_el1"), Some(0x4100));
        // Register names are case-insensitive.
        assert_eq!(sysreg_field("CurrentEL"), sysreg_field("currentel"));
        assert_eq!(sysreg_field("CNTV_CTL_EL0"), Some(0x5F19));
        assert_eq!(sysreg_field("not_a_reg"), None);
        let insns = parse_template(b"mrs %0, ctr_el0; msr nzcv, %1").unwrap();
        assert_eq!(insns[0].mnemonic, "mrs");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::SysReg(0x5801)
            ]
        );
        assert_eq!(insns[1].mnemonic, "msr");
        assert!(matches!(insns[1].operands[0], AsmOpndA64::SysReg(_)));
    }

    #[test]
    fn parse_prefetch() {
        // `prfm <prfop>, [Xn{, #off}]`: the prfop name resolves to its 5-bit
        // code in the Rt slot, the memory operand parses as for a load.
        assert_eq!(prfop_code("pldl1keep"), Some(0));
        assert_eq!(prfop_code("pstl2strm"), Some(19));
        assert_eq!(prfop_code("plil1keep"), Some(8));
        assert_eq!(prfop_code("notaprfop"), None);
        let insns = parse_template(b"prfm pldl1keep, [%0]; prfm pstl2strm, [x1, #16]").unwrap();
        assert_eq!(insns[0].mnemonic, "prfm");
        assert_eq!(insns[0].operands[0], AsmOpndA64::Imm(0));
        assert!(matches!(insns[0].operands[1], AsmOpndA64::Mem { .. }));
        assert_eq!(insns[1].operands[0], AsmOpndA64::Imm(19));
        // A bad prefetch op and a missing memory operand are rejected.
        assert!(parse_template(b"prfm bogus, [x0]").is_err());
        assert!(parse_template(b"prfm pldl1keep, x0").is_err());
    }

    #[test]
    fn parse_fp_registers() {
        // `d0`..`d31` / `s0`..`s31` are SIMD/FP registers, distinct from the GP
        // file and from `sp`. fmov bridges the two files.
        assert_eq!(parse_vreg("d5"), Some((5, true)));
        assert_eq!(parse_vreg("s31"), Some((31, false)));
        assert_eq!(parse_vreg("d32"), None); // out of range
        assert_eq!(parse_vreg("sp"), None); // stack pointer, not S-reg
        // `q0`..`q31` are the 128-bit views, used by vector load/store.
        assert_eq!(parse_qreg("q0"), Some(0));
        assert_eq!(parse_qreg("q31"), Some(31));
        assert_eq!(parse_qreg("q32"), None); // out of range
        assert_eq!(parse_qreg("d0"), None); // a D-register, not a Q one
        // `b0`/`h0` are the byte/half scalar-SIMD views (reduction destinations).
        assert_eq!(parse_vscalar("b0"), Some((0, 0)));
        assert_eq!(parse_vscalar("h31"), Some((31, 1)));
        assert_eq!(parse_vscalar("s0"), None); // an S-register (VReg), not b/h
        assert_eq!(parse_vscalar("b32"), None); // out of range
        // Representable FP immediates decode to their 8-bit VFP value exactly.
        assert_eq!(parse_fp_imm("1.0"), Some(0x70));
        assert_eq!(parse_fp_imm("2.0"), Some(0x00));
        assert_eq!(parse_fp_imm("0.5"), Some(0x60));
        assert_eq!(parse_fp_imm("-1.0"), Some(0xF0));
        assert_eq!(parse_fp_imm("1.5"), Some(0x78));
        assert_eq!(parse_fp_imm("31.0"), Some(0x3F));
        assert_eq!(parse_fp_imm("-2.0"), Some(0x80));
        assert_eq!(parse_fp_imm("0.0"), None); // its own fcmp marker, not fpimm
        assert_eq!(parse_fp_imm("0.1"), None); // not a dyadic fpimm value
        assert_eq!(parse_fp_imm("100.0"), None); // out of range
        let insns = parse_template(b"fmov x0, d1; fmov s2, w3").unwrap();
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 0, is64: true },
                AsmOpndA64::VReg { num: 1, is_d: true },
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::VReg {
                    num: 2,
                    is_d: false
                },
                AsmOpndA64::Reg {
                    num: 3,
                    is64: false
                },
            ]
        );
    }

    #[test]
    fn parse_vector_registers() {
        // `vN.T` arrangement views: size = element-size log2, q = 128-bit.
        assert_eq!(parse_vec_reg("v0.4s"), Some((0, 2, true)));
        assert_eq!(parse_vec_reg("v31.8b"), Some((31, 0, false)));
        assert_eq!(parse_vec_reg("v3.2d"), Some((3, 3, true)));
        assert_eq!(parse_vec_reg("v0.3s"), None); // not an arrangement
        assert_eq!(parse_vec_reg("v32.4s"), None); // out of range
        assert_eq!(parse_vec_reg("d0"), None); // scalar view, not a vector one
        let insns = parse_template(b"add v0.4s, v1.4s, v2.4s").unwrap();
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::VecReg {
                    num: 0,
                    size: 2,
                    q: true
                },
                AsmOpndA64::VecReg {
                    num: 1,
                    size: 2,
                    q: true
                },
                AsmOpndA64::VecReg {
                    num: 2,
                    size: 2,
                    q: true
                },
            ]
        );
    }

    #[test]
    fn parse_vector_elements() {
        // `vN.T[index]` single-element views: size = element-size log2, index the
        // lane, checked against the lane count (16 >> size).
        assert_eq!(parse_vec_elem("v0.s[3]"), Some((0, 2, 3)));
        assert_eq!(parse_vec_elem("v31.b[15]"), Some((31, 0, 15)));
        assert_eq!(parse_vec_elem("v3.d[1]"), Some((3, 3, 1)));
        assert_eq!(parse_vec_elem("v0.s[4]"), None); // lane out of range (4 words)
        assert_eq!(parse_vec_elem("v0.d[2]"), None); // lane out of range (2 dwords)
        assert_eq!(parse_vec_elem("v0.4s"), None); // arrangement, not an element
        assert_eq!(parse_vec_elem("v0.q[0]"), None); // no q element
        let insns = parse_template(b"ins v0.s[1], w2").unwrap();
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::VecElem {
                    num: 0,
                    size: 2,
                    index: 1
                },
                AsmOpndA64::Reg {
                    num: 2,
                    is64: false
                },
            ]
        );
    }

    #[test]
    fn parse_vector_lists() {
        // `{v0.T, ..}` lists: consecutive registers of one arrangement. The
        // comma form and the `v0.T-vN.T` range form are equivalent.
        assert_eq!(parse_vec_list("{v0.4s}"), Some((0, 1, 2, true)));
        assert_eq!(parse_vec_list("{v0.4s, v1.4s}"), Some((0, 2, 2, true)));
        assert_eq!(parse_vec_list("{v0.16b-v3.16b}"), Some((0, 4, 0, true)));
        assert_eq!(parse_vec_list("{v30.2d, v31.2d}"), Some((30, 2, 3, true)));
        assert_eq!(parse_vec_list("{v31.8b-v1.8b}"), Some((31, 3, 0, false))); // wraps
        assert_eq!(parse_vec_list("{v0.4s, v2.4s}"), None); // not consecutive
        assert_eq!(parse_vec_list("{v0.4s, v1.8b}"), None); // arrangements differ
        assert_eq!(parse_vec_list("{v0.4s, v1.4s, v2.4s, v3.4s, v4.4s}"), None); // > 4
        let insns = parse_template(b"ld1 {v0.4s, v1.4s}, [x2]").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpndA64::VecList {
                first: 0,
                count: 2,
                size: 2,
                q: true
            }
        );
        // The lane form `{vN.T}[i]` is a single element (the lane rides outside
        // the braces), parsed as a VecElem shared with the umov/ins forms.
        assert_eq!(parse_vec_list_lane("{v0.s}[2]"), Some((0, 2, 2)));
        assert_eq!(parse_vec_list_lane("{v5.b}[15]"), Some((5, 0, 15)));
        assert_eq!(parse_vec_list_lane("{v0.d}[2]"), None); // lane out of range
        assert_eq!(parse_vec_list_lane("{v0.4s}"), None); // an arrangement list
        let insns = parse_template(b"ld1 {v3.s}[2], [x2]").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpndA64::VecElem {
                num: 3,
                size: 2,
                index: 2
            }
        );
    }

    #[test]
    fn parse_msr_pstate_immediate() {
        // `msr <pstate>, #imm` is a constant instruction; each word matches the
        // reference assembler. A trailing `msr nzcv, %0` stays a register move.
        let insns =
            parse_template(b"msr daifset, #15; msr daifclr, #2; msr spsel, #1; msr nzcv, %0")
                .unwrap();
        let word = |i: usize| u32::from_le_bytes(insns[i].bytes.as_slice().try_into().unwrap());
        assert_eq!(word(0), 0xD503_4FDF); // msr daifset, #15
        assert_eq!(word(1), 0xD503_42FF); // msr daifclr, #2
        assert_eq!(word(2), 0xD500_41BF); // msr spsel, #1
        assert_eq!(insns[3].mnemonic, "msr"); // register move kept for the encoder
        assert!(matches!(insns[3].operands[0], AsmOpndA64::SysReg(_)));
        // A PSTATE field with a register operand is rejected.
        assert!(parse_template(b"msr daifset, x0").is_err());
        // The immediate must fit in four bits.
        assert!(parse_template(b"msr daifset, #16").is_err());
    }

    #[test]
    fn parse_sys_op_operands() {
        // `dc`/`ic`/`tlbi` name an op (resolved to its base word) and take an
        // optional register, explicit or an operand reference.
        let insns = parse_template(b"dc cvac, x0; tlbi vmalle1; dc civac, %0").unwrap();
        assert_eq!(insns[0].mnemonic, "dc");
        assert_eq!(insns[0].operands[0], AsmOpndA64::SysOp(0xD50B_7A20));
        assert_eq!(insns[0].operands[1], AsmOpndA64::Reg { num: 0, is64: true });
        assert_eq!(insns[1].operands, [AsmOpndA64::SysOp(0xD508_8700)]); // no register
        assert_eq!(insns[2].operands[0], AsmOpndA64::SysOp(0xD50B_7E20));
        assert!(matches!(
            insns[2].operands[1],
            AsmOpndA64::Ref { idx: 0, .. }
        ));
        // An unknown op and an over-long operand list are rejected.
        assert!(parse_template(b"dc frobnicate, x0").is_err());
        assert!(parse_template(b"tlbi vae1, x0, x1").is_err());
    }

    #[test]
    fn parse_conditional_aliases() {
        // cinc/cinv/cneg Xd, Xn, cond expand to csinc/csinv/csneg Xd, Xn, Xn,
        // invert(cond) -- the same source register twice, the condition inverted.
        let insns = parse_template(b"cinc x0, x1, eq; cinv x2, x3, lt; cneg x4, x5, ne").unwrap();
        assert_eq!(insns[0].mnemonic, "csinc");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 0, is64: true },
                AsmOpndA64::Reg { num: 1, is64: true },
                AsmOpndA64::Reg { num: 1, is64: true },
                AsmOpndA64::Cond(1), // ne == invert(eq)
            ]
        );
        assert_eq!(insns[1].mnemonic, "csinv");
        assert!(matches!(insns[1].operands[3], AsmOpndA64::Cond(10))); // ge == invert(lt)
        assert_eq!(insns[2].mnemonic, "csneg");
        assert!(matches!(insns[2].operands[3], AsmOpndA64::Cond(0))); // eq == invert(ne)
        // al/nv have no inverse.
        assert!(parse_template(b"cinc x0, x1, al").is_err());
    }

    #[test]
    fn parse_condition_operand() {
        assert_eq!(cond_code("lt"), Some(11));
        assert_eq!(cond_code("hs"), Some(2)); // alias of cs
        assert_eq!(cond_code("xyz"), None);
        let insns = parse_template(b"csel %0, %1, %2, ne").unwrap();
        assert_eq!(insns[0].mnemonic, "csel");
        assert_eq!(insns[0].operands[3], AsmOpndA64::Cond(1));
    }

    #[test]
    fn parse_local_labels() {
        // A definition alone, one prefixing an instruction, and both reference
        // directions.
        let insns = parse_template(b"1:\n\tsub %0, %0, #1\n2: cbnz %0, 1b\n\tb 2f").unwrap();
        assert_eq!(insns[0].label_def, Some(1));
        assert_eq!(insns[1].mnemonic, "sub");
        assert_eq!(insns[2].label_def, Some(2));
        assert_eq!(insns[3].mnemonic, "cbnz");
        assert_eq!(
            insns[3].operands[1],
            AsmOpndA64::Label {
                num: 1,
                forward: false
            }
        );
        assert_eq!(insns[4].mnemonic, "b");
        assert_eq!(
            insns[4].operands[0],
            AsmOpndA64::Label {
                num: 2,
                forward: true
            }
        );
    }
}
