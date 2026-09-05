//! SHF_MERGE pools and `.eh_frame` CIE deduplication.

use crate::c5::linker::eh_frame;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::inputs::RawReloc;
use super::{
    EM_X86_64, EhFrame, LdsLinker, MergePool, OUT_EH_FRAME, Piece, SHF_MERGE, SHF_STRINGS,
    SHT_PROGBITS, SHT_X86_64_UNWIND, STB_LOCAL, STT_SECTION, SecFate, align_up,
};

/// Per-member `(input offsets, pooled offsets)` produced by pool builders.
type PoolMemberMaps = HashMap<usize, (Vec<u64>, Vec<u64>)>;

/// Whether `shtype` is one `.eh_frame` arrives with on `machine`:
/// SHT_PROGBITS everywhere, and the psABI's SHT_X86_64_UNWIND on
/// x86-64, which gcc and clang both emit.
fn eh_frame_shtype(machine: u16, shtype: u32) -> bool {
    shtype == SHT_PROGBITS || (machine == EM_X86_64 && shtype == SHT_X86_64_UNWIND)
}

/// Identity of a CIE for deduplication: the bytes after its length
/// field, and the relocations covering it.
#[derive(PartialEq, Eq, Hash)]
struct CieKey {
    bytes: Vec<u8>,
    relocs: Vec<(u64, u32, String, i64)>,
}

/// One CIE copy, by the input section holding it and its offset there.
type CieId = (usize, usize);

/// A `.eh_frame` input's entries and the fate of each: for a CIE the
/// copy that represents it, for an FDE the CIE it will name, and
/// `None` for an FDE whose code left the link.
struct EhSurvey {
    ents: Vec<eh_frame::Entry>,
    owner: Vec<Option<CieId>>,
}

