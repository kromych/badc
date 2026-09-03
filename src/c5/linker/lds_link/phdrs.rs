//! Program headers.

use crate::c5::error::C5Error;
use crate::c5::linker::lds::PhdrDef;
use alloc::format;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::{
    EM_AARCH64, Elf64Phdr, LdsLinker, PF_R, PF_W, PF_X, PT_DYNAMIC, PT_GNU_EH_FRAME,
    PT_GNU_PROPERTY, PT_GNU_STACK, PT_INTERP, PT_LOAD, PT_NOTE, PT_PHDR, SHF_EXECINSTR, SHF_TLS,
    SHF_WRITE, SHT_NOBITS, SHT_NOTE, SYNTH_DYNAMIC, SYNTH_EH_FRAME_HDR, SYNTH_GNU_PROPERTY,
    SYNTH_INTERP, Stmt, align_up, err,
};

impl<'a> LdsLinker<'a> {
    /// bfd's `CONSTANT(COMMONPAGESIZE)`: 4 KiB on x86-64, 64 KiB on
    /// aarch64, and never above the configured maximum.
    pub(super) fn common_page_size(&self) -> u64 {
        let common = if self.machine == EM_AARCH64 {
            0x10000
        } else {
            0x1000
        };
        common.min(self.opts.max_page_size)
    }

    /// Output sections the writer will emit, in statement order. The
    /// same selection `finish` makes, without settling anything.
    pub(super) fn kept_order(&self) -> Vec<usize> {
        self.stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .filter(|&oi| self.outs[oi].name != "/DISCARD/" && self.outs[oi].size != 0)
            .collect()
    }

    /// What `SIZEOF_HEADERS` counts. A `PHDRS` command states it; the
    /// default segment set is measured from a settled layout and fed
    /// back, since a script places its first section past the headers
    /// and a count short of the truth leaves that section below them.
    pub(super) fn phdr_count_estimate(&self) -> usize {
        self.script.phdrs().map(|p| p.len()).unwrap_or(self.phdrs)
    }

    pub(super) fn build_phdrs(
        &mut self,
        emit_order: &[usize],
    ) -> Result<Vec<(Elf64Phdr, Vec<usize>)>, C5Error> {
        let script = self.script;
        let mut segs = match script.phdrs() {
            Some(defs) => self.script_phdrs(defs, emit_order)?,
            None => self.default_phdrs(emit_order),
        };
        self.set_phdr_alignments(&mut segs);
        Ok(segs)
    }

    /// The segments a `PHDRS` command declares, with the sections each
    /// `:phdr` reference assigns to them.
    fn script_phdrs(
        &mut self,
        defs: &[PhdrDef],
        emit_order: &[usize],
    ) -> Result<Vec<(Elf64Phdr, Vec<usize>)>, C5Error> {
        let mut segs: Vec<(Elf64Phdr, Vec<usize>)> = defs
            .iter()
            .map(|d| {
                let flags = d.flags.as_ref().map(|e| self.eval(e).v as u32).unwrap_or(0);
                (
                    Elf64Phdr {
                        p_type: d.ptype,
                        p_flags: flags,
                        p_align: if d.ptype == PT_LOAD {
                            self.opts.max_page_size
                        } else {
                            4
                        },
                        ..Default::default()
                    },
                    Vec::new(),
                )
            })
            .collect();
        let name_idx: HashMap<&str, usize> = defs
            .iter()
            .enumerate()
            .map(|(i, d)| (d.name.as_str(), i))
            .collect();
        // `:phdr` carries to following sections that name none.
        // The carry runs over the script's section list, not the
        // kept one, so an empty section still passes its
        // assignment on -- an empty `.hash` ahead of `.gnu.hash`
        // is how the vDSO scripts rely on it.
        let kept: HashSet<usize> = emit_order.iter().copied().collect();
        let mut inherit: Vec<usize> = Vec::new();
        for st in &self.stmts {
            let Stmt::Open(oi) = st else { continue };
            let oi = *oi;
            if !self.outs[oi].alloc && kept.contains(&oi) {
                continue;
            }
            let named = &self.outs[oi].phdrs;
            if !named.is_empty() {
                let mut set = Vec::new();
                for n in named {
                    match name_idx.get(n.as_str()) {
                        Some(&k) => set.push(k),
                        None => {
                            return Err(err(&format!(
                                "output section `{}' names unknown program header `{n}'",
                                self.outs[oi].name
                            )));
                        }
                    }
                }
                inherit = set;
            }
            if !kept.contains(&oi) || !self.outs[oi].alloc {
                continue;
            }
            for &k in &inherit {
                segs[k].1.push(oi);
            }
        }
        Ok(segs)
    }

