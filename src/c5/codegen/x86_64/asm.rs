//! GCC extended inline-asm (x86_64): template parsing and instruction
//! encoding.
//!
//! [`parse_template`] turns an AT&T template into a sequence of
//! [`AsmInsn`]s with symbolic operand references (`%N`), explicit
//! registers (`%%reg`), immediates (`$imm`), explicit memory references
//! (`disp(%%reg)` / `disp(%N)`), and local labels -- numeric (`1:`,
//! `1b`/`1f`) and named (`name:`, addressable as `name(%%rip)`), with
//! the `%=` escape expanding to a per-instance number. The emitter
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
use super::super::ssa::emit_common::data_directive_width;

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
    /// A packed shuffle-with-immediate `<op> $imm8, %xmm_src, %xmm_dst`, encoded
    /// as `<prefix> [REX] 0F <opcode> /r ib` (destination in ModRM.reg, source in
    /// r/m). Covers pshuf{d,lw,hw} (opcode 0x70) and shuf{ps,pd} (opcode 0xC6).
    SseShufImm {
        prefix: u8,
        opcode: u8,
    },
    /// A packed shift by immediate `<op> $imm8, %xmm`, encoded as
    /// `66 [REX] 0F <opcode> /digit ib`: the op rides ModRM.reg as an opcode
    /// extension, the (source = destination) xmm sits in r/m.
    SseShiftImm {
        opcode: u8,
        digit: u8,
    },
    /// A 3-operand VEX (AVX) op `<v-op> %{x,y}mm_src2, %{x,y}mm_src1,
    /// %{x,y}mm_dst`, encoded `VEX(vvvv=src1, L=ymm, W=w, pp) <map> <opcode>
    /// ModRM(reg=dst, rm=src2)`. `pp` is the SSE-prefix selector (0 none, 1 0x66,
    /// 2 0xF3, 3 0xF2); `map` the opcode map (1 = 0F, 2 = 0F38, 3 = 0F3A). A
    /// 2-byte VEX (C5) is emitted unless src2 is a high register (r8..15), the
    /// map is not 0F, or W is set -- those need the 3-byte form (C4).
    Vex {
        pp: u8,
        map: u8,
        w: bool,
        opcode: u8,
    },
    /// A 2-operand VEX move `v-op %src, %dst` (VEX.vvvv unused). A register or
    /// memory source into a register uses `load_op`; a register into memory uses
    /// `store_op`. Covers vmovups/vmovaps/vmovdqu/vmovdqa (128/256-bit).
    VexMov {
        pp: u8,
        load_op: u8,
        store_op: u8,
    },
    /// A 2-operand VEX op `v-op %src, %dst` (VEX.vvvv unused), src a register or
    /// memory operand. Covers vsqrtps/vsqrtpd/vrcpps/vrsqrtps, the packed
    /// int<->float conversions (0F map), and the broadcasts (0F38 map).
    Vex2 {
        pp: u8,
        map: u8,
        opcode: u8,
    },
    /// A 3-operand VEX op with a trailing immediate `v-op $imm8, %src2, %src1,
    /// %dst`. Covers vshufps / vshufpd (0F map) and vperm2f128 / vpblendd /
    /// vpalignr / vinsertf128 (0F3A map).
    VexImm3 {
        pp: u8,
        map: u8,
        opcode: u8,
    },
    /// A 2-operand VEX op with a trailing immediate `v-op $imm8, %src, %dst`
    /// (VEX.vvvv unused). Covers vpshufd / vpshuflw / vpshufhw (0F map) and
    /// vpermilps / vpermilpd (0F3A map).
    VexImm2 {
        pp: u8,
        map: u8,
        opcode: u8,
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
    /// A legacy prefix byte: `lock` (0xF0), `rep` / `repe` / `repz` (0xF3),
    /// `repne` / `repnz` (0xF2). A prefix is a statement of its own
    /// (`repe; cmpsb`) or leads the instruction it applies to on the same
    /// statement (`rep stosw`); the parser emits it as its own entry either
    /// way, so it precedes the operand-size prefix the instruction adds.
    Prefix(u8),
    /// An operandless instruction with a fixed encoding, such as `fninit`.
    Fixed(&'static [u8]),
    /// A string primitive (`movs` / `cmps` / `stos` / `lods` / `scas`). Its
    /// operands are the fixed `%rsi` / `%rdi` / accumulator pair, so the AT&T
    /// size suffix alone picks the opcode and the operand-size prefix.
    StringOp {
        opcode: u8,
        osz: bool,
        rex_w: bool,
    },
    /// A single-memory-operand instruction encoded as one opcode byte and a
    /// ModR/M whose reg field is the opcode extension: `fnstsw` / `fnstcw`
    /// (x87 status / control word) and the far indirect call `lcall`.
    /// `osz` emits the 0x66 operand-size prefix; REX.W comes from `rex_w`
    /// and REX.B from the base register.
    MemExt {
        opcode: u8,
        ext: u8,
        osz: bool,
        rex_w: bool,
    },
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
    /// A `.byte`-family data directive whose arguments reference operands
    /// (`.long %c0`), so the values resolve at emit time. The payload is the
    /// element width in bytes; the operands are the directive arguments.
    Data(u8),
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
    /// `%cN` / `%PN`: operand N substituted as a bare constant (`%c`) or a
    /// bare symbol / constant address (`%P`), without the `$` immediate
    /// syntax. Valid on an `i`-class operand; the emitter resolves a
    /// compile-time constant to an immediate and an address value to the
    /// operand's captured value (`lea` / `call` / `jmp` positions).
    RefConst { idx: u8, symbolic: bool },
    /// `%%reg`: an explicit register named in the template.
    Reg { reg: u8, size: AsmRegSize },
    /// `$imm`: a literal immediate.
    Imm(i64),
    /// `disp(%%reg)` / `disp(%N)`: an explicit memory reference written in
    /// the template -- a byte displacement off a 64-bit base register (named
    /// directly or through a register-class operand reference), with an
    /// optional scaled index (`disp(%%base, %%index, scale)`).
    Mem {
        base: AsmMemBase,
        index: Option<AsmMemBase>,
        scale: u8,
        disp: i32,
    },
    /// `seg:disp` with no base register (`%%gs:0x28`): an absolute
    /// displacement, meaningful under the instruction's segment override.
    AbsMem { disp: i32 },
    /// `Nf` / `Nb`: a local-label reference (label number plus direction --
    /// `f` forward, `b` backward), the target of a `jmp` / `jcc` within the
    /// block. The emitter resolves it to a rel32 against the label definition.
    /// Named labels carry `NAMED_LABEL_BASE + intern-index` (direction is
    /// ignored: a name has exactly one definition).
    Label { num: u32, forward: bool },
    /// `LABEL(%%rip)`: the address of a template-local label, the source of a
    /// `lea`. Resolved to a RIP-relative rel32 against the label definition.
    LabelAddr { num: u32, forward: bool },
    /// `%lK`: an `asm goto` label reference by label-list index (the
    /// frontend canonicalizes `%l[name]` and operand-relative `%lN` to
    /// this form). The emitter branches to the label's target block.
    GotoLabel(u8),
}

/// Base register of an explicit template memory operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmMemBase {
    /// An explicit `%%reg` (architectural GP number).
    Reg(u8),
    /// An operand reference `%N`; the emitter substitutes its assigned
    /// register.
    Ref(u8),
}

/// Label numbers at and above this mark are interned named labels
/// (`name:` definitions); below it, GNU-as numeric locals (`1:`).
pub(crate) const NAMED_LABEL_BASE: u32 = 1 << 31;

/// One instruction of a parsed template, in AT&T operand order.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsn {
    pub mnemonic: Mnemonic,
    pub suffix: Option<AsmRegSize>,
    /// Segment-override prefix byte (0x64 `%%fs:`, 0x65 `%%gs:`) written on
    /// the instruction's memory operand; emitted before the opcode.
    pub seg: Option<u8>,
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
    /// A memory reference `disp(%base)` / `disp(%base, %index, scale)`:
    /// `base` holds the address, `disp` a byte displacement (0 for a
    /// memory-constrained `m` template operand).
    Mem {
        base: u8,
        index: Option<u8>,
        scale: u8,
        disp: i32,
        size: AsmRegSize,
    },
    /// An absolute displacement (`%%gs:0x28`), addressed with no base
    /// register; meaningful under a segment override.
    AbsMem {
        disp: i32,
        size: AsmRegSize,
    },
    Imm(i64),
}

/// Reject any `%N` template reference past the end of the operand list.
/// Both the native emitter and the interpreter index the operand list by
/// a reference's number, so the bound is checked once, up front.
pub(crate) fn check_operand_refs(insns: &[AsmInsn], n_operands: usize) -> Result<(), String> {
    for insn in insns {
        for o in &insn.operands {
            if let AsmOpnd::Ref { idx, .. } = *o
                && idx as usize >= n_operands
            {
                return Err(alloc::format!(
                    "inline asm: `%{idx}` names no operand ({n_operands} operands)"
                ));
            }
        }
    }
    Ok(())
}

