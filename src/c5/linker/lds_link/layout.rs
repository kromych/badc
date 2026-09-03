//! The layout passes: output section addresses, sizes and chunk
//! layout from the statement walk.

use crate::c5::error::C5Error;
use crate::c5::linker::dynamic::{self};
use crate::c5::linker::lds::{Command, Expr, OutputSectionType};
use crate::c5::linker::object::is_c_identifier;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashSet;

use super::{
    Att, ChunkSrc, EM_386, EM_AARCH64, EM_X86_64, LdsEmit, LdsLinker, Piece, Placement, SHF_ALLOC,
    SHF_EXCLUDE, SHF_EXECINSTR, SHF_GROUP, SHF_INFO_LINK, SHF_LINK_ORDER, SHF_MERGE, SHF_STRINGS,
    SHT_NOBITS, SHT_NOTE, SHT_PROGBITS, SHT_RELA, SHT_RELR, SHT_STRTAB, STT_NOTYPE, STV_PROTECTED,
    ScriptSym, Stmt, Val, align_up,
};

/// The fill pattern for a numeric fill value: the value's big-endian
/// bytes with leading zeros trimmed (at least one byte). `0xcccccccc`
/// fills with `cc`, `0x9090` with `90 90`.
fn fill_pattern(v: u64) -> Vec<u8> {
    let be = v.to_be_bytes();
    let first = be.iter().position(|&b| b != 0).unwrap_or(7);
    be[first..].to_vec()
}

/// A gap's padding: the script's fill pattern where it gave one, the
/// architecture's otherwise.
fn pad_bytes(fill: &Option<Vec<u8>>, machine: u16, code: bool, len: u64) -> Vec<u8> {
    match fill {
        Some(f) => f.clone(),
        None => arch_fill(machine, code, len as usize),
    }
}

/// Padding bytes for a gap a script gave no fill for: bfd takes them
/// from the architecture (`bfd/cpu-*.c`), which is a NOP sequence in a
/// code section and zeros everywhere else, so padding a control-flow
/// path reaches is not an instruction stream of its own.
fn arch_fill(machine: u16, code: bool, len: usize) -> Vec<u8> {
    if !code || len == 0 {
        return alloc::vec![0u8; len];
    }
    match machine {
        EM_386 | EM_X86_64 => {
            let mut v = alloc::vec![0x90u8; len];
            for k in (0..len.saturating_sub(1)).step_by(2) {
                v[k] = 0x66;
            }
            v
        }
        EM_AARCH64 if len.is_multiple_of(4) => {
            let mut v = Vec::with_capacity(len);
            for _ in 0..len / 4 {
                v.extend_from_slice(&[0x1f, 0x20, 0x03, 0xd5]);
            }
            v
        }
        _ => alloc::vec![0u8; len],
    }
}

impl<'a> LdsLinker<'a> {
    pub(super) fn fingerprint(&self) -> Vec<u64> {
        let mut fp: Vec<u64> = Vec::with_capacity(self.outs.len() * 3 + self.script_now.len());
        for o in &self.outs {
            fp.push(o.addr);
            fp.push(o.size);
            fp.push(o.lma);
        }
        // Script symbols in name order for a stable fingerprint.
        let mut names: Vec<&String> = self.script_now.keys().collect();
        names.sort();
        for n in names {
            fp.push(self.script_now[n].val.v);
        }
        fp.push(self.dyn_relas.len() as u64);
        fp.push(self.relr_addrs.len() as u64);
        fp.push(self.got_slots.len() as u64);
        for (&oi, &v) in &self.veneer_reserve {
            fp.push(oi as u64);
            fp.push(v);
        }
        fp
    }

    pub(super) fn layout_pass(&mut self, final_pass: bool) -> Result<(), C5Error> {
        self.final_pass = final_pass;
        // Dynamic machinery is sized from the previous pass's state:
        // its placement (the `placed` flags and offsets still hold) and
        // its script symbols, which the dynamic tables carry. Both are
        // reset below, so this runs first. Skipped in effect on the
        // first pass, where no placement exists yet -- the tables start
        // empty and gain their size once a pass has run.
        self.size_dynamic_sections();
        self.size_eh_frame_hdr();
        self.script_prev = core::mem::take(&mut self.script_now);
        for p in &mut self.placements {
            p.placed = false;
        }
        self.dot = 0;
        self.cur_out = None;
        self.dot_section = None;
        self.prefer_next = false;
        self.cur_stmt = 0;
        self.found_end = false;
        // Values persist across passes: a statement before its
        // section's visit this pass sees the previous pass's flag, as
        // ld's phases do.
        self.after_end.resize(self.outs.len(), false);
        self.lma_delta = 0;
        self.errors.clear();
        self.undefined.clear();

        // File-level commands before SECTIONS.
        let mut sections_done = false;
        for cmd in &self.script.commands.clone() {
            match cmd {
                Command::Assign(a) => self.exec_assignment(a, sections_done),
                Command::Assert(e, m) => self.exec_assert(e, m),
                Command::Sections(_) => {
                    self.exec_sections()?;
                    sections_done = true;
                }
                _ => {}
            }
        }
        Ok(())
    }

