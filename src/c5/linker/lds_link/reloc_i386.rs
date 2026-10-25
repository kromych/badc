//! Relocation application; the i386 arm, and the `R_386_GOT32X`
//! relaxations GNU ld applies to a load through the GOT.

use crate::c5::object::elf_reloc_types as rt;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::inputs::RawReloc;
use super::{LdsEmit, LdsLinker, SHN_ABS, STB_LOCAL, STB_WEAK, STT_GNU_IFUNC};

/// What a relaxed `R_386_GOT32X` site becomes, as bfd's
/// `elf_i386_convert_load_reloc` rewrites it.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum GotRelax {
    /// `mov`, `test`, an ALU op or `push` takes `S` as an immediate.
    Immediate,
    /// `mov` becomes `lea` of `S - GOT`.
    Lea,
    /// An indirect call or jump becomes a direct one to `S`.
    Branch,
}

/// The opcode and ModRM bytes ahead of a GOT field at `at`.
fn insn_bytes(data: &[u8], at: u64) -> Option<(u8, u8)> {
    let at = usize::try_from(at).ok()?;
    Some((*data.get(at.checked_sub(2)?)?, *data.get(at - 1)?))
}

/// ModRM `disp32` with no base register.
fn baseless(modrm: u8) -> bool {
    modrm & 0xc7 == 0x05
}

impl<'a> LdsLinker<'a> {
    /// How the `R_386_GOT32X` site `r` in section `si` of object `oi`
    /// relaxes, or `None` where it keeps its GOT slot. Following GNU ld
    /// 2.46: only a zero addend relaxes; a position-independent image
    /// turns a load of a locally resolved symbol into `lea` and keeps
    /// every other form on the slot, except a load of an absolute
    /// symbol or of an undefined weak one, which takes the value; a
    /// position-dependent one takes every value as an immediate. A
    /// call or jump relaxes where the target is defined in the link.
    pub(super) fn i386_got_relax(&self, oi: usize, si: usize, r: &RawReloc) -> Option<GotRelax> {
        if r.rtype != rt::R_386_GOT32X || r.addend != 0 {
            return None;
        }
        let obj = &self.objects[oi];
        let (opcode, modrm) = insn_bytes(obj.section_data(&obj.sections[si]), r.offset)?;
        let pic = self.opts.emit == LdsEmit::Dyn;
        if pic && baseless(modrm) {
            return None;
        }
        let branch = match (opcode, modrm & 0x38) {
            (0xff, 0x10 | 0x20) => true,
            (0xff, 0x30) => false,
            (0xff, _) => return None,
            _ => false,
        };
        let sym = obj.symbols.get(r.sym as usize)?;
        let (abs, zero) = if sym.binding() == STB_LOCAL {
            if sym.kind() == STT_GNU_IFUNC {
                return None;
            }
            (sym.shndx as u16 == SHN_ABS, false)
        } else {
            self.got_binding(&sym.name, sym.binding())?
        };
        if branch {
            return (!(zero && pic)).then_some(GotRelax::Branch);
        }
        let immediate = !pic || zero;
        match opcode {
            0x8b if immediate || abs => Some(GotRelax::Immediate),
            0x8b => Some(GotRelax::Lea),
            0x85 | 0xff if immediate => Some(GotRelax::Immediate),
            op if immediate && op | 0x38 == 0x3b => Some(GotRelax::Immediate),
            _ => None,
        }
    }

    /// For a global `name` the link resolves locally: whether an object
    /// defines it absolute, and whether it is an undefined weak reference
    /// resolved to zero. `None` for an import, a preemptible definition,
    /// an indirect function, a strong reference the link leaves
    /// undefined, and `_DYNAMIC`, whose link-time address the loader
    /// reads.
    fn got_binding(&self, name: &str, binding: u8) -> Option<(bool, bool)> {
        if self.import_of.contains_key(name) || self.preemptible.contains(name) {
            return None;
        }
        if let Some(&(oi, si)) = self.globals.get(name) {
            let def = &self.objects[oi].symbols[si];
            return (def.kind() != STT_GNU_IFUNC).then_some((def.shndx as u16 == SHN_ABS, false));
        }
        if name == "_DYNAMIC" {
            return None;
        }
        if self.script_now.contains_key(name)
            || self.script_prev.contains_key(name)
            || name == rt::GOT_BASE_SYMBOL
        {
            return Some((false, false));
        }
        (binding == STB_WEAK).then_some((false, true))
    }

    /// True where a GOT reference keeps a slot: every `R_386_GOT32`, and
    /// an `R_386_GOT32X` that does not relax.
    pub(super) fn i386_got_slot_ref(&self, oi: usize, si: usize, r: &RawReloc) -> bool {
        match r.rtype {
            rt::R_386_GOT32 => true,
            rt::R_386_GOT32X => self.i386_got_relax(oi, si, r).is_none(),
            _ => false,
        }
    }

