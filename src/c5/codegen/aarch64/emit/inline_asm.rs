use super::*;

/// Block-target branch context for an `asm goto` statement: the
/// `jump_tables` row (`[fall_through, label targets...]`) and the
/// enclosing function's branch-fixup lists. A template `%lK` branch lands
/// on a local restore trampoline whose final `b` is patched to the label's
/// block like any other block-local branch; with no operand frame to
/// release it is recorded in `direct_goto` and patched to the block
/// itself, so it and a `.long %lK - .` section field name one address.
pub(super) struct AsmGotoCtxA64<'a> {
    pub(super) row: &'a [super::super::ir::BlockId],
    pub(super) branch_fixups: &'a mut Vec<BranchFixup>,
    pub(super) direct_goto: &'a mut Vec<AsmGotoDirectBranch>,
}

/// A template `%lK` branch resolved straight to its label's block: the
/// branch's byte offset in the function's code, its form, and the block.
/// Encoded once the block layout is final.
pub(super) struct AsmGotoDirectBranch {
    pub(super) site: usize,
    pub(super) kind: LabelBranch,
    pub(super) target: u32,
}

/// A deferred ALTERNATIVE replacement region (`.subsection 1`): the encoded
/// replacement instructions, appended to `.text` after the function body so
/// the main sequence does not fall through into it. `labels` records each
/// local label's byte offset within `bytes` so the `.altinstructions`
/// entry's `.word 663f - .` resolves to the replacement's final text
/// offset once the region is placed.
pub(super) struct DeferredAsmRegion {
    pub(super) bytes: alloc::vec::Vec<u8>,
    pub(super) labels: alloc::vec::Vec<(u32, usize)>,
    pub(super) goto_branches: alloc::vec::Vec<DeferredGotoBranch>,
    pub(super) sym_branches: alloc::vec::Vec<DeferredSymBranch>,
    /// Region-relative `(offset, length)` of each data run, recorded so the
    /// mapping symbols cover them once the region's text base is known.
    pub(super) data_ranges: alloc::vec::Vec<(usize, usize)>,
}

/// A replacement `b` / `bl` to a symbol. The rel26 is a link-time or
/// whole-text decision, so the region carries a zero placeholder word and the
/// site is registered as a call fixup once the region's text base is known.
pub(super) struct DeferredSymBranch {
    pub(super) region_off: usize,
    pub(super) name: alloc::string::String,
    pub(super) is_call: bool,
}

/// A replacement `%l[...]` asm-goto branch that leaves the out-of-line region
/// for a target in the enclosing function. `region_off` is the branch's byte
/// offset within the region; the displacement is resolved once the region base
/// and block layout are final.
pub(super) struct DeferredGotoBranch {
    pub(super) region_off: usize,
    pub(super) kind: LabelBranch,
    pub(super) target: DeferredGotoTarget,
}

/// Where a `DeferredGotoBranch` lands.
pub(super) enum DeferredGotoTarget {
    /// A fixed code offset in the function body -- the asm's operand-frame
    /// teardown trampoline (or fall-through exit) -- reached before the label.
    Code(usize),
    /// A block, branched to directly when the asm needs no teardown.
    Block(u32),
}

/// A template branch to a local (`Nf` / `Nb`) or `asm goto` (`%lK`)
/// label, recorded as a placeholder word and patched once the target
/// offset is known.
#[derive(Clone, Copy)]
pub(super) enum LabelBranch {
    B,
    Bl,
    BCond(u8),
    Cb { nz: bool, rt: u8, is64: bool },
    Tb { nz: bool, rt: u8, bit: u8 },
    Adr { rd: u8 },
}

/// Encode a resolved label branch; `delta` is the byte displacement
/// from the branch instruction to its target. `Adr` is byte-granular
/// and handled by the caller.
pub(super) fn label_branch_word(
    kind: &LabelBranch,
    delta: i64,
) -> Result<u32, alloc::string::String> {
    use alloc::string::String;
    if delta % 4 != 0 {
        return Err(String::from(
            "aarch64 inline asm: label target is not word-aligned",
        ));
    }
    let words = (delta / 4) as i32;
    let fits = |bits: u32| {
        let lim = 1i32 << (bits - 1);
        (-lim..lim).contains(&words)
    };
    Ok(match *kind {
        LabelBranch::B => {
            if !fits(26) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            super::encode::enc_b(words)
        }
        LabelBranch::Bl => {
            if !fits(26) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            super::encode::enc_bl(words)
        }
        // B.cond: 0101_0100 | imm19 << 5 | cond.
        LabelBranch::BCond(c) => {
            if !fits(19) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            0x5400_0000 | (((words as u32) & 0x7_FFFF) << 5) | c as u32
        }
        // CBZ/CBNZ: sf | 0011_010z | imm19 << 5 | Rt.
        LabelBranch::Cb { nz, rt, is64 } => {
            if !fits(19) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            (if is64 { 1u32 << 31 } else { 0 })
                | (if nz { 0x3500_0000 } else { 0x3400_0000 })
                | (((words as u32) & 0x7_FFFF) << 5)
                | rt as u32
        }
        // TBZ/TBNZ: bit<5> | 0011_011z | bit<4:0> << 19 | imm14 << 5 | Rt.
        LabelBranch::Tb { nz, rt, bit } => {
            if !fits(14) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            ((bit as u32 >> 5) << 31)
                | (if nz { 0x3700_0000 } else { 0x3600_0000 })
                | ((bit as u32 & 31) << 19)
                | (((words as u32) & 0x3FFF) << 5)
                | rt as u32
        }
        LabelBranch::Adr { .. } => {
            return Err(String::from(
                "aarch64 inline asm: adr is not a branch encoding",
            ));
        }
    })
}

/// Resolve a label-branch instruction -- `b` / `b.cond` / `cbz` / `cbnz` /
/// `tbz` / `tbnz` / `adr` with a local label, `.`, or `%l[...]` target -- to
/// its `LabelBranch` kind. Register and bit-number operands are read through
/// `conv`, the same converter the table encoder uses, so the main stream and
/// the out-of-line replacement region admit the same set of forms.
fn build_label_branch(
    insn: &super::asm::AsmInsnA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> Result<LabelBranch, alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    use alloc::string::String;
    Ok(match insn.mnemonic.as_str() {
        "b" if insn.operands.len() == 1 => LabelBranch::B,
        "bl" if insn.operands.len() == 1 => LabelBranch::Bl,
        "cbz" | "cbnz" if insn.operands.len() == 2 => match conv(&insn.operands[0])? {
            Opnd::Reg { num: rt, is64, .. } => LabelBranch::Cb {
                nz: insn.mnemonic == "cbnz",
                rt,
                is64,
            },
            _ => {
                return Err(String::from(
                    "aarch64 inline asm: cbz/cbnz operand must be a register",
                ));
            }
        },
        "tbz" | "tbnz" if insn.operands.len() == 3 => {
            let (rt, is64) = match conv(&insn.operands[0])? {
                Opnd::Reg { num, is64, .. } => (num, is64),
                _ => {
                    return Err(String::from(
                        "aarch64 inline asm: tbz/tbnz operand must be a register",
                    ));
                }
            };
            let AsmOpndA64::Imm(bit) = insn.operands[1] else {
                return Err(String::from(
                    "aarch64 inline asm: tbz/tbnz bit number must be an immediate",
                ));
            };
            if bit < 0 || bit >= if is64 { 64 } else { 32 } {
                return Err(String::from(
                    "aarch64 inline asm: tbz/tbnz bit number out of range",
                ));
            }
            LabelBranch::Tb {
                nz: insn.mnemonic == "tbnz",
                rt,
                bit: bit as u8,
            }
        }
        "adr" if insn.operands.len() == 2 => match conv(&insn.operands[0])? {
            Opnd::Reg {
                num, is64: true, ..
            } => LabelBranch::Adr { rd: num },
            _ => {
                return Err(String::from(
                    "aarch64 inline asm: adr destination must be a 64-bit register",
                ));
            }
        },
        m => {
            // Both conditional spellings: `b.<cond>` and the bare `b<cond>`
            // (`bne`, `beq`), which GNU as also accepts.
            let cond = m
                .strip_prefix("b.")
                .and_then(super::asm::cond_code)
                .or_else(|| m.strip_prefix('b').and_then(super::asm::cond_code));
            match cond.filter(|_| insn.operands.len() == 1) {
                Some(c) => LabelBranch::BCond(c),
                None => {
                    return Err(String::from(
                        "aarch64 inline asm: label branch must be b/b.cond/cbz/cbnz",
                    ));
                }
            }
        }
    })
}

