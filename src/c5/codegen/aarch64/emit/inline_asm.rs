use super::*;

/// The `asm goto` context: the `jump_tables` row
/// `[fall_through, labels...]` and the function's branch-fixup lists. A
/// template `%lK` branch lands on a restore trampoline patched to the
/// label's block like any block-local branch; with no operand frame it is
/// recorded in `direct_goto` and patched to the block itself, so it and a
/// `.long %lK - .` section field name one address.
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

/// A deferred ALTERNATIVE replacement (`.subsection 1`): its encoded
/// bytes, appended to `.text` after the function body so the main
/// sequence does not fall into it, and each local label's offset within
/// them for the `.altinstructions` fields (`.word 663f - .`).
pub(super) struct DeferredAsmRegion {
    pub(super) bytes: alloc::vec::Vec<u8>,
    pub(super) labels: alloc::vec::Vec<(u32, usize)>,
    pub(super) goto_branches: alloc::vec::Vec<DeferredGotoBranch>,
    pub(super) sym_branches: alloc::vec::Vec<DeferredSymBranch>,
    /// Region-relative `(offset, length)` of each data run, recorded so the
    /// mapping symbols cover them once the region's text base is known.
    pub(super) data_ranges: alloc::vec::Vec<(usize, usize)>,
}

/// A replacement `b` / `bl` to a symbol: a zero placeholder word,
/// registered as a call fixup once the region's text base is known.
pub(super) struct DeferredSymBranch {
    pub(super) region_off: usize,
    pub(super) name: alloc::string::String,
    pub(super) is_call: bool,
}

/// A replacement `%l[...]` branch leaving the region; resolved once the
/// region base and the block layout are final.
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

/// Classify a label-branch instruction (`b` / `b.cond` / `cbz` / `cbnz`
/// / `tbz` / `tbnz` / `adr` with a local label, `.` or `%l[...]` target).
/// Register and bit operands go through `conv`, the table encoder's
/// converter, so the main stream and the replacement region admit the
/// same forms.
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

/// Encode an ALTERNATIVE `.subsection` replacement into a deferred
/// region. A branch to a local label or `.` resolves within the region
/// (the displacement is placement-invariant); a `%l[...]` branch is
/// returned as `(region offset, kind, label index)` for the caller to
/// resolve after layout; a symbol target would need a relocation at the
/// final offset and is rejected. `main_label` resolves a main-stream
/// label (`661b`) for the `.org` length expression.
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
            // `.` is the current region offset; a `Nb` label resolves in the region
            // (`663b`) or the main stream (`661b`). The expression uses only label
            // differences, so the main labels' absolute offsets cancel.
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
    // A forward reference binds the next definition after the branch, a
    // backward one the most recent at or before it (GNU as `Nf` / `Nb`).
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
/// state, as GNU as does in an executable section, and leave `state` on
/// instructions. The gap is under one instruction and is filled with
/// zeros as part of the data run it follows.
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

/// The output tables an inline-asm statement writes.
struct AsmSink<'a> {
    code: &'a mut Vec<u8>,
    fixups: &'a mut Vec<super::encode::Fixup>,
    asm_sections: &'a mut crate::c5::asm::AsmSectionSink,
    asm_extern_call_sites: &'a mut Vec<super::UserExternCallSite>,
    asm_sym_fixups: &'a mut Vec<super::AsmSymFixup>,
    deferred_regions: &'a mut Vec<DeferredAsmRegion>,
    text_data_ranges: &'a mut Vec<(usize, usize)>,
    text_align: &'a mut usize,
    asm_text_labels: &'a mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &'a mut Vec<super::AsmSectionTextRef>,
}

/// The unit's symbol tables a statement resolves names against.
#[derive(Clone, Copy)]
struct AsmSymbols<'a> {
    /// Function name -> entry PC, for a `bl` / `b` to a named symbol.
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
    /// `Inst::ImmData` value-id -> cross-TU data symbol name.
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// Internal-linkage data object name -> unified data offset.
    data_sym_offsets: &'a alloc::collections::BTreeMap<alloc::string::String, i64>,
}

/// A statement's operands with their assigned registers: what the
/// template substitution, the operand converter and the capture / load /
/// store-back sequences read.
struct AsmOperands<'a> {
    asm: &'a super::super::ir::AsmBlock,
    args: &'a [u32],
    func: &'a FunctionSsa,
    op_reg: Vec<Option<u8>>,
}