    /// bfd's default segment assignment
    /// (`_bfd_elf_map_sections_to_segments`): the PT_LOAD runs, a
    /// PT_NOTE per run of note sections, the table segments, and
    /// PT_PHDR ahead of an interpreted image.
    fn default_phdrs(&self, emit_order: &[usize]) -> Vec<(Elf64Phdr, Vec<usize>)> {
        let mut segs = self.load_segments(emit_order);
        for run in self.note_runs(emit_order) {
            segs.push((
                Elf64Phdr {
                    p_type: PT_NOTE,
                    p_flags: PF_R,
                    p_align: 4,
                    ..Default::default()
                },
                run,
            ));
        }
        // PT_DYNAMIC over `.dynamic`, so a loader finds the tables
        // without walking section headers; PT_GNU_EH_FRAME over
        // `.eh_frame_hdr`, which is how an unwinder finds it;
        // PT_GNU_PROPERTY over the merged note, which is where a
        // loader looks for the image's feature claims.
        for (name, ptype, flags, align) in [
            (SYNTH_INTERP, PT_INTERP, PF_R, 1),
            (SYNTH_DYNAMIC, PT_DYNAMIC, PF_R | PF_W, 8),
            (SYNTH_EH_FRAME_HDR, PT_GNU_EH_FRAME, PF_R, 8),
            (SYNTH_GNU_PROPERTY, PT_GNU_PROPERTY, PF_R, 8),
        ] {
            if let Some(&oi) = emit_order
                .iter()
                .find(|&&oi| self.outs[oi].alloc && self.outs[oi].name == name)
            {
                segs.push((
                    Elf64Phdr {
                        p_type: ptype,
                        p_flags: flags,
                        p_align: align,
                        ..Default::default()
                    },
                    alloc::vec![oi],
                ));
            }
        }
        segs.push((
            Elf64Phdr {
                p_type: PT_GNU_STACK,
                p_flags: PF_R | PF_W,
                p_align: 0x10,
                ..Default::default()
            },
            Vec::new(),
        ));
        // An interpreted image needs PT_PHDR ahead of every
        // loadable entry: a loader takes the load bias from it, and
        // bfd pairs it with PT_INTERP for that reason. Its extent
        // is the header table itself, filled once the count and the
        // first segment's address are known.
        if emit_order
            .iter()
            .any(|&oi| self.outs[oi].alloc && self.outs[oi].name == SYNTH_INTERP)
        {
            segs.insert(
                0,
                (
                    Elf64Phdr {
                        p_type: PT_PHDR,
                        p_flags: PF_R,
                        p_align: 8,
                        ..Default::default()
                    },
                    Vec::new(),
                ),
            );
        }
        segs
    }

