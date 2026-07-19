//! GCC extended inline-asm (x86_64): template parsing and instruction
//! encoding.
//!
//! [`parse_template`] turns an AT&T template into a sequence of
//! [`AsmInsn`]s with symbolic operand references (`%N`), explicit
//! registers (`%%reg`), and immediates (`$imm`). The emitter
//! ([`super::emit`]) resolves each reference to a machine register per
//! the operand constraint, builds a [`Concrete`] operand list, and
//! calls [`encode`]. The SSA interpreter reuses the same parse to
//! evaluate the semantics, so both paths agree on operand order and
//! width.
//!
//! [`encode`] routes the general-purpose and system mnemonics through the
//! shared table encoder ([`super::table`]) via [`to_table`], transposing the
//! AT&T (`src, dst`) operands to the table's Intel (`dst, src`) order. What
//! stays here is what the table does not cover: the double-precision shifts,
//! the port I/O and privileged prefix forms, the MMX and control / debug /
//! segment register moves, and the interrupt / stack ops.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::super::ir::AsmRegSize;

/// Base mnemonic of a template instruction (AT&T size suffix folded
/// out into [`AsmInsn::suffix`]).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Mnemonic {
    Shld,
    Shrd,
    Shl,
    Shr,
    Sar,
    Or,
    And,
    Add,
    Sub,
    Xor,
    Mov,
    Bswap,
    Rdtscp,
    Rdtsc,
    Nop,
    /// Port input `in al/ax/eax, dx` (variable-port form). The
    /// accumulator and DX are implicit; the operands' `a`/`d`
    /// constraints tie the values there.
    In,
    /// Port output `out dx, al/ax/eax` (variable-port form).
    Out,
    /// Software interrupt `int $imm` (int3 breakpoint is `int $3`).
    Int,
    /// Spin-loop hint `pause`.
    Pause,
    /// Push the 64-bit RFLAGS, `pushfq`.
    Pushfq,
    /// Pop a 64-bit register, `pop reg`.
    Pop,
    /// `movd` between an MMX / XMM register and a GPR / memory. The MMX form has
    /// no operand-size prefix; the XMM form (an `xmm` operand) adds the 0x66.
    Movd,
    /// An SSE2 two-operand register form `<op> %xmm_src, %xmm_dst` encoded as
    /// `<prefix> [REX] 0F <opcode> /r` with the destination in ModRM.reg and the
    /// source in ModRM.rm (pxor, paddd, pand, ...).
    Sse2Rr {
        prefix: u8,
        opcode: u8,
    },
    /// An SSE move `mov{dqa,dqu,aps,ups,sd,ss}` between xmm and xmm / memory. The
    /// register-register and load (memory-source) forms use `load_op`; the store
    /// (memory-destination) form uses `store_op`. The xmm register is always
    /// ModRM.reg; the other operand is r/m.
    SseMov {
        prefix: u8,
        load_op: u8,
        store_op: u8,
    },
    /// Privileged / model-specific operandless forms (operands, where any,
    /// ride fixed registers via the statement's constraints). `cli` / `sti`
    /// clear / set the interrupt flag; `invd` / `wbinvd` invalidate caches;
    /// `rdmsr` / `wrmsr` / `rdpmc` access MSRs / performance counters;
    /// `monitor` / `mwait` arm the monitor-wait pair.
    Cli,
    Sti,
    Invd,
    Wbinvd,
    Rdmsr,
    Wrmsr,
    Rdpmc,
    Monitor,
    Mwait,
    /// Halt, `hlt`.
    Hlt,
    /// `lock` prefix on its own template line; emits 0xF0 so the following
    /// instruction (in a multi-line block) becomes its locked form.
    Lock,
    /// `xadd r, r/m` (0F C0/C1): exchange-and-add, the atomic primitive of
    /// the interlocked increment / decrement.
    Xadd,
    /// `cmpxchg r, r/m` (0F B0/B1): compare-and-exchange against the
    /// accumulator, the atomic primitive of interlocked compare-exchange.
    Cmpxchg,
    /// `inc r/m` / `dec r/m` (FF /0, /1). The single-byte 0x40+r forms are
    /// REX prefixes in 64-bit mode, so the ModRM forms are always used.
    Inc,
    Dec,
    /// Literal machine bytes, carried in [`AsmInsn::bytes`]. Produced for a
    /// template piece that is a run of hex-byte tokens (`CC; C3; 90`) or a
    /// `.byte` / `.word` / `.long` / `.quad` directive. An escape hatch for
    /// instructions the mnemonic catalogue does not cover; the bytes are
    /// emitted verbatim.
    RawBytes,
    /// A general-purpose / system mnemonic recognized straight from the
    /// catalogue, not one of the bespoke forms above. The string is the
    /// catalogue mnemonic; [`encode`] routes it through the table encoder with
    /// a generic AT&T-to-Intel operand transpose. This is what lets inline asm
    /// reach every instruction the table encodes without a per-mnemonic arm.
    Table(&'static str),
}

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmOpnd {
    /// `%N` / `%<size>N`: operand N of the asm statement, at the named
    /// register-name size (or the operand's own width when unmodified).
    Ref { idx: u8, size: Option<AsmRegSize> },
    /// `%%reg`: an explicit register named in the template.
    Reg { reg: u8, size: AsmRegSize },
    /// `$imm`: a literal immediate.
    Imm(i64),
    /// `Nf` / `Nb`: a local-label reference (label number plus direction --
    /// `f` forward, `b` backward), the target of a `jmp` / `jcc` within the
    /// block. The emitter resolves it to a rel32 against the label definition.
    Label { num: u32, forward: bool },
}

/// One instruction of a parsed template, in AT&T operand order.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsn {
    pub mnemonic: Mnemonic,
    pub suffix: Option<AsmRegSize>,
    pub operands: Vec<AsmOpnd>,
    /// Literal bytes for a [`Mnemonic::RawBytes`] piece; empty otherwise.
    pub bytes: Vec<u8>,
    /// For a direct `call` / `jmp` to a bare identifier (`call schedule`),
    /// the target symbol name; the emitter resolves it to a rel32 through a
    /// relocation. `None` for every other instruction.
    pub sym_target: Option<alloc::string::String>,
    /// A local-label definition `N:` at this point; the emitter records the
    /// code offset it stands at. Such a piece carries no mnemonic operands.
    pub label_def: Option<u32>,
}

/// A resolved operand: a concrete register (with its access size) or an
/// immediate. Produced by the emitter / interpreter from an [`AsmOpnd`]
/// once the operand's register assignment (or constant value) is known.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Concrete {
    Reg {
        reg: u8,
        size: AsmRegSize,
    },
    /// A memory reference `(%base)`: `base` holds the operand's address.
    /// Produced for a memory-constrained (`m`) template operand.
    Mem {
        base: u8,
        size: AsmRegSize,
    },
    Imm(i64),
}

