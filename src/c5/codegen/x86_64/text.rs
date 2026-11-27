//! The text of x86-64 instructions for the assembly listing: AT&T syntax in
//! LLVM's spelling, which GNU as reads. Immediates and displacements print
//! in hex; a general-purpose instruction carries its operand-size suffix.

use alloc::format;
use alloc::string::String;

use super::encode::Cc;
use super::table::{Mnem, Opnd};
pub(crate) use crate::c5::codegen::listing::{Operand, Text};

const R64: [&str; 16] = [
    "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13",
    "r14", "r15",
];
const R32: [&str; 16] = [
    "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d", "r12d",
    "r13d", "r14d", "r15d",
];
const R16: [&str; 16] = [
    "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w", "r13w",
    "r14w", "r15w",
];
const R8: [&str; 16] = [
    "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
    "r13b", "r14b", "r15b",
];
const HIGH_BYTE: [&str; 4] = ["ah", "ch", "dh", "bh"];

/// `%reg` of general-purpose register `num` at `width` bytes.
pub(crate) fn gpr(num: u8, width: u8) -> String {
    let n = usize::from(num & 15);
    let name = match width {
        8 => R64[n],
        4 => R32[n],
        2 => R16[n],
        _ => R8[n],
    };
    format!("%{name}")
}

/// `%xmmN`, `%ymmN` or `%zmmN` for a vector register of `bytes` bytes.
pub(crate) fn vreg(num: u8, bytes: u8) -> String {
    match bytes {
        32 => format!("%ymm{num}"),
        64 => format!("%zmm{num}"),
        _ => format!("%xmm{num}"),
    }
}

/// `%xmmN`.
pub(crate) fn xmm(num: u8) -> String {
    vreg(num, 16)
}

/// A signed value in hex: `0x10`, `-0x8`.
pub(crate) fn hex(v: i64) -> String {
    if v < 0 {
        format!("-{:#x}", v.unsigned_abs())
    } else {
        format!("{v:#x}")
    }
}

/// An immediate operand: `$0x10`, `$-0x8`.
pub(crate) fn imm(v: i64) -> String {
    format!("${}", hex(v))
}

/// The AT&T operand-size suffix of a `width`-byte operation.
pub(crate) fn suffix(width: u8) -> char {
    match width {
        8 => 'q',
        4 => 'l',
        2 => 'w',
        _ => 'b',
    }
}

/// The condition-code part of a `jcc` / `setcc` / `cmovcc` mnemonic.
pub(crate) fn cc(cc: Cc) -> &'static str {
    match cc {
        Cc::O => "o",
        Cc::No => "no",
        Cc::B => "b",
        Cc::Ae => "ae",
        Cc::E => "e",
        Cc::Ne => "ne",
        Cc::Be => "be",
        Cc::A => "a",
        Cc::S => "s",
        Cc::Ns => "ns",
        Cc::P => "p",
        Cc::Np => "np",
        Cc::L => "l",
        Cc::Ge => "ge",
        Cc::Le => "le",
        Cc::G => "g",
    }
}

