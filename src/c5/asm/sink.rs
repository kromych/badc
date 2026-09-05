//! The file-scope section sink: the accumulator a unit's assembler
//! statements append sections, labels and symbol declarations to, with
//! the name indexes that keep the per-statement lookups off the section
//! list, and the deferred relocation resolution the emit runs over it.

use super::*;
use crate::c5::codegen::map_syms::MapMarks;
use crate::c5::codegen::ssa::cfi;

/// The accumulated inline-asm sections and the indexes that make a lookup
/// against them independent of how much the sink already holds. A unit's
/// file-scope asm can push a uniquely named section and a label per
/// exported symbol -- modpost's `.vmlinux.export.c` pushes tens of
/// thousands of both -- and every [`materialize_asm_sections`] call has to
/// resolve a section identity and the labels earlier calls defined, so
/// scanning the sink for either makes a unit quadratic in its own asm.
#[derive(Debug, Default)]
pub(crate) struct AsmSectionSink {
    pub(crate) sections: asm_sections::AsmSections,
    /// `(name, flags, sh_type)` identity -> index into `sections`.
    pub(crate) by_key: hashbrown::HashMap<alloc::string::String, usize>,
    /// Section name -> the identity keys carrying it, in push order. A
    /// name pushed under different attributes is several sections; the
    /// last one answers a lookup, as a walk of the sink would.
    pub(crate) by_name: AsmSinkSectionNames,
    /// Label name -> its section's identity key and its offset there.
    /// Carries only labels of completed calls: that is what a call's
    /// location expressions resolve against, its own coming from the
    /// measurement. Keyed by identity rather than index so a lookup stays
    /// disjoint from a mutable borrow of the section being laid out.
    pub(crate) labels: AsmSinkLabels,
    /// Per section, how many of its labels the binding counts below hold.
    /// A call's labels join them where it publishes them, so a rebinding
    /// under the mark adjusts the counts and one over it does not.
    pub(crate) published: alloc::vec::Vec<usize>,
    /// How many published labels and unit-level declarations bind each
    /// name global or weak, and how many bind it weak.
    pub(crate) non_local: AsmBindCounts,
    pub(crate) weak: AsmBindCounts,
    /// Unit-level symbol declarations the unit's templates made outside any
    /// section, merged by name. Applied by the object writer, which is where
    /// every definition the unit holds is known.
    pub(crate) sym_decls: alloc::vec::Vec<AsmSymDecl>,
    /// `.cfi_*` directives in the order the unit wrote them, each carrying
    /// the section and offset it reached. Turned into frame tables by
    /// [`Self::emit_cfi_sections`] once every section is laid out.
    pub(crate) cfi: alloc::vec::Vec<cfi::CfiRecord>,
}

/// Section name -> the identity keys the sink holds under it.
pub(crate) type AsmSinkSectionNames =
    hashbrown::HashMap<alloc::string::String, alloc::vec::Vec<alloc::string::String>>;

/// The key a bare section name stands for: the last section pushed under
/// it, as a walk of the sink would find.
pub(crate) fn sink_section_key<'a>(names: &'a AsmSinkSectionNames, name: &str) -> Option<&'a str> {
    names.get(name)?.last().map(alloc::string::String::as_str)
}

/// Label name -> (owning section's identity key, offset within it).
pub(crate) type AsmSinkLabels =
    hashbrown::HashMap<alloc::string::String, (alloc::string::String, i64)>;

/// The sink state an expression resolves a name against: the labels
/// earlier statements published and the sections the unit holds.
pub(crate) struct AsmSinkNames<'a> {
    pub(crate) labels: &'a AsmSinkLabels,
    pub(crate) sections: &'a AsmSinkSectionNames,
}

impl AsmSinkNames<'_> {
    pub(crate) fn label(&self, name: &str) -> Option<&(alloc::string::String, i64)> {
        self.labels.get(name)
    }

    pub(crate) fn section(&self, name: &str) -> Option<&str> {
        sink_section_key(self.sections, name)
    }
}

/// Name -> how many labels and declarations give it one binding. Shared:
/// a statement's binding tests read the counts as its materialization
/// found them, while the same materialization keeps adding to the sink's.
pub(crate) type AsmBindCounts = alloc::rc::Rc<hashbrown::HashMap<alloc::string::String, u32>>;

