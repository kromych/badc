use super::*;

/// Placeholder for a `$LABEL` immediate: outside the signed-byte range, so
/// form selection takes the 32-bit immediate field the relocation needs, and
/// distinctive enough to confirm the field landed at the end of the encoding.
const ABS_LABEL_PLACEHOLDER: i64 = 0x1234_5678;
const ABS_LABEL_PLACEHOLDER_BYTES: [u8; 4] = (ABS_LABEL_PLACEHOLDER as u32).to_le_bytes();

/// Block-target branch context for an `asm goto` statement. The
/// template's `%lK` branches leave the statement, so they must run the
/// register-restore sequence first; each referenced label gets a local
/// trampoline (restore + jump) whose final jump rides the enclosing
/// function's `BranchFixup` machinery to the target block.
pub(super) struct AsmGotoCtx<'a> {
    /// `jump_tables` row: `[fall_through, label targets...]`.
    pub(super) row: &'a [super::super::ir::BlockId],
    pub(super) branch_fixups: &'a mut alloc::vec::Vec<BranchFixup>,
    pub(super) branch_short: &'a [bool],
}

/// Access width of a template memory operand. A memory reference carries no
/// width of its own: a `%N` size modifier wins, else the AT&T size suffix,
/// else a GP register operand of the same instruction. `None` leaves the
/// choice to the caller's default.
fn asm_mem_size(
    modifier: Option<super::super::ir::AsmRegSize>,
    insn: &super::asm::AsmInsn,
    operands: &[super::super::ir::AsmOperand],
    op_reg: &[Option<u8>],
) -> Option<super::super::ir::AsmRegSize> {
    use super::super::ir::{AsmConstraint, AsmRegSize};
    use super::asm::AsmOpnd;
    modifier.or(insn.suffix).or_else(|| {
        insn.operands.iter().find_map(|o| match *o {
            AsmOpnd::Reg { reg, size } if reg < super::asm::XMM_BASE => Some(size),
            AsmOpnd::HighReg(_) | AsmOpnd::HighRef(_) => Some(AsmRegSize::Byte),
            AsmOpnd::Ref { idx, size }
                if op_reg.get(idx as usize).copied().flatten().is_some()
                    && !matches!(
                        operands[idx as usize].constraint,
                        AsmConstraint::Fp | AsmConstraint::Mem
                    ) =>
            {
                Some(size.unwrap_or(AsmRegSize::from_width(operands[idx as usize].width)))
            }
            _ => None,
        })
    })
}

/// RIP-relative target of an inline-asm `%a` address operand: an
/// `i`-class operand naming a link-time data address (`&global`,
/// optionally offset by a constant).
enum AsmRipSym {
    /// Cross-TU global: `offset` is the constant byte offset added to the
    /// named symbol.
    Extern {
        name: alloc::string::String,
        offset: i64,
    },
    /// Global defined in this unit: `data_offset` is its byte offset in the
    /// merged data segment.
    Local { data_offset: i64 },
    /// Function defined in this unit, named by its entry PC. Resolved
    /// through the same channel as an `Inst::ImmCode` function-pointer
    /// literal, so the reference reaches the function's own body.
    Text { ent_pc: usize },
}

/// Resolve an inline-asm `%a` / `%c` address operand to a RIP-relative
/// relocation target. `arg` is the operand's SSA value-id; the accepted
/// shape is a C99 6.6p9 address constant -- the address of a static-storage
/// object or of a function, plus a constant byte offset. Returns `None`
/// when the operand is not a link-time address.
fn asm_riprel_target(
    func: &FunctionSsa,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    arg: u32,
) -> Option<AsmRipSym> {
    use crate::c5::asm::{asm_operand_code_base, asm_operand_data_target};
    if let Some((target, addend)) =
        asm_operand_data_target(func, arg, &|v| extern_data_names.get(&v).cloned())
    {
        use crate::c5::asm::AsmSectionTarget;
        return Some(match target {
            AsmSectionTarget::Symbol(name) => AsmRipSym::Extern {
                name,
                offset: addend,
            },
            AsmSectionTarget::Data(off) => AsmRipSym::Local {
                data_offset: off as i64,
            },
            _ => return None,
        });
    }
    let (base_vid, ent_pc, offset) = asm_operand_code_base(func, arg)?;
    // `name2entpc` holds the unit's own definitions. One of them takes the
    // entry-PC channel, which reaches the emitted body; every other name is
    // cross-TU and relocates by name. The in-unit channel names the entry,
    // so a byte offset into the body has nowhere to ride.
    if name2entpc.values().any(|&pc| pc == ent_pc) {
        return (offset == 0).then_some(AsmRipSym::Text { ent_pc });
    }
    extern_code_names
        .get(&base_vid)
        .map(|name| AsmRipSym::Extern {
            name: name.clone(),
            offset,
        })
}

/// Byte offset within `body` of the disp32 field of its symbolic
/// RIP-relative operand, and the count of bytes trailing the field (an
/// immediate). Re-encodes with a distinct displacement in that operand,
/// keeping its form; exactly the field's four bytes differ.
fn riprel_field(
    body: &[u8],
    concrete: &[super::asm::Concrete],
    addr: u8,
    insn: &super::asm::AsmInsn,
) -> Option<(usize, usize)> {
    let idx = concrete
        .iter()
        .position(|c| matches!(c, super::asm::Concrete::RipRel { .. }))?;
    let super::asm::Concrete::RipRel { size, .. } = concrete[idx] else {
        return None;
    };
    let mut probe = concrete.to_vec();
    probe[idx] = super::asm::Concrete::RipRel {
        disp: RIPREL_PROBE_DISP,
        size,
    };
    let mut probe_bytes = alloc::vec::Vec::new();
    super::asm::encode(&mut probe_bytes, addr, insn.mnemonic, insn.suffix, &probe).ok()?;
    let (field, width) = differing_run(body, &probe_bytes)?;
    (width == 4).then(|| (field, body.len() - field - 4))
}

/// Encode the replacement instructions of an executable inline-asm section
/// (`.pushsection .altinstr_replacement,"ax"`) to bytes and relocations,
/// each `Code` item becoming `CodeBytes`. Only a direct `call` / `jmp` to a
/// symbol, a `jmp` / `jcc` to an `asm goto` label (via `goto_block`) and
/// self-contained instructions assemble; a replacement referencing a
/// register operand or a memory location is rejected.
fn encode_x86_asm_section_code(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
    func: &FunctionSsa,
    args: &[u32],
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    op_reg: &[Option<u8>],
    operands: &[super::super::ir::AsmOperand],
) -> Result<(), alloc::string::String> {
    use super::super::ir::Inst;
    use crate::c5::asm::{AsmSectionItem, AsmSectionTarget};
    // A same-TU function operand is an `ImmCode` whose ent_pc reverses to its
    // name here; a cross-TU one carries its name in `extern_code_names`.
    let mut entpc2name: alloc::collections::BTreeMap<usize, &str> =
        alloc::collections::BTreeMap::new();
    for (n, &pc) in name2entpc {
        entpc2name.entry(pc).or_insert(n.as_str());
    }
    let operand_target = |idx: u8| -> Option<AsmSectionTarget> {
        let arg = *args.get(idx as usize)?;
        if let Some(name) = extern_code_names.get(&arg) {
            return Some(AsmSectionTarget::Symbol(name.clone()));
        }
        match func.insts.get(arg as usize) {
            Some(Inst::ImmCode(pc)) => entpc2name
                .get(pc)
                .map(|n| AsmSectionTarget::Symbol(alloc::string::String::from(*n))),
            _ => crate::c5::asm::asm_operand_data_target(func, arg, &|v| {
                extern_data_names.get(&v).cloned()
            })
            .map(|(t, _)| t),
        }
    };
    // A `%N` naming an `i`-class operand with a compile-time constant.
    let imm_of = |idx: u8| -> Option<i64> {
        crate::c5::asm::asm_operand_const(func, *args.get(idx as usize)?)
    };
    let form = |idx: u8| -> alloc::string::String {
        args.get(idx as usize).map_or_else(
            || alloc::string::String::from("past the operand list"),
            |&a| crate::c5::asm::asm_operand_form(func, a),
        )
    };
    // A `%a[N]` operand naming a link-time data address (`&global`): its reloc
    // target and the constant byte offset added to it.
    let addr_of = |idx: u8| -> Option<(AsmSectionTarget, i64)> {
        let arg = *args.get(idx as usize)?;
        crate::c5::asm::asm_operand_data_target(func, arg, &|v| extern_data_names.get(&v).cloned())
    };
    let mut mode = super::table::Mode::Bits64;
    let mut fold = crate::c5::asm::AsmParseFold::default();
    for b in blocks.iter_mut() {
        fold.enter_block(&*b);
        for item in b.items.iter_mut() {
            if let AsmSectionItem::Code(text) = item {
                let f = |e: &str| fold.fold(e, &imm_of);
                let refs = SectionOperandRefs {
                    op_reg,
                    operands,
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    form: &form,
                    fold: &f,
                    file_scope: false,
                };
                *item = encode_one_x86_section_insn(
                    text,
                    &mut mode,
                    &operand_target,
                    goto_block,
                    &refs,
                )?;
            }
            note_x86_align_mode(item, mode);
            fold.note_item(item, &imm_of);
        }
    }
    Ok(())
}

/// Encode a file-scope inline-asm section's instructions with an empty
/// operand context: no numbered operands, `asm goto` labels or register
/// assignments. The `.code16` / `.code32` / `.code64` state is a property
/// of the assembler's input stream, so it carries across sections in walk
/// order.
pub(crate) fn encode_x86_file_asm_section_code(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
    class: crate::c5::ElfClass,
) -> Result<(), alloc::string::String> {
    use crate::c5::asm::{AsmSectionItem, AsmSectionTarget};
    let operand_target = |_: u8| -> Option<AsmSectionTarget> { None };
    let goto_block = |_: u8| -> Option<u32> { None };
    let imm_of = |_: u8| -> Option<i64> { None };
    let addr_of = |_: u8| -> Option<(AsmSectionTarget, i64)> { None };
    let form = |_: u8| alloc::string::String::from("not an operand of this statement");
    let mut mode = if class.is32() {
        super::table::Mode::Bits32
    } else {
        super::table::Mode::Bits64
    };
    // Inside a deferred `.rept` nothing folds: the count, and with it every
    // offset the body's copies take, is settled by the layout.
    fn encode_rept(
        items: &mut [crate::c5::asm::AsmSectionItem],
        mode: &mut super::table::Mode,
        operand_target: &dyn Fn(u8) -> Option<crate::c5::asm::AsmSectionTarget>,
        goto_block: &dyn Fn(u8) -> Option<u32>,
        refs: &SectionOperandRefs<'_>,
    ) -> Result<(), alloc::string::String> {
        use crate::c5::asm::AsmSectionItem;
        for it in items {
            if let AsmSectionItem::Rept { items, .. } = it {
                encode_rept(items, mode, operand_target, goto_block, refs)?;
            } else if let AsmSectionItem::Code(text) = it {
                *it = encode_one_x86_section_insn(text, mode, operand_target, goto_block, refs)?;
            }
            note_x86_align_mode(it, *mode);
        }
        Ok(())
    }
    let mut fold = crate::c5::asm::AsmParseFold::default();
    for b in blocks.iter_mut() {
        fold.enter_block(&*b);
        for item in b.items.iter_mut() {
            if let AsmSectionItem::Rept { items, .. } = item {
                let none = |_: &str| None;
                let refs = SectionOperandRefs {
                    op_reg: &[],
                    operands: &[],
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    form: &form,
                    fold: &none,
                    file_scope: true,
                };
                encode_rept(items, &mut mode, &operand_target, &goto_block, &refs)?;
            } else if let AsmSectionItem::Code(text) = item {
                let f = |e: &str| fold.fold(e, &imm_of);
                let refs = SectionOperandRefs {
                    op_reg: &[],
                    operands: &[],
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    form: &form,
                    fold: &f,
                    file_scope: true,
                };
                *item = encode_one_x86_section_insn(
                    text,
                    &mut mode,
                    &operand_target,
                    &goto_block,
                    &refs,
                )?;
            }
            note_x86_align_mode(item, mode);
            fold.note_item(item, &imm_of);
        }
    }
    Ok(())
}

/// Record on an alignment directive the encoding mode it stands in, which
/// selects the no-op forms its default fill takes.
fn note_x86_align_mode(item: &mut crate::c5::asm::AsmSectionItem, mode: super::table::Mode) {
    if let crate::c5::asm::AsmSectionItem::Align { nops, .. } = item {
        *nops = if mode == super::table::Mode::Bits16 {
            crate::c5::asm::AlignNops::X86Bits16
        } else {
            crate::c5::asm::AlignNops::X86
        };
    }
}

/// Opcode of a branch whose displacement field is rel8 only.
pub(crate) fn short_branch_opcode(mnem: &str) -> Option<u8> {
    Some(match mnem {
        "loopne" | "loopnz" => 0xE0,
        "loope" | "loopz" => 0xE1,
        "loop" => 0xE2,
        "jrcxz" | "jecxz" | "jcxz" => 0xE3,
        _ => return None,
    })
}

/// Address-size prefix of an `E3 rel8` branch. The counter the name spells is
/// the instruction's address size: the mode's default takes no prefix, the
/// mode's other address size takes `67`, and a width the mode cannot address
/// has no encoding, as GNU as rejects it.
fn e3_branch_prefix(
    mnem: &str,
    mode: super::table::Mode,
) -> Result<Option<u8>, alloc::string::String> {
    let width: u8 = match mnem {
        "jcxz" => 2,
        "jecxz" => 4,
        "jrcxz" => 8,
        _ => return Ok(None),
    };
    let dflt = mode.addrsize();
    let alt = if dflt == 2 { 4 } else { dflt / 2 };
    if width == dflt {
        Ok(None)
    } else if width == alt {
        Ok(Some(0x67))
    } else {
        Err(alloc::format!(
            "inline asm: `{mnem}` does not encode in {}-bit mode",
            dflt * 8
        ))
    }
}

/// A branch target's section target: a bare name resolves through the label,
/// section and `.set` maps; an expression over them (`jmp sym + 4`) is valued
/// where the section materializes.
fn branch_section_target(text: &str) -> crate::c5::asm::AsmSectionTarget {
    use crate::c5::asm::AsmSectionTarget;
    use crate::c5::asm::is_asm_symbol_name;
    if is_asm_symbol_name(text) {
        AsmSectionTarget::Symbol(alloc::string::String::from(text))
    } else {
        AsmSectionTarget::Expr(alloc::string::String::from(text))
    }
}

/// The `rel8` encoding of a direct branch: `EB` for `jmp`, `70+cc` for a
/// `jcc`. GNU as takes it whenever the target is a label of the branch's own
/// section within a signed-byte displacement, in every code-size mode; the
/// layout makes that choice, so both forms are handed to it. A `call` has no
/// short form.
fn short_branch_form(
    opcode: u8,
    target: &crate::c5::asm::AsmSectionTarget,
) -> crate::c5::asm::AsmShortBranch {
    use crate::c5::asm::{AsmRelocKind, AsmSectionReloc, AsmShortBranch};
    AsmShortBranch {
        bytes: alloc::vec![opcode, 0],
        reloc: AsmSectionReloc {
            offset: 1,
            width: 1,
            kind: AsmRelocKind::JumpRel,
            pcrel: true,
            branch: false,
            signed: false,
            target: target.clone(),
            addend: -1,
        },
    }
}

/// Legacy prefixes in GNU as order: segment, address size, operand size, then
/// repeat / lock. `body` carries the size prefixes at its front and `pending`
/// the bytes prefix statements deposited. Returns the count of `body` bytes
/// taken; the rest is the caller's to append.
fn push_legacy_prefixes(
    out: &mut alloc::vec::Vec<u8>,
    body: &[u8],
    seg: Option<u8>,
    pending: &[u8],
) -> usize {
    let is_seg = |b: u8| matches!(b, 0x26 | 0x2E | 0x36 | 0x3E | 0x64 | 0x65);
    let sizes = body.iter().take_while(|b| matches!(b, 0x66 | 0x67)).count();
    out.extend(seg);
    out.extend(pending.iter().copied().filter(|&b| is_seg(b)));
    out.extend_from_slice(&body[..sizes]);
    out.extend(pending.iter().copied().filter(|&b| !is_seg(b)));
    sizes
}