/// Map the condition suffix of a `=@cc<cond>` flag-output constraint to
/// its x86_64 condition-code nibble (the value shared by `Jcc`, `SETcc`
/// and `CMOVcc`). Covers the synonym spellings GCC accepts.
pub(crate) fn flag_cond_code(cond: &str) -> Option<u8> {
    Some(match cond {
        "o" => 0x0,
        "no" => 0x1,
        "b" | "c" | "nae" => 0x2,
        "ae" | "nb" | "nc" => 0x3,
        "e" | "z" => 0x4,
        "ne" | "nz" => 0x5,
        "be" | "na" => 0x6,
        "a" | "nbe" => 0x7,
        "s" => 0x8,
        "ns" => 0x9,
        "p" | "pe" => 0xA,
        "np" | "po" => 0xB,
        "l" | "nge" => 0xC,
        "ge" | "nl" => 0xD,
        "le" | "ng" => 0xE,
        "g" | "nle" => 0xF,
        _ => return None,
    })
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
    if let Some(rest) = n.strip_prefix("ymm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 16
    {
        // YMM registers, marked with YMM_BASE; the VEX encode arm reads the mark
        // to set the 256-bit `L` bit and masks back to the ModRM / vvvv field.
        return Some((YMM_BASE + i, Quad));
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
pub(crate) const XMM_BASE: u8 = 64;
/// YMM registers (AVX 256-bit) occupy `YMM_BASE..YMM_BASE+16`. A VEX-encoded op
/// reads the mark to set the `L` bit (256-bit) and masks back to the low xmm
/// number for ModRM / VEX.vvvv.
pub(crate) const YMM_BASE: u8 = 96;
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
    clobber_fp_regs: u32,
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 16];
    // Fixed / bound / register-or-immediate operands take their named
    // register.
    for (i, op) in operands.iter().enumerate() {
        if let C::Fixed(r) | C::Bound(r) | C::RegOrImm(r) = op.constraint {
            assigned[i] = Some(r);
            used[r as usize] = true;
        }
    }
    // `r` operands take free pool registers (rax rbx rcx rdx rsi rdi r8 r9);
    // a memory operand takes one too, to hold its address, and a flag output
    // one to receive its `setcc` result. Every pool register is byte
    // addressable under REX, as `setcc` requires.
    let pool = [0u8, 3, 1, 2, 6, 7, 8, 9];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem | C::Flags(_)) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // `x` operands take an XMM register (xmm0..15). The GP and XMM files are
    // independent, so a number here does not clash with a GP assignment; the
    // emitter tells them apart by the operand's constraint. Skip any xmm named
    // in the clobber list.
    let mut fp_used = [false; 16];
    for r in 0..16u8 {
        if clobber_fp_regs & (1 << r) != 0 {
            fp_used[r as usize] = true;
        }
    }
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Fp) {
            let r = (0u8..16)
                .find(|&r| !fp_used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of XMM registers for operands"))?;
            fp_used[r as usize] = true;
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
/// The string primitives as `(base name, byte-form opcode)`. Their operands
/// are the fixed `%rsi` / `%rdi` / `%al` pair, so the whole encoding is the
/// opcode plus an operand-size prefix: the byte form is the opcode itself,
/// and the wider forms are `opcode + 1` under 0x66 (word) or REX.W (quad).
/// The size always comes from the AT&T suffix, which is part of the name
/// here rather than a separate suffix, so `movsbl` stays a sign-extending
/// move and never parses as `movsb` plus a long suffix.
const STRING_OPS: &[(&str, u8)] = &[
    ("movs", 0xA4),
    ("cmps", 0xA6),
    ("stos", 0xAA),
    ("lods", 0xAC),
    ("scas", 0xAE),
];

fn string_op(name: &str) -> Option<Mnemonic> {
    let (base, suffix) = name.split_at(name.len().checked_sub(1)?);
    let op = STRING_OPS.iter().find(|(n, _)| *n == base)?.1;
    let (opcode, osz, rex_w) = match suffix {
        "b" => (op, false, false),
        "w" => (op + 1, true, false),
        "l" => (op + 1, false, false),
        "q" => (op + 1, false, true),
        _ => return None,
    };
    Some(Mnemonic::StringOp { opcode, osz, rex_w })
}

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
        "lock" => Mnemonic::Prefix(0xF0),
        "rep" | "repe" | "repz" => Mnemonic::Prefix(0xF3),
        "repne" | "repnz" => Mnemonic::Prefix(0xF2),
        "fninit" => Mnemonic::Fixed(&[0xDB, 0xE3]),
        // x87 store status / control word to memory (DD /7, D9 /7).
        "fnstsw" => Mnemonic::MemExt {
            opcode: 0xDD,
            ext: 7,
            osz: false,
            rex_w: false,
        },
        "fnstcw" => Mnemonic::MemExt {
            opcode: 0xD9,
            ext: 7,
            osz: false,
            rex_w: false,
        },
        // Far indirect call (FF /3); the AT&T suffix sets the operand size.
        "lcallw" => Mnemonic::MemExt {
            opcode: 0xFF,
            ext: 3,
            osz: true,
            rex_w: false,
        },
        "lcall" | "lcalll" => Mnemonic::MemExt {
            opcode: 0xFF,
            ext: 3,
            osz: false,
            rex_w: false,
        },
        "lcallq" => Mnemonic::MemExt {
            opcode: 0xFF,
            ext: 3,
            osz: false,
            rex_w: true,
        },
        "xadd" => Mnemonic::Xadd,
        "cmpxchg" => Mnemonic::Cmpxchg,
        "inc" => Mnemonic::Inc,
        "dec" => Mnemonic::Dec,
        _ => {
            return string_op(name)
                .or_else(|| sse2_op(name))
                .or_else(|| sse_mov(name))
                .or_else(|| sse_imm(name))
                .or_else(|| vex_op(name));
        }
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
        ("pmullw", 0x66, 0xD5), ("pmuludq", 0x66, 0xF4), ("pmaddwd", 0x66, 0xF5), ("pmulhw", 0x66, 0xE5),
        ("pcmpeqb", 0x66, 0x74), ("pcmpeqw", 0x66, 0x75), ("pcmpeqd", 0x66, 0x76), ("pcmpgtd", 0x66, 0x66),
        ("pminub", 0x66, 0xDA), ("pmaxub", 0x66, 0xDE),
        ("packsswb", 0x66, 0x63), ("packssdw", 0x66, 0x6B), ("packuswb", 0x66, 0x67),
        ("punpcklbw", 0x66, 0x60), ("punpcklwd", 0x66, 0x61), ("punpckldq", 0x66, 0x62),
        ("punpckhbw", 0x66, 0x68), ("punpckhwd", 0x66, 0x69), ("punpckhdq", 0x66, 0x6A),
        // Scalar double (0xF2) / single (0xF3).
        ("addsd", 0xF2, 0x58), ("subsd", 0xF2, 0x5C), ("mulsd", 0xF2, 0x59), ("divsd", 0xF2, 0x5E),
        ("minsd", 0xF2, 0x5D), ("maxsd", 0xF2, 0x5F), ("sqrtsd", 0xF2, 0x51),
        ("addss", 0xF3, 0x58), ("subss", 0xF3, 0x5C), ("mulss", 0xF3, 0x59), ("divss", 0xF3, 0x5E),
        ("minss", 0xF3, 0x5D), ("maxss", 0xF3, 0x5F), ("sqrtss", 0xF3, 0x51),
        // Packed single (no prefix) / double (0x66).
        ("addps", 0, 0x58), ("subps", 0, 0x5C), ("mulps", 0, 0x59), ("divps", 0, 0x5E),
        ("minps", 0, 0x5D), ("maxps", 0, 0x5F), ("sqrtps", 0, 0x51),
        ("andps", 0, 0x54), ("andnps", 0, 0x55), ("orps", 0, 0x56), ("xorps", 0, 0x57),
        ("unpcklps", 0, 0x14), ("unpckhps", 0, 0x15),
        // Packed int <-> single-float conversions (cvtdq2ps / cvtps2dq / cvttps2dq).
        ("cvtdq2ps", 0, 0x5B), ("cvtps2dq", 0x66, 0x5B), ("cvttps2dq", 0xF3, 0x5B),
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

/// SSE immediate-operand ops: the packed shuffles `pshuf{d,lw,hw}` (opcode 0x70,
/// the prefix selecting the variant) and the shifts-by-immediate `ps{ll,rl,ra}
/// {w,d,q}` / `ps{ll,rl}dq` (opcode 0x71/0x72/0x73, a `/digit` opcode extension).
fn sse_imm(name: &str) -> Option<Mnemonic> {
    // Shuffle-with-immediate ops as `(name, prefix, 0F-opcode)`: pshuf* select
    // by prefix over opcode 0x70; shuf{ps,pd} use opcode 0xC6.
    #[rustfmt::skip]
    const SHUFS: &[(&str, u8, u8)] = &[
        ("pshufd", 0x66, 0x70), ("pshuflw", 0xF2, 0x70), ("pshufhw", 0xF3, 0x70),
        ("shufps", 0, 0xC6), ("shufpd", 0x66, 0xC6),
    ];
    if let Some(&(_, prefix, opcode)) = SHUFS.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::SseShufImm { prefix, opcode });
    }
    #[rustfmt::skip]
    const SHIFTS: &[(&str, u8, u8)] = &[
        ("psllw", 0x71, 6), ("pslld", 0x72, 6), ("psllq", 0x73, 6),
        ("psrlw", 0x71, 2), ("psrld", 0x72, 2), ("psrlq", 0x73, 2),
        ("psraw", 0x71, 4), ("psrad", 0x72, 4),
        ("pslldq", 0x73, 7), ("psrldq", 0x73, 3),
    ];
    SHIFTS
        .iter()
        .find(|(n, _, _)| *n == name)
        .map(|&(_, opcode, digit)| Mnemonic::SseShiftImm { opcode, digit })
}

/// 3-operand VEX (AVX) ops as `(name, pp, 0F-opcode)`, where `pp` selects the
/// SSE prefix (0 none, 1 0x66, 2 0xF3, 3 0xF2). All are 0F-map, VEX.W 0. The
/// non-destructive 3-operand form `v-op %src2, %src1, %dst` mirrors the SSE
/// two-operand op with an extra source. Byte-verified against clang.
fn vex_op(name: &str) -> Option<Mnemonic> {
    // 2-operand VEX moves as `(pp, load-op, store-op)`.
    let mov = match name {
        "vmovups" => Some((0u8, 0x10u8, 0x11u8)),
        "vmovupd" => Some((1, 0x10, 0x11)),
        "vmovaps" => Some((0, 0x28, 0x29)),
        "vmovapd" => Some((1, 0x28, 0x29)),
        "vmovdqu" => Some((2, 0x6F, 0x7F)),
        "vmovdqa" => Some((1, 0x6F, 0x7F)),
        _ => None,
    };
    if let Some((pp, load_op, store_op)) = mov {
        return Some(Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        });
    }
    // 2-operand VEX compute (single source) as `(pp, map, opcode)`. The 0F38
    // entries are the broadcasts: an xmm / memory source replicated across the
    // destination lanes.
    let two = match name {
        "vsqrtps" => Some((0u8, 1u8, 0x51u8)),
        "vsqrtpd" => Some((1, 1, 0x51)),
        "vrcpps" => Some((0, 1, 0x53)),
        "vrsqrtps" => Some((0, 1, 0x52)),
        "vcvtdq2ps" => Some((0, 1, 0x5B)),
        "vcvtps2dq" => Some((1, 1, 0x5B)),
        "vcvttps2dq" => Some((2, 1, 0x5B)),
        "vbroadcastss" => Some((1, 2, 0x18)),
        "vpbroadcastb" => Some((1, 2, 0x78)),
        "vpbroadcastw" => Some((1, 2, 0x79)),
        "vpbroadcastd" => Some((1, 2, 0x58)),
        "vpbroadcastq" => Some((1, 2, 0x59)),
        _ => None,
    };
    if let Some((pp, map, opcode)) = two {
        return Some(Mnemonic::Vex2 { pp, map, opcode });
    }
    #[rustfmt::skip]
    const OPS: &[(&str, u8, u8)] = &[
        // Packed single (no prefix).
        ("vaddps", 0, 0x58), ("vsubps", 0, 0x5C), ("vmulps", 0, 0x59), ("vdivps", 0, 0x5E),
        ("vminps", 0, 0x5D), ("vmaxps", 0, 0x5F),
        ("vandps", 0, 0x54), ("vandnps", 0, 0x55), ("vorps", 0, 0x56), ("vxorps", 0, 0x57),
        ("vunpcklps", 0, 0x14), ("vunpckhps", 0, 0x15),
        // Packed double (0x66).
        ("vaddpd", 1, 0x58), ("vsubpd", 1, 0x5C), ("vmulpd", 1, 0x59), ("vdivpd", 1, 0x5E),
        ("vminpd", 1, 0x5D), ("vmaxpd", 1, 0x5F),
        ("vandpd", 1, 0x54), ("vorpd", 1, 0x56), ("vxorpd", 1, 0x57),
        ("vunpcklpd", 1, 0x14), ("vunpckhpd", 1, 0x15),
        // Packed integer (0x66).
        ("vpaddb", 1, 0xFC), ("vpaddw", 1, 0xFD), ("vpaddd", 1, 0xFE), ("vpaddq", 1, 0xD4),
        ("vpsubb", 1, 0xF8), ("vpsubw", 1, 0xF9), ("vpsubd", 1, 0xFA), ("vpsubq", 1, 0xFB),
        ("vpand", 1, 0xDB), ("vpandn", 1, 0xDF), ("vpor", 1, 0xEB), ("vpxor", 1, 0xEF),
        ("vpcmpeqd", 1, 0x76), ("vpcmpgtd", 1, 0x66),
        ("vpunpckldq", 1, 0x62), ("vpunpckhdq", 1, 0x6A),
        ("vpmullw", 1, 0xD5), ("vpmaddwd", 1, 0xF5),
        // Scalar single (0xF3) / double (0xF2).
        ("vaddss", 2, 0x58), ("vsubss", 2, 0x5C), ("vmulss", 2, 0x59), ("vdivss", 2, 0x5E),
        ("vaddsd", 3, 0x58), ("vsubsd", 3, 0x5C), ("vmulsd", 3, 0x59), ("vdivsd", 3, 0x5E),
    ];
    if let Some(&(_, pp, opcode)) = OPS.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::Vex {
            pp,
            map: 1,
            w: false,
            opcode,
        });
    }
    // 3-operand VEX on the 0F38 map (all 66-prefixed) as `(name, W, opcode)`:
    // the SSE4.1 multiplies, the variable shifts, vpermd, and the FMA set.
    // W selects the element width (0 = dword / single, 1 = qword / double).
    #[rustfmt::skip]
    const OPS38: &[(&str, bool, u8)] = &[
        ("vpmulld", false, 0x40), ("vpmuldq", false, 0x28),
        ("vpsllvd", false, 0x47), ("vpsrlvd", false, 0x45), ("vpsravd", false, 0x46),
        ("vpsllvq", true, 0x47), ("vpsrlvq", true, 0x45),
        ("vpermd", false, 0x36),
        ("vfmadd132ps", false, 0x98), ("vfmadd213ps", false, 0xA8), ("vfmadd231ps", false, 0xB8),
        ("vfmadd132pd", true, 0x98), ("vfmadd213pd", true, 0xA8), ("vfmadd231pd", true, 0xB8),
        ("vfmsub132ps", false, 0x9A), ("vfmsub213ps", false, 0xAA), ("vfmsub231ps", false, 0xBA),
        ("vfmsub132pd", true, 0x9A), ("vfmsub213pd", true, 0xAA), ("vfmsub231pd", true, 0xBA),
        ("vfnmadd132ps", false, 0x9C), ("vfnmadd213ps", false, 0xAC), ("vfnmadd231ps", false, 0xBC),
        ("vfnmadd132pd", true, 0x9C), ("vfnmadd213pd", true, 0xAC), ("vfnmadd231pd", true, 0xBC),
        ("vfnmsub132ps", false, 0x9E), ("vfnmsub213ps", false, 0xAE), ("vfnmsub231ps", false, 0xBE),
        ("vfnmsub132pd", true, 0x9E), ("vfnmsub213pd", true, 0xAE), ("vfnmsub231pd", true, 0xBE),
    ];
    if let Some(&(_, w, opcode)) = OPS38.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::Vex {
            pp: 1,
            map: 2,
            w,
            opcode,
        });
    }
    // Immediate ops as `(pp, map, opcode)`. 3-operand: vshuf{ps,pd} (0F C6) and
    // the 0F3A lane ops. 2-operand: vpshuf{d,lw,hw} (0F 70) and vpermil{ps,pd}
    // (0F3A). TODO: vextractf128 (0F3A 19) stores dst in ModRM.rm with the
    // source in ModRM.reg -- the reverse of VexImm2 -- and needs its own
    // direction handling, as would EVEX / AVX-512 forms.
    let imm3 = match name {
        "vshufps" => Some((0u8, 1u8, 0xC6u8)),
        "vshufpd" => Some((1, 1, 0xC6)),
        "vperm2f128" => Some((1, 3, 0x06)),
        "vpblendd" => Some((1, 3, 0x02)),
        "vpalignr" => Some((1, 3, 0x0F)),
        "vinsertf128" => Some((1, 3, 0x18)),
        _ => None,
    };
    if let Some((pp, map, opcode)) = imm3 {
        return Some(Mnemonic::VexImm3 { pp, map, opcode });
    }
    let imm2 = match name {
        "vpshufd" => Some((1u8, 1u8, 0x70u8)),
        "vpshuflw" => Some((3, 1, 0x70)),
        "vpshufhw" => Some((2, 1, 0x70)),
        "vpermilps" => Some((1, 3, 0x04)),
        "vpermilpd" => Some((1, 3, 0x05)),
        _ => None,
    };
    imm2.map(|(pp, map, opcode)| Mnemonic::VexImm2 { pp, map, opcode })
}

