//! Relocation application on the final pass; the x86 arms.

use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::linker::object::elf_reloc_desc;
use crate::c5::object::elf_reloc_types as rt;
use crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL as GOT_SYMBOL;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use super::got::R_X86_64_GOTPCRELX;
use super::inputs::RawReloc;
use super::sections::{is_debug_section, is_unwind_section};
use super::{
    EM_386, EM_AARCH64, EM_X86_64, EmittedReloc, LdsLinker, MODULE, R_NONE, SHN_ABS, SHN_COMMON,
    SHN_UNDEF, SHT_NOBITS, STB_LOCAL, STB_WEAK, SecFate,
};
use crate::c5::linker::link_err;

impl<'a> LdsLinker<'a> {
    pub(super) fn apply_relocations(
        &mut self,
        contents: &mut HashMap<usize, Vec<u8>>,
        relr_set: &HashSet<u64>,
    ) -> Result<(), C5Error> {
        let mut errors: Vec<String> = Vec::new();
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].removed || self.outs[out].shtype == SHT_NOBITS {
                continue;
            }
            let id = self.insecs[i];
            if id.obj == self.synth_obj {
                continue;
            }
            if self.objects[id.obj].sections[id.sec].relocs.is_empty() {
                continue;
            }
            let place = self.placements[i];
            let sec_addr = self.outs[out].addr + place.off;
            let alloc = self.outs[out].alloc;
            let name = &self.objects[id.obj].sections[id.sec].name;
            let tolerant = is_debug_section(name) || is_unwind_section(name);
            let relocs = self.objects[id.obj].sections[id.sec].relocs.clone();
            let Some(buf) = contents.get_mut(&out) else {
                continue;
            };
            for r in &relocs {
                // A relocation whose site went away with a duplicate
                // CIE applies nowhere.
                let Some(off) = self.placed_off(i, r.offset) else {
                    continue;
                };
                let site = (place.off + off) as usize;
                let p = sec_addr + off;
                if let Some(bad) = self.merge_offset_out_of_range(id.obj, r) {
                    let source = self.objects[id.obj].source.clone();
                    self.sink.emit(
                        Code::MERGED_SECTION_ACCESS,
                        None,
                        format!("{source}: access beyond end of merged section ({bad})"),
                    );
                }
                let target = self.resolve_reloc_target(id.obj, r, tolerant, &mut errors);
                let Some(s_plus_a) = target else { continue };
                if errors.len() > 40 {
                    break;
                }
                if self.opts.emit_relocs {
                    self.emitted.push(EmittedReloc {
                        out,
                        addr: p,
                        rtype: r.rtype,
                        target: s_plus_a,
                        obj: id.obj,
                        sym: r.sym,
                    });
                }
                if r.rtype == R_NONE {
                    continue; // recorded, applies nothing
                }
                if let Some(e) = self.unrepresentable_in_dyn(id.obj, id.sec, r, alloc) {
                    errors.push(e);
                    continue;
                }
                self.apply_one(
                    buf,
                    site,
                    p,
                    s_plus_a,
                    r,
                    alloc,
                    relr_set,
                    &mut errors,
                    id.obj,
                );
            }
        }
        if !errors.is_empty() {
            errors.truncate(40);
            return Err(link_err(Code::RELOCATION, MODULE, &errors.join("\n")));
        }
        Ok(())
    }

    /// `S + A` for a relocation, or `None` when the reloc is skipped
    /// (undefined weak resolves to zero and still applies).
    /// `tolerant` marks a referring section that describes other
    /// sections rather than depending on them -- debug and unwind
    /// tables -- where bfd resolves a dropped target to zero instead
    /// of complaining.
    fn resolve_reloc_target(
        &self,
        oi: usize,
        r: &RawReloc,
        tolerant: bool,
        errors: &mut Vec<String>,
    ) -> Option<u64> {
        let sym = match self.objects[oi].symbols.get(r.sym as usize) {
            Some(s) => s,
            None => {
                errors.push(format!(
                    "{}: relocation references symbol index {} out of range",
                    self.objects[oi].source, r.sym
                ));
                return None;
            }
        };
        // A named non-local reference resolves through the global
        // table, so a weak definition here yields to a strong one
        // elsewhere; script symbols satisfy references the objects
        // leave undefined.
        let by_name = sym.binding() != STB_LOCAL && !sym.name.is_empty();
        if by_name {
            if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                return match self.resolve_sym_prevpass(doi, dsi, r.addend) {
                    Some(v) => Some(v),
                    None if tolerant => Some(r.addend as u64),
                    None => {
                        errors.push(format!(
                            "{}: `{}' resolves into a discarded section",
                            self.objects[oi].source, sym.name
                        ));
                        None
                    }
                };
            }
            if sym.name == GOT_SYMBOL {
                return self
                    .got_symbol_addr()
                    .map(|g| g.wrapping_add(r.addend as u64));
            }
            if let Some(s) = self.script_now.get(&sym.name) {
                return Some(s.val.v.wrapping_add(r.addend as u64));
            }
            if self.import_of.contains_key(&sym.name) {
                if let Some(v) = self.import_target(&sym.name, r.rtype) {
                    return Some(v.wrapping_add(r.addend as u64));
                }
                errors.push(format!(
                    "{}: {} against `{}' cannot reach a shared library; \
                     the reference needs a GOT slot or a call",
                    self.objects[oi].source,
                    elf_reloc_desc(self.machine, r.rtype),
                    sym.name
                ));
                return None;
            }
        }
        match sym.shndx as u16 {
            SHN_ABS => Some(sym.value.wrapping_add(r.addend as u64)),
            SHN_UNDEF | SHN_COMMON => {
                if sym.binding() == STB_WEAK {
                    // Undefined weak resolves to zero.
                    Some(r.addend as u64)
                } else {
                    errors.push(format!(
                        "{}: undefined reference to `{}'",
                        self.objects[oi].source,
                        if sym.name.is_empty() { "?" } else { &sym.name }
                    ));
                    None
                }
            }
            // Local / section reference into this object; a discarded
            // target resolves to nothing and the site keeps its bytes.
            _ => {
                // The surviving copy of a deduplicated group need bear
                // no relation to the dropped one, so a reference that
                // name resolution above could not place has nowhere to
                // go. GNU ld reports it rather than redirecting.
                if let Some(home) = self.dropped_home(oi, sym) {
                    if tolerant || (by_name && sym.binding() == STB_WEAK) {
                        return Some(r.addend as u64);
                    }
                    let what = if by_name {
                        format!("undefined reference to `{}'", sym.name)
                    } else if sym.name.is_empty() {
                        format!("reference to discarded section `{home}'")
                    } else {
                        format!("`{}' is defined in discarded section `{home}'", sym.name)
                    };
                    errors.push(format!("{}: {what}", self.objects[oi].source));
                    return None;
                }
                self.resolve_sym_prevpass(oi, r.sym as usize, r.addend)
            }
        }
    }

    #[allow(clippy::too_many_arguments)]
    fn apply_one(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        alloc: bool,
        relr_set: &HashSet<u64>,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let machine = self.machine;
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        if site > buf.len() {
            errors.push(format!(
                "{}: relocation offset 0x{:x} outside section",
                self.objects[oi].source, r.offset
            ));
            return;
        }
        let w = |buf: &mut [u8], site: usize, bytes: &[u8]| {
            if site + bytes.len() <= buf.len() {
                buf[site..site + bytes.len()].copy_from_slice(bytes);
                true
            } else {
                false
            }
        };
        match machine {
            EM_X86_64 => match r.rtype {
                rt::R_X86_64_64 => {
                    w(buf, site, &sa.to_le_bytes());
                }
                // GOTPC's symbol is `_GLOBAL_OFFSET_TABLE_`, so `sa` is
                // already the GOT base and the field is the same
                // pc-relative difference the PC forms write.
                rt::R_X86_64_PC64 | rt::R_X86_64_GOTPC64 => {
                    w(buf, site, &sa.wrapping_sub(p).to_le_bytes());
                }
                rt::R_X86_64_PC32 | rt::R_X86_64_PLT32 | rt::R_X86_64_GOTPC32 => {
                    let v = sa.wrapping_sub(p) as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relocation truncated: {} against `{}' (0x{v:x})",
                            rt::x86_64_reloc_desc(r.rtype),
                            name()
                        ));
                    }
                    w(buf, site, &(v as i32).to_le_bytes());
                }
                rt::R_X86_64_32 => {
                    if sa > u32::MAX as u64 {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_32 against `{}' (0x{sa:x})",
                            name()
                        ));
                    }
                    w(buf, site, &(sa as u32).to_le_bytes());
                }
                rt::R_X86_64_32S => {
                    let v = sa as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_32S against `{}' (0x{sa:x})",
                            name()
                        ));
                    }
                    w(buf, site, &(sa as u32).to_le_bytes());
                }
                12 => {
                    // R_X86_64_16
                    w(buf, site, &(sa as u16).to_le_bytes());
                }
                13 => {
                    let v = sa.wrapping_sub(p);
                    w(buf, site, &(v as u16).to_le_bytes());
                }
                14 => {
                    w(buf, site, &[sa as u8]);
                }
                15 => {
                    let v = sa.wrapping_sub(p);
                    w(buf, site, &[v as u8]);
                }
                rt::R_X86_64_GOTPCREL | R_X86_64_GOTPCRELX | rt::R_X86_64_REX_GOTPCRELX => {
                    // An import has no link-time address to relax to;
                    // the site keeps its load from the GOT slot.
                    if self.import_of.contains_key(&name()) {
                        let v = sa.wrapping_sub(p) as i64;
                        w(buf, site, &(v as i32).to_le_bytes());
                        return;
                    }
                    // The kernel scripts assert an empty GOT: relax
                    // the load to a direct reference.
                    if site >= 2 && buf[site - 2] == 0x8b {
                        buf[site - 2] = 0x8d; // mov -> lea
                    } else if site >= 2 && buf[site - 2] == 0xff && buf[site - 1] == 0x15 {
                        buf[site - 2] = 0x67; // call *[rip] -> addr32 call
                        buf[site - 1] = 0xe8;
                    } else if site >= 2 && buf[site - 2] == 0xff && buf[site - 1] == 0x25 {
                        // jmp *[rip] -> jmp rel32; nop. The immediate
                        // moves back one byte.
                        buf[site - 2] = 0xe9;
                        let v = sa.wrapping_sub(p - 1) as i64;
                        w(buf, site - 1, &(v as i32).to_le_bytes());
                        if site + 4 <= buf.len() {
                            buf[site + 3] = 0x90;
                        }
                        return;
                    } else {
                        errors.push(format!(
                            "cannot relax GOT reference against `{}' (insn bytes {:02x} {:02x})",
                            name(),
                            buf.get(site.wrapping_sub(2)).copied().unwrap_or(0),
                            buf.get(site.wrapping_sub(1)).copied().unwrap_or(0),
                        ));
                        return;
                    }
                    let v = sa.wrapping_sub(p) as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relaxed GOT reference out of range against `{}'",
                            name()
                        ));
                    }
                    w(buf, site, &(v as i32).to_le_bytes());
                }
                other => {
                    errors.push(format!(
                        "unsupported relocation {} against `{}'",
                        rt::x86_64_reloc_desc(other),
                        name()
                    ));
                }
            },
            EM_386 => self.apply_i386(buf, site, p, sa, r, errors, oi),
            EM_AARCH64 => self.apply_aarch64(buf, site, p, sa, r, alloc, relr_set, errors, oi),
            _ => errors.push(format!(
                "unsupported machine {}",
                crate::c5::linker::relocatable::elf_machine_desc(machine)
            )),
        }
    }

    /// Intel386 psABI: every type is `S + A`, `S + A - P` or a GOT-base
    /// form, written at the field's own width. bfd complains on
    /// overflow only where the field is narrower than an address.
    #[allow(clippy::too_many_arguments)]
    fn apply_i386(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        errors: &mut Vec<String>,
        oi: usize,
    ) {
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        let v = match r.rtype {
            rt::R_386_32 | rt::R_386_16 | rt::R_386_8 => sa,
            // GOTPC's symbol is `_GLOBAL_OFFSET_TABLE_`, so `sa` is
            // already the GOT base plus the addend.
            rt::R_386_PC32 | rt::R_386_PC16 | rt::R_386_PC8 | rt::R_386_GOTPC | rt::R_386_PLT32 => {
                sa.wrapping_sub(p)
            }
            rt::R_386_GOTOFF => match self.got_symbol_addr() {
                Some(g) => sa.wrapping_sub(g),
                None => {
                    errors.push(format!(
                        "{} against `{}' with no GOT",
                        rt::i386_reloc_desc(r.rtype),
                        name()
                    ));
                    return;
                }
            },
            other => {
                errors.push(format!(
                    "unsupported relocation {} against `{}'",
                    rt::i386_reloc_desc(other),
                    name()
                ));
                return;
            }
        };
        let Some(width) = rt::i386_field_width(r.rtype) else {
            return;
        };
        // bfd's `complain_overflow_bitfield` accepts a value that fits
        // the field read either as signed or as unsigned. A 32-bit
        // field holds every address of an ELF32 image.
        let sv = v as i64;
        let fits = match width {
            1 => (-0x80..=0xff).contains(&sv),
            2 => (-0x8000..=0xffff).contains(&sv),
            _ => true,
        };
        if !fits {
            errors.push(format!(
                "relocation truncated: {} against `{}' (0x{v:x})",
                rt::i386_reloc_desc(r.rtype),
                name()
            ));
        }
        let n = width as usize;
        if site + n <= buf.len() {
            buf[site..site + n].copy_from_slice(&v.to_le_bytes()[..n]);
        }
    }
}