/// Encode an ALTERNATIVE `.subsection` replacement into a deferred region:
/// the machine bytes plus each local label's byte offset within them. A branch
/// to a local label (`Nf` / `Nb`) or `.` resolves within the region (the
/// displacement is target-minus-branch inside the region, invariant of where
/// the region lands), matching GNU-as local-label practice. A branch to an
/// `asm goto` label (`%l[...]`) leaves the region for the enclosing function
/// and is returned for the caller to resolve once the block layout is final. A
/// symbol target is rejected rather than mis-placed, since its bytes would need
/// a relocation at the final out-of-line offset. Instructions encode through
/// the same operand converter and table encoder as the main stream, so the
/// region admits exactly what an inline instruction does. `main_label` resolves
/// a main-stream label (`661b` / `662b`) for the `.org` length expression. The
/// returned goto sites are `(byte offset in the region, branch kind, label
/// index)`.
#[allow(clippy::type_complexity)]
fn encode_deferred_asm_region(
    text: &str,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
    main_label: &dyn Fn(&str) -> Option<usize>,
    sym_name: &dyn Fn(&str) -> Result<alloc::string::String, alloc::string::String>,
) -> Result<(DeferredAsmRegion, Vec<(usize, LabelBranch, u8)>), alloc::string::String> {
    use super::super::map_syms::MapClass;
    use super::asm::{AsmOpndA64, parse_template};
    use super::table::{self, Opnd};
    use alloc::string::String;
    let mut bytes: Vec<u8> = Vec::new();
    // The replacement is appended to `.text`, so it follows the same mapping
    // rule the main stream does.
    let mut map_state: Option<MapClass> = None;
    let mut data_ranges: Vec<(usize, usize)> = Vec::new();
    let mut labels: Vec<(u32, usize)> = Vec::new();
    // Branches to a region-local label, patched after the loop once every
    // label offset is known: `(byte offset in the region, kind, label, forward)`.
    let mut label_fixups: Vec<(usize, LabelBranch, u32, bool)> = Vec::new();
    let mut goto_sites: Vec<(usize, LabelBranch, u8)> = Vec::new();
    let mut sym_branches: Vec<DeferredSymBranch> = Vec::new();
    for stmt in text.split(['\n', ';']) {
        let mut stmt = stmt.trim();
        // Peel leading `N:` label definitions; a directive may follow one.
        while let Some(colon) = stmt.find(':') {
            let head = &stmt[..colon];
            if head.is_empty() || !head.bytes().all(|c| c.is_ascii_digit()) {
                break;
            }
            let num: u32 = head
                .parse()
                .map_err(|_| alloc::format!("inline asm: bad label `{head}:`"))?;
            labels.push((num, bytes.len()));
            stmt = stmt[colon + 1..].trim();
        }
        if stmt.is_empty() {
            continue;
        }
        // `.org <expr>`: pad forward to the target; a backward move is the
        // ALTERNATIVE length-mismatch assertion firing, an error as in GNU as.
        if let Some(rest) = stmt.strip_prefix(".org")
            && (rest.is_empty() || rest.starts_with(char::is_whitespace))
        {
            let expr = rest.trim();
            let cur = bytes.len() as i64;
            // The location counter `.` is the current region offset; a `Nb`
            // label resolves in the region (a `663b` / `664b` replacement
            // label) or falls back to the main stream (`661b` / `662b`). The
            // expression uses only label differences, so the main labels'
            // absolute offsets cancel.
            let resolve = |name: &str| -> Option<i64> {
                if name == "." {
                    return Some(cur);
                }
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if let Ok(n) = digits.parse::<u32>()
                    && let Some(off) = labels.iter().rev().find(|&&(l, _)| l == n)
                {
                    return Some(off.1 as i64);
                }
                main_label(name).map(|o| o as i64)
            };
            let target =
                crate::c5::asm::eval_asm_expr_with_labels(expr, &resolve).ok_or_else(|| {
                    alloc::format!("inline asm: unsupported `.org` expression `{expr}`")
                })?;
            if target < cur {
                return Err(String::from(
                    "inline asm: ALTERNATIVE replacement and original differ in length",
                ));
            }
            bytes.resize(target as usize, 0);
            continue;
        }
        for insn in &parse_template(stmt.as_bytes())? {
            if let Some(num) = insn.label_def {
                labels.push((num, bytes.len()));
                continue;
            }
            // A layout directive resolves against the region's own counter,
            // which is where its labels are recorded.
            if let Some(item) = &insn.layout {
                let resolve = |name: &str| -> Option<i64> {
                    let num: u32 = name.strip_suffix(['b', 'f']).unwrap_or(name).parse().ok()?;
                    labels
                        .iter()
                        .rfind(|&&(n, _)| n == num)
                        .map(|&(_, off)| off as i64)
                };
                let resolved = crate::c5::asm::resolve_align_item(item, &resolve)?;
                let item = resolved.as_ref().unwrap_or(item);
                crate::c5::asm::push_a64_stream_layout(
                    item,
                    &mut bytes,
                    &mut data_ranges,
                    &resolve,
                    &|_| None,
                )?;
                map_state = crate::c5::asm::step_map_state(item, map_state, true);
                continue;
            }
            let class =
                crate::c5::asm::data_directive_class(&insn.mnemonic).unwrap_or(MapClass::Code);
            if class == MapClass::Code {
                a64_align_asm_stream(&mut bytes, &mut data_ranges, &mut map_state);
            }
            map_state = Some(class);
            if !insn.bytes.is_empty() {
                if class == MapClass::Data {
                    data_ranges.push((bytes.len(), insn.bytes.len()));
                }
                bytes.extend_from_slice(&insn.bytes);
                continue;
            }
            if let Some(name) = &insn.sym_target {
                let is_call = insn.mnemonic == "bl";
                sym_branches.push(DeferredSymBranch {
                    region_off: bytes.len(),
                    name: sym_name(name)?,
                    is_call,
                });
                let word = if is_call {
                    super::encode::enc_bl(0)
                } else {
                    super::encode::enc_b(0)
                };
                bytes.extend_from_slice(&word.to_le_bytes());
                continue;
            }
            match insn.operands.last() {
                Some(&AsmOpndA64::Here(off)) => {
                    // `.` names the branch's own address, plus any offset.
                    let kind = build_label_branch(insn, conv)?;
                    let word = match kind {
                        LabelBranch::Adr { rd } => {
                            if !(-(1i32 << 20)..(1i32 << 20)).contains(&off) {
                                return Err(String::from(
                                    "aarch64 inline asm: adr target out of +/-1MiB range",
                                ));
                            }
                            super::encode::enc_adr(Reg(rd), off)
                        }
                        _ => label_branch_word(&kind, off as i64)?,
                    };
                    bytes.extend_from_slice(&word.to_le_bytes());
                }
                Some(&AsmOpndA64::Label { num, forward }) => {
                    label_fixups.push((bytes.len(), build_label_branch(insn, conv)?, num, forward));
                    bytes.extend_from_slice(&0u32.to_le_bytes());
                }
                Some(&AsmOpndA64::GotoLabel(k)) => {
                    goto_sites.push((bytes.len(), build_label_branch(insn, conv)?, k));
                    bytes.extend_from_slice(&0u32.to_le_bytes());
                }
                _ => {
                    let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
                    for o in &insn.operands {
                        ops.push(conv(o)?);
                    }
                    bytes.extend_from_slice(&table::encode(&insn.mnemonic, &ops)?.to_le_bytes());
                }
            }
        }
    }
    // What follows the region in `.text` is instructions, so a replacement
    // ending in data realigns here.
    a64_align_asm_stream(&mut bytes, &mut data_ranges, &mut map_state);
    // Resolve the region-local label branches: a forward reference binds the
    // next definition after the branch, a backward one the most recent at or
    // before it (GNU-as `Nf` / `Nb`). The displacement is region-relative and
    // holds wherever the region is finally placed.
    for &(site, ref kind, num, forward) in &label_fixups {
        let target = if forward {
            labels.iter().find(|&&(n, off)| n == num && off > site)
        } else {
            labels
                .iter()
                .rev()
                .find(|&&(n, off)| n == num && off <= site)
        };
        let Some(&(_, target)) = target else {
            return Err(String::from("aarch64 inline asm: undefined local label"));
        };
        let delta = target as i64 - site as i64;
        let word = if let LabelBranch::Adr { rd } = *kind {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&delta) {
                return Err(String::from(
                    "aarch64 inline asm: adr target out of +/-1MiB range",
                ));
            }
            super::encode::enc_adr(Reg(rd), delta as i32)
        } else {
            label_branch_word(kind, delta)?
        };
        bytes[site..site + 4].copy_from_slice(&word.to_le_bytes());
    }
    Ok((
        DeferredAsmRegion {
            bytes,
            labels,
            goto_branches: Vec::new(),
            sym_branches,
            data_ranges,
        },
        goto_sites,
    ))
}

/// The value of a template field's expression at stream offset `at`, over
/// the template's own label definitions. `None` when a leaf is unresolved.
fn template_expr_value(
    expr: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
) -> Option<i64> {
    crate::c5::asm::eval_asm_expr_with_labels(expr, &|name| {
        crate::c5::asm::template_label_offset(name, at, label_defs, names)
    })
}

/// Bring a stream to the instruction boundary out of the data mapping
/// state, as GNU as does in an executable section, and leave `state` on the
/// instructions the caller is about to lay down. The gap is under one
/// instruction, so the shared fill lays it down as zeros; the padding is
/// part of the data run it follows.
pub(crate) fn a64_align_asm_stream(
    code: &mut Vec<u8>,
    text_data_ranges: &mut Vec<(usize, usize)>,
    state: &mut Option<super::super::map_syms::MapClass>,
) {
    let gap = crate::c5::asm::insn_align_gap(code.len() as i64, *state, true, true) as usize;
    *state = Some(super::super::map_syms::MapClass::Code);
    if gap == 0 {
        return;
    }
    text_data_ranges.push((code.len(), gap));
    crate::c5::asm::push_a64_exec_align_fill(code, gap);
}