impl<'a> LdsLinker<'a> {
    /// Deduplicate SHF_MERGE sections without relocations, following
    /// bfd's merge pass (`bfd/merge.c`): a separate pool per output
    /// section and (entsize, strings, alignment) class. A section
    /// whose entsize/alignment relation fails bfd's sanity check, or
    /// whose size is not an entsize multiple, stays unmerged. The
    /// pool replaces the first member's bytes; other members
    /// contribute nothing and their offsets remap.
    pub(super) fn build_merge_pools(&mut self) {
        #[derive(PartialEq, Eq, Hash)]
        struct Key {
            entsize: u64,
            strings: bool,
            align: u64,
        }
        let mut groups: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
        let mut group_key: Vec<Key> = Vec::new();
        let mut key_index: HashMap<(usize, u64, bool, u64), usize> = HashMap::new();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            let s = self.insec(i);
            if s.flags & SHF_MERGE == 0 || !s.relocs.is_empty() || s.shtype != SHT_PROGBITS {
                continue;
            }
            let strings = s.flags & SHF_STRINGS != 0;
            let entsize = s.entsize;
            if s.size == 0
                || s.size > u32::MAX as u64
                || entsize == 0
                || !s.size.is_multiple_of(entsize)
            {
                continue;
            }
            let align = s.addralign.max(1);
            // bfd: an entsize below the alignment must be a power of
            // two and marks strings; above it, an exact multiple.
            if !align.is_power_of_two()
                || (entsize < align && (!entsize.is_power_of_two() || !strings))
                || (entsize > align && !entsize.is_multiple_of(align))
            {
                continue;
            }
            let tup = (out, entsize, strings, align);
            let gid = *key_index.entry(tup).or_insert_with(|| {
                group_key.push(Key {
                    entsize,
                    strings,
                    align,
                });
                group_key.len() - 1
            });
            groups.entry(gid).or_default().push(i);
        }
        for (gid, members) in &groups {
            let key = &group_key[*gid];
            let (pool_bytes, member_maps) =
                self.build_pool(members, key.entsize, key.strings, key.align);
            let rep = *members
                .iter()
                .min()
                .expect("merge group has at least one member");
            let pool_idx = self.pools.len();
            self.pools.push(MergePool {
                bytes: pool_bytes,
                maps: member_maps,
                rep,
                align: key.align,
            });
            for &m in members {
                self.merge_of.insert(m, pool_idx);
            }
        }
    }

    /// Build one merge pool the way bfd does. Entries are recorded in
    /// member/offset order and deduplicated on identity; an entry's
    /// required alignment is the largest power of two dividing any
    /// input offset it appears at (capped at the section alignment,
    /// offset 0 counting as fully aligned). Strings additionally
    /// share suffixes. Offsets are assigned in first-seen order with
    /// per-entry alignment padding; the pool tail pads to the section
    /// alignment when every member's size is a multiple of it.
    fn build_pool(
        &self,
        members: &[usize],
        entsize: u64,
        strings: bool,
        align: u64,
    ) -> (Vec<u8>, PoolMemberMaps) {
        struct Entry {
            /// Content including the terminator for strings.
            bytes: Vec<u8>,
            /// Required start alignment; 0 once suffix-merged.
            align: u64,
            index: u64,
            suffix_of: usize,
        }
        let es = entsize as usize;
        let mut entries: Vec<Entry> = Vec::new();
        let mut interned: HashMap<Vec<u8>, usize> = HashMap::new();
        let mut member_refs: Vec<(usize, Vec<u64>, Vec<usize>)> = Vec::new();
        let mut pad_tail = true;
        for &m in members {
            let id = self.insecs[m];
            let data = {
                let o = &self.objects[id.obj];
                o.section_data(&o.sections[id.sec]).to_owned()
            };
            pad_tail &= (data.len() as u64).is_multiple_of(align);
            let (mut starts, mut ids) = (Vec::new(), Vec::new());
            let mut pos = 0usize;
            while pos < data.len() {
                let len = if strings {
                    // Entry runs through its all-zero terminator
                    // unit; an unterminated tail gains a synthetic
                    // one (bfd appends entsize zeros to the buffer).
                    let mut k = pos;
                    loop {
                        if k >= data.len() {
                            break data.len() - pos + es;
                        }
                        if data[k..data.len().min(k + es)].iter().all(|&b| b == 0) {
                            break k + es - pos;
                        }
                        k += es;
                    }
                } else {
                    es
                };
                let mut bytes = data[pos..data.len().min(pos + len)].to_vec();
                bytes.resize(len, 0);
                let eltalign = if pos == 0 {
                    align
                } else {
                    (1u64 << pos.trailing_zeros()).min(align)
                };
                let eid = *interned.entry(bytes.clone()).or_insert_with(|| {
                    entries.push(Entry {
                        bytes,
                        align: 0,
                        index: 0,
                        suffix_of: usize::MAX,
                    });
                    entries.len() - 1
                });
                entries[eid].align = entries[eid].align.max(eltalign);
                starts.push(pos as u64);
                ids.push(eid);
                pos += len;
            }
            member_refs.push((m, starts, ids));
        }
        if strings && !entries.is_empty() {
            // bfd merge_strings: sort by reversed content (lengths
            // without the terminator) and merge each entry into an
            // alignment-compatible neighbour it is a suffix of.
            let content_len = |e: &Entry| e.bytes.len() - es;
            let uniform = entries[1..]
                .iter()
                .all(|e| e.align == entries[0].align)
                .then(|| entries[0].align)
                .filter(|&a| a > entsize);
            let revcmp = |a: &Entry, b: &Entry| -> core::cmp::Ordering {
                let (la, lb) = (content_len(a), content_len(b));
                if let Some(al) = uniform {
                    let t = (la as u64 & (al - 1)).cmp(&(lb as u64 & (al - 1)));
                    if t != core::cmp::Ordering::Equal {
                        return t;
                    }
                }
                let l = la.min(lb);
                for k in 1..=l {
                    let t = a.bytes[la - k].cmp(&b.bytes[lb - k]);
                    if t != core::cmp::Ordering::Equal {
                        return t;
                    }
                }
                la.cmp(&lb)
            };
            let mut order: Vec<usize> = (0..entries.len()).collect();
            order.sort_by(|&x, &y| revcmp(&entries[x], &entries[y]));
            let mut e = order[order.len() - 1];
            for &cmp in order[..order.len() - 1].iter().rev() {
                let (el, cl) = (entries[e].bytes.len(), entries[cmp].bytes.len());
                if entries[e].align >= entries[cmp].align
                    && el > cl
                    && ((el - cl) as u64).is_multiple_of(entries[cmp].align)
                    && entries[e].bytes[el - cl..] == entries[cmp].bytes[..]
                {
                    entries[cmp].suffix_of = e;
                    entries[cmp].align = 0;
                } else {
                    e = cmp;
                }
            }
        }
        let mut size = 0u64;
        for e in entries.iter_mut() {
            if e.align != 0 {
                size = align_up(size, e.align);
                e.index = size;
                size += e.bytes.len() as u64;
            }
        }
        for k in 0..entries.len() {
            let t = entries[k].suffix_of;
            if t != usize::MAX {
                entries[k].index =
                    entries[t].index + (entries[t].bytes.len() - entries[k].bytes.len()) as u64;
            }
        }
        if pad_tail {
            size = align_up(size, align);
        }
        let mut pool = vec![0u8; size as usize];
        for e in &entries {
            if e.align != 0 {
                pool[e.index as usize..e.index as usize + e.bytes.len()].copy_from_slice(&e.bytes);
            }
        }
        let mut maps: HashMap<usize, (Vec<u64>, Vec<u64>)> = HashMap::new();
        for (m, starts, ids) in member_refs {
            let targets: Vec<u64> = ids.iter().map(|&eid| entries[eid].index).collect();
            maps.insert(m, (starts, targets));
        }
        (pool, maps)
    }

    /// Remap an offset into a merged input section to its pool
    /// offset: the covering entry's position plus the delta into it.
    /// At or past the input's end the offset maps to the pool's end,
    /// as bfd resolves end-of-section references.
    fn merge_remap(&self, insec: usize, off: u64) -> u64 {
        let pool = &self.pools[self.merge_of[&insec]];
        if off >= self.insec(insec).size {
            return pool.bytes.len() as u64;
        }
        let (starts, targets) = &pool.maps[&insec];
        match starts.binary_search(&off) {
            Ok(k) => targets[k],
            Err(0) => off, // before first entry: identity
            Err(k) => targets[k - 1] + (off - starts[k - 1]),
        }
    }

    /// The offset of a section-symbol reference into a merge pool that
    /// the input section does not cover, which bfd reports as `access
    /// beyond end of merged section`. Such an addend names no entry and
    /// resolves to the pool's end.
    pub(super) fn merge_offset_out_of_range(&self, oi: usize, r: &RawReloc) -> Option<i64> {
        if self.merge_of.is_empty() {
            return None;
        }
        let sym = self.objects[oi].symbols.get(r.sym as usize)?;
        if sym.kind() != STT_SECTION {
            return None;
        }
        let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
        let i = self.insec_index(oi, sec);
        self.merge_of.get(&i)?;
        let off = sym.value.wrapping_add(r.addend as u64);
        (off > self.insec(i).size).then_some(off as i64)
    }

    /// Effective placed size of input section `i` (0 for non-
    /// representative members of a merge pool).
    pub(super) fn insec_placed_size(&self, i: usize) -> u64 {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return self.pools[p].bytes.len() as u64;
            }
            return 0;
        }
        if let Some(&e) = self.eh_of.get(&i) {
            return self.eh_frames[e].bytes.len() as u64;
        }
        self.insec(i).size
    }

    /// Offset `off` into input section `i` after the content transforms
    /// that move bytes within it. `None` when the byte is gone.
    pub(super) fn placed_off(&self, i: usize, off: u64) -> Option<u64> {
        if self.merge_of.contains_key(&i) {
            return Some(self.merge_remap(i, off));
        }
        match self.eh_of.get(&i) {
            Some(&e) => self.eh_frames[e].remap(off),
            None => Some(off),
        }
    }

    /// Rewrite the `.eh_frame` inputs of one output section the way
    /// bfd's `elf-eh-frame.c` does: identical CIEs fold into the first
    /// copy in output order, an FDE describing code that left the link
    /// goes, and a CIE no surviving FDE names goes with it. Two CIEs
    /// are one when the bytes after their length field and the
    /// relocations covering them agree; bfd compares a CIE's parsed
    /// fields and the symbol its personality resolves to, and those
    /// follow from byte and relocation equality.
    ///
    /// Which CIEs survive is settled over the whole output section
    /// before any input is rewritten: an FDE in a later input keeps a
    /// CIE in an earlier one alive, so a single pass could not decide
    /// it.
    pub(super) fn build_eh_frame_dedup(&mut self) {
        let mut order: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
        for oi in 0..self.outs.len() {
            for p in &self.outs[oi].pieces {
                let Piece::Inputs(v) = p else { continue };
                for &i in v {
                    let s = self.insec(i);
                    if s.name == OUT_EH_FRAME
                        && eh_frame_shtype(self.machine, s.shtype)
                        && s.size != 0
                    {
                        order.entry(oi).or_default().push(i);
                    }
                }
            }
        }
        let mut built: Vec<(usize, EhFrame)> = Vec::new();
        for inputs in order.values() {
            let mut canon: HashMap<CieKey, CieId> = HashMap::new();
            let mut used: HashSet<CieId> = HashSet::new();
            let surveys: Vec<Option<EhSurvey>> = inputs
                .iter()
                .map(|&i| self.survey_eh_frame(i, &mut canon, &mut used))
                .collect();
            // Offset a surviving CIE landed at, for the FDEs naming it.
            let mut placed: HashMap<CieId, (usize, u64)> = HashMap::new();
            for (&i, survey) in inputs.iter().zip(&surveys) {
                let Some(s) = survey else { continue };
                if let Some(f) = self.rewrite_eh_frame(i, s, &used, &mut placed) {
                    built.push((i, f));
                }
            }
        }
        for (i, f) in built {
            self.eh_of.insert(i, self.eh_frames.len());
            self.eh_frames.push(f);
        }
    }

    /// Whether the first relocated field in `[off, off + len)` of
    /// input section `i` names a definition that leaves the link. In
    /// an FDE that field is the initial location, which is what
    /// decides whether the entry still describes anything.
    fn covers_discarded(&self, i: usize, off: usize, len: usize) -> bool {
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        o.sections[id.sec]
            .relocs
            .iter()
            .filter(|r| (r.offset as usize) >= off && (r.offset as usize) < off + len)
            .min_by_key(|r| r.offset)
            .is_some_and(|r| self.defines_discarded(id.obj, r.sym as usize))
    }

    fn defines_discarded(&self, oi: usize, si: usize) -> bool {
        let Some(sym) = self.objects[oi].symbols.get(si) else {
            return false;
        };
        let (doi, dsi) = if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            match self.globals.get(&sym.name) {
                Some(&d) => d,
                None => return self.dropped_home(oi, sym).is_some(),
            }
        } else {
            (oi, si)
        };
        let home = &self.objects[doi].symbols[dsi].shndx;
        match self.objects[doi].shndx_map.get(home) {
            Some(&sec) => self.fates[self.insec_index(doi, sec)] == SecFate::Discarded,
            None => false,
        }
    }

    /// Decide the fate of one `.eh_frame` input's entries, registering
    /// its CIEs in its output section's table and marking the ones a
    /// surviving FDE needs. `None` leaves the input untouched.
    fn survey_eh_frame(
        &self,
        i: usize,
        canon: &mut HashMap<CieKey, CieId>,
        used: &mut HashSet<CieId>,
    ) -> Option<EhSurvey> {
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        let data = o.section_data(&o.sections[id.sec]);
        let ents = eh_frame::entries(data).ok()?;
        // An FDE names its CIE by a distance back from its own pointer
        // field, so a well-formed input has that CIE among the entries
        // ahead of it. Reject the rest before any of it is registered.
        let cie_offs: HashSet<usize> = ents
            .iter()
            .filter(|e| e.cie.is_none())
            .map(|e| e.off)
            .collect();
        if ents
            .iter()
            .any(|e| e.cie.is_some_and(|at| !cie_offs.contains(&at)))
        {
            return None;
        }
        let mut local: HashMap<usize, CieId> = HashMap::new();
        let mut owner: Vec<Option<CieId>> = Vec::with_capacity(ents.len());
        for e in &ents {
            match e.cie {
                None => {
                    let c = *canon.entry(self.cie_key(i, data, e)).or_insert((i, e.off));
                    local.insert(e.off, c);
                    owner.push(Some(c));
                }
                // An FDE describing code that left the link describes
                // nothing; bfd drops the entry rather than relocate it.
                Some(_) if self.covers_discarded(i, e.off, e.len) => owner.push(None),
                Some(at) => {
                    let c = *local.get(&at)?;
                    used.insert(c);
                    owner.push(Some(c));
                }
            }
        }
        Some(EhSurvey { ents, owner })
    }

    /// Emit one `.eh_frame` input under the fates the survey settled.
    /// `None` when every entry stays where it is, which leaves the
    /// input's bytes and offsets untouched.
    fn rewrite_eh_frame(
        &self,
        i: usize,
        survey: &EhSurvey,
        used: &HashSet<CieId>,
        placed: &mut HashMap<CieId, (usize, u64)>,
    ) -> Option<EhFrame> {
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        let data = o.section_data(&o.sections[id.sec]);
        let ents = &survey.ents;
        let mut bytes: Vec<u8> = Vec::with_capacity(data.len());
        let mut kept: Vec<(u64, u64, u64)> = Vec::new();
        let mut fdes: Vec<(u64, usize, u64)> = Vec::new();
        let mut dropped = false;
        for (e, owner) in ents.iter().zip(&survey.owner) {
            match (e.cie, owner) {
                (_, None) => {
                    dropped = true;
                    continue;
                }
                (None, Some(c)) => {
                    // A duplicate copy, or one no surviving FDE names.
                    if *c != (i, e.off) || !used.contains(c) {
                        dropped = true;
                        continue;
                    }
                    placed.insert(*c, (i, bytes.len() as u64));
                }
                (Some(_), Some(c)) => {
                    let (sec, off) = *placed.get(c)?;
                    fdes.push((bytes.len() as u64, sec, off));
                }
            }
            kept.push((e.off as u64, e.len as u64, bytes.len() as u64));
            bytes.extend_from_slice(&data[e.off..e.off + e.len]);
        }
        // Whatever follows the last entry (a terminator, padding) is
        // not addressed by any of them and carries over verbatim.
        let tail = ents.last().map_or(0, |e| e.off + e.len);
        kept.push((tail as u64, (data.len() - tail) as u64, bytes.len() as u64));
        bytes.extend_from_slice(&data[tail..]);
        // An entry stream stopping short of the section's alignment
        // would leave the padding before the next input inside the
        // linked stream, where a zero length ends it. bfd gives the
        // padding to the last entry instead; so does this.
        let align = self.insec(i).addralign.max(1) as usize;
        let padded = tail == data.len() && kept.len() > 1 && !bytes.len().is_multiple_of(align);
        if padded {
            let at = kept[kept.len() - 2].2 as usize;
            let pad = align - bytes.len() % align;
            let len = u32::from_le_bytes(bytes[at..at + 4].try_into().ok()?) + pad as u32;
            bytes[at..at + 4].copy_from_slice(&len.to_le_bytes());
            bytes.resize(bytes.len() + pad, 0);
        }
        if !dropped && !padded {
            return None;
        }
        Some(EhFrame {
            orig_size: data.len() as u64,
            bytes,
            kept,
            fdes,
        })
    }

    fn cie_key(&self, i: usize, data: &[u8], e: &eh_frame::Entry) -> CieKey {
        let id = self.insecs[i];
        let s = &self.objects[id.obj].sections[id.sec];
        let (start, end) = (e.off as u64, (e.off + e.len) as u64);
        let relocs = s
            .relocs
            .iter()
            .filter(|r| r.offset >= start && r.offset < end)
            .map(|r| {
                // A local symbol is named by nothing an object outside
                // its own can match, so it keeps the CIE to itself.
                let sym = &self.objects[id.obj].symbols[r.sym as usize];
                let name = match sym.binding() {
                    STB_LOCAL => format!("{}:{}", id.obj, r.sym),
                    _ => sym.name.clone(),
                };
                (r.offset - start, r.rtype, name, r.addend)
            })
            .collect();
        CieKey {
            bytes: data[e.off + 4..e.off + e.len].to_vec(),
            relocs,
        }
    }

    /// Point every FDE of a rewritten input at the CIE that survived.
    /// The field holds the distance back from itself to the CIE, so it
    /// settles only once both have been placed.
    pub(super) fn patch_eh_frame(&self, contents: &mut HashMap<usize, Vec<u8>>) {
        for (&i, &e) in &self.eh_of {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            let Some(buf) = contents.get_mut(&out) else {
                continue;
            };
            let base = self.placements[i].off;
            for &(fde, cie_sec, cie_off) in &self.eh_frames[e].fdes {
                let field = base + fde + eh_frame::CIE_POINTER as u64;
                let cie = self.placements[cie_sec].off + cie_off;
                let (Some(v), true) = (
                    field.checked_sub(cie).and_then(|d| u32::try_from(d).ok()),
                    field + 4 <= buf.len() as u64,
                ) else {
                    continue;
                };
                buf[field as usize..field as usize + 4].copy_from_slice(&v.to_le_bytes());
            }
        }
    }

    /// Bytes an input chunk contributes: its own section data, the
    /// merge pool for a pool representative (empty for other members),
    /// or its deduplicated `.eh_frame`.
    pub(super) fn chunk_input_bytes(&self, i: usize) -> &[u8] {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return &self.pools[p].bytes;
            }
            return &[];
        }
        if let Some(&e) = self.eh_of.get(&i) {
            return &self.eh_frames[e].bytes;
        }
        let id = self.insecs[i];
        let o = &self.objects[id.obj];
        let s = &o.sections[id.sec];
        if id.obj == self.synth_obj {
            // Synthetic sections have no backing bytes here; content
            // is written by `fill_synth_contents`.
            return &[];
        }
        o.section_data(s)
    }
}
