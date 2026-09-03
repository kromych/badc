//! Input flattening, COMDAT resolution, global symbol resolution, and
//! the assignment of input sections to output sections: claims, garbage
//! collection and orphan placement.

use crate::c5::error::C5Error;
use crate::c5::linker::comdat::{self};
use crate::c5::linker::lds::{
    Command, InputSpec, OutputSection, SectionContent, SectionsItem, SortKind, glob_match,
};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::inputs::RawSym;
use super::{
    InSecId, LdsEmit, LdsLinker, OrphanHandling, OutSec, Piece, Placement, SHF_ALLOC,
    SHF_EXECINSTR, SHF_GNU_RETAIN, SHF_WRITE, SHN_ABS, SHN_COMMON, SHN_UNDEF, SHT_NOBITS,
    STB_GLOBAL, STB_LOCAL, STB_WEAK, STT_OBJECT, SYNTH_COMMON, SecFate, Stmt, align_up, err,
};

/// bfd's orphan buckets, in layout order: code, read-only data,
/// writable data, `.bss`, then everything unallocated.
fn orphan_class(flags: u64, shtype: u32) -> u32 {
    if flags & SHF_ALLOC == 0 {
        4
    } else if flags & SHF_EXECINSTR != 0 {
        0
    } else if shtype == SHT_NOBITS {
        3
    } else if flags & SHF_WRITE == 0 {
        1
    } else {
        2
    }
}

/// The output section each orphan class anchors on when the script
/// names one; otherwise the last compatible section takes the orphan.
const ORPHAN_ANCHOR_NAMES: [Option<&str>; 5] = [
    Some(".text"),
    Some(".rodata"),
    Some(".data"),
    Some(".bss"),
    None,
];

/// Unwind and exception tables: kept whatever GC decides, and never a
/// source of liveness -- each names every function it describes.
pub(super) fn is_unwind_section(name: &str) -> bool {
    name == ".eh_frame" || name.starts_with(".eh_frame.") || name == ".eh_frame_hdr"
}

pub(super) fn is_debug_section(name: &str) -> bool {
    name.starts_with(".debug")
        || name.starts_with(".zdebug")
        || name.starts_with(".stab")
        || name == ".line"
        || name.starts_with(".gnu.linkonce.wi.")
}

fn file_glob(pattern: &str, source: &str) -> bool {
    if pattern == "*" {
        return true;
    }
    if glob_match(pattern, source) {
        return true;
    }
    if !pattern.contains('/') {
        let base = source.rsplit('/').next().unwrap_or(source);
        // Archive members are labeled `lib.a(member.o)`.
        let base = base
            .split_once('(')
            .map(|(_, m)| m.trim_end_matches(')'))
            .unwrap_or(base);
        return glob_match(pattern, base);
    }
    false
}

impl<'a> LdsLinker<'a> {
    /// Keep one copy of each COMDAT group and of each `.gnu.linkonce`
    /// section. Runs before symbol resolution so a losing copy's
    /// definitions never collide with the surviving one's.
    pub(super) fn dedup_groups(&mut self) {
        let dropped = {
            let views: Vec<comdat::ObjView<'_>> = self
                .objects
                .iter()
                .map(|o| comdat::ObjView {
                    groups: o
                        .groups
                        .iter()
                        .map(|g| comdat::GroupView {
                            flags: g.flags,
                            signature: &g.signature,
                            members: &g.members,
                        })
                        .collect(),
                    section_names: o.sections.iter().map(|s| s.name.as_str()).collect(),
                })
                .collect();
            comdat::dedup(&views).dropped
        };
        self.comdat_dropped = dropped;
    }

    /// The name of the section defining `sym` of object `oi`, if the
    /// dedup dropped it.
    pub(super) fn dropped_home(&self, oi: usize, sym: &RawSym) -> Option<&str> {
        let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
        self.comdat_dropped
            .contains(&(oi, sec))
            .then(|| self.objects[oi].sections[sec].name.as_str())
    }