/// An assembler operand: a register by its range of the assembler's
/// numbering, memory, or an immediate.
pub(crate) fn concrete(c: super::asm::Concrete) -> String {
    use super::asm::{Concrete, MASK_BASE, XMM_BASE, YMM_BASE, ZMM_BASE};
    use crate::c5::ir::AsmRegSize;
    let width = |size: AsmRegSize| match size {
        AsmRegSize::Byte => 1,
        AsmRegSize::Word => 2,
        AsmRegSize::Long => 4,
        AsmRegSize::Quad => 8,
    };
    match c {
        Concrete::Reg { reg, size } => match reg {
            0..16 => gpr(reg, width(size)),
            16..24 => format!("%mm{}", reg - 16),
            24..40 => format!("%cr{}", reg - 24),
            40..48 => format!("%db{}", reg - 40),
            48..54 => format!(
                "%{}",
                ["es", "cs", "ss", "ds", "fs", "gs"][usize::from(reg - 48)]
            ),
            r if (XMM_BASE..YMM_BASE).contains(&r) => format!("%xmm{}", r - XMM_BASE),
            r if (YMM_BASE..128).contains(&r) => format!("%ymm{}", r - YMM_BASE),
            128 => String::from("%st"),
            129..136 => format!("%st({})", reg - 128),
            r if (ZMM_BASE..MASK_BASE).contains(&r) => format!("%zmm{}", r - ZMM_BASE),
            r => format!("%k{}", r - MASK_BASE),
        },
        Concrete::HighReg(n) => format!("%{}", HIGH_BYTE[usize::from(n.wrapping_sub(4) & 3)]),
        Concrete::Mem {
            base,
            index,
            scale,
            disp,
            ..
        } => mem(Some(base), index, scale, disp),
        Concrete::AbsMem { disp, .. } => hex(i64::from(disp)),
        Concrete::IndexMem {
            index, scale, disp, ..
        } => mem(None, Some(index), scale, disp),
        Concrete::RipRel { disp, .. } => format!("{}(%rip)", hex(i64::from(disp))),
        Concrete::Imm(v) => imm(v),
    }
}

/// `name` with AT&T-order assembler operands `ops`.
pub(crate) fn att(name: &str, ops: &[super::asm::Concrete]) -> String {
    use super::asm::Concrete;
    const PREDICATES: [&str; 32] = [
        "eq", "lt", "le", "unord", "neq", "nlt", "nle", "ord", "eq_uq", "nge", "ngt", "false",
        "neq_oq", "ge", "gt", "true", "eq_os", "lt_oq", "le_oq", "unord_s", "neq_us", "nlt_uq",
        "nle_uq", "ord_s", "eq_us", "nge_uq", "ngt_uq", "false_os", "neq_os", "ge_oq", "gt_oq",
        "true_us",
    ];
    // A compare's predicate immediate reads as the mnemonic it names.
    let (v, rest) = match name.strip_prefix('v') {
        Some(rest) => ("v", rest),
        None => ("", name),
    };
    if let Some(kind) = rest.strip_prefix("cmp")
        && matches!(kind, "ps" | "pd" | "ss" | "sd")
        && let Some(&Concrete::Imm(p)) = ops.first()
        && (0..if v.is_empty() { 8 } else { 32 }).contains(&p)
    {
        return att(
            &format!("{v}cmp{}{kind}", PREDICATES[p as usize]),
            &ops[1..],
        );
    }
    // A far or near indirect branch's operand takes AT&T's `*`.
    let indirect = ["call", "jmp", "lcall", "ljmp"]
        .iter()
        .any(|b| name.starts_with(b));
    let mut s = String::from(name);
    for (k, o) in ops.iter().enumerate() {
        s.push_str(if k == 0 { " " } else { ", " });
        if indirect && !matches!(o, Concrete::Imm(_)) {
            s.push('*');
        }
        s.push_str(&concrete(*o));
    }
    s
}

/// A data directive over `bytes` in `width`-byte little-endian units:
/// `.byte`, `.short`, `.long` or `.quad`.
pub(crate) fn data(width: u8, bytes: &[u8]) -> String {
    let mut s = String::from(match width {
        8 => ".quad",
        4 => ".long",
        2 => ".short",
        _ => ".byte",
    });
    for (k, unit) in bytes.chunks(usize::from(width.max(1))).enumerate() {
        s.push_str(if k == 0 { " " } else { ", " });
        let mut v = 0u64;
        for (i, b) in unit.iter().enumerate() {
            v |= u64::from(*b) << (8 * i);
        }
        s.push_str(&format!("{v:#x}"));
    }
    s
}

/// The name of a legacy prefix byte.
pub(crate) fn prefix_name(b: u8) -> &'static str {
    match b {
        0xF0 => "lock",
        0xF2 => "repne",
        0xF3 => "rep",
        0x2E => "cs",
        0x36 => "ss",
        0x3E => "ds",
        0x26 => "es",
        0x64 => "fs",
        0x65 => "gs",
        0x66 => "data16",
        0x67 => "addr32",
        _ => "?",
    }
}

