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

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmOpndA64 {
    /// `%N` / `%wN` / `%xN`: operand N of the statement, at the register width
    /// named by the modifier (or the operand's own width when unmodified).
    Ref { idx: u8, is64: Option<bool> },
    /// `%N.T` (e.g. `%0.16b`): operand N as a SIMD vector register in the
    /// named arrangement. Valid for `w`-constraint operands only.
    RefVec { idx: u8, size: u8, q: bool },
    /// `%N.T[i]` (e.g. `%1.d[0]`): one lane of operand N, the element view the
    /// lane-transfer forms take. Valid for `w`-constraint operands only.
    RefVecElem { idx: u8, size: u8, index: u8 },
    /// `%qN`: operand N's 128-bit `q` register view (`w` operands).
    RefQ(u8),
    /// `{%N.T}`: a one-register table list whose register is operand N
    /// (the tbl/tbx table when the wrapper passes it as a `w` operand).
    RefVecList { idx: u8, size: u8, q: bool },
    /// `%cN` / `%PN`: operand N substituted as a bare constant, without
    /// immediate syntax. Valid on an `i`-class operand; the emitter
    /// resolves the compile-time constant value.
    RefConst(u8),
    /// An explicit register: `x5` / `w5` / `sp` / `xzr`. `num == 31` is the
    /// zero register or SP per the instruction, so `sp` records which spelling
    /// was written; the encoder picks the form that reads it that way.
    Reg { num: u8, is64: bool, sp: bool },
    /// `Xn!`: a 64-bit register operand the instruction writes back, as the
    /// memory copy/set family spells its size and pointer operands.
    RegWb(u8),
    /// A shifted-register `<lsr|asr|ror> #amount` modifier (`kind` 1..3; `lsl`
    /// stays [`AsmOpndA64::Lsl`], which the extended forms also take).
    Shift { kind: u8, amount: u8 },
    /// An extended-register `<extend> {#amount}` modifier; `option` is the
    /// 3-bit extend selector.
    Extend { option: u8, amount: u8 },
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
    /// A system register named in a `mrs` / `msr`, resolved to its 16-bit
    /// `op0:op1:CRn:CRm:op2` field.
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
    /// The location counter `.` as a branch target, with an optional signed
    /// byte offset: the address of the branch instruction itself (`cbnz %0,
    /// .`) or a fixed displacement from it (`bl . + 4`, a branch to the next
    /// instruction that only records a return address).
    Here(i32),
    /// `%lK`: an `asm goto` label reference by label-list index (the
    /// frontend canonicalizes `%l[name]` and operand-relative `%lN` to
    /// this form). The emitter branches to the label's target block.
    GotoLabel(u8),
    /// A symbol expression operand (`sym`, `sym + 24`, `sym + (2f - 1f)`):
    /// a branch / `adr` / `adrp` target, or the part of the value `spec`
    /// names. Section code and function bodies both encode these to a
    /// relocation; a function body admits only the `sym + constant` form,
    /// having no layout to fold a label difference against.
    Sym { expr: String, spec: SymSpec },
    /// `[base, :lo12:sym]`: a load/store whose scaled immediate is the low
    /// 12 bits of a symbol expression. The base is an operand reference or
    /// an explicit register, as for [`AsmOpndA64::Mem`].
    MemSymLo12 { base: MemBase, expr: String },
    /// An immediate written as an expression over labels (`#(1b - vs + 4)`):
    /// absolute, but only the section layout knows the value, and on A64 the
    /// value selects the encoding, so the section path folds it before
    /// encoding.
    ImmExpr(String),
    /// A memory offset written as such an expression (`[x30, #(1b - vs)]`),
    /// folded the same way.
    MemExpr {
        base: MemBase,
        expr: String,
        pre: bool,
    },
    /// `ldr Rt, =value`: the value goes in the section's literal pool and the
    /// load reads it PC-relatively. The expression text is resolved when the
    /// pool is assigned, before layout.
    LitPool(String),
}

/// Which part of a symbol expression's value an operand takes, from the
/// relocation specifier GNU as writes before the expression.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum SymSpec {
    /// No specifier: the address itself, for a branch / `adr` / `adrp`.
    Addr,
    /// `:lo12:` -- the low 12 bits, for an `add` or a load/store immediate.
    Lo12,
    /// `:abs_gN[_s|_nc]:` -- the `group`th 16-bit group of the value, for a
    /// `movz` / `movk` immediate. `signed` marks the `_s` forms, whose
    /// negative values encode as `movn`; `check` is the value width GNU as
    /// admits when the expression folds, `None` for the `_nc` forms and
    /// `:abs_g3:`.
    MovwAbs {
        group: u8,
        signed: bool,
        check: Option<u32>,
    },
}

/// The base register of a memory operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum MemBase {
    Ref(u8),
    Reg(u8),
}