    pub(super) fn resolve_globals(&mut self) -> Result<(), C5Error> {
        // Strong definitions win over weak; two strongs collide.
        let mut strong: HashMap<String, (usize, usize)> = HashMap::new();
        let mut weak: HashMap<String, (usize, usize)> = HashMap::new();
        let mut common: HashMap<String, (u64, u64, usize, usize)> = HashMap::new();
        for (oi, o) in self.objects.iter().enumerate() {
            for (si, s) in o.symbols.iter().enumerate() {
                if s.name.is_empty() || s.binding() == STB_LOCAL {
                    continue;
                }
                if o.shndx_map
                    .get(&s.shndx)
                    .is_some_and(|&sec| self.comdat_dropped.contains(&(oi, sec)))
                {
                    continue; // the surviving copy owns the definition
                }
                match s.shndx as u16 {
                    SHN_UNDEF => {
                        self.referenced.insert(s.name.clone());
                    }
                    SHN_COMMON => {
                        let e = common.entry(s.name.clone()).or_insert((0, 1, oi, si));
                        e.0 = e.0.max(s.size);
                        e.1 = e.1.max(s.value.max(1));
                    }
                    _ => {
                        if s.binding() == STB_WEAK {
                            weak.entry(s.name.clone()).or_insert((oi, si));
                        } else if let Some(&(poi, _)) = strong.get(&s.name) {
                            return Err(err(&format!(
                                "multiple definition of `{}` (in {} and {})",
                                s.name, self.objects[poi].source, self.objects[oi].source
                            )));
                        } else {
                            strong.insert(s.name.clone(), (oi, si));
                        }
                    }
                }
            }
        }
        for (name, def) in weak {
            strong.entry(name).or_insert(def);
        }
        // Commons not overridden by a real definition coalesce into a
        // synthetic NOBITS section on the pseudo-object.
        let mut layout: u64 = 0;
        let mut align: u64 = 1;
        let mut names: Vec<&String> = common.keys().filter(|n| !strong.contains_key(*n)).collect();
        names.sort();
        let mut slots: Vec<(String, u64)> = Vec::new();
        for name in names {
            let (size, al, _, _) = common[name];
            layout = align_up(layout, al);
            slots.push((name.clone(), layout));
            layout += size;
            align = align.max(al);
        }
        if layout > 0 {
            let synth = self.synth_obj;
            let sec = self.push_synth_section(SYNTH_COMMON, SHT_NOBITS, SHF_ALLOC | SHF_WRITE);
            self.objects[synth].sections[sec].size = layout;
            self.objects[synth].sections[sec].addralign = align;
            for (name, off) in slots {
                // Redirect the common definition at the synthetic slot
                // via a pseudo global symbol.
                let si = self.objects[synth].symbols.len();
                let shndx = self.objects[synth].sections[sec].orig_shndx;
                let size = common[&name].0;
                self.objects[synth].symbols.push(RawSym {
                    name: name.clone(),
                    info: (STB_GLOBAL << 4) | STT_OBJECT,
                    other: 0,
                    shndx,
                    value: off,
                    size,
                });
                strong.insert(name, (synth, si));
            }
        }
        self.globals = strong;
        Ok(())
    }

    pub(super) fn flatten_inputs(&mut self) {
        for (oi, o) in self.objects.iter().enumerate() {
            self.obj_base.push(self.insecs.len());
            for si in 0..o.sections.len() {
                self.insecs.push(InSecId { obj: oi, sec: si });
                self.fates.push(if self.comdat_dropped.contains(&(oi, si)) {
                    SecFate::Discarded
                } else {
                    SecFate::Unclaimed
                });
            }
        }
        self.placements = alloc::vec![Placement::default(); self.insecs.len()];
    }

    pub(super) fn build_statements(&mut self) -> Result<(), C5Error> {
        let Some(items) = self.script.sections() else {
            return Err(err("script has no SECTIONS command"));
        };
        for item in items {
            match item {
                SectionsItem::Assign(a) => self.stmts.push(Stmt::Assign(a.clone())),
                SectionsItem::Assert(e, m) => self.stmts.push(Stmt::Assert(e.clone(), m.clone())),
                SectionsItem::Output(o) => {
                    let idx = self.outs.len();
                    self.outs.push(OutSec {
                        address: o.address.clone(),
                        stype: o.stype,
                        at: o.at.clone(),
                        align_attr: o.align.clone(),
                        phdrs: o.phdrs.clone(),
                        fill: o.fill.clone(),
                        ..OutSec::empty(o.name.clone())
                    });
                    self.build_section_pieces(idx, o)?;
                    self.stmts.push(Stmt::Open(idx));
                }
            }
        }
        Ok(())
    }