    fn exec_sections(&mut self) -> Result<(), C5Error> {
        for si in 0..self.stmts.len() {
            self.cur_stmt = si;
            match self.stmts[si].clone() {
                Stmt::Assign(a) => {
                    // ld: a top-level assignment to dot makes following
                    // boundary symbols attach to the next section.
                    if a.symbol == "." {
                        self.prefer_next = true;
                    }
                    self.exec_assignment(&a, false)
                }
                Stmt::Assert(e, m) => self.exec_assert(&e, &m),
                Stmt::Open(oi) => {
                    self.after_end[oi] = self.found_end;
                    // A section already known empty never becomes the
                    // dot anchor (its sizes converged in earlier
                    // passes; `removed` itself settles only at finish).
                    if self.outs[oi].alloc
                        && self.outs[oi].size > 0
                        && self.outs[oi].name != "/DISCARD/"
                    {
                        self.dot_section = Some(oi);
                        self.prefer_next = false;
                    }
                    self.layout_out_section(oi)
                }
            }
        }
        Ok(())
    }

    fn layout_out_section(&mut self, oi: usize) {
        // Collect immutable inputs first.
        let (address, stype, at, align_attr, fill, pieces_len) = {
            let o = &self.outs[oi];
            (
                o.address.clone(),
                o.stype,
                o.at.clone(),
                o.align_attr.clone(),
                o.fill.clone(),
                o.pieces.len(),
            )
        };
        // Input-derived attributes.
        let mut in_flags = 0u64;
        let mut max_align = 1u64;
        let mut any_input = false;
        let mut all_nobits = true;
        let mut all_note = true;
        let mut entsizes: Vec<u64> = Vec::new();
        let mut in_flag_set: Vec<u64> = Vec::new();
        for pi in 0..pieces_len {
            if let Piece::Inputs(v) = &self.outs[oi].pieces[pi] {
                for &i in v.clone().iter() {
                    let s = self.insec(i);
                    any_input = true;
                    in_flags |= s.flags;
                    max_align = max_align.max(s.addralign);
                    if s.shtype != SHT_NOBITS {
                        all_nobits = false;
                    }
                    if s.shtype != SHT_NOTE {
                        all_note = false;
                    }
                    entsizes.push(s.entsize);
                    in_flag_set.push(s.flags);
                }
            }
        }
        let attr_align = align_attr
            .as_ref()
            .map(|e| self.eval(e).v)
            .unwrap_or(1)
            .max(1);
        let sec_align = max_align.max(attr_align);

        // Address 0 with non-alloc inputs (the debug-section idiom)
        // keeps the section out of the allocation flow; `(INFO)`
        // likewise.
        let explicit_zero = matches!(address, Some(Expr::Number(0)));
        let non_alloc_inputs = in_flags & SHF_ALLOC == 0;
        let info_type = stype == Some(OutputSectionType::Info);
        // An orphan takes its input's allocation: bfd creates the
        // output section from the input's flags, so a non-allocated
        // input never joins the load image.
        let orphan_non_alloc = self.outs[oi].orphan && non_alloc_inputs && any_input;
        let alloc = !info_type && !(explicit_zero && non_alloc_inputs) && !orphan_non_alloc;

        let addr = if let Some(ae) = &address {
            let v = self.eval(ae).v;
            if alloc {
                self.dot = v;
            }
            v
        } else if alloc {
            self.dot = align_up(self.dot, sec_align);
            self.dot
        } else {
            0
        };

        let saved_dot = self.dot;
        let start = if alloc { self.dot } else { addr };
        self.cur_out = Some(oi);
        self.outs[oi].addr = start;

        let mut off: u64 = 0;
        let mut end: u64 = 0;
        let mut chunks: Vec<(u64, u64, ChunkSrc)> = Vec::new();
        let mut fill_bytes: Option<Vec<u8>> = fill.as_ref().map(|e| {
            let v = self.eval(e).v;
            fill_pattern(v)
        });
        let code = self.section_input_flags(oi) & SHF_EXECINSTR != 0;
        let machine = self.machine;
        let mut file_bytes = false;
        // The veneer area sits after the section's last input piece, as
        // ld attaches its stub section, so closing statements still
        // bound it.
        let veneer_len = self.veneer_reserve.get(&oi).copied().unwrap_or(0);
        let last_inputs_pi = (0..pieces_len)
            .rev()
            .find(|&pi| matches!(self.outs[oi].pieces[pi], Piece::Inputs(_)));
        for pi in 0..pieces_len {
            match self.outs[oi].pieces[pi].clone() {
                Piece::Inputs(v) => {
                    for &i in &v {
                        // A merged-away member (not its pool's
                        // representative) contributes no bytes and no
                        // alignment: its storage lives in the pool rep.
                        if let Some(&pl) = self.merge_of.get(&i)
                            && self.pools[pl].rep != i
                        {
                            self.placements[i] = Placement {
                                out: oi,
                                off,
                                placed: true,
                            };
                            continue;
                        }
                        let (a, sz, nobits) = {
                            let s = self.insec(i);
                            let a = if let Some(&pl) = self.merge_of.get(&i) {
                                self.pools[pl].align
                            } else {
                                s.addralign.max(1)
                            };
                            (a, self.insec_placed_size(i), s.shtype == SHT_NOBITS)
                        };
                        let aligned = align_up(off, a);
                        if aligned > off {
                            if !nobits && !all_nobits {
                                let len = aligned - off;
                                let pad = pad_bytes(&fill_bytes, machine, code, len);
                                chunks.push((off, len, ChunkSrc::Pad(pad)));
                            }
                            off = aligned;
                        }
                        self.placements[i] = Placement {
                            out: oi,
                            off,
                            placed: true,
                        };
                        chunks.push((off, sz, ChunkSrc::Input(i)));
                        if !nobits && sz > 0 {
                            file_bytes = true;
                        }
                        off += sz;
                        end = end.max(off);
                        if alloc {
                            self.dot = start + off;
                        }
                    }
                    if veneer_len > 0 && Some(pi) == last_inputs_pi {
                        let aligned = align_up(off, 4);
                        if aligned > off && !all_nobits {
                            let len = aligned - off;
                            let pad = pad_bytes(&fill_bytes, machine, code, len);
                            chunks.push((off, len, ChunkSrc::Pad(pad)));
                        }
                        chunks.push((aligned, veneer_len, ChunkSrc::Veneers));
                        file_bytes = true;
                        off = aligned + veneer_len;
                        end = end.max(off);
                        if alloc {
                            self.dot = start + off;
                        }
                    }
                }
                Piece::Assign(a) => {
                    self.exec_assignment(&a, false);
                    if alloc {
                        let new_off = self.dot.wrapping_sub(start);
                        if self.dot < start && self.final_pass {
                            self.errors.push(format!(
                                "cannot move location counter backwards in `{}'",
                                self.outs[oi].name
                            ));
                        } else {
                            if new_off > off && !all_nobits {
                                let len = new_off - off;
                                let pad = pad_bytes(&fill_bytes, machine, code, len);
                                chunks.push((off, len, ChunkSrc::Pad(pad)));
                            }
                            off = new_off;
                            end = end.max(off);
                        }
                    }
                }
                Piece::Assert(e, m) => self.exec_assert(&e, &m),
                Piece::Data(w, e) => {
                    let v = self.eval(&e).v;
                    let n = w.size() as usize;
                    let bytes = v.to_le_bytes()[..n].to_vec();
                    chunks.push((off, n as u64, ChunkSrc::Bytes(bytes)));
                    file_bytes = true;
                    off += n as u64;
                    end = end.max(off);
                    if alloc {
                        self.dot = start + off;
                    }
                }
                Piece::Fill(e) => {
                    let v = self.eval(&e).v;
                    fill_bytes = Some(fill_pattern(v));
                }
            }
        }
        let size = end;

        // Section classification: no file content at all makes
        // NOBITS (`.bss`-shape sections, `. +=` reservations); a
        // uniform SHT_NOTE membership keeps NOTE; everything else is
        // PROGBITS.
        let noload = stype == Some(OutputSectionType::NoLoad);
        let shtype = if size > 0 && !file_bytes && all_nobits {
            SHT_NOBITS
        } else if any_input && all_note {
            SHT_NOTE
        } else {
            SHT_PROGBITS
        };
        // A group is an input-side construct and its member index does
        // not survive the link, so bfd clears SHF_GROUP; the retain
        // flag describes the content and does survive. Link order is
        // a property of the whole output section, so bfd takes it from
        // the section opening the output and from no other.
        let mut flags = in_flags & !(SHF_GROUP | SHF_INFO_LINK | SHF_EXCLUDE | SHF_LINK_ORDER);
        if self
            .first_input(oi)
            .is_some_and(|i| self.insec(i).flags & SHF_LINK_ORDER != 0)
        {
            flags |= SHF_LINK_ORDER;
        }
        let uniform = !in_flag_set.is_empty()
            && in_flag_set.iter().all(|&f| f == in_flag_set[0])
            && entsizes.iter().all(|&e| e == entsizes[0]);
        let entsize = if uniform { entsizes[0] } else { 0 };
        if !uniform {
            flags &= !(SHF_MERGE | SHF_STRINGS);
        }
        if alloc && (any_input || file_bytes || size > 0) {
            flags |= SHF_ALLOC;
        }
        if !alloc {
            flags &= !SHF_ALLOC;
        }
        // RELA/RELR synthesized content keeps its own type.
        if self.outs[oi].name == self.dyn_reloc_name() && self.opts.emit == LdsEmit::Dyn && size > 0
        {
            // keep type from the synth input (SHT_RELA)
        }

        {
            let o = &mut self.outs[oi];
            o.size = size;
            o.align = sec_align;
            o.flags = flags;
            o.shtype = if noload { SHT_NOBITS } else { shtype };
            o.entsize = entsize;
            o.alloc = alloc;
            o.chunks = chunks;
            o.file_bytes = file_bytes;
            o.removed = false;
        }
        // Synth inputs give the output their type (RELA/RELR/NOTE).
        if let Some(t) = self.synth_out_type(oi) {
            self.outs[oi].shtype = t;
        }

        if alloc {
            self.dot = start + size;
            // LMA.
            let lma = if let Some(at) = &at {
                let v = self.eval_with_dot(at, start).v;
                self.lma_delta = v.wrapping_sub(start);
                v
            } else if self.lma_delta != 0 {
                start.wrapping_add(self.lma_delta)
            } else {
                start
            };
            self.outs[oi].lma = lma;
        } else {
            self.outs[oi].lma = self.outs[oi].addr;
            self.dot = saved_dot;
        }
        self.define_start_stop(oi);
        self.cur_out = None;
    }

