use super::*;

/// Report a bail and yield the handler's `false` result.
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

/// Encode replacement instructions in an executable inline-asm section
/// (`.pushsection .altinstr_replacement,"ax"`) to bytes and relocations,
/// replacing each `Code` item with `CodeBytes`. The x86 ALTERNATIVE puts
/// its replacement in a separate section, so there is no fall-through from
/// the main sequence; the bytes and their relocations lay out like any
/// other section data. Only a direct `call` / `jmp` to a symbol (a bare
/// name or a `%c` function operand), a `jmp` / `jcc` to an `asm goto` label
/// (`%lK`, via `goto_block`), and self-contained instructions are assembled;
/// a replacement referencing a register operand or a memory location is
/// rejected rather than mis-encoded.
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

/// Encode a file-scope inline-asm named section's instructions to bytes,
/// reusing the function-body per-instruction encoder with an empty operand
/// context: file-scope asm has no numbered operands, `asm goto` labels, or
/// register assignments, so only self-contained instructions and a direct
/// `call` / `jmp` to a bare symbol assemble.
///
/// The `.code16` / `.code32` / `.code64` state is a property of the assembler's
/// input stream, so it carries across the walk in section order rather than
/// resetting per section.
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

/// Encode one replacement instruction to a `CodeBytes` item. A direct
/// `call` / `jmp` to a symbol emits `E8`/`E9` with a zero rel32 and a
/// `PLT32` branch relocation (addend -4), matching a compiler-emitted
/// call; a `jmp` / `jcc` to an `asm goto` label (`%lK`) emits the same
/// `E9` / `0F 8x` rel32 with a `PC32` relocation (addend -4) to the label's
/// caller block. Otherwise the operands resolve to registers, immediates,
/// and memory references: a template operand (`%N`) takes its register or
/// `i`-class constant, a register-indirect / displacement memory operand
/// encodes with no relocation, and a `%a[N]` operand naming a link-time
/// address lowers to a RIP-relative reference with a `PC32` relocation
/// against the symbol. A form that resolves to none of these is rejected.
fn encode_one_x86_section_insn(
    text: &str,
    mode: &mut super::table::Mode,
    operand_target: &dyn Fn(u8) -> Option<crate::c5::asm::AsmSectionTarget>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    refs: &SectionOperandRefs<'_>,
) -> Result<crate::c5::asm::AsmSectionItem, alloc::string::String> {
    use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg};
    use super::asm::{AsmMemBase, AsmOpnd, Concrete, Mnemonic};
    use crate::c5::asm::{AsmRelocKind, AsmSectionItem, AsmSectionReloc, AsmSectionTarget};
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
    let prefix = prefix.as_slice();
    let mnem = match insn.mnemonic {
        Mnemonic::Table(n) => n,
        _ => "",
    };
    // REX is a 64-bit-mode prefix; the other modes read the byte as an
    // instruction, so GNU as rejects it there.
    if mode != super::table::Mode::Bits64
        && (insn.rex.is_some()
            || matches!(insn.mnemonic, Mnemonic::Prefix(b) if (0x40..=0x4F).contains(&b)))
    {
        return Err(alloc::format!(
            "inline asm: replacement `{text}` takes a `rex` prefix outside 64-bit mode"
        ));
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
        return Err(alloc::format!(
            "inline asm: replacement `{text}` prefix on a branch"
        ));
    }
    // A `jmp` / `jcc` to an `asm goto` label (`%lK`): the replacement leaves
    // the alternative for a caller block (`jmp %l[t_no]` in `_static_cpu_has`).
    // Emit the rel32 form with a zero displacement and a `PC32` relocation to
    // the label's block, deferred as `TextBlock` and rewritten to the block's
    // text offset after layout -- the GNU as cross-section branch (addend -4).
    if let Some(&AsmOpnd::GotoLabel(k)) = insn.operands.first() {
        let cc = jcc_cond(mnem);
        if cc.is_none() && !matches!(mnem, "jmp" | "jmpq") {
            return Err(alloc::format!(
                "inline asm: replacement `{text}` label operand on a non-jump"
            ));
        }
        let bid = goto_block(k).ok_or_else(|| {
            alloc::format!("inline asm: replacement `{text}` `%l{k}` names no `asm goto` label")
        })?;
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
        return Ok(AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec![reloc],
            short: None,
        });
    }
    // The count- and rcx-conditional branches take a rel8 field only, so a
    // label target resolves to a one-byte displacement rather than the
    // mode-width one the other branches take.
    if let Some(op) = short_branch_opcode(mnem) {
        let prefix = e3_branch_prefix(mnem, mode).map_err(|m| alloc::format!("{m} (`{text}`)"))?;
        let target = if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            insn.sym_exprs
                .first()
                .filter(|n| insn.operands.is_empty() && !n.contains('%'))
                .map(|t| branch_section_target(t))
        };
        if let Some(target) = target {
            let mut bytes = alloc::vec::Vec::new();
            bytes.extend(prefix);
            bytes.extend([op, 0]);
            return Ok(AsmSectionItem::CodeBytes {
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
            });
        }
        // `jcxz` / `jecxz` have no catalogue row to fall back to.
        if matches!(mnem, "jcxz" | "jecxz") {
            return Err(alloc::format!(
                "inline asm: replacement `{text}`: `{mnem}` takes a label target"
            ));
        }
    }
    let is_call = mnem.starts_with("call");
    let is_jmp = matches!(mnem, "jmp" | "jmpq");
    if is_call || is_jmp {
        // A bare-symbol branch target carries no operands; an operand form
        // (`jmp *sym(%rip)`) encodes through the operand path below.
        let target = if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
        {
            if name.contains('%') {
                return Err(alloc::format!(
                    "inline asm: replacement `{text}` call target embeds an operand"
                ));
            }
            Some(branch_section_target(name))
        } else if let Some(&AsmOpnd::RefConst { idx, .. }) = insn.operands.first() {
            Some(operand_target(idx).ok_or_else(|| {
                alloc::format!("inline asm: replacement `{text}` call target is not a symbol")
            })?)
        } else if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            // A numeric-label target resolves at materialize time against
            // this statement's section labels.
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            // An indirect target (`call *%rdi`) encodes on the general
            // operand path below.
            None
        };
        if let Some(target) = target {
            let (rel, prefixed) = branch_rel_width(mode, insn.suffix);
            let mut bytes = alloc::vec::Vec::new();
            if prefixed {
                bytes.push(0x66);
            }
            bytes.push(if is_call { 0xE8u8 } else { 0xE9 });
            let offset = bytes.len() as u32;
            bytes.resize(bytes.len() + rel as usize, 0);
            let reloc = AsmSectionReloc {
                offset,
                width: rel,
                kind: if is_call {
                    AsmRelocKind::Data
                } else {
                    AsmRelocKind::JumpRel
                },
                pcrel: true,
                // Only long mode reaches a call target through a PLT slot.
                branch: mode == super::table::Mode::Bits64,
                signed: false,
                target,
                addend: -(rel as i64),
            };
            let short = (!is_call && !prefixed).then(|| short_branch_form(0xEB, &reloc.target));
            return Ok(AsmSectionItem::CodeBytes {
                bytes,
                relocs: alloc::vec![reloc],
                short,
            });
        }
    }
    // A `jcc` to a symbol or a numeric label -- a section-local label (this
    // or another statement of the section) or an external name: the rel32
    // form with a branch relocation the writer resolves against the label's
    // symbol (a same-section target patches at materialize time).
    if let Some(cc) = jcc_cond(mnem) {
        let target = if insn.operands.is_empty()
            && let Some(name) = insn.sym_exprs.first()
        {
            if name.contains('%') {
                return Err(alloc::format!(
                    "inline asm: replacement `{text}` branch target embeds an operand"
                ));
            }
            Some(branch_section_target(name))
        } else if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            None
        };
        if let Some(target) = target {
            let (rel, prefixed) = branch_rel_width(mode, insn.suffix);
            let mut bytes = alloc::vec::Vec::new();
            if prefixed {
                bytes.push(0x66);
            }
            bytes.extend_from_slice(&[0x0F, 0x80 | (cc as u8)]);
            let offset = bytes.len() as u32;
            bytes.resize(bytes.len() + rel as usize, 0);
            let reloc = AsmSectionReloc {
                offset,
                width: rel,
                kind: AsmRelocKind::JumpRel,
                pcrel: true,
                branch: mode == super::table::Mode::Bits64,
                signed: false,
                target,
                addend: -(rel as i64),
            };
            let short = (!prefixed).then(|| short_branch_form(0x70 | (cc as u8), &reloc.target));
            return Ok(AsmSectionItem::CodeBytes {
                bytes,
                relocs: alloc::vec![reloc],
                short,
            });
        }
    }
    // Resolve each operand to a concrete register, immediate, or memory
    // reference. A template operand assigned a register uses it; an `i`-class
    // operand uses its constant. A base register is a `%%reg` or an operand's
    // register; a `%a[N]` operand naming an `i`-class link-time address
    // resolves to no register and lowers to a RIP-relative reference.
    // A reference with no width of its own takes the mode's default operand
    // size, which the near-branch and stack group promotes to 64 bits in long
    // mode and leaves at 32 or 16 outside it.
    let mem_size = |insn: &super::asm::AsmInsn| {
        asm_mem_size(None, insn, refs.operands, refs.op_reg)
            .unwrap_or(AsmRegSize::from_width(mode.stack_opsize()))
    };
    let reg_of = |idx: u8, modifier: Option<AsmRegSize>| -> Option<Concrete> {
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
    };
    // A memory base / index that names an operand resolves to its assigned GP
    // register (an FP operand is not an address register).
    let base_reg = |b: AsmMemBase| -> Option<u8> {
        match b {
            AsmMemBase::Reg { num, .. } => Some(num),
            AsmMemBase::Ref(i) => refs.op_reg.get(i as usize).copied().flatten().filter(|_| {
                !matches!(
                    refs.operands.get(i as usize).map(|o| o.constraint),
                    Some(AsmConstraint::Fp)
                )
            }),
        }
    };
    let mut concrete = alloc::vec::Vec::new();
    // A symbolic disp32 operand: its reloc target, the symbol addend, the
    // operand's index in `concrete`, and whether the reference is PC-relative
    // (a RIP-relative `%a` / `%c`) or absolute (a no-base scaled-index
    // `sym(,%index,scale)`). The disp32 field is located by re-encoding. At
    // most one such operand per instruction.
    let mut sym_disp: Option<(AsmSectionTarget, i64, usize, bool)> = None;
    // A `$symbol` immediate: its reloc target, the symbol addend, and the
    // operand's index in `concrete`. The field is located by re-encoding, as
    // for a symbolic displacement. At most one per instruction.
    let mut sym_imm: Option<(AsmSectionTarget, i64, usize)> = None;
    // A `__seg_gs` / `__seg_fs` memory operand's segment override; a template
    // `%%gs:` rides `insn.seg` instead, and the two never conflict.
    let mut operand_seg: Option<u8> = None;
    // The relocation target of the operand expression an operand names: the
    // section engine evaluates it against the layout when the section
    // materializes.
    let expr_target = |i: u8| -> Result<AsmSectionTarget, alloc::string::String> {
        insn.sym_exprs
            .get(i as usize)
            .map(|e| AsmSectionTarget::Expr(e.clone()))
            .ok_or_else(|| {
                alloc::format!("inline asm: replacement `{text}` operand expression is missing")
            })
    };
    for o in &insn.operands {
        match *o {
            AsmOpnd::Imm(v) => concrete.push(Concrete::Imm(v)),
            AsmOpnd::ImmSym { expr } => {
                // An expression that is already a constant encodes as the
                // literal, taking the operand's narrowest form.
                if let Some(v) = insn
                    .sym_exprs
                    .get(expr as usize)
                    .and_then(|e| (refs.fold)(e))
                {
                    concrete.push(Concrete::Imm(v));
                    continue;
                }
                if sym_imm.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one symbol immediate"
                    ));
                }
                sym_imm = Some((expr_target(expr)?, 0, concrete.len()));
                concrete.push(Concrete::Imm(IMM_PROBE[0].1));
            }
            AsmOpnd::Reg { reg, size } => concrete.push(Concrete::Reg { reg, size }),
            AsmOpnd::HighReg(n) => concrete.push(Concrete::HighReg(n)),
            AsmOpnd::HighRef(idx) => {
                concrete.push(super::asm::resolve_high_ref(
                    idx,
                    refs.operands,
                    refs.op_reg,
                )?);
            }
            AsmOpnd::Ref { idx, size } => {
                // A memory-constraint (`m`) operand holds its address in the
                // assigned register; `%N` is the register-indirect reference
                // `(%r)`, the same lowering the code stream uses (a `lea %N`
                // then computes the address). Any other operand resolves to a
                // register or an `i`-class constant.
                let op = refs.operands.get(idx as usize);
                let mem = matches!(op.map(|o| o.constraint), Some(AsmConstraint::Mem))
                    .then(|| refs.op_reg.get(idx as usize).copied().flatten())
                    .flatten();
                match mem {
                    Some(base) => {
                        let width = op.map(|o| o.width).unwrap_or(8);
                        let size = asm_mem_size(size, insn, refs.operands, refs.op_reg)
                            .unwrap_or(AsmRegSize::from_width(width));
                        operand_seg = match op.map(|o| o.seg) {
                            Some(AsmSeg::Gs) => Some(0x65),
                            Some(AsmSeg::Fs) => Some(0x64),
                            _ => operand_seg,
                        };
                        concrete.push(Concrete::Mem {
                            base,
                            index: None,
                            scale: 1,
                            disp: 0,
                            size,
                        });
                    }
                    None => concrete.push(reg_of(idx, size).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: replacement `{text}` operand `%{idx}` is not a register \
                             or constant: the operand is {}",
                            (refs.form)(idx)
                        )
                    })?),
                }
            }
            AsmOpnd::Mem {
                base,
                index,
                scale,
                disp,
            } => {
                let size = mem_size(insn);
                // A `%a[N]` (base-only operand naming an `i`-class link-time
                // address) resolves to no register. A scaled index cannot ride
                // the RIP-relative form.
                let sym = match base {
                    AsmMemBase::Ref(bi) if index.is_none() => (refs.addr_of)(bi),
                    _ => None,
                };
                match (base_reg(base), sym) {
                    (Some(b), _) => {
                        let index = match index {
                            Some(i) => Some(base_reg(i).ok_or_else(|| {
                                alloc::format!(
                                    "inline asm: replacement `{text}` memory index is not a register"
                                )
                            })?),
                            None => None,
                        };
                        concrete.push(Concrete::Mem {
                            base: b,
                            index,
                            scale,
                            disp,
                            size,
                        });
                    }
                    (None, Some((target, off))) => {
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off + disp as i64, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                    (None, None) => {
                        let AsmMemBase::Ref(bi) = base else {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` memory base is not a register"
                            ));
                        };
                        let abs = (refs.imm_of)(bi)
                            .filter(|_| index.is_none())
                            .and_then(|v| i32::try_from(v.checked_add(disp as i64)?).ok());
                        let Some(disp) = abs else {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` memory base `%{bi}` is not a \
                                 register, a constant or a link-time address: the operand is {}",
                                (refs.form)(bi)
                            ));
                        };
                        concrete.push(Concrete::AbsMem { disp, size });
                    }
                }
            }
            // `disp(%%rip)` with a literal displacement (`leaq (%rip), %r8`):
            // the address is `rip + disp`, computed at run time.
            AsmOpnd::RipRel { disp } => concrete.push(Concrete::RipRel {
                disp,
                size: mem_size(insn),
            }),
            // `%cN(%%rip)` / `%PN(%%rip)`: a constant becomes the disp32
            // literal; a link-time address takes a RIP-relative relocation.
            AsmOpnd::RipRelRef { idx, .. } => {
                let size = mem_size(insn);
                match (refs.imm_of)(idx) {
                    Some(v) => concrete.push(Concrete::RipRel {
                        disp: i32::try_from(v).map_err(|_| {
                            alloc::format!(
                                "inline asm: replacement `{text}` RIP-relative displacement out of range"
                            )
                        })?,
                        size,
                    }),
                    None => {
                        let (target, off) = (refs.addr_of)(idx).ok_or_else(|| {
                            alloc::format!(
                                "inline asm: replacement `{text}` `%c`/`%P` operand is not a \
                                 constant or address: the operand is {}",
                                (refs.form)(idx)
                            )
                        })?;
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                }
            }
            // An absolute address with no base register, written as a literal,
            // as a symbol expression, or as a bare `%cN` / `%PN` operand: the
            // absolute disp form, its field relocated when a symbol names it.
            AsmOpnd::AbsMem { disp, sym } => {
                let size = mem_size(insn);
                let Some(expr) = sym else {
                    concrete.push(Concrete::AbsMem { disp, size });
                    continue;
                };
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                concrete.push(Concrete::AbsMem {
                    disp: abs_probe(super::asm::addr_size(insn, mode)).0,
                    size,
                });
            }
            AsmOpnd::AbsMemRef { idx, .. } => {
                let size = mem_size(insn);
                match (refs.imm_of)(idx) {
                    Some(v) => concrete.push(Concrete::AbsMem {
                        disp: i32::try_from(v).map_err(|_| {
                            alloc::format!(
                                "inline asm: replacement `{text}` absolute displacement out of range"
                            )
                        })?,
                        size,
                    }),
                    None => {
                        let (target, off) = (refs.addr_of)(idx).ok_or_else(|| {
                            alloc::format!(
                                "inline asm: replacement `{text}` `%c`/`%P` operand is not a \
                                 constant or address: the operand is {}",
                                (refs.form)(idx)
                            )
                        })?;
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                }
            }
            // `disp(,%index,scale)`: a no-base scaled-index reference. A symbol
            // displacement takes an absolute reloc; a literal encodes directly.
            AsmOpnd::IndexMem {
                index,
                scale,
                disp,
                sym,
            } => {
                let size = mem_size(insn);
                let index = base_reg(index).ok_or_else(|| {
                    alloc::format!(
                        "inline asm: replacement `{text}` memory index is not a register"
                    )
                })?;
                match sym {
                    Some(expr) => {
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                        concrete.push(Concrete::IndexMem {
                            index,
                            scale,
                            disp: 0,
                            size,
                        });
                    }
                    None => concrete.push(Concrete::IndexMem {
                        index,
                        scale,
                        disp,
                        size,
                    }),
                }
            }
            // `disp+sym(%base[, %index, scale])`: a based reference whose
            // symbol displacement takes an absolute reloc. The probe
            // displacement forces the disp32 form; the field is zeroed once
            // located.
            AsmOpnd::SymMem {
                base,
                index,
                scale,
                expr,
            } => {
                let size = mem_size(insn);
                let base = base_reg(base).ok_or_else(|| {
                    alloc::format!("inline asm: replacement `{text}` memory base is not a register")
                })?;
                let index = match index {
                    Some(i) => Some(base_reg(i).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: replacement `{text}` memory index is not a register"
                        )
                    })?),
                    None => None,
                };
                // A displacement expression that is already a constant
                // encodes as the literal, taking the narrowest based form.
                if let Some(v) = insn
                    .sym_exprs
                    .get(expr as usize)
                    .and_then(|e| (refs.fold)(e))
                    .and_then(|v| i32::try_from(v).ok())
                {
                    concrete.push(Concrete::Mem {
                        base,
                        index,
                        scale,
                        disp: v,
                        size,
                    });
                    continue;
                }
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                concrete.push(Concrete::Mem {
                    base,
                    index,
                    scale,
                    disp: RIPREL_PROBE_DISP,
                    size,
                });
            }
            // `sym(%%rip)` / `(sym - 1b)(%%rip)`: a RIP-relative reference to
            // what the displacement expression leaves symbolic; the disp32
            // takes a PC-relative relocation.
            AsmOpnd::SymRipRel { expr } => {
                let size = mem_size(insn);
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), true));
                concrete.push(Concrete::RipRel { disp: 0, size });
            }
            // `Nf(%%rip)`: the address of a section label, a `lea` source. The
            // materializer values the label, so the reference is a PC-relative
            // relocation against it like any other symbolic displacement.
            AsmOpnd::LabelAddr { num, forward } => {
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                    true,
                ));
                concrete.push(Concrete::RipRel {
                    disp: 0,
                    size: mem_size(insn),
                });
            }
            // `$Nf`: the label's address as an absolute immediate.
            AsmOpnd::ImmLabel { num, forward } => {
                if sym_imm.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one symbol immediate"
                    ));
                }
                sym_imm = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                ));
                concrete.push(Concrete::Imm(IMM_PROBE[0].1));
            }
            // A bare `Nf` outside a branch is AT&T's absolute memory address
            // (the boot stubs patch their own operands through one). The
            // displacement is the address size wide and takes an absolute
            // relocation against the label.
            AsmOpnd::Label { num, forward } => {
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                    false,
                ));
                concrete.push(Concrete::AbsMem {
                    disp: abs_probe(super::asm::addr_size(insn, mode)).0,
                    size: mem_size(insn),
                });
            }
            _ => {
                return Err(alloc::format!(
                    "inline asm: replacement instruction `{text}` operand is not a \
                     register or immediate"
                ));
            }
        }
    }
    // Encode the instruction body; a segment override rides in front of it.
    let addr = super::asm::addr_size(insn, mode);
    let encode = |ops: &[Concrete]| {
        let mut out = alloc::vec::Vec::new();
        super::asm::encode_in(&mut out, mode, addr, insn.mnemonic, insn.suffix, ops)?;
        if let Some(rex) = insn.rex {
            super::asm::splice_rex(&mut out, 0, rex)?;
        }
        Ok(out)
    };
    // A `$symbol` immediate: settle the field's width and signedness before
    // the body is encoded, since both follow from the form the probe value
    // selects. The widest probe that encodes wins, matching GNU as, which
    // relocates a symbol immediate in the operand size's own field rather
    // than in a shortened one.
    let tail = super::asm::imm_field_tail(insn.mnemonic);
    let imm_field = match sym_imm {
        Some((_, _, idx)) => Some(
            locate_sym_imm_field(&concrete, idx, tail, &encode).ok_or_else(|| {
                alloc::format!(
                    "inline asm: replacement `{text}` symbol immediate has no encodable field"
                )
            })?,
        ),
        None => None,
    };
    if let (Some((_, _, idx)), Some(f)) = (&sym_imm, &imm_field) {
        concrete[*idx] = Concrete::Imm(f.probe);
    }
    let mut body =
        encode(&concrete).map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
    let mut bytes = alloc::vec::Vec::new();
    let sizes = push_legacy_prefixes(&mut bytes, &body, insn.seg.or(operand_seg), prefix);
    // A field of `body` past the size prefixes lands in `bytes` shifted by the
    // segment and repeat / lock bytes only, the size prefixes having moved
    // ahead of them.
    let seg_len = bytes.len() as u32 - sizes as u32;
    let mut relocs = alloc::vec::Vec::new();
    if let Some((target, off, idx, pcrel)) = sym_disp {
        // Locate the disp32 field: re-encode with a distinct displacement in
        // that operand, keeping its form; exactly those four bytes differ.
        let mut probe = concrete.clone();
        probe[idx] = match concrete[idx] {
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
        let probe_bytes =
            encode(&probe).map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
        let (field, width) = differing_run(&body, &probe_bytes)
            .filter(|&(_, n)| matches!(n, 2 | 4))
            .ok_or_else(|| {
                alloc::format!(
                    "inline asm: replacement `{text}` displacement field is not a 2- or 4-byte run"
                )
            })?;
        body[field..field + width].fill(0);
        // A PC-relative field's addend is the symbol offset less the field's
        // own end skew and any bytes trailing it (the immediate of `testb
        // $imm, sym(%rip)`), matching gcc. An absolute field is patched with
        // the symbol value plus the offset directly.
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
            // An absolute disp32 is sign-extended into a 64-bit address, so it
            // takes `R_X86_64_32S`; under a 32- or 16-bit address size the
            // field is the whole address and takes the zero-extended flavour.
            signed: !pcrel && width == 4 && addr == 8,
            target,
            addend,
        });
    }
    if let (Some((target, off, _)), Some(f)) = (sym_imm, imm_field) {
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

/// Probe pairs for locating a symbol immediate's field, widest first. Both
/// members of a pair differ in every byte of the field and stay inside the
/// signed range of their width, so a form that accepts one accepts the other.
/// The 8-byte pair comes last: an instruction that also has a 4-byte form
/// (`movq $sym, %rax`) takes it, as GNU as does, and only an imm64-only form
/// (`movabsq`) falls through.
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

/// Lower an `Inst::InlineAsm` (GCC extended asm with operands). Assigns
/// each register operand a machine register per its constraint, saves
/// the registers it and the clobber list overwrite, loads the inputs,
/// encodes the register-concrete template, and stores the outputs back
/// through their addresses. Operand values / addresses are captured to
/// the stack first (via r10) so an operand living in a register the asm
/// then overwrites is read before it is clobbered -- the shape the
/// register-tied intrinsics above use, generalised over the constraints.
/// `goto_ctx` is present for the `asm goto` form (the statement is the
/// last instruction of a `Terminator::AsmGoto` block).
///
/// A template branch to a label of its own stream starts on the rel8 form
/// and is lengthened, permanently, when the settled layout leaves its
/// displacement outside the byte's reach: the attempt grows the set and
/// this driver rolls the outputs back and lays the template out again.
/// Each round either grows the set or is final, the rule
/// `measure_asm_section_offsets` applies to a pushed section's branches.
pub(super) fn emit_inline_asm(
    out: &mut Out,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fcx: &FnCtx,
    mut goto_ctx: Option<AsmGotoCtx<'_>>,
) -> bool {
    let mut long_sites: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let base = out.mark();
    loop {
        let known = long_sites.len();
        let round_ctx = goto_ctx.as_mut().map(|c| AsmGotoCtx {
            row: c.row,
            branch_fixups: &mut *c.branch_fixups,
            branch_short: c.branch_short,
        });
        if !emit_inline_asm_once(out, asm, args, fcx, round_ctx, &mut long_sites) {
            return false;
        }
        if long_sites.len() == known {
            return true;
        }
        out.restore(&base);
    }
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
) -> bool {
    use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg};
    use super::asm::{AsmOpnd, Concrete};
    let FnCtx {
        func,
        alloc,
        frame,
        name2entpc,
        extern_data_names,
        extern_code_names,
        ..
    } = *fcx;
    let cx = &mut *out.cx;
    let fixups = &mut *out.fixups;
    let asm_section_text_refs = &mut *out.asm_section_text_refs;
    let asm_text_abs_refs = &mut *out.asm_text_abs_refs;
    let asm_text_labels = &mut *out.asm_text_labels;
    let code = &mut *cx.code;
    let asm_sections = &mut *cx.asm_sections;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    let asm_sym_fixups = &mut *cx.asm_sym_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let user_extern_data_refs = &mut *cx.user_extern_data_refs;
    let text_align = &mut *cx.text_align;
    // A statement that lowers to nothing keeps only its IR-level ordering
    // effect; the operand staging around zero bytes of code is dead, and
    // `asm_scratch_bytes` reserved no region for it.
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86) {
        return true;
    }
    // Expand `%=` once so the code text and any `.pushsection` content
    // share one instance number, then split off the section blocks; the
    // arch parser sees only the code text.
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        return fail("inline asm: non-UTF8 template");
    };
    let stripped = crate::c5::asm::strip_asm_comments(raw_text, crate::c5::asm::AsmComments::X86);
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = crate::c5::asm::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    // Rename any numeric label defined more than once in one asm instance to
    // per-definition unique names, so the code and section resolvers below see
    // single-definition labels.
    let multidef = crate::c5::asm::rewrite_multidef_local_labels(text);
    let text = multidef.as_deref().unwrap_or(text);
    // `%zN` prints operand N's size suffix into its mnemonic; the parser
    // reads the resolved mnemonic.
    let sized = match crate::c5::asm::expand_size_suffix_refs(text, &|idx| {
        asm.operands
            .get(idx as usize)
            .and_then(|op| super::asm::att_size_suffix(op.width))
    }) {
        Ok(s) => s,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = sized.as_deref().unwrap_or(text);
    // The constant value of an `i`-class operand reference, if any.
    let const_of = |idx: u8| -> Option<i64> {
        crate::c5::asm::asm_operand_const(func, *args.get(idx as usize)?)
    };
    // The operand register assignment is needed both for the code stream and,
    // ahead of it, for the GNU-as macro pass and a replacement instruction that
    // references a template operand (`popcntl %1, %0`); compute it once, first.
    let op_reg = match super::asm::assign_operand_regs(
        &asm.operands,
        asm.clobber_regs | frame.fixed_regs.gpr,
        asm.clobber_fp_regs | frame.fixed_regs.fpr,
        &|i| const_of(i as u8),
    ) {
        Ok(r) => r,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Expand any GNU-as macro directives (`.macro` / `.irp` / `.ifc` / `.set` /
    // `.if`) before section extraction, substituting each register operand to
    // its assigned AT&T name so the macro's register-name comparisons resolve.
    let gas_subst = |tok: &str| -> Option<alloc::string::String> {
        let body = tok.strip_prefix('%')?;
        let (modifier, digits) = match body.as_bytes().first() {
            Some(m) if m.is_ascii_alphabetic() => (Some(*m), &body[1..]),
            _ => (None, body),
        };
        let idx: u8 = digits.parse().ok()?;
        if matches!(modifier, Some(b'c') | Some(b'P') | Some(b'n')) {
            let v = const_of(idx)?;
            return Some(alloc::format!(
                "{}",
                if modifier == Some(b'n') { -v } else { v }
            ));
        }
        let op = asm.operands.get(idx as usize)?;
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
    };
    let gas = match crate::c5::asm::expand_asm_gas_macros(text, 4, &gas_subst) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = gas.as_deref().unwrap_or(text);
    let mut extracted = match crate::c5::asm::extract_asm_sections(text, false) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    if let Some(ex) = &extracted {
        if let Err(m) = crate::c5::asm::reject_unit_symbol_items(&ex.blocks) {
            bail_msg(&m);
            return false;
        }
        // The template's symbol directives declare names of the unit; the
        // object writer applies them, where every definition is known.
        if let Err(m) = asm_sections.push_sym_decls(&ex.sym_items) {
            bail_msg(&m);
            return false;
        }
    }
    // Encode any replacement instructions in an executable section
    // (`.altinstr_replacement,"ax"`) to bytes and relocations before layout. A
    // `%lK` goto branch resolves through the enclosing `asm goto` row to its
    // target block (index `1 + K`), the same mapping the code stream uses. The
    // row slice carries its own lifetime, so this holds no borrow of `goto_ctx`.
    let goto_row: Option<&[super::super::ir::BlockId]> = goto_ctx.as_ref().map(|c| c.row);
    let goto_block = |k: u8| -> Option<u32> { goto_row?.get(1 + k as usize).copied() };
    if let Some(ex) = extracted.as_mut()
        && let Err(m) = encode_x86_asm_section_code(
            &mut ex.blocks,
            func,
            args,
            name2entpc,
            extern_data_names,
            extern_code_names,
            &goto_block,
            &op_reg,
            &asm.operands,
        )
    {
        bail_msg(&m);
        return false;
    }
    let (code_text, section_blocks) = match &extracted {
        Some(ex) => (ex.code.as_str(), ex.blocks.as_slice()),
        None => (text, &[][..]),
    };
    let insns = match super::asm::parse_template(code_text.as_bytes()) {
        Ok(i) => i,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    if let Err(m) = super::asm::check_operand_refs(&insns, asm.operands.len()) {
        bail_msg(&m);
        return false;
    }
    // Code-stream label names, so a `.skip` expression can size its padding
    // from a named code label (a multiply-defined numeric label renamed above).
    let code_label_names = super::asm::scan_label_names(code_text);
    // Names the unit binds weak, as the section relaxation reads them: an
    // in-stream definition of one does not satisfy a branch in place, since
    // the link may bind another definition, so the field keeps a relocation
    // against the name, as GNU as keeps it.
    let weak_names = crate::c5::asm::asm_weak_only_names(section_blocks, asm_sections);
    let weak_target_name = |num: u32| -> Option<alloc::string::String> {
        let idx = num.checked_sub(super::asm::NAMED_LABEL_BASE)?;
        let name = *code_label_names.get(idx as usize)?;
        weak_names
            .contains(name)
            .then(|| alloc::string::String::from(name))
    };
    // Label numbers the code stream defines, by instruction index, so a
    // branch knows before layout whether its target lands in this stream
    // and on which side of the reference.
    let stream_defs: alloc::vec::Vec<(u32, usize)> = insns
        .iter()
        .enumerate()
        .filter_map(|(ii, insn)| insn.label_def.map(|n| (n, ii)))
        .collect();
    // Registers the asm overwrites: the operand registers plus the explicit
    // clobber list (a bound operand's register is the one the asm was asked
    // to see and affect, so it is not saved around the block). GP registers
    // save to 8-byte scratch slots; `x` (xmm) operands and FP clobbers live
    // in the independent XMM file and take 16-byte slots. `stage` carries
    // the capture / load / store-back sequences below.
    let (used, fp_used, stage) = match asm_save_masks_and_stage(asm, &op_reg, frame.fixed_regs) {
        Ok(t) => t,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let save_list: alloc::vec::Vec<u8> = (0u8..16).filter(|r| used & (1 << r) != 0).collect();
    let fp_save_list: alloc::vec::Vec<u8> = (0u8..16).filter(|r| fp_used & (1 << r) != 0).collect();
    // With nothing to run on the way out -- no register outputs to store
    // back, no saved registers to restore -- a `%lK` branch goes straight to
    // the label's block instead of a teardown trampoline, so the template
    // branch and a `.long %lK - .` section field name one address. Runtime
    // patchers that read the section entry and rewrite the branch require
    // that. TODO with exit work pending, a section field still names the
    // block, so a patched-in branch skips the store-backs and restores; the
    // aarch64 lowering rewrites such fields to the restore trampoline.
    let goto_direct = save_list.is_empty()
        && fp_save_list.is_empty()
        && !asm.operands.iter().any(|op| {
            op.is_output && !matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
        });
    // Register saves and operand captures live in the frame's asm scratch
    // region (rbp-relative), never below rsp: a setjmp-style template saves
    // rsp mid-block and a later longjmp-style one resumes it after the
    // memory below that rsp was reused by other calls. rbp survives such a
    // round trip (the resuming template restores it), so frame slots do.
    // Layout from the region base up: xmm saves, GP saves, captures.
    let fp_area = fp_save_list.len() as i32 * 16;
    let base = frame.asm_scratch_off;
    debug_assert!(
        base != 0 || (fp_area == 0 && save_list.is_empty() && asm.operands.is_empty()),
        "inline asm without a frame scratch region"
    );
    let gp_off = |k: usize| -> i32 { base + fp_area + 8 * k as i32 };
    let cap_off = |i: usize| -> i32 { base + fp_area + 8 * (save_list.len() + i) as i32 };
    for (k, &r) in fp_save_list.iter().enumerate() {
        super::encode::emit_movups_mem_xmm(code, Reg::RBP, base + k as i32 * 16, Reg(r));
    }
    for (k, &r) in save_list.iter().enumerate() {
        super::encode::emit_mov_mem_r(code, Reg::RBP, gp_off(k), Reg(r));
    }
    // Capture each operand's value (input) / address (output) into its
    // slot before any asm register is written. An allocator-visible
    // stage (r10 and r11 both held by operands or clobbers) may itself
    // be some operand value's allocated register, so register-resident
    // operands are captured in a first pass, before a spill load writes
    // the stage.
    let passes = if stage == SCRATCH_R10 || stage == SCRATCH_R11 {
        1
    } else {
        2
    };
    for pass in 0..passes {
        for (i, &a) in args.iter().enumerate() {
            let Some(place) = alloc.places.get(a as usize).copied() else {
                return fail("inline asm: operand place missing");
            };
            if passes == 2 && (pass == 1) != matches!(place, Place::Spill(_)) {
                continue;
            }
            let Some(r) = materialize_int(code, place, stage, frame) else {
                return fail("inline asm: operand not an integer place");
            };
            super::encode::emit_mov_mem_r(code, Reg::RBP, cap_off(i), r);
        }
    }
    // Load inputs into their registers; a `+` output loads its current
    // value from the destination address. A memory operand instead loads its
    // captured address into the register -- the instruction dereferences it.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            // The captured slot holds the operand's address (a 16-byte value is
            // addressed, not passed in a register); load its 128 bits into the
            // assigned xmm. An output-only `=x` is written by the asm, so skip
            // its load; a `+x` needs the current value.
            if !op.is_output || op.is_rw {
                super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
                super::encode::emit_movups_xmm_mem(code, Reg(r), stage, 0);
            }
            continue;
        }
        // Nothing moves into a bound operand: it has no storage behind it.
        if matches!(op.constraint, AsmConstraint::Bound(_)) {
            continue;
        }
        let reg = Reg(r);
        if matches!(op.constraint, AsmConstraint::Mem) || !op.is_output {
            // A memory operand loads its captured address; a plain input
            // loads its value. Both come from the captured slot.
            super::encode::emit_mov_r_mem(code, reg, Reg::RBP, cap_off(i));
        } else if op.is_rw {
            super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
            emit_asm_load_width(code, reg, stage, op.width);
        }
    }
    // Local labels: definitions record the code offset they stand at; a
    // jmp / jcc / lea referencing a label records its displacement field as
    // `(field, label, forward, field_width, instruction_index)`, patched
    // once every definition's offset is known. A relaxable branch's field
    // is one byte wide until `long_sites` holds its instruction.
    let mut label_defs: alloc::vec::Vec<(u32, usize)> = alloc::vec::Vec::new();
    let mut label_fixups: alloc::vec::Vec<(usize, u32, bool, u8, usize)> = alloc::vec::Vec::new();
    // `$LABEL` address immediates: `(imm32_field, label_number, forward)`,
    // resolved to an absolute `.text` relocation once every definition's
    // offset is known.
    let mut abs_label_fixups: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // Fields over template labels (`.byte 662f-661b`, `subl $(2f - 1b)`):
    // `(reference_site, field, width, expression)`. Only a forward reference
    // reaches here; a backward one is a value where the field is laid down,
    // so the encoding sees it and takes the narrow form where one fits.
    let mut expr_fixups: alloc::vec::Vec<(usize, usize, u8, alloc::string::String)> =
        alloc::vec::Vec::new();
    // `asm goto` label branches: `(rel32_site, branch_kind, label_index)`
    // per `%lK` reference, patched to the label's block directly when
    // `goto_direct`, else to the label's teardown trampoline (or to the
    // shared fall-through teardown when the label target is the
    // fall-through block).
    let mut goto_sites: alloc::vec::Vec<(usize, LocalBranchKind, usize)> = alloc::vec::Vec::new();
    // The constant value of an `i`-class operand reference, if any.
    let const_of = |idx: u8| -> Option<i64> {
        crate::c5::asm::asm_operand_const(func, *args.get(idx as usize)?)
    };
    let operand_form = |idx: u8| -> alloc::string::String {
        args.get(idx as usize).map_or_else(
            || alloc::string::String::from("past the operand list"),
            |&a| crate::c5::asm::asm_operand_form(func, a),
        )
    };
    // Section-label offsets, so a `.skip` in the main stream can size its
    // padding against the replacement length (`775f - 774f`, both in a
    // `.pushsection`) before the sections are materialized below.
    // Measured against the sink the sections merge into below, so this and
    // the materialization settle every branch form the same way and a
    // replacement length means the same to both.
    let section_measure = match crate::c5::asm::measure_asm_section_offsets(
        section_blocks,
        &const_of,
        false,
        asm_sections,
    ) {
        Ok(m) => m,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Whether the last byte the stream took came from an instruction; the
    // template opens right after the function's compiled code, so it does.
    // Alignment padding depends on it (see `push_x86_exec_align_fill`).
    let mut after_insn = true;
    // Start of the run of legacy prefix bytes a `lock` / `rep` / segment
    // statement deposited; the instruction they lead re-places them.
    let mut prefix_run: Option<usize> = None;
    // Encode each template instruction with its operands resolved to the
    // assigned registers, explicit registers, and immediates.
    for (ii, insn) in insns.iter().enumerate() {
        let pending_at = if matches!(insn.mnemonic, super::asm::Mnemonic::Prefix(_)) {
            prefix_run.get_or_insert(code.len());
            None
        } else {
            prefix_run.take()
        };
        // A local-label definition marks the current offset; it emits no bytes.
        if let Some(num) = insn.label_def {
            label_defs.push((num, code.len()));
            continue;
        }
        // `.align` / `.p2align` / `.balign`: pad `code` (the unit's whole
        // text stream, so its length is a section offset) to the boundary, as
        // GNU as does section-relative. A boundary above the section default
        // raises the section alignment, so the padding holds absolutely; the
        // default fill is the GNU as multi-byte NOP sequence, which an
        // explicit one-byte-NOP fill also selects. The padding leaves no
        // instruction boundary of its own.
        //
        // An operand over template labels resolves against the definitions
        // already emitted, as GNU as resolves one where the directive stands.
        if let Some(crate::c5::asm::AsmSectionItem::Align {
            spec,
            fill,
            max,
            nops,
        }) = &insn.layout
        {
            let at = code.len();
            let n = match spec.bytes(&|name| {
                crate::c5::asm::template_label_offset(name, at, &label_defs, &code_label_names)
                    .filter(|&off| off <= at as i64)
            }) {
                Ok(n) => n,
                Err(e) => return fail(&e),
            };
            *text_align = (*text_align).max(n as usize);
            let gap = crate::c5::asm::align_gap(at as i64, n as i64, *max) as usize;
            if let Err(e) =
                crate::c5::asm::push_align_fill(code, gap, *fill, true, *nops, after_insn)
            {
                return fail(&e);
            }
            continue;
        }
        // A raw-byte piece emits its literal bytes with no operand resolution.
        // Both spellings a piece can take -- a hex-byte run and a `.byte`
        // family directive -- are data as far as alignment is concerned.
        if insn.mnemonic == super::asm::Mnemonic::RawBytes {
            code.extend_from_slice(&insn.bytes);
            after_insn = false;
            continue;
        }
        // `.skip count, fill`: pad with `count` fill bytes. `count` resolves
        // against the section replacement length and the template labels
        // already emitted (the ALTERNATIVE old site is padded to the longer of
        // the two so a boot-time patch fits).
        if insn.mnemonic == super::asm::Mnemonic::Skip {
            let expr = insn.sym_exprs.first().map_or("0", |e| e.as_str());
            let Some(count) = template_expr_value(
                expr,
                code.len(),
                &label_defs,
                &code_label_names,
                &section_measure,
            ) else {
                return fail("inline asm: `.skip` count is not a constant");
            };
            if count < 0 {
                return fail("inline asm: `.skip` count is negative");
            }
            let unit: &[u8] = if insn.bytes.is_empty() {
                &[0]
            } else {
                &insn.bytes
            };
            for _ in 0..count {
                code.extend_from_slice(unit);
            }
            after_insn = false;
            continue;
        }
        // A data directive with operand references (`.long %c0`): each
        // argument must resolve to a compile-time constant, emitted
        // little-endian at the directive width.
        if let super::asm::Mnemonic::Data(w) = insn.mnemonic {
            for o in &insn.operands {
                let v = match *o {
                    AsmOpnd::Imm(v) => v,
                    AsmOpnd::RefConst { idx, .. } | AsmOpnd::Ref { idx, .. } => {
                        match const_of(idx) {
                            Some(v) => v,
                            None => return fail("inline asm: non-constant data-directive value"),
                        }
                    }
                    // A value over template labels: the field width is the
                    // directive's, so only the value waits on the layout.
                    AsmOpnd::ImmSym { expr } => {
                        let Some(text) = insn.sym_exprs.get(expr as usize) else {
                            return fail("inline asm: data-directive expression is missing");
                        };
                        match template_expr_value(
                            text,
                            code.len(),
                            &label_defs,
                            &code_label_names,
                            &section_measure,
                        ) {
                            Some(v) => v,
                            None => {
                                expr_fixups.push((code.len(), code.len(), w, text.clone()));
                                0
                            }
                        }
                    }
                    _ => return fail("inline asm: unsupported data-directive value"),
                };
                code.extend_from_slice(&(v as u64).to_le_bytes()[..w as usize]);
            }
            after_insn = false;
            continue;
        }
        // `%P` / `%c` naming a link-time address (not a compile-time
        // constant): the operand's captured value is the address. `lea`
        // materializes it into the destination; `call` / `jmp` branch
        // through it (r11 scratch).
        if let Some((k, idx)) = insn
            .operands
            .iter()
            .enumerate()
            .find_map(|(k, o)| match *o {
                AsmOpnd::RefConst { idx, .. } if const_of(idx).is_none() => Some((k, idx)),
                _ => None,
            })
        {
            let name = match insn.mnemonic {
                super::asm::Mnemonic::Table(n) => n,
                _ => "",
            };
            match name {
                "lea" | "leaq" if k == 0 && insn.operands.len() == 2 => {
                    let dst = match insn.operands[1] {
                        AsmOpnd::Reg { reg, .. } if reg < 16 => reg,
                        AsmOpnd::Ref { idx, .. } => match op_reg[idx as usize] {
                            Some(r) => r,
                            None => {
                                return fail("inline asm: `lea` destination must be a register");
                            }
                        },
                        _ => return fail("inline asm: `lea` destination must be a register"),
                    };
                    super::encode::emit_mov_r_mem(code, Reg(dst), Reg::RBP, cap_off(idx as usize));
                }
                "call" | "callq" | "jmp" | "jmpq" if insn.operands.len() == 1 => {
                    super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(idx as usize));
                    // FF /2 (call) / FF /4 (jmp) through the stage register.
                    if stage.0 >= 8 {
                        code.push(0x41);
                    }
                    code.push(0xFF);
                    code.push(if name.starts_with("call") { 0xD0 } else { 0xE0 } | (stage.0 & 7));
                }
                _ => {
                    return fail("inline asm: `%c`/`%P` address operand outside lea/call/jmp");
                }
            }
            after_insn = true;
            continue;
        }
        // The direct-branch forms below carry no REX byte, so a prefix on one
        // would be dropped rather than encoded.
        if insn.rex.is_some()
            && (matches!(
                insn.operands.first(),
                Some(AsmOpnd::Label { .. } | AsmOpnd::GotoLabel(_))
            ) || (!insn.sym_exprs.is_empty() && insn.operands.is_empty()))
        {
            return fail("inline asm: a `rex` prefix on a direct branch");
        }
        // A jmp / jcc to a local label. A target the unit binds weak is not
        // satisfied by its in-stream definition: the field keeps the rel32
        // form and relocates against the name. A target this stream defines
        // relaxes to the rel8 form unless a round below lengthened it; a
        // target outside the stream keeps rel32 for the section pass.
        if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            let super::asm::Mnemonic::Table(name) = insn.mnemonic else {
                return fail("inline asm: label operand on a non-jump");
            };
            let cc = jcc_cond(name);
            if cc.is_none() && !matches!(name, "jmp" | "jmpq") {
                return fail("inline asm: label operand on a non-jump");
            }
            if let Some(n) = weak_target_name(num) {
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                    None => super::encode::emit_jmp_rel32(code, 0),
                }
                asm_sym_fixups.push(super::AsmSymFixup {
                    instr_offset: code.len() - 4,
                    kind: crate::c5::asm::AsmRelocKind::JumpRel,
                    target: crate::c5::asm::AsmSectionTarget::Symbol(n),
                    addend: -4,
                });
                after_insn = true;
                continue;
            }
            let in_stream = stream_defs.iter().any(|&(n, di)| {
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
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                    None => super::encode::emit_jmp_rel32(code, 0),
                }
                4
            };
            label_fixups.push((code.len() - width as usize, num, forward, width, ii));
            after_insn = true;
            continue;
        }
        // A `$LABEL` operand (`pushq $1f`, `movq $1f, %rax`) is the label's
        // address as an absolute immediate. It resolves through the ordinary
        // operand path below with a placeholder that forces the 32-bit
        // immediate field; the field then carries an `R_X86_64_32S` relocation
        // against the label's text offset, recorded once the definition is
        // known. A narrower field has no room for the relocation.
        let abs_label = match insn.operands.first() {
            Some(&AsmOpnd::ImmLabel { num, forward }) => Some((num, forward)),
            _ => None,
        };
        // `lea LABEL(%rip), %reg`: materialize a template-local label's
        // address. The table emits the RIP-relative form with a zero rel32
        // (its last four bytes); the label fixup pass patches it like the
        // jump displacements.
        if let Some(&AsmOpnd::LabelAddr { num, forward }) = insn.operands.first() {
            if !matches!(insn.mnemonic, super::asm::Mnemonic::Table("lea")) {
                return fail("inline asm: a label address requires `lea`");
            }
            let [_, dst] = insn.operands.as_slice() else {
                return fail("inline asm: `lea` needs a destination register");
            };
            let (reg, width) = match *dst {
                AsmOpnd::Reg { reg, size } if reg < 16 => (reg, size.bytes()),
                AsmOpnd::Ref { idx, size } => match op_reg[idx as usize] {
                    Some(r)
                        if !matches!(
                            asm.operands[idx as usize].constraint,
                            AsmConstraint::Fp | AsmConstraint::Mem
                        ) =>
                    {
                        (
                            r,
                            size.unwrap_or(AsmRegSize::from_width(
                                asm.operands[idx as usize].width,
                            ))
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
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
            label_fixups.push((code.len() - 4, num, forward, 4, ii));
            after_insn = true;
            continue;
        }
        // A jmp / jcc to an `asm goto` label (`%lK`): emit the rel32
        // form and record the site for the trampoline patch below.
        if let Some(&AsmOpnd::GotoLabel(k)) = insn.operands.first() {
            let Some(ctx) = goto_ctx.as_ref() else {
                return fail("inline asm: `%l` label reference outside `asm goto`");
            };
            if 1 + k as usize >= ctx.row.len() {
                return fail("inline asm: `%l` label index out of range");
            }
            let super::asm::Mnemonic::Table(name) = insn.mnemonic else {
                return fail("inline asm: label operand on a non-jump");
            };
            let cc = jcc_cond(name);
            if cc.is_none() && !matches!(name, "jmp" | "jmpq") {
                return fail("inline asm: label operand on a non-jump");
            }
            let site = code.len();
            match cc {
                Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                None => super::encode::emit_jmp_rel32(code, 0),
            }
            let kind = match cc {
                Some(cc) => LocalBranchKind::Jcc(cc),
                None => LocalBranchKind::Jmp,
            };
            goto_sites.push((site, kind, k as usize));
            after_insn = true;
            continue;
        }
        // A direct `call` / `jmp` to a symbol: resolve the name to its entry
        // and emit the E8/E9 opcode plus a rel32 the fixup pass patches once
        // every function's address is final. Other instructions also carry a
        // symbol expression (a `$symbol` immediate, a symbol-displacement memory
        // operand); those resolve through their operand arms below.
        if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
            && matches!(insn.mnemonic, super::asm::Mnemonic::Table("call" | "jmp"))
        {
            let is_call =
                matches!(insn.mnemonic, super::asm::Mnemonic::Table(n) if n.starts_with("call"));
            // The name may embed operand references; substituting them first
            // is what makes `__get_user_%c0` name `__get_user_4`.
            let name = match crate::c5::asm::resolve_asm_symbol_target(
                name,
                &crate::c5::asm::X64_SYMBOL_SUBST,
                &const_of,
            ) {
                Ok(n) => n,
                Err(e) => return fail(&e),
            };
            // The code stream's branch channels name a symbol with no addend.
            // TODO carry an addend on the call site and the fixup.
            if !crate::c5::asm::is_asm_symbol_name(&name) {
                return fail(
                    "inline asm: a branch to a symbol expression is only supported in a section",
                );
            }
            // native_offset is the opcode byte; the fixup pass patches the
            // rel32 at +1 and computes the displacement from the 5-byte end.
            let native_offset = code.len();
            match name2entpc.get(name.as_str()) {
                Some(&ent_pc) => fixups.push(super::encode::Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind: super::encode::BranchKind::Call,
                }),
                // Not defined here: the callee's address is a link-time
                // decision, so the site becomes a call relocation against the
                // name, exactly as a compiler-emitted call to an extern
                // function does. The rel32 stays zero for the linker to patch.
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: name.clone(),
                    is_tail: !is_call,
                }),
            }
            code.push(if is_call { 0xE8 } else { 0xE9 });
            code.extend_from_slice(&[0u8; 4]);
            after_insn = true;
            continue;
        }
        // A `jcc` to a bare symbol resolves against a section label; only
        // file-scope section code carries that resolution.
        if !insn.sym_exprs.is_empty()
            && insn.operands.is_empty()
            && matches!(insn.mnemonic, super::asm::Mnemonic::Table(n) if jcc_cond(n).is_some())
        {
            return fail(
                "inline asm: a conditional branch to a symbol is only supported in file-scope asm",
            );
        }
        let mut concrete: alloc::vec::Vec<Concrete> = alloc::vec::Vec::new();
        // A `__seg_gs` / `__seg_fs`-qualified memory operand references its
        // object through a segment override; the prefix rides the enclosing
        // instruction (an extended-asm instruction reaches at most one such
        // operand). `None` unless a resolved memory operand carries a segment.
        let mut operand_seg: Option<u8> = None;
        // A `%a` address operand naming a link-time symbol lowers to a
        // RIP-relative reference; the relocation against the symbol is
        // recorded after the instruction encodes, at its disp32 field. Holds
        // the target and the operand's template displacement (folded into the
        // reloc addend). At most one memory operand per instruction.
        let mut riprel_reloc: Option<(AsmRipSym, i64)> = None;
        // A `$expr` immediate, and a memory displacement, whose value the
        // stream has not reached: the placeholder fixes the wide field and
        // the expression settles into it below.
        let mut imm_expr: Option<alloc::string::String> = None;
        let mut disp_expr: Option<alloc::string::String> = None;
        // An immediate encodes after the memory operand's disp32, so a
        // RIP-relative form would put the relocation on the wrong bytes.
        // Instructions carrying one keep the register-indirect addressing.
        let has_imm_operand = insn.operands.iter().any(|o| match *o {
            AsmOpnd::Imm(_) | AsmOpnd::RefConst { .. } => true,
            AsmOpnd::Ref { idx, .. } => op_reg.get(idx as usize).copied().flatten().is_none(),
            _ => false,
        });
        for o in &insn.operands {
            let c = match *o {
                AsmOpnd::Imm(val) => Concrete::Imm(val),
                AsmOpnd::HighReg(n) => Concrete::HighReg(n),
                AsmOpnd::HighRef(idx) => {
                    match super::asm::resolve_high_ref(idx, &asm.operands, &op_reg) {
                        Ok(c) => c,
                        Err(m) => return fail(&m),
                    }
                }
                // `%cN` / `%PN` with a compile-time constant (the address
                // case was handled above): a bare immediate.
                AsmOpnd::RefConst { idx, .. } => match const_of(idx) {
                    Some(v) => Concrete::Imm(v),
                    None => {
                        return fail(&alloc::format!(
                            "inline asm: non-constant `%c`/`%P` operand `%{idx}`: the operand is {}",
                            operand_form(idx)
                        ));
                    }
                },
                // A bare `%cN` / `%PN` memory reference: a constant addresses
                // absolutely (the percpu form under a `%%gs:` / `%%fs:`
                // override), a link-time address RIP-relative, as for `%a`.
                // TODO: gcc spells a `%c` symbol operand as an absolute
                // reference, which a non-PIC code model needs.
                AsmOpnd::AbsMemRef { idx, .. } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    match const_of(idx) {
                        Some(v) => match i32::try_from(v) {
                            Ok(disp) => Concrete::AbsMem { disp, size },
                            Err(_) => {
                                return fail("inline asm: absolute displacement out of range");
                            }
                        },
                        None => match args.get(idx as usize).and_then(|a| {
                            asm_riprel_target(
                                func,
                                name2entpc,
                                extern_data_names,
                                extern_code_names,
                                *a,
                            )
                        }) {
                            Some(sym) => {
                                riprel_reloc = Some((sym, 0));
                                Concrete::RipRel { disp: 0, size }
                            }
                            None => {
                                return fail(&alloc::format!(
                                    "inline asm: `%c`/`%P` memory operand `%{idx}` is not a constant \
                                     or address: the operand is {}",
                                    operand_form(idx)
                                ));
                            }
                        },
                    }
                }
                AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
                AsmOpnd::Ref { idx, size } => {
                    let width = asm.operands[idx as usize].width;
                    match op_reg[idx as usize] {
                        Some(r)
                            if matches!(
                                asm.operands[idx as usize].constraint,
                                AsmConstraint::Mem
                            ) =>
                        {
                            // The C operand type is only the default width.
                            let size = asm_mem_size(size, insn, &asm.operands, &op_reg)
                                .unwrap_or(AsmRegSize::from_width(width));
                            operand_seg = match asm.operands[idx as usize].seg {
                                AsmSeg::Gs => Some(0x65),
                                AsmSeg::Fs => Some(0x64),
                                AsmSeg::None => operand_seg,
                            };
                            // A file-scope object addresses RIP-relative, as
                            // gcc does; the captured-address register serves
                            // a local, a computed address, and the segment
                            // forms, whose base is not a link-time address.
                            let sym = if has_imm_operand
                                || !matches!(asm.operands[idx as usize].seg, AsmSeg::None)
                            {
                                None
                            } else {
                                args.get(idx as usize).and_then(|a| {
                                    asm_riprel_target(
                                        func,
                                        name2entpc,
                                        extern_data_names,
                                        extern_code_names,
                                        *a,
                                    )
                                })
                            };
                            match sym {
                                Some(sym) => {
                                    riprel_reloc = Some((sym, 0));
                                    Concrete::RipRel { disp: 0, size }
                                }
                                None => Concrete::Mem {
                                    base: r,
                                    index: None,
                                    scale: 1,
                                    disp: 0,
                                    size,
                                },
                            }
                        }
                        Some(r)
                            if matches!(
                                asm.operands[idx as usize].constraint,
                                AsmConstraint::Fp
                            ) =>
                        {
                            Concrete::Reg {
                                reg: super::asm::XMM_BASE + r,
                                size: size.unwrap_or(AsmRegSize::from_width(width)),
                            }
                        }
                        Some(r) => Concrete::Reg {
                            reg: r,
                            size: size.unwrap_or(AsmRegSize::from_width(width)),
                        },
                        // A `%N` naming an operand with no register: its
                        // constant value.
                        None => match const_of(idx) {
                            Some(v) => Concrete::Imm(v),
                            None => return fail("inline asm: non-constant immediate operand"),
                        },
                    }
                }
                // An explicit `disp(%reg)` memory reference; 64-bit default.
                AsmOpnd::Mem {
                    base,
                    index,
                    scale,
                    disp,
                } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    let resolve = |b: super::asm::AsmMemBase| -> Option<u8> {
                        match b {
                            super::asm::AsmMemBase::Reg { num, .. } => Some(num),
                            super::asm::AsmMemBase::Ref(idx) => {
                                op_reg.get(idx as usize).copied().flatten().filter(|_| {
                                    !matches!(
                                        asm.operands[idx as usize].constraint,
                                        AsmConstraint::Fp
                                    )
                                })
                            }
                        }
                    };
                    // A `%a` / `disp(%N)` operand whose `%N` is an `i`-class
                    // symbolic address (`&global`) resolves to no register:
                    // emit a RIP-relative reference the linker resolves against
                    // the symbol, as gcc does for `%a` (`sym(%rip)`). A scaled
                    // index cannot ride the RIP-relative form.
                    let sym = match base {
                        super::asm::AsmMemBase::Ref(bi) if index.is_none() => {
                            args.get(bi as usize).and_then(|a| {
                                asm_riprel_target(
                                    func,
                                    name2entpc,
                                    extern_data_names,
                                    extern_code_names,
                                    *a,
                                )
                            })
                        }
                        _ => None,
                    };
                    let base = match (resolve(base), sym) {
                        (Some(b), _) => b,
                        (None, Some(sym)) => {
                            riprel_reloc = Some((sym, disp as i64));
                            concrete.push(Concrete::RipRel {
                                disp: 0,
                                size: size.unwrap_or(AsmRegSize::Quad),
                            });
                            continue;
                        }
                        (None, None) => {
                            let super::asm::AsmMemBase::Ref(bi) = base else {
                                return fail("inline asm: memory base must be a register");
                            };
                            let abs = const_of(bi)
                                .filter(|_| index.is_none())
                                .and_then(|v| i32::try_from(v.checked_add(disp as i64)?).ok());
                            let Some(disp) = abs else {
                                return fail(&alloc::format!(
                                    "inline asm: memory base `%{bi}` is not a register, a \
                                     constant or a link-time address: the operand is {}",
                                    operand_form(bi)
                                ));
                            };
                            concrete.push(Concrete::AbsMem {
                                disp,
                                size: size.unwrap_or(AsmRegSize::Quad),
                            });
                            continue;
                        }
                    };
                    let index = match index {
                        Some(i) => match resolve(i) {
                            Some(r) => Some(r),
                            None => {
                                return fail("inline asm: memory index must be a register operand");
                            }
                        },
                        None => None,
                    };
                    Concrete::Mem {
                        base,
                        index,
                        scale,
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // An absolute `seg:disp` reference; the segment prefix rides
                // the instruction. Access width as for `disp(%reg)`. A symbol
                // address needs a relocation the function-body stream does not
                // carry, so only the literal form assembles here.
                AsmOpnd::AbsMem { sym: Some(_), .. } => {
                    return fail(
                        "inline asm: an absolute symbol address is only supported in \
                         file-scope asm",
                    );
                }
                AsmOpnd::AbsMem { disp, sym: None } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    Concrete::AbsMem {
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // A literal-displacement `disp(%rip)`: encode the RIP-relative
                // form (mod=00 rm=101 + disp32) with no relocation; the address
                // is `rip + disp`. Access width as for `disp(%reg)`.
                AsmOpnd::RipRel { disp } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    Concrete::RipRel {
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // `%cN(%%rip)` / `%PN(%%rip)`: a compile-time constant becomes
                // the disp32 literal; a link-time address takes a RIP-relative
                // relocation, as for `%a`.
                AsmOpnd::RipRelRef { idx, .. } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    match const_of(idx) {
                        Some(v) => match i32::try_from(v) {
                            Ok(disp) => Concrete::RipRel { disp, size },
                            Err(_) => {
                                return fail("inline asm: RIP-relative displacement out of range");
                            }
                        },
                        None => match args.get(idx as usize).and_then(|a| {
                            asm_riprel_target(
                                func,
                                name2entpc,
                                extern_data_names,
                                extern_code_names,
                                *a,
                            )
                        }) {
                            Some(sym) => {
                                riprel_reloc = Some((sym, 0));
                                Concrete::RipRel { disp: 0, size }
                            }
                            None => {
                                return fail(&alloc::format!(
                                    "inline asm: `%c`/`%P` RIP-relative operand `%{idx}` is not a \
                                     constant or address: the operand is {}",
                                    operand_form(idx)
                                ));
                            }
                        },
                    }
                }
                // `disp(,%index,scale)`: a no-base scaled-index reference. A
                // symbol displacement needs an absolute relocation the
                // function-body stream does not carry (as for `$symbol`); it is
                // assembled only in file-scope asm.
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
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    let index = match index {
                        super::asm::AsmMemBase::Reg { num, .. } => num,
                        super::asm::AsmMemBase::Ref(i) => {
                            match op_reg.get(i as usize).copied().flatten().filter(|_| {
                                !matches!(asm.operands[i as usize].constraint, AsmConstraint::Fp)
                            }) {
                                Some(r) => r,
                                None => {
                                    return fail(
                                        "inline asm: memory index must be a register operand",
                                    );
                                }
                            }
                        }
                    };
                    Concrete::IndexMem {
                        index,
                        scale,
                        disp,
                        size,
                    }
                }
                // `disp+sym(%base)`: a symbol displacement, as for the
                // no-base form above.
                // A displacement expression over template labels is a value
                // the stream settles; one naming a symbol needs a relocation
                // only file-scope section code carries.
                AsmOpnd::SymMem {
                    base,
                    index,
                    scale,
                    expr,
                } => {
                    let sym_only = "inline asm: a symbol-displacement memory operand is only \
                                    supported in file-scope asm";
                    let Some(text) = insn.sym_exprs.get(expr as usize) else {
                        return fail(sym_only);
                    };
                    if !crate::c5::asm::is_template_label_expr(text, &code_label_names) {
                        return fail(sym_only);
                    }
                    let disp = match template_expr_value(
                        text,
                        code.len(),
                        &label_defs,
                        &code_label_names,
                        &section_measure,
                    ) {
                        Some(v) => match i32::try_from(v) {
                            Ok(d) => d,
                            Err(_) => return fail("inline asm: displacement out of range"),
                        },
                        None => {
                            disp_expr = Some(text.clone());
                            RIPREL_PROBE_DISP
                        }
                    };
                    let reg_of = |b: super::asm::AsmMemBase| -> Option<u8> {
                        match b {
                            super::asm::AsmMemBase::Reg { num, .. } => Some(num),
                            super::asm::AsmMemBase::Ref(i) => {
                                op_reg.get(i as usize).copied().flatten()
                            }
                        }
                    };
                    let (Some(base), index) = (reg_of(base), index.map(reg_of)) else {
                        return fail("inline asm: memory base is not a register");
                    };
                    if index == Some(None) {
                        return fail("inline asm: memory index is not a register");
                    }
                    Concrete::Mem {
                        base,
                        index: index.flatten(),
                        scale,
                        disp,
                        size: asm_mem_size(None, insn, &asm.operands, &op_reg)
                            .unwrap_or(AsmRegSize::Quad),
                    }
                }
                // `sym(%%rip)`: a PC-relative reference to a named symbol,
                // resolved by name through the same relocation channel as a
                // `%a` operand.
                AsmOpnd::SymRipRel { expr } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    // The in-function channel names a symbol and an offset,
                    // so a displacement over a label difference has nowhere
                    // to resolve and is refused rather than mis-encoded.
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
                    riprel_reloc = Some((AsmRipSym::Extern { name, offset: 0 }, addend));
                    Concrete::RipRel { disp: 0, size }
                }
                // A `$expr` immediate, under the same rule as a displacement.
                AsmOpnd::ImmSym { expr } => {
                    let Some(text) = insn.sym_exprs.get(expr as usize) else {
                        return fail("inline asm: symbol immediate expression is missing");
                    };
                    match template_expr_value(
                        text,
                        code.len(),
                        &label_defs,
                        &code_label_names,
                        &section_measure,
                    ) {
                        Some(v) => Concrete::Imm(v),
                        None if crate::c5::asm::is_template_label_expr(text, &code_label_names) => {
                            imm_expr = Some(text.clone());
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
                // A label address immediate encodes as a placeholder wide
                // enough to force the imm32 field; the relocation replaces it.
                AsmOpnd::ImmLabel { .. } => Concrete::Imm(ABS_LABEL_PLACEHOLDER),
                // Handled above (jmp / jcc / lea referencing a local label); a
                // label reaching operand resolution rode an unsupported form.
                AsmOpnd::Label { .. } | AsmOpnd::LabelAddr { .. } | AsmOpnd::GotoLabel(_) => {
                    return fail("inline asm: misplaced label reference");
                }
            };
            concrete.push(c);
        }
        if abs_label.is_some()
            && concrete
                .iter()
                .filter(|c| matches!(c, Concrete::Imm(_)))
                .count()
                > 1
        {
            return fail("inline asm: a label address immediate with a second immediate");
        }
        // A segment override comes from a template `%gs:` / `%fs:` or from a
        // `__seg_gs` / `__seg_fs` memory operand; the two never conflict on one
        // instruction. It joins the prefix statements ahead of the instruction.
        let pending = match pending_at {
            Some(at) => code.split_off(at),
            None => alloc::vec::Vec::new(),
        };
        let insn_at = code.len();
        let addr = super::asm::addr_size(insn, super::table::Mode::Bits64);
        let mut body = alloc::vec::Vec::new();
        if let Err(m) = super::asm::encode(&mut body, addr, insn.mnemonic, insn.suffix, &concrete) {
            bail_msg(&m);
            return false;
        }
        let sizes = push_legacy_prefixes(code, &body, insn.seg.or(operand_seg), &pending);
        code.extend_from_slice(&body[sizes..]);
        if let Some(rex) = insn.rex
            && let Err(m) = super::asm::splice_rex(code, insn_at, rex)
        {
            bail_msg(&m);
            return false;
        }
        // The label address immediate occupies the last four bytes; the
        // placeholder confirms the chosen form put it there.
        if let Some((num, forward)) = abs_label {
            if code.len() < 4 || code[code.len() - 4..] != ABS_LABEL_PLACEHOLDER_BYTES {
                return fail("inline asm: a label address immediate requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            abs_label_fixups.push((at, num, forward));
        }
        // The displacement is the last four bytes; an immediate would follow
        // it, so a form carrying one is refused rather than patched wrong.
        if let Some(text) = disp_expr.take() {
            if concrete.iter().any(|c| matches!(c, Concrete::Imm(_))) {
                return fail("inline asm: an expression displacement with an immediate");
            }
            if code.len() < 4 || code[code.len() - 4..] != RIPREL_PROBE_DISP.to_le_bytes() {
                return fail("inline asm: an expression displacement requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            expr_fixups.push((insn_at, at, 4, text));
        }
        // The same placement rule for a `$expr` immediate.
        if let Some(text) = imm_expr.take() {
            if code.len() < 4 || code[code.len() - 4..] != ABS_LABEL_PLACEHOLDER_BYTES {
                return fail("inline asm: an expression immediate requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            expr_fixups.push((insn_at, at, 4, text));
        }
        // Record the RIP-relative relocation against the operand's symbol.
        // Both channels place the reloc at `instr_offset + 3`, so anchor
        // three bytes before the disp32 field. gcc's addend is the operand's
        // constant offset less the field's 4-byte PC-relative end skew and
        // any immediate trailing the field (`testb $imm, sym(%rip)`).
        if let Some((sym, disp)) = riprel_reloc.take() {
            let Some((field, trailing)) = riprel_field(&body, &concrete, addr, insn) else {
                return fail("inline asm: RIP-relative displacement field not found");
            };
            let instr_offset = code.len() - (body.len() - field) - 3;
            let trailing = trailing as i64;
            match sym {
                AsmRipSym::Extern { name, offset } => {
                    user_extern_data_refs.push(super::UserExternDataRef {
                        instr_offset,
                        symbol_name: name,
                        direct_pcrel: Some(offset + disp - 4 - trailing),
                    });
                }
                AsmRipSym::Local { data_offset } => {
                    data_fixups.push(DataFixup {
                        instr_offset,
                        data_offset: (data_offset + disp - trailing) as u64,
                        part: AddrPart::Whole,
                    });
                }
                AsmRipSym::Text { ent_pc } if disp == 0 && trailing == 0 => {
                    pending_func_fixups.push((instr_offset, ent_pc));
                }
                AsmRipSym::Text { .. } => {
                    return fail(
                        "inline asm: a displacement on an in-unit function address is not supported",
                    );
                }
            }
        }
        after_insn = true;
    }
    // Settle each deferred expression field: the layout is final, so a
    // forward reference now has its definition.
    for (site, at, width, text) in &expr_fixups {
        let Some(v) = template_expr_value(
            text,
            *site,
            &label_defs,
            &code_label_names,
            &section_measure,
        ) else {
            bail_msg(&alloc::format!(
                "inline asm: expression `{text}` is not a constant"
            ));
            return false;
        };
        let w = *width as usize;
        code[*at..*at + w].copy_from_slice(&(v as u64).to_le_bytes()[..w]);
    }
    // Patch each label reference now that every definition's offset is
    // known. A forward `Nf` takes the nearest matching definition after the
    // reference; a backward `Nb`, the nearest at or before it (GNU as
    // local-label rule). A named label has exactly one definition, so the
    // direction is ignored. The displacement is measured from the end of
    // its field. A reference with no main-stream definition may name a
    // label placed in one of the template's pushed sections; defer it to
    // the section pass.
    let mut pending_xsec: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // The same, for `$LABEL` address immediates, whose field is absolute.
    let mut pending_abs_xsec: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // The main-stream definition a label reference at `at` binds to: a named
    // label has one definition; a forward `Nf` the nearest after `at`, a
    // backward `Nb` the nearest at or before it.
    let resolve_label = |at: usize, num: u32, forward: bool| -> Option<usize> {
        if num >= super::asm::NAMED_LABEL_BASE {
            label_defs.iter().find(|&&(n, _)| n == num).map(|&(_, o)| o)
        } else if forward {
            label_defs
                .iter()
                .filter(|&&(n, off)| n == num && off > at)
                .map(|&(_, off)| off)
                .min()
        } else {
            label_defs
                .iter()
                .filter(|&&(n, off)| n == num && off <= at)
                .map(|&(_, off)| off)
                .max()
        }
    };
    // Lengthen every short branch this layout leaves outside the byte's
    // reach and hand the grown set back for the next round.
    let known_long = long_sites.len();
    for &(at, num, forward, width, ii) in &label_fixups {
        if width == 1
            && let Some(target) = resolve_label(at, num, forward)
            && !(-128..=127).contains(&(target as i64 - (at as i64 + 1)))
        {
            long_sites.insert(ii);
        }
    }
    if long_sites.len() != known_long {
        return true;
    }
    for &(at, num, forward, width, _) in &label_fixups {
        match resolve_label(at, num, forward) {
            Some(target) => {
                let w = width as usize;
                let rel = target as i64 - (at + w) as i64;
                code[at..at + w].copy_from_slice(&rel.to_le_bytes()[..w]);
            }
            // Only a target this stream defines takes the short form.
            None if width == 4 => pending_xsec.push((at, num, forward)),
            None => return fail("inline asm: undefined local label"),
        }
    }
    // A `$LABEL` immediate binds to the same main-stream definition, but the
    // field carries an absolute `.text` relocation rather than an in-stream
    // displacement. A label the main stream does not define is deferred to the
    // pushed sections, as a branch displacement is.
    for &(at, num, forward) in &abs_label_fixups {
        match resolve_label(at, num, forward) {
            Some(target) => asm_text_abs_refs.push(super::AsmTextAbsRef {
                field_offset: at,
                target_offset: target,
            }),
            None => pending_abs_xsec.push((at, num, forward)),
        }
    }
    // A named label defined in the main stream is a definition of the unit,
    // as it is for GNU as: record it so the writers emit a local `.text`
    // symbol and bind a same-name C reference to it. `.L`-prefixed names are
    // assembler-local (and the renames this emit generates for multiply
    // defined numeric labels carry that prefix), so no C reference spells one.
    for &(num, off) in &label_defs {
        if num < super::asm::NAMED_LABEL_BASE {
            continue;
        }
        let Some(&name) = code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize)
        else {
            continue;
        };
        if crate::c5::asm::is_local_label(name) {
            continue;
        }
        // One definition per name across the unit, as in GNU as.
        if asm_text_labels.iter().any(|l| l.name == name) {
            bail_msg(&alloc::format!(
                "inline asm: symbol `{name}` is already defined"
            ));
            return false;
        }
        asm_text_labels.push(super::AsmTextLabel {
            name: alloc::string::String::from(name),
            text_offset: off,
        });
    }
    // Materialize the `.pushsection` blocks now that every label's text
    // offset is known. A reference that names a template label resolves
    // to its offset; any other name is a symbol relocation.
    if !section_blocks.is_empty() {
        let names = super::asm::scan_label_names(code_text);
        use crate::c5::asm::LabelLoc;
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
            let mut defs = label_defs.iter().filter(|&&(n, _)| n == num);
            if forward {
                defs.map(|&(_, off)| off).min()
            } else {
                defs.next_back().map(|&(_, off)| off)
            }
            .map(LabelLoc::Text)
        };
        // An `i`-class operand naming a link-time data address (`.long %c0 - .`
        // where `%c0` is `&sym` or a string literal) relocates against the
        // data image, resolved like the operand's own `ImmData` lowering.
        let operand_sym = |idx: u8| -> Option<(crate::c5::asm::AsmSectionTarget, i64)> {
            crate::c5::asm::asm_operand_data_target(func, *args.get(idx as usize)?, &|vid| {
                extern_data_names.get(&vid).cloned()
            })
        };
        let resolver = crate::c5::asm::AsmOperandResolver {
            const_of: &|idx| const_of(idx),
            symbol_of: &operand_sym,
            form: &operand_form,
        };
        // An `asm goto` label operand (`.long %l0 - .`): the goto row's block
        // index. Its text offset is not final here; the reloc carries the
        // block and is rewritten after layout (see resolve_asm_goto_relocs).
        let goto_block = |idx: u8| -> Option<u32> {
            let ctx = goto_ctx.as_ref()?;
            ctx.row.get(1 + idx as usize).copied()
        };
        let defined = match crate::c5::asm::materialize_asm_sections(
            section_blocks,
            &resolver,
            &label_off,
            &goto_block,
            false,
            asm_sections,
        ) {
            Ok(d) => d,
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        };
        // Bind each deferred main-stream reference to its section definition.
        // The pushed sections follow the main stream textually, so only a
        // forward reference reaches one; the two land in different object
        // sections, so the reference becomes a PC-relative relocation against
        // the target section's symbol rather than an in-stream displacement.
        for (at, num, forward) in pending_xsec.drain(..) {
            let name = if num >= super::asm::NAMED_LABEL_BASE {
                match code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize) {
                    Some(n) => alloc::string::String::from(*n),
                    None => return fail("inline asm: undefined local label"),
                }
            } else {
                alloc::format!("{num}")
            };
            let hit = if forward {
                defined.iter().find(|d| d.name == name)
            } else {
                None
            };
            match hit {
                Some(d) => asm_section_text_refs.push(super::AsmSectionTextRef {
                    instr_offset: at,
                    section_index: d.section_index,
                    section_offset: d.offset,
                    addend: -4,
                    absolute: false,
                    kind: crate::c5::asm::AsmRelocKind::Data,
                }),
                None => return fail("inline asm: undefined local label"),
            }
        }
        // The absolute form of the same binding: no end skew, and the field
        // takes an absolute relocation against the section symbol.
        for (at, num, forward) in pending_abs_xsec.drain(..) {
            let name = if num >= super::asm::NAMED_LABEL_BASE {
                match code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize) {
                    Some(n) => alloc::string::String::from(*n),
                    None => return fail("inline asm: undefined local label"),
                }
            } else {
                alloc::format!("{num}")
            };
            match forward
                .then(|| defined.iter().find(|d| d.name == name))
                .flatten()
            {
                Some(d) => asm_section_text_refs.push(super::AsmSectionTextRef {
                    instr_offset: at,
                    section_index: d.section_index,
                    section_offset: d.offset,
                    addend: 0,
                    absolute: true,
                    kind: crate::c5::asm::AsmRelocKind::Data,
                }),
                None => {
                    return fail("inline asm: `$LABEL` address immediate names no local label");
                }
            }
        }
    }
    // A deferred reference with no section to resolve against is undefined.
    if !pending_xsec.is_empty() {
        return fail("inline asm: undefined local label");
    }
    if !pending_abs_xsec.is_empty() {
        return fail("inline asm: `$LABEL` address immediate names no local label");
    }

    // Flag outputs: the template's condition flags are still live here (the
    // label fixups above patch bytes and emit none), so materialize each
    // `=@cc<cond>` with `set<cond>` into its assigned register's low byte and
    // zero-extend it. This must precede the store-back loop, whose `mov`s
    // would otherwise be the first instructions after the template.
    for (i, op) in asm.operands.iter().enumerate() {
        let AsmConstraint::Flags(nibble) = op.constraint else {
            continue;
        };
        let Some(cc) = super::encode::Cc::from_nibble(nibble) else {
            return fail("inline asm: bad flag-output condition");
        };
        let Some(r) = op_reg[i] else {
            return fail("inline asm: flag output without a register");
        };
        super::encode::emit_setcc_r8(code, cc, Reg(r));
        super::encode::emit_movzx_r_r8(code, Reg(r), Reg(r));
    }
    // Store the register outputs back through their captured addresses. A
    // memory operand needs no store-back: the instruction wrote memory.
    // For `asm goto` the outputs are stored on every exit path (GCC 11
    // output semantics), so the sequence repeats on each trampoline.
    let emit_outputs = |code: &mut Vec<u8>| {
        for (i, op) in asm.operands.iter().enumerate() {
            if !op.is_output
                || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
            {
                continue;
            }
            let Some(r) = op_reg[i] else { continue };
            super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
            if matches!(op.constraint, AsmConstraint::Fp) {
                super::encode::emit_movups_mem_xmm(code, stage, 0, Reg(r));
            } else {
                emit_asm_store_width(code, stage, Reg(r), op.width);
            }
        }
    };
    // Restore the saved registers from their frame slots.
    let emit_restore = |code: &mut Vec<u8>| {
        for (k, &r) in save_list.iter().enumerate() {
            super::encode::emit_mov_r_mem(code, Reg(r), Reg::RBP, gp_off(k));
        }
        for (k, &r) in fp_save_list.iter().enumerate() {
            super::encode::emit_movups_xmm_mem(code, Reg(r), Reg::RBP, base + k as i32 * 16);
        }
    };
    let exit_start = code.len();
    emit_outputs(code);
    emit_restore(code);
    // `asm goto`: each `%lK` branch leaves mid-template, before the
    // store-backs and restore just emitted on the fall-through path, so
    // it lands on a trampoline that repeats them and jumps to the
    // label's block through the enclosing function's branch fixups. A
    // label whose target is the fall-through block reuses the
    // fall-through exit sequence instead. With an empty exit sequence
    // (`goto_direct`) the template branch itself rides the enclosing
    // function's branch fixups, pinned to its already-emitted long form.
    if let Some(ctx) = goto_ctx.as_mut()
        && goto_direct
    {
        for &(site, kind, k) in &goto_sites {
            ctx.branch_fixups.push(BranchFixup {
                site: site + kind.opcode_len(),
                target: ctx.row[1 + k],
                kind,
                short: false,
                pinned_long: true,
            });
        }
    } else if let Some(ctx) = goto_ctx.as_mut() {
        let mut tramp_at: alloc::vec::Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
        if goto_sites
            .iter()
            .any(|&(_, _, k)| ctx.row[1 + k] != ctx.row[0])
        {
            let skip_site = code.len() + 1;
            super::encode::emit_jmp_rel32(code, 0);
            for &(_, _, k) in &goto_sites {
                if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                    continue;
                }
                tramp_at[k] = Some(code.len());
                emit_outputs(code);
                emit_restore(code);
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
        for &(site, kind, k) in &goto_sites {
            let target = tramp_at[k].unwrap_or(exit_start);
            let at = site + kind.opcode_len();
            let rel = target as i64 - (at + 4) as i64;
            code[at..at + 4].copy_from_slice(&(rel as i32).to_le_bytes());
        }
    }
    true
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