/// If `movq src, dst` involves an XMM register, encode the SSE quadword move and
/// return true; otherwise (a plain GP move) return false. The forms: GP64<->xmm
/// (66 REX.W 0F 6E/7E), xmm<->xmm and mem->xmm load (F3 0F 7E), xmm->mem store
/// (66 0F D6). The xmm is always ModRM.reg; the other operand is r/m.
fn movq_xmm(code: &mut Vec<u8>, src: Concrete, dst: Concrete) -> bool {
    let xmm = |c: &Concrete| match c {
        Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
            Some(*reg - XMM_BASE)
        }
        _ => None,
    };
    let (sx, dx) = (xmm(&src), xmm(&dst));
    match (sx, dx, src, dst) {
        // GP -> xmm.
        (None, Some(d), Concrete::Reg { reg: g, .. }, _) => {
            code.push(0x66);
            code.push(rex(true, d >= 8, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x6E]);
            code.push(modrm_reg(d & 7, g & 7));
        }
        // xmm -> GP.
        (Some(s), None, _, Concrete::Reg { reg: g, .. }) => {
            code.push(0x66);
            code.push(rex(true, s >= 8, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x7E]);
            code.push(modrm_reg(s & 7, g & 7));
        }
        // xmm -> xmm.
        (Some(s), Some(d), _, _) => {
            code.push(0xF3);
            if d >= 8 || s >= 8 {
                code.push(rex(false, d >= 8, false, s >= 8));
            }
            code.extend_from_slice(&[0x0F, 0x7E]);
            code.push(modrm_reg(d & 7, s & 7));
        }
        // mem -> xmm (load).
        (None, Some(d), Concrete::Mem { base, disp, .. }, _) => {
            code.push(0xF3);
            if d >= 8 || base >= 8 {
                code.push(rex(false, d >= 8, false, base >= 8));
            }
            code.extend_from_slice(&[0x0F, 0x7E]);
            modrm_mem(code, d & 7, base, disp);
        }
        // xmm -> mem (store).
        (Some(s), None, _, Concrete::Mem { base, disp, .. }) => {
            code.push(0x66);
            if s >= 8 || base >= 8 {
                code.push(rex(false, s >= 8, false, base >= 8));
            }
            code.extend_from_slice(&[0x0F, 0xD6]);
            modrm_mem(code, s & 7, base, disp);
        }
        // No xmm operand: a plain GP move.
        _ => return false,
    }
    true
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
        // A string primitive carries its size in its own name, so a further
        // suffix does not apply: `movsbl` is a sign-extending move, not
        // `movsb` widened to long.
        if matches!(m, Mnemonic::StringOp { .. }) {
            return None;
        }
        return Some((m, suffix));
    }
    table_mnemonic(base).map(|name| (Mnemonic::Table(name), suffix))
}