/// Map an AT&T register name (without the `%` prefix) to its
/// architectural number and access size. Covers the 8/16/32/64-bit
/// names for the 16 GPRs.
pub(crate) fn reg_by_name(name: &str) -> Option<(u8, AsmRegSize)> {
    use AsmRegSize::*;
    let n = name;
    // 64-bit.
    let q = [
        "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
        "r13", "r14", "r15",
    ];
    if let Some(i) = q.iter().position(|&r| r == n) {
        return Some((i as u8, Quad));
    }
    // 32-bit.
    let d = [
        "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d",
        "r12d", "r13d", "r14d", "r15d",
    ];
    if let Some(i) = d.iter().position(|&r| r == n) {
        return Some((i as u8, Long));
    }
    // 16-bit.
    let w = [
        "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w",
        "r13w", "r14w", "r15w",
    ];
    if let Some(i) = w.iter().position(|&r| r == n) {
        return Some((i as u8, Word));
    }
    // 8-bit (low byte; REX-form names for rsp/rbp/rsi/rdi).
    let b = [
        "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
        "r13b", "r14b", "r15b",
    ];
    if let Some(i) = b.iter().position(|&r| r == n) {
        return Some((i as u8, Byte));
    }
    // MMX registers mm0..mm7. Marked with register numbers 16..24 so they
    // never collide with the 0..16 GPRs; only `movd` reads them, masking
    // the mark back to the 0..8 ModRM.reg field.
    if let Some(rest) = n.strip_prefix("xmm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 16
    {
        // XMM registers, marked with XMM_BASE so they never collide with the
        // GPRs/MMX; the SSE encode arms mask back to the ModRM field and set
        // REX.R/REX.B for xmm8..15. The size marker is unused (the mnemonic
        // fixes the operation width).
        return Some((XMM_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("mm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 8
    {
        return Some((16 + i, Quad));
    }
    // Control (cr0..cr15) and debug (dr0..dr7) registers, marked with the
    // bases below so they never collide with the GPRs. Only `mov` reads /
    // writes them, masking the mark back to the 0..16 ModRM.reg field. They
    // are inherently 64-bit in long mode.
    if let Some(rest) = n.strip_prefix("cr")
        && let Ok(i) = rest.parse::<u8>()
        && i < 16
    {
        return Some((CR_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("dr")
        && let Ok(i) = rest.parse::<u8>()
        && i < 8
    {
        return Some((DR_BASE + i, Quad));
    }
    // Segment registers, marked with SEG_BASE + the architectural Sreg code
    // (ES=0, CS=1, SS=2, DS=3, FS=4, GS=5) used as the ModRM.reg field of the
    // `mov Sreg, r/m` (8C) / `mov r/m, Sreg` (8E) forms.
    let seg = ["es", "cs", "ss", "ds", "fs", "gs"];
    if let Some(i) = seg.iter().position(|&r| r == n) {
        return Some((SEG_BASE + i as u8, Word));
    }
    None
}

/// The register number a `reg_by_name` result carries for `mm0`; MMX
/// registers occupy `MMX_BASE..MMX_BASE+8`.
const MMX_BASE: u8 = 16;
/// XMM registers occupy `XMM_BASE..XMM_BASE+16`, clear of the GPR/MMX/CR/DR/SEG
/// marks below.
const XMM_BASE: u8 = 64;
/// Control / debug / segment registers occupy the ranges below; each is
/// marked so it never collides with the 0..16 GPRs or the MMX marks.
const CR_BASE: u8 = 24;
const DR_BASE: u8 = 40;
const SEG_BASE: u8 = 48;

/// Assign an x86 register number to each register operand of an
/// extended-asm statement, per its constraint. Returns a vector
/// parallel to `operands`: `Some(reg)` for a register operand, `None`
/// for a pure immediate. Fixed and matching constraints take their
/// required register; `r` operands take free registers from a fixed
/// pool (never r10 / r11, which the emitter reserves as bridge scratch,
/// nor rsp / rbp). Shared by the emitter and the interpreter so both
/// resolve the template's `%N` references to the same registers.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 16];
    // Fixed / register-or-immediate operands take their named register.
    for (i, op) in operands.iter().enumerate() {
        if let C::Fixed(r) | C::RegOrImm(r) = op.constraint {
            assigned[i] = Some(r);
            used[r as usize] = true;
        }
    }
    // `r` operands take free pool registers (rax rbx rcx rdx rsi rdi r8 r9);
    // a memory operand takes one too, to hold its address.
    let pool = [0u8, 3, 1, 2, 6, 7, 8, 9];
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
    // Matching constraints alias the register of the operand they name
    // (an earlier output, already assigned above).
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    Ok(assigned)
}

/// Known base mnemonic for a template token, if any.
fn mnemonic_by_name(name: &str) -> Option<Mnemonic> {
    Some(match name {
        "shld" => Mnemonic::Shld,
        "shrd" => Mnemonic::Shrd,
        "shl" | "sal" => Mnemonic::Shl,
        "shr" => Mnemonic::Shr,
        "sar" => Mnemonic::Sar,
        "or" => Mnemonic::Or,
        "and" => Mnemonic::And,
        "add" => Mnemonic::Add,
        "sub" => Mnemonic::Sub,
        "xor" => Mnemonic::Xor,
        "mov" => Mnemonic::Mov,
        "bswap" => Mnemonic::Bswap,
        "rdtscp" => Mnemonic::Rdtscp,
        "rdtsc" => Mnemonic::Rdtsc,
        "nop" => Mnemonic::Nop,
        "in" => Mnemonic::In,
        "out" => Mnemonic::Out,
        "int" => Mnemonic::Int,
        "pause" => Mnemonic::Pause,
        "pushfq" => Mnemonic::Pushfq,
        "pop" => Mnemonic::Pop,
        "movd" => Mnemonic::Movd,
        "cli" => Mnemonic::Cli,
        "sti" => Mnemonic::Sti,
        "invd" => Mnemonic::Invd,
        "wbinvd" => Mnemonic::Wbinvd,
        "rdmsr" => Mnemonic::Rdmsr,
        "wrmsr" => Mnemonic::Wrmsr,
        "rdpmc" => Mnemonic::Rdpmc,
        "monitor" => Mnemonic::Monitor,
        "mwait" => Mnemonic::Mwait,
        "hlt" => Mnemonic::Hlt,
        "lock" => Mnemonic::Lock,
        "xadd" => Mnemonic::Xadd,
        "cmpxchg" => Mnemonic::Cmpxchg,
        "inc" => Mnemonic::Inc,
        "dec" => Mnemonic::Dec,
        _ => return sse2_op(name).or_else(|| sse_mov(name)),
    })
}

/// SSE2 two-xmm register ops as `(name, mandatory-prefix, 0F-opcode)`; a zero
/// prefix is the no-mandatory-prefix packed-single form. A table rather than a
/// per-op match arm since they all share the `Sse2Rr` encoding. Byte-verified
/// against clang.
fn sse2_op(name: &str) -> Option<Mnemonic> {
    #[rustfmt::skip]
    const OPS: &[(&str, u8, u8)] = &[
        // Integer (0x66 prefix).
        ("pxor", 0x66, 0xEF), ("pand", 0x66, 0xDB), ("por", 0x66, 0xEB), ("pandn", 0x66, 0xDF),
        ("paddb", 0x66, 0xFC), ("paddw", 0x66, 0xFD), ("paddd", 0x66, 0xFE), ("paddq", 0x66, 0xD4),
        ("psubb", 0x66, 0xF8), ("psubw", 0x66, 0xF9), ("psubd", 0x66, 0xFA), ("psubq", 0x66, 0xFB),
        ("pmullw", 0x66, 0xD5), ("pmuludq", 0x66, 0xF4),
        ("pcmpeqb", 0x66, 0x74), ("pcmpeqw", 0x66, 0x75), ("pcmpeqd", 0x66, 0x76), ("pcmpgtd", 0x66, 0x66),
        ("pminub", 0x66, 0xDA), ("pmaxub", 0x66, 0xDE),
        ("punpcklbw", 0x66, 0x60), ("punpcklwd", 0x66, 0x61), ("punpckldq", 0x66, 0x62), ("punpckhdq", 0x66, 0x6A),
        // Scalar double (0xF2) / single (0xF3).
        ("addsd", 0xF2, 0x58), ("subsd", 0xF2, 0x5C), ("mulsd", 0xF2, 0x59), ("divsd", 0xF2, 0x5E),
        ("minsd", 0xF2, 0x5D), ("maxsd", 0xF2, 0x5F), ("sqrtsd", 0xF2, 0x51),
        ("addss", 0xF3, 0x58), ("subss", 0xF3, 0x5C), ("mulss", 0xF3, 0x59), ("divss", 0xF3, 0x5E),
        ("minss", 0xF3, 0x5D), ("maxss", 0xF3, 0x5F), ("sqrtss", 0xF3, 0x51),
        // Packed single (no prefix) / double (0x66).
        ("addps", 0, 0x58), ("subps", 0, 0x5C), ("mulps", 0, 0x59), ("divps", 0, 0x5E),
        ("minps", 0, 0x5D), ("maxps", 0, 0x5F),
        ("andps", 0, 0x54), ("andnps", 0, 0x55), ("orps", 0, 0x56), ("xorps", 0, 0x57),
        ("addpd", 0x66, 0x58), ("subpd", 0x66, 0x5C), ("mulpd", 0x66, 0x59), ("divpd", 0x66, 0x5E),
        ("andpd", 0x66, 0x54), ("orpd", 0x66, 0x56), ("xorpd", 0x66, 0x57),
        ("unpcklpd", 0x66, 0x14), ("unpckhpd", 0x66, 0x15),
    ];
    OPS.iter()
        .find(|(n, _, _)| *n == name)
        .map(|&(_, prefix, opcode)| Mnemonic::Sse2Rr { prefix, opcode })
}

/// SSE move ops as `(name, prefix, load-opcode, store-opcode)`: the register-
/// register and load forms use the load opcode, the store form the store one.
fn sse_mov(name: &str) -> Option<Mnemonic> {
    #[rustfmt::skip]
    const MOVS: &[(&str, u8, u8, u8)] = &[
        ("movdqa", 0x66, 0x6F, 0x7F),
        ("movdqu", 0xF3, 0x6F, 0x7F),
        ("movaps", 0x00, 0x28, 0x29),
        ("movups", 0x00, 0x10, 0x11),
        ("movsd",  0xF2, 0x10, 0x11),
        ("movss",  0xF3, 0x10, 0x11),
    ];
    MOVS.iter()
        .find(|(n, _, _, _)| *n == name)
        .map(|&(_, prefix, load_op, store_op)| Mnemonic::SseMov {
            prefix,
            load_op,
            store_op,
        })
}

/// The catalogue mnemonic matching `name`, as a `'static` string, or `None`.
/// Lets a mnemonic the table encodes but that has no bespoke [`Mnemonic`]
/// variant still be parsed and routed through the table.
fn table_mnemonic(name: &str) -> Option<&'static str> {
    // The catalogue is sorted by mnemonic; binary-search rather than scan.
    let forms = super::isa_x86_table::FORMS;
    let start = forms.partition_point(|f| f.mnemonic < name);
    forms.get(start).map(|f| f.mnemonic).filter(|&m| m == name)
}

/// Resolve a mnemonic token to its base form plus any AT&T size suffix.
/// A trailing `b`/`w`/`l`/`q` is a suffix only when the token is not a
/// mnemonic as written (so `shl` stays `shl`, but `bswapl` is
/// `bswap` + long). A token that is not a bespoke mnemonic but names a
/// catalogue instruction resolves to [`Mnemonic::Table`].
fn split_mnemonic(tok: &str) -> Option<(Mnemonic, Option<AsmRegSize>)> {
    if let Some(m) = mnemonic_by_name(tok) {
        return Some((m, None));
    }
    if let Some(name) = table_mnemonic(tok) {
        return Some((Mnemonic::Table(name), None));
    }
    let (base, suffix) = match tok.as_bytes().last() {
        Some(b'b') => (&tok[..tok.len() - 1], Some(AsmRegSize::Byte)),
        Some(b'w') => (&tok[..tok.len() - 1], Some(AsmRegSize::Word)),
        Some(b'l') => (&tok[..tok.len() - 1], Some(AsmRegSize::Long)),
        Some(b'q') => (&tok[..tok.len() - 1], Some(AsmRegSize::Quad)),
        _ => return None,
    };
    if let Some(m) = mnemonic_by_name(base) {
        return Some((m, suffix));
    }
    table_mnemonic(base).map(|name| (Mnemonic::Table(name), suffix))
}

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpnd, String> {
    let bytes = tok.as_bytes();
    if let Some(rest) = tok.strip_prefix('$') {
        let v = parse_int(rest).ok_or_else(|| format!("inline asm: bad immediate `{tok}`"))?;
        return Ok(AsmOpnd::Imm(v));
    }
    // A local-label reference `Nf` / `Nb` (jmp / jcc target). Digits then a
    // single direction letter; a bare register or `%N` reference never has
    // this shape.
    if let Some((digits, dir)) = tok
        .strip_suffix('f')
        .map(|d| (d, true))
        .or_else(|| tok.strip_suffix('b').map(|d| (d, false)))
        && !digits.is_empty()
        && digits.bytes().all(|c| c.is_ascii_digit())
        && let Ok(num) = digits.parse::<u32>()
    {
        return Ok(AsmOpnd::Label { num, forward: dir });
    }
    if let Some(rest) = tok.strip_prefix("%%") {
        let (reg, size) =
            reg_by_name(rest).ok_or_else(|| format!("inline asm: unknown register `{tok}`"))?;
        return Ok(AsmOpnd::Reg { reg, size });
    }
    if bytes.first() == Some(&b'%') {
        let body = &tok[1..];
        // A single `%` before a register name is an explicit register. GCC
        // uses this in *basic* asm (no operand list); extended asm spells it
        // `%%reg`. Operand references (`%0`, `%w1`) are never register names,
        // so trying the register table first is unambiguous.
        if let Some((reg, size)) = reg_by_name(body) {
            return Ok(AsmOpnd::Reg { reg, size });
        }
        // `%N` or `%<size>N`. A leading size modifier is a single
        // letter b/w/k/q before the operand digits.
        let (size, digits) = match body.as_bytes().first() {
            Some(&b'b') if body.len() > 1 => (Some(AsmRegSize::Byte), &body[1..]),
            Some(&b'w') if body.len() > 1 => (Some(AsmRegSize::Word), &body[1..]),
            Some(&b'k') if body.len() > 1 => (Some(AsmRegSize::Long), &body[1..]),
            Some(&b'q') if body.len() > 1 => (Some(AsmRegSize::Quad), &body[1..]),
            _ => (None, body),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpnd::Ref { idx, size });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Parse a decimal or `0x`-hex integer, optionally signed.
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

/// Literal machine bytes for a raw-byte template piece, or `None` when the
/// piece is a mnemonic instruction. Two forms are recognised:
///
/// * a run of bare 2-hex-digit tokens (`CC C3 90`), each a byte value, and
/// * a `.byte` / `.word` / `.long` / `.quad` directive whose comma-separated
///   arguments are integer constants emitted little-endian at the directive's
///   width (the assembler idiom for hand-placed data).
///
/// The bare form reads its tokens as hexadecimal (so `90` is `0x90`); the
/// directive form reads C-style integer constants (`0x`-prefixed or decimal).
fn parse_raw_bytes(piece: &str) -> Option<Result<Vec<u8>, String>> {
    let width = match piece.split_whitespace().next()? {
        ".byte" => Some(1usize),
        ".word" | ".2byte" => Some(2),
        ".long" | ".4byte" => Some(4),
        ".quad" | ".8byte" => Some(8),
        _ => None,
    };
    if let Some(w) = width {
        let args = piece[piece.find(char::is_whitespace).unwrap()..].trim();
        let mut out = Vec::new();
        for a in args.split(',') {
            let a = a.trim();
            let Some(v) = parse_int(a) else {
                return Some(Err(format!(
                    "inline asm: bad `.byte`-directive value `{a}`"
                )));
            };
            out.extend_from_slice(&(v as u64).to_le_bytes()[..w]);
        }
        return Some(Ok(out));
    }
    // Bare hex-byte run: every whitespace-delimited token must be exactly two
    // hex digits, so a normal mnemonic (letters) is never mistaken for one.
    let tokens: Vec<&str> = piece.split_whitespace().collect();
    if !tokens.is_empty()
        && tokens
            .iter()
            .all(|t| t.len() == 2 && t.bytes().all(|b| b.is_ascii_hexdigit()))
    {
        let bytes = tokens
            .iter()
            .map(|t| u8::from_str_radix(t, 16).unwrap())
            .collect();
        return Some(Ok(bytes));
    }
    None
}

/// Parse an AT&T inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsn>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // A leading `N:` (digits then colon) defines a local label at this
        // point; the rest of the piece, if any, follows on the same line. The
        // digit-prefix test excludes segment overrides like `%fs:0x0`.
        while let Some(colon) = piece.find(':')
            && colon > 0
            && piece.as_bytes()[..colon].iter().all(u8::is_ascii_digit)
        {
            let num: u32 = piece[..colon]
                .parse()
                .map_err(|_| format!("inline asm: bad label `{piece}`"))?;
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_target: None,
                label_def: Some(num),
            });
            piece = piece[colon + 1..].trim();
        }
        if piece.is_empty() {
            continue;
        }
        // A raw-byte piece (hex-byte run or `.byte`-family directive) emits its
        // bytes verbatim with no operands.
        if let Some(bytes) = parse_raw_bytes(piece) {
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                operands: Vec::new(),
                bytes: bytes?,
                sym_target: None,
                label_def: None,
            });
            continue;
        }
        // Mnemonic is the first whitespace-delimited token; the operand
        // list is the remainder, comma-separated.
        let (mnem_tok, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        let (mnemonic, suffix) = split_mnemonic(mnem_tok)
            .ok_or_else(|| format!("inline asm: unsupported instruction `{mnem_tok}`"))?;
        // A direct `call` / `jmp` to a bare identifier is a symbol reference
        // (basic-asm `call schedule`); the target is resolved to a rel32 by a
        // relocation, not parsed as a register / immediate / memory operand.
        let is_bare_ident = !rest.is_empty()
            && rest
                .bytes()
                .next()
                .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_')
            && rest.bytes().all(|c| c.is_ascii_alphanumeric() || c == b'_')
            && reg_by_name(rest).is_none();
        if matches!(mnem_tok, "call" | "callq" | "jmp" | "jmpq") && is_bare_ident {
            insns.push(AsmInsn {
                mnemonic,
                suffix,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_target: Some(alloc::string::String::from(rest)),
                label_def: None,
            });
            continue;
        }
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in rest.split(',') {
                operands.push(parse_operand(op.trim())?);
            }
        }
        insns.push(AsmInsn {
            mnemonic,
            suffix,
            operands,
            bytes: Vec::new(),
            sym_target: None,
            label_def: None,
        });
    }
    Ok(insns)
}

// ------------------------------------------------------------------
// Encoding primitives (local copies of the shared REX / ModR/M
// helpers so this module needs no wider visibility into `encode`).
// ------------------------------------------------------------------

fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    let mut v = 0x40;
    if w {
        v |= 0x08;
    }
    if r {
        v |= 0x04;
    }
    if x {
        v |= 0x02;
    }
    if b {
        v |= 0x01;
    }
    v
}

fn modrm_reg(reg: u8, rm: u8) -> u8 {
    // Register-direct form (mod = 11).
    0xC0 | ((reg & 7) << 3) | (rm & 7)
}

/// Emit a ModR/M (plus SIB / disp8 as the base register requires) for a
/// `(%base)` memory reference with ModRM.reg = `reg`. REX.B for `base >= 8`
/// and any operand-size prefix are emitted by the caller.
fn modrm_mem(code: &mut Vec<u8>, reg: u8, base: u8) {
    let rm = base & 7;
    if rm == 5 {
        // rbp / r13: mod=00 rm=101 is RIP-relative, so use mod=01 disp8=0.
        code.push(0x40 | ((reg & 7) << 3) | rm);
        code.push(0x00);
    } else if rm == 4 {
        // rsp / r12: rm=100 selects a SIB byte; encode base with no index.
        code.push(((reg & 7) << 3) | rm);
        code.push(0x24);
    } else {
        code.push(((reg & 7) << 3) | rm);
    }
}

/// Emit any needed operand-size / REX prefix for an instruction whose
/// operands are `size`-wide and use ModR/M.reg = `reg`, r/m = `rm`.
/// The 16-bit operand-size prefix (0x66) precedes REX per the SDM.
fn prefix_rex(code: &mut Vec<u8>, size: AsmRegSize, reg: u8, rm: u8) {
    if size == AsmRegSize::Word {
        code.push(0x66);
    }
    let w = size == AsmRegSize::Quad;
    let r = reg >= 8;
    let b = rm >= 8;
    // A byte operation naming spl/bpl/sil/dil (register numbers 4..8) needs
    // a REX prefix to select the new byte registers rather than ah/ch/dh/bh.
    let byte_rex = size == AsmRegSize::Byte && ((4..8).contains(&reg) || (4..8).contains(&rm));
    if w || r || b || byte_rex {
        code.push(rex(w, r, false, b));
    }
}

/// Map a template instruction to the table encoder's mnemonic name and its
/// operands in Intel (`dst, src`) order, or `None` when this mnemonic keeps its
/// bespoke encoding below. Template operands are AT&T (`src, dst`), so a
/// two-operand form is transposed; a shift's count operand moves after the
/// destination, and an omitted count becomes the implicit `1`. Instructions
/// naming a control / debug / segment / MMX register (marked `reg >= 16`) stay
/// on the bespoke path.
fn to_table(
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Option<(&'static str, Option<u8>, Vec<super::table::Opnd>)> {
    use super::table::Opnd;
    use Mnemonic as M;
    // A catalogue-passthrough mnemonic carries its own name; arrange the AT&T
    // operands into the table's Intel order by arity and route straight through.
    if let M::Table(name) = mnemonic {
        return to_table_generic(name, suffix, ops);
    }
    let name = match mnemonic {
        M::Add => "add",
        M::Sub => "sub",
        M::And => "and",
        M::Or => "or",
        M::Xor => "xor",
        M::Mov => "mov",
        M::Shl => "shl",
        M::Shr => "shr",
        M::Sar => "sar",
        M::Bswap => "bswap",
        M::Xadd => "xadd",
        M::Cmpxchg => "cmpxchg",
        M::Inc => "inc",
        M::Dec => "dec",
        M::Rdtsc => "rdtsc",
        M::Rdtscp => "rdtscp",
        M::Nop => "nop",
        M::Cli => "cli",
        M::Sti => "sti",
        M::Invd => "invd",
        M::Wbinvd => "wbinvd",
        M::Rdmsr => "rdmsr",
        M::Wrmsr => "wrmsr",
        M::Rdpmc => "rdpmc",
        M::Monitor => "monitor",
        M::Mwait => "mwait",
        M::Hlt => "hlt",
        _ => return None,
    };
    if ops
        .iter()
        .any(|o| matches!(o, Concrete::Reg { reg, .. } if *reg >= MMX_BASE))
    {
        return None;
    }
    let cvt = table_opnd;
    let tops: Vec<Opnd> = match mnemonic {
        M::Rdtsc
        | M::Rdtscp
        | M::Nop
        | M::Cli
        | M::Sti
        | M::Invd
        | M::Wbinvd
        | M::Rdmsr
        | M::Wrmsr
        | M::Rdpmc
        | M::Monitor
        | M::Mwait
        | M::Hlt => Vec::new(),
        M::Bswap | M::Inc | M::Dec => match ops {
            [rm] => alloc::vec![cvt(rm)],
            _ => return None,
        },
        M::Shl | M::Shr | M::Sar => match ops {
            [dst] => alloc::vec![cvt(dst), Opnd::Imm(1)],
            [count, dst] => {
                let c = match *count {
                    Concrete::Imm(v) => Opnd::Imm(v),
                    // The shift count is CL regardless of the register's name.
                    Concrete::Reg { reg: 1, .. } => Opnd::Reg { num: 1, width: 1 },
                    _ => return None,
                };
                alloc::vec![cvt(dst), c]
            }
            _ => return None,
        },
        // ALU / mov / xadd / cmpxchg: AT&T `op src, dst` -> Intel `op dst, src`.
        _ => match ops {
            [src, dst] => alloc::vec![cvt(dst), cvt(src)],
            _ => return None,
        },
    };
    Some((name, suffix.map(|s| s.bytes()), tops))
}

/// Arrange the operands of a catalogue-passthrough mnemonic
/// ([`Mnemonic::Table`]) into the table's Intel order, by arity: no operands
/// stay empty, a unary form passes its operand, a two-operand form transposes
/// AT&T `src, dst` to `dst, src`, and a shift / rotate takes its count (CL or an
/// immediate) after the destination with an omitted count meaning `1`. Operands
/// naming a register with no catalogue form (MMX / control / debug / segment,
/// `reg >= MMX_BASE`) return `None`.
fn to_table_generic(
    name: &'static str,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Option<(&'static str, Option<u8>, Vec<super::table::Opnd>)> {
    use super::table::Opnd;
    if ops
        .iter()
        .any(|o| matches!(o, Concrete::Reg { reg, .. } if *reg >= MMX_BASE))
    {
        return None;
    }
    let shift_like = matches!(
        name,
        "shl" | "shr" | "sar" | "sal" | "rol" | "ror" | "rcl" | "rcr"
    );
    let tops = match ops {
        [] => Vec::new(),
        [rm] if shift_like => alloc::vec![table_opnd(rm), Opnd::Imm(1)],
        [rm] => alloc::vec![table_opnd(rm)],
        [count, dst] if shift_like => {
            let c = match *count {
                Concrete::Imm(v) => Opnd::Imm(v),
                // The shift / rotate count is CL regardless of the register's name.
                Concrete::Reg { reg: 1, .. } => Opnd::Reg { num: 1, width: 1 },
                _ => return None,
            };
            alloc::vec![table_opnd(dst), c]
        }
        [src, dst] => alloc::vec![table_opnd(dst), table_opnd(src)],
        _ => return None,
    };
    Some((name, suffix.map(|s| s.bytes()), tops))
}

/// Convert a resolved operand to the table encoder's operand form.
fn table_opnd(c: &Concrete) -> super::table::Opnd {
    use super::table::Opnd;
    match *c {
        Concrete::Reg { reg, size } => Opnd::Reg {
            num: reg,
            width: size.bytes(),
        },
        Concrete::Mem { base, size } => Opnd::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            width: size.bytes(),
        },
        Concrete::Imm(v) => Opnd::Imm(v),
    }
}

/// Encode one resolved instruction into `code`. Operands are in AT&T
/// order. Returns an error for an unsupported mnemonic / operand form.
pub(crate) fn encode(
    code: &mut Vec<u8>,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Result<(), String> {
    // Mnemonics the table encoder covers route through it; the operands are
    // resolved to Intel order first.
    if let Some((name, width, tops)) = to_table(mnemonic, suffix, ops) {
        // The inline-asm path holds the mnemonic as text (a parsed token); map
        // it to the catalogue enum at this one boundary.
        let mnem = super::table::Mnem::from_name(name)
            .ok_or_else(|| format!("inline asm: unknown catalogue mnemonic `{name}`"))?;
        code.extend_from_slice(&super::table::encode(mnem, width, &tops)?);
        return Ok(());
    }
    match mnemonic {
        // Raw bytes carry their payload on the `AsmInsn`, not in `ops`; the
        // caller emits them directly and never routes them here.
        Mnemonic::RawBytes => Err(String::from(
            "inline asm: raw bytes not routed through encode",
        )),
        Mnemonic::Pause => {
            code.extend_from_slice(&[0xF3, 0x90]);
            Ok(())
        }
        Mnemonic::Lock => {
            // Prefix byte; the following template line encodes the locked op.
            code.push(0xF0);
            Ok(())
        }
        Mnemonic::Pushfq => {
            code.push(0x9C);
            Ok(())
        }
        Mnemonic::Int => {
            // `int $imm`: int3 (imm 3) is the one-byte 0xCC breakpoint;
            // any other vector is 0xCD ib.
            match ops.first() {
                Some(Concrete::Imm(3)) => code.push(0xCC),
                Some(Concrete::Imm(n)) => code.extend_from_slice(&[0xCD, *n as u8]),
                _ => return Err(String::from("inline asm: `int` needs an immediate vector")),
            }
            Ok(())
        }
        Mnemonic::Pop => {
            // `pop reg` (64-bit): 0x58+reg, REX.B for r8..r15.
            let (reg, _) = reg_operand(ops.first(), suffix)?;
            if reg >= 8 {
                code.push(rex(false, false, false, true));
            }
            code.push(0x58 + (reg & 7));
            Ok(())
        }
        Mnemonic::Movd => {
            // One operand is a vector register (MMX MMX_BASE..+8 or XMM
            // XMM_BASE..+16), the other a GPR / memory. `movd %vec, %gp` stores
            // (0F 7E /r), `movd %gp, %vec` loads (0F 6E /r). The vector register
            // is the ModRM.reg field, the GPR / memory the r/m. MMX has no
            // prefix; XMM adds 0x66. movd is 32-bit (no REX.W); a high XMM sets
            // REX.R, a high GPR / base REX.B.
            let [a, b] = two(ops)?;
            let vec = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (MMX_BASE..MMX_BASE + 8).contains(reg) => {
                    Some((*reg - MMX_BASE, false))
                }
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some((*reg - XMM_BASE, true))
                }
                _ => None,
            };
            let ((v_field, is_xmm), other, opcode) = if let Some(v) = vec(&a) {
                (v, b, 0x7E)
            } else if let Some(v) = vec(&b) {
                (v, a, 0x6E)
            } else {
                return Err(String::from("inline asm: `movd` needs one MMX/XMM operand"));
            };
            if is_xmm {
                code.push(0x66);
            }
            match other {
                Concrete::Reg { reg: gp_reg, .. } => {
                    if v_field >= 8 || gp_reg >= 8 {
                        code.push(rex(false, v_field >= 8, false, gp_reg >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    code.push(modrm_reg(v_field & 7, gp_reg & 7));
                }
                Concrete::Mem { base, .. } => {
                    if v_field >= 8 || base >= 8 {
                        code.push(rex(false, v_field >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    modrm_mem(code, v_field & 7, base);
                }
                Concrete::Imm(_) => {
                    return Err(String::from(
                        "inline asm: `movd` operand must be a register or memory",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::Sse2Rr { prefix, opcode } => {
            // `<op> %xmm_src/mem, %xmm_dst`: <prefix> [REX] 0F <opcode> /r, with
            // the AT&T destination in ModRM.reg and the source (an xmm register
            // or a `(%base)` memory operand) in r/m. A high destination sets
            // REX.R, a high source register / base REX.B.
            let [src, dst] = two(ops)?;
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let Some(d) = xmm(&dst) else {
                return Err(String::from(
                    "inline asm: this SSE op's destination must be an XMM register",
                ));
            };
            // A zero prefix means the no-mandatory-prefix packed forms (addps,
            // xorps, ...); 0x66/0xF2/0xF3 select the double / scalar variants.
            if prefix != 0 {
                code.push(prefix);
            }
            match src {
                _ if xmm(&src).is_some() => {
                    let s = xmm(&src).unwrap();
                    if d >= 8 || s >= 8 {
                        code.push(rex(false, d >= 8, false, s >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                Concrete::Mem { base, .. } => {
                    if d >= 8 || base >= 8 {
                        code.push(rex(false, d >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    modrm_mem(code, d & 7, base);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: this SSE op's source must be an XMM register or memory",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::SseMov {
            prefix,
            load_op,
            store_op,
        } => {
            // `mov* %src, %dst`: the xmm register is always ModRM.reg; a
            // `(%base)` memory operand is r/m. reg<-reg and reg<-mem (load) use
            // load_op, mem<-reg (store) store_op.
            let [src, dst] = two(ops)?;
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            if prefix != 0 {
                code.push(prefix);
            }
            match (src, dst) {
                (s, d) if xmm(&s).is_some() && xmm(&d).is_some() => {
                    let (sn, dn) = (xmm(&s).unwrap(), xmm(&d).unwrap());
                    if dn >= 8 || sn >= 8 {
                        code.push(rex(false, dn >= 8, false, sn >= 8));
                    }
                    code.extend_from_slice(&[0x0F, load_op]);
                    code.push(modrm_reg(dn & 7, sn & 7));
                }
                (Concrete::Mem { base, .. }, d) if xmm(&d).is_some() => {
                    let dn = xmm(&d).unwrap();
                    if dn >= 8 || base >= 8 {
                        code.push(rex(false, dn >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, load_op]);
                    modrm_mem(code, dn & 7, base);
                }
                (s, Concrete::Mem { base, .. }) if xmm(&s).is_some() => {
                    let sn = xmm(&s).unwrap();
                    if sn >= 8 || base >= 8 {
                        code.push(rex(false, sn >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, store_op]);
                    modrm_mem(code, sn & 7, base);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: SSE move needs an xmm register with an xmm or memory operand",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::In | Mnemonic::Out => {
            // AT&T `in port, acc` / `out acc, port`. The accumulator
            // (AL/AX/EAX) is implicit; only the width and the port form
            // select the opcode. Width comes from the suffix (inb/inw/inl),
            // else the accumulator operand.
            let is_in = matches!(mnemonic, Mnemonic::In);
            let (port, acc) = if is_in {
                (ops.first(), ops.get(1))
            } else {
                (ops.get(1), ops.first())
            };
            let size = suffix
                .or(acc.and_then(|o| match o {
                    Concrete::Reg { size, .. } => Some(*size),
                    _ => None,
                }))
                .unwrap_or(AsmRegSize::Long);
            if size == AsmRegSize::Word {
                code.push(0x66);
            }
            let byte = size == AsmRegSize::Byte;
            match port {
                // Immediate-port form: E4/E5 (in), E6/E7 (out), imm8 port.
                Some(Concrete::Imm(p)) if (0..=255).contains(p) => {
                    code.push(match (is_in, byte) {
                        (true, true) => 0xE4,
                        (true, false) => 0xE5,
                        (false, true) => 0xE6,
                        (false, false) => 0xE7,
                    });
                    code.push(*p as u8);
                }
                // Variable-port form: EC/ED (in), EE/EF (out), port in dx.
                _ => code.push(match (is_in, byte) {
                    (true, true) => 0xEC,
                    (true, false) => 0xED,
                    (false, true) => 0xEE,
                    (false, false) => 0xEF,
                }),
            }
            Ok(())
        }
        Mnemonic::Shld | Mnemonic::Shrd => {
            // AT&T `shld count, src, dst` -> Intel `SHLD dst, src, count`.
            let [count, src, dst] = three(ops)?;
            let (src_reg, ssz) = as_reg(src)?;
            let (dst_reg, dsz) = as_reg(dst)?;
            let size = suffix.unwrap_or(if dsz == AsmRegSize::Byte { ssz } else { dsz });
            let (op_cl, op_imm) = if mnemonic == Mnemonic::Shld {
                (0xA5u8, 0xA4u8)
            } else {
                (0xADu8, 0xACu8)
            };
            prefix_rex(code, size, src_reg, dst_reg);
            code.push(0x0F);
            match count {
                Concrete::Imm(v) => {
                    code.push(op_imm);
                    code.push(modrm_reg(src_reg, dst_reg));
                    code.push((v & 0xFF) as u8);
                }
                Concrete::Reg { reg, .. } => {
                    if reg != 1 {
                        return Err(String::from(
                            "inline asm: double-shift count must be CL or an immediate",
                        ));
                    }
                    code.push(op_cl);
                    code.push(modrm_reg(src_reg, dst_reg));
                }
                Concrete::Mem { .. } => {
                    return Err(String::from("inline asm: double-shift count in memory"));
                }
            }
            Ok(())
        }
        // Only control / debug / segment register moves reach here; the general
        // register / memory / immediate moves route through the table encoder.
        //   read  cr/dr/seg -> gpr : 0F 20 / 0F 21 / 8C
        //   write gpr -> cr/dr/seg : 0F 22 / 0F 23 / 8E
        Mnemonic::Mov => {
            let [src, dst] = two(ops)?;
            {
                let class = |c: &Concrete| -> Option<(u8, u8)> {
                    let Concrete::Reg { reg, .. } = c else {
                        return None;
                    };
                    if (CR_BASE..CR_BASE + 16).contains(reg) {
                        Some((reg - CR_BASE, b'c'))
                    } else if (DR_BASE..DR_BASE + 8).contains(reg) {
                        Some((reg - DR_BASE, b'd'))
                    } else if (SEG_BASE..SEG_BASE + 6).contains(reg) {
                        Some((reg - SEG_BASE, b's'))
                    } else {
                        None
                    }
                };
                let special = match (class(&src), class(&dst)) {
                    (Some(s), None) => Some((s.0, s.1, true)),
                    (None, Some(d)) => Some((d.0, d.1, false)),
                    (Some(_), Some(_)) => {
                        return Err(String::from(
                            "inline asm: mov between two special registers",
                        ));
                    }
                    (None, None) => None,
                };
                if let Some((spec_idx, kind, spec_is_src)) = special {
                    let (gp, gp_size) = as_reg(if spec_is_src { dst } else { src })?;
                    if gp >= MMX_BASE {
                        return Err(String::from(
                            "inline asm: mov special-register GPR expected",
                        ));
                    }
                    if kind == b's' {
                        // 8C stores a segment selector to r/m, 8E loads one.
                        prefix_rex(code, gp_size, spec_idx, gp);
                        code.push(if spec_is_src { 0x8C } else { 0x8E });
                    } else {
                        // Control / debug moves are inherently 64-bit; REX.W is
                        // unused. REX.R extends the special register (cr8+),
                        // REX.B the GPR.
                        let base: u8 = if kind == b'c' { 0x20 } else { 0x21 };
                        if spec_idx >= 8 || gp >= 8 {
                            code.push(rex(false, spec_idx >= 8, false, gp >= 8));
                        }
                        code.push(0x0F);
                        code.push(if spec_is_src { base } else { base + 2 });
                    }
                    code.push(modrm_reg(spec_idx, gp));
                    return Ok(());
                }
            }
            Err(String::from("inline asm: unsupported mov operands"))
        }
        // The delegated general-purpose / system mnemonics are handled by the
        // table encoder above and never reach here.
        _ => Err(format!(
            "inline asm: unsupported instruction `{mnemonic:?}`"
        )),
    }
}

fn as_reg(op: Concrete) -> Result<(u8, AsmRegSize), String> {
    match op {
        Concrete::Reg { reg, size } => Ok((reg, size)),
        Concrete::Mem { .. } => Err(String::from("inline asm: unexpected memory operand")),
        Concrete::Imm(_) => Err(String::from("inline asm: register operand expected")),
    }
}

fn reg_operand(
    op: Option<&Concrete>,
    suffix: Option<AsmRegSize>,
) -> Result<(u8, AsmRegSize), String> {
    let (reg, size) = as_reg(*op.ok_or_else(|| String::from("inline asm: missing operand"))?)?;
    Ok((reg, suffix.unwrap_or(size)))
}

fn two(ops: &[Concrete]) -> Result<[Concrete; 2], String> {
    if ops.len() != 2 {
        return Err(String::from("inline asm: instruction needs two operands"));
    }
    Ok([ops[0], ops[1]])
}

fn three(ops: &[Concrete]) -> Result<[Concrete; 3], String> {
    if ops.len() != 3 {
        return Err(String::from("inline asm: instruction needs three operands"));
    }
    Ok([ops[0], ops[1], ops[2]])
}

#[cfg(test)]
mod tests {
    use super::*;

    fn enc(m: Mnemonic, suffix: Option<AsmRegSize>, ops: &[Concrete]) -> Vec<u8> {
        let mut c = Vec::new();
        encode(&mut c, m, suffix, ops).unwrap();
        c
    }

    fn raw(tmpl: &[u8]) -> Vec<u8> {
        // Concatenate the bytes of every piece; `;`-separated hex bytes parse
        // as one raw-byte piece each.
        let mut out = Vec::new();
        for i in parse_template(tmpl).unwrap() {
            assert_eq!(i.mnemonic, Mnemonic::RawBytes);
            out.extend_from_slice(&i.bytes);
        }
        out
    }

    #[test]
    fn raw_byte_templates() {
        // Bare hex-byte run: each token is one byte (read as hex, so `90` is
        // 0x90). `;` and whitespace both separate.
        assert_eq!(raw(b"CC; C3; 90"), [0xCC, 0xC3, 0x90]);
        assert_eq!(raw(b"cc c3 90"), [0xCC, 0xC3, 0x90]);
        // `.byte` / `.word` / `.long` / `.quad` directives, little-endian at
        // the directive width; C-style integer constants.
        assert_eq!(raw(b".byte 0x48, 0x89, 0xd8"), [0x48, 0x89, 0xd8]);
        assert_eq!(raw(b".word 0x1234"), [0x34, 0x12]);
        assert_eq!(raw(b".long 0xdeadbeef"), [0xef, 0xbe, 0xad, 0xde]);
        assert_eq!(raw(b".byte 144"), [0x90]); // decimal in the directive form
        // A run of hex bytes and a mnemonic can share one template.
        let mixed = parse_template(b".byte 0x90; nop").unwrap();
        assert_eq!(mixed.len(), 2);
        assert_eq!(mixed[0].mnemonic, Mnemonic::RawBytes);
        assert_eq!(mixed[1].mnemonic, Mnemonic::Nop);
        // A single alphabetic token stays a mnemonic, not a raw byte.
        assert_eq!(parse_template(b"nop").unwrap()[0].mnemonic, Mnemonic::Nop);
    }

    #[test]
    fn sse2_xmm_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let gp = |n: u8| Concrete::Reg {
            reg: n,
            size: AsmRegSize::Long,
        };
        let sse = |prefix, opcode| Mnemonic::Sse2Rr { prefix, opcode };
        // Two-xmm SSE2: `<prefix> [REX] 0F <opcode>` with ModRM.reg = dst,
        // rm = src (AT&T `op src, dst`, ops in source-first order).
        assert_eq!(
            enc(sse(0x66, 0xEF), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0xEF, 0xD1]
        ); // pxor %xmm1,%xmm2
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0xFE, 0xD1]
        ); // paddd
        assert_eq!(
            enc(sse(0x66, 0xD4), None, &[xmm(3), xmm(4)]),
            [0x66, 0x0F, 0xD4, 0xE3]
        ); // paddq %xmm3,%xmm4
        assert_eq!(
            enc(sse(0x66, 0x6F), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0x6F, 0xD1]
        ); // movdqa
        assert_eq!(
            enc(sse(0x66, 0xEF), None, &[xmm(9), xmm(10)]),
            [0x66, 0x45, 0x0F, 0xEF, 0xD1]
        ); // pxor high xmm -> REX.R+REX.B
        // movd GP<->xmm: the xmm form of the MMX movd adds the 0x66 prefix; the
        // vector register is ModRM.reg, the GPR rm.
        assert_eq!(
            enc(Mnemonic::Movd, None, &[gp(0), xmm(0)]),
            [0x66, 0x0F, 0x6E, 0xC0]
        ); // movd %eax,%xmm0
        assert_eq!(
            enc(Mnemonic::Movd, None, &[xmm(0), gp(0)]),
            [0x66, 0x0F, 0x7E, 0xC0]
        ); // movd %xmm0,%eax
        assert_eq!(
            enc(Mnemonic::Movd, None, &[gp(9), xmm(3)]),
            [0x66, 0x41, 0x0F, 0x6E, 0xD9]
        ); // movd %r9d,%xmm3 -> REX.B
        // A non-xmm operand pair is rejected.
        assert!(encode(&mut Vec::new(), sse(0x66, 0xEF), None, &[gp(0), gp(1)]).is_err());
        // The prefix byte selects the variant: 0xF2/0xF3 scalar, 0x66 packed
        // double, and a zero prefix the no-prefix packed single (no leading
        // byte).
        assert_eq!(
            enc(sse(0xF2, 0x58), None, &[xmm(1), xmm(2)]),
            [0xF2, 0x0F, 0x58, 0xD1]
        ); // addsd
        assert_eq!(
            enc(sse(0, 0x58), None, &[xmm(3), xmm(4)]),
            [0x0F, 0x58, 0xE3]
        ); // addps (no mandatory prefix)
        // The mnemonic table resolves names to their Sse2Rr encoding.
        assert_eq!(
            sse2_op("addsd"),
            Some(Mnemonic::Sse2Rr {
                prefix: 0xF2,
                opcode: 0x58
            })
        );
        assert_eq!(
            sse2_op("xorps"),
            Some(Mnemonic::Sse2Rr {
                prefix: 0,
                opcode: 0x57
            })
        );
        assert_eq!(sse2_op("not_an_sse_op"), None);
        // A `(%base)` memory source rides r/m through modrm_mem; a high
        // destination still sets REX.R, a high base REX.B.
        let mem = |base: u8| Concrete::Mem {
            base,
            size: AsmRegSize::Quad,
        };
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[mem(0), xmm(0)]),
            [0x66, 0x0F, 0xFE, 0x00]
        ); // paddd (%rax),%xmm0
        assert_eq!(
            enc(sse(0xF2, 0x58), None, &[mem(0), xmm(3)]),
            [0xF2, 0x0F, 0x58, 0x18]
        ); // addsd (%rax),%xmm3
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[mem(0), xmm(9)]),
            [0x66, 0x44, 0x0F, 0xFE, 0x08]
        ); // paddd (%rax),%xmm9 -> REX.R
    }

    #[test]
    fn sse_mov_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            size: AsmRegSize::Quad,
        };
        let mov = |p, l, s| Mnemonic::SseMov {
            prefix: p,
            load_op: l,
            store_op: s,
        };
        // reg-reg and load use the load opcode; store uses the store opcode; the
        // xmm register is always ModRM.reg.
        assert_eq!(
            enc(mov(0, 0x28, 0x29), None, &[xmm(1), xmm(2)]),
            [0x0F, 0x28, 0xD1]
        ); // movaps %xmm1,%xmm2
        assert_eq!(
            enc(mov(0x66, 0x6F, 0x7F), None, &[mem(0), xmm(0)]),
            [0x66, 0x0F, 0x6F, 0x00]
        ); // movdqa (%rax),%xmm0
        assert_eq!(
            enc(mov(0x66, 0x6F, 0x7F), None, &[xmm(0), mem(0)]),
            [0x66, 0x0F, 0x7F, 0x00]
        ); // movdqa %xmm0,(%rax)
        assert_eq!(
            enc(mov(0xF2, 0x10, 0x11), None, &[xmm(4), mem(0)]),
            [0xF2, 0x0F, 0x11, 0x20]
        ); // movsd %xmm4,(%rax)
        // The mov table resolves names to their SseMov encoding.
        assert_eq!(
            sse_mov("movdqa"),
            Some(Mnemonic::SseMov {
                prefix: 0x66,
                load_op: 0x6F,
                store_op: 0x7F
            })
        );
        assert_eq!(sse_mov("not_a_mov"), None);
    }

    #[test]
    fn port_io_variable_form() {
        // `in`/`out` DX-port form: width from the AT&T suffix; word takes
        // the 0x66 prefix. Registers are implicit (accumulator + DX).
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Byte), &[]), [0xEC]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Word), &[]), [0x66, 0xED]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Long), &[]), [0xED]);
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Byte), &[]), [0xEE]);
        assert_eq!(
            enc(Mnemonic::Out, Some(AsmRegSize::Word), &[]),
            [0x66, 0xEF]
        );
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Long), &[]), [0xEF]);
    }

    #[test]
    fn catalogue_passthrough() {
        let q = AsmRegSize::Quad;
        let rax = Concrete::Reg { reg: 0, size: q };
        let rbx = Concrete::Reg { reg: 3, size: q };
        // A non-bespoke catalogue mnemonic parses to Mnemonic::Table, stripping
        // an AT&T size suffix; an unknown token stays unresolved.
        assert_eq!(split_mnemonic("cmp"), Some((Mnemonic::Table("cmp"), None)));
        assert_eq!(
            split_mnemonic("negq"),
            Some((Mnemonic::Table("neg"), Some(q)))
        );
        assert_eq!(split_mnemonic("bogusxyz"), None);
        // Encodings match the assembler (the table is the same core the
        // differential sweep checks): neg/not (F7 /3,/2), and AT&T
        // `op src, dst` transposed to Intel for cmp (39 /r) and adc (11 /r).
        assert_eq!(
            enc(Mnemonic::Table("neg"), None, &[rax]),
            [0x48, 0xF7, 0xD8]
        );
        assert_eq!(
            enc(Mnemonic::Table("not"), None, &[rax]),
            [0x48, 0xF7, 0xD0]
        );
        assert_eq!(
            enc(Mnemonic::Table("cmp"), None, &[rbx, rax]),
            [0x48, 0x39, 0xD8]
        );
        assert_eq!(
            enc(Mnemonic::Table("adc"), None, &[rbx, rax]),
            [0x48, 0x11, 0xD8]
        );
        // A rotate takes its count after the destination; `rol $1` selects the
        // D1 /0 rotate-by-one short form, `rol $4` the C1 /0 immediate form.
        assert_eq!(
            enc(Mnemonic::Table("rol"), None, &[Concrete::Imm(1), rax]),
            [0x48, 0xD1, 0xC0]
        );
        assert_eq!(
            enc(Mnemonic::Table("rol"), None, &[Concrete::Imm(4), rax]),
            [0x48, 0xC1, 0xC0, 0x04]
        );
    }

    #[test]
    fn system_ops_encoding() {
        assert_eq!(enc(Mnemonic::Pause, None, &[]), [0xF3, 0x90]);
        assert_eq!(enc(Mnemonic::Pushfq, None, &[]), [0x9C]);
        assert_eq!(enc(Mnemonic::Int, None, &[Concrete::Imm(3)]), [0xCC]);
        assert_eq!(
            enc(Mnemonic::Int, None, &[Concrete::Imm(0x20)]),
            [0xCD, 0x20]
        );
        // pop rax = 0x58; pop r8 = REX.B 0x58.
        let rax = Concrete::Reg {
            reg: 0,
            size: AsmRegSize::Quad,
        };
        let r8 = Concrete::Reg {
            reg: 8,
            size: AsmRegSize::Quad,
        };
        assert_eq!(enc(Mnemonic::Pop, None, &[rax]), [0x58]);
        assert_eq!(enc(Mnemonic::Pop, None, &[r8]), [0x41, 0x58]);
    }

    #[test]
    fn port_io_mnemonic_parse() {
        // AT&T `inb`/`inw`/`inl`, `outb`/... split to (In/Out, size).
        assert_eq!(
            split_mnemonic("inb"),
            Some((Mnemonic::In, Some(AsmRegSize::Byte)))
        );
        assert_eq!(
            split_mnemonic("inl"),
            Some((Mnemonic::In, Some(AsmRegSize::Long)))
        );
        assert_eq!(
            split_mnemonic("outb"),
            Some((Mnemonic::Out, Some(AsmRegSize::Byte)))
        );
        assert_eq!(split_mnemonic("in"), Some((Mnemonic::In, None)));
    }
}