/// Lower an `Inst::InlineAsm` (GCC extended asm) on AArch64. Assigns each
/// register operand a machine register per its constraint, saves the registers
/// the block overwrites, captures the operand values / addresses to a stack
/// region, loads the inputs, encodes the register-concrete template through the
/// table encoder, and stores the outputs back through their addresses. Raw-byte
/// pieces emit their literal bytes verbatim. `x16` / `x17` are the bridge
/// scratch, so the operand pool is `x0..x15`. `goto_ctx` is present for
/// the `asm goto` form (the statement is the last instruction of a
/// `Terminator::AsmGoto` block).
pub(super) fn emit_inline_asm_aarch64(
    code: &mut Vec<u8>,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    fixups: &mut Vec<super::encode::Fixup>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    data_sym_offsets: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    asm_sections: &mut crate::c5::asm::AsmSectionSink,
    asm_extern_call_sites: &mut Vec<super::UserExternCallSite>,
    asm_sym_fixups: &mut Vec<super::AsmSymFixup>,
    deferred_regions: &mut Vec<DeferredAsmRegion>,
    text_data_ranges: &mut Vec<(usize, usize)>,
    text_align: &mut usize,
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    goto_ctx: Option<AsmGotoCtxA64<'_>>,
) -> bool {
    use super::super::ir::AsmConstraint;
    use super::super::map_syms::MapClass;
    use super::asm::{AsmOpndA64, assign_operand_regs, parse_template};
    use super::encode::{enc_add_imm, enc_str_imm, enc_str32_imm, enc_strh_imm, enc_sub_imm};
    use super::table::{self, Opnd};
    use alloc::string::String;

    // A statement that lowers to nothing keeps only its IR-level ordering
    // effect; the operand staging around zero bytes of code is dead, and
    // `asm_scratch_bytes` reserved no region for it.
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::A64) {
        return true;
    }
    // Expand `%=` once so the code text and any `.pushsection` content
    // share one instance number, then split off the section blocks; the
    // arch parser sees only the code text.
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        bail_msg("aarch64 inline asm: non-UTF8 template");
        return false;
    };
    let stripped = crate::c5::asm::strip_asm_comments(raw_text, crate::c5::asm::AsmComments::A64);
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = crate::c5::asm::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    let reduced = match crate::c5::asm::strip_asm_conditionals(text) {
        Ok(r) => r,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = reduced.as_deref().unwrap_or(text);
    // Assign operand registers before the GNU-as macro pass so it can
    // substitute each reference to its register name -- the same register the
    // operand capture and write-back below use.
    // The constant value of an `i`-class operand reference, if any.
    let const_of = |idx: u8| -> Option<i64> {
        crate::c5::asm::asm_operand_const(func, *args.get(idx as usize)?)
    };
    let operand_form = |idx: u8| -> String {
        args.get(idx as usize).map_or_else(
            || String::from("past the operand list"),
            |&a| crate::c5::asm::asm_operand_form(func, a),
        )
    };
    let op_reg = match assign_operand_regs(
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
    let gas_subst = |tok: &str| -> Option<String> {
        let body = tok.strip_prefix('%')?;
        let (force, digits) = match body.as_bytes().first()? {
            b'w' => (Some(false), &body[1..]),
            b'x' => (Some(true), &body[1..]),
            b'c' | b'P' => {
                let idx: u8 = body[1..].parse().ok()?;
                return const_of(idx).map(|v| alloc::format!("{v}"));
            }
            _ => (None, body),
        };
        let idx: u8 = digits.parse().ok()?;
        let r = op_reg.get(idx as usize).copied().flatten()?;
        // A `Q` operand substitutes as the whole memory reference `[xN]`
        // through its address register, matching the operand converter's
        // rule for the un-expanded `%N` form.
        if matches!(
            asm.operands.get(idx as usize).map(|o| o.constraint),
            Some(AsmConstraint::MemBase)
        ) {
            return Some(alloc::format!("[x{r}]"));
        }
        let wide = asm
            .operands
            .get(idx as usize)
            .map(|o| o.width >= 8)
            .unwrap_or(true);
        Some(alloc::format!(
            "{}{}",
            if force.unwrap_or(wide) { 'x' } else { 'w' },
            r
        ))
    };
    let gas = match crate::c5::asm::expand_asm_gas_macros(text, 4, &gas_subst) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = gas.as_deref().unwrap_or(text);
    // Lift any ALTERNATIVE `.subsection` replacement out of the main stream;
    // it is encoded into a deferred region appended after the function body
    // (below), out of the main sequence's fall-through path.
    let (main_text, deferred_text) = crate::c5::asm::split_asm_subsections(text);
    let text = main_text.as_str();
    let extracted = match crate::c5::asm::extract_asm_sections(text, true) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Owned parts: the blocks are encoded in place below, once the operand
    // converter exists, while the code text stays borrowable.
    let (code_owned, mut section_blocks, sym_items) = match extracted {
        Some(ex) => (Some(ex.code), ex.blocks, ex.sym_items),
        None => (None, Vec::new(), Vec::new()),
    };
    let code_text: &str = code_owned.as_deref().unwrap_or(text);
    if let Err(m) = crate::c5::asm::reject_unit_symbol_items(&section_blocks) {
        bail_msg(&m);
        return false;
    }
    // The template's symbol directives declare names of the unit; the object
    // writer applies them, where every definition is known.
    if let Err(m) = asm_sections.push_sym_decls(&sym_items) {
        bail_msg(&m);
        return false;
    }
    let insns = match parse_template(code_text.as_bytes()) {
        Ok(i) => i,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Registers the block overwrites: the operand registers plus the explicit
    // clobber list. Every general register is saved around the block, since the
    // allocator may hold a live value in any of them; x16 / x17 are this
    // lowering's own scratch, reloaded after the template rather than carried
    // across it. `w` operands and FP clobbers are in the independent d0..d7
    // file and are saved separately. `asm_save_masks` is shared with the
    // frame-region sizing in `compute_frame`.
    let (used_mask, fp_used_mask) = match asm_save_masks(asm, &op_reg, frame.fixed_regs) {
        Ok(m) => m,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let save_list: Vec<u8> = (0u8..31).filter(|r| used_mask & (1 << r) != 0).collect();
    let fp_save_list: Vec<u8> = (0u8..8).filter(|r| fp_used_mask & (1 << r) != 0).collect();

    let n = asm.operands.len();
    let n_saved = save_list.len();
    let n_fp_saved = fp_save_list.len();
    // An immediate operand is substituted into the template text and has
    // no runtime storage, so it takes no capture slot. Keeping the
    // region empty for a template whose only operands are immediates
    // matters beyond the saved bytes: the region is released on the paths
    // out of the template, and an `asm goto` label reached by a branch
    // planted at run time -- a jump-label or alternative patch site, whose
    // `%l` is a data reference rather than a branch in the template --
    // bypasses every one of them.
    let needs_cap: Vec<bool> = op_reg.iter().map(Option::is_some).collect();
    let mut cap_slot: Vec<usize> = alloc::vec![0; n];
    let mut n_cap = 0usize;
    for (i, &c) in needs_cap.iter().enumerate() {
        if c {
            cap_slot[i] = n_cap;
            n_cap += 1;
        }
    }
    // Region layout: captures first, then the saved GP registers, then the
    // saved FP registers, a 16-byte multiple. The region is frame storage at
    // `[sp + region_base + off]` (`Frame::asm_scratch_off`): sp does not move,
    // so an `asm goto` label reached by a run-time-patched branch -- a
    // published `%l` in a jump table, which bypasses every exit path of the
    // template -- leaves sp balanced. A naked function has no frame, so its
    // region is carved from sp around the template as a self-contained pair.
    let size = (((n_cap + n_saved + n_fp_saved) * 8) as u32 + 15) & !15;
    let carve = func.is_naked && size > 0;
    // An empty region means no entry or exit work: every capture, save and
    // operand load addresses it, and an operand with no register takes no
    // slot. The template's own realignment is per instruction below.
    let mut map_state = *text_map_state;
    if size > 0 {
        a64_align_asm_stream(code, text_data_ranges, &mut map_state);
    }
    let region_base: u32 = if carve {
        if size > MAX_UNPROBED_STACK_STEP {
            bail_msg("aarch64 inline asm: operand frame too large");
            return false;
        }
        emit(code, enc_sub_imm(Reg(31), Reg(31), size));
        0
    } else {
        debug_assert!(
            size == 0 || (frame.asm_scratch_off + size as i64) <= 0,
            "inline asm without a frame scratch region"
        );
        (frame.frame_bytes as i64 + frame.asm_scratch_off) as u32
    };
    // The carve moved sp under the allocator's sp-relative spill slots; frame
    // storage leaves sp alone.
    let spill_shift = if carve { size } else { 0 };
    let cap_off = |i: usize| region_base + (cap_slot[i] * 8) as u32;
    let save_off = |j: usize| region_base + ((n_cap + j) * 8) as u32;
    let fp_save_off = |k: usize| region_base + ((n_cap + n_saved + k) * 8) as u32;
    // Region slot accessors: the carve is always sp-based; frame storage
    // follows the spill addressing (sp-based, fp-based when `dynamic_sp`).
    let reg_ldr_x = |code: &mut Vec<u8>, rt: Reg, off: u32| {
        if carve {
            emit_sp_ldr_x(code, rt, off);
        } else {
            emit_spill_ldr_x(code, frame, rt, off);
        }
    };
    let reg_str_x = |code: &mut Vec<u8>, rt: Reg, off: u32| {
        if carve {
            emit_sp_str_x_auto(code, rt, off);
        } else {
            emit_spill_str_x_auto(code, frame, rt, off);
        }
    };
    let reg_ldr_d = |code: &mut Vec<u8>, dt: u8, off: u32| {
        if carve {
            emit_sp_ldr_d_auto(code, dt, off);
        } else {
            emit_spill_ldr_d_auto(code, frame, dt, off);
        }
    };
    let reg_str_d = |code: &mut Vec<u8>, dt: u8, off: u32| {
        if carve {
            emit_sp_str_d_auto(code, dt, off);
        } else {
            emit_spill_str_d_auto(code, frame, dt, off);
        }
    };

    // Save the clobbered registers, then capture each operand's value (input) /
    // address (output) -- both before any operand register is overwritten.
    for (j, &r) in save_list.iter().enumerate() {
        reg_str_x(code, Reg(r), save_off(j));
    }
    for (k, &r) in fp_save_list.iter().enumerate() {
        reg_str_d(code, r, fp_save_off(k));
    }
    for (i, &a) in args.iter().enumerate() {
        if !needs_cap.get(i).copied().unwrap_or(true) {
            continue;
        }
        let Some(place) = alloc.places.get(a as usize).copied() else {
            bail_msg("aarch64 inline asm: operand place missing");
            return false;
        };
        // A double `w` input captures its FP value; a 16-byte `w` operand's
        // SSA value is its address, so it captures like the integer operands.
        // Every other operand captures an integer value (input) or a
        // destination address (output).
        if matches!(asm.operands[i].constraint, AsmConstraint::Fp)
            && !asm.operands[i].is_output
            && asm.operands[i].width == 8
        {
            let Some(d) = materialize_fp_shifted(code, place, 16, frame, spill_shift) else {
                bail_msg("aarch64 inline asm: `w` operand not a floating-point place");
                return false;
            };
            reg_str_d(code, d, cap_off(i));
        } else {
            let Some(r) = materialize_int_shifted(code, place, Reg(16), frame, spill_shift) else {
                bail_msg("aarch64 inline asm: operand not an integer place");
                return false;
            };
            reg_str_x(code, r, cap_off(i));
        }
    }
    // Load inputs and memory addresses into their assigned registers; a `+`
    // read-write output loads its current value from the destination address.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            // A double `w` input loads its captured FP value into the
            // d-register; a 16-byte `w` operand (input or read-write output)
            // loads the full q register through its captured address. A
            // read-write double output loads the current value the same way.
            if op.width == 16 {
                if !op.is_output || op.is_rw {
                    reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = operand address
                    emit(code, super::encode::enc_ldr_q_imm(r, Reg(16), 0));
                }
            } else if !op.is_output {
                reg_ldr_d(code, r, cap_off(i));
            } else if op.is_rw {
                reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = destination address
                emit(code, super::encode::enc_ldr_d_imm(r, Reg(16), 0));
            }
            continue;
        }
        if matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase) || !op.is_output {
            reg_ldr_x(code, Reg(r), cap_off(i));
        } else if op.is_rw {
            reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = destination address
            let ok = match op.width {
                8 => {
                    emit(code, super::encode::enc_ldr_imm(Reg(r), Reg(16), 0));
                    true
                }
                4 => {
                    emit(code, super::encode::enc_ldr32_imm(Reg(r), Reg(16), 0));
                    true
                }
                2 => {
                    emit(code, super::encode::enc_ldrh_imm(Reg(r), Reg(16), 0));
                    true
                }
                1 => {
                    emit(code, super::encode::enc_ldrb_imm(Reg(r), Reg(16), 0));
                    true
                }
                _ => false,
            };
            if !ok {
                bail_msg("aarch64 inline asm: unsupported read-write operand width");
                return false;
            }
        }
    }
    // Resolve one symbolic operand to a table operand; label references have
    // no table form and are handled by the branch path below.
    let conv = |o: &AsmOpndA64| -> Result<Opnd, String> {
        let resolve_ref = |idx: u8| -> Option<u8> { op_reg.get(idx as usize).copied().flatten() };
        Ok(match *o {
            AsmOpndA64::Imm(v) => Opnd::Imm(v),
            // `%cN` / `%PN`: the operand's compile-time constant, bare.
            AsmOpndA64::RefConst(idx) => match const_of(idx) {
                Some(v) => Opnd::Imm(v),
                None => {
                    return Err(String::from(
                        "aarch64 inline asm: non-constant `%c` operand",
                    ));
                }
            },
            AsmOpndA64::Lsl(s) => Opnd::Lsl(s),
            AsmOpndA64::Shift { kind, amount } => Opnd::Shift { kind, amount },
            AsmOpndA64::Extend { option, amount } => Opnd::Extend { option, amount },
            AsmOpndA64::SysReg(f) => Opnd::SysReg(f),
            AsmOpndA64::SysOp(b) => Opnd::SysOp(b),
            AsmOpndA64::Reg { num, is64, sp } => Opnd::Reg { num, is64, sp },
            AsmOpndA64::RegWb(num) => Opnd::RegWb(num),
            AsmOpndA64::VReg { num, is_d } => Opnd::VReg { num, is_d },
            AsmOpndA64::QReg(num) => Opnd::QReg(num),
            AsmOpndA64::VScalar { num, size } => Opnd::VScalar { num, size },
            AsmOpndA64::FpImm(v) => Opnd::FpImm(v),
            AsmOpndA64::VecReg { num, size, q } => Opnd::VecReg { num, size, q },
            AsmOpndA64::VecElem { num, size, index } => Opnd::VecElem { num, size, index },
            AsmOpndA64::VecList {
                first,
                count,
                size,
                q,
            } => Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            AsmOpndA64::VecListLane {
                first,
                count,
                size,
                index,
            } => Opnd::VecListLane {
                first,
                count,
                size,
                index,
            },
            AsmOpndA64::Ref { idx, is64 } => {
                let Some(r) = resolve_ref(idx) else {
                    // An immediate operand has no register; a bare `%N` uses
                    // its compile-time constant value.
                    if matches!(
                        asm.operands[idx as usize].constraint,
                        AsmConstraint::Imm | AsmConstraint::RegOrImm { .. }
                    ) {
                        return match const_of(idx) {
                            Some(v) => Ok(Opnd::Imm(v)),
                            None => Err(alloc::format!(
                                "aarch64 inline asm: non-constant immediate operand `%{idx}`: \
                                 the operand is {}",
                                operand_form(idx)
                            )),
                        };
                    }
                    return Err(String::from(
                        "aarch64 inline asm: operand reference is not a register",
                    ));
                };
                if matches!(asm.operands[idx as usize].constraint, AsmConstraint::Fp) {
                    // `%sN` selects the single view, `%dN` / bare the double.
                    Opnd::VReg {
                        num: r,
                        is_d: is64.unwrap_or(true),
                    }
                } else if matches!(
                    asm.operands[idx as usize].constraint,
                    AsmConstraint::MemBase
                ) {
                    // A `Q` operand substitutes as the whole memory
                    // reference `[xN]` through its address register.
                    Opnd::Mem {
                        base: r,
                        off: 0,
                        pre: false,
                    }
                } else {
                    let is64 = is64.unwrap_or(asm.operands[idx as usize].width >= 8);
                    Opnd::Reg {
                        num: r,
                        is64,
                        sp: false,
                    }
                }
            }
            // The vector views (`%N.T`, `%qN`, `{%N.T}`) name the SIMD file, so
            // they require a `w` operand.
            AsmOpndA64::RefVec { idx, size, q } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecReg { num: r, size, q }
            }
            AsmOpndA64::RefVecElem { idx, size, index } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecElem {
                    num: r,
                    size,
                    index,
                }
            }
            AsmOpndA64::RefVecList { idx, size, q } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecList {
                    first: r,
                    count: 1,
                    size,
                    q,
                }
            }
            AsmOpndA64::RefVecListLane { idx, size, index } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecListLane {
                    first: r,
                    count: 1,
                    size,
                    index,
                }
            }
            AsmOpndA64::RefQ(idx) => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::QReg(r)
            }
            AsmOpndA64::Mem { base, off, pre } => {
                let base = match base {
                    super::asm::MemBase::Reg(n) => n,
                    super::asm::MemBase::Ref(idx) => {
                        let Some(r) = resolve_ref(idx) else {
                            return Err(String::from(
                                "aarch64 inline asm: memory base is not a register",
                            ));
                        };
                        r
                    }
                };
                Opnd::Mem { base, off, pre }
            }
            AsmOpndA64::MemReg {
                base,
                index,
                option,
                shift,
            } => {
                let reg_of = |b: super::asm::MemBase| match b {
                    super::asm::MemBase::Reg(n) => Some(n),
                    super::asm::MemBase::Ref(idx) => resolve_ref(idx),
                };
                let (Some(base), Some(index)) = (reg_of(base), reg_of(index)) else {
                    return Err(String::from(
                        "aarch64 inline asm: memory operand is not a register",
                    ));
                };
                Opnd::MemReg {
                    base,
                    index,
                    option,
                    shift,
                }
            }
            AsmOpndA64::Cond(c) => Opnd::Cond(c),
            AsmOpndA64::Label { .. } | AsmOpndA64::GotoLabel(_) => {
                return Err(String::from(
                    "aarch64 inline asm: label reference outside a branch",
                ));
            }
            AsmOpndA64::Here(_) => {
                return Err(String::from(
                    "aarch64 inline asm: `.` reference outside a branch",
                ));
            }
            // The main-stream encoder routes a trailing symbol operand
            // through `encode_a64_sym_insn` before operand conversion; one
            // reaching here sits in an unsupported position (a deferred
            // ALTERNATIVE replacement, a non-final operand).
            // TODO symbol relocations in deferred replacement regions.
            AsmOpndA64::Sym { .. } | AsmOpndA64::MemSymLo12 { .. } => {
                return Err(String::from(
                    "aarch64 inline asm: symbol operand needs a relocation",
                ));
            }
            // TODO operand expressions over labels in function-body asm; a
            // function body has no section layout to fold one against.
            AsmOpndA64::ImmExpr(ref e) | AsmOpndA64::MemExpr { expr: ref e, .. } => {
                return Err(alloc::format!(
                    "aarch64 inline asm: operand expression `{e}` needs a section layout"
                ));
            }
            // TODO literal pools in function-body asm; a function body has no
            // section of its own to flush one into.
            AsmOpndA64::LitPool(_) => {
                return Err(String::from(
                    "aarch64 inline asm: `ldr` literal pool needs a file-scope section",
                ));
            }
        })
    };
    // `%lK` label indices this statement's section items reference -- a data
    // field (`.long %l0 - .`) or a section branch (`b %l[k]`). A statement
    // with exit work rewrites those relocs below, so the published address is
    // the same trampoline a template `%lK` branch takes.
    let data_goto_ks = core::cell::RefCell::new(Vec::<usize>::new());
    let goto_block = |idx: u8| -> Option<u32> {
        let ctx = goto_ctx.as_ref()?;
        let bid = ctx.row.get(1 + idx as usize).copied()?;
        data_goto_ks.borrow_mut().push(idx as usize);
        Some(bid)
    };
    // Assemble the instructions of a pushed section to bytes before layout.
    // The converter above resolves a reference to the enclosing template's
    // operands, which the file-scope encoder has no notion of.
    if !section_blocks.is_empty()
        && let Err(m) = encode_a64_asm_section_code(&mut section_blocks, &conv, &goto_block)
    {
        bail_msg(&m);
        return false;
    }
    // Local labels: definitions record the code offset they stand at; branches
    // to them emit a placeholder word and are patched once the block's layout
    // is final (a `Nb` reference binds to the most recent definition of N at
    // or before the branch, `Nf` to the next one after it).
    let mut label_defs: Vec<(u32, usize)> = Vec::new();
    let mut label_fixups: Vec<(usize, LabelBranch, u32, bool)> = Vec::new();
    // The template's intern table, telling an expression leaf apart from a
    // symbol the stream cannot relocate.
    let label_names = crate::c5::asm::scan_label_names(code_text);
    // Forward-referencing fields over template labels, settled below: a data
    // field as `(reference_site, field, width, expression)`, an instruction
    // operand by re-encoding its word.
    let mut expr_fixups: Vec<(usize, usize, usize, String)> = Vec::new();
    let mut insn_expr_fixups: Vec<(usize, String, Vec<Opnd>, usize, String)> = Vec::new();
    // `asm goto` label branches: `(site, kind, label_index)` per `%lK`
    // reference, patched to the label's restore trampoline (or to the
    // shared fall-through restore when the target is the fall-through
    // block).
    let mut goto_sites: Vec<(usize, LabelBranch, usize)> = Vec::new();

    // The mapping state the stream is in on entry; it spans the section, so
    // a template ending in data pads only where an instruction follows.
    let mut map_state = *text_map_state;

    // Code-stream label names, so a layout directive's expression can read a
    // named label's offset as it reads a numeric one.
    let stream_label_names = crate::c5::asm::scan_label_names(code_text);
    // Encode each template instruction; raw-byte pieces emit verbatim.
    for insn in &insns {
        if let Some(num) = insn.label_def {
            label_defs.push((num, code.len()));
            continue;
        }
        // A layout directive moves the location counter; `code` is the unit's
        // whole text stream, so its length is the section offset GNU as
        // resolves one against. Only a definition already emitted resolves.
        if let Some(item) = &insn.layout {
            let resolve = |name: &str| -> Option<i64> {
                let num = match stream_label_names.iter().position(|&n| n == name) {
                    Some(i) => crate::c5::asm::NAMED_LABEL_BASE + i as u32,
                    None => name.strip_suffix(['b', 'f'])?.parse().ok()?,
                };
                label_defs
                    .iter()
                    .rfind(|&&(n, _)| n == num)
                    .map(|&(_, off)| off as i64)
            };
            let resolved = match crate::c5::asm::resolve_align_item(item, &resolve) {
                Ok(r) => r,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            let item = resolved.as_ref().unwrap_or(item);
            match crate::c5::asm::push_a64_stream_layout(
                item,
                code,
                text_data_ranges,
                &resolve,
                &const_of,
            ) {
                Ok(n) => *text_align = (*text_align).max(n as usize),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
            map_state = crate::c5::asm::step_map_state(item, map_state, true);
            continue;
        }
        // Every item but a data directive lays down instructions: a raw-byte
        // piece the parser encoded itself (`msr`, the barriers, the system
        // ops), `.inst`, and an assembled mnemonic.
        let class = crate::c5::asm::data_directive_class(&insn.mnemonic).unwrap_or(MapClass::Code);
        if class == MapClass::Code {
            a64_align_asm_stream(code, text_data_ranges, &mut map_state);
        }
        map_state = Some(class);
        if !insn.bytes.is_empty() {
            if class == MapClass::Data {
                text_data_ranges.push((code.len(), insn.bytes.len()));
            }
            code.extend_from_slice(&insn.bytes);
            continue;
        }
        // A data directive with operand references (`.long %c0`): each
        // argument must resolve to a compile-time constant, emitted
        // little-endian at the directive width.
        if let Some(w) = crate::c5::asm::data_directive_width(&insn.mnemonic) {
            // `.word` is target-dependent: 4 bytes on AArch64.
            let w = if insn.mnemonic == ".word" { 4 } else { w };
            if class == MapClass::Data {
                text_data_ranges.push((code.len(), w * insn.operands.len()));
            }
            for o in &insn.operands {
                let v = match *o {
                    AsmOpndA64::Imm(v) => v,
                    AsmOpndA64::RefConst(idx) | AsmOpndA64::Ref { idx, .. } => {
                        match const_of(idx) {
                            Some(v) => v,
                            None => {
                                bail_msg("aarch64 inline asm: non-constant data-directive value");
                                return false;
                            }
                        }
                    }
                    // A value over template labels: the field width is the
                    // directive's, so only the value waits on the layout.
                    AsmOpndA64::ImmExpr(ref e) => {
                        match template_expr_value(e, code.len(), &label_defs, &label_names) {
                            Some(v) => v,
                            None if crate::c5::asm::is_template_label_expr(e, &label_names) => {
                                expr_fixups.push((code.len(), code.len(), w, e.clone()));
                                0
                            }
                            None => {
                                bail_msg("aarch64 inline asm: unsupported data-directive value");
                                return false;
                            }
                        }
                    }
                    _ => {
                        bail_msg("aarch64 inline asm: unsupported data-directive value");
                        return false;
                    }
                };
                code.extend_from_slice(&(v as u64).to_le_bytes()[..w]);
            }
            continue;
        }
        // A direct `bl` / `b` to a symbol: resolve the name to its entry PC and
        // record a fixup the post-pass patches to a rel26 once every function's
        // address is final -- the same mechanism as a compiler-emitted call.
        if let Some(name) = &insn.sym_target {
            let is_call = insn.mnemonic == "bl";
            let (kind, word) = if is_call {
                (BranchKind::Bl, super::encode::enc_bl(0))
            } else {
                (BranchKind::B, super::encode::enc_b(0))
            };
            // The name may embed operand references; substituting them first
            // is what makes `__get_user_%c0` name `__get_user_4`.
            let name = match crate::c5::asm::resolve_asm_symbol_target(
                name,
                &crate::c5::asm::A64_SYMBOL_SUBST,
                &const_of,
            ) {
                Ok(n) => n,
                Err(e) => {
                    bail_msg(&e);
                    return false;
                }
            };
            let native_offset = code.len();
            match name2entpc.get(name.as_str()) {
                Some(&ent_pc) => fixups.push(Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind,
                }),
                // Not defined here: the callee's address is a link-time
                // decision, so the site becomes a call relocation against the
                // name, exactly as a compiler-emitted call to an extern
                // function does. The rel26 stays zero for the linker to patch.
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: name.clone(),
                    is_tail: !is_call,
                }),
            }
            emit(code, word);
            continue;
        }
        let goto_label = match insn.operands.last() {
            Some(&AsmOpndA64::GotoLabel(k)) => Some(k),
            _ => None,
        };
        if matches!(
            insn.operands.last(),
            Some(AsmOpndA64::Label { .. } | AsmOpndA64::Here(_))
        ) || goto_label.is_some()
        {
            let kind = match build_label_branch(insn, &conv) {
                Ok(k) => k,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            if let Some(k) = goto_label {
                let Some(ctx) = goto_ctx.as_ref() else {
                    bail_msg("aarch64 inline asm: `%l` label reference outside `asm goto`");
                    return false;
                };
                if 1 + k as usize >= ctx.row.len() {
                    bail_msg("aarch64 inline asm: `%l` label index out of range");
                    return false;
                }
                if matches!(kind, LabelBranch::Adr { .. }) {
                    bail_msg("aarch64 inline asm: adr cannot take an `asm goto` label");
                    return false;
                }
                goto_sites.push((code.len(), kind, k as usize));
                emit(code, 0);
                continue;
            }
            if let Some(&AsmOpndA64::Here(off)) = insn.operands.last() {
                // `.` names the branch's own address, plus any offset.
                let word = match kind {
                    LabelBranch::Adr { rd } => {
                        if !(-(1i32 << 20)..(1i32 << 20)).contains(&off) {
                            bail_msg("aarch64 inline asm: adr target out of +/-1MiB range");
                            return false;
                        }
                        super::encode::enc_adr(Reg(rd), off)
                    }
                    _ => match label_branch_word(&kind, off as i64) {
                        Ok(w) => w,
                        Err(m) => {
                            bail_msg(&m);
                            return false;
                        }
                    },
                };
                emit(code, word);
                continue;
            }
            let Some(&AsmOpndA64::Label { num, forward }) = insn.operands.last() else {
                unreachable!("guard admits Label, Here or GotoLabel; the first two handled above");
            };
            label_fixups.push((code.len(), kind, num, forward));
            emit(code, 0);
            continue;
        }
        // `movz` / `movk` with `:abs_gN:` over an expression that folds:
        // a function body has no layout pass, so only a constant resolves,
        // and it takes the same field encoding the section path applies.
        if let Some(AsmOpndA64::Sym {
            expr,
            spec:
                super::asm::SymSpec::MovwAbs {
                    group,
                    signed,
                    check,
                },
        }) = insn.operands.last()
            && matches!(insn.mnemonic.as_str(), "movz" | "movk")
            && let Some(v) = crate::c5::asm::eval_const_expr_ops(expr, &|_| None)
        {
            let (rd, is64) = match conv(&insn.operands[0]) {
                Ok(Opnd::Reg { num, is64, .. }) => (num, is64),
                _ => {
                    bail_msg("aarch64 inline asm: `:abs_g` destination must be a register");
                    return false;
                }
            };
            let movk = insn.mnemonic == "movk";
            if movk && *signed {
                bail_msg("aarch64 inline asm: `:abs_g<n>_s:` is not allowed on `movk`");
                return false;
            }
            let word = match a64_movw_placeholder(rd, is64, movk, *group) {
                Ok(w) => w,
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 {m}"));
                    return false;
                }
            };
            match super::patch::movw_const_word(word, *group, *signed, *check, v) {
                Ok(w) => emit(code, w),
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 inline asm: {m}"));
                    return false;
                }
            }
            continue;
        }
        // A symbol operand (`adrp %x0, sym`, `add ..., :lo12:sym`, a `:lo12:`
        // load/store, `movz`/`movk` `:abs_gN:sym`, a branch / `adr` / literal
        // `ldr` naming a symbol) takes the section path's shape encoder; the
        // site records a per-instruction relocation against the name, an
        // internal-linkage data object resolved to its offset.
        if matches!(
            insn.operands.last(),
            Some(AsmOpndA64::Sym { .. } | AsmOpndA64::MemSymLo12 { .. })
        ) {
            let (word, kind, expr) = match encode_a64_sym_insn(insn, &conv) {
                Ok(Some(t)) => t,
                Ok(None) => {
                    bail_msg("aarch64 inline asm: unsupported symbol operand");
                    return false;
                }
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 {m}"));
                    return false;
                }
            };
            // A function body has no section layout, so only `sym + constant`
            // resolves here; a label-difference expression does not.
            let Some((name, addend)) = crate::c5::asm::asm_expr_sym_addend(&expr) else {
                bail_msg(&alloc::format!(
                    "aarch64 inline asm: operand expression `{expr}` needs a section layout"
                ));
                return false;
            };
            let target = match data_sym_offsets.get(name.as_str()) {
                Some(&off) => crate::c5::asm::AsmSectionTarget::Data(off as u64),
                None => crate::c5::asm::AsmSectionTarget::Symbol(name),
            };
            asm_sym_fixups.push(super::AsmSymFixup {
                instr_offset: code.len(),
                kind,
                target,
                addend,
            });
            emit(code, word);
            continue;
        }
        let mut ops: Vec<Opnd> = Vec::new();
        // An operand expression over template labels resolves here when every
        // leaf is placed; a forward reference encodes zero and the word is
        // built again below, the field width being the encoding's either way.
        let mut pending: Option<(usize, String)> = None;
        for o in &insn.operands {
            if let AsmOpndA64::ImmExpr(e) = o
                && crate::c5::asm::is_template_label_expr(e, &label_names)
            {
                let v = template_expr_value(e, code.len(), &label_defs, &label_names);
                if v.is_none() {
                    pending = Some((ops.len(), e.clone()));
                }
                ops.push(Opnd::Imm(v.unwrap_or(0)));
                continue;
            }
            match conv(o) {
                Ok(opnd) => ops.push(opnd),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
        }
        let site = code.len();
        match table::encode(&insn.mnemonic, &ops) {
            Ok(word) => emit(code, word),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
        if let Some((idx, expr)) = pending {
            insn_expr_fixups.push((site, insn.mnemonic.clone(), ops, idx, expr));
        }
    }
    // Settle the deferred expression fields and words: the layout is final,
    // so a forward reference now has its definition.
    for (site, at, width, expr) in &expr_fixups {
        let Some(v) = template_expr_value(expr, *site, &label_defs, &label_names) else {
            bail_msg(&alloc::format!(
                "aarch64 inline asm: expression `{expr}` is not a constant"
            ));
            return false;
        };
        code[*at..*at + *width].copy_from_slice(&(v as u64).to_le_bytes()[..*width]);
    }
    for (site, mnemonic, ops, idx, expr) in &insn_expr_fixups {
        let Some(v) = template_expr_value(expr, *site, &label_defs, &label_names) else {
            bail_msg(&alloc::format!(
                "aarch64 inline asm: expression `{expr}` is not a constant"
            ));
            return false;
        };
        let mut ops = ops.clone();
        ops[*idx] = Opnd::Imm(v);
        match table::encode(mnemonic, &ops) {
            Ok(word) => code[*site..*site + 4].copy_from_slice(&word.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    }
    // Patch the label branches now that every definition's offset is known.
    // A named label has exactly one definition, so direction does not apply.
    // Numeric references without an in-stream definition: the definition may
    // sit in one of the statement's pushed sections, resolved once those are
    // materialized below (`jmp 6f` shape). Only a forward reference reaches
    // one, as the sections follow the code textually.
    let mut pending_xsec: Vec<(usize, LabelBranch, u32)> = Vec::new();
    for &(site, ref kind, num, forward) in &label_fixups {
        let target = if num >= crate::c5::asm::NAMED_LABEL_BASE {
            label_defs.iter().find(|&&(n, _)| n == num).map(|&(_, o)| o)
        } else if forward {
            label_defs
                .iter()
                .find(|&&(n, off)| n == num && off > site)
                .map(|&(_, off)| off)
        } else {
            label_defs
                .iter()
                .rev()
                .find(|&&(n, off)| n == num && off <= site)
                .map(|&(_, off)| off)
        };
        let Some(target) = target else {
            if num < crate::c5::asm::NAMED_LABEL_BASE && forward && !section_blocks.is_empty() {
                pending_xsec.push((site, *kind, num));
                continue;
            }
            bail_msg("aarch64 inline asm: undefined local label");
            return false;
        };
        let delta = target as i64 - site as i64;
        // `adr` materializes a byte-granular PC-relative address (rel21,
        // unscaled), unlike the word-aligned, word-scaled branch offsets.
        if let LabelBranch::Adr { rd } = *kind {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&delta) {
                bail_msg("aarch64 inline asm: adr target out of +/-1MiB range");
                return false;
            }
            let word = super::encode::enc_adr(Reg(rd), delta as i32);
            code[site..site + 4].copy_from_slice(&word.to_le_bytes());
            continue;
        }
        match label_branch_word(kind, delta) {
            Ok(word) => code[site..site + 4].copy_from_slice(&word.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    }
    // A named label defined in the main stream is a definition of the unit,
    // as it is for GNU as: record it so the writers emit a `.text` symbol and
    // bind a same-name C reference to it. `.L`-prefixed names are
    // assembler-local, so no C reference spells one.
    {
        let names = crate::c5::asm::scan_label_names(code_text);
        for &(num, off) in &label_defs {
            let Some(idx) = num.checked_sub(crate::c5::asm::NAMED_LABEL_BASE) else {
                continue;
            };
            let Some(&name) = names.get(idx as usize) else {
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
    }
    // Resolve a numeric main-stream template label (`661b` / `662b`) to its
    // emitted text offset; `Nb` (or bare `N`) binds the last definition, `Nf`
    // the first.
    let main_label_off = |name: &str| -> Option<usize> {
        let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
        if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        let num: u32 = digits.parse().ok()?;
        let mut defs = label_defs.iter().filter(|&&(n, _)| n == num);
        if name.ends_with('f') {
            defs.map(|&(_, off)| off).min()
        } else {
            defs.next_back().map(|&(_, off)| off)
        }
    };
    // Encode the ALTERNATIVE replacement (if any) into a deferred region;
    // its `.org` length assertion reads the main labels above. The region is
    // appended after the function body and its labels resolved to text
    // offsets once its base is known (see the caller's placement pass).
    let mut deferred_goto_sites: Vec<(usize, LabelBranch, u8)> = Vec::new();
    let deferred_idx: Option<u32> = if deferred_text.is_empty() {
        None
    } else {
        // A replacement branch names its target the same way a main-stream one
        // does, operand references included (`bl __get_user_%c0`).
        let sym_name = |name: &str| -> Result<String, String> {
            crate::c5::asm::resolve_asm_symbol_target(
                name,
                &crate::c5::asm::A64_SYMBOL_SUBST,
                &const_of,
            )
        };
        match encode_deferred_asm_region(&deferred_text, &conv, &main_label_off, &sym_name) {
            Ok((region, gotos)) => {
                let idx = deferred_regions.len() as u32;
                deferred_regions.push(region);
                deferred_goto_sites = gotos;
                Some(idx)
            }
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    };
    // The per-section reloc counts before this statement's contribution,
    // bounding the trampoline rewrite below to this statement's relocs.
    let sect_reloc_marks: Vec<usize> = if goto_ctx.is_some() && size > 0 {
        asm_sections
            .relocs_mut()
            .iter()
            .map(|s| s.relocs.len())
            .collect()
    } else {
        Vec::new()
    };
    // Materialize the `.pushsection` blocks now that every label's text
    // offset is known. A reference that names a numeric template label
    // resolves to its offset; any other name is a symbol relocation.
    if !section_blocks.is_empty() {
        let label_off = |name: &str| -> Option<crate::c5::asm::LabelLoc> {
            use crate::c5::asm::LabelLoc;
            // A replacement-region label (`663f` / `664f`) resolves into the
            // deferred region, rewritten to a text offset once it is placed.
            if let Some(region) = deferred_idx {
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if let Ok(num) = digits.parse::<u32>() {
                    let labels = &deferred_regions[region as usize].labels;
                    let hit = if name.ends_with('f') {
                        labels
                            .iter()
                            .filter(|&&(n, _)| n == num)
                            .map(|&(_, o)| o)
                            .min()
                    } else {
                        labels
                            .iter()
                            .rev()
                            .find(|&&(n, _)| n == num)
                            .map(|&(_, o)| o)
                    };
                    if let Some(off) = hit {
                        return Some(LabelLoc::Deferred { region, off });
                    }
                }
            }
            main_label_off(name).map(LabelLoc::Text)
        };
        // An `i`-class operand naming a link-time data address (`.quad %c0 - .`
        // where `%c0` is `&sym`) relocates against the data image, resolved
        // like the operand's own `ImmData` lowering.
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
        // An `asm goto` label operand (`.long %l0 - .`) resolves through
        // `goto_block` to the row's block index. Its text offset is not final
        // here; the reloc carries the block and is rewritten after layout
        // (see resolve_asm_goto_relocs).
        let defined = match crate::c5::asm::materialize_asm_sections(
            &section_blocks,
            &resolver,
            &label_off,
            &goto_block,
            true,
            asm_sections,
        ) {
            Ok(d) => d,
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        };
        // Bind each deferred main-stream branch to its section definition.
        // The two land in different object sections, so the site takes an
        // instruction-field relocation against the target section rather
        // than an in-stream displacement.
        for (site, kind, num) in pending_xsec.drain(..) {
            let name = alloc::format!("{num}");
            let Some(d) = defined.iter().find(|d| d.name == name) else {
                bail_msg("aarch64 inline asm: undefined local label");
                return false;
            };
            let (word, rkind) = match a64_label_branch_reloc(&kind) {
                Ok(t) => t,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            code[site..site + 4].copy_from_slice(&word.to_le_bytes());
            asm_section_text_refs.push(super::AsmSectionTextRef {
                instr_offset: site,
                section_index: d.section_index,
                section_offset: d.offset,
                addend: 0,
                absolute: false,
                kind: rkind,
            });
        }
    }
    // Store the register outputs back through their captured addresses (x16
    // holds the address; the operand pool is untouched). For `asm goto`
    // the outputs are stored on every exit path (GCC 11 output
    // semantics), so the sequence repeats on each trampoline.
    let emit_outputs = |code: &mut Vec<u8>| -> bool {
        for (i, op) in asm.operands.iter().enumerate() {
            if !op.is_output || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase)
            {
                continue;
            }
            let Some(r) = op_reg[i] else { continue };
            reg_ldr_x(code, Reg(16), cap_off(i));
            if matches!(op.constraint, AsmConstraint::Fp) {
                if op.width == 16 {
                    emit(code, super::encode::enc_str_q_imm(r, Reg(16), 0));
                } else {
                    emit(code, super::encode::enc_str_d_imm(r, Reg(16), 0));
                }
                continue;
            }
            match op.width {
                8 => emit(code, enc_str_imm(Reg(r), Reg(16), 0)),
                4 => emit(code, enc_str32_imm(Reg(r), Reg(16), 0)),
                2 => emit(code, enc_strh_imm(Reg(r), Reg(16), 0)),
                1 => emit(code, super::encode::enc_strb_imm(Reg(r), Reg(16), 0)),
                _ => return false,
            }
        }
        true
    };
    // Restore the saved registers; only the naked carve moves sp back.
    let emit_restore = |code: &mut Vec<u8>| {
        for (j, &r) in save_list.iter().enumerate() {
            reg_ldr_x(code, Reg(r), save_off(j));
        }
        for (k, &r) in fp_save_list.iter().enumerate() {
            reg_ldr_d(code, r, fp_save_off(k));
        }
        if carve {
            emit(code, enc_add_imm(Reg(31), Reg(31), size));
        }
    };
    if size > 0 {
        a64_align_asm_stream(code, text_data_ranges, &mut map_state);
    }
    let exit_start = code.len();
    if !emit_outputs(code) {
        bail_msg("aarch64 inline asm: unsupported output width");
        return false;
    }
    emit_restore(code);
    // `asm goto`: each `%lK` branch leaves mid-template, before the
    // store-backs and restore just emitted on the fall-through path, so
    // it lands on a trampoline that repeats them and branches to the
    // label's block through the enclosing function's branch fixups. A
    // label whose target is the fall-through block reuses the
    // fall-through exit sequence instead.
    if let Some(ctx) = goto_ctx {
        let mut tramp_at: Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
        // Label indices needing a restore trampoline. With no exit work, a
        // `%lK` reference -- a template or replacement (`.subsection`) branch,
        // or a section data field -- names its block directly; with captures
        // or saves, every one routes through the trampolines built here, so a
        // branch a run-time patcher plants from a section field runs the same
        // store-backs and restores a template branch does.
        let mut tramp_ks: Vec<usize> = Vec::new();
        if size > 0 {
            tramp_ks.extend(goto_sites.iter().map(|&(_, _, k)| k));
            tramp_ks.extend(deferred_goto_sites.iter().map(|&(_, _, k)| k as usize));
            tramp_ks.extend(data_goto_ks.borrow().iter().copied());
        }
        if tramp_ks.iter().any(|&k| ctx.row[1 + k] != ctx.row[0]) {
            let skip_site = code.len();
            emit(code, 0); // b over the trampolines, patched below
            for &k in &tramp_ks {
                if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                    continue;
                }
                tramp_at[k] = Some(code.len());
                if !emit_outputs(code) {
                    bail_msg("aarch64 inline asm: unsupported output width");
                    return false;
                }
                emit_restore(code);
                ctx.branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target: ctx.row[1 + k],
                    kind: LocalBranchKind::B,
                });
                emit(code, super::encode::enc_b(0));
            }
            let words = ((code.len() - skip_site) / 4) as i32;
            let word = super::encode::enc_b(words);
            code[skip_site..skip_site + 4].copy_from_slice(&word.to_le_bytes());
        }
        for &(site, ref kind, k) in &goto_sites {
            if size == 0 {
                ctx.direct_goto.push(AsmGotoDirectBranch {
                    site,
                    kind: *kind,
                    target: ctx.row[1 + k],
                });
                continue;
            }
            let target = tramp_at[k].unwrap_or(exit_start);
            match label_branch_word(kind, target as i64 - site as i64) {
                Ok(word) => code[site..site + 4].copy_from_slice(&word.to_le_bytes()),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
        }
        // Record each out-of-line replacement `%lK` branch for the placement
        // pass, where the region base is known. With an operand frame it routes
        // through the teardown trampoline (or the fall-through exit when the
        // label is the fall-through block); frameless, it targets the block
        // directly, matching a plain out-of-line branch.
        if let Some(idx) = deferred_idx {
            for &(region_off, kind, k) in &deferred_goto_sites {
                let k = k as usize;
                let target = if size == 0 {
                    DeferredGotoTarget::Block(ctx.row[1 + k])
                } else if ctx.row[1 + k] == ctx.row[0] {
                    DeferredGotoTarget::Code(exit_start)
                } else {
                    DeferredGotoTarget::Code(
                        tramp_at[k].expect("trampoline built for framed deferred goto"),
                    )
                };
                deferred_regions[idx as usize]
                    .goto_branches
                    .push(DeferredGotoBranch {
                        region_off,
                        kind,
                        target,
                    });
            }
        }
        // Rewrite this statement's section `%l` fields from the label's block
        // to its trampoline (or the fall-through exit) while exit work is
        // pending; frameless fields keep the block and resolve with the
        // function's layout (`resolve_asm_goto_relocs`).
        if size > 0 && !data_goto_ks.borrow().is_empty() {
            use crate::c5::asm::AsmSectionTarget;
            let ks = data_goto_ks.borrow();
            let target_of = |bid: u32| -> Option<usize> {
                ks.iter()
                    .find(|&&k| ctx.row.get(1 + k).copied() == Some(bid))
                    .map(|&k| tramp_at[k].unwrap_or(exit_start))
            };
            for (i, s) in asm_sections.relocs_mut().iter_mut().enumerate() {
                let start = sect_reloc_marks.get(i).copied().unwrap_or(0);
                for r in s.relocs.iter_mut().skip(start) {
                    if let AsmSectionTarget::TextBlock(bid) = r.target
                        && let Some(off) = target_of(bid)
                    {
                        r.target = AsmSectionTarget::Text(off);
                    }
                }
            }
        }
    } else if !deferred_goto_sites.is_empty() {
        bail_msg("aarch64 inline asm: `%l` label reference outside `asm goto`");
        return false;
    }
    *text_map_state = map_state;
    true
}

/// Resolve a template vector-view reference (`%N.T`, `%qN`, `{%N.T}`) to the
/// SIMD register assigned to operand N, requiring a `w` constraint.
fn resolve_fp_ref(
    op_reg: &[Option<u8>],
    asm: &super::super::ir::AsmBlock,
    idx: u8,
) -> Result<u8, alloc::string::String> {
    use super::super::ir::AsmConstraint;
    if !matches!(
        asm.operands.get(idx as usize).map(|o| o.constraint),
        Some(AsmConstraint::Fp)
    ) {
        return Err(alloc::string::String::from(
            "aarch64 inline asm: vector operand view on a non-`w` operand",
        ));
    }
    op_reg.get(idx as usize).copied().flatten().ok_or_else(|| {
        alloc::string::String::from("aarch64 inline asm: operand reference is not a register")
    })
}

/// Encode instruction lines in an executable file-scope inline-asm section
/// (`.pushsection .text,"ax"`) to machine bytes. A file-scope block has no
/// operands, so every instruction must be register-concrete.
pub(crate) fn encode_a64_file_asm_section_code(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    let conv = |o: &AsmOpndA64| -> Result<Opnd, alloc::string::String> {
        Ok(match *o {
            AsmOpndA64::Imm(v) => Opnd::Imm(v),
            AsmOpndA64::FpImm(v) => Opnd::FpImm(v),
            AsmOpndA64::Lsl(s) => Opnd::Lsl(s),
            AsmOpndA64::Shift { kind, amount } => Opnd::Shift { kind, amount },
            AsmOpndA64::Extend { option, amount } => Opnd::Extend { option, amount },
            AsmOpndA64::SysReg(f) => Opnd::SysReg(f),
            AsmOpndA64::SysOp(b) => Opnd::SysOp(b),
            AsmOpndA64::Cond(c) => Opnd::Cond(c),
            AsmOpndA64::Reg { num, is64, sp } => Opnd::Reg { num, is64, sp },
            AsmOpndA64::RegWb(num) => Opnd::RegWb(num),
            AsmOpndA64::VReg { num, is_d } => Opnd::VReg { num, is_d },
            AsmOpndA64::QReg(num) => Opnd::QReg(num),
            AsmOpndA64::VScalar { num, size } => Opnd::VScalar { num, size },
            AsmOpndA64::VecReg { num, size, q } => Opnd::VecReg { num, size, q },
            AsmOpndA64::VecElem { num, size, index } => Opnd::VecElem { num, size, index },
            AsmOpndA64::VecList {
                first,
                count,
                size,
                q,
            } => Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            AsmOpndA64::VecListLane {
                first,
                count,
                size,
                index,
            } => Opnd::VecListLane {
                first,
                count,
                size,
                index,
            },
            AsmOpndA64::Mem { base, off, pre } => match base {
                super::asm::MemBase::Reg(b) => Opnd::Mem { base: b, off, pre },
                super::asm::MemBase::Ref(_) => {
                    return Err(alloc::string::String::from(
                        "inline asm: operand reference in a file-scope section",
                    ));
                }
            },
            AsmOpndA64::MemReg {
                base,
                index,
                option,
                shift,
            } => match (base, index) {
                (super::asm::MemBase::Reg(b), super::asm::MemBase::Reg(i)) => Opnd::MemReg {
                    base: b,
                    index: i,
                    option,
                    shift,
                },
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: operand reference in a file-scope section",
                    ));
                }
            },
            _ => {
                return Err(alloc::string::String::from(
                    "inline asm: unsupported operand in a file-scope section",
                ));
            }
        })
    };
    // File-scope asm has no `asm goto` labels.
    encode_a64_asm_section_code(blocks, &conv, &|_| None)
}

/// Encode instruction lines in an executable inline-asm section
/// (`.pushsection .text,"ax"`) to machine bytes, replacing each `Code` item
/// with `CodeBytes`. `conv` resolves an operand to its table form: a
/// function-body block passes the enclosing template's converter, so a
/// pushed section may reference its operands; a file-scope block has none and
/// passes a register-concrete one. Everything else -- the literal pools, the
/// layout the operand expressions fold against, the symbol relocations -- is
/// the same in both positions.
pub(super) fn encode_a64_asm_section_code(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
) -> Result<(), alloc::string::String> {
    use super::table::{self, Opnd};
    use crate::c5::asm::AsmSectionItem;
    assign_a64_literal_pools(blocks)?;
    // An operand expression over labels is folded before its instruction is
    // encoded: on A64 the value selects the form -- a scaled or unscaled
    // offset, `movz` or `movn` -- which a relocation applied to a finished
    // word cannot.
    let measured = a64_section_operand_layout(blocks)?;
    a64_for_each_section_item_mut(blocks, &mut |key, site, item| {
        {
            let AsmSectionItem::Code(text) = item else {
                return Ok(());
            };
            let mut insns = super::asm::parse_template(text.as_bytes())
                .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
            if let Some(measured) = &measured {
                let mut here = site.and_then(|s| measured.place(s));
                for insn in &mut insns {
                    fold_a64_layout_operands(insn, key, here, measured)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    here = here.map(|h| h + a64_insn_placeholder_len(insn) as i64);
                }
            }
            let mut bytes: Vec<u8> = Vec::new();
            let mut relocs: Vec<crate::c5::asm::AsmSectionReloc> = Vec::new();
            for insn in &insns {
                if !insn.bytes.is_empty() {
                    bytes.extend_from_slice(&insn.bytes);
                    continue;
                }
                if insn.label_def.is_some() {
                    return Err(alloc::format!(
                        "inline asm: `{text}` in a section needs a relocation"
                    ));
                }
                // A branch (or `adr`) to an `asm goto` label (`b %l[k]`)
                // leaves the section for a block of the function. The word
                // carries a zero displacement; the relocation names the
                // block, rewritten to its text offset after layout.
                if let Some(&super::asm::AsmOpndA64::GotoLabel(k)) = insn.operands.last() {
                    let bid = goto_block(k).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: `%l{k}` names no `asm goto` label (section `{text}`)"
                        )
                    })?;
                    let branch = build_label_branch(insn, conv)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    let (word, kind) = a64_label_branch_reloc(&branch)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    relocs.push(crate::c5::asm::AsmSectionReloc {
                        offset: bytes.len() as u32,
                        width: 4,
                        kind,
                        pcrel: false,
                        branch: false,
                        signed: false,
                        target: crate::c5::asm::AsmSectionTarget::TextBlock(bid),
                        addend: 0,
                    });
                    bytes.extend_from_slice(&word.to_le_bytes());
                    continue;
                }
                if let Some((word, kind, expr)) = encode_a64_sym_insn(insn, conv)
                    .map_err(|m| alloc::format!("{m} (section `{text}`)"))?
                {
                    // An empty expression marks a `.`-relative form resolved
                    // in place: the word is final, no relocation.
                    if !expr.is_empty() {
                        relocs.push(crate::c5::asm::AsmSectionReloc {
                            offset: bytes.len() as u32,
                            width: 4,
                            kind,
                            pcrel: false,
                            branch: false,
                            signed: false,
                            target: crate::c5::asm::AsmSectionTarget::Expr(expr),
                            addend: 0,
                        });
                    }
                    bytes.extend_from_slice(&word.to_le_bytes());
                    continue;
                }
                let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
                for o in &insn.operands {
                    ops.push(conv(o).map_err(|m| alloc::format!("{m} (section `{text}`)"))?);
                }
                let word = table::encode(&insn.mnemonic, &ops)
                    .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                bytes.extend_from_slice(&word.to_le_bytes());
            }
            *item = AsmSectionItem::CodeBytes {
                bytes,
                relocs,
                short: None,
            };
        }
        Ok(())
    })
}