/// The sink's sections, behind an interface that records every walk of
/// them. Materialization resolves what it needs through the sink's
/// indexes, so the total stays linear in a unit's asm; the asymptotic test
/// reads it.
mod asm_sections {
    use super::AsmSection;

    #[derive(Debug, Default)]
    pub(crate) struct AsmSections {
        v: alloc::vec::Vec<AsmSection>,
        walked: core::cell::Cell<u64>,
    }

    impl AsmSections {
        pub(crate) fn len(&self) -> usize {
            self.v.len()
        }

        pub(crate) fn at(&self, i: usize) -> &AsmSection {
            &self.v[i]
        }

        pub(crate) fn at_mut(&mut self, i: usize) -> &mut AsmSection {
            &mut self.v[i]
        }

        pub(crate) fn push(&mut self, s: AsmSection) {
            self.v.push(s);
        }

        /// Every section, for a pass that has to walk them all.
        pub(crate) fn all(&self) -> &[AsmSection] {
            self.note();
            &self.v
        }

        pub(crate) fn all_mut(&mut self) -> &mut [AsmSection] {
            self.note();
            &mut self.v
        }

        pub(crate) fn drain_from(&mut self, n: usize) -> alloc::vec::Drain<'_, AsmSection> {
            self.note();
            self.v.drain(n..)
        }

        pub(crate) fn into_vec(self) -> alloc::vec::Vec<AsmSection> {
            self.v
        }

        #[cfg(test)]
        pub(crate) fn walked(&self) -> u64 {
            self.walked.get()
        }

        fn note(&self) {
            self.walked.set(self.walked.get() + self.v.len() as u64);
        }
    }
}

impl AsmSectionSink {
    /// Mutable access for the relocation-retarget passes. Section identity
    /// and the label lists are indexed, so a caller must not add, remove,
    /// or rename either through this.
    pub(crate) fn relocs_mut(&mut self) -> &mut [AsmSection] {
        self.sections.all_mut()
    }

    /// The accumulated sections and unit-level symbol declarations, for the
    /// object writers. The indexes serve materialization only and are
    /// dropped with the sink.
    pub(crate) fn into_parts(self) -> (alloc::vec::Vec<AsmSection>, alloc::vec::Vec<AsmSymDecl>) {
        (self.sections.into_vec(), self.sym_decls)
    }

    #[cfg(test)]
    pub(crate) fn len(&self) -> usize {
        self.sections.len()
    }

    pub(crate) fn section(&self, i: usize) -> &AsmSection {
        self.sections.at(i)
    }

    #[cfg(test)]
    pub(crate) fn sections(&self) -> &[AsmSection] {
        self.sections.all()
    }

    /// Sections walked, read by the test that locks the per-statement cost
    /// of materialization to a constant.
    #[cfg(test)]
    pub(crate) fn walked(&self) -> u64 {
        self.sections.walked()
    }

    pub(crate) fn section_names(&self) -> &AsmSinkSectionNames {
        &self.by_name
    }

    /// The counts as they stand, for a statement to test its names against.
    pub(crate) fn bind_counts(&self, weak_only: bool) -> AsmBindCounts {
        if weak_only {
            self.weak.clone()
        } else {
            self.non_local.clone()
        }
    }

    /// Append the frame tables the unit's `.cfi_*` directives describe. Runs
    /// once every section is laid out, since an FDE spans a code range whose
    /// end the closing directive fixes.
    pub(crate) fn emit_cfi_sections(
        &mut self,
        target: cfi::CfiTarget,
    ) -> Result<(), alloc::string::String> {
        if self.cfi.is_empty() {
            return Ok(());
        }
        let built = cfi::build_cfi_sections(&self.cfi, target)?;
        for s in built {
            self.push_section(s);
        }
        Ok(())
    }

    fn push_section(&mut self, s: AsmSection) -> usize {
        let i = self.sections.len();
        let key = section_key_of(&s);
        self.by_name
            .entry_ref(s.name.as_str())
            .or_default()
            .push(key.clone());
        self.by_key.insert(key, i);
        self.published.push(0);
        self.sections.push(s);
        i
    }