/// Byte width of a near-branch displacement and whether the operand-size
/// prefix selects it. The displacement follows the operand size, which is 32
/// in long and 32-bit modes and 16 in 16-bit mode; an AT&T size suffix
/// (`calll` in a `.code16` stub) names the other one.
fn branch_rel_width(
    mode: super::table::Mode,
    suffix: Option<super::super::ir::AsmRegSize>,
) -> (u8, bool) {
    let dflt: u8 = if mode == super::table::Mode::Bits16 {
        2
    } else {
        4
    };
    let want = match suffix.map(|s| s.bytes()) {
        Some(2) => 2,
        Some(4) => 4,
        _ => dflt,
    };
    (want, want != dflt)
}

/// Template-operand resolution for a replacement instruction: the register
/// assignments, `i`-class constant immediates, and link-time data addresses
/// (`%a`) its operand references resolve through. Built by
/// `encode_x86_asm_section_code` from the enclosing statement's operand list.
struct SectionOperandRefs<'a> {
    op_reg: &'a [Option<u8>],
    operands: &'a [super::super::ir::AsmOperand],
    imm_of: &'a dyn Fn(u8) -> Option<i64>,
    addr_of: &'a dyn Fn(u8) -> Option<(crate::c5::asm::AsmSectionTarget, i64)>,
    /// The form of an operand that is neither a register nor a constant.
    form: &'a dyn Fn(u8) -> alloc::string::String,
    /// The value an operand expression already has at this point of the
    /// stream, when the walk's [`AsmParseFold`] can prove it is a constant.
    /// A folded immediate or displacement encodes as a literal, taking the
    /// narrow field GNU as picks at the same point.
    fold: &'a dyn Fn(&str) -> Option<i64>,
    /// File-scope / `.S`-unit text is basic asm, where `%kN` is an opmask
    /// register; an extended-asm statement's section text keeps GCC's
    /// `%k<N>` operand-modifier reading.
    file_scope: bool,
}

/// Encode one replacement instruction to a `CodeBytes` item: a direct
/// `call` / `jmp` to a symbol as `E8` / `E9` with a `PLT32` relocation
/// (addend -4), a `jmp` / `jcc` to an `asm goto` label with a `PC32`
/// relocation to the label's block, otherwise the operands resolved to
/// registers, immediates and memory references, a `%a[N]` link-time
/// address becoming a RIP-relative reference with a `PC32` relocation.
fn encode_one_x86_section_insn(
    text: &str,
    mode: &mut super::table::Mode,
    operand_target: &dyn Fn(u8) -> Option<crate::c5::asm::AsmSectionTarget>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    refs: &SectionOperandRefs<'_>,
) -> Result<crate::c5::asm::AsmSectionItem, alloc::string::String> {
    use super::asm::{AsmOpnd, Mnemonic};
    use crate::c5::asm::AsmSectionItem;
    // An encoding-mode directive sets the state the rest of the stream
    // assembles under and deposits no bytes.
    if let Some(m) = match text {
        ".code16" => Some(super::table::Mode::Bits16),
        ".code32" => Some(super::table::Mode::Bits32),
        ".code64" => Some(super::table::Mode::Bits64),
        _ => None,
    } {
        *mode = m;
        return Ok(AsmSectionItem::CodeBytes {
            bytes: alloc::vec::Vec::new(),
            relocs: alloc::vec::Vec::new(),
            short: None,
        });
    }
    let mode = *mode;
    let insns = if refs.file_scope {
        super::asm::parse_file_template(text.as_bytes())
    } else {
        super::asm::parse_template(text.as_bytes())
    }
    .map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
    // Each leading `lock` / `rep` / segment prefix parses as its own entry and
    // rides in front of the instruction's bytes. A prefix statement standing
    // alone is the instruction, so the run stops one short of the end.
    let prefix: alloc::vec::Vec<u8> = insns
        .split_last()
        .map_or(&[][..], |(_, head)| head)
        .iter()
        .map_while(|i| match i.mnemonic {
            Mnemonic::Prefix(b) => Some(b),
            _ => None,
        })
        .collect();
    let [insn] = &insns[prefix.len()..] else {
        return Err(alloc::format!(
            "inline asm: replacement `{text}` is not a single instruction"
        ));
    };
    let si = SectionInsn {
        text,
        mode,
        insn,
        prefix: &prefix,
        mnem: match insn.mnemonic {
            Mnemonic::Table(n) => n,
            _ => "",
        },
        refs,
    };
    // REX is a 64-bit-mode prefix; the other modes read the byte as an
    // instruction, so GNU as rejects it there.
    if mode != super::table::Mode::Bits64
        && (insn.rex.is_some()
            || matches!(insn.mnemonic, Mnemonic::Prefix(b) if (0x40..=0x4F).contains(&b)))
    {
        return Err(si.err("takes a `rex` prefix outside 64-bit mode"));
    }
    // A prefixed branch or symbol push has no meaning; the prefix applies
    // on the general operand path below. The direct-branch forms are built
    // by hand and carry neither prefix byte, so one on them would be
    // dropped rather than encoded.
    if (!prefix.is_empty() || insn.rex.is_some())
        && (matches!(
            insn.operands.first(),
            Some(AsmOpnd::GotoLabel(_) | AsmOpnd::ImmSym { .. } | AsmOpnd::Label { .. })
        ) || (!insn.sym_exprs.is_empty() && insn.operands.is_empty()))
    {
        return Err(si.err("prefix on a branch"));
    }
    if let Some(item) = si.goto_branch(goto_block)? {
        return Ok(item);
    }
    if let Some(item) = si.short_branch()? {
        return Ok(item);
    }
    if let Some(item) = si.direct_branch(operand_target)? {
        return Ok(item);
    }
    let ops = si.resolve_operands()?;
    si.encode(ops)
}

/// One replacement instruction of a section, parsed, with the mode it
/// assembles under.
struct SectionInsn<'a> {
    text: &'a str,
    mode: super::table::Mode,
    insn: &'a super::asm::AsmInsn,
    prefix: &'a [u8],
    /// The catalogue mnemonic, empty for the other mnemonic kinds.
    mnem: &'a str,
    refs: &'a SectionOperandRefs<'a>,
}

/// The operands of a replacement instruction resolved for encoding.
struct SectionOperands {
    concrete: alloc::vec::Vec<super::asm::Concrete>,
    /// A symbolic disp32 operand: its reloc target, the symbol addend, the
    /// operand's index in `concrete`, and whether the reference is
    /// PC-relative (a RIP-relative `%a` / `%c`) or absolute (a no-base
    /// scaled-index `sym(,%index,scale)`). At most one per instruction.
    sym_disp: Option<(crate::c5::asm::AsmSectionTarget, i64, usize, bool)>,
    /// A `$symbol` immediate: its reloc target, the symbol addend, and the
    /// operand's index in `concrete`. At most one per instruction.
    sym_imm: Option<(crate::c5::asm::AsmSectionTarget, i64, usize)>,
    /// A `__seg_gs` / `__seg_fs` memory operand's segment override; a
    /// template `%%gs:` rides `insn.seg` instead, and the two never conflict.
    operand_seg: Option<u8>,
}