impl AsmOperands<'_> {
    /// The constant value of an `i`-class operand reference, if any.
    fn const_of(&self, idx: u8) -> Option<i64> {
        crate::c5::asm::asm_operand_const(self.func, *self.args.get(idx as usize)?)
    }

    fn operand_form(&self, idx: u8) -> alloc::string::String {
        self.args.get(idx as usize).map_or_else(
            || alloc::string::String::from("past the operand list"),
            |&a| crate::c5::asm::asm_operand_form(self.func, a),
        )
    }

    fn resolve_ref(&self, idx: u8) -> Option<u8> {
        self.op_reg.get(idx as usize).copied().flatten()
    }

    fn constraint(&self, idx: u8) -> Option<super::super::ir::AsmConstraint> {
        self.asm.operands.get(idx as usize).map(|o| o.constraint)
    }

    /// The GNU-as macro pass substitutes each operand reference with its
    /// register name -- the register the capture and write-back use.
    fn gas_subst(&self, tok: &str) -> Option<alloc::string::String> {
        use super::super::ir::AsmConstraint;
        let body = tok.strip_prefix('%')?;
        let (force, digits) = match body.as_bytes().first()? {
            b'w' => (Some(false), &body[1..]),
            b'x' => (Some(true), &body[1..]),
            b'c' | b'P' => {
                let idx: u8 = body[1..].parse().ok()?;
                return self.const_of(idx).map(|v| alloc::format!("{v}"));
            }
            _ => (None, body),
        };
        let idx: u8 = digits.parse().ok()?;
        let r = self.resolve_ref(idx)?;
        // A `Q` operand substitutes as `[xN]`, as the converter does for `%N`.
        if matches!(self.constraint(idx), Some(AsmConstraint::MemBase)) {
            return Some(alloc::format!("[x{r}]"));
        }
        let wide = self
            .asm
            .operands
            .get(idx as usize)
            .map(|o| o.width >= 8)
            .unwrap_or(true);
        Some(alloc::format!(
            "{}{}",
            if force.unwrap_or(wide) { 'x' } else { 'w' },
            r
        ))
    }

    /// A bare `%N` reference as a table operand: the assigned register in
    /// the view the constraint gives it, or an immediate operand's constant.
    fn conv_ref(
        &self,
        idx: u8,
        is64: Option<bool>,
    ) -> Result<super::table::Opnd, alloc::string::String> {
        use super::super::ir::AsmConstraint;
        use super::table::Opnd;
        use alloc::string::String;
        let Some(r) = self.resolve_ref(idx) else {
            if matches!(
                self.asm.operands[idx as usize].constraint,
                AsmConstraint::Imm | AsmConstraint::RegOrImm { .. }
            ) {
                return match self.const_of(idx) {
                    Some(v) => Ok(Opnd::Imm(v)),
                    None => Err(alloc::format!(
                        "aarch64 inline asm: non-constant immediate operand `%{idx}`: \
                         the operand is {}",
                        self.operand_form(idx)
                    )),
                };
            }
            return Err(String::from(
                "aarch64 inline asm: operand reference is not a register",
            ));
        };
        Ok(match self.asm.operands[idx as usize].constraint {
            // `%sN` selects the single view, `%dN` / bare the double.
            AsmConstraint::Fp => Opnd::VReg {
                num: r,
                is_d: is64.unwrap_or(true),
            },
            // A `Q` operand substitutes as `[xN]`.
            AsmConstraint::MemBase => Opnd::Mem {
                base: r,
                off: 0,
                pre: false,
            },
            _ => Opnd::Reg {
                num: r,
                is64: is64.unwrap_or(self.asm.operands[idx as usize].width >= 8),
                sp: false,
            },
        })
    }

    /// Resolve one symbolic operand to a table operand; label references
    /// have no table form and are handled by the branch path.
    fn conv(
        &self,
        o: &super::asm::AsmOpndA64,
    ) -> Result<super::table::Opnd, alloc::string::String> {
        use super::asm::AsmOpndA64;
        use super::table::Opnd;
        use alloc::string::String;
        Ok(match *o {
            AsmOpndA64::Imm(v) => Opnd::Imm(v),
            // `%cN` / `%PN`: the operand's compile-time constant, bare.
            AsmOpndA64::RefConst(idx) => match self.const_of(idx) {
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
            AsmOpndA64::Ref { idx, is64 } => self.conv_ref(idx, is64)?,
            // The vector views (`%N.T`, `%qN`, `{%N.T}`) name the SIMD file,
            // so they require a `w` operand.
            AsmOpndA64::RefVec { idx, size, q } => {
                let r = resolve_fp_ref(&self.op_reg, self.asm, idx)?;
                Opnd::VecReg { num: r, size, q }
            }
            AsmOpndA64::RefVecElem { idx, size, index } => {
                let r = resolve_fp_ref(&self.op_reg, self.asm, idx)?;
                Opnd::VecElem {
                    num: r,
                    size,
                    index,
                }
            }
            AsmOpndA64::RefVecList { idx, size, q } => {
                let r = resolve_fp_ref(&self.op_reg, self.asm, idx)?;
                Opnd::VecList {
                    first: r,
                    count: 1,
                    size,
                    q,
                }
            }
            AsmOpndA64::RefVecListLane { idx, size, index } => {
                let r = resolve_fp_ref(&self.op_reg, self.asm, idx)?;
                Opnd::VecListLane {
                    first: r,
                    count: 1,
                    size,
                    index,
                }
            }
            AsmOpndA64::RefQ(idx) => {
                let r = resolve_fp_ref(&self.op_reg, self.asm, idx)?;
                Opnd::QReg(r)
            }
            AsmOpndA64::Mem { base, off, pre } => {
                let base = match base {
                    super::asm::MemBase::Reg(n) => n,
                    super::asm::MemBase::Ref(idx) => {
                        let Some(r) = self.resolve_ref(idx) else {
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
                    super::asm::MemBase::Ref(idx) => self.resolve_ref(idx),
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
            // A trailing symbol operand goes through `encode_a64_sym_insn` first;
            // one reaching here is in an unsupported position.
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
    }

    /// A symbol name with its operand references substituted, which is what
    /// makes `__get_user_%c0` name `__get_user_4`.
    fn symbol_name(&self, name: &str) -> Result<alloc::string::String, alloc::string::String> {
        crate::c5::asm::resolve_asm_symbol_target(name, &crate::c5::asm::A64_SYMBOL_SUBST, &|i| {
            self.const_of(i)
        })
    }
}

/// The statement's scratch region: operand captures, then the saved GP
/// registers, then the saved FP registers, a 16-byte multiple in frame
/// storage (`Frame::asm_scratch_off`) so sp stays balanced for an
/// `asm goto` label reached by a run-time-patched branch, which bypasses
/// every exit path. A naked function has no frame and carves the region
/// from sp.
struct AsmRegion {
    frame: Frame,
    save_list: Vec<u8>,
    fp_save_list: Vec<u8>,
    /// Whether operand `i` has a capture slot: an immediate operand is
    /// substituted into the text and has no runtime storage.
    needs_cap: Vec<bool>,
    cap_slot: Vec<usize>,
    n_cap: usize,
    size: u32,
    carve: bool,
    region_base: u32,
    /// The carve moves sp under the allocator's sp-relative spill slots;
    /// frame storage leaves sp alone.
    spill_shift: u32,
}

impl AsmRegion {
    fn layout(ops: &AsmOperands, frame: Frame) -> Result<Self, alloc::string::String> {
        // The operand registers plus the clobber list; x16 / x17 are this
        // lowering's scratch and are reloaded after the template.
        let (used_mask, fp_used_mask) = asm_save_masks(ops.asm, &ops.op_reg, frame.fixed_regs)?;
        let save_list: Vec<u8> = (0u8..31).filter(|r| used_mask & (1 << r) != 0).collect();
        let fp_save_list: Vec<u8> = (0u8..8).filter(|r| fp_used_mask & (1 << r) != 0).collect();
        let n = ops.asm.operands.len();
        let needs_cap: Vec<bool> = ops.op_reg.iter().map(Option::is_some).collect();
        let mut cap_slot: Vec<usize> = alloc::vec![0; n];
        let mut n_cap = 0usize;
        for (i, &c) in needs_cap.iter().enumerate() {
            if c {
                cap_slot[i] = n_cap;
                n_cap += 1;
            }
        }
        let size = (((n_cap + save_list.len() + fp_save_list.len()) * 8) as u32 + 15) & !15;
        let carve = ops.func.is_naked && size > 0;
        let region_base = if carve {
            0
        } else {
            debug_assert!(
                size == 0 || (frame.asm_scratch_off + size as i64) <= 0,
                "inline asm without a frame scratch region"
            );
            (frame.frame_bytes as i64 + frame.asm_scratch_off) as u32
        };
        Ok(AsmRegion {
            frame,
            save_list,
            fp_save_list,
            needs_cap,
            cap_slot,
            n_cap,
            size,
            carve,
            region_base,
            spill_shift: if carve { size } else { 0 },
        })
    }

    /// The naked function's sp carve. An empty region means no entry or
    /// exit work at all.
    fn enter(&self, code: &mut Vec<u8>) -> Result<(), alloc::string::String> {
        if !self.carve {
            return Ok(());
        }
        if self.size > MAX_UNPROBED_STACK_STEP {
            return Err(alloc::string::String::from(
                "aarch64 inline asm: operand frame too large",
            ));
        }
        emit(code, enc_sub_imm(Reg(31), Reg(31), self.size));
        Ok(())
    }

    fn cap_off(&self, i: usize) -> u32 {
        self.region_base + (self.cap_slot[i] * 8) as u32
    }

    fn save_off(&self, j: usize) -> u32 {
        self.region_base + ((self.n_cap + j) * 8) as u32
    }

    fn fp_save_off(&self, k: usize) -> u32 {
        self.region_base + ((self.n_cap + self.save_list.len() + k) * 8) as u32
    }

    // Region slot accessors: the carve is always sp-based; frame storage
    // follows the spill addressing (sp-based, fp-based when `dynamic_sp`).
    fn ldr_x(&self, code: &mut Vec<u8>, rt: Reg, off: u32) {
        if self.carve {
            emit_sp_ldr_x(code, rt, off);
        } else {
            emit_spill_ldr_x(code, self.frame, rt, off);
        }
    }

    fn str_x(&self, code: &mut Vec<u8>, rt: Reg, off: u32) {
        if self.carve {
            emit_sp_str_x_auto(code, rt, off);
        } else {
            emit_spill_str_x_auto(code, self.frame, rt, off);
        }
    }

    fn ldr_d(&self, code: &mut Vec<u8>, dt: u8, off: u32) {
        if self.carve {
            emit_sp_ldr_d_auto(code, dt, off);
        } else {
            emit_spill_ldr_d_auto(code, self.frame, dt, off);
        }
    }

    fn str_d(&self, code: &mut Vec<u8>, dt: u8, off: u32) {
        if self.carve {
            emit_sp_str_d_auto(code, dt, off);
        } else {
            emit_spill_str_d_auto(code, self.frame, dt, off);
        }
    }

    /// Save the clobbered registers, then capture each operand's value
    /// (input) / address (output) -- both before any operand register is
    /// overwritten.
    fn emit_saves_and_captures(
        &self,
        code: &mut Vec<u8>,
        ops: &AsmOperands,
        alloc: &Allocation,
    ) -> Result<(), alloc::string::String> {
        use super::super::ir::AsmConstraint;
        for (j, &r) in self.save_list.iter().enumerate() {
            self.str_x(code, Reg(r), self.save_off(j));
        }
        for (k, &r) in self.fp_save_list.iter().enumerate() {
            self.str_d(code, r, self.fp_save_off(k));
        }
        for (i, &a) in ops.args.iter().enumerate() {
            if !self.needs_cap.get(i).copied().unwrap_or(true) {
                continue;
            }
            let Some(place) = alloc.places.get(a as usize).copied() else {
                return Err(alloc::string::String::from(
                    "aarch64 inline asm: operand place missing",
                ));
            };
            // A double `w` input captures its FP value; a 16-byte `w` operand's
            // SSA value is its address and captures like an integer operand.
            let op = &ops.asm.operands[i];
            if matches!(op.constraint, AsmConstraint::Fp) && !op.is_output && op.width == 8 {
                let Some(d) = materialize_fp_shifted(code, place, 16, self.frame, self.spill_shift)
                else {
                    return Err(alloc::string::String::from(
                        "aarch64 inline asm: `w` operand not a floating-point place",
                    ));
                };
                self.str_d(code, d, self.cap_off(i));
            } else {
                let Some(r) =
                    materialize_int_shifted(code, place, Reg(16), self.frame, self.spill_shift)
                else {
                    return Err(alloc::string::String::from(
                        "aarch64 inline asm: operand not an integer place",
                    ));
                };
                self.str_x(code, r, self.cap_off(i));
            }
        }
        Ok(())
    }

    /// Load inputs and memory addresses into their assigned registers; a
    /// `+` read-write output loads its current value from the destination
    /// address.
    fn emit_input_loads(
        &self,
        code: &mut Vec<u8>,
        ops: &AsmOperands,
    ) -> Result<(), alloc::string::String> {
        use super::super::ir::AsmConstraint;
        for (i, op) in ops.asm.operands.iter().enumerate() {
            let Some(r) = ops.op_reg[i] else { continue };
            if matches!(op.constraint, AsmConstraint::Fp) {
                // A 16-byte `w` operand (input or read-write output) loads the full q
                // register through its captured address; a read-write double output
                // loads its current value the same way.
                if op.width == 16 {
                    if !op.is_output || op.is_rw {
                        self.ldr_x(code, Reg(16), self.cap_off(i)); // x16 = operand address
                        emit(code, super::encode::enc_ldr_q_imm(r, Reg(16), 0));
                    }
                } else if !op.is_output {
                    self.ldr_d(code, r, self.cap_off(i));
                } else if op.is_rw {
                    self.ldr_x(code, Reg(16), self.cap_off(i)); // x16 = destination address
                    emit(code, super::encode::enc_ldr_d_imm(r, Reg(16), 0));
                }
                continue;
            }
            if matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase) || !op.is_output
            {
                self.ldr_x(code, Reg(r), self.cap_off(i));
            } else if op.is_rw {
                self.ldr_x(code, Reg(16), self.cap_off(i)); // x16 = destination address
                let word = match op.width {
                    8 => super::encode::enc_ldr_imm(Reg(r), Reg(16), 0),
                    4 => super::encode::enc_ldr32_imm(Reg(r), Reg(16), 0),
                    2 => super::encode::enc_ldrh_imm(Reg(r), Reg(16), 0),
                    1 => super::encode::enc_ldrb_imm(Reg(r), Reg(16), 0),
                    _ => {
                        return Err(alloc::string::String::from(
                            "aarch64 inline asm: unsupported read-write operand width",
                        ));
                    }
                };
                emit(code, word);
            }
        }
        Ok(())
    }

    /// Store the register outputs back through their captured addresses
    /// (x16 holds the address; the operand pool is untouched). `false` for
    /// an output width with no store form.
    fn emit_outputs(&self, code: &mut Vec<u8>, ops: &AsmOperands) -> bool {
        use super::super::ir::AsmConstraint;
        for (i, op) in ops.asm.operands.iter().enumerate() {
            if !op.is_output || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase)
            {
                continue;
            }
            let Some(r) = ops.op_reg[i] else { continue };
            self.ldr_x(code, Reg(16), self.cap_off(i));
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
                1 => emit(code, enc_strb_imm(Reg(r), Reg(16), 0)),
                _ => return false,
            }
        }
        true
    }

    /// Restore the saved registers; only the naked carve moves sp back.
    fn emit_restore(&self, code: &mut Vec<u8>) {
        for (j, &r) in self.save_list.iter().enumerate() {
            self.ldr_x(code, Reg(r), self.save_off(j));
        }
        for (k, &r) in self.fp_save_list.iter().enumerate() {
            self.ldr_d(code, r, self.fp_save_off(k));
        }
        if self.carve {
            emit(code, enc_add_imm(Reg(31), Reg(31), self.size));
        }
    }

    /// The store-backs and the restore: the exit sequence every path out
    /// of the template runs.
    fn emit_exit(
        &self,
        code: &mut Vec<u8>,
        ops: &AsmOperands,
    ) -> Result<(), alloc::string::String> {
        if !self.emit_outputs(code, ops) {
            return Err(alloc::string::String::from(
                "aarch64 inline asm: unsupported output width",
            ));
        }
        self.emit_restore(code);
        Ok(())
    }
}

/// The template text after the passes that run before the arch parser
/// sees it: comments stripped, `%=` expanded once so the code text and any
/// `.pushsection` content share one instance number, `.if` conditionals
/// reduced.
fn template_text(
    asm: &super::super::ir::AsmBlock,
) -> Result<alloc::string::String, alloc::string::String> {
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        return Err(alloc::string::String::from(
            "aarch64 inline asm: non-UTF8 template",
        ));
    };
    let stripped = crate::c5::asm::strip_asm_comments(raw_text, crate::c5::asm::AsmComments::A64);
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = crate::c5::asm::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    let reduced = crate::c5::asm::strip_asm_conditionals(text)?;
    Ok(alloc::string::String::from(
        reduced.as_deref().unwrap_or(text),
    ))
}

/// A branch site awaiting its label: `(site, kind, label, forward)`.
type LabelFixup = (usize, LabelBranch, u32, bool);

/// The main-stream template encoding: label definitions and every site
/// patched once the statement's layout is final.
struct TemplateStream<'a> {
    /// The template's intern table, telling an expression leaf apart from
    /// a symbol the stream cannot relocate.
    label_names: Vec<&'a str>,
    /// Local label definitions and the code offset each stands at.
    label_defs: Vec<(u32, usize)>,
    /// Branches to local labels, patched once the layout is final.
    label_fixups: Vec<LabelFixup>,
    /// Forward-referencing data fields over template labels:
    /// `(reference_site, field, width, expression)`.
    expr_fixups: Vec<(usize, usize, usize, alloc::string::String)>,
    /// Instruction operands over template labels, re-encoded once settled:
    /// `(site, mnemonic, operands, operand index, expression)`.
    insn_expr_fixups: Vec<(
        usize,
        alloc::string::String,
        Vec<super::table::Opnd>,
        usize,
        alloc::string::String,
    )>,
    /// `asm goto` label branches: `(site, kind, label_index)` per `%lK`
    /// reference.
    goto_sites: Vec<(usize, LabelBranch, usize)>,
    /// The mapping state; it spans the section, so a template ending in
    /// data pads only where an instruction follows.
    map_state: Option<super::super::map_syms::MapClass>,
}

impl<'a> TemplateStream<'a> {
    fn new(code_text: &'a str, map_state: Option<super::super::map_syms::MapClass>) -> Self {
        TemplateStream {
            label_names: crate::c5::asm::scan_label_names(code_text),
            label_defs: Vec::new(),
            label_fixups: Vec::new(),
            expr_fixups: Vec::new(),
            insn_expr_fixups: Vec::new(),
            goto_sites: Vec::new(),
            map_state,
        }
    }

    /// The offset a layout directive's expression reads for a label: a
    /// named label's index, a numeric one's number; only a definition
    /// already emitted resolves.
    fn label_offset(&self, name: &str) -> Option<i64> {
        let num = match self.label_names.iter().position(|&n| n == name) {
            Some(i) => crate::c5::asm::NAMED_LABEL_BASE + i as u32,
            None => name.strip_suffix(['b', 'f'])?.parse().ok()?,
        };
        self.label_defs
            .iter()
            .rfind(|&&(n, _)| n == num)
            .map(|&(_, off)| off as i64)
    }

    fn expr_value(&self, expr: &str, at: usize) -> Option<i64> {
        template_expr_value(expr, at, &self.label_defs, &self.label_names)
    }

    /// Resolve a numeric main-stream template label (`661b` / `662b`) to
    /// its emitted text offset; `Nb` (or bare `N`) binds the last
    /// definition, `Nf` the first.
    fn main_label_off(&self, name: &str) -> Option<usize> {
        let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
        if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        let num: u32 = digits.parse().ok()?;
        let mut defs = self.label_defs.iter().filter(|&&(n, _)| n == num);
        if name.ends_with('f') {
            defs.map(|&(_, off)| off).min()
        } else {
            defs.next_back().map(|&(_, off)| off)
        }
    }

    /// Encode each template instruction; raw-byte pieces emit verbatim.
    fn encode(
        &mut self,
        insns: &[super::asm::AsmInsnA64],
        ops: &AsmOperands,
        out: &mut AsmSink,
        syms: AsmSymbols,
        goto_row: Option<&[super::super::ir::BlockId]>,
    ) -> Result<(), alloc::string::String> {
        use super::super::map_syms::MapClass;
        use super::asm::AsmOpndA64;
        for insn in insns {
            if let Some(num) = insn.label_def {
                self.label_defs.push((num, out.code.len()));
                continue;
            }
            if let Some(item) = &insn.layout {
                self.encode_layout(item, ops, out)?;
                continue;
            }
            // Every item but a data directive lays down instructions (raw bytes
            // the parser encoded, `.inst`, an assembled mnemonic).
            let class =
                crate::c5::asm::data_directive_class(&insn.mnemonic).unwrap_or(MapClass::Code);
            if class == MapClass::Code {
                a64_align_asm_stream(out.code, out.text_data_ranges, &mut self.map_state);
            }
            self.map_state = Some(class);
            if !insn.bytes.is_empty() {
                if class == MapClass::Data {
                    out.text_data_ranges
                        .push((out.code.len(), insn.bytes.len()));
                }
                out.code.extend_from_slice(&insn.bytes);
                continue;
            }
            if let Some(w) = crate::c5::asm::data_directive_width(&insn.mnemonic) {
                self.encode_data_directive(insn, w, class, ops, out)?;
                continue;
            }
            if let Some(name) = &insn.sym_target {
                encode_sym_branch(insn, name, ops, out, syms)?;
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
                self.encode_label_branch(insn, goto_label, ops, out, goto_row)?;
                continue;
            }
            if encode_movw_abs(insn, ops, out)? {
                continue;
            }
            if matches!(
                insn.operands.last(),
                Some(AsmOpndA64::Sym { .. } | AsmOpndA64::MemSymLo12 { .. })
            ) {
                encode_sym_operand(insn, ops, out, syms)?;
                continue;
            }
            self.encode_table_insn(insn, ops, out)?;
        }
        Ok(())
    }

    /// A layout directive moves the location counter; the unit's whole text
    /// stream is the section GNU as resolves it against.
    fn encode_layout(
        &mut self,
        item: &crate::c5::asm::AsmSectionItem,
        ops: &AsmOperands,
        out: &mut AsmSink,
    ) -> Result<(), alloc::string::String> {
        let resolve = |name: &str| -> Option<i64> { self.label_offset(name) };
        let resolved = crate::c5::asm::resolve_align_item(item, &resolve)?;
        let item = resolved.as_ref().unwrap_or(item);
        let n = crate::c5::asm::push_a64_stream_layout(
            item,
            out.code,
            out.text_data_ranges,
            &resolve,
            &|i| ops.const_of(i),
        )?;
        *out.text_align = (*out.text_align).max(n as usize);
        self.map_state = crate::c5::asm::step_map_state(item, self.map_state, true);
        Ok(())
    }

    /// A data directive with operand references (`.long %c0`): each
    /// argument must resolve to a compile-time constant, emitted
    /// little-endian at the directive width.
    fn encode_data_directive(
        &mut self,
        insn: &super::asm::AsmInsnA64,
        w: usize,
        class: super::super::map_syms::MapClass,
        ops: &AsmOperands,
        out: &mut AsmSink,
    ) -> Result<(), alloc::string::String> {
        use super::super::map_syms::MapClass;
        use super::asm::AsmOpndA64;
        // `.word` is target-dependent: 4 bytes on AArch64.
        let w = if insn.mnemonic == ".word" { 4 } else { w };
        if class == MapClass::Data {
            out.text_data_ranges
                .push((out.code.len(), w * insn.operands.len()));
        }
        for o in &insn.operands {
            let v = match *o {
                AsmOpndA64::Imm(v) => v,
                AsmOpndA64::RefConst(idx) | AsmOpndA64::Ref { idx, .. } => {
                    match ops.const_of(idx) {
                        Some(v) => v,
                        None => {
                            return Err(alloc::string::String::from(
                                "aarch64 inline asm: non-constant data-directive value",
                            ));
                        }
                    }
                }
                // A value over template labels: the field width is the
                // directive's, so only the value waits on the layout.
                AsmOpndA64::ImmExpr(ref e) => match self.expr_value(e, out.code.len()) {
                    Some(v) => v,
                    None if crate::c5::asm::is_template_label_expr(e, &self.label_names) => {
                        self.expr_fixups
                            .push((out.code.len(), out.code.len(), w, e.clone()));
                        0
                    }
                    None => {
                        return Err(alloc::string::String::from(
                            "aarch64 inline asm: unsupported data-directive value",
                        ));
                    }
                },
                _ => {
                    return Err(alloc::string::String::from(
                        "aarch64 inline asm: unsupported data-directive value",
                    ));
                }
            };
            out.code.extend_from_slice(&(v as u64).to_le_bytes()[..w]);
        }
        Ok(())
    }

    /// A branch to a local label, `.`, or an `asm goto` label: a `.` target
    /// encodes at once; the other two take a placeholder word patched once
    /// the target offset is known.
    fn encode_label_branch(
        &mut self,
        insn: &super::asm::AsmInsnA64,
        goto_label: Option<u8>,
        ops: &AsmOperands,
        out: &mut AsmSink,
        goto_row: Option<&[super::super::ir::BlockId]>,
    ) -> Result<(), alloc::string::String> {
        use super::asm::AsmOpndA64;
        use alloc::string::String;
        let kind = build_label_branch(insn, &|o| ops.conv(o))?;
        if let Some(k) = goto_label {
            let Some(row) = goto_row else {
                return Err(String::from(
                    "aarch64 inline asm: `%l` label reference outside `asm goto`",
                ));
            };
            if 1 + k as usize >= row.len() {
                return Err(String::from(
                    "aarch64 inline asm: `%l` label index out of range",
                ));
            }
            if matches!(kind, LabelBranch::Adr { .. }) {
                return Err(String::from(
                    "aarch64 inline asm: adr cannot take an `asm goto` label",
                ));
            }
            self.goto_sites.push((out.code.len(), kind, k as usize));
            emit(out.code, 0);
            return Ok(());
        }
        if let Some(&AsmOpndA64::Here(off)) = insn.operands.last() {
            // `.` names the branch's own address, plus any offset.
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
            emit(out.code, word);
            return Ok(());
        }
        let Some(&AsmOpndA64::Label { num, forward }) = insn.operands.last() else {
            unreachable!("guard admits Label, Here or GotoLabel; the first two handled above");
        };
        self.label_fixups.push((out.code.len(), kind, num, forward));
        emit(out.code, 0);
        Ok(())
    }

    /// An assembled mnemonic. An operand expression over template labels
    /// resolves when every leaf is placed; a forward reference encodes zero
    /// and re-encodes once settled.
    fn encode_table_insn(
        &mut self,
        insn: &super::asm::AsmInsnA64,
        ops: &AsmOperands,
        out: &mut AsmSink,
    ) -> Result<(), alloc::string::String> {
        use super::asm::AsmOpndA64;
        use super::table::{self, Opnd};
        let mut table_ops: Vec<Opnd> = Vec::new();
        let mut pending: Option<(usize, alloc::string::String)> = None;
        for o in &insn.operands {
            if let AsmOpndA64::ImmExpr(e) = o
                && crate::c5::asm::is_template_label_expr(e, &self.label_names)
            {
                let v = self.expr_value(e, out.code.len());
                if v.is_none() {
                    pending = Some((table_ops.len(), e.clone()));
                }
                table_ops.push(Opnd::Imm(v.unwrap_or(0)));
                continue;
            }
            table_ops.push(ops.conv(o)?);
        }
        let site = out.code.len();
        emit(out.code, table::encode(&insn.mnemonic, &table_ops)?);
        if let Some((idx, expr)) = pending {
            self.insn_expr_fixups
                .push((site, insn.mnemonic.clone(), table_ops, idx, expr));
        }
        Ok(())
    }

    /// Settle the deferred expression fields and words: the layout is
    /// final, so a forward reference now has its definition.
    fn settle_expr_fixups(&self, out: &mut AsmSink) -> Result<(), alloc::string::String> {
        use super::table::{self, Opnd};
        for (site, at, width, expr) in &self.expr_fixups {
            let Some(v) = self.expr_value(expr, *site) else {
                return Err(alloc::format!(
                    "aarch64 inline asm: expression `{expr}` is not a constant"
                ));
            };
            out.code[*at..*at + *width].copy_from_slice(&(v as u64).to_le_bytes()[..*width]);
        }
        for (site, mnemonic, ops, idx, expr) in &self.insn_expr_fixups {
            let Some(v) = self.expr_value(expr, *site) else {
                return Err(alloc::format!(
                    "aarch64 inline asm: expression `{expr}` is not a constant"
                ));
            };
            let mut ops = ops.clone();
            ops[*idx] = Opnd::Imm(v);
            let word = table::encode(mnemonic, &ops)?;
            out.code[*site..*site + 4].copy_from_slice(&word.to_le_bytes());
        }
        Ok(())
    }

    /// Patch the label branches. A named label has one definition, so
    /// direction does not apply. A forward numeric reference with no
    /// in-stream definition may bind one in a pushed section (`jmp 6f`);
    /// those are returned for the section pass.
    fn patch_label_branches(
        &self,
        out: &mut AsmSink,
        has_sections: bool,
    ) -> Result<Vec<(usize, LabelBranch, u32)>, alloc::string::String> {
        let mut pending_xsec: Vec<(usize, LabelBranch, u32)> = Vec::new();
        for &(site, ref kind, num, forward) in &self.label_fixups {
            let target = if num >= crate::c5::asm::NAMED_LABEL_BASE {
                self.label_defs
                    .iter()
                    .find(|&&(n, _)| n == num)
                    .map(|&(_, o)| o)
            } else if forward {
                self.label_defs
                    .iter()
                    .find(|&&(n, off)| n == num && off > site)
                    .map(|&(_, off)| off)
            } else {
                self.label_defs
                    .iter()
                    .rev()
                    .find(|&&(n, off)| n == num && off <= site)
                    .map(|&(_, off)| off)
            };
            let Some(target) = target else {
                if num < crate::c5::asm::NAMED_LABEL_BASE && forward && has_sections {
                    pending_xsec.push((site, *kind, num));
                    continue;
                }
                return Err(alloc::string::String::from(
                    "aarch64 inline asm: undefined local label",
                ));
            };
            let delta = target as i64 - site as i64;
            // `adr` materializes a byte-granular PC-relative address
            // (rel21, unscaled), unlike the word-scaled branch offsets.
            let word = if let LabelBranch::Adr { rd } = *kind {
                if !(-(1i64 << 20)..(1i64 << 20)).contains(&delta) {
                    return Err(alloc::string::String::from(
                        "aarch64 inline asm: adr target out of +/-1MiB range",
                    ));
                }
                super::encode::enc_adr(Reg(rd), delta as i32)
            } else {
                label_branch_word(kind, delta)?
            };
            out.code[site..site + 4].copy_from_slice(&word.to_le_bytes());
        }
        Ok(pending_xsec)
    }

    /// A named label defined in the main stream is a definition of the
    /// unit, as under GNU as: the writers emit a `.text` symbol for it. `.L`
    /// names are assembler-local.
    fn record_named_labels(&self, out: &mut AsmSink) -> Result<(), alloc::string::String> {
        for &(num, off) in &self.label_defs {
            let Some(idx) = num.checked_sub(crate::c5::asm::NAMED_LABEL_BASE) else {
                continue;
            };
            let Some(&name) = self.label_names.get(idx as usize) else {
                continue;
            };
            if crate::c5::asm::is_local_label(name) {
                continue;
            }
            // One definition per name across the unit, as in GNU as.
            if out.asm_text_labels.iter().any(|l| l.name == name) {
                return Err(alloc::format!(
                    "inline asm: symbol `{name}` is already defined"
                ));
            }
            out.asm_text_labels.push(super::AsmTextLabel {
                name: alloc::string::String::from(name),
                text_offset: off,
            });
        }
        Ok(())
    }
}

/// A direct `bl` / `b` to a symbol: a fixup the post-pass patches to a
/// rel26 once every function's address is final, or a call relocation
/// for a name this unit does not define.
fn encode_sym_branch(
    insn: &super::asm::AsmInsnA64,
    name: &str,
    ops: &AsmOperands,
    out: &mut AsmSink,
    syms: AsmSymbols,
) -> Result<(), alloc::string::String> {
    let is_call = insn.mnemonic == "bl";
    let (kind, word) = if is_call {
        (BranchKind::Bl, super::encode::enc_bl(0))
    } else {
        (BranchKind::B, super::encode::enc_b(0))
    };
    let name = ops.symbol_name(name)?;
    let native_offset = out.code.len();
    match syms.name2entpc.get(name.as_str()) {
        Some(&ent_pc) => out.fixups.push(Fixup {
            native_offset,
            target_ent_pc: ent_pc,
            kind,
        }),
        None => out.asm_extern_call_sites.push(super::UserExternCallSite {
            instr_offset: native_offset,
            symbol_name: name.clone(),
            is_tail: !is_call,
        }),
    }
    emit(out.code, word);
    Ok(())
}

/// `movz` / `movk` with `:abs_gN:` over an expression that folds: a
/// function body has no layout pass, so only a constant resolves, and it
/// takes the same field encoding the section path applies. `Ok(false)`
/// when the instruction is not of that shape.
fn encode_movw_abs(
    insn: &super::asm::AsmInsnA64,
    ops: &AsmOperands,
    out: &mut AsmSink,
) -> Result<bool, alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    use alloc::string::String;
    let Some(AsmOpndA64::Sym {
        expr,
        spec:
            super::asm::SymSpec::MovwAbs {
                group,
                signed,
                check,
            },
    }) = insn.operands.last()
    else {
        return Ok(false);
    };
    if !matches!(insn.mnemonic.as_str(), "movz" | "movk") {
        return Ok(false);
    }
    let Some(v) = crate::c5::asm::eval_const_expr_ops(expr, &|_| None) else {
        return Ok(false);
    };
    let (rd, is64) = match ops.conv(&insn.operands[0]) {
        Ok(Opnd::Reg { num, is64, .. }) => (num, is64),
        _ => {
            return Err(String::from(
                "aarch64 inline asm: `:abs_g` destination must be a register",
            ));
        }
    };
    let movk = insn.mnemonic == "movk";
    if movk && *signed {
        return Err(String::from(
            "aarch64 inline asm: `:abs_g<n>_s:` is not allowed on `movk`",
        ));
    }
    let word =
        a64_movw_placeholder(rd, is64, movk, *group).map_err(|m| alloc::format!("aarch64 {m}"))?;
    let word = super::patch::movw_const_word(word, *group, *signed, *check, v)
        .map_err(|m| alloc::format!("aarch64 inline asm: {m}"))?;
    emit(out.code, word);
    Ok(true)
}