    /// Merge the symbol directives a template carried outside any section
    /// into the unit's declarations, later directives on a name winning.
    /// A `.size` needs a section's layout to value `.`, so one here must
    /// fold to a constant. TODO `.size` over code-stream labels.
    pub(crate) fn push_sym_decls(
        &mut self,
        items: &[AsmSectionItem],
    ) -> Result<(), alloc::string::String> {
        for item in items {
            let (name, bind, sym_type, size, value) = match item {
                AsmSectionItem::Global(n) => {
                    (n, AsmSymBind::Global, AsmSymType::NoType, None, None)
                }
                AsmSectionItem::Local(n) => (n, AsmSymBind::Local, AsmSymType::NoType, None, None),
                AsmSectionItem::Weak(n) => (n, AsmSymBind::Weak, AsmSymType::NoType, None, None),
                AsmSectionItem::Type { name, sym_type } => {
                    (name, AsmSymBind::Default, *sym_type, None, None)
                }
                AsmSectionItem::Size { name, expr } => {
                    let ctx = AsmExprCtx {
                        resolve: &|_| None,
                        const_of: &|_| None,
                        lax_div: false,
                    };
                    let v = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .filter(|v| *v >= 0)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.size {name}, {expr}` outside a section needs a \
                                 constant size"
                            )
                        })?;
                    (
                        name,
                        AsmSymBind::Default,
                        AsmSymType::NoType,
                        Some(v as u64),
                        None,
                    )
                }
                // An assignment defines the name for the unit: a constant
                // binds it `SHN_ABS`, a symbol makes it that symbol's alias.
                AsmSectionItem::AbsSet { name, value } => (
                    name,
                    AsmSymBind::Default,
                    AsmSymType::NoType,
                    None,
                    Some(AsmSymValue::Abs(*value)),
                ),
                AsmSectionItem::SymSet { name, target } => (
                    name,
                    AsmSymBind::Default,
                    AsmSymType::NoType,
                    None,
                    Some(AsmSymValue::Sym(target.clone(), 0)),
                ),
                // Outside a section there is no layout to value a location
                // expression against, so one here must fold to a constant.
                AsmSectionItem::SetExpr { name, expr } => {
                    let ctx = AsmExprCtx {
                        resolve: &|_| None,
                        const_of: &|_| None,
                        lax_div: false,
                    };
                    let v = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.set {name}, {expr}` outside a section needs a \
                                 constant value"
                            )
                        })?;
                    (
                        name,
                        AsmSymBind::Default,
                        AsmSymType::NoType,
                        None,
                        Some(AsmSymValue::Abs(v)),
                    )
                }
                // `.set .,` moves the location counter of the section it sits
                // in; the code stream's is the enclosing function's, which the
                // arch backend lays out.
                AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. }
                | AsmSectionItem::OrgExpr(..) => {
                    return Err(alloc::string::String::from(
                        "inline asm: `.set .` outside a section",
                    ));
                }
                _ => continue,
            };
            let di = self.sym_decl_slot(name);
            if bind != AsmSymBind::Default {
                let was = core::mem::replace(&mut self.sym_decls[di].bind, bind);
                count_bind(&mut self.non_local, &mut self.weak, name, was, false);
                count_bind(&mut self.non_local, &mut self.weak, name, bind, true);
            }
            let d = &mut self.sym_decls[di];
            if sym_type != AsmSymType::NoType {
                d.sym_type = sym_type;
            }
            if size.is_some() {
                d.size = size;
            }
            if value.is_some() {
                d.value = value;
            }
        }
        Ok(())
    }

    /// The unit's declaration slot for `name`, appended when it has none.
    fn sym_decl_slot(&mut self, name: &str) -> usize {
        if let Some(i) = self.sym_decls.iter().position(|d| d.name == name) {
            return i;
        }
        self.sym_decls.push(AsmSymDecl {
            name: alloc::string::String::from(name),
            ..Default::default()
        });
        self.sym_decls.len() - 1
    }

    /// Record a `.type` / `.size` for a name the sections define no label
    /// for, so a symbol built elsewhere in the unit takes the attributes.
    pub(crate) fn record_sym_attrs(&mut self, name: &str, sym_type: AsmSymType, size: Option<u64>) {
        let di = self.sym_decl_slot(name);
        let d = &mut self.sym_decls[di];
        if sym_type != AsmSymType::NoType {
            d.sym_type = sym_type;
        }
        if size.is_some() {
            d.size = size;
        }
    }

    /// Index of the section carrying `b`'s identity, if the sink has one.
    pub(crate) fn index_of(&self, b: &AsmSectionBlock) -> Option<usize> {
        self.by_key.get(&section_key(b)).copied()
    }

    /// Index of `b`'s section, appending an empty one when the sink holds
    /// no section of that identity yet.
    pub(crate) fn get_or_insert(&mut self, b: &AsmSectionBlock) -> usize {
        if let Some(&i) = self.by_key.get(&section_key(b)) {
            return i;
        }
        self.push_section(AsmSection {
            name: b.name.clone(),
            flags: b.flags.clone(),
            sh_type: b.sh_type.clone(),
            entsize: b.entsize,
            link: b.link.clone(),
            bytes: alloc::vec::Vec::new(),
            relocs: alloc::vec::Vec::new(),
            labels: alloc::vec::Vec::new(),
            align: 1,
            after_insn: true,
            map_state: None,
            map: MapMarks::default(),
        })
    }

    /// Publish the labels section `sec_idx` gained past `from`, so the next
    /// call resolves them and their bindings answer a binding test. Runs
    /// once a call's pending entries are settled.
    pub(crate) fn publish_labels(&mut self, sec_idx: usize, from: usize) {
        let sec = self.sections.at(sec_idx);
        let key = section_key_of(sec);
        // The counts cover every label under the mark, the label index
        // what this call added; the two agree except where a `.set` wrote
        // into a section the call did not otherwise touch.
        let counted = self.published[sec_idx];
        for i in counted.min(from)..sec.labels.len() {
            let l = &sec.labels[i];
            if i >= counted {
                count_label_bind(&mut self.non_local, &mut self.weak, l, true);
            }
            if i >= from {
                self.labels
                    .insert(l.name.clone(), (key.clone(), l.offset as i64));
            }
        }
        self.published[sec_idx] = sec.labels.len();
    }

    /// Record the sink's outer length and each existing section's bytes,
    /// relocs, labels, alignment, and instruction-boundary state.
    pub(crate) fn snapshot(&self) -> AsmSectionsSnapshot {
        AsmSectionsSnapshot {
            len: self.sections.len(),
            decls: self.sym_decls.clone(),
            cfi: self.cfi.len(),
            per_section: self
                .sections
                .all()
                .iter()
                .map(|s| {
                    (
                        s.bytes.len(),
                        s.relocs.len(),
                        s.labels.len(),
                        s.align,
                        s.after_insn,
                        s.map_state,
                    )
                })
                .collect(),
        }
    }

    /// Restore the sink to a prior [`AsmSectionSink::snapshot`]: drop
    /// sections created since, and truncate each pre-existing section's
    /// contents. The indexes shed exactly what the truncation drops. A
    /// snapshot the sink has already shrunk past restores nothing, so a
    /// caller may restore the same one more than once.
    pub(crate) fn restore(&mut self, snap: &AsmSectionsSnapshot) {
        if self.sym_decls.len() >= snap.decls.len() {
            for d in &self.sym_decls {
                count_bind(&mut self.non_local, &mut self.weak, &d.name, d.bind, false);
            }
            self.sym_decls.clone_from(&snap.decls);
            for d in &self.sym_decls {
                count_bind(&mut self.non_local, &mut self.weak, &d.name, d.bind, true);
            }
        }
        self.cfi.truncate(snap.cfi.min(self.cfi.len()));
        let keep = snap.len.min(self.sections.len());
        for (i, s) in self.sections.drain_from(keep).enumerate() {
            let key = section_key_of(&s);
            if let Some(v) = self.by_name.get_mut(&s.name)
                && let Some(at) = v.iter().rposition(|k| *k == key)
            {
                v.remove(at);
            }
            self.by_key.remove(&key);
            for (li, l) in s.labels.iter().enumerate() {
                if li < self.published[keep + i] {
                    count_label_bind(&mut self.non_local, &mut self.weak, l, false);
                }
                self.labels.remove(&l.name);
            }
        }
        self.published.truncate(keep);
        for (i, (s, &(bytes, relocs, labels, align, after_insn, map_state))) in self
            .sections
            .all_mut()
            .iter_mut()
            .zip(&snap.per_section)
            .enumerate()
        {
            s.bytes.truncate(bytes);
            s.map.truncate(bytes);
            s.relocs.truncate(relocs);
            for (li, l) in s.labels.drain(labels.min(s.labels.len())..).enumerate() {
                if labels + li < self.published[i] {
                    count_label_bind(&mut self.non_local, &mut self.weak, &l, false);
                }
                self.labels.remove(&l.name);
            }
            self.published[i] = self.published[i].min(s.labels.len());
            s.align = align;
            s.after_insn = after_insn;
            s.map_state = map_state;
        }
    }
}