/// Visitor of [`a64_for_each_section_item_mut`]: the section identity key,
/// the item's `(block, item)` index where it has one, and the item.
type A64SectionItemFn<'a> = dyn FnMut(
        &str,
        Option<(usize, usize)>,
        &mut crate::c5::asm::AsmSectionItem,
    ) -> Result<(), alloc::string::String>
    + 'a;

/// Apply `f` to every item of the blocks with the identity key of the section
/// it lands in, descending into `.rept` bodies as the shared walk does. The
/// key is the section an operand expression folds against. `site` is the
/// item's `(block, item)` index, `None` inside a `.rept` body, whose items
/// the measurement walk does not place individually.
fn a64_for_each_section_item_mut(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
    f: &mut A64SectionItemFn<'_>,
) -> Result<(), alloc::string::String> {
    fn walk(
        key: &str,
        bi: usize,
        top: bool,
        items: &mut [crate::c5::asm::AsmSectionItem],
        f: &mut A64SectionItemFn<'_>,
    ) -> Result<(), alloc::string::String> {
        for (ii, it) in items.iter_mut().enumerate() {
            if let crate::c5::asm::AsmSectionItem::Rept { items, .. } = it {
                walk(key, bi, false, items, f)?;
            } else {
                f(key, top.then_some((bi, ii)), it)?;
            }
        }
        Ok(())
    }
    for (bi, b) in blocks.iter_mut().enumerate() {
        let key = crate::c5::asm::section_key(b);
        walk(&key, bi, true, &mut b.items, f)?;
    }
    Ok(())
}