    /// Intel386 psABI: every type is `S + A`, `S + A - P` or a GOT-base
    /// form, written at the field's own width. bfd complains on
    /// overflow only where the field is narrower than an address. For
    /// the GOT forms `sa` is the slot plus the addend, or `S` where the
    /// site relaxes.
    #[allow(clippy::too_many_arguments)]
    pub(super) fn apply_i386(
        &self,
        buf: &mut [u8],
        site: usize,
        p: u64,
        sa: u64,
        r: &RawReloc,
        (oi, si): (usize, usize),
        errors: &mut Vec<String>,
    ) {
        let name = || self.objects[oi].symbol_name(r.sym as usize);
        let got_base = || {
            self.got_symbol_addr().ok_or_else(|| {
                format!(
                    "{} against `{}' with no GOT",
                    rt::i386_reloc_desc(r.rtype),
                    name()
                )
            })
        };
        let mut at = site;
        let v = match r.rtype {
            rt::R_386_32 | rt::R_386_16 | rt::R_386_8 => Ok(sa),
            // GOTPC's symbol is `_GLOBAL_OFFSET_TABLE_`, so `sa` is
            // already the GOT base plus the addend.
            rt::R_386_PC32 | rt::R_386_PC16 | rt::R_386_PC8 | rt::R_386_GOTPC | rt::R_386_PLT32 => {
                Ok(sa.wrapping_sub(p))
            }
            rt::R_386_GOTOFF => got_base().map(|g| sa.wrapping_sub(g)),
            rt::R_386_GOT32 | rt::R_386_GOT32X => match self.i386_got_relax(oi, si, r) {
                Some(how) if site + 4 <= buf.len() => {
                    let (field, v) = relax_got32x(buf, site, p, sa, how);
                    at = field;
                    match how {
                        GotRelax::Lea => got_base().map(|g| v.wrapping_sub(g)),
                        _ => Ok(v),
                    }
                }
                _ => self.got32_field(sa, r, (oi, si), got_base),
            },
            other => Err(format!(
                "unsupported relocation {} against `{}'",
                rt::i386_reloc_desc(other),
                name()
            )),
        };
        let v = match v {
            Ok(v) => v,
            Err(e) => {
                errors.push(e);
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
        if at + n <= buf.len() {
            buf[at..at + n].copy_from_slice(&v.to_le_bytes()[..n]);
        }
    }

    /// `G + A` of a GOT reference kept on its slot, `slot` being the
    /// slot's address plus the addend: its offset from the GOT base, or
    /// with no base register in a position-dependent image its address.
    /// A position-independent image has no address to give; there bfd
    /// still accepts `lea foo@GOT, %reg`, whose value is the offset.
    fn got32_field(
        &self,
        slot: u64,
        r: &RawReloc,
        (oi, si): (usize, usize),
        got_base: impl Fn() -> Result<u64, String>,
    ) -> Result<u64, String> {
        let obj = &self.objects[oi];
        let (opcode, modrm) =
            insn_bytes(obj.section_data(&obj.sections[si]), r.offset).unwrap_or((0, 0));
        if !baseless(modrm) || opcode == 0x8d && r.rtype == rt::R_386_GOT32 {
            return got_base().map(|g| slot.wrapping_sub(g));
        }
        if self.opts.emit != LdsEmit::Dyn {
            return Ok(slot);
        }
        Err(format!(
            "{}: direct GOT relocation {} against `{}' without base register can not be \
             used when making a shared object",
            obj.source,
            rt::i386_reloc_desc(r.rtype),
            obj.symbol_name(r.sym as usize),
        ))
    }
}

/// Rewrite the instruction ahead of the GOT field at `site` (address `p`)
/// as `how` directs, the way bfd does. Returns where the field now
/// starts and the value it takes for the target `s`, less the GOT base
/// for [`GotRelax::Lea`].
fn relax_got32x(buf: &mut [u8], site: usize, p: u64, s: u64, how: GotRelax) -> (usize, u64) {
    let (opcode, modrm) = (buf[site - 2], buf[site - 1]);
    let reg = (modrm & 0x38) >> 3;
    match how {
        GotRelax::Lea => {
            buf[site - 2] = 0x8d;
            (site, s)
        }
        GotRelax::Immediate => {
            let (op, rm) = match opcode {
                0x8b => (0xc7, 0xc0 | reg),
                0x85 => (0xf7, 0xc0 | reg),
                // `push $imm32` behind a `%cs` prefix, which fills the
                // ModRM byte's place.
                0xff => (0x2e, 0x68),
                _ => (0x81, 0xc0 | reg | (opcode & 0x38)),
            };
            buf[site - 2] = op;
            buf[site - 1] = rm;
            (site, s)
        }
        // A call keeps its length behind an `addr32` prefix; a jump moves
        // the displacement back a byte and ends in a `nop`.
        GotRelax::Branch if modrm == 0x15 || modrm & 0xf8 == 0x90 => {
            buf[site - 2] = 0x67;
            buf[site - 1] = 0xe8;
            (site, s.wrapping_sub(4).wrapping_sub(p))
        }
        GotRelax::Branch => {
            buf[site - 2] = 0xe9;
            buf[site + 3] = 0x90;
            (site - 1, s.wrapping_sub(4).wrapping_sub(p - 1))
        }
    }
}