/// Move a declaration's binding into or out of the sink's counts.
fn count_bind(
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    name: &str,
    bind: AsmSymBind,
    add: bool,
) {
    match bind {
        AsmSymBind::Global => count_name(alloc::rc::Rc::make_mut(non_local), name, add),
        AsmSymBind::Weak => {
            count_name(alloc::rc::Rc::make_mut(non_local), name, add);
            count_name(alloc::rc::Rc::make_mut(weak), name, add);
        }
        _ => {}
    }
}

/// The same for a section label's binding.
fn count_label_bind(
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    l: &AsmSectionLabel,
    add: bool,
) {
    if l.global || l.weak {
        count_name(alloc::rc::Rc::make_mut(non_local), &l.name, add);
    }
    if l.weak {
        count_name(alloc::rc::Rc::make_mut(weak), &l.name, add);
    }
}

fn count_name(counts: &mut hashbrown::HashMap<alloc::string::String, u32>, name: &str, add: bool) {
    if add {
        *counts.entry_ref(name).or_insert(0) += 1;
    } else if let Some(c) = counts.get_mut(name) {
        *c -= 1;
        if *c == 0 {
            counts.remove(name);
        }
    }
}

/// Rewrite a label's binding and keep the sink's counts in step. A label
/// the call has not published carries no count yet; publishing takes its
/// final binding.
pub(crate) fn rebind_label(
    l: &mut AsmSectionLabel,
    counted: bool,
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    f: impl FnOnce(&mut AsmSectionLabel),
) {
    if counted {
        count_label_bind(non_local, weak, l, false);
    }
    f(l);
    if counted {
        count_label_bind(non_local, weak, l, true);
    }
}