/// The label layout an operand expression folds against, or `None` when no
/// operand in the blocks needs one. Each code statement measures as
/// placeholder bytes of its assembled length, which the parse gives: an A64
/// instruction is one word whatever its operands hold. Sections start at zero
/// rather than at the sink's current length, which the values this serves do
/// not depend on.
fn a64_section_operand_layout(
    blocks: &[crate::c5::asm::AsmSectionBlock],
) -> Result<Option<crate::c5::asm::SectionLabelOffsets>, alloc::string::String> {
    use super::asm::AsmOpndA64;
    use crate::c5::asm::AsmSectionItem;
    let mut sized = blocks.to_vec();
    let mut needs = false;
    a64_for_each_section_item_mut(&mut sized, &mut |_, _, item| {
        let AsmSectionItem::Code(text) = item else {
            return Ok(());
        };
        let insns = super::asm::parse_template(text.as_bytes())
            .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
        needs |= insns
            .iter()
            .flat_map(|i| &i.operands)
            .any(|o| matches!(o, AsmOpndA64::ImmExpr(_) | AsmOpndA64::MemExpr { .. }));
        let len = insns.iter().map(a64_insn_placeholder_len).sum();
        *item = AsmSectionItem::CodeBytes {
            bytes: alloc::vec![0u8; len],
            relocs: Vec::new(),
            short: None,
        };
        Ok(())
    })?;
    if !needs {
        return Ok(None);
    }
    crate::c5::asm::measure_asm_section_offsets(
        &sized,
        &|_| None,
        true,
        &crate::c5::asm::AsmSectionSink::default(),
    )
    .map(Some)
}