/// A symbol operand (`adrp`, `add :lo12:`, a `:lo12:` load/store,
/// `:abs_gN:`, a branch / `adr` / literal `ldr` naming a symbol) takes
/// the section path's encoder and records a relocation against the
/// name.
fn encode_sym_operand(
    insn: &super::asm::AsmInsnA64,
    ops: &AsmOperands,
    out: &mut AsmSink,
    syms: AsmSymbols,
) -> Result<(), alloc::string::String> {
    let (word, kind, expr) = match encode_a64_sym_insn(insn, &|o| ops.conv(o)) {
        Ok(Some(t)) => t,
        Ok(None) => {
            return Err(alloc::string::String::from(
                "aarch64 inline asm: unsupported symbol operand",
            ));
        }
        Err(m) => return Err(alloc::format!("aarch64 {m}")),
    };
    // A function body has no section layout, so only `sym + constant`
    // resolves here; a label-difference expression does not.
    let Some((name, addend)) = crate::c5::asm::asm_expr_sym_addend(&expr) else {
        return Err(alloc::format!(
            "aarch64 inline asm: operand expression `{expr}` needs a section layout"
        ));
    };
    let target = match syms.data_sym_offsets.get(name.as_str()) {
        Some(&off) => crate::c5::asm::AsmSectionTarget::Data(off as u64),
        None => crate::c5::asm::AsmSectionTarget::Symbol(name),
    };
    out.asm_sym_fixups.push(super::AsmSymFixup {
        instr_offset: out.code.len(),
        kind,
        target,
        addend,
    });
    emit(out.code, word);
    Ok(())
}