/// A `lock` prefix ahead of the instruction.
pub(crate) fn lock(text: &mut Text, _: u8) {
    text.insert(0, "lock ");
}

/// Segment override `prefix` (`64` fs, `65` gs, ...) on the instruction's
/// memory operand: the first operand with a base, an index or no `$` and
/// no `%`.
pub(crate) fn segment(text: &mut Text, prefix: u8) {
    let seg = match prefix {
        0x26 => "%es:",
        0x2E => "%cs:",
        0x36 => "%ss:",
        0x3E => "%ds:",
        0x64 => "%fs:",
        _ => "%gs:",
    };
    let Some(ops) = text.text.find(' ').map(|i| i + 1) else {
        return;
    };
    let mut at = ops;
    let mut depth = 0;
    let bytes = text.text.as_bytes();
    for i in ops..=bytes.len() {
        match bytes.get(i) {
            Some(b'(') => depth += 1,
            Some(b')') => depth -= 1,
            Some(b',') | None if depth == 0 => {
                let op = text.text[at..i].trim_start();
                let start = i - op.len();
                if op.contains('(') || !(op.starts_with('$') || op.starts_with('%')) {
                    text.insert(start + usize::from(op.starts_with('*')), seg);
                    return;
                }
                at = i + 1;
            }
            _ => {}
        }
    }
}

/// The operation of a scalar or packed SSE arithmetic opcode, the part of
/// its mnemonic ahead of the element type.
pub(crate) fn sse_arith(opcode: u8) -> &'static str {
    match opcode {
        0x51 => "sqrt",
        0x58 => "add",
        0x59 => "mul",
        0x5C => "sub",
        0x5D => "min",
        0x5E => "div",
        0x5F => "max",
        _ => "?",
    }
}

/// The scalar SSE mnemonic of `opcode` on a single (`f32`) or a double,
/// its VEX form under `vex`.
pub(crate) fn sse_scalar(opcode: u8, f32: bool, vex: bool) -> String {
    let v = if vex { "v" } else { "" };
    match (opcode, f32) {
        (0x5A, true) => format!("{v}cvtss2sd"),
        (0x5A, false) => format!("{v}cvtsd2ss"),
        (_, f32) => format!("{v}{}s{}", sse_arith(opcode), if f32 { 's' } else { 'd' }),
    }
}

/// The FMA3 mnemonic of `opcode` (`0F38` map): the operation from the low
/// nibble, the operand order from the high one, scalar for an odd opcode,
/// double precision under `w64`.
pub(crate) fn fma(opcode: u8, w64: bool) -> String {
    let op = match opcode & 0xE {
        0x8 => "madd",
        0xA => "msub",
        0xC => "nmadd",
        _ => "nmsub",
    };
    let order = match opcode >> 4 {
        0x9 => "132",
        0xA => "213",
        _ => "231",
    };
    let kind = if opcode & 1 == 1 { 's' } else { 'p' };
    format!("vf{op}{order}{kind}{}", if w64 { 'd' } else { 's' })
}

/// `disp(%base,%index,scale)`; a zero displacement and a unit scale are
/// left out.
pub(crate) fn mem(base: Option<u8>, index: Option<u8>, scale: u8, disp: i32) -> String {
    let mut s = if disp != 0 || (base.is_none() && index.is_none()) {
        hex(i64::from(disp))
    } else {
        String::new()
    };
    s.push('(');
    if let Some(b) = base {
        s.push_str(&gpr(b, 8));
    }
    if let Some(i) = index {
        s.push(',');
        s.push_str(&gpr(i, 8));
        if scale != 1 {
            s.push_str(&format!(",{scale}"));
        }
    }
    s.push(')');
    s
}

/// `disp(%base)`.
pub(crate) fn mem_at(base: u8, disp: i32) -> String {
    mem(Some(base), None, 1, disp)
}