/// The bytes a parsed statement occupies before it is encoded: a label
/// definition none, an assembled A64 instruction one word, and a statement
/// the parse already resolved to bytes its own length. The operand fold
/// advances the location counter by this, as the sizing pass measures by it.
fn a64_insn_placeholder_len(i: &super::asm::AsmInsnA64) -> usize {
    match i {
        i if i.label_def.is_some() => 0,
        i if i.bytes.is_empty() => 4,
        i => i.bytes.len(),
    }
}

/// Replace each operand the section layout values with the constant it folds
/// to, so the encoder selects the form from the value as GNU as does. `here`
/// is the instruction's section offset, which its expressions read as the
/// location counter.
fn fold_a64_layout_operands(
    insn: &mut super::asm::AsmInsnA64,
    key: &str,
    here: Option<i64>,
    measured: &crate::c5::asm::SectionLabelOffsets,
) -> Result<(), alloc::string::String> {
    use super::asm::AsmOpndA64;
    let fold = |e: &str| crate::c5::asm::fold_asm_operand_expr(e, key, here, measured);
    for o in &mut insn.operands {
        let folded = match o {
            AsmOpndA64::ImmExpr(expr) => AsmOpndA64::Imm(fold(expr)?),
            AsmOpndA64::MemExpr { base, expr, pre } => AsmOpndA64::Mem {
                base: *base,
                off: fold(expr)?,
                pre: *pre,
            },
            _ => continue,
        };
        *o = folded;
    }
    Ok(())
}