impl SectionInsn<'_> {
    fn err(&self, what: &str) -> alloc::string::String {
        alloc::format!("inline asm: replacement `{}` {what}", self.text)
    }

    /// A jmp / jcc to an `asm goto` label (`%lK`), as `jmp %l[t_no]` in
    /// `_static_cpu_has`: the rel32 form with a `PC32` relocation deferred as
    /// `TextBlock` and rewritten to the block's text offset after layout, the
    /// GNU as cross-section branch (addend -4).
    fn goto_branch(
        &self,
        goto_block: &dyn Fn(u8) -> Option<u32>,
    ) -> Result<Option<crate::c5::asm::AsmSectionItem>, alloc::string::String> {
        use crate::c5::asm::{AsmRelocKind, AsmSectionItem, AsmSectionReloc, AsmSectionTarget};
        let Some(&super::asm::AsmOpnd::GotoLabel(k)) = self.insn.operands.first() else {
            return Ok(None);
        };
        let cc = jcc_cond(self.mnem);
        if cc.is_none() && !matches!(self.mnem, "jmp" | "jmpq") {
            return Err(self.err("label operand on a non-jump"));
        }
        let bid = goto_block(k)
            .ok_or_else(|| self.err(&alloc::format!("`%l{k}` names no `asm goto` label")))?;
        let mut bytes = alloc::vec::Vec::new();
        let offset = match cc {
            Some(cc) => {
                super::encode::emit_jcc_rel32(&mut bytes, cc, 0);
                2
            }
            None => {
                super::encode::emit_jmp_rel32(&mut bytes, 0);
                1
            }
        };
        let reloc = AsmSectionReloc {
            offset,
            width: 4,
            kind: AsmRelocKind::Data,
            pcrel: true,
            branch: false,
            signed: false,
            target: AsmSectionTarget::TextBlock(bid),
            addend: -4,
        };
        Ok(Some(AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec![reloc],
            short: None,
        }))
    }

    /// The count- and rcx-conditional branches take a rel8 field only, so
    /// a label target resolves to a one-byte displacement rather than the
    /// mode-width one the other branches take.
    fn short_branch(
        &self,
    ) -> Result<Option<crate::c5::asm::AsmSectionItem>, alloc::string::String> {
        use crate::c5::asm::{AsmRelocKind, AsmSectionItem, AsmSectionReloc, AsmSectionTarget};
        let Some(op) = short_branch_opcode(self.mnem) else {
            return Ok(None);
        };
        let prefix = e3_branch_prefix(self.mnem, self.mode)
            .map_err(|m| alloc::format!("{m} (`{}`)", self.text))?;
        let target = if let Some(&super::asm::AsmOpnd::Label { num, forward }) =
            self.insn.operands.first()
        {
            Some(AsmSectionTarget::Symbol(local_label_name(num, forward)))
        } else {
            self.insn
                .sym_exprs
                .first()
                .filter(|n| self.insn.operands.is_empty() && !n.contains('%'))
                .map(|t| branch_section_target(t))
        };
        if let Some(target) = target {
            let mut bytes = alloc::vec::Vec::new();
            bytes.extend(prefix);
            bytes.extend([op, 0]);
            return Ok(Some(AsmSectionItem::CodeBytes {
                relocs: alloc::vec![AsmSectionReloc {
                    offset: bytes.len() as u32 - 1,
                    width: 1,
                    // Not `JumpRel`: these have no wider form, so GNU as
                    // fixes them up rather than relaxing them, and a global
                    // target keeps its relocation as it does for `call`.
                    kind: AsmRelocKind::Data,
                    pcrel: true,
                    branch: false,
                    signed: false,
                    target,
                    addend: -1,
                }],
                bytes,
                short: None,
            }));
        }
        // `jcxz` / `jecxz` have no catalogue row to fall back to.
        if matches!(self.mnem, "jcxz" | "jecxz") {
            return Err(alloc::format!(
                "inline asm: replacement `{}`: `{}` takes a label target",
                self.text,
                self.mnem
            ));
        }
        Ok(None)
    }

    /// A `call` / `jmp` / `jcc` to a symbol or a numeric label: the mode-width
    /// rel form with a branch relocation the writer resolves against the
    /// label's symbol (a same-section target patches at materialize time). An
    /// indirect target encodes on the operand path.
    fn direct_branch(
        &self,
        operand_target: &dyn Fn(u8) -> Option<crate::c5::asm::AsmSectionTarget>,
    ) -> Result<Option<crate::c5::asm::AsmSectionItem>, alloc::string::String> {
        use super::asm::AsmOpnd;
        use crate::c5::asm::{AsmRelocKind, AsmSectionTarget};
        let insn = self.insn;
        let is_call = self.mnem.starts_with("call");
        let is_jmp = matches!(self.mnem, "jmp" | "jmpq");
        let cc = jcc_cond(self.mnem);
        if !is_call && !is_jmp && cc.is_none() {
            return Ok(None);
        }
        // A bare-symbol target carries no operands.
        let target = if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
        {
            if name.contains('%') {
                let what = if cc.is_some() { "branch" } else { "call" };
                return Err(self.err(&alloc::format!("{what} target embeds an operand")));
            }
            Some(branch_section_target(name))
        } else if let Some(&AsmOpnd::RefConst { idx, .. }) = insn.operands.first()
            && cc.is_none()
        {
            Some(operand_target(idx).ok_or_else(|| self.err("call target is not a symbol"))?)
        } else if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            // A numeric-label target resolves at materialize time against
            // this statement's section labels.
            Some(AsmSectionTarget::Symbol(local_label_name(num, forward)))
        } else {
            None
        };
        let Some(target) = target else {
            return Ok(None);
        };
        let item = match cc {
            Some(cc) => self.rel_branch(
                &[0x0F, 0x80 | (cc as u8)],
                AsmRelocKind::JumpRel,
                Some(0x70 | (cc as u8)),
                target,
            ),
            None if is_call => self.rel_branch(&[0xE8], AsmRelocKind::Data, None, target),
            None => self.rel_branch(&[0xE9], AsmRelocKind::JumpRel, Some(0xEB), target),
        };
        Ok(Some(item))
    }

    /// A direct branch in the mode-width rel form with a relocation to
    /// `target`; `short_op` is the rel8 opcode the section relaxation may
    /// substitute, when the form has one.
    fn rel_branch(
        &self,
        opcode: &[u8],
        kind: crate::c5::asm::AsmRelocKind,
        short_op: Option<u8>,
        target: crate::c5::asm::AsmSectionTarget,
    ) -> crate::c5::asm::AsmSectionItem {
        use crate::c5::asm::{AsmSectionItem, AsmSectionReloc};
        let (rel, prefixed) = branch_rel_width(self.mode, self.insn.suffix);
        let mut bytes = alloc::vec::Vec::new();
        if prefixed {
            bytes.push(0x66);
        }
        bytes.extend_from_slice(opcode);
        let offset = bytes.len() as u32;
        bytes.resize(bytes.len() + rel as usize, 0);
        let reloc = AsmSectionReloc {
            offset,
            width: rel,
            kind,
            pcrel: true,
            // Only long mode reaches a call target through a PLT slot.
            branch: self.mode == super::table::Mode::Bits64,
            signed: false,
            target,
            addend: -(rel as i64),
        };
        let short = short_op
            .filter(|_| !prefixed)
            .map(|op| short_branch_form(op, &reloc.target));
        AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec![reloc],
            short,
        }
    }

    /// The access width of a memory reference with no width of its own: the
    /// mode's default operand size, which the near-branch and stack group
    /// promotes to 64 bits in long mode and leaves at 32 or 16 outside it.
    fn mem_size(&self) -> super::super::ir::AsmRegSize {
        asm_mem_size(None, self.insn, self.refs.operands, self.refs.op_reg).unwrap_or(
            super::super::ir::AsmRegSize::from_width(self.mode.stack_opsize()),
        )
    }

    /// A template operand's register, or its `i`-class constant.
    fn reg_of(
        &self,
        idx: u8,
        modifier: Option<super::super::ir::AsmRegSize>,
    ) -> Option<super::asm::Concrete> {
        use super::super::ir::{AsmConstraint, AsmRegSize};
        use super::asm::Concrete;
        let refs = self.refs;
        let width = refs.operands.get(idx as usize)?.width;
        let size = modifier.unwrap_or(AsmRegSize::from_width(width));
        match refs.op_reg.get(idx as usize).copied().flatten() {
            Some(r) if matches!(refs.operands[idx as usize].constraint, AsmConstraint::Fp) => {
                Some(Concrete::Reg {
                    reg: super::asm::XMM_BASE + r,
                    size,
                })
            }
            Some(r) => Some(Concrete::Reg { reg: r, size }),
            None => (refs.imm_of)(idx).map(Concrete::Imm),
        }
    }

    /// A memory base / index that names an operand resolves to its assigned
    /// GP register (an FP operand is not an address register).
    fn base_reg(&self, b: super::asm::AsmMemBase) -> Option<u8> {
        use super::super::ir::AsmConstraint;
        use super::asm::AsmMemBase;
        match b {
            AsmMemBase::Reg { num, .. } => Some(num),
            AsmMemBase::Ref(i) => {
                self.refs
                    .op_reg
                    .get(i as usize)
                    .copied()
                    .flatten()
                    .filter(|_| {
                        !matches!(
                            self.refs.operands.get(i as usize).map(|o| o.constraint),
                            Some(AsmConstraint::Fp)
                        )
                    })
            }
        }
    }

    fn index_reg(&self, i: super::asm::AsmMemBase) -> Result<u8, alloc::string::String> {
        self.base_reg(i)
            .ok_or_else(|| self.err("memory index is not a register"))
    }

    /// The relocation target of the operand expression an operand names:
    /// the section engine evaluates it against the layout when the section
    /// materializes.
    fn expr_target(
        &self,
        i: u8,
    ) -> Result<crate::c5::asm::AsmSectionTarget, alloc::string::String> {
        self.insn
            .sym_exprs
            .get(i as usize)
            .map(|e| crate::c5::asm::AsmSectionTarget::Expr(e.clone()))
            .ok_or_else(|| self.err("operand expression is missing"))
    }

    /// The value an operand expression already has at this point of the
    /// stream, when the walk can prove it is a constant.
    fn folded(&self, expr: u8) -> Option<i64> {
        self.insn
            .sym_exprs
            .get(expr as usize)
            .and_then(|e| (self.refs.fold)(e))
    }

    /// Resolve each operand to a concrete register, immediate or memory
    /// reference: a template operand takes its register or its `i`-class
    /// constant; a `%a[N]` operand naming a link-time address resolves to no
    /// register and becomes a RIP-relative reference.
    fn resolve_operands(&self) -> Result<SectionOperands, alloc::string::String> {
        use super::asm::AsmOpnd;
        let mut ops = SectionOperands {
            concrete: alloc::vec::Vec::new(),
            sym_disp: None,
            sym_imm: None,
            operand_seg: None,
        };
        for o in &self.insn.operands {
            let c = match *o {
                AsmOpnd::Imm(v) => super::asm::Concrete::Imm(v),
                AsmOpnd::ImmSym { expr } => self.resolve_imm_sym(expr, &mut ops)?,
                AsmOpnd::Reg { reg, size } => super::asm::Concrete::Reg { reg, size },
                AsmOpnd::HighReg(n) => super::asm::Concrete::HighReg(n),
                AsmOpnd::HighRef(idx) => {
                    super::asm::resolve_high_ref(idx, self.refs.operands, self.refs.op_reg)?
                }
                AsmOpnd::Ref { idx, size } => self.resolve_ref(idx, size, &mut ops)?,
                AsmOpnd::Mem {
                    base,
                    index,
                    scale,
                    disp,
                } => self.resolve_mem(base, index, scale, disp, &mut ops)?,
                // `disp(%%rip)` with a literal displacement: the address is
                // `rip + disp`, computed at run time.
                AsmOpnd::RipRel { disp } => super::asm::Concrete::RipRel {
                    disp,
                    size: self.mem_size(),
                },
                AsmOpnd::RipRelRef { idx, .. } => {
                    self.resolve_const_ref_mem(idx, true, &mut ops)?
                }
                AsmOpnd::AbsMem { disp, sym } => self.resolve_abs_mem(disp, sym, &mut ops)?,
                AsmOpnd::AbsMemRef { idx, .. } => {
                    self.resolve_const_ref_mem(idx, false, &mut ops)?
                }
                AsmOpnd::IndexMem {
                    index,
                    scale,
                    disp,
                    sym,
                } => self.resolve_index_mem(index, scale, disp, sym, &mut ops)?,
                AsmOpnd::SymMem {
                    base,
                    index,
                    scale,
                    expr,
                } => self.resolve_sym_mem(base, index, scale, expr, &mut ops)?,
                // `sym(%%rip)` / `(sym - 1b)(%%rip)`: a RIP-relative reference
                // to what the displacement expression leaves symbolic; the
                // disp32 takes a PC-relative relocation.
                AsmOpnd::SymRipRel { expr } => {
                    let size = self.mem_size();
                    ops.set_sym_disp(self, self.expr_target(expr), 0, true)?;
                    super::asm::Concrete::RipRel { disp: 0, size }
                }
                // `Nf(%%rip)`: the address of a section label, a `lea` source.
                // The materializer values the label, so the reference is a
                // PC-relative relocation against it like any other symbolic
                // displacement.
                AsmOpnd::LabelAddr { num, forward } => {
                    let target =
                        crate::c5::asm::AsmSectionTarget::Symbol(local_label_name(num, forward));
                    ops.set_sym_disp(self, Ok(target), 0, true)?;
                    super::asm::Concrete::RipRel {
                        disp: 0,
                        size: self.mem_size(),
                    }
                }
                // `$Nf`: the label's address as an absolute immediate.
                AsmOpnd::ImmLabel { num, forward } => {
                    let target =
                        crate::c5::asm::AsmSectionTarget::Symbol(local_label_name(num, forward));
                    ops.set_sym_imm(self, Ok(target), 0)?;
                    super::asm::Concrete::Imm(IMM_PROBE[0].1)
                }
                // A bare `Nf` outside a branch is AT&T's absolute memory
                // address (the boot stubs patch their own operands through
                // one). The displacement is the address size wide and takes
                // an absolute relocation against the label.
                AsmOpnd::Label { num, forward } => {
                    let target =
                        crate::c5::asm::AsmSectionTarget::Symbol(local_label_name(num, forward));
                    ops.set_sym_disp(self, Ok(target), 0, false)?;
                    super::asm::Concrete::AbsMem {
                        disp: abs_probe(super::asm::addr_size(self.insn, self.mode)).0,
                        size: self.mem_size(),
                    }
                }
                _ => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{}` operand is not a \
                         register or immediate",
                        self.text
                    ));
                }
            };
            ops.concrete.push(c);
        }
        Ok(ops)
    }

    /// A `$expr` immediate: an expression that is already a constant
    /// encodes as the literal, taking the operand's narrowest form; a
    /// symbolic one takes the probe that settles its field.
    fn resolve_imm_sym(
        &self,
        expr: u8,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        if let Some(v) = self.folded(expr) {
            return Ok(super::asm::Concrete::Imm(v));
        }
        ops.set_sym_imm(self, self.expr_target(expr), 0)?;
        Ok(super::asm::Concrete::Imm(IMM_PROBE[0].1))
    }

    /// A template operand. A memory-constraint (`m`) operand holds its
    /// address in the assigned register; `%N` is the register-indirect
    /// reference `(%r)`, the same lowering the code stream uses (a `lea %N`
    /// then computes the address). Any other operand resolves to a register
    /// or an `i`-class constant.
    fn resolve_ref(
        &self,
        idx: u8,
        size: Option<super::super::ir::AsmRegSize>,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg};
        let refs = self.refs;
        let op = refs.operands.get(idx as usize);
        let mem = matches!(op.map(|o| o.constraint), Some(AsmConstraint::Mem))
            .then(|| refs.op_reg.get(idx as usize).copied().flatten())
            .flatten();
        let Some(base) = mem else {
            return self.reg_of(idx, size).ok_or_else(|| {
                self.err(&alloc::format!(
                    "operand `%{idx}` is not a register or constant: the operand is {}",
                    (refs.form)(idx)
                ))
            });
        };
        let width = op.map(|o| o.width).unwrap_or(8);
        let size = asm_mem_size(size, self.insn, refs.operands, refs.op_reg)
            .unwrap_or(AsmRegSize::from_width(width));
        ops.operand_seg = match op.map(|o| o.seg) {
            Some(AsmSeg::Gs) => Some(0x65),
            Some(AsmSeg::Fs) => Some(0x64),
            _ => ops.operand_seg,
        };
        Ok(super::asm::Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size,
        })
    }

    /// An explicit `disp(%reg)` reference. A `%a[N]` (base-only operand
    /// naming an `i`-class link-time address) resolves to no register and
    /// takes a RIP-relative relocation; a scaled index cannot ride that
    /// form. A constant base addresses absolutely.
    fn resolve_mem(
        &self,
        base: super::asm::AsmMemBase,
        index: Option<super::asm::AsmMemBase>,
        scale: u8,
        disp: i32,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        use super::asm::{AsmMemBase, Concrete};
        let size = self.mem_size();
        let sym = match base {
            AsmMemBase::Ref(bi) if index.is_none() => (self.refs.addr_of)(bi),
            _ => None,
        };
        match (self.base_reg(base), sym) {
            (Some(b), _) => {
                let index = match index {
                    Some(i) => Some(self.index_reg(i)?),
                    None => None,
                };
                Ok(Concrete::Mem {
                    base: b,
                    index,
                    scale,
                    disp,
                    size,
                })
            }
            (None, Some((target, off))) => {
                ops.set_sym_disp(self, Ok(target), off + disp as i64, true)?;
                Ok(Concrete::RipRel { disp: 0, size })
            }
            (None, None) => {
                let AsmMemBase::Ref(bi) = base else {
                    return Err(self.err("memory base is not a register"));
                };
                let abs = (self.refs.imm_of)(bi)
                    .filter(|_| index.is_none())
                    .and_then(|v| i32::try_from(v.checked_add(disp as i64)?).ok());
                let Some(disp) = abs else {
                    return Err(self.err(&alloc::format!(
                        "memory base `%{bi}` is not a register, a constant or a link-time \
                         address: the operand is {}",
                        (self.refs.form)(bi)
                    )));
                };
                Ok(Concrete::AbsMem { disp, size })
            }
        }
    }

    /// `%cN(%%rip)` / `%PN(%%rip)` (`riprel`) or a bare `%cN` / `%PN`
    /// reference: a constant becomes the displacement literal; a link-time
    /// address takes a RIP-relative relocation.
    fn resolve_const_ref_mem(
        &self,
        idx: u8,
        riprel: bool,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        use super::asm::Concrete;
        let size = self.mem_size();
        if let Some(v) = (self.refs.imm_of)(idx) {
            let (what, wide) = if riprel {
                ("RIP-relative", true)
            } else {
                ("absolute", false)
            };
            let disp = i32::try_from(v)
                .map_err(|_| self.err(&alloc::format!("{what} displacement out of range")))?;
            return Ok(if wide {
                Concrete::RipRel { disp, size }
            } else {
                Concrete::AbsMem { disp, size }
            });
        }
        let (target, off) = (self.refs.addr_of)(idx).ok_or_else(|| {
            self.err(&alloc::format!(
                "`%c`/`%P` operand is not a constant or address: the operand is {}",
                (self.refs.form)(idx)
            ))
        })?;
        ops.set_sym_disp(self, Ok(target), off, true)?;
        Ok(Concrete::RipRel { disp: 0, size })
    }

    /// An absolute address with no base register, written as a literal or
    /// as a symbol expression: the absolute disp form, its field relocated
    /// when a symbol names it.
    fn resolve_abs_mem(
        &self,
        disp: i32,
        sym: Option<u8>,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        let size = self.mem_size();
        let Some(expr) = sym else {
            return Ok(super::asm::Concrete::AbsMem { disp, size });
        };
        ops.set_sym_disp(self, self.expr_target(expr), 0, false)?;
        Ok(super::asm::Concrete::AbsMem {
            disp: abs_probe(super::asm::addr_size(self.insn, self.mode)).0,
            size,
        })
    }

    /// `disp(,%index,scale)`: a no-base scaled-index reference. A symbol
    /// displacement takes an absolute reloc; a literal encodes directly.
    fn resolve_index_mem(
        &self,
        index: super::asm::AsmMemBase,
        scale: u8,
        disp: i32,
        sym: Option<u8>,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        let size = self.mem_size();
        let index = self.index_reg(index)?;
        let disp = match sym {
            Some(expr) => {
                ops.set_sym_disp(self, self.expr_target(expr), 0, false)?;
                0
            }
            None => disp,
        };
        Ok(super::asm::Concrete::IndexMem {
            index,
            scale,
            disp,
            size,
        })
    }

    /// `disp+sym(%base[, %index, scale])`: a based reference whose symbol
    /// displacement takes an absolute reloc. A displacement expression that
    /// is already a constant encodes as the literal, taking the narrowest
    /// based form; otherwise the probe displacement forces the disp32 form,
    /// whose field is zeroed once located.
    fn resolve_sym_mem(
        &self,
        base: super::asm::AsmMemBase,
        index: Option<super::asm::AsmMemBase>,
        scale: u8,
        expr: u8,
        ops: &mut SectionOperands,
    ) -> Result<super::asm::Concrete, alloc::string::String> {
        let size = self.mem_size();
        let base = self
            .base_reg(base)
            .ok_or_else(|| self.err("memory base is not a register"))?;
        let index = match index {
            Some(i) => Some(self.index_reg(i)?),
            None => None,
        };
        if let Some(v) = self.folded(expr).and_then(|v| i32::try_from(v).ok()) {
            return Ok(super::asm::Concrete::Mem {
                base,
                index,
                scale,
                disp: v,
                size,
            });
        }
        ops.set_sym_disp(self, self.expr_target(expr), 0, false)?;
        Ok(super::asm::Concrete::Mem {
            base,
            index,
            scale,
            disp: RIPREL_PROBE_DISP,
            size,
        })
    }

    /// Encode the body behind its prefixes and locate the symbolic fields: a
    /// `$symbol` immediate settles its width and signedness first, the widest
    /// probe that encodes winning as under GNU as; a symbolic displacement is
    /// found by re-encoding with a distinct displacement, exactly those bytes
    /// differing.
    fn encode(
        &self,
        mut ops: SectionOperands,
    ) -> Result<crate::c5::asm::AsmSectionItem, alloc::string::String> {
        use super::asm::Concrete;
        use crate::c5::asm::{AsmRelocKind, AsmSectionItem, AsmSectionReloc};
        let insn = self.insn;
        let mode = self.mode;
        let addr = super::asm::addr_size(insn, mode);
        let encode = |ops: &[Concrete]| {
            let mut out = alloc::vec::Vec::new();
            super::asm::encode_in(&mut out, mode, addr, insn.mnemonic, insn.suffix, ops)?;
            if let Some(rex) = insn.rex {
                super::asm::splice_rex(&mut out, 0, rex)?;
            }
            Ok(out)
        };
        let tail = super::asm::imm_field_tail(insn.mnemonic);
        let imm_field = match ops.sym_imm {
            Some((_, _, idx)) => Some(
                locate_sym_imm_field(&ops.concrete, idx, tail, &encode)
                    .ok_or_else(|| self.err("symbol immediate has no encodable field"))?,
            ),
            None => None,
        };
        if let (Some((_, _, idx)), Some(f)) = (&ops.sym_imm, &imm_field) {
            ops.concrete[*idx] = Concrete::Imm(f.probe);
        }
        let body_err = |m: alloc::string::String| {
            alloc::format!("inline asm: replacement `{}`: {m}", self.text)
        };
        let mut body = encode(&ops.concrete).map_err(body_err)?;
        let mut bytes = alloc::vec::Vec::new();
        let sizes =
            push_legacy_prefixes(&mut bytes, &body, insn.seg.or(ops.operand_seg), self.prefix);
        // A field of `body` past the size prefixes lands in `bytes` shifted by
        // the segment and repeat / lock bytes only, the size prefixes having
        // moved ahead of them.
        let seg_len = bytes.len() as u32 - sizes as u32;
        let mut relocs = alloc::vec::Vec::new();
        if let Some((target, off, idx, pcrel)) = ops.sym_disp {
            let mut probe = ops.concrete.clone();
            probe[idx] = match ops.concrete[idx] {
                Concrete::RipRel { size, .. } => Concrete::RipRel {
                    disp: RIPREL_PROBE_DISP,
                    size,
                },
                Concrete::IndexMem {
                    index, scale, size, ..
                } => Concrete::IndexMem {
                    index,
                    scale,
                    disp: RIPREL_PROBE_DISP,
                    size,
                },
                // The body already carries the first probe displacement (which
                // forces the disp32 form); vary every field byte again.
                Concrete::Mem {
                    base,
                    index,
                    scale,
                    size,
                    ..
                } => Concrete::Mem {
                    base,
                    index,
                    scale,
                    disp: RIPREL_PROBE_DISP2,
                    size,
                },
                // An absolute address's field is the address size wide, so its
                // probe pair is chosen to differ in every byte of that width.
                Concrete::AbsMem { size, .. } => Concrete::AbsMem {
                    disp: abs_probe(addr).1,
                    size,
                },
                other => other,
            };
            let probe_bytes = encode(&probe).map_err(body_err)?;
            let (field, width) = differing_run(&body, &probe_bytes)
                .filter(|&(_, n)| matches!(n, 2 | 4))
                .ok_or_else(|| self.err("displacement field is not a 2- or 4-byte run"))?;
            body[field..field + width].fill(0);
            // A PC-relative field's addend is the symbol offset less the
            // field's own end skew and any bytes trailing it (the immediate of
            // `testb $imm, sym(%rip)`), matching gcc. An absolute field is
            // patched with the symbol value plus the offset directly.
            let trailing = body.len() - (field + width);
            let addend = if pcrel {
                off - width as i64 - trailing as i64
            } else {
                off
            };
            relocs.push(AsmSectionReloc {
                offset: seg_len + field as u32,
                width: width as u8,
                kind: AsmRelocKind::Data,
                pcrel,
                branch: false,
                // An absolute disp32 is sign-extended into a 64-bit address,
                // so it takes `R_X86_64_32S`; under a 32- or 16-bit address
                // size the field is the whole address and takes the
                // zero-extended flavour.
                signed: !pcrel && width == 4 && addr == 8,
                target,
                addend,
            });
        }
        if let (Some((target, off, _)), Some(f)) = (ops.sym_imm, imm_field) {
            body[f.start..f.start + f.width as usize].fill(0);
            relocs.push(AsmSectionReloc {
                offset: seg_len + f.start as u32,
                width: f.width,
                kind: AsmRelocKind::Data,
                pcrel: false,
                branch: false,
                signed: f.signed,
                target,
                addend: off,
            });
        }
        bytes.extend_from_slice(&body[sizes..]);
        Ok(AsmSectionItem::CodeBytes {
            bytes,
            relocs,
            short: None,
        })
    }
}

impl SectionOperands {
    /// Record the one symbolic displacement an instruction may carry.
    fn set_sym_disp(
        &mut self,
        si: &SectionInsn,
        target: Result<crate::c5::asm::AsmSectionTarget, alloc::string::String>,
        off: i64,
        pcrel: bool,
    ) -> Result<(), alloc::string::String> {
        if self.sym_disp.is_some() {
            return Err(si.err("has more than one memory operand"));
        }
        self.sym_disp = Some((target?, off, self.concrete.len(), pcrel));
        Ok(())
    }

    /// Record the one `$symbol` immediate an instruction may carry.
    fn set_sym_imm(
        &mut self,
        si: &SectionInsn,
        target: Result<crate::c5::asm::AsmSectionTarget, alloc::string::String>,
        off: i64,
    ) -> Result<(), alloc::string::String> {
        if self.sym_imm.is_some() {
            return Err(si.err("has more than one symbol immediate"));
        }
        self.sym_imm = Some((target?, off, self.concrete.len()));
        Ok(())
    }
}

/// Where a `$symbol` immediate lands in an instruction's encoding.
struct SymImmField {
    /// Probe value that selects this field; the body encodes with it and the
    /// field bytes are zeroed afterwards.
    probe: i64,
    start: usize,
    width: u8,
    /// The form's immediate slot is the sign-extended class, so the field
    /// takes `R_X86_64_32S` rather than `R_X86_64_32`.
    signed: bool,
}

/// Probe pairs for locating a symbol immediate's field, widest first; the
/// members of a pair differ in every byte and stay inside the signed range
/// of their width. The 8-byte pair comes last, so a form with a 4-byte
/// variant takes it, as under GNU as, and only `movabsq` falls through.
const IMM_PROBE: [(u8, i64, i64); 4] = [
    (4, 0x5B3D_71A7, 0x24C2_8E58),
    (2, 0x5B3D, 0x24C2),
    (1, 0x5B, 0x24),
    (8, 0x5B3D_71A7_2C4E_1936, 0x24C2_8E58_53B1_E6C9),
];

/// A value only an unsigned imm32 slot accepts: a signed imm32 slot rejects
/// it, which is how the sign-extended class is told apart.
const IMM_UNSIGNED_PROBE: i64 = 0x8000_0000;

/// Encode a concrete operand list, or report why it does not encode.
type EncodeFn<'a> =
    dyn Fn(&[super::asm::Concrete]) -> Result<alloc::vec::Vec<u8>, alloc::string::String> + 'a;

/// Settle a symbol immediate's field by re-encoding. Each probe pair encodes
/// the instruction twice; the bytes that differ are the field, which x86
/// places last (`tail` bytes from the end for the form that trails it), so a
/// run reaching that point is the whole field and a shorter one means the
/// probe did not fill it.
fn locate_sym_imm_field(
    concrete: &[super::asm::Concrete],
    idx: usize,
    tail: usize,
    encode: &EncodeFn<'_>,
) -> Option<SymImmField> {
    use super::asm::Concrete;
    let with = |v: i64| {
        let mut ops = concrete.to_vec();
        ops[idx] = Concrete::Imm(v);
        encode(&ops).ok()
    };
    for (width, p1, p2) in IMM_PROBE {
        // A probe the form rejects (a 16-bit field asked for a 32-bit value)
        // rules that width out, not the search.
        let (Some(a), Some(b)) = (with(p1), with(p2)) else {
            continue;
        };
        let Some((start, len)) = differing_run(&a, &b) else {
            continue;
        };
        let end = start + len;
        if len != width as usize || (end != a.len() && end + tail != a.len()) {
            continue;
        }
        // The signed imm32 class rejects a value above `i32::MAX`, so an
        // encoding that changes length or fails there is the sign-extended
        // form. Narrower fields carry no such distinction.
        let signed = width == 4 && with(IMM_UNSIGNED_PROBE).is_none_or(|u| u.len() != a.len());
        return Some(SymImmField {
            probe: p1,
            start,
            width,
            signed,
        });
    }
    None
}

/// The value of a template field's expression at stream offset `at`: a
/// template label takes the offset its definition stands at, a section label
/// the offset the measured layout gives it. `None` when a leaf is unresolved.
fn template_expr_value(
    expr: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
    measure: &crate::c5::asm::SectionLabelOffsets,
) -> Option<i64> {
    let resolve = |name: &str| -> Option<i64> {
        // A bare decimal is an integer literal; a GNU as numeric label is
        // referenced only as `Nb` / `Nf`. Leave literals for the evaluator.
        if name.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        measure
            .offset(name)
            .or_else(|| crate::c5::asm::template_label_offset(name, at, label_defs, names))
    };
    crate::c5::asm::eval_asm_expr_with_labels(expr, &resolve)
}

/// A local label's name as the section materializer resolves it: the number
/// plus its search direction.
fn local_label_name(num: u32, forward: bool) -> alloc::string::String {
    alloc::format!("{num}{}", if forward { 'f' } else { 'b' })
}

/// The probe pair for locating an absolute-address displacement, whose field
/// is the address size wide: both members differ in every byte of that field.
fn abs_probe(addr: u8) -> (i32, i32) {
    if addr == 2 {
        (0x5B3D, 0x24C2)
    } else {
        (RIPREL_PROBE_DISP, RIPREL_PROBE_DISP2)
    }
}

/// A distinctive displacement for locating a RIP-relative disp32 field by
/// re-encoding: every byte differs from a zero field.
const RIPREL_PROBE_DISP: i32 = 0x5B3D_71A7u32 as i32;

/// The byte-wise complement of [`RIPREL_PROBE_DISP`], for locating a field
/// that already carries the first probe: every byte differs again.
const RIPREL_PROBE_DISP2: i32 = 0xA4C2_8E58u32 as i32;

/// Byte offset of the four-byte run that differs between two encodings that
/// vary only in a RIP-relative displacement. Returns `None` unless exactly
/// four contiguous bytes differ -- an encoder-invariant check that the disp32
/// is the sole variable field.
fn riprel_disp32_field(a: &[u8], b: &[u8]) -> Option<usize> {
    differing_run(a, b).filter(|&(_, n)| n == 4).map(|(s, _)| s)
}

/// The single contiguous run of bytes two equal-length encodings differ in,
/// as (offset, length). `None` when they differ nowhere or in more than one
/// run -- the encoder-invariant check that the probed field is the only
/// variable one.
fn differing_run(a: &[u8], b: &[u8]) -> Option<(usize, usize)> {
    if a.len() != b.len() {
        return None;
    }
    let differ = |i: usize| a.get(i).zip(b.get(i)).is_some_and(|(x, y)| x != y);
    let first = (0..a.len()).find(|&i| differ(i))?;
    let end = (first..a.len()).find(|&i| !differ(i)).unwrap_or(a.len());
    (end..a.len())
        .all(|i| !differ(i))
        .then_some((first, end - first))
}

/// Lower an `Inst::InlineAsm`: assign each register operand a register per
/// its constraint, save the registers the statement overwrites, capture the
/// operand values and addresses to the frame (so an operand in a register
/// the asm overwrites is read first), load the inputs, encode the
/// template, store the outputs back. `goto_ctx` is present for `asm goto`.
///
/// A branch to a label of the template's own stream starts on the rel8
/// form; when the settled layout leaves it out of reach the attempt grows
/// `long_sites` and this driver rolls the outputs back and lays the
/// template out again. Each round either grows the set or is final.
pub(super) fn emit_inline_asm(
    out: &mut Out,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fcx: &FnCtx,
    mut goto_ctx: Option<AsmGotoCtx<'_>>,
) -> Emit {
    let mut long_sites: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let base = out.mark();
    loop {
        let known = long_sites.len();
        let round_ctx = goto_ctx.as_mut().map(|c| AsmGotoCtx {
            row: c.row,
            branch_fixups: &mut *c.branch_fixups,
            branch_short: c.branch_short,
        });
        emit_inline_asm_once(out, asm, args, fcx, round_ctx, &mut long_sites)?;
        if long_sites.len() == known {
            return Ok(());
        }
        out.restore(&base);
    }
}

/// One inline-asm statement with the per-function context its lowering
/// reads.
struct AsmStmt<'a> {
    asm: &'a super::super::ir::AsmBlock,
    args: &'a [u32],
    func: &'a FunctionSsa,
    alloc: &'a Allocation,
    frame: Frame,
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
}

impl AsmStmt<'_> {
    /// The constant value of an `i`-class operand reference, if any.
    fn const_of(&self, idx: u8) -> Option<i64> {
        crate::c5::asm::asm_operand_const(self.func, *self.args.get(idx as usize)?)
    }

    /// The form of an operand, for a diagnostic.
    fn operand_form(&self, idx: u8) -> alloc::string::String {
        self.args.get(idx as usize).map_or_else(
            || alloc::string::String::from("past the operand list"),
            |&a| crate::c5::asm::asm_operand_form(self.func, a),
        )
    }

    /// The link-time address an operand names, for a RIP-relative reference.
    fn riprel_target(&self, idx: u8) -> Option<AsmRipSym> {
        asm_riprel_target(
            self.func,
            self.name2entpc,
            self.extern_data_names,
            self.extern_code_names,
            *self.args.get(idx as usize)?,
        )
    }

    /// The link-time data address an `i`-class operand names, resolved like
    /// the operand's own `ImmData` lowering.
    fn operand_sym(&self, idx: u8) -> Option<(crate::c5::asm::AsmSectionTarget, i64)> {
        crate::c5::asm::asm_operand_data_target(self.func, *self.args.get(idx as usize)?, &|vid| {
            self.extern_data_names.get(&vid).cloned()
        })
    }
}

/// The template after the text passes: the operand register assignment,
/// the code stream parsed, and the pushed sections encoded.
struct AsmTemplate {
    op_reg: alloc::vec::Vec<Option<u8>>,
    code: alloc::string::String,
    blocks: alloc::vec::Vec<crate::c5::asm::AsmSectionBlock>,
    insns: alloc::vec::Vec<super::asm::AsmInsn>,
}

/// Expand `%=` once so the code text and any `.pushsection` content share
/// one instance number, rename multiply defined numeric labels, print the
/// `%zN` size suffixes, assign the operand registers, expand the GNU as
/// macro directives, split off the section blocks and encode their
/// replacement instructions, then parse the code text.
fn prepare_template(
    stmt: &AsmStmt,
    asm_sections: &mut crate::c5::asm::AsmSectionSink,
    goto_row: Option<&[super::super::ir::BlockId]>,
) -> Emit<AsmTemplate> {
    let asm = stmt.asm;
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        return fail("inline asm: non-UTF8 template");
    };
    let stripped = crate::c5::asm::strip_asm_comments(raw_text, crate::c5::asm::AsmComments::X86);
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = crate::c5::asm::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    let multidef = crate::c5::asm::rewrite_multidef_local_labels(text);
    let text = multidef.as_deref().unwrap_or(text);
    let sized = match crate::c5::asm::expand_size_suffix_refs(text, &|idx| {
        asm.operands
            .get(idx as usize)
            .and_then(|op| super::asm::att_size_suffix(op.width))
    }) {
        Ok(s) => s,
        Err(m) => return fail(m),
    };
    let text = sized.as_deref().unwrap_or(text);
    // The register assignment serves the code stream and, ahead of it, the
    // macro pass and a replacement instruction referencing a template
    // operand (`popcntl %1, %0`).
    let op_reg = match super::asm::assign_operand_regs(
        &asm.operands,
        asm.clobber_regs | stmt.frame.fixed_regs.gpr,
        asm.clobber_fp_regs | stmt.frame.fixed_regs.fpr,
        &|i| stmt.const_of(i as u8),
    ) {
        Ok(r) => r,
        Err(m) => return fail(m),
    };
    let gas = match crate::c5::asm::expand_asm_gas_macros(text, 4, &|tok| {
        gas_operand_subst(stmt, &op_reg, tok)
    }) {
        Ok(e) => e,
        Err(m) => return fail(m),
    };
    let text = gas.as_deref().unwrap_or(text);
    let mut extracted = match crate::c5::asm::extract_asm_sections(text, false) {
        Ok(e) => e,
        Err(m) => return fail(m),
    };
    if let Some(ex) = &extracted {
        if let Err(m) = crate::c5::asm::reject_unit_symbol_items(&ex.blocks) {
            return fail(m);
        }
        // The template's symbol directives declare names of the unit; the
        // object writer applies them, where every definition is known.
        if let Err(m) = asm_sections.push_sym_decls(&ex.sym_items) {
            return fail(m);
        }
    }
    // A `%lK` goto branch in a replacement instruction resolves through the
    // enclosing `asm goto` row to its target block (index `1 + K`).
    let goto_block = |k: u8| -> Option<u32> { goto_row?.get(1 + k as usize).copied() };
    if let Some(ex) = extracted.as_mut()
        && let Err(m) = encode_x86_asm_section_code(
            &mut ex.blocks,
            stmt.func,
            stmt.args,
            stmt.name2entpc,
            stmt.extern_data_names,
            stmt.extern_code_names,
            &goto_block,
            &op_reg,
            &asm.operands,
        )
    {
        return fail(m);
    }
    let (code, blocks) = match extracted {
        Some(ex) => (ex.code, ex.blocks),
        None => (alloc::string::String::from(text), alloc::vec::Vec::new()),
    };
    let insns = match super::asm::parse_template(code.as_bytes()) {
        Ok(i) => i,
        Err(m) => return fail(m),
    };
    if let Err(m) = super::asm::check_operand_refs(&insns, asm.operands.len()) {
        return fail(m);
    }
    Ok(AsmTemplate {
        op_reg,
        code,
        blocks,
        insns,
    })
}

/// The text a template operand reference substitutes to in a GNU as macro
/// directive: a register operand's assigned AT&T name, so the macro's
/// register-name comparisons resolve, or an `i`-class constant.
fn gas_operand_subst(
    stmt: &AsmStmt,
    op_reg: &[Option<u8>],
    tok: &str,
) -> Option<alloc::string::String> {
    use super::super::ir::AsmConstraint;
    let body = tok.strip_prefix('%')?;
    let (modifier, digits) = match body.as_bytes().first() {
        Some(m) if m.is_ascii_alphabetic() => (Some(*m), &body[1..]),
        _ => (None, body),
    };
    let idx: u8 = digits.parse().ok()?;
    if matches!(modifier, Some(b'c') | Some(b'P') | Some(b'n')) {
        let v = stmt.const_of(idx)?;
        return Some(alloc::format!(
            "{}",
            if modifier == Some(b'n') { -v } else { v }
        ));
    }
    let op = stmt.asm.operands.get(idx as usize)?;
    if !matches!(
        op.constraint,
        AsmConstraint::Reg
            | AsmConstraint::Fixed(_)
            | AsmConstraint::Bound(_)
            | AsmConstraint::Match(_)
    ) {
        return None;
    }
    let r = op_reg.get(idx as usize).copied().flatten()?;
    if modifier == Some(b'h') {
        return (r < 4).then(|| alloc::format!("%{}", super::asm::GPR_HB[r as usize]));
    }
    let width = match modifier {
        Some(b'b') => 1,
        Some(b'w') => 2,
        Some(b'k') => 4,
        Some(b'q') => 8,
        _ => op.width,
    };
    super::asm::gpr_att_name(r, width).map(|n| alloc::format!("%{n}"))
}

/// The frame's asm scratch region for one statement: xmm saves, then GP
/// saves, then one capture slot per operand. Register saves and operand
/// captures live rbp-relative, never below rsp: a setjmp-style template
/// saves rsp mid-block and a later longjmp-style one resumes it after the
/// memory below that rsp was reused; rbp survives such a round trip.
struct AsmScratch {
    base: i32,
    fp_area: i32,
    save_list: alloc::vec::Vec<u8>,
    fp_save_list: alloc::vec::Vec<u8>,
    /// The register operand captures and store-backs go through.
    stage: Reg,
}

impl AsmScratch {
    fn new(stmt: &AsmStmt, op_reg: &[Option<u8>]) -> Emit<AsmScratch> {
        let (used, fp_used, stage) =
            match asm_save_masks_and_stage(stmt.asm, op_reg, stmt.frame.fixed_regs) {
                Ok(t) => t,
                Err(m) => return fail(m),
            };
        let save_list: alloc::vec::Vec<u8> = (0u8..16).filter(|r| used & (1 << r) != 0).collect();
        let fp_save_list: alloc::vec::Vec<u8> =
            (0u8..16).filter(|r| fp_used & (1 << r) != 0).collect();
        let fp_area = fp_save_list.len() as i32 * 16;
        let base = stmt.frame.asm_scratch_off;
        debug_assert!(
            base != 0 || (fp_area == 0 && save_list.is_empty() && stmt.asm.operands.is_empty()),
            "inline asm without a frame scratch region"
        );
        Ok(AsmScratch {
            base,
            fp_area,
            save_list,
            fp_save_list,
            stage,
        })
    }

    fn gp_off(&self, k: usize) -> i32 {
        self.base + self.fp_area + 8 * k as i32
    }

    fn cap_off(&self, i: usize) -> i32 {
        self.base + self.fp_area + 8 * (self.save_list.len() + i) as i32
    }

    /// With no store-back and no restore on the way out, a `%lK` branch goes
    /// straight to the label's block, so the template branch and a
    /// `.long %lK - .` section field name one address, as runtime patchers
    /// require. TODO with exit work pending, a section field still names the
    /// block, so a patched-in branch skips the store-backs and restores; the
    /// aarch64 lowering rewrites such fields to the restore trampoline.
    fn goto_direct(&self, asm: &super::super::ir::AsmBlock) -> bool {
        use super::super::ir::AsmConstraint;
        self.save_list.is_empty()
            && self.fp_save_list.is_empty()
            && !asm.operands.iter().any(|op| {
                op.is_output
                    && !matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
            })
    }

    fn emit_saves(&self, code: &mut Vec<u8>) {
        for (k, &r) in self.fp_save_list.iter().enumerate() {
            super::encode::emit_movups_mem_xmm(code, Reg::RBP, self.base + k as i32 * 16, Reg(r));
        }
        for (k, &r) in self.save_list.iter().enumerate() {
            super::encode::emit_mov_mem_r(code, Reg::RBP, self.gp_off(k), Reg(r));
        }
    }

    /// Capture each operand's value (input) / address (output) into its
    /// slot before any asm register is written. An allocator-visible stage
    /// (r10 and r11 both held by operands or clobbers) may itself be some
    /// operand's register, so register-resident operands are captured in a
    /// first pass, before a spill load writes the stage.
    fn emit_captures(&self, code: &mut Vec<u8>, stmt: &AsmStmt) -> Emit {
        let passes = if self.stage == SCRATCH_R10 || self.stage == SCRATCH_R11 {
            1
        } else {
            2
        };
        for pass in 0..passes {
            for (i, &a) in stmt.args.iter().enumerate() {
                let Some(place) = stmt.alloc.places.get(a as usize).copied() else {
                    return fail("inline asm: operand place missing");
                };
                if passes == 2 && (pass == 1) != matches!(place, Place::Spill(_)) {
                    continue;
                }
                let Some(r) = materialize_int(code, place, self.stage, stmt.frame) else {
                    return fail("inline asm: operand not an integer place");
                };
                super::encode::emit_mov_mem_r(code, Reg::RBP, self.cap_off(i), r);
            }
        }
        Ok(())
    }

    /// Load the inputs into their registers; a `+` output loads its current
    /// value from the destination address, a memory operand its captured
    /// address, an `x` operand its 128 bits from the addressed object.
    fn emit_loads(
        &self,
        code: &mut Vec<u8>,
        asm: &super::super::ir::AsmBlock,
        op_reg: &[Option<u8>],
    ) {
        use super::super::ir::AsmConstraint;
        for (i, op) in asm.operands.iter().enumerate() {
            let Some(r) = op_reg[i] else { continue };
            if matches!(op.constraint, AsmConstraint::Fp) {
                if !op.is_output || op.is_rw {
                    super::encode::emit_mov_r_mem(code, self.stage, Reg::RBP, self.cap_off(i));
                    super::encode::emit_movups_xmm_mem(code, Reg(r), self.stage, 0);
                }
                continue;
            }
            // Nothing moves into a bound operand: it has no storage behind it.
            if matches!(op.constraint, AsmConstraint::Bound(_)) {
                continue;
            }
            let reg = Reg(r);
            if matches!(op.constraint, AsmConstraint::Mem) || !op.is_output {
                super::encode::emit_mov_r_mem(code, reg, Reg::RBP, self.cap_off(i));
            } else if op.is_rw {
                super::encode::emit_mov_r_mem(code, self.stage, Reg::RBP, self.cap_off(i));
                emit_asm_load_width(code, reg, self.stage, op.width);
            }
        }
    }

    /// Store the register outputs back through their captured addresses. A
    /// memory operand needs no store-back: the instruction wrote memory.
    fn emit_outputs(
        &self,
        code: &mut Vec<u8>,
        asm: &super::super::ir::AsmBlock,
        op_reg: &[Option<u8>],
    ) {
        use super::super::ir::AsmConstraint;
        for (i, op) in asm.operands.iter().enumerate() {
            if !op.is_output
                || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
            {
                continue;
            }
            let Some(r) = op_reg[i] else { continue };
            super::encode::emit_mov_r_mem(code, self.stage, Reg::RBP, self.cap_off(i));
            if matches!(op.constraint, AsmConstraint::Fp) {
                super::encode::emit_movups_mem_xmm(code, self.stage, 0, Reg(r));
            } else {
                emit_asm_store_width(code, self.stage, Reg(r), op.width);
            }
        }
    }

    fn emit_restore(&self, code: &mut Vec<u8>) {
        for (k, &r) in self.save_list.iter().enumerate() {
            super::encode::emit_mov_r_mem(code, Reg(r), Reg::RBP, self.gp_off(k));
        }
        for (k, &r) in self.fp_save_list.iter().enumerate() {
            super::encode::emit_movups_xmm_mem(code, Reg(r), Reg::RBP, self.base + k as i32 * 16);
        }
    }
}

/// Records of one layout pass over the template.
#[derive(Default)]
struct AsmLayout {
    /// Local-label definitions: `(label, code offset)`.
    label_defs: alloc::vec::Vec<(u32, usize)>,
    /// Branch and `lea` displacement fields over local labels:
    /// `(field, label, forward, width, instruction index)`. A relaxable
    /// branch's field is one byte wide until `long_sites` holds its
    /// instruction.
    label_fixups: alloc::vec::Vec<(usize, u32, bool, u8, usize)>,
    /// `$LABEL` address immediates: `(imm32 field, label, forward)`.
    abs_label_fixups: alloc::vec::Vec<(usize, u32, bool)>,
    /// Fields over template-label expressions a forward reference left
    /// unsettled: `(reference site, field, width, expression)`.
    expr_fixups: alloc::vec::Vec<(usize, usize, u8, alloc::string::String)>,
    /// `asm goto` label branches: `(rel32 site, kind, label index)`.
    goto_sites: alloc::vec::Vec<(usize, LocalBranchKind, usize)>,
    /// Whether the last byte emitted came from an instruction; alignment
    /// padding depends on it.
    after_insn: bool,
    /// Start of the run of prefix statements the next instruction re-places.
    prefix_run: Option<usize>,
}

/// The operands of one instruction resolved for encoding, with the fields
/// the layout or the writers settle afterwards.
struct ResolvedOperands {
    concrete: alloc::vec::Vec<super::asm::Concrete>,
    /// A `__seg_gs` / `__seg_fs` memory operand's segment override.
    operand_seg: Option<u8>,
    /// A RIP-relative reference to a link-time symbol and the operand's
    /// template displacement, recorded at the disp32 field once encoded.
    riprel_reloc: Option<(AsmRipSym, i64)>,
    /// A `$expr` immediate / memory displacement the stream has not reached:
    /// a placeholder fixes the wide field and the expression settles later.
    imm_expr: Option<alloc::string::String>,
    disp_expr: Option<alloc::string::String>,
}

/// Label references the main stream does not define, deferred to the
/// pushed sections: `(field, label, forward)` per branch displacement and
/// per `$LABEL` address immediate.
struct DeferredRefs {
    branches: alloc::vec::Vec<(usize, u32, bool)>,
    addresses: alloc::vec::Vec<(usize, u32, bool)>,
}

/// Read-only context of one layout pass.
struct AsmPass<'a> {
    stmt: &'a AsmStmt<'a>,
    tpl: &'a AsmTemplate,
    /// Code-stream label names, indexed from `NAMED_LABEL_BASE`.
    label_names: &'a [&'a str],
    /// Names the unit binds weak: an in-stream definition of one does not
    /// satisfy a branch in place, since the link may bind another
    /// definition, so the field keeps a relocation against the name.
    weak_names: &'a crate::c5::asm::AsmBindingNames<'a>,
    /// Label numbers the code stream defines, by instruction index.
    stream_defs: alloc::vec::Vec<(u32, usize)>,
    /// Section-label offsets, so a `.skip` in the main stream can size its
    /// padding against a replacement length before the sections
    /// materialize.
    section_measure: crate::c5::asm::SectionLabelOffsets,
    scratch: &'a AsmScratch,
    goto_row: Option<&'a [super::super::ir::BlockId]>,
}

impl AsmPass<'_> {
    fn expr_value(&self, expr: &str, at: usize, layout: &AsmLayout) -> Option<i64> {
        template_expr_value(
            expr,
            at,
            &layout.label_defs,
            self.label_names,
            &self.section_measure,
        )
    }

    fn weak_target_name(&self, num: u32) -> Option<alloc::string::String> {
        let idx = num.checked_sub(super::asm::NAMED_LABEL_BASE)?;
        let name = *self.label_names.get(idx as usize)?;
        self.weak_names
            .contains(name)
            .then(|| alloc::string::String::from(name))
    }

    fn mem_size(
        &self,
        modifier: Option<super::super::ir::AsmRegSize>,
        insn: &super::asm::AsmInsn,
    ) -> Option<super::super::ir::AsmRegSize> {
        asm_mem_size(modifier, insn, &self.stmt.asm.operands, &self.tpl.op_reg)
    }

    fn mem_size_or_quad(&self, insn: &super::asm::AsmInsn) -> super::super::ir::AsmRegSize {
        self.mem_size(None, insn)
            .unwrap_or(super::super::ir::AsmRegSize::Quad)
    }

    /// The jcc condition of a branch mnemonic, `None` for `jmp`; a
    /// non-branch is refused.
    fn branch_cc(insn: &super::asm::AsmInsn) -> Emit<Option<Cc>> {
        let super::asm::Mnemonic::Table(name) = insn.mnemonic else {
            return fail("inline asm: label operand on a non-jump");
        };
        let cc = jcc_cond(name);
        if cc.is_none() && !matches!(name, "jmp" | "jmpq") {
            return fail("inline asm: label operand on a non-jump");
        }
        Ok(cc)
    }

    fn emit_insn(
        &self,
        ii: usize,
        insn: &super::asm::AsmInsn,
        out: &mut Out,
        layout: &mut AsmLayout,
        long_sites: &mut alloc::collections::BTreeSet<usize>,
    ) -> Emit {
        let pending_at = if matches!(insn.mnemonic, super::asm::Mnemonic::Prefix(_)) {
            layout.prefix_run.get_or_insert(out.cx.code.len());
            None
        } else {
            layout.prefix_run.take()
        };
        if let Some(ok) = self.emit_directive(insn, out.cx.code, out.cx.text_align, layout) {
            return ok;
        }
        if let Some(ok) = self.emit_address_operand(insn, out.cx.code, layout) {
            return ok;
        }
        if let Some(ok) = self.emit_branch(ii, insn, out, layout, long_sites) {
            return ok;
        }
        let resolved = self.resolve_operands(insn, out.cx.code.len(), layout)?;
        self.encode_insn(insn, resolved, pending_at, out, layout)
    }

    /// A label definition or a layout / data directive, which encode no
    /// instruction; `None` when `insn` is an instruction.
    fn emit_directive(
        &self,
        insn: &super::asm::AsmInsn,
        code: &mut Vec<u8>,
        text_align: &mut usize,
        layout: &mut AsmLayout,
    ) -> Option<Emit> {
        use super::asm::{AsmOpnd, Mnemonic};
        // A local-label definition marks the current offset.
        if let Some(num) = insn.label_def {
            layout.label_defs.push((num, code.len()));
            return Some(Ok(()));
        }
        // `.align` / `.p2align` / `.balign` pad the unit's text stream to the
        // boundary as GNU as does section-relative, raising the section
        // alignment above the default when needed; the default fill is the GNU
        // as multi-byte NOP sequence. A label operand resolves against the
        // definitions already emitted.
        if let Some(crate::c5::asm::AsmSectionItem::Align {
            spec,
            fill,
            max,
            nops,
        }) = &insn.layout
        {
            let at = code.len();
            let n = match spec.bytes(&|name| {
                crate::c5::asm::template_label_offset(
                    name,
                    at,
                    &layout.label_defs,
                    self.label_names,
                )
                .filter(|&off| off <= at as i64)
            }) {
                Ok(n) => n,
                Err(e) => return Some(fail(e)),
            };
            *text_align = (*text_align).max(n as usize);
            let gap = crate::c5::asm::align_gap(at as i64, n as i64, *max) as usize;
            if let Err(e) =
                crate::c5::asm::push_align_fill(code, gap, *fill, true, *nops, layout.after_insn)
            {
                return Some(fail(e));
            }
            return Some(Ok(()));
        }
        // A raw-byte piece (a hex-byte run or a `.byte` family directive) is
        // data as far as alignment is concerned.
        if insn.mnemonic == Mnemonic::RawBytes {
            code.extend_from_slice(&insn.bytes);
            layout.after_insn = false;
            return Some(Ok(()));
        }
        // `.skip count, fill`: `count` resolves against the section
        // replacement length and the template labels already emitted (the
        // ALTERNATIVE old site is padded to the longer of the two so a
        // boot-time patch fits).
        if insn.mnemonic == Mnemonic::Skip {
            let expr = insn.sym_exprs.first().map_or("0", |e| e.as_str());
            let Some(count) = self.expr_value(expr, code.len(), layout) else {
                return Some(fail("inline asm: `.skip` count is not a constant"));
            };
            if count < 0 {
                return Some(fail("inline asm: `.skip` count is negative"));
            }
            let unit: &[u8] = if insn.bytes.is_empty() {
                &[0]
            } else {
                &insn.bytes
            };
            for _ in 0..count {
                code.extend_from_slice(unit);
            }
            layout.after_insn = false;
            return Some(Ok(()));
        }
        // A data directive with operand references (`.long %c0`): each
        // argument is a compile-time constant or a value over template
        // labels, emitted little-endian at the directive width.
        if let Mnemonic::Data(w) = insn.mnemonic {
            for o in &insn.operands {
                let v = match *o {
                    AsmOpnd::Imm(v) => v,
                    AsmOpnd::RefConst { idx, .. } | AsmOpnd::Ref { idx, .. } => {
                        match self.stmt.const_of(idx) {
                            Some(v) => v,
                            None => {
                                return Some(fail("inline asm: non-constant data-directive value"));
                            }
                        }
                    }
                    AsmOpnd::ImmSym { expr } => {
                        let Some(text) = insn.sym_exprs.get(expr as usize) else {
                            return Some(fail("inline asm: data-directive expression is missing"));
                        };
                        match self.expr_value(text, code.len(), layout) {
                            Some(v) => v,
                            None => {
                                layout
                                    .expr_fixups
                                    .push((code.len(), code.len(), w, text.clone()));
                                0
                            }
                        }
                    }
                    _ => return Some(fail("inline asm: unsupported data-directive value")),
                };
                code.extend_from_slice(&(v as u64).to_le_bytes()[..w as usize]);
            }
            layout.after_insn = false;
            return Some(Ok(()));
        }
        None
    }

    /// `%P` / `%c` naming a link-time address (not a compile-time constant):
    /// the operand's captured value is the address. `lea` materializes it
    /// into the destination; `call` / `jmp` branch through the stage
    /// register. `None` when the instruction carries no such operand.
    fn emit_address_operand(
        &self,
        insn: &super::asm::AsmInsn,
        code: &mut Vec<u8>,
        layout: &mut AsmLayout,
    ) -> Option<Emit> {
        use super::asm::{AsmOpnd, Mnemonic};
        let (k, idx) = insn
            .operands
            .iter()
            .enumerate()
            .find_map(|(k, o)| match *o {
                AsmOpnd::RefConst { idx, .. } if self.stmt.const_of(idx).is_none() => {
                    Some((k, idx))
                }
                _ => None,
            })?;
        let name = match insn.mnemonic {
            Mnemonic::Table(n) => n,
            _ => "",
        };
        let stage = self.scratch.stage;
        match name {
            "lea" | "leaq" if k == 0 && insn.operands.len() == 2 => {
                let dst = match insn.operands[1] {
                    AsmOpnd::Reg { reg, .. } if reg < 16 => reg,
                    AsmOpnd::Ref { idx, .. } => match self.tpl.op_reg[idx as usize] {
                        Some(r) => r,
                        None => {
                            return Some(fail("inline asm: `lea` destination must be a register"));
                        }
                    },
                    _ => return Some(fail("inline asm: `lea` destination must be a register")),
                };
                super::encode::emit_mov_r_mem(
                    code,
                    Reg(dst),
                    Reg::RBP,
                    self.scratch.cap_off(idx as usize),
                );
            }
            "call" | "callq" | "jmp" | "jmpq" if insn.operands.len() == 1 => {
                super::encode::emit_mov_r_mem(
                    code,
                    stage,
                    Reg::RBP,
                    self.scratch.cap_off(idx as usize),
                );
                // FF /2 (call) / FF /4 (jmp) through the stage register.
                if stage.0 >= 8 {
                    code.push(0x41);
                }
                code.push(0xFF);
                code.push(if name.starts_with("call") { 0xD0 } else { 0xE0 } | (stage.0 & 7));
            }
            _ => {
                return Some(fail(
                    "inline asm: `%c`/`%P` address operand outside lea/call/jmp",
                ));
            }
        }
        layout.after_insn = true;
        Some(Ok(()))
    }

    /// The direct-branch forms: a jmp / jcc to a local label, a label `lea`,
    /// a jmp / jcc to an `asm goto` label, a `call` / `jmp` to a symbol.
    /// `None` when `insn` is none of these.
    fn emit_branch(
        &self,
        ii: usize,
        insn: &super::asm::AsmInsn,
        out: &mut Out,
        layout: &mut AsmLayout,
        long_sites: &mut alloc::collections::BTreeSet<usize>,
    ) -> Option<Emit> {
        use super::asm::{AsmOpnd, Mnemonic};
        let code = &mut *out.cx.code;
        // The direct-branch forms carry no REX byte, so a prefix on one
        // would be dropped rather than encoded.
        if insn.rex.is_some()
            && (matches!(
                insn.operands.first(),
                Some(AsmOpnd::Label { .. } | AsmOpnd::GotoLabel(_))
            ) || (!insn.sym_exprs.is_empty() && insn.operands.is_empty()))
        {
            return Some(fail("inline asm: a `rex` prefix on a direct branch"));
        }
        // A jmp / jcc to a local label. A target the unit binds weak keeps
        // the rel32 form and relocates against the name. A target this
        // stream defines relaxes to the rel8 form unless a round lengthened
        // it; a target outside the stream keeps rel32 for the section pass.
        if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            let cc = match Self::branch_cc(insn) {
                Ok(cc) => cc,
                Err(e) => return Some(Err(e)),
            };
            if let Some(n) = self.weak_target_name(num) {
                emit_rel32_branch(code, cc);
                out.cx.asm_sym_fixups.push(super::AsmSymFixup {
                    instr_offset: code.len() - 4,
                    kind: crate::c5::asm::AsmRelocKind::JumpRel,
                    target: crate::c5::asm::AsmSectionTarget::Symbol(n),
                    addend: -4,
                });
                layout.after_insn = true;
                return Some(Ok(()));
            }
            let in_stream = self.stream_defs.iter().any(|&(n, di)| {
                n == num
                    && (num >= super::asm::NAMED_LABEL_BASE
                        || if forward { di > ii } else { di < ii })
            });
            let width: u8 = if in_stream && !long_sites.contains(&ii) {
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel8(code, cc, 0),
                    None => super::encode::emit_jmp_rel8(code, 0),
                }
                1
            } else {
                emit_rel32_branch(code, cc);
                4
            };
            layout
                .label_fixups
                .push((code.len() - width as usize, num, forward, width, ii));
            layout.after_insn = true;
            return Some(Ok(()));
        }
        // `lea LABEL(%rip), %reg`: the RIP-relative form with a zero rel32
        // the label fixup pass patches like a jump displacement.
        if let Some(&AsmOpnd::LabelAddr { num, forward }) = insn.operands.first() {
            let width = match self.emit_label_lea(insn, code) {
                Ok(w) => w,
                Err(e) => return Some(Err(e)),
            };
            layout
                .label_fixups
                .push((code.len() - 4, num, forward, width, ii));
            layout.after_insn = true;
            return Some(Ok(()));
        }
        // A jmp / jcc to an `asm goto` label (`%lK`): the rel32 form; the
        // site is patched to its exit below.
        if let Some(&AsmOpnd::GotoLabel(k)) = insn.operands.first() {
            let Some(row) = self.goto_row else {
                return Some(fail("inline asm: `%l` label reference outside `asm goto`"));
            };
            if 1 + k as usize >= row.len() {
                return Some(fail("inline asm: `%l` label index out of range"));
            }
            let cc = match Self::branch_cc(insn) {
                Ok(cc) => cc,
                Err(e) => return Some(Err(e)),
            };
            let site = code.len();
            emit_rel32_branch(code, cc);
            let kind = match cc {
                Some(cc) => LocalBranchKind::Jcc(cc),
                None => LocalBranchKind::Jmp,
            };
            layout.goto_sites.push((site, kind, k as usize));
            layout.after_insn = true;
            return Some(Ok(()));
        }
        // A direct `call` / `jmp` to a symbol: E8 / E9 with a rel32 the fixup
        // pass patches once every function's address is final. Other
        // instructions with a symbol expression (a `$symbol` immediate, a
        // symbol-displacement memory operand) resolve through their operands.
        if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
            && matches!(insn.mnemonic, Mnemonic::Table("call" | "jmp"))
        {
            let is_call = matches!(insn.mnemonic, Mnemonic::Table(n) if n.starts_with("call"));
            // The name may embed operand references (`__get_user_%c0`).
            let name = match crate::c5::asm::resolve_asm_symbol_target(
                name,
                &crate::c5::asm::X64_SYMBOL_SUBST,
                &|i| self.stmt.const_of(i),
            ) {
                Ok(n) => n,
                Err(e) => return Some(fail(e)),
            };
            // The code stream's branch channels name a symbol with no addend.
            // TODO carry an addend on the call site and the fixup.
            if !crate::c5::asm::is_asm_symbol_name(&name) {
                return Some(fail(
                    "inline asm: a branch to a symbol expression is only supported in a section",
                ));
            }
            // `native_offset` is the opcode byte; the fixup pass patches the
            // rel32 at +1 against the 5-byte end.
            let native_offset = code.len();
            match self.stmt.name2entpc.get(name.as_str()) {
                Some(&ent_pc) => out.fixups.push(super::encode::Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind: super::encode::BranchKind::Call,
                }),
                // Not defined here: a call relocation against the name, as
                // for a compiler-emitted call to an extern function.
                None => out
                    .cx
                    .asm_extern_call_sites
                    .push(super::UserExternCallSite {
                        instr_offset: native_offset,
                        symbol_name: name.clone(),
                        is_tail: !is_call,
                    }),
            }
            code.push(if is_call { 0xE8 } else { 0xE9 });
            code.extend_from_slice(&[0u8; 4]);
            layout.after_insn = true;
            return Some(Ok(()));
        }
        // A `jcc` to a bare symbol resolves against a section label; only
        // file-scope section code carries that resolution.
        if !insn.sym_exprs.is_empty()
            && insn.operands.is_empty()
            && matches!(insn.mnemonic, Mnemonic::Table(n) if jcc_cond(n).is_some())
        {
            return Some(fail(
                "inline asm: a conditional branch to a symbol is only supported in file-scope asm",
            ));
        }
        None
    }

    /// `lea LABEL(%rip), %reg`: returns the width of the displacement field.
    fn emit_label_lea(&self, insn: &super::asm::AsmInsn, code: &mut Vec<u8>) -> Emit<u8> {
        use super::super::ir::{AsmConstraint, AsmRegSize};
        use super::asm::AsmOpnd;
        if !matches!(insn.mnemonic, super::asm::Mnemonic::Table("lea")) {
            return fail("inline asm: a label address requires `lea`");
        }
        let [_, dst] = insn.operands.as_slice() else {
            return fail("inline asm: `lea` needs a destination register");
        };
        let operands = &self.stmt.asm.operands;
        let (reg, width) = match *dst {
            AsmOpnd::Reg { reg, size } if reg < 16 => (reg, size.bytes()),
            AsmOpnd::Ref { idx, size } => match self.tpl.op_reg[idx as usize] {
                Some(r)
                    if !matches!(
                        operands[idx as usize].constraint,
                        AsmConstraint::Fp | AsmConstraint::Mem
                    ) =>
                {
                    (
                        r,
                        size.unwrap_or(AsmRegSize::from_width(operands[idx as usize].width))
                            .bytes(),
                    )
                }
                _ => return fail("inline asm: `lea` destination must be a register"),
            },
            _ => return fail("inline asm: `lea` destination must be a register"),
        };
        let tops = [
            super::table::Opnd::Reg { num: reg, width },
            super::table::Opnd::RipRel { disp: 0, width },
        ];
        match super::table::encode(super::table::Mnem::Lea, None, &tops) {
            Ok(bytes) => code.extend_from_slice(&bytes),
            Err(m) => return fail(m),
        }
        Ok(4)
    }

    /// Resolve the operands to concrete registers, immediates and memory
    /// references.
    fn resolve_operands(
        &self,
        insn: &super::asm::AsmInsn,
        at: usize,
        layout: &AsmLayout,
    ) -> Emit<ResolvedOperands> {
        use super::asm::AsmOpnd;
        let mut r = ResolvedOperands {
            concrete: alloc::vec::Vec::new(),
            operand_seg: None,
            riprel_reloc: None,
            imm_expr: None,
            disp_expr: None,
        };
        // An immediate encodes after the memory operand's disp32, so a
        // RIP-relative form would put the relocation on the wrong bytes;
        // an instruction carrying one keeps register-indirect addressing.
        let has_imm_operand = insn.operands.iter().any(|o| match *o {
            AsmOpnd::Imm(_) | AsmOpnd::RefConst { .. } => true,
            AsmOpnd::Ref { idx, .. } => self
                .tpl
                .op_reg
                .get(idx as usize)
                .copied()
                .flatten()
                .is_none(),
            _ => false,
        });
        for o in &insn.operands {
            let c = self.resolve_operand(o, insn, at, layout, has_imm_operand, &mut r)?;
            r.concrete.push(c);
        }
        Ok(r)
    }

    fn resolve_operand(
        &self,
        o: &super::asm::AsmOpnd,
        insn: &super::asm::AsmInsn,
        at: usize,
        layout: &AsmLayout,
        has_imm_operand: bool,
        r: &mut ResolvedOperands,
    ) -> Emit<super::asm::Concrete> {
        use super::asm::{AsmOpnd, Concrete};
        let stmt = self.stmt;
        Ok(match *o {
            AsmOpnd::Imm(val) => Concrete::Imm(val),
            AsmOpnd::HighReg(n) => Concrete::HighReg(n),
            AsmOpnd::HighRef(idx) => {
                match super::asm::resolve_high_ref(idx, &stmt.asm.operands, &self.tpl.op_reg) {
                    Ok(c) => c,
                    Err(m) => return fail(m),
                }
            }
            // `%cN` / `%PN` with a compile-time constant (the address case
            // was handled above): a bare immediate.
            AsmOpnd::RefConst { idx, .. } => match stmt.const_of(idx) {
                Some(v) => Concrete::Imm(v),
                None => {
                    return fail(alloc::format!(
                        "inline asm: non-constant `%c`/`%P` operand `%{idx}`: the operand is {}",
                        stmt.operand_form(idx)
                    ));
                }
            },
            // A bare `%cN` / `%PN` memory reference: a constant addresses
            // absolutely (the percpu form under a `%%gs:` / `%%fs:`
            // override), a link-time address RIP-relative, as for `%a`.
            // TODO: gcc spells a `%c` symbol operand as an absolute
            // reference, which a non-PIC code model needs.
            AsmOpnd::AbsMemRef { idx, .. } => self.resolve_const_ref_mem(idx, insn, false, r)?,
            AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
            AsmOpnd::Ref { idx, size } => self.resolve_ref(idx, size, insn, has_imm_operand, r)?,
            AsmOpnd::Mem {
                base,
                index,
                scale,
                disp,
            } => self.resolve_mem(base, index, scale, disp, insn, r)?,
            // An absolute `seg:disp` reference; the segment prefix rides the
            // instruction. A symbol address needs a relocation the
            // function-body stream does not carry.
            AsmOpnd::AbsMem { sym: Some(_), .. } => {
                return fail(
                    "inline asm: an absolute symbol address is only supported in \
                     file-scope asm",
                );
            }
            AsmOpnd::AbsMem { disp, sym: None } => Concrete::AbsMem {
                disp,
                size: self.mem_size_or_quad(insn),
            },
            // A literal-displacement `disp(%rip)`: no relocation, the address
            // is `rip + disp`.
            AsmOpnd::RipRel { disp } => Concrete::RipRel {
                disp,
                size: self.mem_size_or_quad(insn),
            },
            // `%cN(%%rip)` / `%PN(%%rip)`: a compile-time constant becomes
            // the disp32 literal; a link-time address takes a RIP-relative
            // relocation, as for `%a`.
            AsmOpnd::RipRelRef { idx, .. } => self.resolve_const_ref_mem(idx, insn, true, r)?,
            // `disp(,%index,scale)`: a no-base scaled-index reference. A
            // symbol displacement needs an absolute relocation the
            // function-body stream does not carry.
            AsmOpnd::IndexMem {
                index,
                scale,
                disp,
                sym,
            } => {
                if sym.is_some() {
                    return fail(
                        "inline asm: a symbol-displacement memory operand is only supported in file-scope asm",
                    );
                }
                let Some(index) = self.address_reg(index) else {
                    return fail("inline asm: memory index must be a register operand");
                };
                Concrete::IndexMem {
                    index,
                    scale,
                    disp,
                    size: self.mem_size_or_quad(insn),
                }
            }
            // `disp+sym(%base)`: a displacement expression over template
            // labels is a value the stream settles; one naming a symbol
            // needs a relocation only file-scope section code carries.
            AsmOpnd::SymMem {
                base,
                index,
                scale,
                expr,
            } => self.resolve_sym_mem(base, index, scale, expr, insn, at, layout, r)?,
            // `sym(%%rip)`: a PC-relative reference to a named symbol,
            // through the same relocation channel as a `%a` operand.
            AsmOpnd::SymRipRel { expr } => {
                let size = self.mem_size_or_quad(insn);
                // The in-function channel names a symbol and an offset, so
                // a displacement over a label difference has nowhere to
                // resolve.
                let Some((name, addend)) = insn
                    .sym_exprs
                    .get(expr as usize)
                    .and_then(|e| crate::c5::asm::asm_expr_sym_addend(e))
                else {
                    return fail(
                        "inline asm: a memory displacement over a label difference is only \
                         supported in file-scope asm",
                    );
                };
                r.riprel_reloc = Some((AsmRipSym::Extern { name, offset: 0 }, addend));
                Concrete::RipRel { disp: 0, size }
            }
            // A `$expr` immediate, under the same rule as a displacement.
            AsmOpnd::ImmSym { expr } => {
                let Some(text) = insn.sym_exprs.get(expr as usize) else {
                    return fail("inline asm: symbol immediate expression is missing");
                };
                match self.expr_value(text, at, layout) {
                    Some(v) => Concrete::Imm(v),
                    None if crate::c5::asm::is_template_label_expr(text, self.label_names) => {
                        r.imm_expr = Some(text.clone());
                        Concrete::Imm(ABS_LABEL_PLACEHOLDER)
                    }
                    None => {
                        return fail(
                            "inline asm: `$symbol` address immediate is only supported in \
                             file-scope asm",
                        );
                    }
                }
            }
            // A label address immediate: a placeholder wide enough to force
            // the imm32 field; the relocation replaces it.
            AsmOpnd::ImmLabel { .. } => Concrete::Imm(ABS_LABEL_PLACEHOLDER),
            // Handled by `emit_branch`; a label reaching operand resolution
            // rode an unsupported form.
            AsmOpnd::Label { .. } | AsmOpnd::LabelAddr { .. } | AsmOpnd::GotoLabel(_) => {
                return fail("inline asm: misplaced label reference");
            }
        })
    }

    /// A memory base or index naming a register or a register operand.
    fn address_reg(&self, b: super::asm::AsmMemBase) -> Option<u8> {
        use super::super::ir::AsmConstraint;
        match b {
            super::asm::AsmMemBase::Reg { num, .. } => Some(num),
            super::asm::AsmMemBase::Ref(idx) => self
                .tpl
                .op_reg
                .get(idx as usize)
                .copied()
                .flatten()
                .filter(|_| {
                    !matches!(
                        self.stmt.asm.operands[idx as usize].constraint,
                        AsmConstraint::Fp
                    )
                }),
        }
    }

    /// `%cN` / `%PN` as a memory reference: a compile-time constant is the
    /// displacement literal (RIP-relative under `riprel`, absolute
    /// otherwise), a link-time address a RIP-relative relocation.
    fn resolve_const_ref_mem(
        &self,
        idx: u8,
        insn: &super::asm::AsmInsn,
        riprel: bool,
        r: &mut ResolvedOperands,
    ) -> Emit<super::asm::Concrete> {
        use super::asm::Concrete;
        let size = self.mem_size_or_quad(insn);
        let stmt = self.stmt;
        Ok(match stmt.const_of(idx) {
            Some(v) => match (i32::try_from(v), riprel) {
                (Ok(disp), true) => Concrete::RipRel { disp, size },
                (Ok(disp), false) => Concrete::AbsMem { disp, size },
                (Err(_), true) => {
                    return fail("inline asm: RIP-relative displacement out of range");
                }
                (Err(_), false) => return fail("inline asm: absolute displacement out of range"),
            },
            None => match stmt.riprel_target(idx) {
                Some(sym) => {
                    r.riprel_reloc = Some((sym, 0));
                    Concrete::RipRel { disp: 0, size }
                }
                None => {
                    let what = if riprel {
                        "RIP-relative operand"
                    } else {
                        "memory operand"
                    };
                    return fail(alloc::format!(
                        "inline asm: `%c`/`%P` {what} `%{idx}` is not a constant or address: \
                         the operand is {}",
                        stmt.operand_form(idx)
                    ));
                }
            },
        })
    }

    /// A template operand: a memory-constraint operand is the register
    /// holding its address (a file-scope object addresses RIP-relative
    /// instead, as gcc does), an `x` operand its xmm, any other its register
    /// or its constant.
    fn resolve_ref(
        &self,
        idx: u8,
        size: Option<super::super::ir::AsmRegSize>,
        insn: &super::asm::AsmInsn,
        has_imm_operand: bool,
        r: &mut ResolvedOperands,
    ) -> Emit<super::asm::Concrete> {
        use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg};
        use super::asm::Concrete;
        let stmt = self.stmt;
        let op = &stmt.asm.operands[idx as usize];
        let width = op.width;
        Ok(match self.tpl.op_reg[idx as usize] {
            Some(reg) if matches!(op.constraint, AsmConstraint::Mem) => {
                // The C operand type is only the default width.
                let size = self
                    .mem_size(size, insn)
                    .unwrap_or(AsmRegSize::from_width(width));
                r.operand_seg = match op.seg {
                    AsmSeg::Gs => Some(0x65),
                    AsmSeg::Fs => Some(0x64),
                    AsmSeg::None => r.operand_seg,
                };
                // The captured-address register serves a local, a computed
                // address, and the segment forms, whose base is not a
                // link-time address.
                let sym = if has_imm_operand || !matches!(op.seg, AsmSeg::None) {
                    None
                } else {
                    stmt.riprel_target(idx)
                };
                match sym {
                    Some(sym) => {
                        r.riprel_reloc = Some((sym, 0));
                        Concrete::RipRel { disp: 0, size }
                    }
                    None => Concrete::Mem {
                        base: reg,
                        index: None,
                        scale: 1,
                        disp: 0,
                        size,
                    },
                }
            }
            Some(reg) if matches!(op.constraint, AsmConstraint::Fp) => Concrete::Reg {
                reg: super::asm::XMM_BASE + reg,
                size: size.unwrap_or(AsmRegSize::from_width(width)),
            },
            Some(reg) => Concrete::Reg {
                reg,
                size: size.unwrap_or(AsmRegSize::from_width(width)),
            },
            // A `%N` naming an operand with no register: its constant value.
            None => match stmt.const_of(idx) {
                Some(v) => Concrete::Imm(v),
                None => return fail("inline asm: non-constant immediate operand"),
            },
        })
    }

    /// An explicit `disp(%reg)` memory reference. A `%a` / `disp(%N)` whose
    /// `%N` is an `i`-class symbolic address resolves to no register and
    /// lowers to a RIP-relative reference, as gcc does for `%a`; a scaled
    /// index cannot ride that form. A constant base addresses absolutely.
    fn resolve_mem(
        &self,
        base: super::asm::AsmMemBase,
        index: Option<super::asm::AsmMemBase>,
        scale: u8,
        disp: i32,
        insn: &super::asm::AsmInsn,
        r: &mut ResolvedOperands,
    ) -> Emit<super::asm::Concrete> {
        use super::asm::{AsmMemBase, Concrete};
        let stmt = self.stmt;
        let size = self.mem_size(None, insn);
        let sym = match base {
            AsmMemBase::Ref(bi) if index.is_none() => stmt.riprel_target(bi),
            _ => None,
        };
        let base = match (self.address_reg(base), sym) {
            (Some(b), _) => b,
            (None, Some(sym)) => {
                r.riprel_reloc = Some((sym, disp as i64));
                return Ok(Concrete::RipRel {
                    disp: 0,
                    size: size.unwrap_or(super::super::ir::AsmRegSize::Quad),
                });
            }
            (None, None) => {
                let AsmMemBase::Ref(bi) = base else {
                    return fail("inline asm: memory base must be a register");
                };
                let abs = stmt
                    .const_of(bi)
                    .filter(|_| index.is_none())
                    .and_then(|v| i32::try_from(v.checked_add(disp as i64)?).ok());
                let Some(disp) = abs else {
                    return fail(alloc::format!(
                        "inline asm: memory base `%{bi}` is not a register, a \
                         constant or a link-time address: the operand is {}",
                        stmt.operand_form(bi)
                    ));
                };
                return Ok(Concrete::AbsMem {
                    disp,
                    size: size.unwrap_or(super::super::ir::AsmRegSize::Quad),
                });
            }
        };
        let index = match index {
            Some(i) => match self.address_reg(i) {
                Some(r) => Some(r),
                None => return fail("inline asm: memory index must be a register operand"),
            },
            None => None,
        };
        Ok(Concrete::Mem {
            base,
            index,
            scale,
            disp,
            size: size.unwrap_or(super::super::ir::AsmRegSize::Quad),
        })
    }

    /// `disp+sym(%base)` with a displacement over template labels.
    #[allow(clippy::too_many_arguments)]
    fn resolve_sym_mem(
        &self,
        base: super::asm::AsmMemBase,
        index: Option<super::asm::AsmMemBase>,
        scale: u8,
        expr: u8,
        insn: &super::asm::AsmInsn,
        at: usize,
        layout: &AsmLayout,
        r: &mut ResolvedOperands,
    ) -> Emit<super::asm::Concrete> {
        use super::asm::{AsmMemBase, Concrete};
        let sym_only = "inline asm: a symbol-displacement memory operand is only \
                        supported in file-scope asm";
        let Some(text) = insn.sym_exprs.get(expr as usize) else {
            return fail(sym_only);
        };
        if !crate::c5::asm::is_template_label_expr(text, self.label_names) {
            return fail(sym_only);
        }
        let disp = match self.expr_value(text, at, layout) {
            Some(v) => match i32::try_from(v) {
                Ok(d) => d,
                Err(_) => return fail("inline asm: displacement out of range"),
            },
            None => {
                r.disp_expr = Some(text.clone());
                RIPREL_PROBE_DISP
            }
        };
        let reg_of = |b: AsmMemBase| -> Option<u8> {
            match b {
                AsmMemBase::Reg { num, .. } => Some(num),
                AsmMemBase::Ref(i) => self.tpl.op_reg.get(i as usize).copied().flatten(),
            }
        };
        let (Some(base), index) = (reg_of(base), index.map(reg_of)) else {
            return fail("inline asm: memory base is not a register");
        };
        if index == Some(None) {
            return fail("inline asm: memory index is not a register");
        }
        Ok(Concrete::Mem {
            base,
            index: index.flatten(),
            scale,
            disp,
            size: self.mem_size_or_quad(insn),
        })
    }

    /// Encode `insn` over its resolved operands behind the prefix run it
    /// leads, then record the fields the layout or the writers settle: a
    /// label address immediate, an expression displacement or immediate,
    /// and a RIP-relative symbol relocation.
    fn encode_insn(
        &self,
        insn: &super::asm::AsmInsn,
        mut resolved: ResolvedOperands,
        pending_at: Option<usize>,
        out: &mut Out,
        layout: &mut AsmLayout,
    ) -> Emit {
        use super::asm::{AsmOpnd, Concrete};
        let abs_label = match insn.operands.first() {
            Some(&AsmOpnd::ImmLabel { num, forward }) => Some((num, forward)),
            _ => None,
        };
        let concrete = &resolved.concrete;
        if abs_label.is_some()
            && concrete
                .iter()
                .filter(|c| matches!(c, Concrete::Imm(_)))
                .count()
                > 1
        {
            return fail("inline asm: a label address immediate with a second immediate");
        }
        let code = &mut *out.cx.code;
        // A segment override comes from a template `%gs:` / `%fs:` or from
        // a `__seg_gs` / `__seg_fs` operand; it joins the prefix statements
        // ahead of the instruction.
        let pending = match pending_at {
            Some(at) => code.split_off(at),
            None => alloc::vec::Vec::new(),
        };
        let insn_at = code.len();
        let addr = super::asm::addr_size(insn, super::table::Mode::Bits64);
        let mut body = alloc::vec::Vec::new();
        if let Err(m) = super::asm::encode(&mut body, addr, insn.mnemonic, insn.suffix, concrete) {
            return fail(m);
        }
        let sizes = push_legacy_prefixes(code, &body, insn.seg.or(resolved.operand_seg), &pending);
        code.extend_from_slice(&body[sizes..]);
        if let Some(rex) = insn.rex
            && let Err(m) = super::asm::splice_rex(code, insn_at, rex)
        {
            return fail(m);
        }
        // Each placeholder occupies the last four bytes; it confirms the
        // chosen form put the field there.
        if let Some((num, forward)) = abs_label {
            let Some(at) = take_placeholder(code, &ABS_LABEL_PLACEHOLDER_BYTES) else {
                return fail("inline asm: a label address immediate requires a wider form");
            };
            layout.abs_label_fixups.push((at, num, forward));
        }
        // An immediate would follow the displacement, so a form carrying one
        // is refused rather than patched wrong.
        if let Some(text) = resolved.disp_expr.take() {
            if concrete.iter().any(|c| matches!(c, Concrete::Imm(_))) {
                return fail("inline asm: an expression displacement with an immediate");
            }
            let Some(at) = take_placeholder(code, &RIPREL_PROBE_DISP.to_le_bytes()) else {
                return fail("inline asm: an expression displacement requires a wider form");
            };
            layout.expr_fixups.push((insn_at, at, 4, text));
        }
        if let Some(text) = resolved.imm_expr.take() {
            let Some(at) = take_placeholder(code, &ABS_LABEL_PLACEHOLDER_BYTES) else {
                return fail("inline asm: an expression immediate requires a wider form");
            };
            layout.expr_fixups.push((insn_at, at, 4, text));
        }
        // Both relocation channels place the reloc at `instr_offset + 3`, so
        // the anchor is three bytes before the disp32 field. gcc's addend is
        // the operand's constant offset less the field's 4-byte PC-relative
        // end skew and any immediate trailing the field.
        if let Some((sym, disp)) = resolved.riprel_reloc.take() {
            let Some((field, trailing)) = riprel_field(&body, concrete, addr, insn) else {
                return fail("inline asm: RIP-relative displacement field not found");
            };
            let instr_offset = code.len() - (body.len() - field) - 3;
            let trailing = trailing as i64;
            match sym {
                AsmRipSym::Extern { name, offset } => {
                    out.cx.user_extern_data_refs.push(super::UserExternDataRef {
                        instr_offset,
                        symbol_name: name,
                        direct_pcrel: Some(offset + disp - 4 - trailing),
                    });
                }
                AsmRipSym::Local { data_offset } => {
                    out.cx.data_fixups.push(DataFixup {
                        instr_offset,
                        data_offset: (data_offset + disp - trailing) as u64,
                        part: AddrPart::Whole,
                    });
                }
                AsmRipSym::Text { ent_pc } if disp == 0 && trailing == 0 => {
                    out.cx.pending_func_fixups.push((instr_offset, ent_pc));
                }
                AsmRipSym::Text { .. } => {
                    return fail(
                        "inline asm: a displacement on an in-unit function address is not supported",
                    );
                }
            }
        }
        layout.after_insn = true;
        Ok(())
    }

    /// Settle each deferred expression field: the layout is final, so a
    /// forward reference now has its definition.
    fn settle_expr_fixups(&self, code: &mut [u8], layout: &AsmLayout) -> Emit {
        for (site, at, width, text) in &layout.expr_fixups {
            let Some(v) = self.expr_value(text, *site, layout) else {
                return fail(alloc::format!(
                    "inline asm: expression `{text}` is not a constant"
                ));
            };
            let w = *width as usize;
            code[*at..*at + w].copy_from_slice(&(v as u64).to_le_bytes()[..w]);
        }
        Ok(())
    }

    /// The main-stream definition a label reference at `at` binds to: a
    /// named label has one definition; a forward `Nf` takes the nearest
    /// after `at`, a backward `Nb` the nearest at or before it (the GNU as
    /// local-label rule).
    fn resolve_label(
        &self,
        layout: &AsmLayout,
        at: usize,
        num: u32,
        forward: bool,
    ) -> Option<usize> {
        let defs = &layout.label_defs;
        if num >= super::asm::NAMED_LABEL_BASE {
            defs.iter().find(|&&(n, _)| n == num).map(|&(_, o)| o)
        } else if forward {
            defs.iter()
                .filter(|&&(n, off)| n == num && off > at)
                .map(|&(_, off)| off)
                .min()
        } else {
            defs.iter()
                .filter(|&&(n, off)| n == num && off <= at)
                .map(|&(_, off)| off)
                .max()
        }
    }

    /// Lengthen every short branch this layout leaves outside the byte's
    /// reach; `true` when the set grew, so the driver runs another round.
    fn grow_long_sites(
        &self,
        layout: &AsmLayout,
        long_sites: &mut alloc::collections::BTreeSet<usize>,
    ) -> bool {
        let known = long_sites.len();
        for &(at, num, forward, width, ii) in &layout.label_fixups {
            if width == 1
                && let Some(target) = self.resolve_label(layout, at, num, forward)
                && !(-128..=127).contains(&(target as i64 - (at as i64 + 1)))
            {
                long_sites.insert(ii);
            }
        }
        long_sites.len() != known
    }

    /// Patch each label reference against the definition it binds to, the
    /// displacement measured from the end of its field. A reference with no
    /// main-stream definition may name a label in a pushed section; it is
    /// returned for the section pass, as is a `$LABEL` immediate, whose field
    /// carries an absolute `.text` relocation.
    fn patch_label_refs(
        &self,
        code: &mut [u8],
        layout: &AsmLayout,
        asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    ) -> Emit<DeferredRefs> {
        let mut deferred = DeferredRefs {
            branches: alloc::vec::Vec::new(),
            addresses: alloc::vec::Vec::new(),
        };
        for &(at, num, forward, width, _) in &layout.label_fixups {
            match self.resolve_label(layout, at, num, forward) {
                Some(target) => {
                    let w = width as usize;
                    let rel = target as i64 - (at + w) as i64;
                    code[at..at + w].copy_from_slice(&rel.to_le_bytes()[..w]);
                }
                // Only a target this stream defines takes the short form.
                None if width == 4 => deferred.branches.push((at, num, forward)),
                None => return fail("inline asm: undefined local label"),
            }
        }
        for &(at, num, forward) in &layout.abs_label_fixups {
            match self.resolve_label(layout, at, num, forward) {
                Some(target) => asm_text_abs_refs.push(super::AsmTextAbsRef {
                    field_offset: at,
                    target_offset: target,
                }),
                None => deferred.addresses.push((at, num, forward)),
            }
        }
        Ok(deferred)
    }

    /// A named label defined in the main stream is a definition of the unit,
    /// as for GNU as: the writers emit a local `.text` symbol and bind a
    /// same-name C reference to it. `.L`-prefixed names are assembler-local
    /// (the renames of multiply defined numeric labels carry that prefix).
    fn record_text_labels(
        &self,
        layout: &AsmLayout,
        asm_text_labels: &mut Vec<super::AsmTextLabel>,
    ) -> Emit {
        for &(num, off) in &layout.label_defs {
            if num < super::asm::NAMED_LABEL_BASE {
                continue;
            }
            let Some(&name) = self
                .label_names
                .get((num - super::asm::NAMED_LABEL_BASE) as usize)
            else {
                continue;
            };
            if crate::c5::asm::is_local_label(name) {
                continue;
            }
            if asm_text_labels.iter().any(|l| l.name == name) {
                return fail(alloc::format!(
                    "inline asm: symbol `{name}` is already defined"
                ));
            }
            asm_text_labels.push(super::AsmTextLabel {
                name: alloc::string::String::from(name),
                text_offset: off,
            });
        }
        Ok(())
    }

    /// Materialize the `.pushsection` blocks, every label offset now known,
    /// then bind each deferred main-stream reference to its section
    /// definition. The sections follow the main stream textually, so only a
    /// forward reference reaches one, and it becomes a relocation against the
    /// target section's symbol.
    fn materialize_sections(
        &self,
        out: &mut Out,
        layout: &AsmLayout,
        deferred: DeferredRefs,
    ) -> Emit {
        use crate::c5::asm::LabelLoc;
        let undefined = "inline asm: undefined local label";
        let no_abs = "inline asm: `$LABEL` address immediate names no local label";
        if self.tpl.blocks.is_empty() {
            if !deferred.branches.is_empty() {
                return fail(undefined);
            }
            if !deferred.addresses.is_empty() {
                return fail(no_abs);
            }
            return Ok(());
        }
        let names = self.label_names;
        let label_off = |name: &str| -> Option<LabelLoc> {
            let num = if let Some(i) = names.iter().position(|&n| n == name) {
                super::asm::NAMED_LABEL_BASE + i as u32
            } else {
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
                    return None;
                }
                digits.parse().ok()?
            };
            // Sections follow the code textually; a `Nb` (or bare `N`)
            // reference binds to the last definition, `Nf` to the first.
            let forward = name.ends_with('f') && !names.contains(&name);
            let mut defs = layout.label_defs.iter().filter(|&&(n, _)| n == num);
            if forward {
                defs.map(|&(_, off)| off).min()
            } else {
                defs.next_back().map(|&(_, off)| off)
            }
            .map(LabelLoc::Text)
        };
        let stmt = self.stmt;
        let resolver = crate::c5::asm::AsmOperandResolver {
            const_of: &|idx| stmt.const_of(idx),
            symbol_of: &|idx| stmt.operand_sym(idx),
            form: &|idx| stmt.operand_form(idx),
        };
        // An `asm goto` label operand (`.long %l0 - .`): the goto row's block
        // index; the reloc carries the block and is rewritten after layout.
        let goto_block = |idx: u8| -> Option<u32> { self.goto_row?.get(1 + idx as usize).copied() };
        let defined = match crate::c5::asm::materialize_asm_sections(
            &self.tpl.blocks,
            &resolver,
            &label_off,
            &goto_block,
            false,
            out.cx.asm_sections,
        ) {
            Ok(d) => d,
            Err(m) => return fail(m),
        };
        let label_name = |num: u32| -> Option<alloc::string::String> {
            if num >= super::asm::NAMED_LABEL_BASE {
                self.label_names
                    .get((num - super::asm::NAMED_LABEL_BASE) as usize)
                    .map(|n| alloc::string::String::from(*n))
            } else {
                Some(alloc::format!("{num}"))
            }
        };
        for (at, num, forward) in deferred.branches {
            let Some(name) = label_name(num) else {
                return fail(undefined);
            };
            let hit = forward
                .then(|| defined.iter().find(|d| d.name == name))
                .flatten();
            let Some(d) = hit else {
                return fail(undefined);
            };
            out.asm_section_text_refs.push(super::AsmSectionTextRef {
                instr_offset: at,
                section_index: d.section_index,
                section_offset: d.offset,
                addend: -4,
                absolute: false,
                kind: crate::c5::asm::AsmRelocKind::Data,
            });
        }
        // The absolute form of the same binding: no end skew.
        for (at, num, forward) in deferred.addresses {
            let Some(name) = label_name(num) else {
                return fail(undefined);
            };
            let hit = forward
                .then(|| defined.iter().find(|d| d.name == name))
                .flatten();
            let Some(d) = hit else {
                return fail(no_abs);
            };
            out.asm_section_text_refs.push(super::AsmSectionTextRef {
                instr_offset: at,
                section_index: d.section_index,
                section_offset: d.offset,
                addend: 0,
                absolute: true,
                kind: crate::c5::asm::AsmRelocKind::Data,
            });
        }
        Ok(())
    }

    /// Flag outputs: the template's condition flags are still live here,
    /// so each `=@cc<cond>` materializes with `set<cond>` into its
    /// register's low byte, zero-extended. Runs before the store-backs,
    /// whose `mov`s would otherwise follow the template first.
    fn emit_flag_outputs(&self, code: &mut Vec<u8>) -> Emit {
        use super::super::ir::AsmConstraint;
        for (i, op) in self.stmt.asm.operands.iter().enumerate() {
            let AsmConstraint::Flags(nibble) = op.constraint else {
                continue;
            };
            let Some(cc) = super::encode::Cc::from_nibble(nibble) else {
                return fail("inline asm: bad flag-output condition");
            };
            let Some(r) = self.tpl.op_reg[i] else {
                return fail("inline asm: flag output without a register");
            };
            super::encode::emit_setcc_r8(code, cc, Reg(r));
            super::encode::emit_movzx_r_r8(code, Reg(r), Reg(r));
        }
        Ok(())
    }

    /// The store-backs and restores of the fall-through path, then the
    /// `asm goto` exits: a `%lK` branch leaves mid-template, so it lands on a
    /// trampoline repeating the exit sequence and jumping to the label's
    /// block through the enclosing function's branch fixups (a label
    /// targeting the fall-through block reuses the fall-through exit). With
    /// an empty exit sequence the template branch itself rides the function's
    /// branch fixups, pinned to its long form.
    fn emit_exits(
        &self,
        code: &mut Vec<u8>,
        layout: &AsmLayout,
        goto_direct: bool,
        goto_ctx: Option<&mut AsmGotoCtx<'_>>,
    ) {
        let asm = self.stmt.asm;
        let op_reg = &self.tpl.op_reg;
        let exit_start = code.len();
        self.scratch.emit_outputs(code, asm, op_reg);
        self.scratch.emit_restore(code);
        let Some(ctx) = goto_ctx else {
            return;
        };
        if goto_direct {
            for &(site, kind, k) in &layout.goto_sites {
                ctx.branch_fixups.push(BranchFixup {
                    site: site + kind.opcode_len(),
                    target: ctx.row[1 + k],
                    kind,
                    short: false,
                    pinned_long: true,
                });
            }
            return;
        }
        let mut tramp_at: alloc::vec::Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
        if layout
            .goto_sites
            .iter()
            .any(|&(_, _, k)| ctx.row[1 + k] != ctx.row[0])
        {
            let skip_site = code.len() + 1;
            super::encode::emit_jmp_rel32(code, 0);
            for &(_, _, k) in &layout.goto_sites {
                if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                    continue;
                }
                tramp_at[k] = Some(code.len());
                self.scratch.emit_outputs(code, asm, op_reg);
                self.scratch.emit_restore(code);
                emit_local_branch(
                    code,
                    ctx.branch_fixups,
                    ctx.branch_short,
                    LocalBranchKind::Jmp,
                    ctx.row[1 + k],
                );
            }
            let rel = (code.len() - (skip_site + 4)) as i32;
            code[skip_site..skip_site + 4].copy_from_slice(&rel.to_le_bytes());
        }
        for &(site, kind, k) in &layout.goto_sites {
            let target = tramp_at[k].unwrap_or(exit_start);
            let at = site + kind.opcode_len();
            let rel = target as i64 - (at + 4) as i64;
            code[at..at + 4].copy_from_slice(&(rel as i32).to_le_bytes());
        }
    }
}

/// A `jmp` / `jcc` in the rel32 form with a zero displacement.
fn emit_rel32_branch(code: &mut Vec<u8>, cc: Option<Cc>) {
    match cc {
        Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
        None => super::encode::emit_jmp_rel32(code, 0),
    }
}

/// The offset of a four-byte placeholder ending the stream, zeroed for the
/// relocation or the settled value to fill; `None` when the encoding did
/// not put the field there.
fn take_placeholder(code: &mut [u8], placeholder: &[u8; 4]) -> Option<usize> {
    if code.len() < 4 || code[code.len() - 4..] != placeholder[..] {
        return None;
    }
    let at = code.len() - 4;
    code[at..].fill(0);
    Some(at)
}

/// One layout attempt under the branch forms `long_sites` fixes. Returns
/// with the set grown, ahead of any patching or section materialization,
/// when a short branch does not reach; the driver above rolls back what
/// the attempt emitted.
fn emit_inline_asm_once(
    out: &mut Out,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fcx: &FnCtx,
    mut goto_ctx: Option<AsmGotoCtx<'_>>,
    long_sites: &mut alloc::collections::BTreeSet<usize>,
) -> Emit {
    // A statement that lowers to nothing keeps only its IR-level ordering
    // effect; `asm_scratch_bytes` reserved no region for it.
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86) {
        return Ok(());
    }
    let stmt = AsmStmt {
        asm,
        args,
        func: fcx.func,
        alloc: fcx.alloc,
        frame: fcx.frame,
        name2entpc: fcx.name2entpc,
        extern_data_names: fcx.extern_data_names,
        extern_code_names: fcx.extern_code_names,
    };
    let goto_row = goto_ctx.as_ref().map(|c| c.row);
    let tpl = prepare_template(&stmt, out.cx.asm_sections, goto_row)?;
    let label_names = super::asm::scan_label_names(&tpl.code);
    let weak_names = crate::c5::asm::asm_weak_only_names(&tpl.blocks, out.cx.asm_sections);
    let stream_defs: alloc::vec::Vec<(u32, usize)> = tpl
        .insns
        .iter()
        .enumerate()
        .filter_map(|(ii, insn)| insn.label_def.map(|n| (n, ii)))
        .collect();
    let scratch = AsmScratch::new(&stmt, &tpl.op_reg)?;
    let goto_direct = scratch.goto_direct(asm);
    scratch.emit_saves(out.cx.code);
    scratch.emit_captures(out.cx.code, &stmt)?;
    scratch.emit_loads(out.cx.code, asm, &tpl.op_reg);
    // Measured against the sink the sections merge into, so this and the
    // materialization settle every branch form the same way.
    let section_measure = match crate::c5::asm::measure_asm_section_offsets(
        &tpl.blocks,
        &|idx| stmt.const_of(idx),
        false,
        out.cx.asm_sections,
    ) {
        Ok(m) => m,
        Err(m) => return fail(m),
    };
    let pass = AsmPass {
        stmt: &stmt,
        tpl: &tpl,
        label_names: &label_names,
        weak_names: &weak_names,
        stream_defs,
        section_measure,
        scratch: &scratch,
        goto_row,
    };
    // The template opens right after the function's compiled code, so the
    // last byte came from an instruction.
    let mut layout = AsmLayout {
        after_insn: true,
        ..Default::default()
    };
    for (ii, insn) in tpl.insns.iter().enumerate() {
        pass.emit_insn(ii, insn, out, &mut layout, long_sites)?;
    }
    pass.settle_expr_fixups(out.cx.code, &layout)?;
    if pass.grow_long_sites(&layout, long_sites) {
        return Ok(());
    }
    let deferred = pass.patch_label_refs(out.cx.code, &layout, out.asm_text_abs_refs)?;
    pass.record_text_labels(&layout, out.asm_text_labels)?;
    pass.materialize_sections(out, &layout, deferred)?;
    pass.emit_flag_outputs(out.cx.code)?;
    pass.emit_exits(out.cx.code, &layout, goto_direct, goto_ctx.as_mut());
    Ok(())
}

/// Map a conditional-jump mnemonic to its condition code, folding the
/// synonym spellings (`jc`==`jb`, `jnae`==`jb`, ...). `None` for `jmp` and
/// for any non-jcc mnemonic.
pub(crate) fn jcc_cond(name: &str) -> Option<super::encode::Cc> {
    use super::encode::Cc;
    Some(match name {
        "je" | "jz" => Cc::E,
        "jne" | "jnz" => Cc::Ne,
        "js" => Cc::S,
        "jns" => Cc::Ns,
        "jl" | "jnge" => Cc::L,
        "jge" | "jnl" => Cc::Ge,
        "jg" | "jnle" => Cc::G,
        "jle" | "jng" => Cc::Le,
        "jb" | "jc" | "jnae" => Cc::B,
        "jae" | "jnb" | "jnc" => Cc::Ae,
        "ja" | "jnbe" => Cc::A,
        "jbe" | "jna" => Cc::Be,
        "jo" => Cc::O,
        "jno" => Cc::No,
        "jp" | "jpe" => Cc::P,
        "jnp" | "jpo" => Cc::Np,
        _ => return None,
    })
}

/// Load the low `width` bytes at `[base]` into `dst` (zero-extended).
fn emit_asm_load_width(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::encode::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::encode::emit_mov_r_mem32(code, dst, base, 0),
        _ => super::encode::emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`.
fn emit_asm_store_width(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::encode::emit_mov_mem_r8(code, base, 0, src),
        2 => super::encode::emit_mov_mem_r16(code, base, 0, src),
        4 => super::encode::emit_mov_mem_r32(code, base, 0, src),
        _ => super::encode::emit_mov_mem_r(code, base, 0, src),
    }
}