/// A catalog operand. A RIP-relative or base-less indexed memory operand's
/// displacement is the operand slot, returned with its text split around it.
fn opnd(o: Opnd, slotted: bool) -> (String, Option<String>) {
    match o {
        Opnd::Reg { num, width } => (gpr(num, width), None),
        Opnd::HighByteReg(n) => (
            format!("%{}", HIGH_BYTE[usize::from(n.wrapping_sub(4) & 3)]),
            None,
        ),
        Opnd::Mem {
            base,
            index,
            scale,
            disp,
            ..
        } => (mem(Some(base), index, scale, disp), None),
        Opnd::AbsMem { disp, .. } => (hex(i64::from(disp)), None),
        Opnd::RipRel { disp, .. } if !slotted => (format!("{}(%rip)", hex(disp.into())), None),
        Opnd::RipRel { .. } => (String::new(), Some(String::from("(%rip)"))),
        Opnd::IndexMem {
            index, scale, disp, ..
        } if !slotted => (mem(None, Some(index), scale, disp), None),
        Opnd::IndexMem { index, scale, .. } => {
            let tail = if scale == 1 {
                format!("(,{})", gpr(index, 8))
            } else {
                format!("(,{},{scale})", gpr(index, 8))
            };
            (String::new(), Some(tail))
        }
        Opnd::Imm(v) => (imm(v), None),
    }
}

/// The text of catalog instruction `mnem` with Intel-order operands `ops`,
/// `width` its operation width. `field` is the offset of the displacement a
/// RIP-relative or base-less memory operand ends in, which the operand slot
/// names.
pub(crate) fn catalog(mnem: Mnem, width: Option<u8>, ops: &[Opnd], field: Option<u8>) -> Text {
    let name = mnem.name();
    let reg_width = |o: &Opnd| match *o {
        Opnd::Reg { width, .. } => Some(width),
        Opnd::HighByteReg(_) => Some(1),
        _ => None,
    };
    let opw = width.or_else(|| ops.iter().find_map(reg_width));
    let canon = canonical(name);
    let name = canon.as_str();
    let mut mnemonic = String::from(name);
    match name {
        "ret" | "call" | "pushf" | "popf" => mnemonic.push('q'),
        "jmp" if ops.iter().any(|o| !matches!(o, Opnd::Imm(_))) => mnemonic.push('q'),
        "movsx" | "movzx" => {
            let src = ops.get(1).and_then(|o| match *o {
                Opnd::Reg { width, .. } | Opnd::Mem { width, .. } => Some(width),
                Opnd::RipRel { width, .. } | Opnd::IndexMem { width, .. } => Some(width),
                _ => None,
            });
            let dst = ops.first().and_then(reg_width);
            mnemonic = format!(
                "mov{}{}{}",
                &name[3..4],
                suffix(src.unwrap_or(1)),
                suffix(dst.unwrap_or(8))
            );
        }
        "movsxd" => mnemonic = String::from("movslq"),
        _ if no_suffix(name) => {}
        _ => {
            if let Some(w) = opw {
                mnemonic.push(suffix(w));
            }
        }
    }
    // A shift or rotate by one is the `D1` form, whose count is implied.
    let shift_by_one = matches!(
        name,
        "shl" | "sal" | "shr" | "sar" | "rol" | "ror" | "rcl" | "rcr"
    ) && matches!(ops.get(1), Some(Opnd::Imm(1)));
    let ops = if shift_by_one { &ops[..1] } else { ops };
    // An indirect branch's operand takes AT&T's `*`; an exchange reads in
    // the order LLVM prints, the register operand last.
    let indirect = matches!(name, "call" | "jmp");
    let mut head = mnemonic;
    let mut slot = None;
    let order: alloc::vec::Vec<&Opnd> = match name {
        "xchg" if ops.iter().all(|o| matches!(o, Opnd::Reg { .. })) => ops.iter().collect(),
        _ => ops.iter().rev().collect(),
    };
    for (k, o) in order.into_iter().enumerate() {
        head.push_str(if k == 0 { " " } else { ", " });
        if indirect && !matches!(o, Opnd::Imm(_)) {
            head.push('*');
        }
        let (text, tail) = opnd(*o, field.is_some());
        head.push_str(&text);
        if let Some(tail) = tail {
            slot = Some(head.len());
            head.push_str(&tail);
        }
    }
    let rip = ops.iter().any(|o| matches!(o, Opnd::RipRel { .. }));
    match (slot, field) {
        (Some(at), Some(field)) => Text {
            text: head,
            operand: Some((
                at,
                if rip {
                    Operand::PcRel { field, width: 4 }
                } else {
                    Operand::Field { field, width: 4 }
                },
            )),
        },
        _ => Text::from(head),
    }
}