    fn build_section_pieces(&mut self, idx: usize, o: &OutputSection) -> Result<(), C5Error> {
        for c in &o.contents {
            let piece = match c {
                SectionContent::Assign(a) => Piece::Assign(a.clone()),
                SectionContent::Assert(e, m) => Piece::Assert(e.clone(), m.clone()),
                SectionContent::Data(w, e) => Piece::Data(*w, e.clone()),
                SectionContent::Fill(e) => Piece::Fill(e.clone()),
                SectionContent::Constructors => continue,
                SectionContent::Input(_) => Piece::Inputs(Vec::new()),
            };
            self.outs[idx].pieces.push(piece);
        }
        Ok(())
    }

    /// Match every input section against the script's specs, in
    /// script order; each section is claimed at most once.
    pub(super) fn claim_inputs(&mut self) -> Result<(), C5Error> {
        let Some(items) = self.script.sections() else {
            return Ok(());
        };
        let mut out_idx = 0usize;
        for item in items {
            let SectionsItem::Output(o) = item else {
                continue;
            };
            let discard = o.name == "/DISCARD/";
            let this_out = out_idx;
            out_idx += 1;
            let mut piece_idx = 0usize;
            for c in &o.contents {
                let is_piece = !matches!(c, SectionContent::Constructors);
                let SectionContent::Input(spec) = c else {
                    if is_piece {
                        piece_idx += 1;
                    }
                    continue;
                };
                let claimed = self.claim_spec(spec);
                if discard {
                    for i in &claimed {
                        self.fates[*i] = SecFate::Discarded;
                    }
                } else {
                    for i in &claimed {
                        self.fates[*i] = SecFate::Placed { out: this_out };
                    }
                    if let Piece::Inputs(v) = &mut self.outs[this_out].pieces[piece_idx] {
                        *v = claimed;
                    }
                }
                piece_idx += 1;
            }
        }
        self.handle_orphans()
    }

    /// `--gc-sections`: discard every allocatable input section no
    /// root reaches through a relocation, before the specs claim
    /// anything. bfd's rule set -- a section carrying none of
    /// `SEC_ALLOC` / `SEC_LOAD` / `SEC_RELOC` is kept, as is a debug
    /// section, `SHF_GNU_RETAIN`, and anything a `KEEP()` names.
    pub(super) fn gc_sections(&mut self) {
        if !self.opts.gc_sections {
            return;
        }
        let mut live = alloc::vec![false; self.insecs.len()];
        let mut work: Vec<usize> = Vec::new();
        // A section the group dedup dropped is not part of the link:
        // it is neither a root nor a path to one, whatever names it.
        let gone: Vec<bool> = self
            .insecs
            .iter()
            .map(|id| self.comdat_dropped.contains(&(id.obj, id.sec)))
            .collect();
        let mark = |live: &mut [bool], work: &mut Vec<usize>, i: usize| {
            if !live[i] && !gone[i] {
                live[i] = true;
                work.push(i);
            }
        };
        // Sections GC never collects. Kept is not the same as
        // reaching: a debug or unwind section names every function it
        // describes, so following its relocations would keep the whole
        // input. bfd keeps those sections and prunes their contents
        // instead, and their references to a dropped section resolve
        // to nothing rather than to a diagnostic.
        for (i, keep) in live.iter_mut().enumerate() {
            let id = self.insecs[i];
            let s = &self.objects[id.obj].sections[id.sec];
            let collectable = s.flags & SHF_ALLOC != 0;
            *keep = !gone[i]
                && (!collectable
                    || s.flags & SHF_GNU_RETAIN != 0
                    || is_debug_section(&s.name)
                    || is_unwind_section(&s.name)
                    || id.obj == self.synth_obj);
        }
        // `KEEP()` roots, matched the way the claim would match them.
        let specs = self.keep_specs();
        for spec in &specs {
            for i in 0..self.insecs.len() {
                if self.spec_matches(spec, i, None) && !is_unwind_section(&self.insec(i).name) {
                    mark(&mut live, &mut work, i);
                }
            }
        }
        // Named roots: the entry point, `-u`, and every symbol the
        // dynamic table exports.
        let mut roots: Vec<String> = self.opts.undefined.clone();
        if let Some(e) = self
            .opts
            .entry_override
            .clone()
            .or_else(|| self.script.entry().map(String::from))
        {
            roots.push(e);
        }
        if self.opts.emit == LdsEmit::Dyn {
            roots.extend(self.globals.keys().cloned());
        }
        for name in &roots {
            for i in self.sections_defining(name) {
                mark(&mut live, &mut work, i);
            }
        }
        // Reachability. A reference to `__start_X` / `__stop_X` keeps
        // every section named `X`, the bound being meaningless without
        // the content it brackets.
        while let Some(i) = work.pop() {
            let id = self.insecs[i];
            for r in self.objects[id.obj].sections[id.sec].relocs.clone() {
                for t in self.reloc_targets(id.obj, r.sym as usize) {
                    mark(&mut live, &mut work, t);
                }
            }
        }
        for (i, keep) in live.iter().enumerate() {
            if !keep {
                self.fates[i] = SecFate::Discarded;
            }
        }
    }