/// Materialize the `.pushsection` blocks now that every label's text
/// offset is known: a numeric template label resolves to its offset
/// (into the deferred region for `663f` / `664f`), any other name is a
/// symbol relocation, and an `i`-class operand naming a link-time data
/// address relocates against the data image. A deferred main-stream
/// branch to a section definition takes an instruction-field relocation
/// against the section.
#[allow(clippy::too_many_arguments)]
fn materialize_sections(
    section_blocks: &[crate::c5::asm::AsmSectionBlock],
    stream: &TemplateStream,
    deferred_idx: Option<u32>,
    pending_xsec: Vec<(usize, LabelBranch, u32)>,
    ops: &AsmOperands,
    out: &mut AsmSink,
    syms: AsmSymbols,
    goto_block: &dyn Fn(u8) -> Option<u32>,
) -> Result<(), alloc::string::String> {
    use crate::c5::asm::LabelLoc;
    let deferred_labels = deferred_idx.map(|r| &out.deferred_regions[r as usize].labels);
    let label_off = |name: &str| -> Option<LabelLoc> {
        if let Some(region) = deferred_idx
            && let Some(labels) = deferred_labels
        {
            let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
            if let Ok(num) = digits.parse::<u32>() {
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
        stream.main_label_off(name).map(LabelLoc::Text)
    };
    let operand_sym = |idx: u8| -> Option<(crate::c5::asm::AsmSectionTarget, i64)> {
        crate::c5::asm::asm_operand_data_target(ops.func, *ops.args.get(idx as usize)?, &|vid| {
            syms.extern_data_names.get(&vid).cloned()
        })
    };
    let resolver = crate::c5::asm::AsmOperandResolver {
        const_of: &|idx| ops.const_of(idx),
        symbol_of: &operand_sym,
        form: &|idx| ops.operand_form(idx),
    };
    // An `asm goto` label field resolves to its block index; the reloc is
    // rewritten to the text offset after layout
    // (`resolve_asm_goto_relocs`).
    let defined = crate::c5::asm::materialize_asm_sections(
        section_blocks,
        &resolver,
        &label_off,
        goto_block,
        true,
        out.asm_sections,
    )?;
    for (site, kind, num) in pending_xsec {
        let name = alloc::format!("{num}");
        let Some(d) = defined.iter().find(|d| d.name == name) else {
            return Err(alloc::string::String::from(
                "aarch64 inline asm: undefined local label",
            ));
        };
        let (word, rkind) = a64_label_branch_reloc(&kind)?;
        out.code[site..site + 4].copy_from_slice(&word.to_le_bytes());
        out.asm_section_text_refs.push(super::AsmSectionTextRef {
            instr_offset: site,
            section_index: d.section_index,
            section_offset: d.offset,
            addend: 0,
            absolute: false,
            kind: rkind,
        });
    }
    Ok(())
}

/// `asm goto` exits. A `%lK` branch leaves mid-template, before the
/// store-backs and restore, so with exit work it lands on a trampoline
/// that repeats them and branches to the label's block through the
/// function's branch fixups (the fall-through block reuses the
/// fall-through exit). With no exit work every reference names its
/// block directly.
#[allow(clippy::too_many_arguments)]
fn emit_goto_exits(
    ctx: AsmGotoCtxA64<'_>,
    region: &AsmRegion,
    ops: &AsmOperands,
    stream: &TemplateStream,
    deferred_idx: Option<u32>,
    deferred_goto_sites: &[(usize, LabelBranch, u8)],
    data_goto_ks: &[usize],
    sect_reloc_marks: &[usize],
    exit_start: usize,
    out: &mut AsmSink,
) -> Result<(), alloc::string::String> {
    let size = region.size;
    let mut tramp_at: Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
    let mut tramp_ks: Vec<usize> = Vec::new();
    if size > 0 {
        tramp_ks.extend(stream.goto_sites.iter().map(|&(_, _, k)| k));
        tramp_ks.extend(deferred_goto_sites.iter().map(|&(_, _, k)| k as usize));
        tramp_ks.extend(data_goto_ks.iter().copied());
    }
    if tramp_ks.iter().any(|&k| ctx.row[1 + k] != ctx.row[0]) {
        let skip_site = out.code.len();
        emit(out.code, 0); // b over the trampolines, patched below
        for &k in &tramp_ks {
            if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                continue;
            }
            tramp_at[k] = Some(out.code.len());
            region.emit_exit(out.code, ops)?;
            ctx.branch_fixups.push(BranchFixup {
                site: out.code.len(),
                target: ctx.row[1 + k],
                kind: LocalBranchKind::B,
            });
            emit(out.code, super::encode::enc_b(0));
        }
        let words = ((out.code.len() - skip_site) / 4) as i32;
        let word = super::encode::enc_b(words);
        out.code[skip_site..skip_site + 4].copy_from_slice(&word.to_le_bytes());
    }
    for &(site, ref kind, k) in &stream.goto_sites {
        if size == 0 {
            ctx.direct_goto.push(AsmGotoDirectBranch {
                site,
                kind: *kind,
                target: ctx.row[1 + k],
            });
            continue;
        }
        let target = tramp_at[k].unwrap_or(exit_start);
        let word = label_branch_word(kind, target as i64 - site as i64)?;
        out.code[site..site + 4].copy_from_slice(&word.to_le_bytes());
    }
    // Each out-of-line replacement `%lK` branch is recorded for the
    // placement pass, where the region base is known.
    if let Some(idx) = deferred_idx {
        for &(region_off, kind, k) in deferred_goto_sites {
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
            out.deferred_regions[idx as usize]
                .goto_branches
                .push(DeferredGotoBranch {
                    region_off,
                    kind,
                    target,
                });
        }
    }
    // Section `%l` fields move from the block to its trampoline while exit
    // work is pending; frameless ones keep the block.
    if size > 0 && !data_goto_ks.is_empty() {
        use crate::c5::asm::AsmSectionTarget;
        let target_of = |bid: u32| -> Option<usize> {
            data_goto_ks
                .iter()
                .find(|&&k| ctx.row.get(1 + k).copied() == Some(bid))
                .map(|&k| tramp_at[k].unwrap_or(exit_start))
        };
        for (i, s) in out.asm_sections.relocs_mut().iter_mut().enumerate() {
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
    Ok(())
}

/// Lower an `Inst::InlineAsm` (GCC extended asm): assign each register
/// operand a register, save the registers the block overwrites, capture
/// the operand values / addresses, load the inputs, encode the template
/// through the table encoder, store the outputs back. x16 / x17 are the
/// bridge scratch, so the operand pool is x0..x15. `goto_ctx` is present
/// for `asm goto`.
#[allow(clippy::too_many_arguments)]
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
    // A statement that lowers to nothing needs no staging;
    // `asm_scratch_bytes` reserved none.
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::A64) {
        return true;
    }
    let mut out = AsmSink {
        code,
        fixups,
        asm_sections,
        asm_extern_call_sites,
        asm_sym_fixups,
        deferred_regions,
        text_data_ranges,
        text_align,
        asm_text_labels,
        asm_section_text_refs,
    };
    let syms = AsmSymbols {
        name2entpc,
        extern_data_names,
        data_sym_offsets,
    };
    match lower_inline_asm(
        &mut out,
        asm,
        args,
        func,
        alloc,
        frame,
        syms,
        *text_map_state,
        goto_ctx,
    ) {
        Ok(map_state) => {
            *text_map_state = map_state;
            true
        }
        Err(m) => {
            bail_msg(&m);
            false
        }
    }
}

/// The body of [`emit_inline_asm_aarch64`]; the mapping state it returns
/// is the stream's after the statement.
#[allow(clippy::too_many_arguments)]
fn lower_inline_asm(
    out: &mut AsmSink,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    syms: AsmSymbols,
    map_state: Option<super::super::map_syms::MapClass>,
    goto_ctx: Option<AsmGotoCtxA64<'_>>,
) -> Result<Option<super::super::map_syms::MapClass>, alloc::string::String> {
    use super::asm::{assign_operand_regs, parse_template};
    let text = template_text(asm)?;
    // The GNU-as macro pass substitutes each reference with its register.
    let ops = AsmOperands {
        asm,
        args,
        func,
        op_reg: assign_operand_regs(
            &asm.operands,
            asm.clobber_regs | frame.fixed_regs.gpr,
            asm.clobber_fp_regs | frame.fixed_regs.fpr,
            &|i| crate::c5::asm::asm_operand_const(func, *args.get(i)?),
        )?,
    };
    let gas = crate::c5::asm::expand_asm_gas_macros(&text, 4, &|tok| ops.gas_subst(tok))?;
    let text = gas.as_deref().unwrap_or(&text);
    // An ALTERNATIVE `.subsection` replacement becomes a deferred region
    // appended after the function body.
    let (main_text, deferred_text) = crate::c5::asm::split_asm_subsections(text);
    let extracted = crate::c5::asm::extract_asm_sections(&main_text, true)?;
    let (code_owned, mut section_blocks, sym_items) = match extracted {
        Some(ex) => (Some(ex.code), ex.blocks, ex.sym_items),
        None => (None, Vec::new(), Vec::new()),
    };
    let code_text: &str = code_owned.as_deref().unwrap_or(&main_text);
    crate::c5::asm::reject_unit_symbol_items(&section_blocks)?;
    // The template's symbol directives declare names of the unit; the
    // object writer applies them, where every definition is known.
    out.asm_sections.push_sym_decls(&sym_items)?;
    let insns = parse_template(code_text.as_bytes())?;
    let region = AsmRegion::layout(&ops, frame)?;
    // An empty region means no entry or exit work.
    let mut stream = TemplateStream::new(code_text, map_state);
    if region.size > 0 {
        a64_align_asm_stream(out.code, out.text_data_ranges, &mut stream.map_state);
    }
    region.enter(out.code)?;
    region.emit_saves_and_captures(out.code, &ops, alloc)?;
    region.emit_input_loads(out.code, &ops)?;
    // `%lK` indices the section items reference; with exit work their
    // relocs are rewritten to the trampoline a template branch takes.
    let goto_row: Option<&[super::super::ir::BlockId]> = goto_ctx.as_ref().map(|c| c.row);
    let data_goto_ks = core::cell::RefCell::new(Vec::<usize>::new());
    let goto_block = |idx: u8| -> Option<u32> {
        let bid = goto_row?.get(1 + idx as usize).copied()?;
        data_goto_ks.borrow_mut().push(idx as usize);
        Some(bid)
    };
    // A pushed section's instructions assemble before layout, through the
    // template's converter so they may reference its operands.
    if !section_blocks.is_empty() {
        encode_a64_asm_section_code(&mut section_blocks, &|o| ops.conv(o), &goto_block)?;
    }
    stream.encode(&insns, &ops, out, syms, goto_row)?;
    stream.settle_expr_fixups(out)?;
    let pending_xsec = stream.patch_label_branches(out, !section_blocks.is_empty())?;
    stream.record_named_labels(out)?;
    // The replacement's `.org` length assertion reads the main labels.
    let mut deferred_goto_sites: Vec<(usize, LabelBranch, u8)> = Vec::new();
    let deferred_idx: Option<u32> = if deferred_text.is_empty() {
        None
    } else {
        let (region, gotos) = encode_deferred_asm_region(
            &deferred_text,
            &|o| ops.conv(o),
            &|name| stream.main_label_off(name),
            &|name| ops.symbol_name(name),
        )?;
        let idx = out.deferred_regions.len() as u32;
        out.deferred_regions.push(region);
        deferred_goto_sites = gotos;
        Some(idx)
    };
    // The per-section reloc counts before this statement's contribution
    // bound the trampoline rewrite to this statement's relocs.
    let sect_reloc_marks: Vec<usize> = if goto_ctx.is_some() && region.size > 0 {
        out.asm_sections
            .relocs_mut()
            .iter()
            .map(|s| s.relocs.len())
            .collect()
    } else {
        Vec::new()
    };
    if !section_blocks.is_empty() {
        materialize_sections(
            &section_blocks,
            &stream,
            deferred_idx,
            pending_xsec,
            &ops,
            out,
            syms,
            &goto_block,
        )?;
    }
    // The fall-through exit: outputs are stored on every exit path (GCC 11
    // output semantics), so the sequence repeats on each goto trampoline.
    if region.size > 0 {
        a64_align_asm_stream(out.code, out.text_data_ranges, &mut stream.map_state);
    }
    let exit_start = out.code.len();
    region.emit_exit(out.code, &ops)?;
    match goto_ctx {
        Some(ctx) => emit_goto_exits(
            ctx,
            &region,
            &ops,
            &stream,
            deferred_idx,
            &deferred_goto_sites,
            &data_goto_ks.borrow(),
            &sect_reloc_marks,
            exit_start,
            out,
        )?,
        None if !deferred_goto_sites.is_empty() => {
            return Err(alloc::string::String::from(
                "aarch64 inline asm: `%l` label reference outside `asm goto`",
            ));
        }
        None => {}
    }
    Ok(stream.map_state)
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

/// Encode the instruction lines of an executable inline-asm section to
/// bytes, replacing each `Code` item with `CodeBytes`. `conv` is the
/// enclosing template's converter for a function-body block and a
/// register-concrete one for a file-scope block; the literal pools, the
/// layout and the symbol relocations are the same in both.
pub(super) fn encode_a64_asm_section_code(
    blocks: &mut [crate::c5::asm::AsmSectionBlock],
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
) -> Result<(), alloc::string::String> {
    use super::table::{self, Opnd};
    use crate::c5::asm::AsmSectionItem;
    assign_a64_literal_pools(blocks)?;
    // An operand expression over labels is folded before encoding: on A64
    // the value selects the form (scaled or unscaled offset, `movz` or
    // `movn`), which a relocation on a finished word cannot.
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
                // A branch or `adr` to an `asm goto` label leaves the section: a zero
                // displacement and a relocation naming the block, rewritten after
                // layout.
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

/// Apply `f` to every item with the identity key of its section,
/// descending into `.rept` bodies; `site` is the item's `(block, item)`
/// index, `None` inside a `.rept` body.
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

/// The label layout an operand expression folds against, or `None` when
/// none needs one. Each code statement measures as its assembled length
/// (one word per A64 instruction); sections start at zero, which the
/// values served do not depend on.
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

/// The bytes a parsed statement occupies: none for a label definition,
/// one word for an instruction, its own length for a statement the
/// parse resolved to bytes.
fn a64_insn_placeholder_len(i: &super::asm::AsmInsnA64) -> usize {
    match i {
        i if i.label_def.is_some() => 0,
        i if i.bytes.is_empty() => 4,
        i => i.bytes.len(),
    }
}

/// Replace each operand the section layout values with its constant, so
/// the encoder selects the form from the value as GNU as does; `here` is
/// the instruction's section offset.
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

/// The `movz` / `movk` word an `:abs_gN:` operand relocates: zero
/// immediate, the group's shift. A 32-bit destination admits only the
/// two groups that fit it, as GNU as does.
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

/// The register shape of `o` after operand-reference resolution, for
/// the helpers that select an encoding from the register class.
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
    // A numeric-label reference (`b 1b`) is carried as a symbol reference
    // and resolves at materialize time; `.`-relative branches encode
    // directly.
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

/// Assign the literal pools of a statement's sections: each
/// `ldr Rt, =value` takes an entry of its section and subsection's
/// pending pool (shared with an earlier request of the same width and
/// value) and becomes a literal load of the entry's label; `.ltorg` and
/// the end of the subsection's content flush, as under GNU as.
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