/// Parse one operand token (already trimmed). `labels` is the template's
/// named-label intern table (from the definition pre-scan); a bare token
/// matching an entry is a local-label reference, not a symbol.
fn parse_operand(tok: &str, labels: &[&str]) -> Result<AsmOpnd, String> {
    // A leading `*` is AT&T's indirect-branch marker (`jmp *%rax`,
    // `call *8(%rbx)`); the operand kind alone selects the encoding.
    let tok = tok.strip_prefix('*').unwrap_or(tok);
    let bytes = tok.as_bytes();
    if let Some(rest) = tok.strip_prefix('$') {
        let v = parse_int(rest).ok_or_else(|| format!("inline asm: bad immediate `{tok}`"))?;
        return Ok(AsmOpnd::Imm(v));
    }
    // `prefix(inner)`: a memory reference (displacement off a base register)
    // or, with an `(%rip)` base, the address of a template-local label.
    if let Some(open) = tok.find('(')
        && tok.ends_with(')')
    {
        return parse_mem_operand(&tok[..open], &tok[open + 1..tok.len() - 1], labels)
            .ok_or_else(|| format!("inline asm: unsupported operand `{tok}`"));
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
    if let Some(idx) = labels.iter().position(|&n| n == tok) {
        return Ok(AsmOpnd::Label {
            num: NAMED_LABEL_BASE + idx as u32,
            forward: true,
        });
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
        // `%lK`: an `asm goto` label-list reference.
        if let Some(digits) = body.strip_prefix('l')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let k: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad goto-label reference `{tok}`"))?;
            return Ok(AsmOpnd::GotoLabel(k));
        }
        // `%cN` / `%PN`: a bare-constant / bare-symbol substitution.
        if let Some(&m) = body.as_bytes().first()
            && matches!(m, b'c' | b'P')
            && body.len() > 1
            && body[1..].bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = body[1..]
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpnd::RefConst {
                idx,
                symbolic: m == b'P',
            });
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

/// Split an operand list on commas, but not commas inside `(...)` (a
/// scaled-index memory operand carries its own commas, as in
/// `8(%%rax, %%rbx, 4)`).
fn split_asm_operands(rest: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut depth, mut start) = (0i32, 0usize);
    for (i, c) in rest.char_indices() {
        match c {
            '(' => depth += 1,
            ')' => depth -= 1,
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

/// Segment-override prefix byte for a leading `%%fs:` / `%%gs:` (or the
/// single-`%` basic-asm spelling), with the remainder of the token.
fn split_seg_prefix(tok: &str) -> Option<(u8, &str)> {
    for (name, byte) in [("fs:", 0x64u8), ("gs:", 0x65)] {
        if let Some(rest) = tok
            .strip_prefix("%%")
            .or_else(|| tok.strip_prefix('%'))
            .and_then(|t| t.strip_prefix(name))
        {
            return Some((byte, rest));
        }
    }
    None
}

/// Parse a base / index register of a memory operand: `%%reg` (a 64-bit GP
/// name) or an operand reference `%N` (an optional `q` size letter is the
/// 64-bit name the address requires anyway).
fn parse_mem_base(tok: &str) -> Option<AsmMemBase> {
    let body = tok
        .trim()
        .strip_prefix("%%")
        .or_else(|| tok.trim().strip_prefix('%'))?;
    let digits = body.strip_prefix('q').unwrap_or(body);
    if !digits.is_empty() && digits.bytes().all(|c| c.is_ascii_digit()) {
        return Some(AsmMemBase::Ref(digits.parse().ok()?));
    }
    let (reg, size) = reg_by_name(body)?;
    if reg >= 16 || size != AsmRegSize::Quad {
        return None;
    }
    Some(AsmMemBase::Reg(reg))
}

/// Parse `prefix(inner)`: the `disp(%%reg)` / `disp(%N)` /
/// `disp(%%base, %%index, scale)` memory forms and the `LABEL(%rip)`
/// label-address form. `None` for shapes not modelled.
fn parse_mem_operand(prefix: &str, inner: &str, labels: &[&str]) -> Option<AsmOpnd> {
    let prefix = prefix.trim();
    let inner = inner.trim();
    // `(base, index, scale)`: a SIB form. The bare `(base, index)` defaults
    // the scale to 1.
    let parts = split_asm_operands(inner);
    if parts.len() >= 2 {
        if parts.len() > 3 {
            return None;
        }
        let disp = if prefix.is_empty() {
            0i32
        } else {
            i32::try_from(parse_int(prefix)?).ok()?
        };
        let base = parse_mem_base(parts[0])?;
        let index = parse_mem_base(parts[1])?;
        let scale = match parts.get(2) {
            Some(s) => match parse_int(s)? {
                v @ (1 | 2 | 4 | 8) => v as u8,
                _ => return None,
            },
            None => 1,
        };
        return Some(AsmOpnd::Mem {
            base,
            index: Some(index),
            scale,
            disp,
        });
    }
    let reg_body = inner
        .strip_prefix("%%")
        .or_else(|| inner.strip_prefix('%'))?;
    if reg_body == "rip" {
        // The address of a template-local label (named or `Nf` / `Nb`).
        if let Some(idx) = labels.iter().position(|&n| n == prefix) {
            return Some(AsmOpnd::LabelAddr {
                num: NAMED_LABEL_BASE + idx as u32,
                forward: true,
            });
        }
        let (digits, forward) = prefix
            .strip_suffix('f')
            .map(|d| (d, true))
            .or_else(|| prefix.strip_suffix('b').map(|d| (d, false)))?;
        if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        return Some(AsmOpnd::LabelAddr {
            num: digits.parse().ok()?,
            forward,
        });
    }
    let disp = if prefix.is_empty() {
        0i32
    } else {
        i32::try_from(parse_int(prefix)?).ok()?
    };
    // An operand-reference base `%N` or an explicit 64-bit base register
    // (32-bit bases need the 0x67 prefix, not modelled).
    Some(AsmOpnd::Mem {
        base: parse_mem_base(inner)?,
        index: None,
        scale: 1,
        disp,
    })
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
    let width = data_directive_width(piece.split_whitespace().next()?);
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

/// Split a leading `name:` / `N:` local-label definition off `piece`,
/// returning the label text and the remainder. Names use the assembler
/// identifier charset (`.` and `$` included); a `%`-prefixed token (a
/// segment override like `%fs:0x0`) never matches.
fn split_label_def(piece: &str) -> Option<(&str, &str)> {
    let colon = piece.find(':')?;
    if colon == 0 {
        return None;
    }
    let name = &piece.as_bytes()[..colon];
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let named = !name[0].is_ascii_digit() && ident(name[0]) && name.iter().all(|&c| ident(c));
    if named || name.iter().all(u8::is_ascii_digit) {
        Some((&piece[..colon], &piece[colon + 1..]))
    } else {
        None
    }
}

/// Named local labels defined in the template's code text, in definition
/// order (the intern order the `NAMED_LABEL_BASE + index` label numbers
/// use). Shared with the emitter's section materialization so a section
/// reference resolves a name to the same number.
pub(crate) fn scan_label_names(text: &str) -> Vec<&str> {
    let mut names: Vec<&str> = Vec::new();
    for piece in text.split([';', '\n']) {
        let mut p = piece.trim();
        while let Some((name, rest)) = split_label_def(p) {
            if !name.as_bytes()[0].is_ascii_digit() && !names.contains(&name) {
                names.push(name);
            }
            p = rest.trim();
        }
    }
    names
}

/// Parse an AT&T inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsn>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let stripped;
    let text = match super::super::ssa::emit_common::strip_asm_comments(
        text,
        super::super::ssa::emit_common::AsmComments::X86,
    ) {
        Some(t) => {
            stripped = t;
            stripped.as_str()
        }
        None => text,
    };
    let expanded;
    let text = match super::super::ssa::emit_common::expand_template_uniq(text) {
        Some(t) => {
            expanded = t;
            expanded.as_str()
        }
        None => text,
    };
    // Pre-scan the label definitions so operand parsing can tell a local
    // label from a symbol; named labels intern in definition order.
    let names = scan_label_names(text);
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // A leading label definition marks this point; the rest of the
        // piece, if any, follows on the same line.
        while let Some((name, rest)) = split_label_def(piece) {
            let num = if name.as_bytes()[0].is_ascii_digit() {
                let n: u32 = name
                    .parse()
                    .ok()
                    .filter(|&n| n < NAMED_LABEL_BASE)
                    .ok_or_else(|| format!("inline asm: bad label `{piece}`"))?;
                n
            } else {
                // The pre-scan interned every named definition.
                NAMED_LABEL_BASE + names.iter().position(|&n| n == name).unwrap() as u32
            };
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                seg: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_target: None,
                label_def: Some(num),
            });
            piece = rest.trim();
        }
        if piece.is_empty() {
            continue;
        }
        // `.cfi_*` directives describe unwind state to a DWARF consumer and
        // carry no code bytes. badc emits no unwind info for asm bodies, so
        // they are accepted and ignored.
        if piece.starts_with(".cfi_") {
            continue;
        }
        // A `.byte`-family directive whose arguments reference operands
        // (`.long %c0`) resolves its values at emit time.
        if let Some((tok, rest)) = piece
            .split_once(char::is_whitespace)
            .filter(|(_, r)| r.contains('%'))
            && let Some(w) = data_directive_width(tok)
        {
            let mut operands = Vec::new();
            for a in rest.split(',') {
                // Directive arguments are bare integers, not `$`-prefixed.
                let a = a.trim();
                operands.push(match parse_int(a) {
                    Some(v) => AsmOpnd::Imm(v),
                    None => parse_operand(a, &names)?,
                });
            }
            insns.push(AsmInsn {
                mnemonic: Mnemonic::Data(w as u8),
                suffix: None,
                seg: None,
                operands,
                bytes: Vec::new(),
                sym_target: None,
                label_def: None,
            });
            continue;
        }
        // A raw-byte piece (hex-byte run or `.byte`-family directive) emits its
        // bytes verbatim with no operands.
        if let Some(bytes) = parse_raw_bytes(piece) {
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                seg: None,
                operands: Vec::new(),
                bytes: bytes?,
                sym_target: None,
                label_def: None,
            });
            continue;
        }
        // Mnemonic is the first whitespace-delimited token; the operand
        // list is the remainder, comma-separated.
        let (mut mnem_tok, mut rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        // A prefix may lead the instruction it applies to on the same
        // statement (`rep stosw`, `lock xaddl ...`) as well as stand alone
        // (`repe; cmpsb`). Emit each leading prefix as its own entry and
        // carry on with the rest of the statement.
        while !rest.is_empty()
            && let Some((Mnemonic::Prefix(b), None)) = split_mnemonic(mnem_tok)
        {
            insns.push(AsmInsn {
                mnemonic: Mnemonic::Prefix(b),
                suffix: None,
                seg: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_target: None,
                label_def: None,
            });
            (mnem_tok, rest) = match rest.find(char::is_whitespace) {
                Some(p) => (&rest[..p], rest[p..].trim()),
                None => (rest, ""),
            };
        }
        let (mnemonic, suffix) = split_mnemonic(mnem_tok)
            .ok_or_else(|| format!("inline asm: unsupported instruction `{mnem_tok}`"))?;
        // A direct `call` / `jmp` to a symbol name is a symbol reference
        // (basic-asm `call schedule`); the target is resolved to a rel32 by a
        // relocation, not parsed as a register / immediate / memory operand.
        // A name the template defines as a label resolves locally instead.
        // The name may embed operand references (`call __get_user_%c0`), which
        // are substituted at emit time, so the text is kept verbatim here.
        let is_symbol_target = !rest.is_empty()
            && super::super::ssa::emit_common::is_asm_symbol_template(rest)
            && reg_by_name(rest).is_none()
            && !names.contains(&rest);
        if matches!(mnem_tok, "call" | "callq" | "jmp" | "jmpq") && is_symbol_target {
            insns.push(AsmInsn {
                mnemonic,
                suffix,
                seg: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_target: Some(alloc::string::String::from(rest)),
                label_def: None,
            });
            continue;
        }
        let mut operands = Vec::new();
        let mut seg: Option<u8> = None;
        if !rest.is_empty() {
            for op in split_asm_operands(rest) {
                // A `%%fs:` / `%%gs:` segment override rides the instruction
                // (one memory operand per instruction); the remainder is the
                // memory reference, a bare integer being an absolute
                // displacement.
                let tok = match split_seg_prefix(op) {
                    Some((byte, rem)) => {
                        if seg.is_some_and(|s| s != byte) {
                            return Err(String::from("inline asm: conflicting segment overrides"));
                        }
                        seg = Some(byte);
                        if let Some(v) = parse_int(rem) {
                            let disp = i32::try_from(v)
                                .map_err(|_| format!("inline asm: bad displacement `{op}`"))?;
                            operands.push(AsmOpnd::AbsMem { disp });
                            continue;
                        }
                        rem
                    }
                    None => op,
                };
                operands.push(parse_operand(tok, &names)?);
            }
        }
        insns.push(AsmInsn {
            mnemonic,
            suffix,
            seg,
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

/// Emit a VEX prefix. `r`/`x`/`b` are the (non-inverted) high bits of ModRM.reg,
/// SIB.index, and ModRM.rm/base; VEX stores them inverted. `map` is the opcode
/// map (1 = 0F, 2 = 0F38, 3 = 0F3A), `w` the VEX.W bit, `vvvv` the src1
/// register 0..15 (inverted here), `l` the 256-bit bit, `pp` the SSE-prefix
/// selector (0/1/2/3). Uses the 2-byte form (C5) when x, b, and w are clear and
/// the map is 0F; else the 3-byte form (C4).
#[allow(clippy::too_many_arguments)]
fn emit_vex(
    code: &mut Vec<u8>,
    r: bool,
    x: bool,
    b: bool,
    map: u8,
    w: bool,
    vvvv: u8,
    l: u8,
    pp: u8,
) {
    let inv_vvvv = !vvvv & 0x0F;
    if !x && !b && !w && map == 1 {
        code.push(0xC5);
        code.push((u8::from(!r) << 7) | (inv_vvvv << 3) | (l << 2) | pp);
    } else {
        code.push(0xC4);
        code.push((u8::from(!r) << 7) | (u8::from(!x) << 6) | (u8::from(!b) << 5) | map);
        code.push((u8::from(w) << 7) | (inv_vvvv << 3) | (l << 2) | pp);
    }
}

/// Decode a [`Concrete`] xmm / ymm register to `(number, is_ymm)`.
fn vec_reg(c: &Concrete) -> Option<(u8, bool)> {
    match c {
        Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
            Some((*reg - XMM_BASE, false))
        }
        Concrete::Reg { reg, .. } if (YMM_BASE..YMM_BASE + 16).contains(reg) => {
            Some((*reg - YMM_BASE, true))
        }
        _ => None,
    }
}

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

/// Emit a ModR/M (plus SIB / displacement as the base register and `disp`
/// require) for a `disp(%base)` memory reference with ModRM.reg = `reg`.
/// REX.B for `base >= 8` and any operand-size prefix are emitted by the
/// caller. rbp / r13 (rm=101) have no mod=00 form (that means RIP-relative),
/// so a zero displacement still encodes as disp8=0 there; rsp / r12 (rm=100)
/// take a no-index SIB byte.
fn modrm_mem(code: &mut Vec<u8>, reg: u8, base: u8, disp: i32) {
    let rm = base & 7;
    let mod_: u8 = if disp == 0 && rm != 5 {
        0
    } else if (-128..=127).contains(&disp) {
        1
    } else {
        2
    };
    code.push((mod_ << 6) | ((reg & 7) << 3) | rm);
    if rm == 4 {
        code.push(0x24);
    }
    match mod_ {
        1 => code.push(disp as u8),
        2 => code.extend_from_slice(&disp.to_le_bytes()),
        _ => {}
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
        Concrete::Mem {
            base,
            index,
            scale,
            disp,
            size,
        } => Opnd::Mem {
            base,
            index,
            scale,
            disp,
            width: size.bytes(),
        },
        Concrete::AbsMem { disp, size } => Opnd::AbsMem {
            disp,
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
    // The bespoke arms below address memory through `modrm_mem` (base +
    // displacement only); a scaled index reaches them only on an
    // unmodelled shape.
    if ops
        .iter()
        .any(|o| matches!(o, Concrete::Mem { index: Some(_), .. }))
    {
        return Err(String::from(
            "inline asm: scaled-index memory operand unsupported for this instruction",
        ));
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
        Mnemonic::Prefix(b) => {
            // The instruction it applies to is the next entry, so the prefix
            // byte precedes any operand-size prefix that instruction emits.
            code.push(b);
            Ok(())
        }
        Mnemonic::Fixed(bytes) => {
            code.extend_from_slice(bytes);
            Ok(())
        }
        Mnemonic::StringOp { opcode, osz, rex_w } => {
            if osz {
                code.push(0x66);
            }
            if rex_w {
                code.push(rex(true, false, false, false));
            }
            code.push(opcode);
            Ok(())
        }
        Mnemonic::MemExt {
            opcode,
            ext,
            osz,
            rex_w,
        } => {
            let Some(Concrete::Mem { base, disp, .. }) = ops.first() else {
                return Err(String::from(
                    "inline asm: this instruction takes a memory operand",
                ));
            };
            if osz {
                code.push(0x66);
            }
            if rex_w || *base >= 8 {
                code.push(rex(rex_w, false, false, *base >= 8));
            }
            code.push(opcode);
            modrm_mem(code, ext, *base, *disp);
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
                Concrete::Mem { base, disp, .. } => {
                    if v_field >= 8 || base >= 8 {
                        code.push(rex(false, v_field >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    modrm_mem(code, v_field & 7, base, disp);
                }
                Concrete::Imm(_) | Concrete::AbsMem { .. } => {
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
                Concrete::Mem { base, disp, .. } => {
                    if d >= 8 || base >= 8 {
                        code.push(rex(false, d >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    modrm_mem(code, d & 7, base, disp);
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
                (Concrete::Mem { base, disp, .. }, d) if xmm(&d).is_some() => {
                    let dn = xmm(&d).unwrap();
                    if dn >= 8 || base >= 8 {
                        code.push(rex(false, dn >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, load_op]);
                    modrm_mem(code, dn & 7, base, disp);
                }
                (s, Concrete::Mem { base, disp, .. }) if xmm(&s).is_some() => {
                    let sn = xmm(&s).unwrap();
                    if sn >= 8 || base >= 8 {
                        code.push(rex(false, sn >= 8, false, base >= 8));
                    }
                    code.extend_from_slice(&[0x0F, store_op]);
                    modrm_mem(code, sn & 7, base, disp);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: SSE move needs an xmm register with an xmm or memory operand",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::SseShufImm { prefix, opcode } => {
            // `<op> $imm, %xmm_src, %xmm_dst`: <prefix> [REX] 0F <opcode> /r ib.
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let [imm, src, dst] = ops else {
                return Err(String::from(
                    "inline asm: shuffle needs $imm, %xmm_src, %xmm_dst",
                ));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: shuffle immediate expected"));
            };
            let (Some(d), Some(s)) = (xmm(dst), xmm(src)) else {
                return Err(String::from("inline asm: shuffle operands must be xmm"));
            };
            if prefix != 0 {
                code.push(prefix);
            }
            if d >= 8 || s >= 8 {
                code.push(rex(false, d >= 8, false, s >= 8));
            }
            code.extend_from_slice(&[0x0F, opcode]);
            code.push(modrm_reg(d & 7, s & 7));
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::SseShiftImm { opcode, digit } => {
            // `<op> $imm, %xmm`: 66 [REX.B] 0F <opcode> /digit ib. The opcode
            // extension `digit` rides ModRM.reg, the xmm sits in r/m.
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let [imm, reg] = ops else {
                return Err(String::from("inline asm: packed shift needs $imm, %xmm"));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: packed shift immediate expected"));
            };
            let Some(r) = xmm(reg) else {
                return Err(String::from("inline asm: packed shift operand must be xmm"));
            };
            code.push(0x66);
            if r >= 8 {
                code.push(rex(false, false, false, true));
            }
            code.extend_from_slice(&[0x0F, opcode]);
            code.push(modrm_reg(digit, r & 7));
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::Vex { pp, map, w, opcode } => {
            // 3-operand VEX: dst in ModRM.reg, src1 in VEX.vvvv (inverted), src2
            // in ModRM.rm. `L` is set when any operand is a ymm.
            let [src2, src1, dst] = ops else {
                return Err(String::from("inline asm: VEX op needs %src2, %src1, %dst"));
            };
            let (Some((d, dy)), Some((s1, s1y))) = (vec_reg(dst), vec_reg(src1)) else {
                return Err(String::from("inline asm: VEX dst / src1 must be xmm/ymm"));
            };
            match src2 {
                _ if vec_reg(src2).is_some() => {
                    let (s2, s2y) = vec_reg(src2).unwrap();
                    let l = u8::from(dy || s1y || s2y);
                    emit_vex(code, d >= 8, false, s2 >= 8, map, w, s1, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s2 & 7));
                }
                Concrete::Mem { base, disp, .. } => {
                    // src2 is a memory operand: VEX.B carries the base's high bit;
                    // L comes from the register operands.
                    let l = u8::from(dy || s1y);
                    emit_vex(code, d >= 8, false, *base >= 8, map, w, s1, l, pp);
                    code.push(opcode);
                    modrm_mem(code, d & 7, *base, *disp);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: VEX src2 must be xmm/ymm or memory",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        } => {
            // 2-operand VEX move (VEX.vvvv = 1111, passed as 0 to `emit_vex`).
            let [src, dst] = two(ops)?;
            if let Some((d, dy)) = vec_reg(&dst) {
                // reg-reg or load: the destination register rides ModRM.reg.
                match &src {
                    _ if vec_reg(&src).is_some() => {
                        let (s, sy) = vec_reg(&src).unwrap();
                        emit_vex(
                            code,
                            d >= 8,
                            false,
                            s >= 8,
                            1,
                            false,
                            0,
                            u8::from(dy || sy),
                            pp,
                        );
                        code.push(load_op);
                        code.push(modrm_reg(d & 7, s & 7));
                    }
                    Concrete::Mem { base, disp, .. } => {
                        emit_vex(
                            code,
                            d >= 8,
                            false,
                            *base >= 8,
                            1,
                            false,
                            0,
                            u8::from(dy),
                            pp,
                        );
                        code.push(load_op);
                        modrm_mem(code, d & 7, *base, *disp);
                    }
                    _ => {
                        return Err(String::from(
                            "inline asm: VEX move source must be xmm/ymm/mem",
                        ));
                    }
                }
            } else if let (Some((s, sy)), Concrete::Mem { base, disp, .. }) = (vec_reg(&src), &dst)
            {
                // store: the source register rides ModRM.reg, memory the r/m.
                emit_vex(
                    code,
                    s >= 8,
                    false,
                    *base >= 8,
                    1,
                    false,
                    0,
                    u8::from(sy),
                    pp,
                );
                code.push(store_op);
                modrm_mem(code, s & 7, *base, *disp);
            } else {
                return Err(String::from("inline asm: unsupported VEX move operands"));
            }
            Ok(())
        }
        Mnemonic::Vex2 { pp, map, opcode } => {
            // 2-operand VEX op (VEX.vvvv = 1111), src a register or memory.
            let [src, dst] = two(ops)?;
            let Some((d, dy)) = vec_reg(&dst) else {
                return Err(String::from("inline asm: VEX2 destination must be xmm/ymm"));
            };
            match &src {
                _ if vec_reg(&src).is_some() => {
                    let (s, sy) = vec_reg(&src).unwrap();
                    emit_vex(
                        code,
                        d >= 8,
                        false,
                        s >= 8,
                        map,
                        false,
                        0,
                        u8::from(dy || sy),
                        pp,
                    );
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                Concrete::Mem { base, disp, .. } => {
                    emit_vex(
                        code,
                        d >= 8,
                        false,
                        *base >= 8,
                        map,
                        false,
                        0,
                        u8::from(dy),
                        pp,
                    );
                    code.push(opcode);
                    modrm_mem(code, d & 7, *base, *disp);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: VEX2 source must be xmm/ymm or memory",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::VexImm3 { pp, map, opcode } => {
            // `v-op $imm, %src2, %src1, %dst`: the 3-operand VEX with a trailing
            // immediate byte; src2 may be a register or memory operand.
            let [imm, src2, src1, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX shuffle needs $imm, %src2, %src1, %dst",
                ));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: VEX shuffle immediate expected"));
            };
            let (Some((d, dy)), Some((s1, s1y))) = (vec_reg(dst), vec_reg(src1)) else {
                return Err(String::from(
                    "inline asm: VEX shuffle dst / src1 must be xmm/ymm",
                ));
            };
            match src2 {
                _ if vec_reg(src2).is_some() => {
                    let (s2, s2y) = vec_reg(src2).unwrap();
                    let l = u8::from(dy || s1y || s2y);
                    emit_vex(code, d >= 8, false, s2 >= 8, map, false, s1, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s2 & 7));
                }
                Concrete::Mem { base, disp, .. } => {
                    let l = u8::from(dy || s1y);
                    emit_vex(code, d >= 8, false, *base >= 8, map, false, s1, l, pp);
                    code.push(opcode);
                    modrm_mem(code, d & 7, *base, *disp);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: VEX shuffle src2 must be xmm/ymm or memory",
                    ));
                }
            }
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::VexImm2 { pp, map, opcode } => {
            // `v-op $imm, %src, %dst`: a 2-operand VEX (VEX.vvvv = 1111) + imm;
            // src may be a register or memory operand.
            let [imm, src, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX shuffle needs $imm, %src, %dst",
                ));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: VEX shuffle immediate expected"));
            };
            let Some((d, dy)) = vec_reg(dst) else {
                return Err(String::from(
                    "inline asm: VEX shuffle destination must be xmm/ymm",
                ));
            };
            match src {
                _ if vec_reg(src).is_some() => {
                    let (s, sy) = vec_reg(src).unwrap();
                    let l = u8::from(dy || sy);
                    emit_vex(code, d >= 8, false, s >= 8, map, false, 0, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                Concrete::Mem { base, disp, .. } => {
                    emit_vex(
                        code,
                        d >= 8,
                        false,
                        *base >= 8,
                        map,
                        false,
                        0,
                        u8::from(dy),
                        pp,
                    );
                    code.push(opcode);
                    modrm_mem(code, d & 7, *base, *disp);
                }
                _ => {
                    return Err(String::from(
                        "inline asm: VEX shuffle source must be xmm/ymm or memory",
                    ));
                }
            }
            code.push(*ib as u8);
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
                Concrete::Mem { .. } | Concrete::AbsMem { .. } => {
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
            // `movq` with an XMM operand is the SSE quadword move, not a GP mov.
            if movq_xmm(code, src, dst) {
                return Ok(());
            }
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
        // table encoder above; reaching here means the catalogue has no form
        // matching these operands, so report the mnemonic as written.
        Mnemonic::Table(name) => Err(format!(
            "inline asm: `{name}` has no x86-64 encoding for these operands"
        )),
        _ => Err(format!(
            "inline asm: unsupported instruction `{mnemonic:?}`"
        )),
    }
}

fn as_reg(op: Concrete) -> Result<(u8, AsmRegSize), String> {
    match op {
        Concrete::Reg { reg, size } => Ok((reg, size)),
        Concrete::Mem { .. } | Concrete::AbsMem { .. } => {
            Err(String::from("inline asm: unexpected memory operand"))
        }
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

    /// Parse a template of explicit-operand instructions (no `%N` refs),
    /// resolve them the way the emitter does (memory width from the suffix,
    /// else a GP register operand, else quad), and encode. For templates
    /// whose expected bytes are byte-verified against clang.
    pub(super) fn asm_bytes(tmpl: &[u8]) -> Vec<u8> {
        let mut out = Vec::new();
        for insn in parse_template(tmpl).unwrap() {
            let mem_size = insn.suffix.or_else(|| {
                insn.operands.iter().find_map(|o| match *o {
                    AsmOpnd::Reg { reg, size } if reg < 16 => Some(size),
                    _ => None,
                })
            });
            let reg_of = |b: AsmMemBase| match b {
                AsmMemBase::Reg(r) => r,
                AsmMemBase::Ref(_) => panic!("explicit-register template expected"),
            };
            let ops: Vec<Concrete> = insn
                .operands
                .iter()
                .map(|o| match *o {
                    AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
                    AsmOpnd::Imm(v) => Concrete::Imm(v),
                    AsmOpnd::Mem {
                        base,
                        index,
                        scale,
                        disp,
                    } => Concrete::Mem {
                        base: reg_of(base),
                        index: index.map(reg_of),
                        scale,
                        disp,
                        size: mem_size.unwrap_or(AsmRegSize::Quad),
                    },
                    AsmOpnd::AbsMem { disp } => Concrete::AbsMem {
                        disp,
                        size: mem_size.unwrap_or(AsmRegSize::Quad),
                    },
                    other => panic!("unexpected operand {other:?}"),
                })
                .collect();
            if let Some(seg) = insn.seg {
                out.push(seg);
            }
            encode(&mut out, insn.mnemonic, insn.suffix, &ops).unwrap();
        }
        out
    }

    #[test]
    fn explicit_memory_operands() {
        // Every addressing shape vs clang: disp0 / disp8 / disp32, negative
        // displacements, and the rbp/r13 (no mod=00 form) and rsp/r12 (SIB)
        // corners. Expected bytes from `clang --target=x86_64-unknown-linux-gnu`.
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"mov %%rbx, (%%rdx)",      &[0x48, 0x89, 0x1a]),
            (b"mov %%rbp, 8(%%rdx)",     &[0x48, 0x89, 0x6a, 0x08]),
            (b"mov %%r12, 16(%%rdx)",    &[0x4c, 0x89, 0x62, 0x10]),
            (b"mov %%rsp, 24(%%rdx)",    &[0x48, 0x89, 0x62, 0x18]),
            (b"movq (%%rax), %%rbx",     &[0x48, 0x8b, 0x18]),
            (b"movq 72(%%rax), %%rsi",   &[0x48, 0x8b, 0x70, 0x48]),
            (b"mov %%rax, (%%rsp)",      &[0x48, 0x89, 0x04, 0x24]),
            (b"mov %%rax, 8(%%rsp)",     &[0x48, 0x89, 0x44, 0x24, 0x08]),
            (b"mov %%rax, (%%rbp)",      &[0x48, 0x89, 0x45, 0x00]),
            (b"mov %%rax, -16(%%rbp)",   &[0x48, 0x89, 0x45, 0xf0]),
            (b"mov %%rax, (%%r12)",      &[0x49, 0x89, 0x04, 0x24]),
            (b"mov %%rax, 8(%%r12)",     &[0x49, 0x89, 0x44, 0x24, 0x08]),
            (b"mov %%rax, (%%r13)",      &[0x49, 0x89, 0x45, 0x00]),
            (b"mov %%rax, -8(%%r13)",    &[0x49, 0x89, 0x45, 0xf8]),
            (b"mov %%rax, 127(%%rdx)",   &[0x48, 0x89, 0x42, 0x7f]),
            (b"mov %%rax, 128(%%rdx)",   &[0x48, 0x89, 0x82, 0x80, 0x00, 0x00, 0x00]),
            (b"mov %%rax, -128(%%rdx)",  &[0x48, 0x89, 0x42, 0x80]),
            (b"mov %%rax, -129(%%rdx)",  &[0x48, 0x89, 0x82, 0x7f, 0xff, 0xff, 0xff]),
            (b"mov %%rax, 4096(%%r15)",  &[0x49, 0x89, 0x87, 0x00, 0x10, 0x00, 0x00]),
            (b"movl %%ebx, 4(%%rdx)",    &[0x89, 0x5a, 0x04]),
            (b"movw %%ax, 2(%%rdx)",     &[0x66, 0x89, 0x42, 0x02]),
            (b"movb %%al, 1(%%rdx)",     &[0x88, 0x42, 0x01]),
            (b"movb %%al, 1(%%r13)",     &[0x41, 0x88, 0x45, 0x01]),
            (b"addq $7, 16(%%rdx)",      &[0x48, 0x83, 0x42, 0x10, 0x07]),
            (b"incq (%%r13)",            &[0x49, 0xff, 0x45, 0x00]),
            // Indirect branches through a register.
            (b"jmp *%%rdx",              &[0xff, 0xe2]),
            (b"jmp *%%r9",               &[0x41, 0xff, 0xe1]),
            (b"call *%%rax",             &[0xff, 0xd0]),
            // SSE moves / ops with a displaced memory operand (the bespoke
            // encode arms, not the table).
            (b"movdqa %%xmm1, 16(%%rdx)", &[0x66, 0x0f, 0x7f, 0x4a, 0x10]),
            (b"movdqa 32(%%rsp), %%xmm2", &[0x66, 0x0f, 0x6f, 0x54, 0x24, 0x20]),
            (b"movups %%xmm3, -16(%%rbp)", &[0x0f, 0x11, 0x5d, 0xf0]),
            (b"paddd 8(%%rcx), %%xmm5",  &[0x66, 0x0f, 0xfe, 0x69, 0x08]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn byte_word_imm_to_memory_alu() {
        // The 80 / 66 81 / 66 83 /digit immediate-to-memory family plus
        // mov (C6 / 66 C7) and test (F6 / 66 F7), with the access width
        // taken from the AT&T suffix or a register operand. Expected bytes
        // from `clang --target=x86_64-unknown-linux-gnu`.
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"addb $0x11, 16(%%rdx)",   &[0x80, 0x42, 0x10, 0x11]),
            (b"orb $0x22, (%%rdx)",      &[0x80, 0x0a, 0x22]),
            (b"adcb $0x33, (%%rdx)",     &[0x80, 0x12, 0x33]),
            (b"sbbb $0x44, (%%rdx)",     &[0x80, 0x1a, 0x44]),
            (b"andb $0x55, (%%rdx)",     &[0x80, 0x22, 0x55]),
            (b"subb $0x66, (%%rdx)",     &[0x80, 0x2a, 0x66]),
            (b"xorb $0x80, (%%rdx)",     &[0x80, 0x32, 0x80]),
            (b"cmpb $0x77, (%%rdx)",     &[0x80, 0x3a, 0x77]),
            (b"movb $0x42, (%%rdx)",     &[0xc6, 0x02, 0x42]),
            (b"testb $0x01, (%%rdx)",    &[0xf6, 0x02, 0x01]),
            (b"addw $0x1111, 16(%%rdx)", &[0x66, 0x81, 0x42, 0x10, 0x11, 0x11]),
            (b"orw $0x2222, (%%rdx)",    &[0x66, 0x81, 0x0a, 0x22, 0x22]),
            (b"adcw $0x3333, (%%rdx)",   &[0x66, 0x81, 0x12, 0x33, 0x33]),
            (b"sbbw $0x4444, (%%rdx)",   &[0x66, 0x81, 0x1a, 0x44, 0x44]),
            (b"andw $0x5555, (%%rdx)",   &[0x66, 0x81, 0x22, 0x55, 0x55]),
            (b"subw $0x6666, (%%rdx)",   &[0x66, 0x81, 0x2a, 0x66, 0x66]),
            (b"xorw $0x8000, (%%rdx)",   &[0x66, 0x81, 0x32, 0x00, 0x80]),
            (b"cmpw $0x7777, (%%rdx)",   &[0x66, 0x81, 0x3a, 0x77, 0x77]),
            (b"movw $0x4242, (%%rdx)",   &[0x66, 0xc7, 0x02, 0x42, 0x42]),
            (b"testw $0x0101, (%%rdx)",  &[0x66, 0xf7, 0x02, 0x01, 0x01]),
            // A small word immediate takes the 83 imms8 short form.
            (b"addw $8, (%%rdx)",        &[0x66, 0x83, 0x02, 0x08]),
            // REX.B bases (r13 forces disp8=0, r12 forces a SIB).
            (b"xorb $0x80, (%%r13)",     &[0x41, 0x80, 0x75, 0x00, 0x80]),
            (b"xorw $0x8000, 3(%%r12)",  &[0x66, 0x41, 0x81, 0x74, 0x24, 0x03, 0x00, 0x80]),
            // No suffix: a register operand fixes the access width.
            (b"xor %%bl, (%%rdx)",       &[0x30, 0x1a]),
            (b"xor %%cx, (%%rdx)",       &[0x66, 0x31, 0x0a]),
            // The same width selection drives the unary and shift groups.
            (b"notb (%%rdx)",            &[0xf6, 0x12]),
            (b"negb (%%rdx)",            &[0xf6, 0x1a]),
            (b"incb (%%rdx)",            &[0xfe, 0x02]),
            (b"decb (%%rdx)",            &[0xfe, 0x0a]),
            (b"shlb $3, (%%rdx)",        &[0xc0, 0x22, 0x03]),
            (b"shrw $3, (%%rdx)",        &[0x66, 0xc1, 0x2a, 0x03]),
            (b"notw (%%rdx)",            &[0x66, 0xf7, 0x12]),
            (b"incw (%%rdx)",            &[0x66, 0xff, 0x02]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn segment_and_sib_operands() {
        // Segment-override and scaled-index forms vs clang
        // (`clang --target=x86_64-unknown-linux-gnu`).
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            // %%gs:disp absolute (mod=00 rm=100, SIB 0x25, disp32), the
            // seg prefix first (before 66 / REX).
            (b"movq %%gs:0x28, %%rax", &[0x65, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00]),
            (b"movl %%gs:0x10, %%ecx", &[0x65, 0x8b, 0x0c, 0x25, 0x10, 0x00, 0x00, 0x00]),
            (b"movq %%rbx, %%gs:0x28", &[0x65, 0x48, 0x89, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00]),
            (b"movq %%fs:0x0, %%r9",   &[0x64, 0x4c, 0x8b, 0x0c, 0x25, 0x00, 0x00, 0x00, 0x00]),
            (b"addq $1, %%gs:0x30",
             &[0x65, 0x48, 0x83, 0x04, 0x25, 0x30, 0x00, 0x00, 0x00, 0x01]),
            (b"movw %%gs:0x40, %%dx",  &[0x65, 0x66, 0x8b, 0x14, 0x25, 0x40, 0x00, 0x00, 0x00]),
            (b"movb %%gs:0x5, %%al",   &[0x65, 0x8a, 0x04, 0x25, 0x05, 0x00, 0x00, 0x00]),
            (b"movq %%gs:0x28, %%r12", &[0x65, 0x4c, 0x8b, 0x24, 0x25, 0x28, 0x00, 0x00, 0x00]),
            // Segment prefix on a based reference.
            (b"movq %%gs:8(%%rdx), %%rax", &[0x65, 0x48, 0x8b, 0x42, 0x08]),
            // SIB forms `disp(%%base, %%index, scale)` / `(%%base, %%index)`.
            (b"movq (%%rax,%%rbx,4), %%rcx",    &[0x48, 0x8b, 0x0c, 0x98]),
            (b"movq 8(%%rax,%%rbx,8), %%rcx",   &[0x48, 0x8b, 0x4c, 0xd8, 0x08]),
            (b"movl -4(%%r8,%%r9,2), %%edx",    &[0x43, 0x8b, 0x54, 0x48, 0xfc]),
            (b"movq (%%rax,%%rbx), %%rcx",      &[0x48, 0x8b, 0x0c, 0x18]),
            (b"leaq (%%rax,%%rbx,4), %%rcx",    &[0x48, 0x8d, 0x0c, 0x98]),
            (b"movq %%rcx, 16(%%rsp,%%rdx)",    &[0x48, 0x89, 0x4c, 0x14, 0x10]),
            (b"movb %%cl, 3(%%rbp,%%rdi,2)",    &[0x88, 0x4c, 0x7d, 0x03]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn const_modifier_refs() {
        // `%cN` / `%PN` parse to bare-constant operand references.
        let insns = parse_template(b"lea %P0, %%rax").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RefConst {
                idx: 0,
                symbolic: true
            }
        );
        // A data directive referencing an operand defers to emit time,
        // carrying the directive width.
        let insns = parse_template(b".long %c0").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::Data(4));
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RefConst {
                idx: 0,
                symbolic: false
            }
        );
        let insns = parse_template(b".quad %c1, 7").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::Data(8));
        assert_eq!(insns[0].operands[1], AsmOpnd::Imm(7));
        // A constant-only directive stays on the raw-byte path.
        let insns = parse_template(b".long 42").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::RawBytes);
    }

    #[test]
    fn uniq_escape_and_labels() {
        // `%=` gets one number per parse, shared across the template; the
        // label definition and the `lea LABEL(%rip)` reference intern to the
        // same named-label id.
        let insns =
            parse_template(b"lea LJMPRET%=(%%rip), %%rcx\n\tmov %%rbx, (%%rdx)\n\tLJMPRET%=:\n\t")
                .unwrap();
        let AsmOpnd::LabelAddr { num, .. } = insns[0].operands[0] else {
            panic!("lea operand should be a label address");
        };
        assert!(num >= NAMED_LABEL_BASE);
        assert_eq!(insns[2].label_def, Some(num));
        // `.cfi_*` directives parse to nothing.
        let insns =
            parse_template(b".cfi_def_cfa %%rdx, 0\n\t.cfi_offset %%rbx, 0\n\tnop").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, Mnemonic::Nop);
        // A jump to a named label parses as a label operand, not a symbol.
        let insns = parse_template(b"jmp done%=\n\tnop\n\tdone%=:").unwrap();
        assert!(insns[0].sym_target.is_none());
        assert!(matches!(insns[0].operands[0], AsmOpnd::Label { .. }));
        // Numeric-label addresses take a direction suffix.
        let insns = parse_template(b"1:\n\tlea 1b(%%rip), %%rax").unwrap();
        assert!(matches!(
            insns[1].operands[0],
            AsmOpnd::LabelAddr {
                num: 1,
                forward: false
            }
        ));
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
        // Integer pack / multiply-add / high-multiply / high-unpack forms
        // (byte-verified against clang: `<66> 0F <op> C1` for src=xmm1,dst=xmm0).
        for (name, op) in [
            ("packsswb", 0x63u8),
            ("packssdw", 0x6B),
            ("packuswb", 0x67),
            ("pmaddwd", 0xF5),
            ("pmulhw", 0xE5),
            ("punpckhbw", 0x68),
            ("punpckhwd", 0x69),
        ] {
            assert_eq!(
                sse2_op(name),
                Some(Mnemonic::Sse2Rr {
                    prefix: 0x66,
                    opcode: op
                })
            );
            assert_eq!(
                enc(sse(0x66, op), None, &[xmm(1), xmm(0)]),
                [0x66, 0x0F, op, 0xC1]
            );
        }
        // Packed-single float ops: unpck/sqrt (no prefix) and the int<->float
        // convert trio (cvtdq2ps none, cvtps2dq 0x66, cvttps2dq 0xF3). Prefix 0
        // emits no leading byte. Byte-exact vs clang.
        for (name, prefix, op) in [
            ("unpcklps", 0u8, 0x14u8),
            ("unpckhps", 0, 0x15),
            ("sqrtps", 0, 0x51),
            ("cvtdq2ps", 0, 0x5B),
            ("cvtps2dq", 0x66, 0x5B),
            ("cvttps2dq", 0xF3, 0x5B),
        ] {
            assert_eq!(sse2_op(name), Some(Mnemonic::Sse2Rr { prefix, opcode: op }));
            let got = enc(sse(prefix, op), None, &[xmm(1), xmm(0)]);
            if prefix == 0 {
                assert_eq!(got, [0x0F, op, 0xC1]);
            } else {
                assert_eq!(got, [prefix, 0x0F, op, 0xC1]);
            }
        }
        // A `(%base)` memory source rides r/m through modrm_mem; a high
        // destination still sets REX.R, a high base REX.B.
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
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
            index: None,
            scale: 1,
            disp: 0,
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
    fn sse_imm_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let imm = Concrete::Imm;
        // pshuf*: <prefix> 0F 70 /r ib, dst in ModRM.reg, src in r/m.
        assert_eq!(
            enc(
                Mnemonic::SseShufImm {
                    prefix: 0x66,
                    opcode: 0x70
                },
                None,
                &[imm(0x1b), xmm(1), xmm(2)]
            ),
            [0x66, 0x0F, 0x70, 0xD1, 0x1B]
        ); // pshufd $0x1b,%xmm1,%xmm2
        assert_eq!(
            enc(
                Mnemonic::SseShufImm {
                    prefix: 0xF2,
                    opcode: 0x70
                },
                None,
                &[imm(0x4e), xmm(1), xmm(2)]
            ),
            [0xF2, 0x0F, 0x70, 0xD1, 0x4E]
        ); // pshuflw
        assert_eq!(
            enc(
                Mnemonic::SseShufImm {
                    prefix: 0x66,
                    opcode: 0x70
                },
                None,
                &[imm(0x1b), xmm(9), xmm(10)]
            ),
            [0x66, 0x45, 0x0F, 0x70, 0xD1, 0x1B]
        ); // high xmm -> REX.R+REX.B
        // shift-by-imm: 66 0F opcode /digit ib; the digit is the opcode
        // extension in ModRM.reg, the xmm in r/m.
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x72,
                    digit: 6
                },
                None,
                &[imm(3), xmm(0)]
            ),
            [0x66, 0x0F, 0x72, 0xF0, 0x03]
        ); // pslld $3,%xmm0
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x73,
                    digit: 3
                },
                None,
                &[imm(8), xmm(1)]
            ),
            [0x66, 0x0F, 0x73, 0xD9, 0x08]
        ); // psrldq $8,%xmm1
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x72,
                    digit: 6
                },
                None,
                &[imm(3), xmm(11)]
            ),
            [0x66, 0x41, 0x0F, 0x72, 0xF3, 0x03]
        ); // high xmm -> REX.B
        // The tables resolve names.
        assert_eq!(
            sse_imm("pshufd"),
            Some(Mnemonic::SseShufImm {
                prefix: 0x66,
                opcode: 0x70
            })
        );
        // shuf{ps,pd}: opcode 0xC6, ps with no prefix, pd with 0x66. Byte-exact
        // vs clang: `0f c6 c1 1b` and `66 0f c6 c1 01`.
        assert_eq!(
            sse_imm("shufps"),
            Some(Mnemonic::SseShufImm {
                prefix: 0,
                opcode: 0xC6
            })
        );
        assert_eq!(
            enc(
                Mnemonic::SseShufImm {
                    prefix: 0,
                    opcode: 0xC6
                },
                None,
                &[imm(0x1b), xmm(1), xmm(0)]
            ),
            [0x0F, 0xC6, 0xC1, 0x1B]
        ); // shufps $0x1b,%xmm1,%xmm0
        assert_eq!(
            enc(
                Mnemonic::SseShufImm {
                    prefix: 0x66,
                    opcode: 0xC6
                },
                None,
                &[imm(1), xmm(1), xmm(0)]
            ),
            [0x66, 0x0F, 0xC6, 0xC1, 0x01]
        ); // shufpd $1,%xmm1,%xmm0
        assert_eq!(
            sse_imm("psllq"),
            Some(Mnemonic::SseShiftImm {
                opcode: 0x73,
                digit: 6
            })
        );
        assert_eq!(sse_imm("not_an_op"), None);
    }

    #[test]
    fn movq_xmm_forms() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let gp = |n: u8| Concrete::Reg {
            reg: n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let mov = |ops: &[Concrete]| enc(Mnemonic::Mov, None, ops);
        // GP64<->xmm: 66 REX.W 0F 6E/7E.
        assert_eq!(mov(&[gp(0), xmm(0)]), [0x66, 0x48, 0x0F, 0x6E, 0xC0]); // movq %rax,%xmm0
        assert_eq!(mov(&[xmm(0), gp(0)]), [0x66, 0x48, 0x0F, 0x7E, 0xC0]); // movq %xmm0,%rax
        assert_eq!(mov(&[gp(9), xmm(3)]), [0x66, 0x49, 0x0F, 0x6E, 0xD9]); // movq %r9,%xmm3
        // xmm<->xmm and mem->xmm load: F3 0F 7E; xmm->mem store: 66 0F D6.
        assert_eq!(mov(&[xmm(0), xmm(1)]), [0xF3, 0x0F, 0x7E, 0xC8]); // movq %xmm0,%xmm1
        assert_eq!(mov(&[mem(0), xmm(0)]), [0xF3, 0x0F, 0x7E, 0x00]); // movq (%rax),%xmm0
        assert_eq!(mov(&[xmm(0), mem(0)]), [0x66, 0x0F, 0xD6, 0x00]); // movq %xmm0,(%rax)
        assert_eq!(mov(&[xmm(9), xmm(10)]), [0xF3, 0x45, 0x0F, 0x7E, 0xD1]); // high xmm
        // A plain GP move (no xmm) still encodes normally.
        assert_eq!(mov(&[gp(0), gp(3)]), [0x48, 0x89, 0xC3]); // movq %rax,%rbx
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

    #[test]
    fn assign_fp_operands_to_xmm() {
        use crate::c5::ir::{AsmConstraint as C, AsmOperand};
        let op = |constraint| AsmOperand {
            constraint,
            is_output: false,
            is_rw: false,
            width: 16,
        };
        // `x` operands take xmm0, xmm1, ... from a file independent of the GPRs,
        // so a mixed GP + xmm operand list assigns each from its own pool.
        let ops = [op(C::Reg), op(C::Fp), op(C::Reg), op(C::Fp)];
        let a = assign_operand_regs(&ops, 0).unwrap();
        assert_eq!(a, [Some(0), Some(0), Some(3), Some(1)]); // rax, xmm0, rbx, xmm1
        // An xmm named in the clobber list is skipped: xmm0 clobbered pushes the
        // first `x` operand onto xmm1.
        let a = assign_operand_regs(&[op(C::Fp), op(C::Fp)], 1 << 0).unwrap();
        assert_eq!(a, [Some(1), Some(2)]);
    }

    #[test]
    fn vex_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let vex = |pp, opcode| Mnemonic::Vex {
            pp,
            map: 1,
            w: false,
            opcode,
        };
        // 3-operand VEX, AT&T `v-op %src2, %src1, %dst`. Byte-exact vs clang.
        // vaddps %xmm2,%xmm1,%xmm0: 2-byte VEX.
        assert_eq!(
            enc(vex(0, 0x58), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF0, 0x58, 0xC2]
        );
        // ymm sets the L bit.
        assert_eq!(
            enc(vex(0, 0x58), None, &[ymm(2), ymm(1), ymm(0)]),
            [0xC5, 0xF4, 0x58, 0xC2]
        );
        // A high src2 needs the 3-byte VEX (C4) form for VEX.B.
        assert_eq!(
            enc(vex(0, 0x58), None, &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x41, 0x30, 0x58, 0xC2]
        );
        // pp selects the SSE prefix: 0x66 (vpaddd), 0xF3 (vaddss).
        assert_eq!(
            enc(vex(1, 0xFE), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF1, 0xFE, 0xC2]
        );
        assert_eq!(
            enc(vex(2, 0x58), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF2, 0x58, 0xC2]
        );
        // vmulsd %xmm12,%xmm1,%xmm3: 3-byte VEX (high src2), pp = 0xF2.
        assert_eq!(
            enc(vex(3, 0x59), None, &[xmm(12), xmm(1), xmm(3)]),
            [0xC4, 0xC1, 0x73, 0x59, 0xDC]
        );
        // vpmulld: 0F38 map forces the 3-byte VEX (c4 e2 71 40 c2 for
        // %xmm2,%xmm1,%xmm0). vshufps: 3-operand + imm. vpshufd: 2-operand + imm.
        assert_eq!(
            enc(
                Mnemonic::Vex {
                    pp: 1,
                    map: 2,
                    w: false,
                    opcode: 0x40
                },
                None,
                &[xmm(2), xmm(1), xmm(0)]
            ),
            [0xC4, 0xE2, 0x71, 0x40, 0xC2]
        );
        assert_eq!(
            enc(
                Mnemonic::VexImm3 {
                    pp: 0,
                    map: 1,
                    opcode: 0xC6
                },
                None,
                &[Concrete::Imm(0x1b), xmm(2), xmm(1), xmm(0)]
            ),
            [0xC5, 0xF0, 0xC6, 0xC2, 0x1B]
        );
        assert_eq!(
            enc(
                Mnemonic::VexImm2 {
                    pp: 1,
                    map: 1,
                    opcode: 0x70
                },
                None,
                &[Concrete::Imm(0x1b), xmm(1), xmm(0)]
            ),
            [0xC5, 0xF9, 0x70, 0xC1, 0x1B]
        );
        // The table resolves names.
        assert_eq!(
            vex_op("vaddps"),
            Some(Mnemonic::Vex {
                pp: 0,
                map: 1,
                w: false,
                opcode: 0x58
            })
        );
        assert_eq!(
            vex_op("vpmulld"),
            Some(Mnemonic::Vex {
                pp: 1,
                map: 2,
                w: false,
                opcode: 0x40
            })
        );
        assert_eq!(
            vex_op("vshufps"),
            Some(Mnemonic::VexImm3 {
                pp: 0,
                map: 1,
                opcode: 0xC6
            })
        );
        assert_eq!(vex_op("not_a_vex"), None);
        // 2-operand VEX moves (VEX.vvvv = 1111): reg-reg uses load_op, a store
        // to memory uses store_op. Byte-exact vs clang.
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let vmov = |pp, load_op, store_op| Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        };
        // vmovdqu %ymm1,%ymm0 (F3, L=1): c5 fe 6f c1.
        assert_eq!(
            enc(vmov(2, 0x6F, 0x7F), None, &[ymm(1), ymm(0)]),
            [0xC5, 0xFE, 0x6F, 0xC1]
        );
        // vmovdqu %ymm0,(%rax) store: c5 fe 7f 00.
        assert_eq!(
            enc(vmov(2, 0x6F, 0x7F), None, &[ymm(0), mem(0)]),
            [0xC5, 0xFE, 0x7F, 0x00]
        );
        // vmovups (%rcx),%ymm2 load (no prefix): c5 fc 10 11.
        assert_eq!(
            enc(vmov(0, 0x10, 0x11), None, &[mem(1), ymm(2)]),
            [0xC5, 0xFC, 0x10, 0x11]
        );
        // 2-operand VEX compute: vsqrtps %ymm1,%ymm0: c5 fc 51 c1.
        assert_eq!(
            enc(
                Mnemonic::Vex2 {
                    pp: 0,
                    map: 1,
                    opcode: 0x51
                },
                None,
                &[ymm(1), ymm(0)]
            ),
            [0xC5, 0xFC, 0x51, 0xC1]
        );
        // 3-operand VEX with a memory src2: vaddps (%rax),%ymm1,%ymm0: c5 f4 58 00.
        assert_eq!(
            enc(vex(0, 0x58), None, &[mem(0), ymm(1), ymm(0)]),
            [0xC5, 0xF4, 0x58, 0x00]
        );
        assert_eq!(
            vex_op("vmovdqu"),
            Some(Mnemonic::VexMov {
                pp: 2,
                load_op: 0x6F,
                store_op: 0x7F
            })
        );
        assert_eq!(
            vex_op("vsqrtps"),
            Some(Mnemonic::Vex2 {
                pp: 0,
                map: 1,
                opcode: 0x51
            })
        );
    }

    #[test]
    fn vex_0f38_0f3a_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let e = |name: &str, ops: &[Concrete]| enc(vex_op(name).unwrap(), None, ops);
        // 0F38 variable shifts: W selects dword (0) / qword (1) elements.
        // Byte-exact vs clang.
        assert_eq!(
            e("vpsllvd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x42, 0x31, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsrlvd", &[ymm(12), ymm(11), ymm(10)]),
            [0xC4, 0x42, 0x25, 0x45, 0xD4]
        );
        assert_eq!(
            e("vpsravd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x46, 0xC2]
        );
        assert_eq!(
            e("vpsllvq", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0xF1, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsrlvq", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0xF5, 0x45, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[mem(0), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x47, 0x00]
        );
        // vpermd (ymm only).
        assert_eq!(
            e("vpermd", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0x36, 0xC2]
        );
        // FMA: ps is W0, pd W1; one op per 132/213/231 group plus a memory
        // source and high registers.
        assert_eq!(
            e("vfmadd132ps", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x98, 0xC2]
        );
        assert_eq!(
            e("vfmadd213ps", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0xA8, 0xC2]
        );
        assert_eq!(
            e("vfmadd231pd", &[ymm(12), ymm(9), ymm(8)]),
            [0xC4, 0x42, 0xB5, 0xB8, 0xC4]
        );
        assert_eq!(
            e("vfmsub213pd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0xF1, 0xAA, 0xC2]
        );
        assert_eq!(
            e("vfnmadd231ps", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0xBC, 0xC2]
        );
        assert_eq!(
            e("vfnmsub132ps", &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x42, 0x31, 0x9E, 0xC2]
        );
        assert_eq!(
            e("vfmadd231pd", &[mem(8), ymm(1), ymm(0)]),
            [0xC4, 0xC2, 0xF5, 0xB8, 0x00]
        );
        // 0F38 broadcasts (2-operand): L follows the destination.
        assert_eq!(
            e("vpbroadcastb", &[xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x79, 0x78, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastw", &[xmm(1), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x79, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastd", &[xmm(9), ymm(8)]),
            [0xC4, 0x42, 0x7D, 0x58, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastq", &[xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x79, 0x59, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastd", &[mem(0), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x58, 0x00]
        );
        assert_eq!(
            e("vbroadcastss", &[mem(9), ymm(2)]),
            [0xC4, 0xC2, 0x7D, 0x18, 0x11]
        );
        // 0F3A immediate forms.
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x79, 0x04, 0xC1, 0x1B]
        );
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), xmm(9), xmm(8)]),
            [0xC4, 0x43, 0x79, 0x04, 0xC1, 0x1B]
        );
        assert_eq!(
            e("vpermilpd", &[Concrete::Imm(0x5), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x7D, 0x05, 0xC1, 0x05]
        );
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), mem(0), xmm(0)]),
            [0xC4, 0xE3, 0x79, 0x04, 0x00, 0x1B]
        );
        assert_eq!(
            e("vperm2f128", &[Concrete::Imm(0x21), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x06, 0xC2, 0x21]
        );
        assert_eq!(
            e(
                "vperm2f128",
                &[Concrete::Imm(0x21), ymm(10), ymm(9), ymm(8)]
            ),
            [0xC4, 0x43, 0x35, 0x06, 0xC2, 0x21]
        );
        assert_eq!(
            e("vpblendd", &[Concrete::Imm(0x8), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x02, 0xC2, 0x08]
        );
        assert_eq!(
            e("vpblendd", &[Concrete::Imm(0xa1), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x02, 0xC2, 0xA1]
        );
        assert_eq!(
            e("vpalignr", &[Concrete::Imm(0x4), xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x43, 0x31, 0x0F, 0xC2, 0x04]
        );
        assert_eq!(
            e("vpalignr", &[Concrete::Imm(0x4), mem(0), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x0F, 0x00, 0x04]
        );
        assert_eq!(
            e("vinsertf128", &[Concrete::Imm(0x1), xmm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x18, 0xC2, 0x01]
        );
        assert_eq!(
            e("vinsertf128", &[Concrete::Imm(0x1), mem(0), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x18, 0x00, 0x01]
        );
    }
}

#[cfg(test)]
mod string_and_prefix_tests {
    use super::tests::asm_bytes;
    use super::*;

    /// The string primitives over every AT&T size suffix. The byte form is
    /// the bare opcode; the wider forms take `opcode + 1` under 0x66 (word)
    /// or REX.W (quad). Byte-verified against clang.
    #[test]
    fn string_primitives() {
        for (tmpl, want) in [
            ("movsb", &[0xA4][..]),
            ("movsw", &[0x66, 0xA5]),
            ("movsl", &[0xA5]),
            ("movsq", &[0x48, 0xA5]),
            ("cmpsb", &[0xA6]),
            ("cmpsw", &[0x66, 0xA7]),
            ("cmpsl", &[0xA7]),
            ("cmpsq", &[0x48, 0xA7]),
            ("stosb", &[0xAA]),
            ("stosw", &[0x66, 0xAB]),
            ("stosl", &[0xAB]),
            ("stosq", &[0x48, 0xAB]),
            ("lodsb", &[0xAC]),
            ("lodsw", &[0x66, 0xAD]),
            ("lodsl", &[0xAD]),
            ("lodsq", &[0x48, 0xAD]),
            ("scasb", &[0xAE]),
            ("scasw", &[0x66, 0xAF]),
            ("scasl", &[0xAF]),
            ("scasq", &[0x48, 0xAF]),
        ] {
            assert_eq!(asm_bytes(tmpl.as_bytes()), want, "{tmpl}");
        }
    }

    /// A prefix stands alone as a statement or leads its instruction on the
    /// same statement; either way the prefix byte comes first, before the
    /// operand-size prefix the instruction emits. Byte-verified against
    /// clang (`rep stosw` is `f3 66 ab`, not `66 f3 ab`).
    #[test]
    fn prefixes_compose_with_the_next_instruction() {
        assert_eq!(asm_bytes(b"repe; cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"repe cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"rep; stosl"), [0xF3, 0xAB]);
        assert_eq!(asm_bytes(b"rep stosw"), [0xF3, 0x66, 0xAB]);
        assert_eq!(asm_bytes(b"repz cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"repne scasb"), [0xF2, 0xAE]);
        assert_eq!(asm_bytes(b"repnz scasb"), [0xF2, 0xAE]);
        assert_eq!(asm_bytes(b"rep movsq"), [0xF3, 0x48, 0xA5]);
        // `lock` is the same mechanism and keeps its standalone form.
        assert_eq!(asm_bytes(b"lock; stosb"), [0xF0, 0xAA]);
    }

    /// `fninit` and the x87 / far-call memory forms. Byte-verified against
    /// clang.
    #[test]
    fn fninit_and_memory_extension_forms() {
        assert_eq!(asm_bytes(b"fninit"), [0xDB, 0xE3]);
        assert_eq!(asm_bytes(b"fnstsw (%rax)"), [0xDD, 0x38]);
        assert_eq!(asm_bytes(b"fnstcw (%rax)"), [0xD9, 0x38]);
        assert_eq!(asm_bytes(b"fnstsw 8(%rbx)"), [0xDD, 0x7B, 0x08]);
        assert_eq!(asm_bytes(b"lcallw *(%rax)"), [0x66, 0xFF, 0x18]);
        assert_eq!(asm_bytes(b"lcallw *8(%rbx)"), [0x66, 0xFF, 0x5B, 0x08]);
        assert_eq!(asm_bytes(b"lcall *(%rax)"), [0xFF, 0x18]);
        assert_eq!(asm_bytes(b"lcalll *(%rax)"), [0xFF, 0x18]);
        assert_eq!(asm_bytes(b"lcallq *(%rax)"), [0x48, 0xFF, 0x18]);
    }

    /// A string primitive names its own size, so a further AT&T suffix does
    /// not apply: `movsbl` stays a sign-extending move rather than parsing
    /// as `movsb` widened to long.
    #[test]
    fn string_primitive_takes_no_further_suffix() {
        assert!(matches!(
            split_mnemonic("movsb"),
            Some((Mnemonic::StringOp { .. }, None))
        ));
        assert_eq!(split_mnemonic("movsbl"), None);
        assert_eq!(split_mnemonic("movswl"), None);
    }

    /// The template shapes the sweep reported, end to end.
    #[test]
    fn reported_template_shapes() {
        assert_eq!(asm_bytes(b"repe; cmpsb"), [0xF3, 0xA6]);
        assert_eq!(
            asm_bytes(b"fninit ; fnstsw (%rax) ; fnstcw (%rbx)"),
            [0xDB, 0xE3, 0xDD, 0x38, 0xD9, 0x3B]
        );
        assert_eq!(asm_bytes(b"stosw \n\t rep;stosl"), [0x66, 0xAB, 0xF3, 0xAB]);
    }
}