/// The `movz` / `movk` word an `:abs_gN:` operand relocates, with a zero
/// immediate and the group's shift. A 32-bit destination clears the operand
/// size bit and admits only the two groups that fit its width, as GNU as
/// does.
fn a64_movw_placeholder(
    rd: u8,
    is64: bool,
    movk: bool,
    group: u8,
) -> Result<u32, alloc::string::String> {
    if !is64 && group > 1 {
        return Err(alloc::format!(
            "inline asm: `:abs_g{group}` is not allowed for a 32-bit register"
        ));
    }
    let word = if movk {
        super::encode::enc_movk(super::Reg(rd), 0, group)
    } else {
        super::encode::enc_movz(super::Reg(rd), 0, group)
    };
    Ok(if is64 { word } else { word & !(1 << 31) })
}

/// The register shape of `o` after operand-reference resolution, for the
/// helpers that select an encoding from the register class (`%0` resolves
/// to the operand's assigned register in a function body; file-scope code
/// has none and the operand is already concrete).
fn concrete_reg_shape(
    o: &super::asm::AsmOpndA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> super::asm::AsmOpndA64 {
    use super::asm::AsmOpndA64 as A;
    use super::table::Opnd;
    if matches!(o, A::Ref { .. } | A::RefQ(_)) {
        match conv(o) {
            Ok(Opnd::Reg { num, is64, sp }) => return A::Reg { num, is64, sp },
            Ok(Opnd::VReg { num, is_d }) => return A::VReg { num, is_d },
            Ok(Opnd::QReg(n)) => return A::QReg(n),
            _ => {}
        }
    }
    o.clone()
}

/// Encode a section or function-body instruction that references a symbol to
/// its placeholder word plus the relocation kind and symbol expression: `b` /
/// `bl` / `b.cond` / `cbz` / `cbnz` / `tbz` / `tbnz` / `adr` to a symbol,
/// `adrp`, `add ..., :lo12:`, a load/store with a `:lo12:` immediate, and the
/// `ldr` literal form. `Ok(None)` when the instruction references no symbol.
fn encode_a64_sym_insn(
    insn: &super::asm::AsmInsnA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> Result<Option<(u32, crate::c5::asm::AsmRelocKind, alloc::string::String)>, alloc::string::String>
{
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    use crate::c5::asm::AsmRelocKind as K;
    // `b sym` / `bl sym` carry the name on the instruction, not an operand.
    if let Some(name) = &insn.sym_target {
        if name.contains('%') {
            return Err(alloc::string::String::from(
                "inline asm: operand reference in a file-scope branch target",
            ));
        }
        let link = insn.mnemonic == "bl";
        let word = if link {
            super::encode::enc_bl(0)
        } else {
            super::encode::enc_b(0)
        };
        return Ok(Some((word, K::A64Branch26 { link }, name.clone())));
    }
    // A load/store whose immediate is `:lo12:sym`: encode with a zero
    // offset; the access size names the LDST reloc width.
    if let Some(AsmOpndA64::MemSymLo12 { base, expr }) = insn.operands.last() {
        let rt = insn.operands.first().map(|o| concrete_reg_shape(o, conv));
        let size = a64_access_size(&insn.mnemonic, rt.as_ref())?;
        let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
        for o in &insn.operands[..insn.operands.len() - 1] {
            ops.push(conv(o)?);
        }
        ops.push(conv(&AsmOpndA64::Mem {
            base: *base,
            off: 0,
            pre: false,
        })?);
        let word = super::table::encode(&insn.mnemonic, &ops)?;
        return Ok(Some((word, K::A64LdstLo12(size), expr.clone())));
    }
    // A numeric-label reference (`b 1b`) resolves at materialize time, where
    // this call's label offsets are known; carry it as a symbol reference.
    // `.`-relative branches encode directly.
    let named;
    let (name, spec) = match insn.operands.last() {
        Some(AsmOpndA64::Sym { expr, spec }) => (expr, *spec),
        Some(&AsmOpndA64::Label { num, forward }) => {
            named = alloc::format!("{num}{}", if forward { 'f' } else { 'b' });
            (&named, super::asm::SymSpec::Addr)
        }
        Some(&AsmOpndA64::Here(off)) => {
            let kind = build_label_branch(insn, conv)?;
            let word = match kind {
                LabelBranch::Adr { rd } => super::encode::enc_adr(super::Reg(rd), off),
                _ => label_branch_word(&kind, off as i64)?,
            };
            return Ok(Some((word, K::Data, alloc::string::String::new())));
        }
        _ => return Ok(None),
    };
    match spec {
        super::asm::SymSpec::Addr => {}
        super::asm::SymSpec::Lo12 => {
            // `add Rd, Rn, :lo12:sym`.
            if insn.mnemonic != "add" || insn.operands.len() != 3 {
                return Err(alloc::string::String::from(
                    "inline asm: `:lo12:` operand outside `add` or a load/store",
                ));
            }
            let (rd, rn) = match (conv(&insn.operands[0])?, conv(&insn.operands[1])?) {
                (Opnd::Reg { num: rd, .. }, Opnd::Reg { num: rn, .. }) => (rd, rn),
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `add :lo12:` needs register operands",
                    ));
                }
            };
            let word = super::encode::enc_add_imm(super::Reg(rd), super::Reg(rn), 0);
            return Ok(Some((word, K::A64AddLo12, name.clone())));
        }
        // `movz` / `movk` with `:abs_gN:`. The placeholder carries the
        // group's shift and a zero immediate, which is the word GNU as
        // leaves for the relocation to fill.
        super::asm::SymSpec::MovwAbs {
            group,
            signed,
            check,
        } => {
            let movk = match insn.mnemonic.as_str() {
                "movz" => false,
                "movk" => true,
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `:abs_g` operand outside `movz` or `movk`",
                    ));
                }
            };
            // `movk` has no `movn` counterpart, so it cannot carry a group
            // whose negative values need one.
            if movk && signed {
                return Err(alloc::string::String::from(
                    "inline asm: `:abs_g<n>_s:` is not allowed on `movk`",
                ));
            }
            let (rd, is64) = match conv(&insn.operands[0])? {
                Opnd::Reg { num, is64, .. } => (num, is64),
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `:abs_g` destination must be a register",
                    ));
                }
            };
            let word = a64_movw_placeholder(rd, is64, movk, group)?;
            return Ok(Some((
                word,
                K::A64MovwAbs {
                    group,
                    signed,
                    check,
                },
                name.clone(),
            )));
        }
    }
    match insn.mnemonic.as_str() {
        "adrp" => {
            let rd = match conv(&insn.operands[0])? {
                Opnd::Reg {
                    num, is64: true, ..
                } => num,
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `adrp` destination must be a 64-bit register",
                    ));
                }
            };
            Ok(Some((
                super::encode::enc_adrp(super::Reg(rd), 0),
                K::A64AdrpPage21,
                name.clone(),
            )))
        }
        // `ldr Rt, sym` / `ldrsw Xt, sym`: a PC-relative literal load.
        "ldr" | "ldrsw" if insn.operands.len() == 2 => {
            let rt = concrete_reg_shape(&insn.operands[0], conv);
            let (word, _) = a64_ldr_literal_word(&insn.mnemonic, &rt).ok_or_else(|| {
                alloc::string::String::from(
                    "inline asm: `ldr` literal needs a register destination",
                )
            })?;
            Ok(Some((word, K::A64LdrLit19, name.clone())))
        }
        _ => {
            // The branch shapes share the label-branch classifier.
            let kind = build_label_branch(insn, conv)?;
            let (word, k) = a64_label_branch_reloc(&kind)?;
            Ok(Some((word, k, name.clone())))
        }
    }
}