/// The 16-bit `mrs`/`msr` system-register field for a name, or the generic
/// `s<op0>_<op1>_c<CRn>_c<CRm>_<op2>` spelling that names any register.
/// `field = op0<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2` (op0 is the full two
/// bits; the generic spelling reaches op0 0/1, named registers use 2/3).
pub(super) fn sysreg_field(name: &str) -> Option<u16> {
    // Register names are case-insensitive in the architecture; normalize before
    // matching either the named table or the generic spelling.
    let lower = name.to_ascii_lowercase();
    let name = lower.as_str();
    if let Ok(i) = super::sysreg_a64_table::SYSREGS.binary_search_by_key(&name, |&(n, _)| n) {
        return Some(super::sysreg_a64_table::SYSREGS[i].1);
    }
    let p: Vec<&str> = name.split('_').collect();
    if p.len() == 5
        && let Some(op0) = p[0].strip_prefix('s').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op1) = p[1].parse::<u16>()
        && let Some(crn) = p[2].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Some(crm) = p[3].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op2) = p[4].parse::<u16>()
        && op0 <= 3
        && op1 <= 7
        && crn <= 15
        && crm <= 15
        && op2 <= 7
    {
        return Some((op0 << 14) | (op1 << 11) | (crn << 7) | (crm << 3) | op2);
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

/// The base word of a `dc` / `ic` / `at` / `tlbi` system operation
/// (`0xD5080000 | op1<<16 | CRn<<12 | CRm<<8 | op2<<5`, no Rt), or None if the
/// mnemonic/op pair is not a known one.
pub(super) fn sysop_base(mnem: &str, op: &str) -> Option<u32> {
    use super::sysreg_a64_table::{AT_OPS, DC_OPS, IC_OPS, TLBI_OPS};
    let table = match mnem {
        "dc" => DC_OPS,
        "ic" => IC_OPS,
        "at" => AT_OPS,
        "tlbi" => TLBI_OPS,
        _ => return None,
    };
    let lower = op.to_ascii_lowercase();
    let i = table
        .binary_search_by_key(&lower.as_str(), |&(n, _)| n)
        .ok()?;
    let sel = u32::from(table[i].1);
    Some(sysop_word(
        sel >> 11,
        (sel >> 7) & 15,
        (sel >> 3) & 15,
        sel & 7,
    ))
}

/// The `sys` base word for an (op1, CRn, CRm, op2) selector, Rt left zero.
fn sysop_word(op1: u32, crn: u32, crm: u32, op2: u32) -> u32 {
    0xD508_0000 | (op1 << 16) | (crn << 12) | (crm << 8) | (op2 << 5)
}

/// The base word of a `sys #op1, cN, cM, #op2` operand list (`op1`, `crn`,
/// `crm`, `op2` fields, Rt left zero), or None if a field is malformed / out of
/// range. `#` on the immediates is optional, matching GAS.
fn sys_op_base(op1: &str, crn: &str, crm: &str, op2: &str) -> Option<u32> {
    let imm = |t: &str| -> Option<u32> {
        parse_int(t.strip_prefix('#').unwrap_or(t))
            .and_then(|v| u32::try_from(v).ok())
            .filter(|v| *v <= 7)
    };
    let cn = |t: &str| -> Option<u32> {
        t.strip_prefix('c')
            .or_else(|| t.strip_prefix('C'))
            .and_then(|d| d.parse::<u32>().ok())
            .filter(|v| *v <= 15)
    };
    let (op1, crn, crm, op2) = (imm(op1)?, cn(crn)?, cn(crm)?, imm(op2)?);
    Some(sysop_word(op1, crn, crm, op2))
}

/// The 4-bit CRm value of a `dmb` / `dsb` barrier option, or None if the
/// name is not one. `isb` takes only `sy`; `clrex` only a numeric imm.
fn barrier_option(name: &str) -> Option<u32> {
    Some(match name.to_ascii_lowercase().as_str() {
        "sy" => 15,
        "st" => 14,
        "ld" => 13,
        "ish" => 11,
        "ishst" => 10,
        "ishld" => 9,
        "nsh" => 7,
        "nshst" => 6,
        "nshld" => 5,
        "osh" => 3,
        "oshst" => 2,
        "oshld" => 1,
        _ => return None,
    })
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
    /// A layout directive (`.balign`, `.skip`, `.org`, ...), which moves the
    /// location counter rather than depositing an encoding. Carried in the
    /// section engine's form so both paths lay it down the same way.
    pub layout: Option<crate::c5::asm::AsmSectionItem>,
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

/// A general register token: `(number, is64, written as sp)`.
fn parse_reg(tok: &str) -> Option<(u8, bool, bool)> {
    match tok {
        "sp" => return Some((31, true, true)),
        "xzr" => return Some((31, true, false)),
        "wsp" => return Some((31, false, true)),
        "wzr" => return Some((31, false, false)),
        _ => {}
    }
    let (is64, rest) = match tok.as_bytes().first()? {
        b'x' => (true, &tok[1..]),
        b'w' => (false, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 30).then_some((n, is64, false))
}

/// The 3-bit extend selector of an `<extend> {#amount}` operand group.
fn extend_option(kw: &str) -> Option<u8> {
    Some(match kw {
        "uxtb" => 0,
        "uxth" => 1,
        "uxtw" => 2,
        "uxtx" => 3,
        "sxtb" => 4,
        "sxth" => 5,
        "sxtw" => 6,
        "sxtx" => 7,
        _ => return None,
    })
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

/// Resolve an AArch64 clobber register name to `(is_fp, number)`. GP names
/// (`x0`..`x30`, `w0`..`w30`, `sp`) map to the GP file; the SIMD/FP views
/// (`b`/`h`/`s`/`d`/`q`/`vN`) map to the FP file. Returns None for a name that
/// is not a register (e.g. `cc`).
pub(crate) fn clobber_reg_name(name: &str) -> Option<(bool, u8)> {
    if let Some((num, ..)) = parse_reg(name) {
        return Some((false, num));
    }
    if let Some((num, _)) = parse_vreg(name) {
        return Some((true, num));
    }
    if let Some(num) = parse_qreg(name) {
        return Some((true, num));
    }
    if let Some((num, _)) = parse_vscalar(name) {
        return Some((true, num));
    }
    // A bare `vN` names the same SIMD register file as `dN`/`qN`.
    if let Some(num) = name.strip_prefix('v').and_then(|s| s.parse::<u8>().ok())
        && num <= 31
    {
        return Some((true, num));
    }
    None
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

/// A vector arrangement name to (element-size log2, 128-bit flag).
fn arrangement(arr: &str) -> Option<(u8, bool)> {
    Some(match arr {
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
    })
}

/// The element-size log2 of a lane suffix (`b`/`h`/`s`/`d`).
fn element_size(letter: &str) -> Option<u8> {
    Some(match letter {
        "b" => 0,
        "h" => 1,
        "s" => 2,
        "d" => 3,
        _ => return None,
    })
}

/// A SIMD vector-arrangement register `vN.T` (e.g. `v5.4s`): the register
/// number, the element-size log2, and the 128-bit flag.
fn parse_vec_reg(tok: &str) -> Option<(u8, u8, bool)> {
    let (num_s, arr) = tok.strip_prefix('v')?.split_once('.')?;
    let num: u8 = num_s.parse().ok()?;
    if num > 31 {
        return None;
    }
    let (size, q) = arrangement(arr)?;
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
    let size = element_size(letter)?;
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
    let size = element_size(letter.trim())?;
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

/// An assembler integer operand: a literal or a GNU as constant expression
/// (`(1 << 16)`, `4 * 0`). Operand references do not appear here, so the
/// expression resolver yields None for them.
fn parse_int(s: &str) -> Option<i64> {
    crate::c5::asm::eval_const_expr(s.trim())
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
    // `[base, :lo12:sym]`: the symbol's low 12 bits as the scaled immediate.
    if parts.len() == 2
        && let Some(spec) = parts[1]
            .strip_prefix('#')
            .unwrap_or(parts[1])
            .strip_prefix(":lo12:")
    {
        if pre {
            return Err(format!("inline asm: `:lo12:` has no writeback `[{inner}]`"));
        }
        let expr = split_sym_addend(spec)
            .ok_or_else(|| format!("inline asm: bad `:lo12:` symbol `[{inner}]`"))?;
        return Ok(AsmOpndA64::MemSymLo12 {
            base,
            expr: String::from(expr),
        });
    }
    // A second part that is not an immediate is a register index: the
    // register-offset form `[base, Rm{, <extend> #s}]`. GNU as makes the
    // `#` on an offset optional, so a bare integer (`[x4, -16]`) is an
    // offset, not an index.
    let bare_int_off = |t: &str| !t.starts_with('#') && parse_int(t).is_some();
    if parts.len() >= 2 && !parts[1].starts_with('#') && !bare_int_off(parts[1]) {
        if pre {
            return Err(format!(
                "inline asm: register offset has no writeback `[{inner}]`"
            ));
        }
        let (index, idx_is64) = match parse_operand(parts[1])? {
            // The index field reads 31 as the zero register, never as SP.
            AsmOpndA64::Reg { sp: true, .. } => {
                return Err(format!(
                    "inline asm: sp is not an index register `[{inner}]`"
                ));
            }
            AsmOpndA64::Reg { num, is64, .. } => (MemBase::Reg(num), is64),
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
        // The offset is a GNU as constant expression, not just a literal
        // (`[xN, #4 * 0]` folds to 0), with the `#` optional. Operand
        // references do not appear in an offset, so the resolver yields None.
        let expr = parts[1].strip_prefix('#').unwrap_or(parts[1]).trim();
        match crate::c5::asm::eval_const_expr_ops(expr, &|_| None) {
            Some(v) => v,
            // An expression over labels: the value is the section layout's.
            None if is_layout_expr(expr) => {
                return Ok(AsmOpndA64::MemExpr {
                    base,
                    expr: String::from(expr),
                    pre,
                });
            }
            None => return Err(format!("inline asm: bad memory offset `{}`", parts[1])),
        }
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
    let option = match kw {
        "lsl" => 0b011,
        // The index takes the word and doubleword extends only.
        _ => extend_option(kw)
            .filter(|o| matches!(o, 0b010 | 0b011 | 0b110 | 0b111))
            .ok_or_else(|| format!("inline asm: bad index extend `{kw}`"))?,
    };
    if (option & 1 == 1) != idx_is64 {
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

/// The amount of a shift / extend modifier. GAS makes the `#` optional here as
/// it does on an immediate operand, so `lsl 12` and `lsl #12` are one form.
fn shift_amount(rest: &str) -> Option<i64> {
    let rest = rest.trim();
    parse_int(rest.strip_prefix('#').unwrap_or(rest))
}

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpndA64, String> {
    // `=value`: the literal-pool request of `ldr`. No other operand starts
    // with `=`, so the expression carries through unparsed.
    if let Some(expr) = tok.strip_prefix('=') {
        return Ok(AsmOpndA64::LitPool(String::from(expr.trim())));
    }
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
    // GNU as makes the `#` optional on an immediate, including one written as a
    // relocation specifier (`#:lo12:sym`), so a `:`-led remainder falls through
    // to the specifier handling below.
    if let Some(rest) = tok.strip_prefix('#')
        && !rest.starts_with(':')
    {
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
        // An expression over labels: the value is the section layout's.
        if is_layout_expr(rest.trim()) {
            return Ok(AsmOpndA64::ImmExpr(String::from(rest.trim())));
        }
        return Err(format!("inline asm: bad immediate `{tok}`"));
    }
    if let Some(rest) = tok.strip_prefix('%') {
        // `%lK`: an `asm goto` label-list reference.
        if let Some(digits) = rest.strip_prefix('l')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let k: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad goto-label reference `{tok}`"))?;
            return Ok(AsmOpndA64::GotoLabel(k));
        }
        // `%cN` / `%PN`: a bare-constant substitution.
        if let Some(&m) = rest.as_bytes().first()
            && matches!(m, b'c' | b'P')
            && rest.len() > 1
            && rest[1..].bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = rest[1..]
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpndA64::RefConst(idx));
        }
        // `%aN`: operand N rendered as an address reference. The operand holds
        // an address in a general register, so this is the base-only memory
        // form `[xN]`.
        if let Some(digits) = rest.strip_prefix('a')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpndA64::Mem {
                base: MemBase::Ref(idx),
                off: 0,
                pre: false,
            });
        }
        // `%N.T` (e.g. `%0.16b`): a vector-register view of operand N in the
        // named arrangement, or `%N.T[i]` naming one lane of it.
        if let Some((digits, arr)) = rest.split_once('.')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            if let Some((elem, lane)) = arr.split_once('[')
                && let Some(lane) = lane.strip_suffix(']')
            {
                let Some(size) = element_size(elem.trim()) else {
                    return Err(format!("inline asm: bad vector element `{tok}`"));
                };
                let index: u8 = lane
                    .trim()
                    .parse()
                    .map_err(|_| format!("inline asm: bad lane index `{tok}`"))?;
                if index >= (16u8 >> size) {
                    return Err(format!("inline asm: lane index out of range `{tok}`"));
                }
                return Ok(AsmOpndA64::RefVecElem { idx, size, index });
            }
            let Some((size, q)) = arrangement(arr) else {
                return Err(format!("inline asm: bad vector arrangement `{tok}`"));
            };
            return Ok(AsmOpndA64::RefVec { idx, size, q });
        }
        // `%qN`: the 128-bit q view of operand N.
        if let Some(digits) = rest.strip_prefix('q')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpndA64::RefQ(idx));
        }
        // `%N` (natural width); the GP views `%wN` (32) / `%xN` (64); and the FP
        // scalar views `%sN` (single) / `%dN` (double). A view flag rides `is64`
        // (w/s = 32, x/d = 64) and the emitter resolves it against the operand's
        // register file (GP -> W/X, FP -> S/D).
        let (is64, digits) = match rest.as_bytes().first() {
            Some(b'w') | Some(b's') => (Some(false), &rest[1..]),
            Some(b'x') | Some(b'd') => (Some(true), &rest[1..]),
            _ => (None, rest),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpndA64::Ref { idx, is64 });
    }
    // `lsl #n` shift modifier: the move-wide `hw` amount, the shifted-register
    // LSL kind, and the extended-register identity extend all spell it this
    // way, so it keeps its own operand kind.
    if let Some(rest) = tok.strip_prefix("lsl") {
        let amt = shift_amount(rest).ok_or_else(|| format!("inline asm: bad shift `{tok}`"))?;
        return Ok(AsmOpndA64::Lsl(amt as u32));
    }
    // The remaining shifted-register kinds `<lsr|asr|ror> #n`.
    if let Some(kind) = match tok.get(..3) {
        Some("lsr") => Some(1u8),
        Some("asr") => Some(2),
        Some("ror") => Some(3),
        _ => None,
    } {
        let amt = shift_amount(&tok[3..])
            .filter(|v| (0..64).contains(v))
            .ok_or_else(|| format!("inline asm: bad shift `{tok}`"))?;
        return Ok(AsmOpndA64::Shift {
            kind,
            amount: amt as u8,
        });
    }
    // An extended-register `<extend> {#n}` group; the amount defaults to 0.
    if let Some(option) = tok.get(..4).and_then(extend_option) {
        let rest = tok[4..].trim();
        let amount = if rest.is_empty() {
            0
        } else {
            shift_amount(rest)
                .filter(|v| (0..=4).contains(v))
                .ok_or_else(|| format!("inline asm: bad extend amount `{tok}`"))? as u8
        };
        return Ok(AsmOpndA64::Extend { option, amount });
    }
    // `{%N.T}`: a one-register list whose register is an operand reference.
    if let Some(inner) = tok.strip_prefix('{').and_then(|t| t.strip_suffix('}'))
        && let Ok(AsmOpndA64::RefVec { idx, size, q }) = parse_operand(inner.trim())
    {
        return Ok(AsmOpndA64::RefVecList { idx, size, q });
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
    if let Some((num, is64, sp)) = parse_reg(tok) {
        return Ok(AsmOpndA64::Reg { num, is64, sp });
    }
    // `Xn!`: a register the instruction writes back, the size and pointer
    // operands of the memory copy/set family.
    if let Some(base) = tok.strip_suffix('!')
        && let Some((num, true, false)) = parse_reg(base)
    {
        return Ok(AsmOpndA64::RegWb(num));
    }
    // A system-register name (for mrs / msr).
    if let Some(field) = sysreg_field(tok) {
        return Ok(AsmOpndA64::SysReg(field));
    }
    // A condition code (for csel and other conditional forms).
    if let Some(c) = cond_code(tok) {
        return Ok(AsmOpndA64::Cond(c));
    }
    // The location counter `.` names the current instruction as a branch
    // target (`b .`, `cbnz %0, .`), optionally displaced by a signed byte
    // offset (`bl . + 4`); the emitter encodes the displacement.
    if tok == "." {
        return Ok(AsmOpndA64::Here(0));
    }
    if let Some(rest) = tok.strip_prefix('.').map(str::trim_start)
        && let Some(body) = rest.strip_prefix(['+', '-'])
        && let Some(v) = parse_int(body.trim_start())
        && let Ok(off) = i32::try_from(if rest.starts_with('-') { -v } else { v })
    {
        return Ok(AsmOpndA64::Here(off));
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
    // GAS makes the `#` on an immediate optional, so a bare integer literal is
    // an immediate (`brk 0x800`, `hlt 0xf000`). Checked last: registers,
    // system registers and local labels are matched above.
    if let Some(v) = parse_int(tok) {
        return Ok(AsmOpndA64::Imm(v));
    }
    // `:lo12:sym` (with GAS's optional `#`): a symbol's low 12 bits.
    let bare = tok.strip_prefix('#').unwrap_or(tok);
    if let Some(spec) = bare.strip_prefix(":lo12:")
        && let Some(expr) = split_sym_addend(spec)
    {
        return Ok(AsmOpndA64::Sym {
            expr: String::from(expr),
            spec: SymSpec::Lo12,
        });
    }
    // `:abs_gN[_s|_nc]:expr`: one 16-bit group of the value. The expression
    // is kept whole -- it may be a parenthesized constant or reach a symbol
    // -- and resolved where the section is laid out.
    if let Some(rest) = bare.strip_prefix(":abs_g") {
        let (group, expr) = rest
            .split_once(':')
            .ok_or_else(|| format!("inline asm: `:abs_g` specifier `{tok}` is unterminated"))?;
        return Ok(AsmOpndA64::Sym {
            expr: String::from(expr.trim()),
            spec: parse_movw_group(group)
                .ok_or_else(|| format!("inline asm: unknown relocation modifier `{tok}`"))?,
        });
    }
    // A symbol name with an optional constant addend (`sym + 24`): a
    // branch / adr / adrp target the encoder relocates. A PSTATE field
    // name reaching here is a malformed `msr` (the immediate form is
    // matched before the operand parse), not a symbol.
    if let Some(expr) = split_sym_addend(tok)
        && pstate_field(expr).is_none()
    {
        return Ok(AsmOpndA64::Sym {
            expr: String::from(expr),
            spec: SymSpec::Addr,
        });
    }
    // GNU as makes the `#` optional, so an immediate written as an expression
    // over labels also reaches here without one. A lone name is not one of
    // these: the symbol form above already took it, or it is a bad operand.
    if !crate::c5::asm::is_asm_symbol_name(tok) && is_layout_expr(tok) {
        return Ok(AsmOpndA64::ImmExpr(String::from(tok)));
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Whether a token is a well-formed GNU as expression whose value only the
/// section layout knows. Leaves stand in as zero, so this checks the syntax
/// alone; the constant folder has already run.
fn is_layout_expr(tok: &str) -> bool {
    crate::c5::asm::is_asm_layout_expr(tok)
}

/// The group part of an `:abs_gN[_s|_nc]:` specifier. GNU as defines the
/// unsuffixed and `_nc` forms for groups 0..2, `_s` for groups 0..2, and
/// `:abs_g3:` alone for the top group; every other spelling is an unknown
/// modifier. The check width is the group's cumulative one, which for a
/// signed group leaves its top bit to the sign.
fn parse_movw_group(group: &str) -> Option<SymSpec> {
    let (digits, signed, checked) = match group.strip_suffix("_s") {
        Some(d) => (d, true, true),
        None => match group.strip_suffix("_nc") {
            Some(d) => (d, false, false),
            None => (group, false, true),
        },
    };
    let group: u8 = digits.parse().ok().filter(|g| *g <= 3)?;
    if group == 3 && (signed || !checked) {
        return None;
    }
    Some(SymSpec::MovwAbs {
        group,
        signed,
        check: (checked && group < 3).then(|| 16 * (group as u32 + 1)),
    })
}

/// Drop parentheses enclosing a whole expression: `:lo12:(sym + 8)` and
/// `:lo12:sym + 8` name the same value.
fn strip_outer_parens(s: &str) -> &str {
    let mut s = s.trim();
    while let Some(inner) = s.strip_prefix('(').and_then(|t| t.strip_suffix(')')) {
        // Only when the leading `(` is the one the trailing `)` closes.
        let mut depth = 0i32;
        if inner.chars().any(|c| {
            depth += i32::from(c == '(') - i32::from(c == ')');
            depth < 0
        }) {
            break;
        }
        s = inner.trim();
    }
    s
}

/// A symbol reference with an optional addend (`sym`, `sym + 24`,
/// `sym + (2f - 1f)`), returned as written: the section engine evaluates it
/// once the layout is known, folding a same-section label difference and
/// relocating what is left. `None` when the head is not a symbol name or the
/// tail is not `+`/`-` an expression the assembler's grammar accepts.
pub(super) fn split_sym_addend(s: &str) -> Option<&str> {
    let s = strip_outer_parens(s);
    let end = s
        .find(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$')))
        .unwrap_or(s.len());
    let (name, rest) = s.split_at(end);
    if name.is_empty() || name.as_bytes()[0].is_ascii_digit() {
        return None;
    }
    let rest = rest.trim();
    if rest.is_empty() {
        return Some(s);
    }
    if !rest.starts_with(['+', '-']) {
        return None;
    }
    let ctx = crate::c5::asm::AsmExprCtx {
        resolve: &|_| Some(crate::c5::asm::AsmExprLeaf::Abs(0)),
        const_of: &|_| None,
        lax_div: true,
    };
    crate::c5::asm::eval_asm_value(s, &ctx).ok()?;
    Some(s)
}

/// Parse an AArch64 inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas. A piece
/// that is all raw bytes (a `.byte`-family directive or a hex-byte run) becomes
/// a raw-byte instruction.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsnA64>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let stripped;
    let text = match crate::c5::asm::strip_asm_comments(text, crate::c5::asm::AsmComments::A64) {
        Some(t) => {
            stripped = t;
            stripped.as_str()
        }
        None => text,
    };
    // `%=` expands to a per-instance number (shared helper).
    let expanded;
    let text = match crate::c5::asm::expand_template_uniq(text) {
        Some(t) => {
            expanded = t;
            expanded.as_str()
        }
        None => text,
    };
    // Pre-scan the label definitions so an operand naming one resolves to a
    // template label rather than a symbol; named labels intern in definition
    // order.
    let names = crate::c5::asm::scan_label_names(text);
    if let Some(dup) = crate::c5::asm::duplicate_label_name(text) {
        return Err(format!("inline asm: symbol `{dup}` is already defined"));
    }
    let label_num = |name: &str| -> Option<u32> {
        names
            .iter()
            .position(|&n| n == name)
            .map(|i| crate::c5::asm::NAMED_LABEL_BASE + i as u32)
    };
    let mut insns = Vec::new();
    for piece in crate::c5::asm::split_asm_statements(text) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // Leading `name:` / `N:` definitions mark this point; the rest of the
        // statement (possibly empty) follows on the same line.
        while let Some((name, rest)) = crate::c5::asm::split_label_def(piece) {
            let num = if name.as_bytes()[0].is_ascii_digit() {
                name.parse::<u32>()
                    .ok()
                    .filter(|&n| n < crate::c5::asm::NAMED_LABEL_BASE)
                    .ok_or_else(|| format!("inline asm: bad label `{piece}`"))?
            } else {
                label_num(name).expect("the pre-scan interned every named definition")
            };
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes: Vec::new(),
                label_def: Some(num),
                sym_target: None,
                layout: None,
            });
            piece = rest.trim();
        }
        if piece.is_empty() {
            continue;
        }
        // `.arch` / `.arch_extension` / `.cpu` select the assembler's target
        // architecture or an ISA extension. The encoder admits every form its
        // table holds regardless, so these carry no code and are ignored.
        if let Some(tok) = piece.split_whitespace().next()
            && matches!(tok, ".arch" | ".arch_extension" | ".cpu")
        {
            continue;
        }
        // An alignment, space-and-fill or `.org` directive moves the location
        // counter; the section engine's parse gives the form the emitter lays
        // down.
        let (dir_tok, dir_rest) = match piece.split_once(char::is_whitespace) {
            Some((t, r)) => (t, r.trim()),
            None => (piece, ""),
        };
        if let Some(item) = crate::c5::asm::parse_stream_layout_item(dir_tok, dir_rest, true) {
            insns.push(AsmInsnA64 {
                mnemonic: String::from(dir_tok),
                operands: Vec::new(),
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
                layout: Some(item?),
            });
            continue;
        }
        // A `.byte`-family directive whose arguments are not all constant: an
        // operand reference (`.long %c0`) or an expression over template
        // labels (`.byte 662b-661b`) resolves its value at emit time; the
        // directive keyword rides the mnemonic field.
        // `.word` always takes this path: its element is 4 bytes on AArch64,
        // where the shared raw-byte reader lays down the 2-byte default.
        if let Some((tok, rest)) = piece.split_once(char::is_whitespace)
            && crate::c5::asm::data_directive_width(tok).is_some()
            && (tok == ".word" || crate::c5::asm::parse_raw_template(piece.as_bytes()).is_none())
        {
            let mut operands = Vec::new();
            for a in split_operands(rest) {
                // Directive arguments are bare integers, not `#`-prefixed.
                operands.push(match parse_int(a) {
                    Some(v) => AsmOpndA64::Imm(v),
                    None => parse_operand(a)?,
                });
            }
            insns.push(AsmInsnA64 {
                mnemonic: String::from(tok),
                operands,
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
        }
        // Reuse the shared raw-byte recognizer for a single piece. A data
        // directive of constants keeps its keyword in the mnemonic field so
        // the emitter classifies its bytes as it does the operand-referencing
        // form; a bare machine-byte run carries no keyword.
        if let Some(bytes) = crate::c5::asm::parse_raw_template(piece.as_bytes()) {
            let tok = piece.split_whitespace().next().unwrap_or_default();
            insns.push(AsmInsnA64 {
                mnemonic: match crate::c5::asm::data_directive_width(tok) {
                    Some(_) => String::from(tok),
                    None => String::new(),
                },
                operands: Vec::new(),
                bytes,
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
        }
        let (mnem, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        // `mov Rd, sp` / `mov sp, Rn` is `add Rd, Rn, #0`, distinct from the
        // register move `mov Rd, Rm` (`orr Rd, xzr, Rm`). Rewrite the
        // stack-pointer forms here; a plain register / immediate `mov` stays and
        // is encoded by the alias arm in `super::table::encode`.
        if mnem == "mov" {
            let toks: Vec<&str> = split_operands(rest);
            let written_sp =
                |t: &str| matches!(parse_operand(t), Ok(AsmOpndA64::Reg { sp: true, .. }));
            if toks.len() == 2 && (written_sp(toks[0]) || written_sp(toks[1])) {
                let dst = parse_operand(toks[0])?;
                let src = parse_operand(toks[1])?;
                insns.push(AsmInsnA64 {
                    mnemonic: String::from("add"),
                    operands: alloc::vec![dst, src, AsmOpndA64::Imm(0)],
                    bytes: Vec::new(),
                    label_def: None,
                    sym_target: None,
                    layout: None,
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
                    layout: None,
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
            // A name that is both a PSTATE field and a system register (SPSel,
            // PAN, ...) takes this path only for the immediate form.
            if toks.len() == 2
                && let Some((op1, op2)) = pstate_field(toks[0])
                && let Ok(AsmOpndA64::Imm(v)) = parse_operand(toks[1])
            {
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
                    layout: None,
                });
                continue;
            }
        }
        // Barriers: `dmb` / `dsb` take a domain option (default `sy`), `isb`
        // takes only `sy`, `clrex` a numeric imm. All are constant and encode
        // to their word here: `1101 0101 0000 0011 0011 CRm opc 11111` with
        // opc 4 (dsb), 5 (dmb), 6 (isb), 2 (clrex). Byte-verified vs clang.
        if matches!(mnem, "dmb" | "dsb" | "isb" | "clrex") {
            let toks = split_operands(rest);
            if toks.len() > 1 {
                return Err(format!("inline asm: `{mnem}` takes at most one option"));
            }
            let crm = match toks.first() {
                None => 15,
                Some(t) => match barrier_option(t) {
                    Some(v) if matches!(mnem, "dmb" | "dsb") || (mnem == "isb" && v == 15) => v,
                    _ => match t.strip_prefix('#').and_then(parse_int) {
                        Some(v) if (0..=15).contains(&v) => v as u32,
                        _ => return Err(format!("inline asm: bad `{mnem}` option `{t}`")),
                    },
                },
            };
            let opc = match mnem {
                "dsb" => 4u32,
                "dmb" => 5,
                "isb" => 6,
                _ => 2, // clrex
            };
            let word = 0xD503_301F | (crm << 8) | (opc << 5);
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes: word.to_le_bytes().to_vec(),
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
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
                layout: None,
            });
            continue;
        }
        // `at <op>, Xt` translates an address; Xt holds the input address.
        // Encoded as a `sys` instruction, sharing the dc/ic/tlbi encode path.
        if mnem == "at" {
            let toks = split_operands(rest);
            if toks.len() != 2 {
                return Err(String::from("inline asm: `at` takes an op and a register"));
            }
            let Some(base) = sysop_base(mnem, toks[0]) else {
                return Err(format!("inline asm: unknown `at` op `{}`", toks[0]));
            };
            insns.push(AsmInsnA64 {
                mnemonic: String::from("at"),
                operands: alloc::vec![AsmOpndA64::SysOp(base), parse_operand(toks[1])?],
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
        }
        // `sys #op1, cN, cM, #op2{, Xt}` is the generic system instruction that
        // dc/ic/tlbi/at alias. The op fields form a base word; Xt (or xzr) is
        // folded in by the encoder.
        if mnem == "sys" {
            let toks = split_operands(rest);
            if !(4..=5).contains(&toks.len()) {
                return Err(String::from(
                    "inline asm: `sys` takes #op1, cN, cM, #op2 and an optional register",
                ));
            }
            let Some(base) = sys_op_base(toks[0], toks[1], toks[2], toks[3]) else {
                return Err(String::from("inline asm: bad `sys` operands"));
            };
            let mut operands = alloc::vec![AsmOpndA64::SysOp(base)];
            if let Some(reg) = toks.get(4) {
                operands.push(parse_operand(reg)?);
            }
            insns.push(AsmInsnA64 {
                mnemonic: String::from("sys"),
                operands,
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
        }
        // `prfm <prfop>, [Xn{, #off | , Rm}]` prefetches; the prfop name (or a
        // raw #imm5) fills the Rt slot, and the memory operand is parsed as for
        // a load. The encoder scales `prfm`'s immediate offset by 8; `prfum`
        // takes the unscaled signed one.
        if mnem == "prfm" || mnem == "prfum" {
            let toks = split_operands(rest);
            if toks.len() != 2 {
                return Err(format!(
                    "inline asm: `{mnem}` takes a prefetch op and a memory operand"
                ));
            }
            let code = match prfop_code(toks[0]) {
                Some(c) => c as i64,
                None => match parse_operand(toks[0])? {
                    AsmOpndA64::Imm(v) if (0..=31).contains(&v) => v,
                    _ => return Err(format!("inline asm: bad prefetch op `{}`", toks[0])),
                },
            };
            let mem = match parse_operand(toks[1])? {
                // A bare `%N` reference names the base-register form `[xN]`,
                // as `%aN` does: a `Q`/`m` operand holds the object's address
                // in the register the emitter resolves the reference to.
                AsmOpndA64::Ref { idx, .. } => AsmOpndA64::Mem {
                    base: MemBase::Ref(idx),
                    off: 0,
                    pre: false,
                },
                m @ (AsmOpndA64::Mem { .. }
                | AsmOpndA64::MemReg { .. }
                | AsmOpndA64::MemExpr { .. }) => m,
                _ => return Err(format!("inline asm: `{mnem}` needs a memory operand")),
            };
            insns.push(AsmInsnA64 {
                mnemonic: String::from(mnem),
                operands: alloc::vec![AsmOpndA64::Imm(code), mem],
                bytes: Vec::new(),
                label_def: None,
                sym_target: None,
                layout: None,
            });
            continue;
        }
        // A direct `bl` / `b` to a symbol name is a call / tail-branch to a
        // symbol (`bl schedule`); the target is resolved to a rel26 by the fixup
        // pass, not parsed as a register operand. A local-label branch (`b 1f`)
        // starts with a digit, so it is excluded. The name may embed operand
        // references (`bl __get_user_%c0`), which are substituted at emit time,
        // so the text is kept verbatim here.
        if matches!(mnem, "bl" | "b") {
            let is_symbol_target = !rest.is_empty()
                && label_num(rest).is_none()
                && crate::c5::asm::is_asm_symbol_template(rest)
                && parse_reg(rest).is_none();
            if is_symbol_target {
                insns.push(AsmInsnA64 {
                    mnemonic: String::from(mnem),
                    operands: Vec::new(),
                    bytes: Vec::new(),
                    label_def: None,
                    sym_target: Some(String::from(rest)),
                    layout: None,
                });
                continue;
            }
        }
        // A bare `ret` defaults its operand to the link register.
        let rest = if mnem == "ret" && rest.is_empty() {
            "x30"
        } else {
            rest
        };
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in split_operands(rest) {
                // A template label named as an operand is a branch / `adr`
                // target this stream resolves; direction does not apply, a
                // name has one definition. Register names stay registers.
                let tok = op.trim();
                match label_num(tok).filter(|_| parse_reg(tok).is_none()) {
                    Some(num) => operands.push(AsmOpndA64::Label {
                        num,
                        forward: false,
                    }),
                    None => operands.push(parse_operand(op)?),
                }
            }
        }
        insns.push(AsmInsnA64 {
            mnemonic: String::from(mnem),
            operands,
            bytes: Vec::new(),
            label_def: None,
            sym_target: None,
            layout: None,
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
    clobber_regs: u32,
    clobber_fp_regs: u32,
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 32];
    // Fixed constraints (register-asm variables) own their register;
    // assign them before the clobber marks, whose bits include the
    // fixed operands' own registers. Operands may share one register --
    // an input and an output pinned to the same register form a tied
    // pair (the register carries the input value in and the output
    // value out); the front end rejects two outputs on one register.
    for (i, op) in operands.iter().enumerate() {
        if let C::Fixed(r) = op.constraint {
            // A register-asm variable names its own register, which need not
            // be in the allocatable pool; only the emitter's scratch pair is
            // reserved.
            if r > 30 || matches!(r, 16 | 17) {
                return Err(String::from(
                    "inline asm: fixed operand register is not a general register",
                ));
            }
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // A clobbered register is unavailable for an operand: the asm template
    // overwrites it, so an operand placed there would be corrupted.
    for r in 0..32u8 {
        if clobber_regs & (1 << r) != 0 {
            used[r as usize] = true;
        }
    }
    // x0..x15 are the allocatable pool; x16/x17 are the emitter's scratch.
    let pool: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem | C::MemBase) {
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
    for r in 0..32u8 {
        if clobber_fp_regs & (1 << r) != 0 {
            fp_used[r as usize] = true;
        }
    }
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
    // The register-or-immediate class letters are x86-specific and do
    // not occur in AArch64 templates; reject rather than mis-assign.
    for op in operands {
        if matches!(op.constraint, C::RegOrImm(_)) {
            return Err(String::from(
                "inline asm: register-class-letter constraint not supported on AArch64",
            ));
        }
    }
    Ok(assigned)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_location_counter_targets() {
        // `.` alone and with a signed byte offset, decimal or hex.
        for (t, off) in [
            (&b"b ."[..], 0),
            (b"bl . + 4", 4),
            (b"b .+8", 8),
            (b"b . - 4", -4),
            (b"b . + 0x10", 16),
        ] {
            let insns = parse_template(t).unwrap();
            assert_eq!(insns[0].operands, [AsmOpndA64::Here(off)], "{t:?}");
        }
        // A dotted name is an ordinary GNU as symbol, not the location
        // counter: it parses as a symbol branch.
        let insns = parse_template(b"b .foo").unwrap();
        assert_eq!(insns[0].sym_target.as_deref(), Some(".foo"));
        // A bare `ret` defaults to the link register.
        let insns = parse_template(b"ret").unwrap();
        assert_eq!(
            insns[0].operands,
            [AsmOpndA64::Reg {
                num: 30,
                is64: true,
                sp: false
            }]
        );
    }

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
    fn parse_vector_operand_views() {
        // `%N.T`, `%qN`, and the one-register list `{%N.T}`; the
        // `.arch_extension` directive carries no code and is skipped.
        let insns =
            parse_template(b".arch_extension sha3\neor3 %0.16b, %1.16b, %2.16b, %3.16b").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, "eor3");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::RefVec {
                    idx: 0,
                    size: 0,
                    q: true
                },
                AsmOpndA64::RefVec {
                    idx: 1,
                    size: 0,
                    q: true
                },
                AsmOpndA64::RefVec {
                    idx: 2,
                    size: 0,
                    q: true
                },
                AsmOpndA64::RefVec {
                    idx: 3,
                    size: 0,
                    q: true
                },
            ]
        );
        let insns = parse_template(b"ldr %q0, [%1]; tbl %0.16b, {%1.16b}, %2.8b").unwrap();
        assert_eq!(insns[0].operands[0], AsmOpndA64::RefQ(0));
        assert_eq!(
            insns[1].operands[1],
            AsmOpndA64::RefVecList {
                idx: 1,
                size: 0,
                q: true
            }
        );
        assert_eq!(
            insns[1].operands[2],
            AsmOpndA64::RefVec {
                idx: 2,
                size: 0,
                q: false
            }
        );
    }

    #[test]
    fn clobber_names_and_avoidance() {
        use crate::c5::ir::{AsmConstraint as C, AsmOperand};
        // GP names resolve to (false, num); the SIMD/FP views to (true, num).
        assert_eq!(clobber_reg_name("x2"), Some((false, 2)));
        assert_eq!(clobber_reg_name("w9"), Some((false, 9)));
        assert_eq!(clobber_reg_name("d1"), Some((true, 1)));
        assert_eq!(clobber_reg_name("q3"), Some((true, 3)));
        assert_eq!(clobber_reg_name("v5"), Some((true, 5)));
        assert_eq!(clobber_reg_name("h7"), Some((true, 7)));
        assert_eq!(clobber_reg_name("cc"), None);
        let op = |constraint| AsmOperand {
            constraint,
            is_output: false,
            is_rw: false,
            width: 8,
            seg: crate::c5::ir::AsmSeg::None,
        };
        // With x0 and x2 clobbered, three GP operands take x1, x3, x4.
        let gp = [op(C::Reg), op(C::Reg), op(C::Reg)];
        let a = assign_operand_regs(&gp, (1 << 0) | (1 << 2), 0).unwrap();
        assert_eq!(a, [Some(1), Some(3), Some(4)]);
        // An FP (d0) clobber pushes a `w` operand off d0 onto d1.
        let a = assign_operand_regs(&[op(C::Fp)], 0, 1 << 0).unwrap();
        assert_eq!(a, [Some(1)]);
        // No clobbers: the base assignment is unchanged.
        assert_eq!(
            assign_operand_regs(&gp, 0, 0).unwrap(),
            [Some(0), Some(1), Some(2)]
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
                AsmOpndA64::Reg {
                    num: 3,
                    is64: true,
                    sp: false
                },
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
                    is64: false,
                    sp: false,
                },
            ]
        );
    }

    #[test]
    fn parse_stack_pointer_and_operand_groups() {
        // `sp` and `xzr` share register 31 and differ only by spelling.
        let insns = parse_template(b"add x0, sp, x1; add x0, xzr, x1").unwrap();
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::Reg {
                num: 31,
                is64: true,
                sp: true,
            }
        );
        assert_eq!(
            insns[1].operands[1],
            AsmOpndA64::Reg {
                num: 31,
                is64: true,
                sp: false,
            }
        );
        // Trailing shift and extend groups are operands of their own.
        let insns = parse_template(
            b"add x0, x1, x2, lsr #3; add x0, sp, w1, uxtw #2; add x0, x1, x2, lsl #4",
        )
        .unwrap();
        assert_eq!(
            insns[0].operands[3],
            AsmOpndA64::Shift { kind: 1, amount: 3 }
        );
        assert_eq!(
            insns[1].operands[3],
            AsmOpndA64::Extend {
                option: 0b010,
                amount: 2
            }
        );
        assert_eq!(insns[2].operands[3], AsmOpndA64::Lsl(4));
        // An index register is never the stack pointer.
        assert!(parse_template(b"ldr x0, [x1, sp]").is_err());
    }

    #[test]
    fn bare_immediate_operand() {
        // GAS accepts an immediate without `#`; a bare integer literal parses
        // to the same operand as the `#`-prefixed form.
        let insns = parse_template(b"brk 0x800; hlt 0xf000; brk #0x800").unwrap();
        assert_eq!(insns[0].operands, [AsmOpndA64::Imm(0x800)]);
        assert_eq!(insns[1].operands, [AsmOpndA64::Imm(0xf000)]);
        assert_eq!(insns[2].operands, insns[0].operands);
        // A trailing `b`/`f` is still a local-label reference, not an integer.
        let insns = parse_template(b"b 1f").unwrap();
        assert_eq!(
            insns[0].operands,
            [AsmOpndA64::Label {
                num: 1,
                forward: true
            }]
        );
    }

    #[test]
    fn immediate_literal_radices() {
        // GNU as radix rules: a leading `0` with more digits is octal, `0x`
        // hex, `0b` binary, and a `u`/`l` suffix is dropped.
        let insns =
            parse_template(b"brk #010; brk #10; brk #0x10; brk #0b101; brk #0; brk #10L").unwrap();
        let imm = |i: usize| insns[i].operands[0].clone();
        assert_eq!(imm(0), AsmOpndA64::Imm(8));
        assert_eq!(imm(1), AsmOpndA64::Imm(10));
        assert_eq!(imm(2), AsmOpndA64::Imm(16));
        assert_eq!(imm(3), AsmOpndA64::Imm(5));
        assert_eq!(imm(4), AsmOpndA64::Imm(0));
        assert_eq!(imm(5), AsmOpndA64::Imm(10));
        // Signs and constant expressions still fold.
        let insns = parse_template(b"movz x0, #(1 << 4); brk #-010 + 010").unwrap();
        assert_eq!(insns[0].operands[1], AsmOpndA64::Imm(16));
        assert_eq!(insns[1].operands[0], AsmOpndA64::Imm(0));
    }

    #[test]
    fn barrier_encodings() {
        // Every dmb/dsb domain option, isb, and clrex encode to their
        // constant words. Expected words from
        // `clang --target=aarch64-unknown-linux-gnu`.
        #[rustfmt::skip]
        let cases: &[(&[u8], u32)] = &[
            (b"dmb sy",    0xd5033fbf), (b"dmb ish",   0xd5033bbf),
            (b"dmb ishld", 0xd50339bf), (b"dmb ishst", 0xd5033abf),
            (b"dmb osh",   0xd50333bf), (b"dmb oshld", 0xd50331bf),
            (b"dmb oshst", 0xd50332bf), (b"dmb nsh",   0xd50337bf),
            (b"dmb nshld", 0xd50335bf), (b"dmb nshst", 0xd50336bf),
            (b"dmb ld",    0xd5033dbf), (b"dmb st",    0xd5033ebf),
            (b"dmb",       0xd5033fbf),
            (b"dsb sy",    0xd5033f9f), (b"dsb ish",   0xd5033b9f),
            (b"dsb ishst", 0xd5033a9f), (b"dsb ld",    0xd5033d9f),
            (b"dsb st",    0xd5033e9f),
            (b"isb",       0xd5033fdf), (b"isb sy",    0xd5033fdf),
            (b"clrex",     0xd5033f5f), (b"clrex #7",  0xd503375f),
        ];
        for (tmpl, want) in cases {
            let insns = parse_template(tmpl).unwrap();
            assert_eq!(insns.len(), 1);
            assert_eq!(
                insns[0].bytes,
                want.to_le_bytes(),
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
        // An unknown option and an isb domain option are rejected.
        assert!(parse_template(b"dmb full").is_err());
        assert!(parse_template(b"isb ish").is_err());
    }

    #[test]
    fn parse_layout_directives_in_stream() {
        use crate::c5::asm::AsmSectionItem as I;
        use crate::c5::asm::{AlignFill, AlignSpec};
        // `.align` takes a power-of-two exponent on AArch64, and the `w` / `l`
        // spellings widen the fill unit without changing that convention; the
        // fill family and `.org` carry their operands to the emitter
        // unevaluated.
        let align = |n: u32, fill, max| I::Align {
            spec: AlignSpec::Bytes(n),
            fill,
            max,
            nops: crate::c5::asm::AlignNops::A64,
        };
        let fill = |value: u32, width: u8| Some(AlignFill { value, width });
        let cases: &[(&[u8], I)] = &[
            (b".balign 16", align(16, None, None)),
            (b".balign 16, 0xff, 3", align(16, fill(0xff, 1), Some(3))),
            (b".align 4", align(16, None, None)),
            (b".p2align 3", align(8, None, None)),
            (
                b".p2alignl 3, 0x12345678",
                align(8, fill(0x12345678, 4), None),
            ),
            (
                b".balignw 16, 0x1234, 3",
                align(16, fill(0x1234, 2), Some(3)),
            ),
            // A zero alignment is an alignment of one, as GNU as reads it.
            (b".align 0", align(1, None, None)),
            (b".balign 0", align(1, None, None)),
            (
                b".skip 8",
                I::Fill {
                    count: String::from("8"),
                    unit: 1,
                    value: 0,
                },
            ),
            (
                b".fill 3, 4, 9",
                I::Fill {
                    count: String::from("3"),
                    unit: 4,
                    value: 9,
                },
            ),
            (b".org 16", I::Org(16, 0)),
            (
                b".org 1b + 4, 0xcc",
                I::OrgLabel {
                    label: String::from("1b"),
                    addend: String::from("4"),
                    fill: 0xcc,
                },
            ),
        ];
        for (tmpl, want) in cases {
            let insns = parse_template(tmpl).unwrap();
            assert_eq!(insns.len(), 1);
            assert_eq!(
                insns[0].layout.as_ref(),
                Some(want),
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
        // An operand over labels is kept for the emitter to settle where the
        // directive stands.
        let insns = parse_template(b"nop\n\t1:\n\t.align 1b-.").unwrap();
        assert!(matches!(
            insns.last().unwrap().layout,
            Some(I::Align {
                spec: AlignSpec::Expr { pow2: true, .. },
                ..
            })
        ));
        assert!(parse_template(b".balign 3").is_err());
        // GNU as has no `.alignw` / `.alignl`, so neither is a layout
        // directive and the encoder rejects the mnemonic.
        for tmpl in [b".alignl 8".as_slice(), b".alignw 8".as_slice()] {
            assert!(parse_template(tmpl).unwrap()[0].layout.is_none());
        }
    }

    #[test]
    fn parse_raw_piece_in_stream() {
        // A data directive of constants keeps its keyword, which classifies
        // its bytes as data; a bare machine-byte run carries none and stays
        // code.
        let insns = parse_template(b".byte 0x1f, 0x20, 0x03, 0xd5; add %0, %0, %1").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].bytes, [0x1f, 0x20, 0x03, 0xd5]);
        assert_eq!(insns[0].mnemonic, ".byte");
        assert_eq!(insns[1].mnemonic, "add");
        let raw = parse_template(b"1f 20 03 d5").unwrap();
        assert_eq!(raw.len(), 1);
        assert!(raw[0].mnemonic.is_empty());
    }

    #[test]
    fn parse_mov_stack_pointer_rewrite() {
        // `mov Rd, sp` / `mov sp, Rn` become `add ..., #0`; a register move
        // stays `mov`. The rewritten operand keeps the `sp` spelling, which is
        // what makes the encoder read register 31 as the stack pointer.
        let insns = parse_template(b"mov x0, sp; mov sp, x1; mov x2, x3").unwrap();
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg {
                    num: 0,
                    is64: true,
                    sp: false
                },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: true,
                    sp: true,
                },
                AsmOpndA64::Imm(0),
            ]
        );
        assert_eq!(insns[1].mnemonic, "add");
        assert_eq!(
            insns[1].operands[0],
            AsmOpndA64::Reg {
                num: 31,
                is64: true,
                sp: true,
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
                AsmOpndA64::Reg {
                    num: 3,
                    is64: true,
                    sp: false
                },
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
        // CTR_EL0 field 0xD801 (op0=3 sets bit 15), cross-checked against the
        // pattern-matched encoding elsewhere; `s3_3_c14_c0_2` names CNTVCT_EL0.
        assert_eq!(sysreg_field("ctr_el0"), Some(0xD801));
        assert_eq!(sysreg_field("s3_3_c0_c0_1"), Some(0xD801)); // == ctr_el0
        assert_eq!(sysreg_field("s3_3_c14_c0_2"), Some(0xDF02)); // cntvct_el0
        // Generic-timer registers (verified byte-identical to the assembler).
        assert_eq!(sysreg_field("cntv_ctl_el0"), Some(0xDF19));
        assert_eq!(sysreg_field("cntv_tval_el0"), Some(0xDF18));
        assert_eq!(sysreg_field("cntvct_el0"), Some(0xDF02));
        assert_eq!(sysreg_field("cntp_ctl_el0"), Some(0xDF11));
        assert_eq!(sysreg_field("tpidr_el1"), Some(0xC684)); // per-CPU pointer
        assert_eq!(sysreg_field("fpcr"), Some(0xDA20));
        assert_eq!(sysreg_field("tpidrro_el0"), Some(0xDE83));
        assert_eq!(sysreg_field("ttbr0_el1"), Some(0xC100));
        // Register names are case-insensitive.
        assert_eq!(sysreg_field("CurrentEL"), sysreg_field("currentel"));
        assert_eq!(sysreg_field("CNTV_CTL_EL0"), Some(0xDF19));
        assert_eq!(sysreg_field("not_a_reg"), None);
        let insns = parse_template(b"mrs %0, ctr_el0; msr nzcv, %1").unwrap();
        assert_eq!(insns[0].mnemonic, "mrs");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::SysReg(0xD801)
            ]
        );
        assert_eq!(insns[1].mnemonic, "msr");
        assert!(matches!(insns[1].operands[0], AsmOpndA64::SysReg(_)));
    }

    #[test]
    fn parse_sysreg_el_transition_names() {
        // Thread/EL-transition and EL1/EL2 control registers named directly
        // rather than by the generic `sN_N_cN_cN_N` spelling. Every field is
        // byte-verified: `mrs x0, NAME` assembled by clang equals the word our
        // encoder builds from the field. midr_el1 is the regression guard.
        assert_eq!(sysreg_field("midr_el1"), Some(0xC000));
        for (name, field) in [
            ("sp_el0", 0xC208),
            ("sp_el1", 0xE208),
            ("sp_el2", 0xF208),
            ("elr_el2", 0xE201),
            ("elr_el3", 0xF201),
            ("spsr_el2", 0xE200),
            ("spsr_el3", 0xF200),
            ("tpidr_el2", 0xE682),
            ("vbar_el2", 0xE600),
            ("vbar_el3", 0xF600),
            ("cpacr_el1", 0xC082),
            ("sctlr_el2", 0xE080),
            ("hcr_el2", 0xE088),
            ("cptr_el2", 0xE08A),
            ("tcr_el2", 0xE102),
            ("ttbr0_el2", 0xE100),
            ("mair_el2", 0xE510),
            ("esr_el2", 0xE290),
            ("far_el2", 0xE300),
        ] {
            assert_eq!(sysreg_field(name), Some(field), "{name}");
            // Case-insensitive, and the named form equals its generic spelling.
            assert_eq!(sysreg_field(&name.to_ascii_uppercase()), Some(field));
        }
        // The generic spelling s3_0_c4_c1_0 names the same register as sp_el0.
        assert_eq!(sysreg_field("s3_0_c4_c1_0"), sysreg_field("sp_el0"));
        let insns = parse_template(b"mrs %0, sp_el0").unwrap();
        assert_eq!(insns[0].operands[1], AsmOpndA64::SysReg(0xC208));
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
        // A bare `%N` reference names the base-register form `[xN]`, as `%aN`
        // does; the LL/SC atomics spell their `+Q` operand this way.
        let bare = parse_template(b"prfm pstl1strm, %2").unwrap();
        assert_eq!(
            bare[0].operands[1],
            AsmOpndA64::Mem {
                base: MemBase::Ref(2),
                off: 0,
                pre: false,
            }
        );
        // A bad prefetch op and a register (non-memory) operand are rejected.
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
        // The FP operand view modifiers `%dN` / `%sN` ride the is64 flag (d = 64,
        // s = 32) like the GP `%xN` / `%wN`; the emitter resolves it per file.
        let refs = parse_template(b"fmov %d0, %s1").unwrap();
        assert_eq!(
            refs[0].operands,
            [
                AsmOpndA64::Ref {
                    idx: 0,
                    is64: Some(true)
                },
                AsmOpndA64::Ref {
                    idx: 1,
                    is64: Some(false)
                },
            ]
        );
        let insns = parse_template(b"fmov x0, d1; fmov s2, w3").unwrap();
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg {
                    num: 0,
                    is64: true,
                    sp: false
                },
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
                    is64: false,
                    sp: false,
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
                    is64: false,
                    sp: false,
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
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::Reg {
                num: 0,
                is64: true,
                sp: false
            }
        );
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
    fn sysreg_named_and_indexed_families() {
        // Fields whose `mrs x0, NAME`/`mrs x1, NAME`/`mrs x2, NAME` words,
        // assembled by clang, equal `0xD5200000 | field<<5 | Rt`.
        for (name, field) in [
            ("clidr_el1", 0xC801),        // mrs x0 -> 0xD5390020
            ("mdscr_el1", 0x8012),        // mrs x1 -> 0xD5300241
            ("id_aa64mmfr1_el1", 0xC039), // mrs x2 -> 0xD5380722
            ("osdlr_el1", 0x809C),        // mrs x0 -> 0xD5301380
            ("pmccntr_el0", 0xDCE8),      // mrs x1 -> 0xD53B9D01
            ("oslar_el1", 0x8084),        // msr x0 -> 0xD5101080
            ("id_aa64dfr0_el1", 0xC028),  // mrs x0 -> 0xD5380500
            ("pmccfiltr_el0", 0xDF7F),    // mrs x0 -> 0xD53BEFE0
            ("pmceid0_el0", 0xDCE6),      // mrs x0 -> 0xD53B9CC0
            ("pmceid1_el0", 0xDCE7),      // mrs x0 -> 0xD53B9CE0
            ("pmcntenclr_el0", 0xDCE2),   // mrs x0 -> 0xD53B9C40
            ("pmcntenset_el0", 0xDCE1),   // mrs x0 -> 0xD53B9C20
            ("pmcr_el0", 0xDCE0),         // mrs x0 -> 0xD53B9C00
            ("pmintenclr_el1", 0xC4F2),   // mrs x0 -> 0xD5389E40
            ("pmintenset_el1", 0xC4F1),   // mrs x0 -> 0xD5389E20
            ("pmovsclr_el0", 0xDCE3),     // mrs x0 -> 0xD53B9C60
            ("pmselr_el0", 0xDCE5),       // mrs x0 -> 0xD53B9CA0
            ("pmuserenr_el0", 0xDCF0),    // mrs x0 -> 0xD53B9E00
            // Debug breakpoint/watchpoint families, index in CRm (0 and 15).
            ("dbgbvr0_el1", 0x8004),
            ("dbgbvr15_el1", 0x807C),
            ("dbgbcr0_el1", 0x8005),
            ("dbgbcr15_el1", 0x807D),
            ("dbgwvr0_el1", 0x8006),
            ("dbgwcr15_el1", 0x807F),
            // Performance-monitor counters, index split CRm/op2 (0 and 30).
            ("pmevcntr0_el0", 0xDF40),
            ("pmevcntr30_el0", 0xDF5E),
            ("pmevtyper0_el0", 0xDF60),
            ("pmevtyper30_el0", 0xDF7E),
        ] {
            assert_eq!(sysreg_field(name), Some(field), "{name}");
            assert_eq!(sysreg_field(&name.to_ascii_uppercase()), Some(field));
        }
        // Out-of-range indices are not registers.
        assert_eq!(sysreg_field("dbgbvr16_el1"), None);
        assert_eq!(sysreg_field("pmevcntr31_el0"), None);
        // The generic S-form reaches op0 0/1 (mrs x0, s0_3_c1_c0_1 -> 0xD5231020).
        assert_eq!(sysreg_field("s0_3_c1_c0_1"), Some(0x1881));
        assert_eq!(sysreg_field("S0_3_C1_C0_1"), Some(0x1881));
    }

    #[test]
    fn sysreg_and_sysop_tables_cover_the_architecture() {
        // Rows the generated tables add over the earlier hand-written set,
        // each verified byte-identical to the reference assembler
        // (`mrs x0, NAME` = 0xD5200000 | field<<5, and a `sys` alias word =
        // 0xD5080000 | op1<<16 | CRn<<12 | CRm<<8 | op2<<5).
        for (name, field) in [
            ("id_aa64mmfr0_el1", 0xC038u16), // mrs x0 -> 0xD5380700
            ("spsel", 0xC210),               // mrs x1 -> 0xD5384201
            ("mdccint_el1", 0x8010),         // mrs x2 -> 0xD5300202
            ("cntvoff_el2", 0xE703),         // msr    <- 0xD51CE063
            ("vtcr_el2", 0xE10A),            // msr    <- 0xD51C2144
            ("spsr_und", 0xE21A),            // mrs x5 -> 0xD53C4345
            ("fpexc32_el2", 0xE298),         // mrs x6 -> 0xD53C5306
            ("vmpidr_el2", 0xE005),          // mrs x7 -> 0xD53C00A7
            ("dbgauthstatus_el1", 0x83F6),   // mrs x8 -> 0xD5307EC8
        ] {
            assert_eq!(sysreg_field(name), Some(field), "{name}");
            assert_eq!(
                sysreg_field(&name.to_ascii_uppercase()),
                Some(field),
                "{name}"
            );
        }
        // The TLBI range operations and the newer address-translation ops,
        // whose CRm is not the 8 the earlier `at` path assumed.
        for (mnem, op, word) in [
            ("tlbi", "rvale1is", 0xD50882A0u32), // tlbi rvale1is, x0
            ("tlbi", "rvae1is", 0xD5088220),
            ("tlbi", "vae2is", 0xD50C8320),
            ("at", "s1e1a", 0xD5087940),
            ("dc", "cigdvac", 0xD50B7EA0),
            ("ic", "ivau", 0xD50B7520),
        ] {
            assert_eq!(sysop_base(mnem, op), Some(word), "{mnem} {op}");
            assert_eq!(
                sysop_base(mnem, &op.to_ascii_uppercase()),
                Some(word),
                "{mnem} {op}"
            );
        }
        assert_eq!(sysop_base("tlbi", "not_an_op"), None);
        // A name that is both a PSTATE field and a system register takes the
        // immediate encoding only for the immediate form: `msr SPSel, #0` is
        // 0xD500409F, `msr SPSel, x0` is 0xD5184200.
        let insns = parse_template(b"msr spsel, #0; msr spsel, x0").unwrap();
        assert_eq!(insns[0].bytes, 0xD500_40BFu32.to_le_bytes());
        assert_eq!(insns[1].mnemonic, "msr");
        assert_eq!(insns[1].operands[0], AsmOpndA64::SysReg(0xC210));
    }

    #[test]
    fn generated_name_tables_are_sorted() {
        // The lookups binary-search these; the generator emits them sorted.
        use super::super::sysreg_a64_table as t;
        for (what, rows) in [
            ("SYSREGS", t::SYSREGS),
            ("DC_OPS", t::DC_OPS),
            ("IC_OPS", t::IC_OPS),
            ("AT_OPS", t::AT_OPS),
            ("TLBI_OPS", t::TLBI_OPS),
        ] {
            assert!(
                rows.windows(2).all(|w| w[0].0 < w[1].0),
                "{what} not sorted"
            );
            assert!(
                rows.iter().all(|&(n, _)| n
                    .bytes()
                    .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')),
                "{what} holds a name the case-insensitive lookup cannot match"
            );
        }
    }

    #[test]
    fn shift_and_immediate_accept_gas_spellings() {
        // GAS makes `#` optional on a shift amount, and an immediate is a
        // constant expression, not just a literal.
        let insns = parse_template(b"add x0, x0, #0, lsl 12; add x1, x1, #(1 << 16)").unwrap();
        assert_eq!(insns[0].operands[3], AsmOpndA64::Lsl(12));
        assert_eq!(insns[1].operands[2], AsmOpndA64::Imm(1 << 16));
        let insns = parse_template(b"eor x0, x1, x2, ror 16; lsr x3, x4, 5").unwrap();
        assert_eq!(
            insns[0].operands[3],
            AsmOpndA64::Shift {
                kind: 3,
                amount: 16
            }
        );
        assert_eq!(insns[1].operands[2], AsmOpndA64::Imm(5));
        // A non-constant shift is still rejected.
        assert!(parse_template(b"add x0, x0, #0, lsl foo").is_err());
    }

    #[test]
    fn parse_at_and_sys_operands() {
        // `at <op>, Xt` and the generic `sys #op1, cN, cM, #op2{, Xt}` build the
        // same base word the reference assembler emits (Rt folded by the encoder).
        // `at s1e1r, x0` -> 0xD5087800; `sys #3, c7, c10, #1, x0` -> 0xD50B7A20.
        let insns = parse_template(
            b"at s1e1r, %0; at s1e3r, x1; sys #3, c7, c10, #1, %0; sys 0, c7, c6, 1",
        )
        .unwrap();
        assert_eq!(insns[0].mnemonic, "at");
        assert_eq!(insns[0].operands[0], AsmOpndA64::SysOp(0xD508_7800));
        assert!(matches!(
            insns[0].operands[1],
            AsmOpndA64::Ref { idx: 0, .. }
        ));
        assert_eq!(insns[1].operands[0], AsmOpndA64::SysOp(0xD50E_7800));
        assert_eq!(insns[2].mnemonic, "sys");
        assert_eq!(insns[2].operands[0], AsmOpndA64::SysOp(0xD50B_7A20));
        assert!(matches!(
            insns[2].operands[1],
            AsmOpndA64::Ref { idx: 0, .. }
        ));
        // Bare (no `#`) immediates accepted; a missing register leaves op only.
        assert_eq!(insns[3].operands, [AsmOpndA64::SysOp(0xD508_7620)]);
        // Malformed operands are rejected.
        assert!(parse_template(b"at bogus, x0").is_err());
        assert!(parse_template(b"sys #3, x7, c10, #1").is_err());
        assert!(parse_template(b"sys #3, c7, c10").is_err());
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
                AsmOpndA64::Reg {
                    num: 0,
                    is64: true,
                    sp: false
                },
                AsmOpndA64::Reg {
                    num: 1,
                    is64: true,
                    sp: false
                },
                AsmOpndA64::Reg {
                    num: 1,
                    is64: true,
                    sp: false
                },
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

    #[test]
    fn parse_named_labels() {
        use crate::c5::asm::NAMED_LABEL_BASE;
        // A name interns in definition order; a branch to one resolves to the
        // template label, not to a symbol. Two definitions may share a line,
        // and a spelling that collides with a mnemonic is still a label.
        let insns = parse_template(b"lp: nop\n\tb lp\n\ta: nop: nop\n\tcbz %0, nop").unwrap();
        assert_eq!(insns[0].label_def, Some(NAMED_LABEL_BASE));
        assert_eq!(insns[1].mnemonic, "nop");
        assert_eq!(insns[2].mnemonic, "b");
        assert_eq!(insns[2].sym_target, None);
        assert_eq!(
            insns[2].operands[0],
            AsmOpndA64::Label {
                num: NAMED_LABEL_BASE,
                forward: false
            }
        );
        assert_eq!(insns[3].label_def, Some(NAMED_LABEL_BASE + 1));
        assert_eq!(insns[4].label_def, Some(NAMED_LABEL_BASE + 2));
        assert_eq!(
            insns[6].operands[1],
            AsmOpndA64::Label {
                num: NAMED_LABEL_BASE + 2,
                forward: false
            }
        );
        // A name the template does not define stays a symbol branch.
        let insns = parse_template(b"b schedule").unwrap();
        assert_eq!(insns[0].sym_target.as_deref(), Some("schedule"));
    }

    #[test]
    fn parse_rejects_a_duplicate_named_label() {
        // GNU as rejects a second definition of a name; a numeric local may
        // repeat, and each reference binds by direction.
        let err = parse_template(b"dup:\n\tnop\n\tdup:\n\tnop").unwrap_err();
        assert!(err.contains("`dup` is already defined"), "{err}");
        parse_template(b"1:\n\tnop\n\t1:\n\tb 1b").unwrap();
    }

    #[test]
    fn parse_goto_label_reference() {
        let insns = parse_template(b"cbnz %w0, %l1").unwrap();
        assert_eq!(insns[0].mnemonic, "cbnz");
        assert_eq!(insns[0].operands[1], AsmOpndA64::GotoLabel(1));
    }

    #[test]
    fn assign_mem_base_operands() {
        use crate::c5::ir::{AsmConstraint as C, AsmOperand};
        let op = |constraint, is_output, is_rw| AsmOperand {
            constraint,
            is_output,
            is_rw,
            width: 4,
            seg: crate::c5::ir::AsmSeg::None,
        };
        // The LL/SC operand shape `=&r, =&r, +Q, r`: the `Q` operand takes a
        // pool register for its address, like `m`.
        let ops = [
            op(C::Reg, true, false),
            op(C::Reg, true, false),
            op(C::MemBase, true, true),
            op(C::Reg, false, false),
        ];
        assert_eq!(
            assign_operand_regs(&ops, 0, 0).unwrap(),
            [Some(0), Some(1), Some(2), Some(3)]
        );
    }

    #[test]
    fn assign_honors_fixed_registers() {
        use crate::c5::ir::{AsmConstraint, AsmOperand};
        let op = |constraint, is_output| AsmOperand {
            constraint,
            is_output,
            is_rw: false,
            width: 8,
            seg: crate::c5::ir::AsmSeg::None,
        };
        // A register-asm operand keeps its register; the pool operand
        // avoids it.
        let ops = [
            op(AsmConstraint::Fixed(9), false),
            op(AsmConstraint::Reg, false),
        ];
        let assigned = assign_operand_regs(&ops, 0, 0).unwrap();
        assert_eq!(assigned[0], Some(9));
        assert_ne!(assigned[1], Some(9));
        // An output and an input pinned to one register share it: the
        // register carries the input value in and the output value out.
        let pair = [
            op(AsmConstraint::Fixed(0), true),
            op(AsmConstraint::Fixed(0), false),
        ];
        assert_eq!(
            assign_operand_regs(&pair, 0, 0).unwrap(),
            [Some(0), Some(0)]
        );
        // x16/x17 (emit scratch) and beyond are rejected.
        let hi = [op(AsmConstraint::Fixed(16), false)];
        assert!(assign_operand_regs(&hi, 0, 0).is_err());
    }
}