    /// The PT_LOAD runs. A new one begins where the section would
    /// leave a page of the segment unused, where the LMA stops
    /// tracking the VMA, and where the protection changes -- the last
    /// only when the section does not share the previous one's page,
    /// since a page carries one protection anyway. File-backed
    /// content following zero fill stays in the segment; the zero fill
    /// then occupies file space.
    fn load_segments(&self, emit_order: &[usize]) -> Vec<(Elf64Phdr, Vec<usize>)> {
        let page = self.opts.max_page_size.max(1);
        let mut segs: Vec<(Elf64Phdr, Vec<usize>)> = Vec::new();
        let mut cur: Option<usize> = None;
        let mut cur_writable = false;
        let mut cur_code = false;
        let mut prev_end = 0u64;
        let mut prev_bias = 0u64;
        for &oi in emit_order {
            let o = &self.outs[oi];
            if !o.alloc {
                continue;
            }
            let writable = o.flags & SHF_WRITE != 0;
            let code = o.flags & SHF_EXECINSTR != 0;
            let nobits = o.shtype == SHT_NOBITS;
            let bias = o.lma.wrapping_sub(o.addr);
            let same_page = prev_end.saturating_sub(1) & !(page - 1) == o.addr & !(page - 1);
            let protection_change = (writable && !cur_writable) || code != cur_code;
            let start_new = match cur {
                None => true,
                Some(_) => {
                    bias != prev_bias
                        || align_up(prev_end, page) < align_up(o.addr, page)
                        || (protection_change && !same_page)
                }
            };
            if start_new {
                segs.push((
                    Elf64Phdr {
                        p_type: PT_LOAD,
                        p_flags: PF_R,
                        p_align: page,
                        ..Default::default()
                    },
                    Vec::new(),
                ));
                cur = Some(segs.len() - 1);
                cur_writable = writable;
                cur_code = code;
            }
            cur_writable |= writable;
            cur_code |= code;
            prev_bias = bias;
            // Zero-size TLS zero fill overlays the following
            // section rather than occupying its own addresses.
            if !nobits || o.flags & SHF_TLS == 0 {
                prev_end = o.addr + o.size;
            }
            let k = cur.expect("current segment exists");
            segs[k].1.push(oi);
            let mut fl = PF_R;
            if writable {
                fl |= PF_W;
            }
            if code {
                fl |= PF_X;
            }
            segs[k].0.p_flags |= fl;
        }
        segs
    }

    /// Runs of contiguous allocated NOTE sections, one PT_NOTE each.
    /// A segment covers a range, so a note section separated from the
    /// previous one by anything else starts a new run rather than
    /// pulling what lies between into the walk a consumer makes over
    /// the segment.
    fn note_runs(&self, emit_order: &[usize]) -> Vec<Vec<usize>> {
        let mut note_members: Vec<usize> = Vec::new();
        let mut note_runs: Vec<Vec<usize>> = Vec::new();
        for &oi in emit_order {
            let o = &self.outs[oi];
            let contiguous = note_members
                .last()
                .map(|&p: &usize| self.outs[p].addr + self.outs[p].size == o.addr)
                .unwrap_or(true);
            if o.alloc && o.shtype == SHT_NOTE && contiguous {
                note_members.push(oi);
                continue;
            }
            if !note_members.is_empty() {
                note_runs.push(core::mem::take(&mut note_members));
            }
            if o.alloc && o.shtype == SHT_NOTE {
                note_members.push(oi);
            }
        }
        if !note_members.is_empty() {
            note_runs.push(note_members);
        }
        note_runs
    }

    /// Segment alignment once membership is known: a `PT_LOAD` pages
    /// unless `-n` asked otherwise, and every other segment takes the
    /// strongest alignment among its sections, as bfd's does.
    fn set_phdr_alignments(&self, segs: &mut [(Elf64Phdr, Vec<usize>)]) {
        for (ph, members) in segs.iter_mut() {
            let member_align = members
                .iter()
                .map(|&oi| self.outs[oi].align)
                .max()
                .unwrap_or(0);
            if ph.p_type == PT_LOAD {
                if self.opts.nmagic {
                    ph.p_align = member_align.max(1);
                }
            } else if member_align != 0 {
                ph.p_align = member_align;
            }
        }
    }
}