/// The condition-code spellings LLVM prints for the synonyms the catalog
/// also names: `cmovz` reads `cmove`, `setnae` reads `setb`.
fn canonical(name: &str) -> String {
    const SYNONYMS: [(&str, &str); 14] = [
        ("z", "e"),
        ("nz", "ne"),
        ("c", "b"),
        ("nc", "ae"),
        ("nae", "b"),
        ("nb", "ae"),
        ("na", "be"),
        ("nbe", "a"),
        ("nge", "l"),
        ("nl", "ge"),
        ("ng", "le"),
        ("nle", "g"),
        ("pe", "p"),
        ("po", "np"),
    ];
    for prefix in ["cmov", "set", "j"] {
        if let Some(cc) = name.strip_prefix(prefix)
            && let Some((_, c)) = SYNONYMS.iter().find(|(s, _)| *s == cc)
        {
            return format!("{prefix}{c}");
        }
    }
    // The accumulator extensions read in AT&T's spelling.
    String::from(match name {
        "cdqe" => "cltq",
        "cqo" => "cqto",
        "cdq" => "cltd",
        "cwde" => "cwtl",
        "cbw" => "cbtw",
        "cwd" => "cwtd",
        _ => name,
    })
}

/// The text of an instruction the assembler's tables encode as `m`,
/// spelled `name`, with AT&T-order `ops`: a catalog instruction reads as
/// the lowering's own do, another as `name` spells it. `field` is the
/// offset of a RIP-relative displacement.
pub(crate) fn asm_text(
    name: &str,
    m: super::asm::Mnemonic,
    suffix: Option<crate::c5::ir::AsmRegSize>,
    ops: &[super::asm::Concrete],
    field: Option<u8>,
) -> Text {
    let catalog_form = super::asm::to_table(m, suffix, ops)
        .and_then(|(name, w, ops)| Some((Mnem::from_name(name)?, w, ops)));
    let rip = ops
        .iter()
        .find(|o| matches!(o, super::asm::Concrete::RipRel { .. }));
    match (catalog_form, rip.zip(field)) {
        (Some((mnem, w, ops)), _) => catalog(mnem, w, &ops, field),
        // The RIP-relative displacement reads as the field the relocation
        // or the layout fills.
        (None, Some((&rip, field))) => {
            let mut text = att(name, ops);
            let disp = concrete(rip);
            match text.find(&disp) {
                Some(at) => {
                    text.replace_range(at..at + disp.len(), "(%rip)");
                    Text {
                        text,
                        operand: Some((at, Operand::PcRel { field, width: 4 })),
                    }
                }
                None => Text::from(text),
            }
        }
        (None, None) => Text::from(att(name, ops)),
    }
}

/// Mnemonics printed without an operand-size suffix: the operand size is
/// implied or the operation has none.
fn no_suffix(name: &str) -> bool {
    matches!(
        name,
        "cltq"
            | "cqto"
            | "cltd"
            | "cwtl"
            | "cbtw"
            | "cwtd"
            | "cqo"
            | "cdq"
            | "cdqe"
            | "leave"
            | "nop"
            | "pause"
            | "ud2"
            | "int3"
            | "syscall"
            | "endbr64"
            | "lfence"
            | "mfence"
            | "sfence"
            | "rdtsc"
            | "rdtscp"
            | "cpuid"
            | "hlt"
            | "invlpga"
    ) || name.starts_with('j')
        || name.starts_with("set")
}