/// Placeholder word (zero displacement) and relocation kind of a branch or
/// `adr` classified by [`build_label_branch`]; the relocation fills the
/// displacement field.
fn a64_label_branch_reloc(
    kind: &LabelBranch,
) -> Result<(u32, crate::c5::asm::AsmRelocKind), alloc::string::String> {
    use crate::c5::asm::AsmRelocKind as K;
    Ok(match *kind {
        LabelBranch::B => (label_branch_word(kind, 0)?, K::A64Branch26 { link: false }),
        LabelBranch::Bl => (label_branch_word(kind, 0)?, K::A64Branch26 { link: true }),
        LabelBranch::BCond(_) | LabelBranch::Cb { .. } => {
            (label_branch_word(kind, 0)?, K::A64Condbr19)
        }
        LabelBranch::Tb { .. } => (label_branch_word(kind, 0)?, K::A64Tstbr14),
        LabelBranch::Adr { rd } => (super::encode::enc_adr(super::Reg(rd), 0), K::A64Adr21),
    })
}

/// Assign the literal pools of an asm statement's sections. Each
/// `ldr Rt, =value` takes an entry of the pending pool of its section and
/// subsection, sharing one with an earlier request of the same width and
/// value, and becomes a literal load of the entry's synthetic label.
/// `.ltorg` and the end of that subsection's content deposit what has
/// accumulated, which is where GNU as flushes.
fn assign_a64_literal_pools(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    use crate::c5::asm::{AsmPoolEntry, AsmSectionItem, literal_pool_key, subsection_order};
    if !blocks
        .iter()
        .flat_map(|b| &b.items)
        .any(|it| matches!(it, AsmSectionItem::Code(t) if t.contains('=')))
    {
        return Ok(());
    }
    let order = subsection_order(blocks);
    // Where each pool's last block sits in the layout order: the flush point
    // for whatever `.ltorg` left pending.
    let mut last_of: alloc::collections::BTreeMap<alloc::string::String, usize> =
        alloc::collections::BTreeMap::new();
    for (pos, &bi) in order.iter().enumerate() {
        last_of.insert(literal_pool_key(&blocks[bi]), pos);
    }
    let uniq = crate::c5::asm::next_asm_instance();
    let mut seq = 0u32;
    let mut pending: alloc::collections::BTreeMap<alloc::string::String, Vec<AsmPoolEntry>> =
        alloc::collections::BTreeMap::new();
    for (pos, &bi) in order.iter().enumerate() {
        let key = literal_pool_key(&blocks[bi]);
        for item in &mut blocks[bi].items {
            match item {
                AsmSectionItem::LiteralPool(entries) => {
                    *entries = pending.remove(&key).unwrap_or_default();
                }
                AsmSectionItem::Code(text) if text.contains('=') => {
                    let Some(eq) = text.find('=') else { continue };
                    let insns = super::asm::parse_template(text.as_bytes())
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    let pool_ops = insns
                        .iter()
                        .flat_map(|i| &i.operands)
                        .filter(|o| matches!(o, super::asm::AsmOpndA64::LitPool(_)))
                        .count();
                    if pool_ops == 0 {
                        continue;
                    }
                    if insns.len() != 1 || pool_ops != 1 || insns[0].operands.len() != 2 {
                        return Err(alloc::format!(
                            "inline asm: `{text}` is not a literal-pool load"
                        ));
                    }
                    let super::asm::AsmOpndA64::LitPool(expr) = &insns[0].operands[1] else {
                        return Err(alloc::format!(
                            "inline asm: `{text}` is not a literal-pool load"
                        ));
                    };
                    let (_, size) = a64_ldr_literal_word(&insns[0].mnemonic, &insns[0].operands[0])
                        .ok_or_else(|| {
                            alloc::format!("inline asm: `{text}` has no literal-pool load form")
                        })?;
                    let value = a64_pool_value(expr, size)?;
                    let entries = pending.entry(key.clone()).or_default();
                    let label = match entries.iter().find(|e| e.size == size && e.value == value) {
                        Some(e) => e.label.clone(),
                        None => {
                            let label = alloc::format!(".Lc5_ltorg_{uniq}_{seq}");
                            seq += 1;
                            entries.push(AsmPoolEntry {
                                size,
                                label: label.clone(),
                                value,
                            });
                            label
                        }
                    };
                    text.truncate(eq);
                    text.push_str(&label);
                }
                _ => {}
            }
        }
        if last_of.get(&key) == Some(&pos)
            && let Some(entries) = pending.remove(&key)
            && !entries.is_empty()
        {
            blocks[bi].items.push(AsmSectionItem::LiteralPool(entries));
        }
    }
    Ok(())
}

/// The value a `ldr Rt, =value` deposits: a constant truncated to the entry
/// width, or a link-time address the entry relocates to. GNU as has no
/// 16-byte relocation, so only the 4- and 8-byte entries take a symbol.
fn a64_pool_value(
    expr: &str,
    size: u8,
) -> Result<crate::c5::asm::AsmPoolValue, alloc::string::String> {
    use crate::c5::asm::AsmPoolValue;
    if let Some(v) = crate::c5::asm::eval_const_expr_wide(expr) {
        return Ok(AsmPoolValue::Const(v));
    }
    // The pool is assigned before layout, so a value here reduces to one
    // symbol and a constant; a label difference has nothing to fold against.
    let (name, addend) = super::asm::split_sym_addend(expr)
        .and_then(crate::c5::asm::asm_expr_sym_addend)
        .ok_or_else(|| alloc::format!("inline asm: bad literal-pool value `{expr}`"))?;
    if size == 16 {
        return Err(alloc::format!(
            "inline asm: literal-pool symbol `{name}` needs a 4- or 8-byte load"
        ));
    }
    Ok(AsmPoolValue::Sym { name, addend })
}

/// The LDR (literal) word for a destination register view, with the number
/// of bytes the load reads. `None` for a mnemonic or operand class that has
/// no literal form.
fn a64_ldr_literal_word(mnem: &str, rt: &super::asm::AsmOpndA64) -> Option<(u32, u8)> {
    use super::asm::AsmOpndA64 as O;
    Some(match (mnem, rt) {
        (
            "ldr",
            &O::Reg {
                num, is64: false, ..
            },
        ) => (0x1800_0000 | num as u32, 4),
        (
            "ldr",
            &O::Reg {
                num, is64: true, ..
            },
        ) => (0x5800_0000 | num as u32, 8),
        (
            "ldrsw",
            &O::Reg {
                num, is64: true, ..
            },
        ) => (0x9800_0000 | num as u32, 4),
        ("ldr", &O::VReg { num, is_d: false }) => (0x1C00_0000 | num as u32, 4),
        ("ldr", &O::VReg { num, is_d: true }) => (0x5C00_0000 | num as u32, 8),
        ("ldr", &O::QReg(num)) => (0x9C00_0000 | num as u32, 16),
        _ => return None,
    })
}

/// The access size in bytes of a load/store mnemonic, from the mnemonic's
/// width suffix or the register operand's class.
fn a64_access_size(
    mnem: &str,
    rt: Option<&super::asm::AsmOpndA64>,
) -> Result<u8, alloc::string::String> {
    use super::asm::AsmOpndA64;
    Ok(match mnem {
        "ldrb" | "strb" | "ldrsb" => 1,
        "ldrh" | "strh" | "ldrsh" => 2,
        "ldrsw" => 4,
        "ldr" | "str" => match rt {
            Some(AsmOpndA64::Reg { is64, .. }) => {
                if *is64 {
                    8
                } else {
                    4
                }
            }
            Some(AsmOpndA64::VReg { is_d, .. }) => {
                if *is_d {
                    8
                } else {
                    4
                }
            }
            Some(AsmOpndA64::QReg(_)) => 16,
            _ => {
                return Err(alloc::string::String::from(
                    "inline asm: `:lo12:` load/store needs a register operand",
                ));
            }
        },
        _ => {
            return Err(alloc::format!(
                "inline asm: `:lo12:` immediate on unsupported mnemonic `{mnem}`"
            ));
        }
    })
}