    /// Every `KEEP()`-marked input spec in the script.
    fn keep_specs(&self) -> Vec<InputSpec> {
        let mut out: Vec<InputSpec> = Vec::new();
        for cmd in &self.script.commands {
            let Command::Sections(list) = cmd else {
                continue;
            };
            for item in list {
                let SectionsItem::Output(o) = item else {
                    continue;
                };
                for c in &o.contents {
                    if let SectionContent::Input(spec) = c
                        && spec.keep
                    {
                        out.push(spec.clone());
                    }
                }
            }
        }
        out
    }

    /// Input sections defining `name`, plus every section the name
    /// brackets when it is a `__start_` / `__stop_` bound.
    fn sections_defining(&self, name: &str) -> Vec<usize> {
        let mut out: Vec<usize> = Vec::new();
        if let Some(&(oi, si)) = self.globals.get(name) {
            let sym = &self.objects[oi].symbols[si];
            if let Some(&sec) = self.objects[oi].shndx_map.get(&sym.shndx) {
                out.push(self.insec_index(oi, sec));
            }
        }
        let bracketed = name
            .strip_prefix("__start_")
            .or_else(|| name.strip_prefix("__stop_"));
        if let Some(sec_name) = bracketed {
            for i in 0..self.insecs.len() {
                if self.insec(i).name == sec_name {
                    out.push(i);
                }
            }
        }
        out
    }