    /// Every symbol the script assigns, at file scope, in the
    /// statement stream, or inside an output section.
    pub(super) fn collect_script_assigned(&mut self) {
        let mut out: HashSet<String> = HashSet::new();
        for c in &self.script.commands {
            if let Command::Assign(a) = c {
                out.insert(a.symbol.clone());
            }
        }
        for st in &self.stmts {
            if let Stmt::Assign(a) = st {
                out.insert(a.symbol.clone());
            }
        }
        for o in &self.outs {
            for p in &o.pieces {
                if let Piece::Assign(a) = p {
                    out.insert(a.symbol.clone());
                }
            }
        }
        self.script_assigned = out;
    }

    /// Bound an output section whose name is a C identifier with
    /// `__start_<name>` / `__stop_<name>`, as bfd's
    /// `lang_init_start_stop` does. Both follow PROVIDE's rule -- a
    /// referenced, otherwise-undefined name only -- and take the
    /// section's binding and visibility, not the script-symbol
    /// defaults: GLOBAL PROTECTED, matching `-z
    /// start-stop-visibility`'s default.
    fn define_start_stop(&mut self, oi: usize) {
        let (name, addr, size, alloc) = {
            let o = &self.outs[oi];
            (o.name.clone(), o.addr, o.size, o.alloc)
        };
        if !alloc || !is_c_identifier(&name) {
            return;
        }
        for (prefix, value) in [("__start_", addr), ("__stop_", addr + size)] {
            let sym = alloc::format!("{prefix}{name}");
            if self.globals.contains_key(&sym)
                || self.script_assigned.contains(&sym)
                || !self.referenced.contains(&sym)
            {
                continue;
            }
            self.script_now.insert(
                sym,
                ScriptSym {
                    val: Val {
                        v: value,
                        att: Att::Out(oi),
                    },
                    hidden: false,
                    kind: STT_NOTYPE,
                    final_out: Some(oi),
                    vis: Some(STV_PROTECTED),
                },
            );
        }
    }

    fn synth_out_type(&self, oi: usize) -> Option<u32> {
        for p in &self.outs[oi].pieces {
            if let Piece::Inputs(v) = p {
                for &i in v {
                    let id = self.insecs[i];
                    if id.obj == self.synth_obj {
                        let t = self.objects[id.obj].sections[id.sec].shtype;
                        if matches!(
                            t,
                            SHT_RELA
                                | SHT_RELR
                                | SHT_STRTAB
                                | dynamic::SHT_HASH
                                | dynamic::SHT_DYNAMIC
                                | dynamic::SHT_DYNSYM
                                | dynamic::SHT_GNU_HASH
                                | dynamic::SHT_GNU_VERDEF
                                | dynamic::SHT_GNU_VERSYM
                        ) {
                            return Some(t);
                        }
                    }
                }
            }
        }
        None
    }
}