/// Rewrite the `AsmSectionTarget::TextBlock` relocations a function's
/// `asm goto` section fields left behind (relative to `snap`, its entry
/// snapshot) to concrete text offsets, now that its `block_offsets` are
/// final. `block_off` maps a block index to its byte offset in the text.
pub(crate) fn resolve_asm_goto_relocs(
    sink: &mut [AsmSection],
    snap: &AsmSectionsSnapshot,
    block_off: &dyn Fn(u32) -> usize,
) {
    for (i, s) in sink.iter_mut().enumerate() {
        let start = snap
            .per_section
            .get(i)
            .map_or(0, |&(_, relocs, _, _, _, _)| relocs);
        for r in s.relocs.iter_mut().skip(start) {
            if let AsmSectionTarget::TextBlock(bid) = r.target {
                r.target = AsmSectionTarget::Text(block_off(bid));
            }
        }
    }
}

/// Rewrite the `AsmSectionTarget::DeferredText` relocations a function's
/// ALTERNATIVE `.subsection` fields left behind (relative to `snap`, its
/// entry snapshot) to concrete text offsets, now that each deferred region
/// is placed. `region_base` maps a region index to its byte offset in the
/// text; the label's within-region offset is already in the target.
pub(crate) fn resolve_asm_deferred_relocs(
    sink: &mut [AsmSection],
    snap: &AsmSectionsSnapshot,
    region_base: &dyn Fn(u32) -> usize,
) {
    for (i, s) in sink.iter_mut().enumerate() {
        let start = snap
            .per_section
            .get(i)
            .map_or(0, |&(_, relocs, _, _, _, _)| relocs);
        for r in s.relocs.iter_mut().skip(start) {
            if let AsmSectionTarget::DeferredText { region, off } = r.target {
                r.target = AsmSectionTarget::Text(region_base(region) + off as usize);
            }
        }
    }
}