    /// Input sections a relocation against symbol `si` of object `oi`
    /// reaches: the defining section, resolved by name for a global.
    fn reloc_targets(&self, oi: usize, si: usize) -> Vec<usize> {
        let Some(sym) = self.objects[oi].symbols.get(si) else {
            return Vec::new();
        };
        if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            let by_name = self.sections_defining(&sym.name);
            if !by_name.is_empty() {
                return by_name;
            }
        }
        match sym.shndx as u16 {
            SHN_UNDEF | SHN_ABS | SHN_COMMON => Vec::new(),
            _ => match self.objects[oi].shndx_map.get(&sym.shndx) {
                Some(&sec) => alloc::vec![self.insec_index(oi, sec)],
                None => Vec::new(),
            },
        }
    }

    /// Sections matched by one input spec, in ld order: for a spec
    /// with several patterns, matching sections appear in input-file
    /// order interleaved; a SORT-wrapped pattern collects and sorts
    /// its own matches, emitted at the position of that pattern.
    fn claim_spec(&mut self, spec: &InputSpec) -> Vec<usize> {
        let mut result: Vec<usize> = Vec::new();
        let any_sorted = spec.patterns.iter().any(|p| p.sort != SortKind::None);
        if !any_sorted {
            for i in 0..self.insecs.len() {
                if self.fates[i] != SecFate::Unclaimed {
                    continue;
                }
                if self.spec_matches(spec, i, None) {
                    result.push(i);
                }
            }
            return result;
        }
        for (pi, pat) in spec.patterns.iter().enumerate() {
            let mut matches: Vec<usize> = Vec::new();
            for i in 0..self.insecs.len() {
                if self.fates[i] != SecFate::Unclaimed || result.contains(&i) {
                    continue;
                }
                if self.spec_matches(spec, i, Some(pi)) {
                    matches.push(i);
                }
            }
            match pat.sort {
                SortKind::ByName => {
                    matches.sort_by_key(|&a| self.insec(a).name.clone());
                }
                SortKind::ByAlignment => {
                    // Descending alignment, stable.
                    matches.sort_by_key(|&a| core::cmp::Reverse(self.insec(a).addralign));
                }
                SortKind::None => {}
            }
            result.extend(matches);
        }
        result
    }

    fn spec_matches(&self, spec: &InputSpec, i: usize, only_pattern: Option<usize>) -> bool {
        let id = self.insecs[i];
        let sec = &self.objects[id.obj].sections[id.sec];
        let source = &self.objects[id.obj].source;
        if !file_glob(&spec.file, source) {
            return false;
        }
        if spec.patterns.is_empty() {
            return true;
        }
        for (pi, p) in spec.patterns.iter().enumerate() {
            if let Some(only) = only_pattern
                && pi != only
            {
                continue;
            }
            if p.exclude_files.iter().any(|f| file_glob(f, source)) {
                continue;
            }
            if glob_match(&p.pattern, &sec.name) {
                return true;
            }
        }
        false
    }

    /// Unclaimed sections after all specs ran. `error` fails the link;
    /// `warn` / `place` append each after the last output section
    /// with compatible flags (a same-name output section wins).
    fn handle_orphans(&mut self) -> Result<(), C5Error> {
        let mut orphan_list: Vec<usize> = Vec::new();
        for i in 0..self.insecs.len() {
            if self.fates[i] != SecFate::Unclaimed {
                continue;
            }
            let sec = self.insec(i);
            // Zero-size unnamed leftovers and non-alloc reserved names
            // the writer regenerates are dropped silently.
            if sec.name.is_empty() {
                self.fates[i] = SecFate::Discarded;
                continue;
            }
            orphan_list.push(i);
        }
        if orphan_list.is_empty() {
            return Ok(());
        }
        if self.opts.orphan_handling == OrphanHandling::Error {
            let mut msg = String::from("orphan sections with --orphan-handling=error:");
            for &i in orphan_list.iter().take(20) {
                let id = self.insecs[i];
                msg.push_str(&format!(
                    "\n  `{}' from {}",
                    self.insec(i).name,
                    self.objects[id.obj].source
                ));
            }
            if orphan_list.len() > 20 {
                msg.push_str(&format!("\n  ... {} total", orphan_list.len()));
            }
            return Err(err(&msg));
        }
        if self.opts.orphan_handling == OrphanHandling::Discard {
            for &i in &orphan_list {
                self.fates[i] = SecFate::Discarded;
            }
            return Ok(());
        }
        for &i in &orphan_list {
            if self.opts.orphan_handling == OrphanHandling::Warn {
                let id = self.insecs[i];
                self.warnings.push(format!(
                    "warning: orphan section `{}' from `{}' being placed in section `{}'",
                    self.insec(i).name,
                    self.objects[id.obj].source,
                    self.insec(i).name
                ));
            }
            self.place_orphan(i);
        }
        Ok(())
    }

    fn place_orphan(&mut self, i: usize) {
        let (name, flags, shtype) = {
            let s = self.insec(i);
            (s.name.clone(), s.flags, s.shtype)
        };
        // Same-name output section: append there.
        if let Some((oi, _)) = self.outs.iter().enumerate().find(|(_, o)| o.name == name) {
            self.fates[i] = SecFate::Placed { out: oi };
            self.outs[oi].pieces.push(Piece::Inputs(alloc::vec![i]));
            return;
        }
        // New output section named after the input. bfd anchors an
        // orphan on the output section canonically named for its class
        // (`.text`, `.rodata`, `.data`, `.bss`), falling back to the
        // last section of a compatible class; further orphans of the
        // same class stack after the one already placed.
        let want = orphan_class(flags, shtype);
        let anchor = match self.orphan_anchor.get(&want) {
            Some(&oi) => Some(oi),
            None => self
                .outs
                .iter()
                .position(|o| Some(o.name.as_str()) == ORPHAN_ANCHOR_NAMES[want as usize]),
        };
        let mut insert_after: Option<usize> = None; // index into stmts
        for (si, st) in self.stmts.iter().enumerate() {
            if let Stmt::Open(oi) = st {
                if Some(*oi) == anchor {
                    insert_after = Some(si);
                    break;
                }
                if anchor.is_none() {
                    let of = self.section_input_flags(*oi);
                    if orphan_class(of, self.outs[*oi].shtype) <= want {
                        insert_after = Some(si);
                    }
                }
            }
        }
        let new_out = self.outs.len();
        self.outs.push(OutSec {
            pieces: alloc::vec![Piece::Inputs(alloc::vec![i])],
            orphan: true,
            ..OutSec::empty(name)
        });
        let pos = insert_after.map(|s| s + 1).unwrap_or(self.stmts.len());
        self.stmts.insert(pos, Stmt::Open(new_out));
        self.fates[i] = SecFate::Placed { out: new_out };
        self.orphan_anchor.insert(want, new_out);
    }

    /// Union of the input flags currently claimed by output `oi`.
    pub(super) fn section_input_flags(&self, oi: usize) -> u64 {
        let mut f = 0u64;
        for p in &self.outs[oi].pieces {
            if let Piece::Inputs(v) = p {
                for &i in v {
                    f |= self.insec(i).flags;
                }
            }
        }
        f
    }
}
