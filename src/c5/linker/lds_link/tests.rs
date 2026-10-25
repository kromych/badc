use super::inputs::{RawReloc, strz};
use super::*;
use crate::c5::linker::default_script::default_script;
use crate::c5::linker::lds::parse_linker_script;
use crate::c5::linker::object::DynamicImage;
use crate::c5::linker::object::{Elf32Shdr, Elf64Shdr, read_struct};
use crate::c5::linker::zkeyword::{ZKeywords, parse_z_keyword};
use crate::c5::linker::{comdat, dynamic};
use crate::c5::object::eh_frame;
use crate::c5::object::elf_reloc_types as rt;
use crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL as GOT_SYMBOL;

/// `(name, sh_type, flags, addralign, bytes, relocs)` of a test section.
type TestSec = (String, u32, u64, u64, Vec<u8>, Vec<RawReloc>);

/// Minimal ET_REL builder for engine tests.
struct TestObj {
    secs: Vec<TestSec>,
    // name, bind, kind, sec (usize::MAX = UNDEF, MAX-1 = ABS), value, size
    syms: Vec<(String, u8, u8, usize, u64, u64)>,
    entsizes: Vec<(usize, u64)>,
    // Symbol-list index -> st_other.
    sym_vis: Vec<(usize, u8)>,
    // Section index -> sh_link.
    links: Vec<(usize, u32)>,
    // Section index -> sh_info.
    infos: Vec<(usize, u32)>,
    // Flag word, signature symbol (index into `syms`), members.
    groups: Vec<(u32, usize, Vec<usize>)>,
}

impl TestObj {
    fn new() -> Self {
        TestObj {
            secs: Vec::new(),
            syms: Vec::new(),
            entsizes: Vec::new(),
            sym_vis: Vec::new(),
            links: Vec::new(),
            infos: Vec::new(),
            groups: Vec::new(),
        }
    }
    /// An `SHT_GROUP` section over `members`, signed by the symbol
    /// at `sig` in the order `sym` added them.
    fn group(mut self, flags: u32, sig: usize, members: &[usize]) -> Self {
        self.groups.push((flags, sig, members.to_vec()));
        self
    }
    fn sec(mut self, name: &str, shtype: u32, flags: u64, align: u64, body: &[u8]) -> Self {
        self.secs.push((
            name.to_string(),
            shtype,
            flags,
            align,
            body.to_vec(),
            Vec::new(),
        ));
        self
    }
    fn entsize(mut self, sec: usize, entsize: u64) -> Self {
        self.entsizes.push((sec, entsize));
        self
    }
    /// `sh_link` of `sec`, naming another section by its index.
    fn links_to(mut self, sec: usize, target: usize) -> Self {
        self.links.push((sec, target as u32 + 1));
        self
    }
    fn reloc(mut self, sec: usize, offset: u64, sym: u32, rtype: u32, addend: i64) -> Self {
        self.secs[sec].5.push(RawReloc {
            offset,
            sym,
            rtype,
            addend,
        });
        self
    }
    fn sym(mut self, name: &str, bind: u8, kind: u8, sec: usize, value: u64, size: u64) -> Self {
        self.syms
            .push((name.to_string(), bind, kind, sec, value, size));
        self
    }

    /// Set st_other (visibility) of the most recently added symbol.
    fn vis(mut self, other: u8) -> Self {
        self.sym_vis.push((self.syms.len() - 1, other));
        self
    }

    fn build(self, machine: u16) -> Vec<u8> {
        self.build_class(machine, ElfClass::Elf64, true)
    }

    /// `rela = false` stores each addend in the field it relocates
    /// and emits `SHT_REL` tables, the way gas does for i386.
    fn build_class(mut self, machine: u16, class: ElfClass, rela: bool) -> Vec<u8> {
        let aw = class.addr_size() as usize;
        let ent = if rela {
            class.rela_size() as usize
        } else {
            class.rel_size() as usize
        };
        if !rela {
            for (_, _, _, _, body, relocs) in self.secs.iter_mut() {
                for r in relocs.iter() {
                    let w = rt::i386_field_width(r.rtype).unwrap_or(4) as usize;
                    let at = r.offset as usize;
                    if at + w <= body.len() {
                        body[at..at + w].copy_from_slice(&r.addend.to_le_bytes()[..w]);
                    }
                }
            }
        }
        // A group becomes a section: the flag word followed by its
        // members' section indices, `sh_link` the symbol table and
        // `sh_info` the signature symbol.
        let specs = core::mem::take(&mut self.groups);
        let first_group = self.secs.len();
        for (flags, _, members) in &specs {
            let mut body = flags.to_le_bytes().to_vec();
            for &m in members {
                body.extend_from_slice(&(m as u32 + 1).to_le_bytes());
                self.secs[m].2 |= SHF_GROUP;
            }
            self.secs
                .push((".group".to_string(), SHT_GROUP, 0, 4, body, Vec::new()));
        }
        let nsec = self.secs.len();
        for (k, (_, sig, _)) in specs.iter().enumerate() {
            self.links.push((first_group + k, 1 + nsec as u32));
            self.infos.push((first_group + k, (1 + nsec + sig) as u32));
            self.entsizes.push((first_group + k, 4));
        }
        let mut bodies: Vec<u8> = Vec::new();
        let mut body_off: Vec<usize> = Vec::new();
        for (_, shtype, _, _, body, _) in &self.secs {
            body_off.push(class.ehdr_size() as usize + bodies.len());
            if *shtype != SHT_NOBITS {
                bodies.extend_from_slice(body);
            }
        }
        let sym_entry = |name: u32, info: u8, other: u8, shndx: u16, value: u64, size: u64| {
            let mut e = alloc::vec![0u8; class.sym_size() as usize];
            e[0..4].copy_from_slice(&name.to_le_bytes());
            if class.is32() {
                e[4..8].copy_from_slice(&(value as u32).to_le_bytes());
                e[8..12].copy_from_slice(&(size as u32).to_le_bytes());
                e[12] = info;
                e[13] = other;
                e[14..16].copy_from_slice(&shndx.to_le_bytes());
            } else {
                e[4] = info;
                e[5] = other;
                e[6..8].copy_from_slice(&shndx.to_le_bytes());
                e[8..16].copy_from_slice(&value.to_le_bytes());
                e[16..24].copy_from_slice(&size.to_le_bytes());
            }
            e
        };
        // Symtab: null + one section symbol per section + named.
        let mut strtab: Vec<u8> = alloc::vec![0];
        let mut symtab: Vec<u8> = alloc::vec![0; class.sym_size() as usize];
        for k in 0..nsec {
            symtab.extend_from_slice(&sym_entry(0, STT_SECTION, 0, (k + 1) as u16, 0, 0));
        }
        for (k, (name, bind, kind, sec, value, size)) in self.syms.iter().enumerate() {
            let noff = strtab.len() as u32;
            strtab.extend_from_slice(name.as_bytes());
            strtab.push(0);
            let other = self
                .sym_vis
                .iter()
                .find(|&&(i, _)| i == k)
                .map(|&(_, o)| o)
                .unwrap_or(0);
            let shndx: u16 = if *sec == usize::MAX {
                0
            } else if *sec == usize::MAX - 1 {
                SHN_ABS
            } else if *sec == usize::MAX - 2 {
                SHN_COMMON
            } else {
                (*sec + 1) as u16
            };
            symtab.extend_from_slice(&sym_entry(
                noff,
                (bind << 4) | kind,
                other,
                shndx,
                *value,
                *size,
            ));
        }
        let mut out: Vec<u8> = alloc::vec![0; class.ehdr_size() as usize];
        out.extend_from_slice(&bodies);
        let symtab_at = out.len();
        out.extend_from_slice(&symtab);
        let strtab_at = out.len();
        out.extend_from_slice(&strtab);
        let mut rela_at: Vec<(usize, usize, usize)> = Vec::new();
        for (k, (_, _, _, _, _, relocs)) in self.secs.iter().enumerate() {
            if relocs.is_empty() {
                continue;
            }
            let at = out.len();
            for r in relocs {
                out.extend_from_slice(&class.addr_bytes(r.offset)[..aw]);
                let info = class.reloc_info(r.sym, r.rtype);
                out.extend_from_slice(&class.addr_bytes(info)[..aw]);
                if rela {
                    out.extend_from_slice(&class.addr_bytes(r.addend as u64)[..aw]);
                }
            }
            rela_at.push((k, at, relocs.len()));
        }
        // Build shstrtab fully before emitting it.
        let mut shstr: Vec<u8> = alloc::vec![0];
        let mut names: Vec<u32> = Vec::new();
        let add_name = |n: &str, shstr: &mut Vec<u8>| -> u32 {
            let at = shstr.len() as u32;
            shstr.extend_from_slice(n.as_bytes());
            shstr.push(0);
            at
        };
        for (name, ..) in &self.secs {
            names.push(add_name(name, &mut shstr));
        }
        let n_symtab = add_name(".symtab", &mut shstr);
        let n_strtab = add_name(".strtab", &mut shstr);
        let mut rela_names: Vec<u32> = Vec::new();
        for (target, _, _) in &rela_at {
            let prefix = if rela { ".rela" } else { ".rel" };
            rela_names.push(add_name(
                &format!("{prefix}{}", self.secs[*target].0),
                &mut shstr,
            ));
        }
        let n_shstr = add_name(".shstrtab", &mut shstr);
        let shstr_at = out.len();
        out.extend_from_slice(&shstr);
        while !out.len().is_multiple_of(aw) {
            out.push(0);
        }
        let shoff = out.len();
        let symtab_shndx = 1 + nsec;
        let shnum = 1 + nsec + 2 + rela_at.len() + 1;
        let hdr = |name: u32,
                   shtype: u32,
                   flags: u64,
                   off: usize,
                   size: usize,
                   link: u32,
                   info: u32,
                   align: u64,
                   entsize: u64| {
            let mut h = alloc::vec![0u8; class.shdr_size() as usize];
            h[0..4].copy_from_slice(&name.to_le_bytes());
            h[4..8].copy_from_slice(&shtype.to_le_bytes());
            for (f, v) in [flags, 0, off as u64, size as u64].into_iter().enumerate() {
                let o = 8 + f * aw;
                h[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
            let o = 8 + 4 * aw;
            h[o..o + 4].copy_from_slice(&link.to_le_bytes());
            h[o + 4..o + 8].copy_from_slice(&info.to_le_bytes());
            for (f, v) in [align, entsize].into_iter().enumerate() {
                let o = o + 8 + f * aw;
                h[o..o + aw].copy_from_slice(&class.addr_bytes(v)[..aw]);
            }
            h
        };
        let mut shdrs: Vec<Vec<u8>> = alloc::vec![alloc::vec![0u8; class.shdr_size() as usize]];
        for (k, (_, shtype, flags, align, body, _)) in self.secs.iter().enumerate() {
            let entsize = self
                .entsizes
                .iter()
                .find(|(s, _)| *s == k)
                .map(|(_, e)| *e)
                .unwrap_or(0);
            let find = |v: &[(usize, u32)]| {
                v.iter()
                    .find(|(s, _)| *s == k)
                    .map(|(_, l)| *l)
                    .unwrap_or(0)
            };
            shdrs.push(hdr(
                names[k],
                *shtype,
                *flags,
                body_off[k],
                body.len(),
                find(&self.links),
                find(&self.infos),
                *align,
                entsize,
            ));
        }
        shdrs.push(hdr(
            n_symtab,
            SHT_SYMTAB,
            0,
            symtab_at,
            symtab.len(),
            (symtab_shndx + 1) as u32,
            (1 + nsec) as u32,
            aw as u64,
            class.sym_size(),
        ));
        shdrs.push(hdr(
            n_strtab,
            SHT_STRTAB,
            0,
            strtab_at,
            strtab.len(),
            0,
            0,
            1,
            0,
        ));
        for (j, (target, at, count)) in rela_at.iter().enumerate() {
            shdrs.push(hdr(
                rela_names[j],
                if rela { SHT_RELA } else { SHT_REL },
                0,
                *at,
                count * ent,
                symtab_shndx as u32,
                (*target + 1) as u32,
                aw as u64,
                ent as u64,
            ));
        }
        shdrs.push(hdr(
            n_shstr,
            SHT_STRTAB,
            0,
            shstr_at,
            shstr.len(),
            0,
            0,
            1,
            0,
        ));
        assert_eq!(shdrs.len(), shnum);
        for h in &shdrs {
            out.extend_from_slice(h);
        }
        out[0..4].copy_from_slice(b"\x7fELF");
        out[4] = class.ei_class();
        out[5] = 1;
        out[6] = 1;
        out[16..18].copy_from_slice(&1u16.to_le_bytes());
        out[18..20].copy_from_slice(&machine.to_le_bytes());
        let at = 24 + 2 * aw;
        out[at..at + aw].copy_from_slice(&class.addr_bytes(shoff as u64)[..aw]);
        let tail = 24 + 3 * aw + 4;
        out[tail..tail + 2].copy_from_slice(&(class.ehdr_size() as u16).to_le_bytes());
        out[tail + 6..tail + 8].copy_from_slice(&(class.shdr_size() as u16).to_le_bytes());
        out[tail + 8..tail + 10].copy_from_slice(&(shnum as u16).to_le_bytes());
        out[tail + 10..tail + 12].copy_from_slice(&((shnum - 1) as u16).to_le_bytes());
        out
    }
}

fn readelf_sections(image: &[u8]) -> Vec<(String, u32, u64, u64, u64)> {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    let shstrndx = u16::from_le_bytes(image[62..64].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
    let str_sh = sh(shstrndx);
    let strtab = &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
    (1..shnum)
        .map(|i| {
            let h = sh(i);
            (
                strz(strtab, h.sh_name as usize),
                h.sh_type,
                h.sh_addr,
                h.sh_size,
                h.sh_flags,
            )
        })
        .collect()
}

fn image_symbols(image: &[u8]) -> Vec<(String, u64, u16)> {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
    for i in 1..shnum {
        let h = sh(i);
        if h.sh_type == SHT_SYMTAB {
            let strh = sh(h.sh_link as usize);
            let strtab = &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
            let n = (h.sh_size / 24) as usize;
            return (0..n)
                .map(|k| {
                    let s: Elf64Sym = read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                    (strz(strtab, s.st_name as usize), s.st_value, s.st_shndx)
                })
                .collect();
        }
    }
    Vec::new()
}

/// `.dynsym` as `(name, value, shndx)`, in table order.
fn image_dynsyms(image: &[u8]) -> Vec<(String, u64, u16)> {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
    for i in 1..shnum {
        let h = sh(i);
        if h.sh_type != dynamic::SHT_DYNSYM {
            continue;
        }
        let strh = sh(h.sh_link as usize);
        let strtab = &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
        return (0..(h.sh_size / 24) as usize)
            .map(|k| {
                let s: Elf64Sym = read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                (strz(strtab, s.st_name as usize), s.st_value, s.st_shndx)
            })
            .collect();
    }
    Vec::new()
}

fn section_index(image: &[u8], name: &str) -> u32 {
    readelf_sections(image)
        .iter()
        .position(|s| s.0 == name)
        .map(|k| k as u32 + 1)
        .unwrap_or_else(|| panic!("{name} in output"))
}

fn section_link(image: &[u8], name: &str) -> u32 {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let i = section_index(image, name) as usize;
    let h: Elf64Shdr = read_struct(image, shoff + i * 64).unwrap();
    h.sh_link
}

fn image_phdrs(image: &[u8]) -> Vec<Elf64Phdr> {
    let phoff = u64::from_le_bytes(image[32..40].try_into().unwrap()) as usize;
    let phnum = u16::from_le_bytes(image[56..58].try_into().unwrap()) as usize;
    (0..phnum)
        .map(|i| read_struct(image, phoff + i * 56).unwrap())
        .collect()
}

/// Walk a SysV `.hash` chain the way a loader does.
fn sysv_lookup(hash: &[u8], syms: &[(String, u64, u16)], name: &str) -> Option<usize> {
    let w = |i: usize| u32::from_le_bytes(hash[i * 4..i * 4 + 4].try_into().unwrap()) as usize;
    let (nbucket, nchain) = (w(0), w(1));
    assert_eq!(nchain, syms.len(), ".hash nchain covers .dynsym");
    let mut i = w(2 + dynamic::elf_hash(name) as usize % nbucket);
    while i != 0 {
        if syms[i].0 == name {
            return Some(i);
        }
        i = w(2 + nbucket + i);
    }
    None
}

/// Walk a `.gnu.hash` bucket the way a loader does, Bloom filter
/// included: a name the filter rejects is not in the table.
fn gnu_lookup(gnu: &[u8], syms: &[(String, u64, u16)], name: &str) -> Option<usize> {
    let w = |i: usize| u32::from_le_bytes(gnu[i * 4..i * 4 + 4].try_into().unwrap()) as usize;
    let (nbuckets, symndx, maskwords, shift2) = (w(0), w(1), w(2), w(3));
    let h = dynamic::gnu_hash(name);
    let bloom = |k: usize| -> u64 {
        u64::from_le_bytes(gnu[16 + k * 8..16 + k * 8 + 8].try_into().unwrap())
    };
    let word = bloom((h as usize / 64) % maskwords);
    if word & (1u64 << (h % 64)) == 0 || word & (1u64 << ((h >> shift2) % 64)) == 0 {
        return None;
    }
    let buckets = 4 + maskwords * 2;
    let mut i = w(buckets + h as usize % nbuckets);
    if i == 0 {
        return None;
    }
    loop {
        let c = w(buckets + nbuckets + i - symndx);
        if c & !1 == (h & !1) as usize && syms[i].0 == name {
            return Some(i);
        }
        if c & 1 != 0 {
            return None;
        }
        i += 1;
    }
}

fn find_sym(syms: &[(String, u64, u16)], name: &str) -> u64 {
    syms.iter()
        .find(|(n, _, _)| n == name)
        .unwrap_or_else(|| panic!("symbol {name} in output"))
        .1
}

fn section_file_off(image: &[u8], addr: u64) -> usize {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    for i in 1..shnum {
        let h: Elf64Shdr = read_struct(image, shoff + i * 64).unwrap();
        if h.sh_addr == addr && h.sh_type != SHT_NOBITS {
            return h.sh_offset as usize;
        }
    }
    panic!("no section at 0x{addr:x}");
}

const SCRIPT: &str = r#"
ENTRY(_start)
PHDRS {
  text PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(6);
}
SECTIONS {
  . = 0x400000 + 0x1000;
  .text : AT(ADDR(.text) - 0x400000) {
    _text = .;
    *(.text .text.*)
    . = ALIGN(16);
    _etext = .;
  } :text = 0x90909090
  . = ALIGN(0x1000);
  .rodata : { *(.rodata*) __start_tab = .; KEEP(*(__tab)) __stop_tab = .; }
  .data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data
  .bss : { *(.bss) }
  .resv : { . += 0x40; }
  /DISCARD/ : { *(.gone) }
  ASSERT(_etext > _text, "text is empty")
}
"#;

fn two_objects() -> Vec<LdsObject> {
    // a.o: _start calls callee (PC32); .data slots hold &callee
    // and &tab_lo (ABS64).
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xe8, 0, 0, 0, 0, 0xc3],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
        .sec(".gone", SHT_PROGBITS, SHF_ALLOC, 1, &[0xff; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 6)
        .sym("callee", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .sym("tab_lo", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        // Symtab: null(0), sections(1..=3), _start(4), callee(5), tab_lo(6).
        .reloc(0, 1, 5, rt::R_X86_64_PC32, -4)
        .reloc(1, 0, 5, rt::R_X86_64_64, 0)
        .reloc(1, 8, 6, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".text.b",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc3],
        )
        .sec(".rodata.str", SHT_PROGBITS, SHF_ALLOC, 1, b"hi\0")
        .sec(
            "__tab",
            SHT_PROGBITS,
            SHF_ALLOC,
            8,
            &[1, 0, 0, 0, 0, 0, 0, 0],
        )
        .sec(".bss", SHT_NOBITS, SHF_ALLOC | SHF_WRITE, 32, &[0u8; 64])
        .sym("callee", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("tab_lo", STB_GLOBAL, STT_OBJECT, 2, 0, 8)
        .build(EM_X86_64);
    alloc::vec![
        parse_lds_object("a.o", a).expect("a.o parses"),
        parse_lds_object("b.o", b).expect("b.o parses"),
    ]
}

#[test]
fn script_link_places_sections_and_symbols() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let res = link_with_script(&script, two_objects(), &opts).expect("link succeeds");
    let secs = readelf_sections(&res.image);
    let sec = |n: &str| {
        secs.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("section {n}"))
    };
    assert_eq!(sec(".text").2, 0x401000);
    let text_end = 0x401000u64 + sec(".text").3;
    assert_eq!(sec(".rodata").2, align_up(text_end, 0x1000));
    assert!(secs.iter().all(|s| s.0 != ".gone"));
    assert_eq!(sec(".resv").1, SHT_NOBITS);
    assert_eq!(sec(".resv").3, 0x40);
    // 16 input bytes + LONG payload.
    assert_eq!(sec(".data").3, 20);
    let syms = image_symbols(&res.image);
    assert_eq!(find_sym(&syms, "_text"), 0x401000);
    // `__start_tab` sits at the pre-alignment dot; the 8-aligned
    // `__tab` input follows it.
    let start_tab = find_sym(&syms, "__start_tab");
    assert_eq!(find_sym(&syms, "__stop_tab"), align_up(start_tab, 8) + 8);
    let entry = u64::from_le_bytes(res.image[24..32].try_into().unwrap());
    assert_eq!(entry, find_sym(&syms, "_start"));
    // Relocations: .data[0] holds callee's address.
    let data_off = section_file_off(&res.image, sec(".data").2);
    let callee = find_sym(&syms, "callee");
    assert_eq!(
        u64::from_le_bytes(res.image[data_off..data_off + 8].try_into().unwrap()),
        callee
    );
    // PC32 call: disp = callee - (P + 4).
    let text_off = section_file_off(&res.image, 0x401000);
    let disp = i32::from_le_bytes(res.image[text_off + 1..text_off + 5].try_into().unwrap()) as i64;
    assert_eq!(0x401001 + 4 + disp, callee as i64);
    // Fill covers the ALIGN(16) tail of .text.
    assert_eq!(res.image[text_off + 7], 0x90);
    assert_eq!(
        u32::from_le_bytes(res.image[data_off + 16..data_off + 20].try_into().unwrap()),
        0xdeadbeef
    );
    // Program headers carry the script's FLAGS; LMA follows AT().
    let phnum = u16::from_le_bytes(res.image[56..58].try_into().unwrap()) as usize;
    assert_eq!(phnum, 2);
    let p0_flags = u32::from_le_bytes(res.image[68..72].try_into().unwrap());
    let p1_flags = u32::from_le_bytes(res.image[124..128].try_into().unwrap());
    assert_eq!((p0_flags, p1_flags), (5, 6));
    let p0_vaddr = u64::from_le_bytes(res.image[80..88].try_into().unwrap());
    let p0_paddr = u64::from_le_bytes(res.image[88..96].try_into().unwrap());
    assert_eq!(p0_paddr, p0_vaddr - 0x400000);
}

/// A section aligned past the page raises its load's `p_align`, as bfd and
/// lld set it, with `p_vaddr` congruent to `p_offset` modulo it.
#[test]
fn a_load_takes_the_alignment_of_its_widest_section() {
    let obj = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3],
        )
        .sec(
            ".data",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_WRITE,
            0x1_0000,
            &[1u8; 8],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let script =
        parse_linker_script("SECTIONS { . = 0x401000; .text : { *(.text) } .data : { *(.data) } }")
            .expect("script parses");
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let objs = alloc::vec![parse_lds_object("a.o", obj).expect("a.o parses")];
    let res = link_with_script(&script, objs, &opts).expect("link succeeds");
    let data = readelf_sections(&res.image)
        .into_iter()
        .find(|s| s.0 == ".data")
        .expect(".data");
    assert_eq!(data.2 % 0x1_0000, 0, ".data at {:#x}", data.2);
    let load = image_phdrs(&res.image)
        .into_iter()
        .find(|p| p.p_type == PT_LOAD && (p.p_vaddr..p.p_vaddr + p.p_memsz).contains(&data.2))
        .expect("a load holds .data");
    assert_eq!(load.p_align, 0x1_0000);
    assert_eq!(load.p_vaddr % load.p_align, load.p_offset % load.p_align);
}

/// `--emit-relocs`: every applied relocation reappears as a
/// `.rela.<outsec>` entry whose `r_offset` is the final address and
/// from which `S + A` reconstructs, so a post-link tool can relocate the
/// image again.
#[test]
fn emit_relocs_carries_applied_relocations_into_the_image() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let opts = LdsOptions {
        emit_relocs: true,
        ..Default::default()
    };
    let res = link_with_script(&script, two_objects(), &opts).expect("link succeeds");
    let secs = readelf_sections(&res.image);
    let rela_data = secs
        .iter()
        .find(|s| s.0 == ".rela.data")
        .expect(".rela.data emitted");
    assert_eq!(rela_data.1, SHT_RELA);
    assert_eq!(rela_data.3 % 24, 0);
    assert!(secs.iter().any(|s| s.0 == ".rela.text"), "{secs:?}");

    // sh_info names the section the table applies to, sh_link the
    // symbol table it indexes.
    let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(&res.image, shoff + i * 64).unwrap() };
    let data_idx = (1..shnum)
        .find(|&i| {
            let h = sh(i);
            h.sh_type != SHT_RELA && h.sh_addr == secs[i - 1].2 && secs[i - 1].0 == ".data"
        })
        .expect(".data section index");
    let rela_idx = (1..shnum)
        .find(|&i| sh(i).sh_type == SHT_RELA && sh(i).sh_info as usize == data_idx)
        .expect(".rela.data header");
    assert_eq!(sh(sh(rela_idx).sh_link as usize).sh_type, SHT_SYMTAB);

    // The `.data` slot holding &callee: its entry sits at the
    // slot's address and names `callee`.
    let syms = image_symbols(&res.image);
    let callee = find_sym(&syms, "callee");
    let data_addr = secs.iter().find(|s| s.0 == ".data").expect(".data").2;
    let h = sh(rela_idx);
    let n = (h.sh_size / 24) as usize;
    let mut found = false;
    for k in 0..n {
        let at = h.sh_offset as usize + k * 24;
        let off = u64::from_le_bytes(res.image[at..at + 8].try_into().unwrap());
        let info = u64::from_le_bytes(res.image[at + 8..at + 16].try_into().unwrap());
        if off != data_addr {
            continue;
        }
        assert_eq!(syms[(info >> 32) as usize].0, "callee");
        // `S + A` reconstructs from the entry: the slot holds
        // `callee`'s address with a zero addend.
        let add = i64::from_le_bytes(res.image[at + 16..at + 24].try_into().unwrap());
        assert_eq!(syms[(info >> 32) as usize].1 as i64 + add, callee as i64);
        found = true;
    }
    assert!(found, "entry for the .data slot at {data_addr:#x}");

    // Without the option no table is written.
    let plain =
        link_with_script(&script, two_objects(), &LdsOptions::default()).expect("link succeeds");
    assert!(
        !readelf_sections(&plain.image)
            .iter()
            .any(|s| s.1 == SHT_RELA),
        "no relocation tables without --emit-relocs"
    );
}

#[test]
fn assert_failure_fails_the_link() {
    let script_text = SCRIPT.replace("_etext > _text", "_etext < _text");
    let script = parse_linker_script(&script_text).expect("script parses");
    let e = link_with_script(&script, two_objects(), &LdsOptions::default())
        .expect_err("assert must fail the link");
    assert!(format!("{e}").contains("text is empty"), "{e}");
}

#[test]
fn orphan_error_reports_unplaced_sections() {
    let mut script_text = SCRIPT.replace("*(.rodata*)", "*(.rodata.none)");
    script_text = script_text.replace("ASSERT(_etext > _text, \"text is empty\")", "");
    let script = parse_linker_script(&script_text).expect("script parses");
    let opts = LdsOptions {
        orphan_handling: OrphanHandling::Error,
        ..Default::default()
    };
    let e = link_with_script(&script, two_objects(), &opts).expect_err("orphan must fail the link");
    assert!(format!("{e}").contains(".rodata.str"), "{e}");
}

#[test]
fn orphan_place_appends_compatible_section() {
    let mut script_text = SCRIPT.replace("*(.rodata*)", "*(.rodata.none)");
    script_text = script_text.replace("ASSERT(_etext > _text, \"text is empty\")", "");
    let script = parse_linker_script(&script_text).expect("script parses");
    let res = link_with_script(&script, two_objects(), &LdsOptions::default())
        .expect("orphan placement succeeds");
    let secs = readelf_sections(&res.image);
    assert!(secs.iter().any(|s| s.0 == ".rodata.str"));
}

/// An object placing data under a C-identifier section name keeps
/// that name as its own output section and gets the `__start_` /
/// `__stop_` pair bounding it, as bfd does.
#[test]
fn start_stop_bound_an_identifier_named_section() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90],
        )
        .sec("mytab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 24])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("__start_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .sym("__stop_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let sec = readelf_sections(&res.image)
        .into_iter()
        .find(|s| s.0 == "mytab")
        .expect("`mytab` keeps its identity as an output section");
    let syms = image_symbols(&res.image);
    let val = |n: &str| {
        syms.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n}"))
            .1
    };
    assert_eq!(val("__start_mytab"), sec.2);
    assert_eq!(val("__stop_mytab"), sec.2 + 24);
    assert_eq!(sec.3, 24);
}

/// bfd defines the pair only where nothing else does: an object
/// defining the name keeps its own definition.
#[test]
fn an_object_definition_outranks_the_synthesized_bound() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90; 8],
        )
        .sec("tty", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("__start_tty", STB_GLOBAL, STT_FUNC, 0, 4, 4)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let syms = image_symbols(&res.image);
    let text = readelf_sections(&res.image)
        .into_iter()
        .find(|s| s.0 == ".text")
        .expect(".text");
    let start = syms.iter().find(|s| s.0 == "__start_tty").expect("kept");
    assert_eq!(start.1, text.2 + 4);
}

/// A script assignment outranks the synthesized bound, keeping the
/// script symbol's own visibility: a script may bound a table itself.
#[test]
fn a_script_assignment_outranks_the_synthesized_bound() {
    let script_text = SCRIPT.replace(
        ".data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data",
        "mytab : { __start_mytab = .; *(mytab) . += 8; __stop_mytab = .; }\n\
             .data : AT(ADDR(.data) - 0x400000) { *(.data .data.*) LONG(0xdeadbeef) } :data",
    );
    let script = parse_linker_script(&script_text).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90],
        )
        .sec("mytab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 16])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("__stop_mytab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let sec = readelf_sections(&res.image)
        .into_iter()
        .find(|s| s.0 == "mytab")
        .expect("mytab");
    let syms = image_symbols(&res.image);
    let stop = syms.iter().find(|s| s.0 == "__stop_mytab").expect("stop");
    // The script's `. += 8` puts its own bound past the input's end.
    assert_eq!(stop.1, sec.2 + 24);
}

/// A name carrying a `.` is not an identifier, so it gets no pair.
#[test]
fn a_dotted_section_name_gets_no_bounds() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90],
        )
        .sec(".my.tab", SHT_PROGBITS, SHF_ALLOC, 8, &[7u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("__start_.my.tab", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let syms = image_symbols(&res.image);
    assert!(!syms.iter().any(|s| s.0 == "__start_.my.tab"), "{syms:?}");
}

/// Two text sections, one reached from the entry point and one
/// not, plus a `KEEP()`-named table nothing references.
fn gc_objects() -> Vec<LdsObject> {
    let a = TestObj::new()
        .sec(
            ".text._start",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xe8, 0, 0, 0, 0],
        )
        .sec(
            ".text.live",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3],
        )
        .sec(
            ".text.dead",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90; 8],
        )
        .sec("__tab", SHT_PROGBITS, SHF_ALLOC, 8, &[5u8; 8])
        .sec(".rodata.dead", SHT_PROGBITS, SHF_ALLOC, 8, &[6u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 5)
        .sym("live", STB_GLOBAL, STT_FUNC, 1, 0, 1)
        .sym("dead", STB_GLOBAL, STT_FUNC, 2, 0, 8)
        // Symtab: null(0), sections(1..=5), _start(6), live(7), dead(8).
        .reloc(0, 1, 7, rt::R_X86_64_PC32, -4)
        .build(EM_X86_64);
    alloc::vec![parse_lds_object("a.o", a).expect("parses")]
}

/// `--gc-sections` drops what the entry point does not reach, and
/// keeps what a `KEEP()` names.
#[test]
fn gc_sections_drops_what_the_entry_does_not_reach() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let opts = LdsOptions {
        gc_sections: true,
        ..LdsOptions::default()
    };
    let res = link_with_script(&script, gc_objects(), &opts).expect("links");
    let names: Vec<String> = image_symbols(&res.image).into_iter().map(|s| s.0).collect();
    assert!(names.iter().any(|n| n == "_start"), "{names:?}");
    assert!(names.iter().any(|n| n == "live"), "{names:?}");
    assert!(!names.iter().any(|n| n == "dead"), "{names:?}");
    // The script KEEPs `__tab` between its own bounds.
    let syms = image_symbols(&res.image);
    let v = |n: &str| {
        syms.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n}"))
            .1
    };
    assert_eq!(v("__stop_tab") - v("__start_tab"), 8);
}

/// Without the option nothing is collected.
#[test]
fn without_gc_sections_every_input_is_placed() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let res = link_with_script(&script, gc_objects(), &LdsOptions::default()).expect("links");
    let names: Vec<String> = image_symbols(&res.image).into_iter().map(|s| s.0).collect();
    assert!(names.iter().any(|n| n == "dead"), "{names:?}");
}

#[test]
fn undefined_strong_reference_fails() {
    let script = parse_linker_script(SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xe8, 0, 0, 0, 0],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 5)
        .sym("missing", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        // Symtab: null(0), section(1), _start(2), missing(3).
        .reloc(0, 1, 3, rt::R_X86_64_PC32, -4)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let e = link_with_script(&script, objs, &LdsOptions::default())
        .expect_err("undefined reference fails");
    assert!(format!("{e}").contains("missing"), "{e}");
}

/// One `.text` section holding `insns` followed by `tgt`, with a
/// `SABS_G2` / `UABS_G1_NC` / `UABS_G0_NC` relocation over each in turn.
fn movw_seq_object(insns: &[u32]) -> Vec<LdsObject> {
    let mut body: Vec<u8> = insns.iter().flat_map(|w| w.to_le_bytes()).collect();
    let tgt_off = body.len() as u64;
    body.extend_from_slice(&0xd503201fu32.to_le_bytes());
    let mut o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &body)
        .sym("tgt", STB_GLOBAL, STT_FUNC, 0, tgt_off, 4);
    // Symtab: null(0), section(1), tgt(2).
    for (i, _) in insns.iter().enumerate() {
        let ty = match i {
            0 => rt::R_AARCH64_MOVW_SABS_G2,
            1 => rt::R_AARCH64_MOVW_UABS_G1_NC,
            _ => rt::R_AARCH64_MOVW_UABS_G0_NC,
        };
        o = o.reloc(0, i as u64 * 4, 2, ty, 0);
    }
    alloc::vec![parse_lds_object("a.o", o.build(EM_AARCH64)).expect("a.o parses")]
}

fn movw_script(base: &str) -> crate::c5::linker::lds::LinkerScript {
    parse_linker_script(&format!(
        "SECTIONS {{ . = {base}; .text : {{ *(.text) }} }}"
    ))
    .expect("script parses")
}

/// A `movz` / `movk` address load linked through a script: each instruction
/// takes its own 16-bit group of the target's final address. Words checked
/// against `ld -T` over the same script and object.
#[test]
fn aarch64_movw_groups_resolve_like_gnu_ld() {
    // Placeholders as GNU as leaves them: the group's shift, zero imm.
    let insns = [0xd2c0_0005u32, 0xf2a0_0005, 0xf280_0005];
    let res = link_with_script(
        &movw_script("0x123456780000"),
        movw_seq_object(&insns),
        &LdsOptions {
            emit: LdsEmit::Exec,
            max_page_size: 0x1000,
            ..Default::default()
        },
    )
    .expect("link succeeds");
    let syms = image_symbols(&res.image);
    let tgt = find_sym(&syms, "tgt");
    assert_eq!(tgt, 0x1234_5678_000c);
    let off = section_file_off(&res.image, 0x1234_5678_0000);
    let got: Vec<u32> = (0..3)
        .map(|i| {
            u32::from_le_bytes(
                res.image[off + i * 4..off + i * 4 + 4]
                    .try_into()
                    .expect("4-byte word"),
            )
        })
        .collect();
    assert_eq!(
        got,
        alloc::vec![
            0xd2c2_4685, // movz x5, #0x1234, lsl #32
            0xf2aa_cf05, // movk x5, #0x5678, lsl #16
            0xf280_0185, // movk x5, #0xc
        ]
    );
}

/// A `_S` group is checked: a target past its signed range fails the
/// link, as it does under GNU ld, rather than writing a truncated
/// address. The `_NC` halves of the same sequence never complain.
#[test]
fn aarch64_movw_sabs_overflow_fails_the_link() {
    let insns = [0xd2c0_0005u32, 0xf2a0_0005, 0xf280_0005];
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        ..Default::default()
    };
    // The last address the signed group admits is 2^48 - 1.
    link_with_script(
        &movw_script("0xfffffffffff0"),
        movw_seq_object(&insns),
        &opts,
    )
    .expect("a target below 2^48 links");
    let e = link_with_script(
        &movw_script("0x1000000000000"),
        movw_seq_object(&insns),
        &opts,
    )
    .expect_err("a target at 2^48 overflows the signed group");
    let e = format!("{e}");
    assert!(e.contains("R_AARCH64_MOVW_SABS_G2"), "{e}");
    assert!(e.contains("overflow against `tgt'"), "{e}");
}

/// A diagnostic names a section symbol, which has no name of its own,
/// by its section, as GNU ld does.
#[test]
fn a_section_symbol_is_named_by_its_section_in_a_diagnostic() {
    // Symtab: null(0), .text(1), .data(2).
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0; 4])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .reloc(0, 0, 2, rt::R_X86_64_32, 0);
    let objs = alloc::vec![parse_lds_object("a.o", o.build(EM_X86_64)).expect("a.o parses")];
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text) } . = 0x100000000; .data : { *(.data) } }",
    )
    .expect("script parses");
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let e = link_with_script(&script, objs, &opts).expect_err("the field cannot hold the address");
    let e = format!("{e}");
    assert!(e.contains("R_X86_64_32 against `.data'"), "{e}");
}

// ---- Cortex-A53 erratum 843419 (`--fix-cortex-a53-843419`) ----
// The expectations mirror GNU ld's workaround: the ADRP becomes an
// ADR where the addressed page is within a megabyte, otherwise the
// dependent load/store is replaced by a branch to an 8-byte veneer
// holding that load/store and a branch back, the veneer area is
// padded to a page so following page offsets do not move, and each
// veneer takes an `e843419@...` local symbol.

const A53_ADRP_FAR: u32 = 0x9000_1000; // adrp x0, +0x200 pages
const A53_ADRP_NEAR: u32 = 0xb000_0000; // adrp x0, +1 page
const A53_LDR: u32 = 0xf940_0041; // ldr x1, [x2]
const A53_DEP_LDR: u32 = 0xf940_0403; // ldr x3, [x0, #8]
const A53_RET: u32 = 0xd65f_03c0;

fn a53_object(insns: &[u32]) -> Vec<LdsObject> {
    let body: Vec<u8> = insns.iter().flat_map(|w| w.to_le_bytes()).collect();
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &body)
        .sec(
            ".after",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &A53_RET.to_le_bytes(),
        )
        .sym("f", STB_GLOBAL, STT_FUNC, 0, 0, body.len() as u64);
    alloc::vec![parse_lds_object("a.o", o.build(EM_AARCH64)).expect("a.o parses")]
}

fn a53_link(base: u64, insns: &[u32], fix: bool) -> LdsResult {
    let script = parse_linker_script(&format!(
        "SECTIONS {{ . = {base:#x}; .text : {{ *(.text) }} .after : {{ *(.after) }} }}"
    ))
    .expect("script parses");
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        fix_cortex_a53_843419: fix,
        ..Default::default()
    };
    link_with_script(&script, a53_object(insns), &opts).expect("link succeeds")
}

/// `n` words at `sec_addr + delta`, `sec_addr` naming the section.
fn a53_words(image: &[u8], sec_addr: u64, delta: usize, n: usize) -> Vec<u32> {
    let off = section_file_off(image, sec_addr) + delta;
    (0..n)
        .map(|i| {
            u32::from_le_bytes(
                image[off + i * 4..off + i * 4 + 4]
                    .try_into()
                    .expect("word"),
            )
        })
        .collect()
}

fn a53_sec(image: &[u8], name: &str) -> (u64, u64) {
    readelf_sections(image)
        .into_iter()
        .find(|s| s.0 == name)
        .map(|s| (s.2, s.3))
        .expect("section present")
}

/// The dependent load/store is routed through a veneer when the
/// ADRP page is beyond ADR reach; `ld --fix-cortex-a53-843419`
/// leaves the ADRP in place and branches the load/store out.
#[test]
fn a53_veneer_redirects_the_dependent_load() {
    let insns = [A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET];
    let res = a53_link(0xff8, &insns, true);
    assert_eq!(a53_sec(&res.image, ".text"), (0xff8, 0x1010));
    assert_eq!(
        a53_words(&res.image, 0xff8, 0, 4),
        alloc::vec![A53_ADRP_FAR, A53_LDR, 0x1400_0002, A53_RET],
    );
    // Veneer at the reserved area: the load/store, then a branch
    // back to the instruction after its original slot.
    assert_eq!(
        a53_words(&res.image, 0xff8, 0x10, 2),
        alloc::vec![A53_DEP_LDR, 0x17ff_fffe],
    );
    let syms = image_symbols(&res.image);
    assert!(
        syms.iter()
            .any(|s| s.0.starts_with("e843419@") && s.0.ends_with("_8") && s.1 == 0x1008),
        "veneer symbol missing: {syms:?}"
    );
    // The insertion is a whole page: the following section moves by
    // exactly 0x1000 and keeps its page offset.
    let plain = a53_link(0xff8, &insns, false);
    let (fixed, moved) = (
        a53_sec(&res.image, ".after").0,
        a53_sec(&plain.image, ".after").0,
    );
    assert_eq!(fixed - moved, 0x1000);
    assert_eq!(fixed & 0xfff, moved & 0xfff);
}

/// With one non-branch instruction between the two accesses the
/// sequence still matches and the fourth instruction is veneered.
#[test]
fn a53_intervening_instruction_form_is_veneered() {
    let insns = [A53_ADRP_FAR, A53_LDR, 0xd503_201f, A53_DEP_LDR];
    let res = a53_link(0xff8, &insns, true);
    assert_eq!(
        a53_words(&res.image, 0xff8, 0, 4),
        alloc::vec![A53_ADRP_FAR, A53_LDR, 0xd503_201f, 0x1400_0001],
    );
    assert_eq!(
        a53_words(&res.image, 0xff8, 0x10, 2),
        alloc::vec![A53_DEP_LDR, 0x17ff_ffff],
    );
    let syms = image_symbols(&res.image);
    assert!(
        syms.iter()
            .any(|s| s.0.starts_with("e843419@") && s.0.ends_with("_c"))
    );
}

/// A page within ADR range rewrites the ADRP in place, as ld's
/// default (`full`) mode does; the reserved slot stays empty the
/// way ld leaves its unused stub.
#[test]
fn a53_adr_rewrite_when_the_page_is_reachable() {
    let insns = [A53_ADRP_NEAR, A53_LDR, A53_DEP_LDR, A53_RET];
    let res = a53_link(0xff8, &insns, true);
    // adr x0, #8: 0x1000 (the page) - 0xff8 (the site).
    assert_eq!(
        a53_words(&res.image, 0xff8, 0, 4),
        alloc::vec![0x1000_0040, A53_LDR, A53_DEP_LDR, A53_RET],
    );
    assert_eq!(a53_sec(&res.image, ".text"), (0xff8, 0x1010));
    assert_eq!(a53_words(&res.image, 0xff8, 0x10, 2), alloc::vec![0, 0]);
    let syms = image_symbols(&res.image);
    assert!(!syms.iter().any(|s| s.0.starts_with("e843419@")));
}

/// Sequences the erratum conditions exclude stay untouched: an
/// ADRP off the last two word slots of a page, a branch in the
/// intervening slot, a first load/store writing the ADRP register,
/// and a dependent access based elsewhere. `ld` patches none of
/// these.
#[test]
fn a53_non_matching_sequences_are_left_alone() {
    let cases: [(u64, [u32; 4]); 4] = [
        (0xff4, [A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET]),
        (0xff8, [A53_ADRP_FAR, A53_LDR, 0x1400_0001, A53_DEP_LDR]),
        (0xff8, [A53_ADRP_FAR, 0xf940_0040, A53_DEP_LDR, A53_RET]),
        (0xff8, [A53_ADRP_FAR, A53_LDR, 0xf940_0443, A53_RET]),
    ];
    for (base, insns) in cases {
        let res = a53_link(base, &insns, true);
        assert_eq!(a53_sec(&res.image, ".text"), (base, 0x10), "at {base:#x}");
        assert_eq!(a53_words(&res.image, base, 0, 4), insns.to_vec());
        assert!(
            !image_symbols(&res.image)
                .iter()
                .any(|s| s.0.starts_with("e843419@"))
        );
    }
}

/// Sites on consecutive pages take consecutive 8-byte slots in one
/// page-sized area, so the area still moves nothing off its page
/// offset.
#[test]
fn a53_multiple_sites_pack_into_one_area() {
    let mut insns = alloc::vec![A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET];
    insns.extend(core::iter::repeat_n(0xd503_201fu32, 1020));
    insns.extend([A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET]);
    let res = a53_link(0xff8, &insns, true);
    assert_eq!(a53_sec(&res.image, ".text"), (0xff8, 0x2010));
    let mut veneers: Vec<(String, u64)> = image_symbols(&res.image)
        .into_iter()
        .filter(|s| s.0.starts_with("e843419@"))
        .map(|s| (s.0, s.1))
        .collect();
    veneers.sort_by_key(|v| v.1);
    assert_eq!(veneers.len(), 2, "{veneers:?}");
    assert!(veneers[0].0.ends_with("_8") && veneers[0].1 == 0x2008);
    assert!(veneers[1].0.ends_with("_1008") && veneers[1].1 == 0x2010);
    // Both dependent loads branch forward into their slots.
    assert_eq!(a53_words(&res.image, 0xff8, 8, 1), alloc::vec![0x1400_0402]);
    assert_eq!(
        a53_words(&res.image, 0xff8, 0x1008, 1),
        alloc::vec![0x1400_0004]
    );
}

/// A `$d` mapping symbol marks the sequence as data, which the
/// scan skips as ld and LLD skip their data spans.
#[test]
fn a53_data_spans_are_not_scanned() {
    let insns = [A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET];
    let body: Vec<u8> = insns.iter().flat_map(|w| w.to_le_bytes()).collect();
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &body)
        .sym("$d", STB_LOCAL, STT_NOTYPE, 0, 0, 0);
    let objs = alloc::vec![parse_lds_object("a.o", o.build(EM_AARCH64)).expect("parses")];
    let script =
        parse_linker_script("SECTIONS { . = 0xff8; .text : { *(.text) } }").expect("parses");
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        max_page_size: 0x1000,
        fix_cortex_a53_843419: true,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("link succeeds");
    assert_eq!(a53_sec(&res.image, ".text"), (0xff8, 0x10));
    assert_eq!(a53_words(&res.image, 0xff8, 0, 4), insns.to_vec());
}

/// bfd's stack rule: `-z execstack` / `noexecstack` decide; without one,
/// an input whose `.note.GNU-stack` is executable makes the stack
/// executable, with a warning naming it that `--no-warn-execstack`
/// withholds and `--warn-execstack` extends to `-z execstack`.
#[test]
fn an_executable_stack_note_makes_the_stack_executable() {
    let script = parse_linker_script("SECTIONS { . = 0x400000; .text : { *(.text) } }").unwrap();
    let obj = |name: &str, note_flags: u64| {
        let o = TestObj::new()
            .sec(".note.GNU-stack", SHT_PROGBITS, note_flags, 1, &[])
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sym(name, STB_GLOBAL, STT_FUNC, 1, 0, 1);
        parse_lds_object(&format!("{name}.o"), o.build(EM_X86_64)).expect("parses")
    };
    let by_input = "x.o: requires executable stack";
    let by_option = "because of -z execstack";
    for (asked, exec_stack, warn_execstack, rwx, warning) in [
        (false, None, None, false, None),
        (true, None, None, true, Some(by_input)),
        (true, None, Some(false), true, None),
        (true, Some(false), None, false, None),
        (false, Some(true), None, true, None),
        (false, Some(true), Some(true), true, Some(by_option)),
    ] {
        let mut objs = alloc::vec![obj("_start", 0)];
        if asked {
            objs.push(obj("x", SHF_EXECINSTR));
        }
        let opts = LdsOptions {
            exec_stack,
            warn_execstack,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let what = alloc::format!("{asked} {exec_stack:?} {warn_execstack:?}");
        let stack = image_phdrs(&res.image)
            .into_iter()
            .find(|p| p.p_type == PT_GNU_STACK)
            .expect("PT_GNU_STACK");
        assert_eq!(stack.p_flags & PF_X != 0, rwx, "{what}");
        let texts: Vec<&str> = res.warnings.iter().map(|w| w.text.as_str()).collect();
        match warning {
            Some(w) => assert!(texts.iter().any(|t| t.contains(w)), "{what}: {texts:?}"),
            None => assert!(texts.is_empty(), "{what}: {texts:?}"),
        }
    }
}

/// GNU ld's warnings for a loaded segment that is readable, writable and
/// executable and for an executable thread-local one, naming the output;
/// `--no-warn-rwx-segments` withholds both, and a layout keeping code and
/// data on pages of their own draws neither.
#[test]
fn a_read_write_execute_segment_draws_a_warning() {
    let obj = || {
        let o = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sec(
                ".tdata",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_WRITE | SHF_TLS,
                8,
                &[0u8; 8],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1);
        alloc::vec![parse_lds_object("a.o", o.build(EM_X86_64)).expect("parses")]
    };
    let shared_page = "SECTIONS { . = 0x400000; .text : { *(.text) } .data : { *(.data) } \
                       .tdata : { *(.tdata) } }";
    let own_pages = "SECTIONS { . = 0x400000; .text : { *(.text) } . = ALIGN(0x1000); \
                     .data : { *(.data) } .tdata : { *(.tdata) } }";
    let tls_x = "PHDRS { all PT_LOAD FLAGS(5); tls PT_TLS FLAGS(5); } SECTIONS { \
                 . = 0x400000; .text : { *(.text) } :all .data : { *(.data) } :all \
                 .tdata : { *(.tdata) } :all :tls }";
    let rwx = "out has a LOAD segment with RWX permissions";
    let tls = "out has a TLS segment with execute permission";
    for (script, warn, want) in [
        (shared_page, true, &[rwx][..]),
        (shared_page, false, &[]),
        (own_pages, true, &[]),
        (tls_x, true, &[tls]),
    ] {
        let opts = LdsOptions {
            warn_rwx_segments: warn,
            output_name: String::from("out"),
            ..Default::default()
        };
        let script = parse_linker_script(script).expect("parses");
        let res = link_with_script(&script, obj(), &opts).expect("links");
        let texts: Vec<&str> = res.warnings.iter().map(|w| w.text.as_str()).collect();
        assert_eq!(texts, want, "warn={warn}");
    }
}

/// The veneer symbol names its input section by the index the input
/// file gives it, not by the position it holds in this link, so a link
/// with `--strip-debug` and one without produce the same symbol table.
#[test]
fn a53_veneer_name_is_independent_of_the_dropped_sections() {
    let insns = [A53_ADRP_FAR, A53_LDR, A53_DEP_LDR, A53_RET];
    let body: Vec<u8> = insns.iter().flat_map(|w| w.to_le_bytes()).collect();
    let veneers = |strip_debug| {
        let o = TestObj::new()
            .sec(".debug_info", SHT_PROGBITS, 0, 1, &[0u8; 4])
            .sec(".debug_line", SHT_PROGBITS, 0, 1, &[0u8; 4])
            .sec(".note.GNU-stack", SHT_PROGBITS, 0, 1, &[])
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &body)
            .sym("f", STB_GLOBAL, STT_FUNC, 3, 0, body.len() as u64);
        let objs = alloc::vec![parse_lds_object("a.o", o.build(EM_AARCH64)).expect("parses")];
        let script =
            parse_linker_script("SECTIONS { . = 0xff8; .text : { *(.text) } }").expect("parses");
        let opts = LdsOptions {
            emit: LdsEmit::Exec,
            max_page_size: 0x1000,
            fix_cortex_a53_843419: true,
            strip_debug,
            ..Default::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("link succeeds");
        let mut v: Vec<(String, u64)> = image_symbols(&res.image)
            .into_iter()
            .filter(|s| s.0.starts_with("e843419@"))
            .map(|s| (s.0, s.1))
            .collect();
        v.sort();
        v
    };
    let kept = veneers(false);
    assert_eq!(kept.len(), 1, "{kept:?}");
    assert_eq!(kept, veneers(true), "veneer name moved with the strip set");
}

#[test]
fn merge_strings_deduplicate() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata.str1.1) } }",
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".rodata.str1.1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            1,
            b"hello\0world\0",
        )
        .entsize(1, 1)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".text.b",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc3],
        )
        .sec(
            ".rodata.str1.1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            1,
            b"world\0",
        )
        .entsize(1, 1)
        .sym("bfn", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        // b's string symbol: offset of "world" within its section.
        .sym("b_str", STB_GLOBAL, STT_OBJECT, 1, 0, 6)
        .build(EM_X86_64);
    let objs = alloc::vec![
        parse_lds_object("a.o", a).expect("parses"),
        parse_lds_object("b.o", b).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
    // "hello\0world\0" + "world\0" dedupes to 12 bytes.
    assert_eq!(ro.3, 12);
    // b's "world" resolves into the pool at offset 6.
    let syms = image_symbols(&res.image);
    assert_eq!(find_sym(&syms, "b_str"), ro.2 + 6);
}

/// A named symbol into a merged string section anchors its relocs:
/// the addend applies to the remapped address, so an addend past
/// the string's NUL (gcc anchors one-past-end bounds this way)
/// stays with that string instead of resolving to a deduplicated
/// padding entry. A section symbol's addend selects the entry
/// through the remap. Pool entries keep the section's alignment.
#[test]
fn merge_string_addend_anchors_to_symbol_entry() {
    let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } .data : { *(.data*) } }",
        )
        .expect("parses");
    // gcc's .rodata.str1.8 shape: 8-aligned strings, NUL padding.
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0u8; 4],
        )
        .sec(
            ".rodata.str1.8",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            8,
            b"io  \0\0\0\0mem \0\0\0\0",
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 24])
        .entsize(1, 1)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .sym("mem_str", STB_GLOBAL, STT_OBJECT, 1, 8, 5)
        // Symtab: null(0), sections(1..=3), _start(4), mem_str(5).
        // Slots: mem_str+1, mem_str+5 (one past the NUL), and the
        // string's offset through the section symbol.
        .reloc(2, 0, 5, rt::R_AARCH64_ABS64, 1)
        .reloc(2, 8, 5, rt::R_AARCH64_ABS64, 5)
        .reloc(2, 16, 2, rt::R_AARCH64_ABS64, 8)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
    let data = secs.iter().find(|s| s.0 == ".data").expect("data");
    let ro_off = section_file_off(&res.image, ro.2);
    let bytes = &res.image[ro_off..ro_off + ro.3 as usize];
    let mem = bytes
        .windows(5)
        .position(|w| w == b"mem \0")
        .expect("pooled string") as u64;
    assert_eq!((ro.2 + mem) % 8, 0, "pool keeps the entry alignment");
    let d_off = section_file_off(&res.image, data.2);
    let slot =
        |k: usize| u64::from_le_bytes(res.image[d_off + k..d_off + k + 8].try_into().unwrap());
    assert_eq!(slot(0), ro.2 + mem + 1);
    assert_eq!(slot(8), ro.2 + mem + 5);
    assert_eq!(slot(16), ro.2 + mem);
}

/// Mergeable constant pools keep the alignment their inputs
/// requested, whichever pool an entry lands in, and a named local
/// symbol into a section the pool merged away follows its content
/// to the surviving entry. `.rodata` opens with an odd-sized
/// section so a pool that ignored its alignment would land off a
/// 16-byte boundary.
#[test]
fn merge_pools_keep_the_input_alignment() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text*) } \
             .rodata : { *(.rodata) *(.rodata.*) } .data : { *(.data*) } }",
    )
    .expect("parses");
    const K16: &[u8; 16] = b"\x02\x03\x00\x01\x06\x07\x04\x05\x0a\x0b\x08\x09\x0e\x0f\x0c\x0d";
    const OTHER16: &[u8; 16] = b"\x01\x02\x03\x00\x05\x06\x07\x04\x09\x0a\x0b\x08\x0d\x0e\x0f\x0c";
    let mut k32 = [0u8; 32];
    k32[0] = 0xa5;
    // Symtab of each: null(0), sections(1..=n), then the names below.
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0u8; 4],
        )
        .sec(".rodata", SHT_PROGBITS, SHF_ALLOC, 1, b"odd\0\0")
        .sec(
            ".rodata.cst16.k1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            16,
            K16,
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .entsize(2, 16)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .reloc(3, 0, 3, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    // b's k2 holds a's constant, so the pool merges it away; k3 and
    // the 32-aligned k4 are distinct entries.
    let b = TestObj::new()
        .sec(
            ".rodata.cst16.k2",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            16,
            K16,
        )
        .sec(
            ".rodata.cst16.k3",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            16,
            OTHER16,
        )
        .sec(
            ".rodata.cst32.k4",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            32,
            &k32,
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 24])
        .entsize(0, 16)
        .entsize(1, 16)
        .entsize(2, 32)
        .sym("k2", STB_LOCAL, STT_NOTYPE, 0, 0, 0)
        .sym("k3", STB_LOCAL, STT_NOTYPE, 1, 0, 0)
        .sym("k4", STB_LOCAL, STT_NOTYPE, 2, 0, 0)
        .reloc(3, 0, 5, rt::R_AARCH64_ABS64, 0)
        .reloc(3, 8, 6, rt::R_AARCH64_ABS64, 0)
        .reloc(3, 16, 7, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    let objs = alloc::vec![
        parse_lds_object("a.o", a).expect("parses"),
        parse_lds_object("b.o", b).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let data = secs
        .iter()
        .filter(|s| s.0 == ".data")
        .map(|s| s.2)
        .next()
        .expect("data");
    let d_off = section_file_off(&res.image, data);
    let slot =
        |k: usize| u64::from_le_bytes(res.image[d_off + k..d_off + k + 8].try_into().unwrap());
    // a.o's slot comes first, then b.o's three.
    let (k1, k2, k3, k4) = (slot(0), slot(8), slot(16), slot(24));
    assert_eq!(k1, k2, "identical constants share one pool entry");
    assert_ne!(k2, k3, "distinct constants keep separate entries");
    for (name, addr, align) in [("k1", k1, 16), ("k3", k3, 16), ("k4", k4, 32)] {
        assert_eq!(
            addr % align,
            0,
            "{name} at 0x{addr:x} is not {align}-aligned"
        );
    }
    let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
    let ro_off = section_file_off(&res.image, ro.2);
    let at = |addr: u64| {
        let k = ro_off + (addr - ro.2) as usize;
        &res.image[k..k + 16]
    };
    assert_eq!(at(k1), K16, "k1 points at its own constant");
    assert_eq!(at(k3), OTHER16, "k3 points at its own constant");
    assert_eq!(at(k4)[0], 0xa5, "k4 points at its own constant");
}

/// A section-symbol reference into a merge pool whose addend is not
/// an offset the section covers has no entry to name. bfd reports
/// it and resolves to the pool end; the link must say so rather
/// than fold the miss into an address.
#[test]
fn merge_section_symbol_addend_out_of_range_is_reported() {
    let script = parse_linker_script(
            "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } .data : { *(.data*) } }",
        )
        .expect("parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0u8; 4],
        )
        .sec(
            ".rodata.cst16.k1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            16,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .entsize(1, 16)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        // Section symbol of `.rodata.cst16.k1` with the pc-relative
        // -4 an assembler must not reduce a local label to.
        .reloc(2, 0, 2, rt::R_AARCH64_ABS64, -4)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    assert!(
        res.warnings
            .iter()
            .any(|w| w.text.contains("access beyond end of merged section (-4)")),
        "no diagnostic, got {:?}",
        res.warnings
    );
}

const DYN_SCRIPT: &str = r#"
ENTRY(_start)
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .rela.dyn : { __rela_start = .; *(.rela .rela*) __rela_end = .; }
  .relr.dyn : { __relr_start = .; *(.relr.dyn) __relr_end = .; }
  .bss : { *(.bss) }
  /DISCARD/ : { *(.note*) *(.comment) }
}
"#;

/// Property notes reach the output as one merged note, not one per
/// input. The inputs disagree on every property here, which is what
/// makes the merge observable: a consumer reading the first note
/// must see the intersection rather than whichever input landed
/// first.
#[test]
fn property_notes_merge_into_one_note_under_a_gnu_property_segment() {
    const X86_FEATURE_1_AND: u32 = 0xc000_0002;
    const X86_ISA_1_USED: u32 = 0xc001_0002;
    let note = |props: &[(u32, usize, u64)]| {
        gnu_property::encode(
            &props
                .iter()
                .map(|&(ty, datasz, value)| gnu_property::Property::number(ty, datasz, value))
                .collect::<Vec<_>>(),
            8,
        )
    };
    let obj = |unknown: u64, feature: u64, isa: u64| {
        let body = note(&[
            // A type outside every defined range, which the inputs
            // disagree on: dropped, and it must not end the walk
            // over the properties behind it.
            (0x10, 4, unknown),
            (X86_FEATURE_1_AND, 4, feature),
            (X86_ISA_1_USED, 4, isa),
        ]);
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0u8; 16],
            )
            .sec(".note.gnu.property", SHT_NOTE, SHF_ALLOC, 8, &body)
            .build(EM_X86_64)
    };
    let script = parse_linker_script(&super::super::default_script::default_script(false))
        .expect("the built-in default script parses");
    // Build-id on, so the image holds two note sections: PT_NOTE
    // covers a range, and a second note is the first thing that
    // can put a non-note inside it.
    let opts = LdsOptions {
        max_page_size: 0x1000,
        build_id: crate::c5::codegen::BuildId::Sha1,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![
            parse_lds_object("a.o", obj(0xaabb_ccdd, 0x3, 0x0)).expect("parses"),
            parse_lds_object("b.o", obj(0x1122_3344, 0x1, 0x1)).expect("parses"),
        ],
        &opts,
    )
    .expect("the link succeeds");
    let secs = readelf_sections(&res.image);
    let notes: Vec<_> = secs
        .iter()
        .filter(|s| s.0 == ".note.gnu.property")
        .collect();
    assert_eq!(notes.len(), 1, "one merged note section, not one per input");
    // IBT|SHSTK against IBT intersects to IBT; ISA_1_USED is an
    // all-input union, so 0 against 1 keeps 1.
    let want = note(&[(X86_FEATURE_1_AND, 4, 0x1), (X86_ISA_1_USED, 4, 0x1)]);
    assert_eq!(notes[0].3 as usize, want.len(), "sized for the merged note");
    let off = section_file_off(&res.image, notes[0].2);
    assert_eq!(&res.image[off..off + want.len()], &want[..]);
    let phdrs = image_phdrs(&res.image);
    let prop = phdrs
        .iter()
        .find(|p| p.p_type == PT_GNU_PROPERTY)
        .expect("PT_GNU_PROPERTY covers the merged note");
    assert_eq!((prop.p_vaddr, prop.p_filesz), (notes[0].2, notes[0].3));
    // PT_NOTE spans a range, so every allocated section inside it
    // has to be a note: a consumer walks the segment end to end.
    let pt_note = phdrs
        .iter()
        .find(|p| p.p_type == PT_NOTE)
        .expect("PT_NOTE covers the notes");
    let covered: Vec<_> = secs
        .iter()
        .filter(|s| {
            s.4 & SHF_ALLOC != 0
                && s.2 >= pt_note.p_vaddr
                && s.2 < pt_note.p_vaddr + pt_note.p_memsz
        })
        .collect();
    assert_eq!(
        covered.iter().map(|s| s.3).sum::<u64>(),
        pt_note.p_memsz,
        "PT_NOTE holds notes and nothing between them"
    );
    assert!(
        covered.iter().all(|s| s.1 == SHT_NOTE),
        "every section under PT_NOTE is a note: {:?}",
        covered.iter().map(|s| &s.0).collect::<Vec<_>>()
    );
    assert_eq!(covered.len(), 2, "the merged note and the build id");
}

/// The build-id descriptor is the style's digest of the image with the
/// descriptor zero: SHA-1, or lld's 8-byte `fast` id.
#[test]
fn the_build_id_is_the_digest_of_the_image() {
    use crate::c5::codegen::BuildId;
    let script = parse_linker_script(&super::super::default_script::default_script(false))
        .expect("the built-in default script parses");
    for (style, len) in [(BuildId::Sha1, 20), (BuildId::Fast, 8)] {
        let a = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0x90; 16],
            )
            .build(EM_X86_64);
        let opts = LdsOptions {
            build_id: style,
            max_page_size: 0x1000,
            ..Default::default()
        };
        let res = link_with_script(
            &script,
            alloc::vec![parse_lds_object("a.o", a).expect("parses")],
            &opts,
        )
        .expect("the link succeeds");
        let secs = readelf_sections(&res.image);
        let note = (secs.iter())
            .find(|s| s.0 == ".note.gnu.build-id")
            .expect("the note");
        assert_eq!(note.3, 16 + len as u64, "{style:?}");
        let at = section_file_off(&res.image, note.2) + 16;
        let mut zeroed = res.image.clone();
        zeroed[at..at + len].fill(0);
        assert_eq!(
            res.image[at..at + len],
            style.digest(&zeroed)[..],
            "{style:?}"
        );
    }
}

/// A script can put something between two note sections. Each run
/// gets its own PT_NOTE, the way ld emits them, so what a consumer
/// reads end to end over a segment is notes only.
#[test]
fn separated_note_sections_get_a_segment_each() {
    const SEP_SCRIPT: &str = r#"
SECTIONS {
  . = 0x400000 + SIZEOF_HEADERS;
  .note.gnu.property : { *(.note.gnu.property) }
  .text : { *(.text) }
  .note.gnu.build-id : { *(.note.gnu.build-id) }
}
"#;
    let body = gnu_property::encode(&[gnu_property::Property::number(0xc000_0002, 4, 0x3)], 8);
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(".note.gnu.property", SHT_NOTE, SHF_ALLOC, 8, &body)
        .build(EM_X86_64);
    let script = parse_linker_script(SEP_SCRIPT).expect("parses");
    let opts = LdsOptions {
        build_id: crate::c5::codegen::BuildId::Sha1,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &opts,
    )
    .expect("the link succeeds");
    let secs = readelf_sections(&res.image);
    let sec = |n: &str| {
        secs.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n}"))
    };
    let notes = image_phdrs(&res.image)
        .into_iter()
        .filter(|p| p.p_type == PT_NOTE)
        .collect::<Vec<_>>();
    assert_eq!(
        notes.len(),
        2,
        "one segment per run, not one spanning .text"
    );
    for (seg, name) in notes
        .iter()
        .zip([".note.gnu.property", ".note.gnu.build-id"])
    {
        assert_eq!((seg.p_vaddr, seg.p_memsz), (sec(name).2, sec(name).3));
    }
    // ld gives each segment the alignment of what it holds.
    assert_eq!((notes[0].p_align, notes[1].p_align), (8, 4));
}

/// ET_DYN link: every absolute pointer becomes a load-time
/// RELATIVE fixup, packed into .relr.dyn under
/// `pack-relative-relocs`. Regression for the pass-ordering bug
/// that reset placement before sizing the dynamic sections, so
/// they always came out empty.
#[test]
fn dyn_link_emits_relative_relocations() {
    let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
    // .data holds two 8-byte pointers to `target` (an 8-aligned
    // and a non-8-aligned slot) via ABS64.
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 24])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("target", STB_GLOBAL, STT_FUNC, 0, 4, 0)
        // Symtab: null(0), sections(1,2), _start(3), target(4).
        .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
        .reloc(1, 9, 4, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        pack_relative_relocs: true,
        max_page_size: 0x10000,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("dyn link succeeds");
    // ET_DYN.
    assert_eq!(u16::from_le_bytes(res.image[16..18].try_into().unwrap()), 3);
    let secs = readelf_sections(&res.image);
    let relr = secs.iter().find(|s| s.0 == ".relr.dyn");
    let rela = secs.iter().find(|s| s.0 == ".rela.dyn");
    // The 8-aligned slot packs into RELR; the odd slot stays RELA.
    assert!(relr.is_some_and(|s| s.3 > 0), "relr.dyn must be non-empty");
    assert!(
        rela.is_some_and(|s| s.3 >= 24),
        "rela.dyn must hold the odd slot"
    );
    // The RELR word relocates the 8-aligned .data slot's address.
    let syms = image_symbols(&res.image);
    let data_addr = secs.iter().find(|s| s.0 == ".data").unwrap().2;
    let relr_off = section_file_off(&res.image, relr.unwrap().2);
    let w0 = u64::from_le_bytes(res.image[relr_off..relr_off + 8].try_into().unwrap());
    assert_eq!(w0 & 1, 0, "first RELR entry is a base address");
    assert_eq!(w0, data_addr, "RELR relocates the .data pointer slot");
    // The RELA entry is R_AARCH64_RELATIVE (type 1027) at the odd slot.
    let rela_off = section_file_off(&res.image, rela.unwrap().2);
    let r_offset = u64::from_le_bytes(res.image[rela_off..rela_off + 8].try_into().unwrap());
    let r_type = u32::from_le_bytes(res.image[rela_off + 8..rela_off + 12].try_into().unwrap());
    assert_eq!(r_offset, data_addr + 9);
    assert_eq!(r_type, rt::R_AARCH64_RELATIVE);
    let _ = syms;
}

/// A `.text` displacement holding `slot`'s address as a 32-bit
/// absolute, plus an address-width `.data` pointer to it.
fn narrow_abs_object() -> Vec<u8> {
    TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("slot", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        // Symtab: null(0), sections(1,2), _start(3), slot(4).
        .reloc(0, 4, 4, rt::R_X86_64_32S, 0)
        .reloc(1, 8, 4, rt::R_X86_64_64, 0)
        .build(EM_X86_64)
}

/// An absolute relocation narrower than an address has no dynamic
/// form -- `R_X86_64_RELATIVE` writes an 8-byte word -- so an
/// ET_DYN image cannot carry the site. The engine used to write
/// the link-time address and emit no `.rela.dyn` entry covering
/// it, which the loader's slide then invalidated. GNU ld declines
/// the same input. The ET_EXEC link, where the address is a
/// link-time constant, still writes it.
#[test]
fn a_narrow_absolute_is_declined_in_a_dyn_link() {
    let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
    let link = |emit, shared| {
        link_with_script(
            &script,
            alloc::vec![parse_lds_object("t.o", narrow_abs_object()).expect("parses")],
            &LdsOptions {
                emit,
                shared,
                max_page_size: 0x1000,
                ..Default::default()
            },
        )
    };
    let res = link(LdsEmit::Exec, false).expect("exec link succeeds");
    let secs = readelf_sections(&res.image);
    let data_addr = secs.iter().find(|s| s.0 == ".data").expect(".data").2;
    let text_off = section_file_off(
        &res.image,
        secs.iter().find(|s| s.0 == ".text").expect(".text").2,
    );
    assert_eq!(
        u32::from_le_bytes(res.image[text_off + 4..text_off + 8].try_into().unwrap()) as u64,
        data_addr,
        "ET_EXEC keeps writing the link-time address"
    );
    assert_eq!(
        alloc::format!("{}", link(LdsEmit::Dyn, false).expect_err("pie link fails")),
        "error: t.o(.text+0x4): R_X86_64_32S (11) against symbol `slot` can not be used \
             when making a position-independent executable: the reference needs an absolute \
             address, which no load address supplies [B6012] [relocation]"
    );
    assert!(
        alloc::format!(
            "{}",
            link(LdsEmit::Dyn, true).expect_err("shared link fails")
        )
        .contains("when making a shared object"),
        "the refusal names the output kind"
    );
}

/// The screen fires only where no dynamic form exists. An
/// address-width absolute against a load address is exactly what
/// `.rela.dyn` carries, so the same input that loses its narrow
/// site keeps its RELATIVE entry.
#[test]
fn a_dyn_link_covers_an_address_width_absolute() {
    let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 16])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("slot", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .reloc(1, 8, 4, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("t.o", a).expect("parses")],
        &LdsOptions {
            emit: LdsEmit::Dyn,
            max_page_size: 0x1000,
            ..Default::default()
        },
    )
    .expect("abs64 links");
    let secs = readelf_sections(&res.image);
    let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect(".rela.dyn");
    let off = section_file_off(&res.image, rela.2);
    assert_eq!(rela.3, 24, "one RELA entry covers the ABS64 slot");
    assert_eq!(
        u32::from_le_bytes(res.image[off + 8..off + 12].try_into().unwrap()),
        rt::R_X86_64_RELATIVE
    );
}

/// An absolute against a global SHN_ABS symbol holds a link-time
/// constant at any field width: no load address is involved, so
/// the site keeps its value and needs no dynamic entry. Such a
/// symbol is its own entry in the global table, which the
/// load-address test used to follow until the stack ran out.
#[test]
fn a_dyn_link_keeps_an_absolute_global_constant() {
    let script = parse_linker_script(DYN_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("KCONST", STB_GLOBAL, STT_OBJECT, usize::MAX - 1, 0x1234, 0)
        // Symtab: null(0), sections(1,2), _start(3), KCONST(4).
        .reloc(0, 4, 4, rt::R_X86_64_32S, 0)
        .reloc(1, 0, 4, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("t.o", a).expect("parses")],
        &LdsOptions {
            emit: LdsEmit::Dyn,
            max_page_size: 0x1000,
            ..Default::default()
        },
    )
    .expect("an absolute constant links");
    let secs = readelf_sections(&res.image);
    let body =
        |name: &str| section_file_off(&res.image, secs.iter().find(|s| s.0 == name).expect(name).2);
    let text_off = body(".text");
    assert_eq!(
        u32::from_le_bytes(res.image[text_off + 4..text_off + 8].try_into().unwrap()),
        0x1234
    );
    let data_off = body(".data");
    assert_eq!(
        u64::from_le_bytes(res.image[data_off..data_off + 8].try_into().unwrap()),
        0x1234
    );
    assert!(
        !secs.iter().any(|s| s.0 == ".rela.dyn" && s.3 > 0),
        "a constant needs no dynamic entry"
    );
}

/// An ABS64 slot against a symbol only the script defines is a
/// load-address fixup like any other: it must reach the dynamic
/// tables (RELR here) and, since RELR stores the addend in place,
/// carry the link-time value even under
/// `--no-apply-dynamic-relocs`. The collection used to drop such
/// slots -- no fixup, zero in place.
#[test]
fn dyn_link_relocates_script_symbol_slots() {
    let script = parse_linker_script(
            "ENTRY(_start)\nSECTIONS {\n  . = 0;\n  .text : { *(.text*) }\n  .rodata : { table_start = .; *(.rodata*) }\n  .data : { *(.data*) }\n  .rela.dyn : { *(.rela .rela*) }\n  .relr.dyn : { *(.relr.dyn) }\n}",
        )
        .expect("parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sec(".rodata", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("table_start", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        // Symtab: null(0), sections(1..=3), _start(4), table_start(5).
        .reloc(2, 0, 5, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        pack_relative_relocs: true,
        apply_dynamic_relocs: false,
        max_page_size: 0x10000,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let secs = readelf_sections(&res.image);
    let ro_addr = secs.iter().find(|s| s.0 == ".rodata").unwrap().2;
    let data_addr = secs.iter().find(|s| s.0 == ".data").unwrap().2;
    let relr = secs.iter().find(|s| s.0 == ".relr.dyn").expect("relr");
    assert!(relr.3 >= 8, "script-symbol slot must reach RELR");
    let relr_off = section_file_off(&res.image, relr.2);
    let w0 = u64::from_le_bytes(res.image[relr_off..relr_off + 8].try_into().unwrap());
    assert_eq!(w0, data_addr, "RELR relocates the slot");
    let d_off = section_file_off(&res.image, data_addr);
    let slot = u64::from_le_bytes(res.image[d_off..d_off + 8].try_into().unwrap());
    assert_eq!(slot, ro_addr, "slot holds the link-time value in place");
}
/// A shared object's linker script names the dynamic tables, so
/// they must come out with the shape a loader searches: a
/// `.dynsym` holding only what `VERSION` exports, hash tables that
/// find those names, version tables indexing them, and a
/// `.dynamic` naming every one of them plus the soname.
#[test]
fn shared_link_emits_searchable_dynamic_metadata() {
    // The shape of a vDSO link: one exported name, one weak alias
    // whose string is a suffix of it, and everything else local.
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.version : { *(.gnu.version) }
  .gnu.version_d : { *(.gnu.version_d) }
  .dynamic : { *(.dynamic) } :text :dynamic
  .text : { *(.text*) } :text
  /DISCARD/ : { *(.note*) *(.comment) *(.rela*) *(.got*) }
}
PHDRS { text PT_LOAD FLAGS(5) FILEHDR PHDRS; dynamic PT_DYNAMIC FLAGS(4); }
VERSION { LINUX_2.6 { global: __vdso_time; time; local: *; }; }
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 32],
        )
        .sym("__vdso_time", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("time", STB_WEAK, STT_FUNC, 0, 0, 16)
        .sym("internal_helper", STB_GLOBAL, STT_FUNC, 0, 16, 16)
        .build(EM_X86_64);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        soname: Some("linux-vdso.so.1".to_string()),
        hash_style: HashStyle::Both,
        symbolic: true,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &opts,
    )
    .expect("shared link succeeds");
    let secs = readelf_sections(&res.image);
    let sec = |n: &str| {
        secs.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n} in output"))
    };
    assert_eq!(sec(".dynsym").1, dynamic::SHT_DYNSYM);
    assert_eq!(sec(".hash").1, dynamic::SHT_HASH);
    assert_eq!(sec(".gnu.hash").1, dynamic::SHT_GNU_HASH);
    assert_eq!(sec(".gnu.version").1, dynamic::SHT_GNU_VERSYM);
    assert_eq!(sec(".gnu.version_d").1, dynamic::SHT_GNU_VERDEF);
    assert_eq!(sec(".dynamic").1, dynamic::SHT_DYNAMIC);

    // `.dynsym`: the null entry, the two exported names, and the
    // symbol naming the version. `internal_helper` is local.
    let dynsym = image_dynsyms(&res.image);
    let names: BTreeSet<&str> = dynsym.iter().map(|d| d.0.as_str()).collect();
    assert!(names.contains("__vdso_time"), "exported name is present");
    assert!(names.contains("time"), "exported alias is present");
    assert!(names.contains("LINUX_2.6"), "version names itself");
    assert!(
        !names.contains("internal_helper"),
        "`local: *` keeps an unlisted symbol out of .dynsym"
    );
    assert_eq!(dynsym[0].0, "", "index 0 is the null entry");

    // The exported alias shares the longer name's bytes, as bfd's
    // `.dynstr` does.
    let dynstr_off = section_file_off(&res.image, sec(".dynstr").2);
    let dynstr = &res.image[dynstr_off..dynstr_off + sec(".dynstr").3 as usize];
    assert_eq!(
        dynstr.iter().filter(|&&b| b == 0).count(),
        4,
        ".dynstr holds only __vdso_time, the soname, the version, and the leading NUL"
    );

    // Both hash tables find every exported name.
    let hash_off = section_file_off(&res.image, sec(".hash").2);
    let hash = &res.image[hash_off..hash_off + sec(".hash").3 as usize];
    let gnu_off = section_file_off(&res.image, sec(".gnu.hash").2);
    let gnu = &res.image[gnu_off..gnu_off + sec(".gnu.hash").3 as usize];
    for (i, (name, _, _)) in dynsym.iter().enumerate().skip(1) {
        assert_eq!(
            sysv_lookup(hash, &dynsym, name),
            Some(i),
            "`{name}' via .hash"
        );
        assert_eq!(
            gnu_lookup(gnu, &dynsym, name),
            Some(i),
            "`{name}' via .gnu.hash"
        );
    }

    // One versym per dynsym entry; every exported symbol carries
    // the user version (index 2, the base node being index 1).
    assert_eq!(sec(".gnu.version").3, dynsym.len() as u64 * 2);
    let vs_off = section_file_off(&res.image, sec(".gnu.version").2);
    for (i, d) in dynsym.iter().enumerate().skip(1) {
        let v = u16::from_le_bytes(
            res.image[vs_off + i * 2..vs_off + i * 2 + 2]
                .try_into()
                .unwrap(),
        );
        assert_eq!(v, 2, "`{}' carries LINUX_2.6", d.0);
    }
    // Two version definitions: the base (the soname) and LINUX_2.6.
    assert_eq!(sec(".gnu.version_d").3, 2 * (20 + 8));

    // `.dynamic` names each table at the address it landed on.
    let dyn_off = section_file_off(&res.image, sec(".dynamic").2);
    let tags: HashMap<u64, u64> = res.image[dyn_off..dyn_off + sec(".dynamic").3 as usize]
        .as_chunks::<16>()
        .0
        .iter()
        .map(|c| {
            (
                u64::from_le_bytes(c[0..8].try_into().unwrap()),
                u64::from_le_bytes(c[8..16].try_into().unwrap()),
            )
        })
        .collect();
    assert_eq!(tags.get(&dynamic::DT_HASH), Some(&sec(".hash").2));
    assert_eq!(tags.get(&dynamic::DT_GNU_HASH), Some(&sec(".gnu.hash").2));
    assert_eq!(tags.get(&dynamic::DT_SYMTAB), Some(&sec(".dynsym").2));
    assert_eq!(tags.get(&dynamic::DT_STRTAB), Some(&sec(".dynstr").2));
    assert_eq!(tags.get(&dynamic::DT_STRSZ), Some(&sec(".dynstr").3));
    assert_eq!(tags.get(&dynamic::DT_SYMENT), Some(&24));
    assert_eq!(tags.get(&dynamic::DT_VERSYM), Some(&sec(".gnu.version").2));
    assert_eq!(
        tags.get(&dynamic::DT_VERDEF),
        Some(&sec(".gnu.version_d").2)
    );
    assert_eq!(tags.get(&dynamic::DT_VERDEFNUM), Some(&2));
    assert_eq!(tags.get(&dynamic::DT_SYMBOLIC), Some(&0));
    assert_eq!(tags.get(&dynamic::DT_FLAGS), Some(&dynamic::DF_SYMBOLIC));
    assert!(tags.contains_key(&dynamic::DT_NULL));
    // DT_SONAME names the soname's offset in .dynstr.
    let soname_off = *tags.get(&dynamic::DT_SONAME).expect("DT_SONAME") as usize;
    assert_eq!(
        strz(dynstr, soname_off),
        "linux-vdso.so.1",
        "DT_SONAME points at the soname"
    );

    // PT_DYNAMIC covers `.dynamic` exactly.
    let phdrs = image_phdrs(&res.image);
    let pd = phdrs
        .iter()
        .find(|p| p.p_type == PT_DYNAMIC)
        .expect("PT_DYNAMIC");
    assert_eq!(pd.p_vaddr, sec(".dynamic").2);
    assert_eq!(pd.p_filesz, sec(".dynamic").3);

    // `.dynsym` links to `.dynstr`, the hash tables to `.dynsym`.
    let link_of = |n: &str| section_link(&res.image, n);
    assert_eq!(link_of(".dynsym"), section_index(&res.image, ".dynstr"));
    assert_eq!(link_of(".hash"), section_index(&res.image, ".dynsym"));
    assert_eq!(link_of(".gnu.hash"), section_index(&res.image, ".dynsym"));
    assert_eq!(
        link_of(".gnu.version"),
        section_index(&res.image, ".dynsym")
    );
    assert_eq!(
        link_of(".gnu.version_d"),
        section_index(&res.image, ".dynstr")
    );
    assert_eq!(link_of(".dynamic"), section_index(&res.image, ".dynstr"));
}

/// A final link with no `-T` runs the built-in default script, here
/// over `void *p = &p;` linked `-shared -Bsymbolic -z
/// pack-relative-relocs`.
#[test]
fn scriptless_shared_link_uses_the_default_script() {
    let script = parse_linker_script(&super::super::default_script::default_script(true))
        .expect("the built-in default script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("p", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        // Symtab: null(0), sections(1,2), p(3).
        .reloc(1, 0, 3, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        symbolic: true,
        pack_relative_relocs: true,
        max_page_size: 0x200000,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("t.o", a).expect("parses")],
        &opts,
    )
    .expect("scriptless shared link succeeds");
    assert_eq!(
        u16::from_le_bytes(res.image[16..18].try_into().unwrap()),
        ET_DYN
    );
    let secs = readelf_sections(&res.image);
    let sec = |n: &str| {
        secs.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n} in output"))
    };
    // The default script places the dynamic tables and RELR.
    assert!(sec(".relr.dyn").3 >= 8, ".relr.dyn carries the fixup");
    let dynsym = image_dynsyms(&res.image);
    assert!(
        dynsym.iter().any(|d| d.0 == "p"),
        "the defined global reaches .dynsym"
    );
    // A symbol the script defines is exported too, and it is sized
    // for: the tables are built from the same set the sizing pass
    // measured, or the writer refuses the link.
    assert!(
        dynsym.iter().any(|d| d.0 == "_end"),
        "a script-defined symbol reaches .dynsym"
    );
    assert_eq!(
        sec(".dynsym").3 as usize,
        dynsym.len() * 24,
        ".dynsym is sized for exactly what it holds"
    );
    // Read-only tables below the writable group, each on its own
    // segment, as ld's default lays them out.
    assert!(sec(".gnu.hash").2 < sec(".text").2);
    assert!(sec(".text").2 < sec(".dynamic").2);
    assert!(sec(".dynamic").2 < sec(".data").2);
    let dyn_off = section_file_off(&res.image, sec(".dynamic").2);
    let tags: HashMap<u64, u64> = res.image[dyn_off..dyn_off + sec(".dynamic").3 as usize]
        .as_chunks::<16>()
        .0
        .iter()
        .map(|c| {
            (
                u64::from_le_bytes(c[0..8].try_into().unwrap()),
                u64::from_le_bytes(c[8..16].try_into().unwrap()),
            )
        })
        .collect();
    assert_eq!(tags.get(&dynamic::DT_RELR), Some(&sec(".relr.dyn").2));
    assert_eq!(tags.get(&dynamic::DT_RELRSZ), Some(&sec(".relr.dyn").3));
    assert_eq!(tags.get(&dynamic::DT_RELRENT), Some(&8));
    assert_eq!(tags.get(&dynamic::DT_GNU_HASH), Some(&sec(".gnu.hash").2));
    // The writable group gets its own PT_LOAD and a PT_DYNAMIC.
    let phdrs = image_phdrs(&res.image);
    let loads: Vec<&Elf64Phdr> = phdrs.iter().filter(|p| p.p_type == PT_LOAD).collect();
    assert_eq!(loads.len(), 2, "read-only and writable segments");
    assert_eq!(loads[0].p_flags & PF_W, 0);
    assert_ne!(loads[1].p_flags & PF_W, 0);
    assert!(phdrs.iter().any(|p| p.p_type == PT_DYNAMIC));
}

/// A `-shared` link whose script discards the dynamic tables gets no
/// dynamic sections.
#[test]
fn shared_link_honours_discarding_the_dynamic_tables() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0;
  /DISCARD/ : { *(.dynsym) *(.dynstr) *(.hash) *(.gnu.hash) *(.dynamic) *(.gnu.version*) }
  .text : { *(.text*) }
  .rela.dyn : { *(.rela*) }
}
"#,
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sym("exported", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .build(EM_X86_64);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        max_page_size: 0x1000,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &opts,
    )
    .expect("links");
    for n in [".dynsym", ".dynstr", ".gnu.hash", ".hash", ".dynamic"] {
        assert!(
            !readelf_sections(&res.image).iter().any(|s| s.0 == n),
            "{n} must stay discarded"
        );
    }
    assert!(
        !image_phdrs(&res.image)
            .iter()
            .any(|p| p.p_type == PT_DYNAMIC),
        "no PT_DYNAMIC without a .dynamic"
    );
}

/// bfd merge layout for an aligned string class: entries keep the
/// alignment implied by their input offsets, deduplicate on
/// identity, tail-merge only when the length difference is a
/// multiple of the shorter entry's alignment, assign offsets in
/// first-seen order with padding, and the pool tail pads to the
/// section alignment when every member size is a multiple of it.
#[test]
fn merge_pool_matches_bfd_layout() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } }",
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".rodata.str1.8",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            8,
            b"world\0\0\0friend\0\0",
        )
        .entsize(1, 1)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("m1_pad", STB_GLOBAL, STT_OBJECT, 1, 6, 0)
        .sym("m1_end", STB_GLOBAL, STT_OBJECT, 1, 16, 0)
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".rodata.str1.8",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            8,
            b"orld\0\0\0\0",
        )
        .entsize(0, 1)
        .sym("b_str", STB_GLOBAL, STT_OBJECT, 0, 0, 5)
        .build(EM_X86_64);
    let objs = alloc::vec![
        parse_lds_object("a.o", a).expect("parses"),
        parse_lds_object("b.o", b).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
    // "orld\0" cannot tail into "world\0": the length delta (1) is
    // not a multiple of its alignment (8). The empty string from
    // the padding (alignment 2) tails into "orld\0" at delta 4.
    // First-seen layout with per-entry alignment:
    //   world\0 @0, friend\0 @8, orld\0 @16, tail pad to 24.
    assert_eq!(ro.3, 24, "pool size");
    let off = section_file_off(&res.image, ro.2);
    assert_eq!(
        &res.image[off..off + 24],
        b"world\0\0\0friend\0\0orld\0\0\0\0"
    );
    let syms = image_symbols(&res.image);
    assert_eq!(find_sym(&syms, "b_str"), ro.2 + 16);
    // The padding byte at input offset 6 remaps to the shared
    // empty string inside "orld\0" (its NUL at pool offset 20).
    assert_eq!(find_sym(&syms, "m1_pad"), ro.2 + 20);
    // An offset at the input's end resolves to the pool's end.
    assert_eq!(find_sym(&syms, "m1_end"), ro.2 + 24);
}

/// Fixed-entsize pools deduplicate on identity in first-seen
/// order; a section whose entsize is below its alignment fails
/// bfd's sanity check and stays unmerged.
#[test]
fn merge_fixed_pool_dedupes_and_rejects_underaligned() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text*) } .rodata : { *(.rodata*) } }",
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".rodata.cst8",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            8,
            &[
                1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
            ],
        )
        // entsize 8 below the 16-byte alignment: kept verbatim.
        .sec(
            ".rodata.cst16",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            16,
            &[3u8; 16],
        )
        .entsize(1, 8)
        .entsize(2, 8)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("third", STB_GLOBAL, STT_OBJECT, 1, 16, 8)
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".rodata.cst8",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE,
            8,
            &[2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0],
        )
        .entsize(0, 8)
        .sym("b_two", STB_GLOBAL, STT_OBJECT, 0, 0, 8)
        .sym("b_four", STB_GLOBAL, STT_OBJECT, 0, 8, 8)
        .build(EM_X86_64);
    let objs = alloc::vec![
        parse_lds_object("a.o", a).expect("parses"),
        parse_lds_object("b.o", b).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let ro = secs.iter().find(|s| s.0 == ".rodata").expect("rodata");
    // Pool: [1][2][4] (24 bytes), pad to 16, verbatim cst16.
    assert_eq!(ro.3, 24 + 8 + 16, "pool + alignment pad + verbatim cst16");
    let syms = image_symbols(&res.image);
    assert_eq!(find_sym(&syms, "third"), ro.2, "duplicate entry folds");
    assert_eq!(find_sym(&syms, "b_two"), ro.2 + 8);
    assert_eq!(find_sym(&syms, "b_four"), ro.2 + 16);
}

fn shared_input(soname: &str, funcs: &[&str], data: &[&str]) -> SharedInput {
    SharedInput {
        lib: DynamicImage {
            soname: soname.to_string(),
            machine: EM_X86_64,
            exports: funcs.iter().chain(data).map(|s| s.to_string()).collect(),
            data_exports: data.iter().map(|s| s.to_string()).collect(),
            function_exports: funcs.iter().map(|s| s.to_string()).collect(),
            copy_layout: data
                .iter()
                .map(|s| (s.to_string(), (8, 8, false)))
                .collect(),
            ..Default::default()
        },
        as_needed: false,
    }
}

/// A PIE against shared libraries, under the built-in script.
fn dynamic_opts(libs: Vec<SharedInput>) -> LdsOptions {
    LdsOptions {
        emit: LdsEmit::Dyn,
        interp: Some(String::from("/lib64/ld-linux-x86-64.so.2")),
        shared_libs: libs,
        max_page_size: 0x200000,
        ..LdsOptions::default()
    }
}

/// `.text` calling `foo` and loading `bar` through the GOT.
fn import_user() -> Vec<u8> {
    let body = [
        0xe8, 0, 0, 0, 0, // call foo
        0x48, 0x8b, 0x05, 0, 0, 0, 0, // mov bar@GOTPCREL(%rip), %rax
        0xc3, 0, 0, 0,
    ];
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &body)
        .reloc(0, 1, 3, rt::R_X86_64_PLT32, -4)
        .reloc(0, 8, 4, rt::R_X86_64_REX_GOTPCRELX, -4)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 13)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .build(EM_X86_64)
}

fn dyn_tags(image: &[u8]) -> Vec<(u64, u64)> {
    let (_, body) = image_section(image, ".dynamic");
    body.as_chunks::<16>()
        .0
        .iter()
        .map(|c| {
            (
                u64::from_le_bytes(c[..8].try_into().unwrap()),
                u64::from_le_bytes(c[8..].try_into().unwrap()),
            )
        })
        .collect()
}

fn dynstr_at(image: &[u8], off: u64) -> String {
    let (_, s) = image_section(image, ".dynstr");
    strz(&s, off as usize)
}

/// A `-pie` link carries `DT_FLAGS_1` with `DF_1_PIE`, as GNU ld's and
/// lld's do; a `-shared` link does not.
#[test]
fn only_a_pie_link_carries_df_1_pie() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    for (shared, want) in [(false, Some(dynamic::DF_1_PIE)), (true, None)] {
        let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
        let mut opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
        opts.shared = shared;
        let res = link_with_script(&script, objs, &opts).expect("links");
        let flags_1 = dyn_tags(&res.image)
            .into_iter()
            .find(|&(t, _)| t == dynamic::DT_FLAGS_1)
            .map(|(_, v)| v);
        assert_eq!(flags_1, want, "shared={shared}");
    }
}

/// The `-z` keywords that record a loader policy reach `.dynamic` as GNU
/// ld writes them: `now` as `DF_BIND_NOW` and `DF_1_NOW`, `origin` in
/// both words, the rest in `DT_FLAGS_1`, and an executable keeps none
/// of the bits only a shared object can carry.
#[test]
fn loader_keywords_record_their_dynamic_flags() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let mut z = ZKeywords::default();
    for kw in ["now", "origin", "nodelete", "nodefaultlib", "initfirst"] {
        z.push(parse_z_keyword(kw).unwrap());
    }
    for (shared, flags_1) in [
        (
            true,
            dynamic::DF_1_NOW
                | dynamic::DF_1_ORIGIN
                | dynamic::DF_1_NODELETE
                | dynamic::DF_1_NODEFLIB
                | dynamic::DF_1_INITFIRST,
        ),
        (
            false,
            dynamic::DF_1_NOW | dynamic::DF_1_ORIGIN | dynamic::DF_1_NODEFLIB | dynamic::DF_1_PIE,
        ),
    ] {
        let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
        let mut opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
        opts.shared = shared;
        opts.take_z_keywords(&z).expect("the engine takes them");
        let res = link_with_script(&script, objs, &opts).expect("links");
        let tag = |want: u64| {
            dyn_tags(&res.image)
                .into_iter()
                .find(|&(t, _)| t == want)
                .map(|(_, v)| v)
        };
        let flags = dynamic::DF_BIND_NOW | dynamic::DF_ORIGIN;
        assert_eq!(tag(dynamic::DT_FLAGS), Some(flags), "shared={shared}");
        assert_eq!(tag(dynamic::DT_FLAGS_1), Some(flags_1), "shared={shared}");
    }
}

/// An executable's `.dynamic` carries `DT_DEBUG`, the slot the loader
/// writes its `r_debug` into for a debugger; a shared object's does not,
/// as under GNU ld.
#[test]
fn an_executable_takes_dt_debug_and_a_shared_object_does_not() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    for shared in [false, true] {
        let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
        let mut opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
        opts.shared = shared;
        let res = link_with_script(&script, objs, &opts).expect("links");
        let tags = dyn_tags(&res.image);
        let debug = tags.iter().find(|&&(t, _)| t == dynamic::DT_DEBUG);
        assert_eq!(
            debug,
            (!shared).then_some(&(dynamic::DT_DEBUG, 0)),
            "shared={shared}"
        );
    }
}

/// `-z common-page-size=` is what `CONSTANT (COMMONPAGESIZE)` reads, and
/// `-z muldefs` lets the first of two definitions stand.
#[test]
fn common_page_size_and_muldefs_reach_the_link() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x400000; .text : { *(.text) } __common = CONSTANT (COMMONPAGESIZE); }",
    )
    .unwrap();
    let obj = |name: &str, byte: u8| {
        let o = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[byte])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1);
        parse_lds_object(name, o.build(EM_X86_64)).expect("parses")
    };
    let link = |z: &[&str]| {
        let mut keywords = ZKeywords::default();
        for kw in z {
            keywords.push(parse_z_keyword(kw).unwrap());
        }
        let mut opts = LdsOptions::default();
        opts.take_z_keywords(&keywords)
            .expect("the engine takes them");
        link_with_script(
            &script,
            alloc::vec![obj("a.o", 0xc3), obj("b.o", 0x90)],
            &opts,
        )
    };
    let err = link(&[]).expect_err("two definitions of _start");
    assert!(
        format!("{err}").contains("multiple definition of `_start`"),
        "{err}"
    );
    let res = link(&["muldefs", "common-page-size=0x400"]).expect("muldefs links");
    let syms = image_symbols(&res.image);
    assert_eq!(find_sym(&syms, "__common"), 0x400);
    let start = find_sym(&syms, "_start");
    assert_eq!(
        res.image[section_file_off(&res.image, start)],
        0xc3,
        "the first definition stands"
    );
}

/// A shared library input takes a `DT_NEEDED` naming its soname,
/// and `--dynamic-linker` an `.interp` a loader can find through
/// `PT_INTERP`, with `PT_PHDR` for the load bias.
#[test]
fn a_shared_library_input_records_a_dependency() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
    let mut opts = dynamic_opts(alloc::vec![
        shared_input("libc.so.6", &["foo"], &["bar"]),
        shared_input("libm.so.6", &["unused"], &[]),
    ]);
    opts.rpath = alloc::vec![String::from("/opt/lib"), String::from("$ORIGIN")];
    opts.shared_libs[1].as_needed = true;
    let res = link_with_script(&script, objs, &opts).expect("links");
    let needed: Vec<String> = dyn_tags(&res.image)
        .iter()
        .filter(|&&(t, _)| t == dynamic::DT_NEEDED)
        .map(|&(_, v)| dynstr_at(&res.image, v))
        .collect();
    assert_eq!(
        needed,
        alloc::vec![String::from("libc.so.6")],
        "the library the link binds to is recorded; an AS_NEEDED one it does not use is not"
    );
    let rpath: Vec<String> = dyn_tags(&res.image)
        .iter()
        .filter(|&&(t, _)| t == dynamic::DT_RPATH)
        .map(|&(_, v)| dynstr_at(&res.image, v))
        .collect();
    assert_eq!(rpath, alloc::vec![String::from("/opt/lib:$ORIGIN")]);
    let (_, interp) = image_section(&res.image, ".interp");
    assert_eq!(interp, b"/lib64/ld-linux-x86-64.so.2\0");
    let phdrs = image_phdrs(&res.image);
    let interp_seg = phdrs
        .iter()
        .find(|p| p.p_type == PT_INTERP)
        .expect("PT_INTERP");
    let (addr, _) = image_section(&res.image, ".interp");
    assert_eq!(interp_seg.p_vaddr, addr);
    let phdr_seg = phdrs.iter().find(|p| p.p_type == PT_PHDR).expect("PT_PHDR");
    assert_eq!(phdr_seg.p_offset, 64, "the table follows the ELF header");
    assert_eq!(
        phdr_seg.p_filesz,
        phdrs.len() as u64 * 56,
        "and covers all of it"
    );
    let load = phdrs
        .iter()
        .find(|p| p.p_type == PT_LOAD)
        .expect("a loadable segment");
    assert_eq!(
        (load.p_offset, load.p_vaddr),
        (0, 0),
        "the first load covers the headers a loader reads"
    );
}

/// `(offset, symbol index, type, addend)` of each entry of a RELA section.
fn rela_entries(body: &[u8]) -> Vec<(u64, u32, u32, i64)> {
    let word = |c: &[u8], at: usize| u64::from_le_bytes(c[at..at + 8].try_into().unwrap());
    (body.as_chunks::<24>().0.iter())
        .map(|c| {
            let info = word(c, 8);
            (
                word(c, 0),
                (info >> 32) as u32,
                info as u32,
                word(c, 16) as i64,
            )
        })
        .collect()
}

/// GNU ld 2.46.1 gives a load through the GOT a slot `GLOB_DAT` fills, and
/// a call a lazy PLT entry (x86-64 psABI, procedure linkage table): the
/// header pushes `.got.plt[1]` and jumps through `.got.plt[2]`, the
/// loader's; the entry jumps through its own `.got.plt` slot, which holds
/// the entry's `push` until a `JUMP_SLOT` in `.rela.plt` binds it.
/// `.dynamic` names the table and the slots. The called import takes no
/// `.got` slot.
#[test]
fn an_import_is_called_through_a_lazy_plt_entry_and_loaded_through_a_got_slot() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
    let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
    let res = link_with_script(&script, objs, &opts).expect("links");
    let img = &res.image;
    let index = |name: &str| image_dynsyms(img).iter().position(|s| s.0 == name).unwrap() as u32;
    let (got, got_body) = image_section(img, ".got");
    assert_eq!(got_body.len(), 8, "one slot, the load's");
    let (_, rela) = image_section(img, ".rela.dyn");
    assert_eq!(
        rela_entries(&rela),
        [(got, index("bar"), rt::R_X86_64_GLOB_DAT, 0)]
    );
    let (gotplt, gotplt_body) = image_section(img, ".got.plt");
    let (plt, stubs) = image_section(img, ".plt");
    let (_, relaplt) = image_section(img, ".rela.plt");
    let slot = gotplt + 24;
    assert_eq!(
        rela_entries(&relaplt),
        [(slot, index("foo"), rt::R_X86_64_JUMP_SLOT, 0)]
    );
    let rel = |at: u64, to: u64| (to.wrapping_sub(at) as u32).to_le_bytes();
    let mut want = alloc::vec![0xff, 0x35];
    want.extend(rel(plt + 6, gotplt + 8));
    want.extend([0xff, 0x25]);
    want.extend(rel(plt + 12, gotplt + 16));
    want.extend([0x0f, 0x1f, 0x40, 0x00, 0xff, 0x25]);
    want.extend(rel(plt + 22, slot));
    want.extend([0x68, 0, 0, 0, 0, 0xe9]);
    want.extend(rel(plt + 32, plt));
    assert_eq!(stubs, want);
    assert_eq!(
        u64::from_le_bytes(gotplt_body[24..32].try_into().unwrap()),
        plt + 22
    );
    let (text_addr, text) = image_section(img, ".text");
    assert_eq!(
        text_addr as i64 + 5 + u32_at(&text, 1) as i32 as i64,
        (plt + 16) as i64
    );
    assert_eq!(text[5..8], [0x48, 0x8b, 0x05], "the load keeps its slot");
    assert_eq!(
        text_addr as i64 + 12 + u32_at(&text, 8) as i32 as i64,
        got as i64
    );
    let tags = dyn_tags(img);
    let tag = |t: u64| tags.iter().find(|e| e.0 == t).map(|e| e.1);
    let (relaplt_addr, _) = image_section(img, ".rela.plt");
    assert_eq!(tag(dynamic::DT_PLTGOT), Some(gotplt));
    assert_eq!(tag(dynamic::DT_JMPREL), Some(relaplt_addr));
    assert_eq!(tag(dynamic::DT_PLTRELSZ), Some(24));
    assert_eq!(tag(dynamic::DT_PLTREL), Some(dynamic::DT_RELA));
}

/// A shared object's reference that would need the imported object copied
/// into it is refused rather than left pointing at nothing: only an
/// executable holds copies.
#[test]
fn a_shared_objects_direct_reference_to_imported_data_is_refused() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let obj = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x90; 8],
        )
        .reloc(0, 2, 3, rt::R_X86_64_PC32, -4)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", obj).expect("parses")];
    let opts = LdsOptions {
        shared: true,
        ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &[], &["bar"])])
    };
    let e = alloc::format!(
        "{}",
        link_with_script(&script, objs, &opts).expect_err("refused")
    );
    assert!(
        e.contains("`bar'") && e.contains("cannot reach a shared library"),
        "{e}"
    );
}

/// A `zR` CIE, the shape gcc emits for a unit needing no
/// personality routine.
fn eh_cie_zr() -> Vec<u8> {
    alloc::vec![
        0x14, 0, 0, 0, 0, 0, 0, 0, 1, b'z', b'R', 0, 1, 0x78, 0x10, 1, 0x1b, 0x0c, 0x07, 0x08,
        0x90, 0x01, 0, 0,
    ]
}

/// A `zPR` CIE; its personality pointer sits at offset 0x12 and is
/// relocated.
fn eh_cie_zpr() -> Vec<u8> {
    alloc::vec![
        0x1c, 0, 0, 0, 0, 0, 0, 0, 1, b'z', b'P', b'R', 0, 1, 0x78, 0x10, 6, 0x9b, 0, 0, 0, 0,
        0x1b, 0x0c, 0x07, 0x08, 0x90, 0x01, 0, 0, 0, 0,
    ]
}

/// An FDE of `total` bytes naming a CIE `back` bytes before its own
/// pointer field; its initial location sits at offset 8 and is
/// relocated.
fn eh_fde_sized(back: u32, total: usize) -> Vec<u8> {
    let mut f: Vec<u8> = alloc::vec![(total - 4) as u8, 0, 0, 0];
    f.extend_from_slice(&back.to_le_bytes());
    f.extend_from_slice(&[0, 0, 0, 0, 8, 0, 0, 0]);
    f.resize(total, 0);
    f
}

fn eh_fde(back: u32) -> Vec<u8> {
    eh_fde_sized(back, 24)
}

fn image_section(image: &[u8], name: &str) -> (u64, Vec<u8>) {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
    let str_sh = sh(u16::from_le_bytes(image[62..64].try_into().unwrap()) as usize);
    let names = &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
    let h = (1..shnum)
        .map(sh)
        .find(|h| strz(names, h.sh_name as usize) == name)
        .expect("section is in the image");
    (
        h.sh_addr,
        image[h.sh_offset as usize..(h.sh_offset + h.sh_size) as usize].to_vec(),
    )
}

/// bfd folds the identical CIEs of separately compiled units into
/// one and repoints every FDE at it. The pointer is the distance
/// back from its own field, so each FDE takes a different value.
#[test]
fn eh_frame_folds_identical_cies() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
    )
    .expect("parses");
    let unit = |name: &str| {
        let mut eh = eh_cie_zr();
        eh.extend_from_slice(&eh_fde(0x1c));
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0x90; 8],
            )
            .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
            // The FDE's initial location, against the text it covers.
            .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
            .sym(name, STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .build(EM_X86_64)
    };
    let objs = alloc::vec![
        parse_lds_object("a.o", unit("fa")).expect("parses"),
        parse_lds_object("b.o", unit("fb")).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24 + 24, "one CIE, both FDEs");
    assert_eq!(&body[..24], &eh_cie_zr()[..], "the first CIE stays");
    assert_eq!(
        u32::from_le_bytes(body[0x1c..0x20].try_into().unwrap()),
        0x1c
    );
    assert_eq!(
        u32::from_le_bytes(body[0x34..0x38].try_into().unwrap()),
        0x34,
        "the second FDE reaches back to the surviving CIE"
    );
    let fdes = eh_frame::scan(&body, addr).expect("scans");
    let syms = image_symbols(&res.image);
    assert_eq!(
        fdes.iter().map(|e| e.pc).collect::<Vec<_>>(),
        alloc::vec![find_sym(&syms, "fa"), find_sym(&syms, "fb")],
        "both FDEs still cover their own text"
    );
}

/// A zero length ends `.eh_frame`, so the alignment padding between
/// two inputs may not fall inside the linked stream: the entry
/// before it absorbs the gap, as bfd's writer does.
#[test]
fn eh_frame_entries_leave_no_gap_at_an_input_boundary() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
    )
    .expect("parses");
    // 24-byte CIE + 20-byte FDE: 44 bytes under an 8-byte
    // alignment, so the next input would start four bytes on.
    let unit = |name: &str| {
        let mut eh = eh_cie_zr();
        eh.extend_from_slice(&eh_fde_sized(0x1c, 20));
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0x90; 8],
            )
            .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
            .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
            .sym(name, STB_GLOBAL, STT_FUNC, 0, 0, 8)
            .build(EM_X86_64)
    };
    let objs = alloc::vec![
        parse_lds_object("a.o", unit("fa")).expect("parses"),
        parse_lds_object("b.o", unit("fb")).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24 + 24, "one CIE and two padded FDEs");
    assert_eq!(
        u32::from_le_bytes(body[0x18..0x1c].try_into().unwrap()),
        0x14,
        "the first FDE covers the padding that followed it"
    );
    assert_eq!(eh_frame::scan(&body, addr).expect("scans").len(), 2);
    assert_eq!(eh_frame::count_fdes(&body), 2);
}

/// bfd keys a CIE on the personality routine it resolves to, not on
/// the bytes of the pointer, which relocation leaves zero in every
/// input.
#[test]
fn eh_frame_cies_split_on_the_personality_they_name() {
    let script = parse_linker_script(
        "SECTIONS { . = 0x1000; .text : { *(.text) } .eh_frame : { *(.eh_frame) } }",
    )
    .expect("parses");
    let unit = |fname: &str, pers: &str, defines: bool| {
        let mut eh = eh_cie_zpr();
        eh.extend_from_slice(&eh_fde(0x24));
        let o = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0x90; 8],
            )
            .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
            .reloc(1, 0x12, 4, rt::R_X86_64_PC32, 0)
            .reloc(1, 0x28, 1, rt::R_X86_64_PC32, 0)
            .sym(fname, STB_GLOBAL, STT_FUNC, 0, 0, 8);
        let sec = if defines { 0 } else { usize::MAX };
        o.sym(pers, STB_GLOBAL, STT_FUNC, sec, 0, 0)
            .build(EM_X86_64)
    };
    let objs = alloc::vec![
        parse_lds_object("a.o", unit("fa", "pers", true)).expect("parses"),
        parse_lds_object("b.o", unit("fb", "pers", false)).expect("parses"),
        parse_lds_object("c.o", unit("fc", "pers2", true)).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(
        body.len(),
        32 + 24 + 24 + 32 + 24,
        "the two units naming one routine share a CIE; the third keeps its own"
    );
    assert_eq!(
        u32::from_le_bytes(body[0x3c..0x40].try_into().unwrap()),
        0x3c,
        "b.o's FDE reaches back to a.o's CIE"
    );
    assert_eq!(
        u32::from_le_bytes(body[0x74..0x78].try_into().unwrap()),
        0x24,
        "c.o's FDE keeps its own"
    );
    let syms = image_symbols(&res.image);
    let pers = find_sym(&syms, "pers");
    assert_eq!(
        i32::from_le_bytes(body[0x12..0x16].try_into().unwrap()) as i64 + (addr + 0x12) as i64,
        pers as i64,
        "the surviving CIE keeps its own personality relocation"
    );
    assert_eq!(eh_frame::scan(&body, addr).expect("scans").len(), 3);
}

/// `eh_cie_zr` with a different `DW_CFA_def_cfa` offset, so the two
/// fold into nothing.
fn eh_cie_zr_alt() -> Vec<u8> {
    let mut c = eh_cie_zr();
    c[17] = 0x10;
    c
}

/// A `.eh_frame` unit: one text section under `text`, a CIE and a
/// single FDE covering it.
fn eh_unit(text: &str, name: &str, cie: &[u8]) -> Vec<u8> {
    eh_unit_typed(text, name, cie, SHT_PROGBITS)
}

fn eh_unit_typed(text: &str, name: &str, cie: &[u8], shtype: u32) -> Vec<u8> {
    let mut eh = cie.to_vec();
    eh.extend_from_slice(&eh_fde(0x1c));
    TestObj::new()
        .sec(text, SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 8, &[0x90; 8])
        .sec(".eh_frame", shtype, SHF_ALLOC, 8, &eh)
        .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
        .sym(name, STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .build(EM_X86_64)
}

const EH_GC_SCRIPT: &str =
    "SECTIONS { . = 0x1000; .text : { *(.text*) } .eh_frame : { *(.eh_frame) } }";

/// `--gc-sections` drops the FDE describing collected code, and the
/// CIE only that FDE named goes with it. `.eh_frame` is kept but
/// does not propagate, so the collector never reaches the text
/// through it.
#[test]
fn eh_frame_gc_drops_a_collected_fde_and_its_last_cie() {
    let script = parse_linker_script(EH_GC_SCRIPT).expect("parses");
    let objs = || {
        alloc::vec![
            parse_lds_object("a.o", eh_unit(".text.live", "live", &eh_cie_zr())).expect("parses"),
            parse_lds_object("b.o", eh_unit(".text.dead", "dead", &eh_cie_zr_alt()))
                .expect("parses"),
        ]
    };
    let opts = LdsOptions {
        gc_sections: true,
        entry_override: Some(String::from("live")),
        ..LdsOptions::default()
    };
    let res = link_with_script(&script, objs(), &opts).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24, "only the live unit's CIE and FDE");
    assert_eq!(&body[..24], &eh_cie_zr()[..], "the collected CIE is gone");
    assert_eq!(eh_frame::count_fdes(&body), 1);
    let syms = image_symbols(&res.image);
    assert_eq!(
        eh_frame::scan(&body, addr)
            .expect("scans")
            .iter()
            .map(|e| e.pc)
            .collect::<Vec<_>>(),
        alloc::vec![find_sym(&syms, "live")]
    );
    // Without the option both units keep everything.
    let plain = link_with_script(&script, objs(), &LdsOptions::default()).expect("links");
    assert_eq!(image_section(&plain.image, ".eh_frame").1.len(), 4 * 24);
}

/// The x86-64 psABI types `.eh_frame` SHT_X86_64_UNWIND, and gcc
/// and clang emit it that way; pruning and dedup treat it exactly
/// as a SHT_PROGBITS input.
#[test]
fn eh_frame_gc_prunes_unwind_typed_inputs() {
    let script = parse_linker_script(EH_GC_SCRIPT).expect("parses");
    let unit = |text, name, cie: &[u8]| eh_unit_typed(text, name, cie, SHT_X86_64_UNWIND);
    let objs = alloc::vec![
        parse_lds_object("a.o", unit(".text.live", "live", &eh_cie_zr())).expect("parses"),
        parse_lds_object("b.o", unit(".text.dead", "dead", &eh_cie_zr_alt())).expect("parses"),
    ];
    let opts = LdsOptions {
        gc_sections: true,
        entry_override: Some(String::from("live")),
        ..LdsOptions::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24, "only the live unit's CIE and FDE");
    assert_eq!(eh_frame::count_fdes(&body), 1);
    let syms = image_symbols(&res.image);
    assert_eq!(
        eh_frame::scan(&body, addr)
            .expect("scans")
            .iter()
            .map(|e| e.pc)
            .collect::<Vec<_>>(),
        alloc::vec![find_sym(&syms, "live")],
        "the surviving FDE still covers its own text"
    );
}

/// A CIE no FDE names describes nothing wherever it came from, so
/// bfd drops it whether or not anything was collected.
#[test]
fn eh_frame_drops_a_cie_no_fde_names() {
    let script = parse_linker_script(EH_GC_SCRIPT).expect("parses");
    let lone = TestObj::new()
        .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh_cie_zr_alt())
        .build(EM_X86_64);
    let objs = alloc::vec![
        parse_lds_object("a.o", eh_unit(".text.live", "live", &eh_cie_zr())).expect("parses"),
        parse_lds_object("lone.o", lone).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let (_, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24, "the unreferenced CIE contributes none");
    assert_eq!(eh_frame::count_fdes(&body), 1);
}

/// An ABS64 against a non-local symbol in an allocated section the
/// script discards reserves a `.rela.dyn` slot that is never
/// written (bfd sizes the global path without a discard check);
/// local-target relocs in the same section reserve nothing.
#[test]
fn discarded_alloc_relocs_reserve_none_slots() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .data : { *(.data*) }
  .rela.dyn : { *(.rela .rela*) }
  .relr.dyn : { *(.relr.dyn) }
  /DISCARD/ : { *(.export_symbol) }
}
"#,
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sec(".export_symbol", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 16])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("local_t", STB_LOCAL, STT_OBJECT, 0, 4, 0)
        // Symtab: null(0), sections(1..=3), _start(4), local_t(5).
        .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
        .reloc(2, 0, 4, rt::R_AARCH64_ABS64, 0)
        .reloc(2, 8, 5, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        pack_relative_relocs: true,
        max_page_size: 0x10000,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let secs = readelf_sections(&res.image);
    let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect("rela");
    // One reserved slot for the discarded global-target reloc; the
    // local-target one reserves nothing; the live .data slot packs
    // into RELR.
    assert_eq!(rela.3, 24, "one zeroed reservation");
    let off = section_file_off(&res.image, rela.2);
    assert_eq!(&res.image[off..off + 24], &[0u8; 24], "slot reads R_*_NONE");
    let relr = secs.iter().find(|s| s.0 == ".relr.dyn").expect("relr");
    assert!(relr.3 > 0, "live slot packed into RELR");
}

/// Symbols assigned from the top-level location counter attach per
/// ld's section_for_dot: after a dot assignment they bind to the
/// next output section, skipping one the link strips as empty;
/// with no dot assignment in between they bind to the previous
/// allocated section.
#[test]
fn boundary_symbols_attach_like_ld() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text*) }
  . = ALIGN(0x100);
  bnd = .;
  .maybe : { *(.absent) }
  .data : { *(.data*) }
  tail = .;
}
"#,
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[1u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let data_shndx = (secs.iter().position(|s| s.0 == ".data").expect("data") + 1) as u16;
    let syms = image_symbols(&res.image);
    let shndx_of = |name: &str| {
        syms.iter()
            .find(|(n, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name}"))
            .2
    };
    assert_eq!(shndx_of("bnd"), data_shndx, "dot assignment prefers next");
    assert_eq!(shndx_of("tail"), data_shndx, "previous allocated section");
}

/// `(name, st_info, st_shndx)` in symbol table order.
fn image_sym_rows(image: &[u8]) -> Vec<(String, u8, u16)> {
    let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
    for i in 1..shnum {
        let h = sh(i);
        if h.sh_type != SHT_SYMTAB {
            continue;
        }
        let strh = sh(h.sh_link as usize);
        let strtab = &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
        return (0..(h.sh_size / 24) as usize)
            .map(|k| {
                let s: Elf64Sym = read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                (strz(strtab, s.st_name as usize), s.st_info, s.st_shndx)
            })
            .collect();
    }
    Vec::new()
}

fn symtab_objects() -> Vec<LdsObject> {
    // a.o names its source file; b.o has none, and its section is
    // placed ahead of a.o's.
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".rodata.str1.1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_MERGE | SHF_STRINGS,
            1,
            b"hi\0",
        )
        .entsize(1, 1)
        .sym("a.c", STB_LOCAL, STT_FILE, usize::MAX - 1, 0, 0)
        .sym("a_local", STB_LOCAL, STT_OBJECT, 0, 0, 1)
        .sym(".Lstr", STB_LOCAL, STT_NOTYPE, 1, 0, 0)
        .sym("gfunc", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".text.b",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc3],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("b_local", STB_LOCAL, STT_OBJECT, 1, 0, 4)
        .sym("gdata", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .build(EM_X86_64);
    alloc::vec![
        parse_lds_object("obj/a.o", a).expect("a parses"),
        parse_lds_object("lib.a(b.o)", b).expect("b parses"),
    ]
}

const SYMTAB_SCRIPT: &str = r#"
SECTIONS {
  . = 0x1000;
  .btext : { *(.text.b) }
  .text : { *(.text) }
  .rodata : { *(.rodata.str1.1) }
  .data : { *(.data) }
  alias_func = gfunc;
  alias_data = gdata;
  alias_sum = gfunc + gdata;
}
"#;

/// bfd's `.symtab` composition: no section symbols in a final link
/// that emits no relocations, a file symbol heading every object's
/// locals in placement order, compiler temporaries of a merged
/// section dropped, and an assignment carrying the type of the one
/// symbol its expression names.
#[test]
fn symtab_composition_follows_bfd() {
    let script = parse_linker_script(SYMTAB_SCRIPT).expect("script parses");
    let res =
        link_with_script(&script, symtab_objects(), &LdsOptions::default()).expect("link succeeds");
    let rows = image_sym_rows(&res.image);
    assert!(
        rows.iter().all(|(_, info, _)| info & 0xf != STT_SECTION),
        "no section symbols without emitted relocations"
    );
    let files: Vec<&str> = rows
        .iter()
        .filter(|(_, info, _)| info & 0xf == STT_FILE)
        .map(|(n, _, _)| n.as_str())
        .collect();
    assert_eq!(files, alloc::vec!["b.o", "a.c"], "placement order");
    let kind = |name: &str| {
        rows.iter()
            .find(|(n, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name}"))
            .1
            & 0xf
    };
    assert_eq!(kind("alias_func"), STT_FUNC);
    assert_eq!(kind("alias_data"), STT_OBJECT);
    assert_eq!(kind("alias_sum"), STT_NOTYPE, "two names carry no type");
    assert!(
        !rows.iter().any(|(n, _, _)| n == ".Lstr"),
        "merged-section temporary dropped"
    );
    assert!(rows.iter().any(|(n, _, _)| n == "b_local"));
}

/// A definition taken from the location counter outside an output
/// section carries a section in its own entry but hands a number
/// to whatever names it, so the aliases a script builds from one
/// are absolute, as they are in ld.
#[test]
fn a_symbol_defined_from_dot_hands_on_a_number() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text) in_text = .; }
  . = ALIGN(0x1000);
  etext = .;
  .data : { *(.data) }
}
alias_etext = etext;
alias_in_text = in_text;
alias_sum = etext + 4;
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let syms = image_symbols(&res.image);
    let at = |n: &str| {
        let s = syms
            .iter()
            .find(|(name, _, _)| name == n)
            .unwrap_or_else(|| panic!("{n}"));
        (s.1, s.2)
    };
    let text_shndx = 1u16;
    assert_ne!(at("etext").1, SHN_ABS, "the definition keeps a section");
    assert_eq!(at("alias_etext"), (at("etext").0, SHN_ABS));
    assert_eq!(at("alias_sum"), (at("etext").0 + 4, SHN_ABS));
    assert_eq!(
        at("alias_in_text"),
        (at("in_text").0, text_shndx),
        "an in-section definition stays section relative"
    );
}

/// An undefined weak symbol reaches `.symtab` only where a
/// relocation the output keeps names it, as in bfd.
#[test]
fn undefined_weak_symbols_need_a_relocation_naming_them() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text) }
  .data : { *(.data) }
  /DISCARD/ : { *(.gone) }
}
"#,
    )
    .expect("script parses");
    let obj = || {
        let a = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
            .sec(".gone", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
            .sym("wu_kept", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
            .sym("wu_gone", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
            // Symtab: null(0), sections(1..=3), _start(4),
            // wu_kept(5), wu_gone(6).
            .reloc(1, 0, 5, rt::R_X86_64_64, 0)
            .reloc(2, 0, 6, rt::R_X86_64_64, 0)
            .build(EM_X86_64);
        alloc::vec![parse_lds_object("a.o", a).expect("parses")]
    };
    let res = link_with_script(&script, obj(), &LdsOptions::default()).expect("links");
    let names: Vec<String> = image_symbols(&res.image)
        .into_iter()
        .map(|(n, _, _)| n)
        .collect();
    assert!(!names.iter().any(|n| n.starts_with("wu_")), "none kept");
    let opts = LdsOptions {
        emit_relocs: true,
        ..Default::default()
    };
    let res = link_with_script(&script, obj(), &opts).expect("links");
    let weak: Vec<(String, u16)> = image_sym_rows(&res.image)
        .into_iter()
        .filter(|(_, info, _)| info >> 4 == STB_WEAK)
        .map(|(n, _, shndx)| (n, shndx))
        .collect();
    assert_eq!(weak, alloc::vec![("wu_kept".to_string(), SHN_UNDEF)]);
}

/// Without a PHDRS command a PT_LOAD ends where bfd ends one: at a
/// protection change the sections do not share a page across, and
/// at a skipped page. A same-page change and file-backed content
/// after zero fill both stay in the segment.
#[test]
fn default_segments_group_like_bfd() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0;
  .header : { *(.header) }
  . = ALIGN(4);
  .rodata : { *(.rodata) }
  . = ALIGN(0x1000);
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .data : { *(.data) }
  .bss : { *(.bss) }
  . = ALIGN(4);
  .signature : { *(.signature) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(".header", SHT_PROGBITS, SHF_ALLOC, 4, &[0u8; 8])
        .sec(".rodata", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 8])
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sec(".bss", SHT_NOBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 32])
        .sec(".signature", SHT_PROGBITS, SHF_ALLOC, 4, &[0u8; 4])
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let loads: Vec<Elf64Phdr> = image_phdrs(&res.image)
        .into_iter()
        .filter(|p| p.p_type == PT_LOAD)
        .collect();
    let shape: Vec<(u64, u64, u32)> = loads
        .iter()
        .map(|p| (p.p_vaddr, p.p_memsz, p.p_flags))
        .collect();
    assert_eq!(
        shape,
        alloc::vec![
            (0, 0x10, PF_R | PF_W),
            (0x1000, 1, PF_R | PF_X),
            (0x2000, 0x2c, PF_R | PF_W),
        ]
    );
}

/// Link order describes the whole output section, so bfd takes it
/// from the section that opens one and points `sh_link` at the
/// output section its target landed in; the retain flag survives
/// while the group flag does not.
#[test]
fn output_section_flags_follow_bfd() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x1000;
  .tgt : { *(.tgt) }
  .ordered : { *(.o1) *(.plain) }
  .unordered : { *(.plain2) *(.o2) }
  .kept : { *(.ret) *(.grp) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(".tgt", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
        .sec(
            ".o1",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_LINK_ORDER,
            8,
            &[0u8; 8],
        )
        .sec(".plain", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
        .sec(".plain2", SHT_PROGBITS, SHF_ALLOC, 8, &[0u8; 8])
        .sec(
            ".o2",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_LINK_ORDER,
            8,
            &[0u8; 8],
        )
        .sec(
            ".ret",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_GNU_RETAIN,
            8,
            &[0u8; 8],
        )
        .sec(".grp", SHT_PROGBITS, SHF_ALLOC | SHF_GROUP, 8, &[0u8; 8])
        .links_to(1, 0)
        .links_to(4, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    let flags = |n: &str| {
        secs.iter()
            .find(|s| s.0 == n)
            .unwrap_or_else(|| panic!("{n}"))
            .4
    };
    assert_eq!(flags(".ordered") & SHF_LINK_ORDER, SHF_LINK_ORDER);
    assert_eq!(flags(".unordered") & SHF_LINK_ORDER, 0, "opened unordered");
    assert_eq!(flags(".kept") & SHF_GNU_RETAIN, SHF_GNU_RETAIN);
    assert_eq!(flags(".kept") & SHF_GROUP, 0, "group is input-side");
    let tgt = (secs.iter().position(|s| s.0 == ".tgt").expect("tgt") + 1) as u32;
    assert_eq!(section_link(&res.image, ".ordered"), tgt);
}

/// SHF_EXCLUDE keeps an input section out of a final link whatever
/// its other flags say, and a script naming the section does not
/// bring it back. Measured against GNU ld 2.46.1 on linux-x86_64
/// and linux-aarch64: every `.exc.*` below is dropped there, in a
/// default link and under this script alike.
#[test]
fn shf_exclude_sections_never_reach_a_final_image() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text) }
  .exc.alloc : { *(.exc.alloc) }
  .exc.noalloc : { *(.exc.noalloc) }
  .exc.aw : { *(.exc.aw) }
  .exc.ax : { *(.exc.ax) }
  .keep : { *(.keep) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".exc.alloc",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXCLUDE,
            1,
            &[0xa1, 0xa2, 0xa3, 0xa4],
        )
        .sec(
            ".exc.noalloc",
            SHT_PROGBITS,
            SHF_EXCLUDE,
            1,
            &[0xb1, 0xb2, 0xb3, 0xb4],
        )
        .sec(
            ".exc.aw",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_WRITE | SHF_EXCLUDE,
            1,
            &[0xc1, 0xc2, 0xc3, 0xc4],
        )
        .sec(
            ".exc.ax",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR | SHF_EXCLUDE,
            1,
            &[0xd1, 0xd2, 0xd3, 0xd4],
        )
        .sec(
            ".keep",
            SHT_PROGBITS,
            SHF_ALLOC,
            1,
            &[0xe1, 0xe2, 0xe3, 0xe4],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let secs = readelf_sections(&res.image);
    for name in [".exc.alloc", ".exc.noalloc", ".exc.aw", ".exc.ax"] {
        assert!(
            !secs.iter().any(|s| s.0 == name),
            "{name} reached the image"
        );
    }
    assert!(secs.iter().any(|s| s.0 == ".keep"), "control section kept");
    for marker in [
        [0xa1u8, 0xa2, 0xa3, 0xa4],
        [0xb1, 0xb2, 0xb3, 0xb4],
        [0xc1, 0xc2, 0xc3, 0xc4],
        [0xd1, 0xd2, 0xd3, 0xd4],
    ] {
        assert!(
            !res.image.windows(4).any(|w| w == marker),
            "excluded content {marker:x?} reached the image"
        );
    }
    assert!(
        res.image.windows(4).any(|w| w == [0xe1, 0xe2, 0xe3, 0xe4]),
        "control content missing"
    );
}

/// `--emit-relocs` gives the entries relocations name: one section
/// symbol per output section, and the merged-section temporaries.
#[test]
fn emit_relocs_keeps_the_entries_relocations_name() {
    let script = parse_linker_script(SYMTAB_SCRIPT).expect("script parses");
    let opts = LdsOptions {
        emit_relocs: true,
        ..Default::default()
    };
    let res = link_with_script(&script, symtab_objects(), &opts).expect("link succeeds");
    let rows = image_sym_rows(&res.image);
    let sections = rows
        .iter()
        .filter(|(_, i, _)| i & 0xf == STT_SECTION)
        .count();
    assert_eq!(sections, readelf_sections(&res.image).len() - 3, "one each");
    assert!(rows.iter().any(|(n, _, _)| n == ".Lstr"));
}

/// A shared object's unresolved default-visibility weak reference keeps
/// symbol-based dynamic entries (ABS64 at its slots, GLOB_DAT for its GOT
/// entry), where a PIE linked against no library resolves it to 0 with
/// none, as GNU ld 2.46.1 links them; a hidden global is emitted with
/// local binding in a dynamic link.
#[test]
fn undefweak_keeps_symbol_entries_and_hidden_forces_local() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0;
  .text : { *(.text*) }
  .got : { *(.got) }
  .data : { *(.data*) }
  .rela.dyn : { *(.rela .rela*) }
  .relr.dyn : { *(.relr.dyn) }
}
"#,
    )
    .expect("parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("wref", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .sym("hid", STB_GLOBAL, STT_FUNC, 0, 4, 0)
        .vis(STV_HIDDEN)
        // Symtab: null(0), sections(1..=2), _start(3), wref(4), hid(5).
        .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
        .reloc(0, 0, 4, rt::R_AARCH64_ADR_GOT_PAGE, 0)
        .reloc(0, 4, 4, rt::R_AARCH64_LD64_GOT_LO12_NC, 0)
        .build(EM_AARCH64);
    let link = |shared: bool| {
        let objs = alloc::vec![parse_lds_object("a.o", a.clone()).expect("parses")];
        let opts = LdsOptions {
            emit: LdsEmit::Dyn,
            shared,
            pack_relative_relocs: true,
            max_page_size: 0x10000,
            ..Default::default()
        };
        link_with_script(&script, objs, &opts).expect("links")
    };
    let pie = link(false).image;
    let rela_size = |img: &[u8]| {
        readelf_sections(img)
            .iter()
            .find(|s| s.0 == ".rela.dyn")
            .map(|s| s.3)
    };
    assert!(
        rela_size(&pie).is_none_or(|n| n == 0),
        "a PIE resolves it to 0"
    );
    let res = link(true);
    let secs = readelf_sections(&res.image);
    let rela = secs.iter().find(|s| s.0 == ".rela.dyn").expect("rela");
    assert_eq!(rela.3, 48, "GLOB_DAT for the GOT slot + ABS64 at the site");
    let off = section_file_off(&res.image, rela.2);
    let types: Vec<u32> = (0..2)
        .map(|k| {
            u32::from_le_bytes(
                res.image[off + k * 24 + 8..off + k * 24 + 12]
                    .try_into()
                    .unwrap(),
            )
        })
        .collect();
    assert!(types.contains(&rt::R_AARCH64_GLOB_DAT));
    assert!(types.contains(&rt::R_AARCH64_ABS64));
    // The hidden global is forced local: nm reports it lowercase.
    let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
    let mut hid_info = None;
    for i in 1..shnum {
        let h: Elf64Shdr = read_struct(&res.image, shoff + i * 64).unwrap();
        if h.sh_type == SHT_SYMTAB {
            let strh: Elf64Shdr = read_struct(&res.image, shoff + h.sh_link as usize * 64).unwrap();
            let strtab =
                &res.image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
            for k in 0..(h.sh_size / 24) as usize {
                let at = h.sh_offset as usize + k * 24;
                let noff = u32::from_le_bytes(res.image[at..at + 4].try_into().unwrap());
                if strz(strtab, noff as usize) == "hid" {
                    hid_info = Some(res.image[at + 4]);
                }
            }
        }
    }
    assert_eq!(hid_info.expect("hid emitted") >> 4, STB_LOCAL);
}

// ---------------------------------------------------- ELF32 / i386

const I386_SCRIPT: &str = r#"
ENTRY(_start)
SECTIONS {
  . = 0x1000;
  .text : { *(.text) }
  .text32 : { *(.text32) }
  . = ALIGN(0x1000);
  .rodata : { *(.rodata) }
  .data : { *(.data) }
}
"#;

/// `(name, sh_type, sh_addr, sh_offset, sh_size, sh_flags, sh_entsize)`
/// of every ELF32 section but the null one, in table order.
fn elf32_sections(image: &[u8]) -> Vec<(String, u32, u64, u64, u64, u64, u64)> {
    let shoff = u32::from_le_bytes(image[32..36].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(image[48..50].try_into().unwrap()) as usize;
    let shstrndx = u16::from_le_bytes(image[50..52].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr {
        read_struct::<Elf32Shdr>(image, shoff + i * 40)
            .unwrap()
            .into()
    };
    let str_sh = sh(shstrndx);
    let strtab = &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
    (1..shnum)
        .map(|i| {
            let h = sh(i);
            (
                strz(strtab, h.sh_name as usize),
                h.sh_type,
                h.sh_addr,
                h.sh_offset,
                h.sh_size,
                h.sh_flags,
                h.sh_entsize,
            )
        })
        .collect()
}

fn elf32_section(image: &[u8], name: &str) -> (String, u32, u64, u64, u64, u64, u64) {
    elf32_sections(image)
        .into_iter()
        .find(|s| s.0 == name)
        .unwrap_or_else(|| panic!("no `{name}' in the image"))
}

fn elf32_body<'a>(image: &'a [u8], name: &str) -> &'a [u8] {
    let s = elf32_section(image, name);
    &image[s.3 as usize..(s.3 + s.4) as usize]
}

/// One object exercising every `R_386_*` width the boot links use.
/// Each relocation's addend is stored in the field it relocates,
/// which is where an `SHT_REL` entry keeps it.
fn i386_object() -> Vec<u8> {
    TestObj::new()
        // 0: .text -- PC32 at 1, PC16 at 8, PC8 at 12.
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        // 1: .text32 -- an orphan anchor check needs a second code
        // section the script names.
        .sec(
            ".text32",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 4],
        )
        // 2: .data -- 32 at 0, 16 at 4, 8 at 6.
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("target", STB_GLOBAL, STT_NOTYPE, 1, 0, 0)
        // The 8- and 16-bit fields hold no image address, so they
        // reference absolute symbols the way the boot code does.
        .sym("small", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x1234, 0)
        .sym("tiny", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x40, 0)
        // Symtab: null(0), sections(1..=3), _start(4), target(5),
        // small(6), tiny(7).
        .reloc(0, 1, 5, rt::R_386_PC32, -4)
        .reloc(0, 8, 5, rt::R_386_PC16, -2)
        .reloc(0, 12, 4, rt::R_386_PC8, -1)
        .reloc(2, 0, 5, rt::R_386_32, 0x10)
        .reloc(2, 4, 6, rt::R_386_16, 0)
        .reloc(2, 6, 7, rt::R_386_8, 0)
        .build_class(EM_386, ElfClass::Elf32, false)
}

#[test]
fn i386_rel_addends_come_from_the_relocated_field() {
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let text = elf32_section(&res.image, ".text");
    let t32 = elf32_section(&res.image, ".text32");
    let (text_addr, t32_addr) = (text.2, t32.2);
    let tb = elf32_body(&res.image, ".text");
    let db = elf32_body(&res.image, ".data");
    // S + A - P at each width, A read back out of the field.
    let pc32 = i32::from_le_bytes(tb[1..5].try_into().unwrap()) as i64;
    assert_eq!(pc32, t32_addr as i64 - 4 - (text_addr as i64 + 1));
    let pc16 = i16::from_le_bytes(tb[8..10].try_into().unwrap()) as i64;
    assert_eq!(pc16, t32_addr as i64 - 2 - (text_addr as i64 + 8));
    let pc8 = tb[12] as i8 as i64;
    assert_eq!(pc8, text_addr as i64 - 1 - (text_addr as i64 + 12));
    // S + A at each width.
    assert_eq!(
        u32::from_le_bytes(db[0..4].try_into().unwrap()) as u64,
        t32_addr + 0x10
    );
    assert_eq!(u16::from_le_bytes(db[4..6].try_into().unwrap()), 0x1234);
    assert_eq!(db[6], 0x40);
}

#[test]
fn i386_image_is_elf32() {
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let img = &res.image;
    assert_eq!(img[4], 1, "EI_CLASS is ELFCLASS32");
    assert_eq!(u16::from_le_bytes(img[18..20].try_into().unwrap()), EM_386);
    assert_eq!(
        u32::from_le_bytes(img[28..32].try_into().unwrap()),
        52,
        "e_phoff follows the ELF32 header"
    );
    assert_eq!(u16::from_le_bytes(img[40..42].try_into().unwrap()), 52); // e_ehsize
    assert_eq!(u16::from_le_bytes(img[42..44].try_into().unwrap()), 32); // e_phentsize
    assert_eq!(u16::from_le_bytes(img[46..48].try_into().unwrap()), 40); // e_shentsize
    let symtab = elf32_section(img, ".symtab");
    assert_eq!(symtab.6, 16, "Elf32_Sym is 16 bytes");
    // `_start` is found through the ELF32 symbol layout.
    let (_, _, _, off, size, _, ent) = symtab;
    let strtab = elf32_section(img, ".strtab");
    let names = &img[strtab.3 as usize..(strtab.3 + strtab.4) as usize];
    let text_addr = elf32_section(img, ".text").2;
    let start = (0..size / ent).find_map(|k| {
        let at = (off + k * ent) as usize;
        let n = u32::from_le_bytes(img[at..at + 4].try_into().unwrap());
        (strz(names, n as usize) == "_start")
            .then(|| u32::from_le_bytes(img[at + 4..at + 8].try_into().unwrap()) as u64)
    });
    assert_eq!(start, Some(text_addr));
    // The entry point is `_start`, written at address width.
    assert_eq!(
        u32::from_le_bytes(img[24..28].try_into().unwrap()) as u64,
        text_addr
    );
}

#[test]
fn i386_emit_relocs_writes_rel_tables() {
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let objs = alloc::vec![parse_lds_object("a.o", i386_object()).expect("parses")];
    let opts = LdsOptions {
        emit_relocs: true,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let rel = elf32_section(&res.image, ".rel.data");
    assert_eq!(rel.1, SHT_REL);
    assert_eq!(rel.6, 8, "Elf32_Rel is 8 bytes");
    assert_eq!(rel.4, 3 * 8, "three relocations in .data");
    assert!(
        elf32_sections(&res.image)
            .iter()
            .all(|s| !s.0.starts_with(".rela")),
        "a REL target emits no RELA table"
    );
    // r_info keeps the type in the low byte on ELF32.
    let body = &res.image[rel.3 as usize..(rel.3 + rel.4) as usize];
    let info = u32::from_le_bytes(body[4..8].try_into().unwrap());
    assert_eq!(info & 0xff, rt::R_386_32);
}

/// An i386 shared object's dynamic relocations go in `.rel.dyn`, typed
/// `SHT_REL` as GNU ld types it, so section-based tools read them.
#[test]
fn i386_shared_object_types_its_dynamic_relocations_rel() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .rel.dyn : { *(.rel.dyn) }
  .text : { *(.text) }
  .dynamic : { *(.dynamic) }
  .data : { *(.data) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 4])
        .sym("own", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        // Symtab: null(0), sections(1, 2), own(3).
        .reloc(1, 0, 3, rt::R_386_32, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    let objs = alloc::vec![parse_lds_object("own.o", a).expect("parses")];
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        shared: true,
        ..Default::default()
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let rel = elf32_section(&res.image, ".rel.dyn");
    assert_eq!((rel.1, rel.6), (SHT_REL, 8), "{rel:?}");
    assert!(rel.4 >= 8, "{rel:?}");
}

#[test]
fn i386_narrow_relocation_overflow_is_reported() {
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 4],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        // Symtab: null(0), section(1), _start(2).
        .reloc(0, 0, 2, rt::R_386_8, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let e = link_with_script(&script, objs, &LdsOptions::default())
        .expect_err("0x1000 does not fit an 8-bit field");
    assert!(format!("{e}").contains("R_386_8"), "{e}");
}

/// AArch64 keeps the GOT header on `.got`: its first slot holds the
/// `.dynamic` address and GOT entries follow it, while `.got.plt`
/// stays the dynamic linker's.
#[test]
fn aarch64_got_keeps_its_header_and_entries_follow_it() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = 0x10000;
  .text : { *(.text) }
  .data : { *(.data) }
  .dynamic : { *(.dynamic) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .rela.dyn : { *(.rela .rela*) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[0u8; 8],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        // Symtab: null(0), sections(1..=2), _start(3), datum(4).
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("datum", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .reloc(0, 0, 4, rt::R_AARCH64_ADR_GOT_PAGE, 0)
        .reloc(0, 4, 4, rt::R_AARCH64_LD64_GOT_LO12_NC, 0)
        .build(EM_AARCH64);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        max_page_size: 0x10000,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &opts,
    )
    .expect("links");
    let secs = readelf_sections(&res.image);
    let sec = |name: &str| {
        secs.iter()
            .find(|s| s.0 == name)
            .unwrap_or_else(|| panic!("no `{name}' in the image"))
    };
    let (got_addr, got_size) = (sec(".got").2, sec(".got").3);
    assert_eq!(got_size, 16, "the reserved header plus one entry");
    let off = section_file_off(&res.image, got_addr);
    assert_eq!(
        u64::from_le_bytes(res.image[off..off + 8].try_into().unwrap()),
        sec(".dynamic").2,
        "`_GLOBAL_OFFSET_TABLE_[0]` holds the `.dynamic` address"
    );
    let rela = section_file_off(&res.image, sec(".rela.dyn").2);
    assert_eq!(
        u64::from_le_bytes(res.image[rela..rela + 8].try_into().unwrap()),
        got_addr + 8,
        "the GOT entry sits past the header"
    );
    let plt = section_file_off(&res.image, sec(".got.plt").2);
    assert!(
        res.image[plt..plt + sec(".got.plt").3 as usize]
            .iter()
            .all(|&b| b == 0),
        "`.got.plt` carries no header here"
    );
}

/// The x86 psABIs define `_GLOBAL_OFFSET_TABLE_` on `.got.plt`,
/// whose first slot holds the `.dynamic` address, and every
/// GOT-base relative relocation is computed against that same
/// address.
#[test]
fn i386_got_base_is_got_plt_holding_the_dynamic_address() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.hash : { *(.gnu.hash) }
  .dynamic : { *(.dynamic) }
  .text : { *(.text) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .data : { *(.data) }
}
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0u8; 4])
        // Symtab: null(0), .text(1), .data(2), then these two.
        .sym(
            "_GLOBAL_OFFSET_TABLE_",
            STB_GLOBAL,
            STT_NOTYPE,
            usize::MAX,
            0,
            0,
        )
        .sym("datum", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .reloc(0, 0, 3, rt::R_386_GOTPC, 0)
        .reloc(0, 4, 4, rt::R_386_GOTOFF, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        ..Default::default()
    };
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &opts,
    )
    .expect("links");
    let addr = |name: &str| elf32_section(&res.image, name).2 as i64;
    let text = elf32_body(&res.image, ".text");
    let field = |at: usize| i32::from_le_bytes(text[at..at + 4].try_into().unwrap()) as i64;
    assert_eq!(
        field(0) + addr(".text"),
        addr(".got.plt"),
        "R_386_GOTPC yields the `.got.plt` address"
    );
    assert_eq!(
        field(4),
        addr(".data") - addr(".got.plt"),
        "R_386_GOTOFF is relative to the same base"
    );
    let got_plt = elf32_body(&res.image, ".got.plt");
    assert_eq!(
        u32::from_le_bytes(got_plt[..4].try_into().unwrap()) as i64,
        addr(".dynamic"),
        "`_GLOBAL_OFFSET_TABLE_[0]` holds the `.dynamic` address"
    );
    assert!(
        !elf32_sections(&res.image)
            .iter()
            .any(|s| s.0 == ".got" && s.4 != 0),
        "`.got` reserves no header where `.got.plt` carries it"
    );
}

/// A script naming every section the GOT-base tests place.
const GOT_SYM_SCRIPT: &str = r#"
SECTIONS {
  . = 0x400000 + SIZEOF_HEADERS;
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.hash : { *(.gnu.hash) }
  .dynamic : { *(.dynamic) }
  .rela.dyn : { *(.rela.dyn) }
  .text : { *(.text) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .data : { *(.data) }
}
"#;

/// An object naming the GOT base from `.text` and from `.data`.
/// Symtab: null(0), .text(1), .data(2), then the reference.
fn got_sym_object(machine: u16, pcrel: u32, wide: u32) -> Vec<u8> {
    TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0u8; 8])
        .sym(GOT_SYMBOL, STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 0, 3, pcrel, -4)
        .reloc(1, 0, 3, wide, 0)
        .build(machine)
}

/// `(value, st_info, st_shndx)` of the GOT base symbol, or `None`
/// where the link emitted no entry for it.
fn got_sym_row(image: &[u8]) -> Option<(u64, u8, u16)> {
    let vals = image_symbols(image);
    let rows = image_sym_rows(image);
    let v = vals.iter().find(|(n, _, _)| n == GOT_SYMBOL)?;
    let r = rows.iter().find(|(n, _, _)| n == GOT_SYMBOL)?;
    Some((v.1, r.1, r.2))
}

fn link_got_sym(machine: u16, emit: LdsEmit, pcrel: u32, wide: u32) -> LdsResult {
    let script = parse_linker_script(GOT_SYM_SCRIPT).expect("script parses");
    let obj = got_sym_object(machine, pcrel, wide);
    let opts = LdsOptions {
        emit,
        ..Default::default()
    };
    link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", obj).expect("parses")],
        &opts,
    )
    .expect("links")
}

/// bfd defines `_GLOBAL_OFFSET_TABLE_` as a sizeless local OBJECT
/// on `.got.plt` for the x86 targets, in a static link as in a
/// dynamic one, and builds the section on demand where an input
/// names the symbol. Both GOTPC forms yield that same base
/// relative to their own site. Measured against GNU ld 2.46.1 on
/// linux-x86_64.
#[test]
fn x86_64_got_symbol_and_gotpc_forms_follow_ld() {
    for emit in [LdsEmit::Exec, LdsEmit::Dyn] {
        let res = link_got_sym(EM_X86_64, emit, rt::R_X86_64_GOTPC32, rt::R_X86_64_GOTPC64);
        let secs = readelf_sections(&res.image);
        let addr = |n: &str| {
            secs.iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{n} in output"))
                .2
        };
        let got = addr(".got.plt");
        let (value, info, shndx) = got_sym_row(&res.image).expect("GOT base symbol");
        assert_eq!(value, got, "{emit:?}: value is the `.got.plt` address");
        assert_eq!(
            info,
            (STB_LOCAL << 4) | STT_OBJECT,
            "{emit:?}: local object"
        );
        assert_eq!(
            shndx,
            section_index(&res.image, ".got.plt") as u16,
            "{emit:?}: the entry names `.got.plt`"
        );
        let text = section_file_off(&res.image, addr(".text"));
        let field = i32::from_le_bytes(res.image[text..text + 4].try_into().unwrap()) as i64;
        assert_eq!(
            field + 4 + addr(".text") as i64,
            got as i64,
            "{emit:?}: R_X86_64_GOTPC32"
        );
        let data = section_file_off(&res.image, addr(".data"));
        let wide = i64::from_le_bytes(res.image[data..data + 8].try_into().unwrap());
        assert_eq!(
            wide + addr(".data") as i64,
            got as i64,
            "{emit:?}: R_X86_64_GOTPC64"
        );
    }
}

/// aarch64 keeps the GOT base on `.got`, one reserved slot ahead of
/// the first entry. Measured against GNU ld 2.46.1 on
/// linux-aarch64: the entry names `.got` for non-PIC output and is
/// absolute for a PIE or a shared object.
#[test]
fn aarch64_got_symbol_follows_ld() {
    for (emit, absolute) in [(LdsEmit::Exec, false), (LdsEmit::Dyn, true)] {
        let res = link_got_sym(
            EM_AARCH64,
            emit,
            rt::R_AARCH64_ADR_PREL_PG_HI21,
            rt::R_AARCH64_ABS64,
        );
        let secs = readelf_sections(&res.image);
        let got = secs
            .iter()
            .find(|s| s.0 == ".got")
            .unwrap_or_else(|| panic!("{emit:?}: `.got` in output"));
        let (value, info, shndx) = got_sym_row(&res.image).expect("GOT base symbol");
        assert_eq!(value, got.2, "{emit:?}: value is the `.got` address");
        assert_eq!(got.3, 8, "{emit:?}: one reserved slot");
        assert_eq!(
            info,
            (STB_LOCAL << 4) | STT_OBJECT,
            "{emit:?}: local object"
        );
        let want = if absolute {
            SHN_ABS
        } else {
            section_index(&res.image, ".got") as u16
        };
        assert_eq!(shndx, want, "{emit:?}: section the entry names");
    }
}

/// A static aarch64 image gives each symbol a GOT reference names a `.got`
/// slot holding its address, after the reserved header, and keeps the
/// `adrp` + `ldr` reading it, as GNU ld 2.46.1 links it.
#[test]
fn a_static_aarch64_image_fills_a_got_slot_per_referenced_symbol() {
    let script = parse_linker_script(GOT_SYM_SCRIPT).expect("script parses");
    // adrp x0, :got:target; ldr x0, [x0, :got_lo12:target]; ret
    let code: Vec<u8> = [0x9000_0000u32, 0xf940_0000, 0xd65f_03c0]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &code)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 12)
        .sym("target", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        // Symtab: null(0), sections(1, 2), _start(3), target(4).
        .reloc(0, 0, 4, rt::R_AARCH64_ADR_GOT_PAGE, 0)
        .reloc(0, 4, 4, rt::R_AARCH64_LD64_GOT_LO12_NC, 0)
        .build(EM_AARCH64);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let (got, bytes) = image_section(&res.image, ".got");
    let (data, _) = image_section(&res.image, ".data");
    assert_eq!(bytes.len(), 16, "the header and one slot");
    assert_eq!(
        u64::from_le_bytes(bytes[8..16].try_into().unwrap()),
        data,
        "the slot holds `target`"
    );
    let (text, insns) = image_section(&res.image, ".text");
    let word = |k: usize| u32::from_le_bytes(insns[4 * k..4 * k + 4].try_into().unwrap());
    let imm = ((word(0) >> 29) & 3) | ((word(0) >> 5) & 0x7_ffff) << 2;
    let slot = got + 8;
    assert_eq!(
        (text & !0xfff) + ((imm as u64) << 12),
        slot & !0xfff,
        "adrp reaches the slot's page"
    );
    assert_eq!(word(1) & 0xffc0_0000, 0xf940_0000, "the ldr stays a load");
    assert_eq!(
        ((word(1) >> 10) & 0xfff) as u64 * 8,
        slot & 0xfff,
        "ldr reads the slot"
    );
}

/// bfd emits no `_GLOBAL_OFFSET_TABLE_` where the link built no
/// GOT, so a static link that never names it carries neither the
/// symbol nor the sections.
#[test]
fn no_got_symbol_where_the_link_builds_no_got() {
    let script = parse_linker_script(GOT_SYM_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .build(EM_X86_64);
    let res = link_with_script(
        &script,
        alloc::vec![parse_lds_object("a.o", a).expect("parses")],
        &LdsOptions::default(),
    )
    .expect("links");
    assert!(got_sym_row(&res.image).is_none(), "no GOT, no entry");
    assert!(
        !readelf_sections(&res.image)
            .iter()
            .any(|s| s.0.starts_with(".got")),
        "no GOT sections"
    );
}

#[test]
fn i386_shared_object_carries_elf32_dynamic_metadata() {
    let script = parse_linker_script(
        r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.version : { *(.gnu.version) }
  .gnu.version_d : { *(.gnu.version_d) }
  .dynamic : { *(.dynamic) }
  .rodata : { *(.rodata) *(.got.plt) *(.got) }
  .text : { *(.text) }
}
VERSION { LINUX_2.6 { global: exported; local: *; }; }
"#,
    )
    .expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sym("exported", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .build_class(EM_386, ElfClass::Elf32, false);
    let opts = LdsOptions {
        emit: LdsEmit::Dyn,
        soname: Some("linux-gate.so.1".to_string()),
        hash_style: HashStyle::Both,
        ..Default::default()
    };
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &opts).expect("links");
    assert_eq!(elf32_section(&res.image, ".dynsym").6, 16);
    assert_eq!(elf32_section(&res.image, ".dynamic").6, 8);
    // bfd gives `.gnu.hash` an entsize on ELF32 only.
    assert_eq!(elf32_section(&res.image, ".gnu.hash").6, 4);
    // `.gnu.hash` Bloom words are address-width, so ELF32 needs
    // twice as many for the same mask and always shifts by 5.
    let gh = elf32_body(&res.image, ".gnu.hash");
    let word = |at: usize| u32::from_le_bytes(gh[at..at + 4].try_into().unwrap()) as usize;
    let (nbuckets, maskwords, shift2) = (word(0), word(8), word(12) as u32);
    let nhashed = elf32_section(&res.image, ".dynsym").4 as usize / 16 - 1;
    assert_eq!(
        (maskwords, shift2),
        dynamic::bloom_params(nhashed, ElfClass::Elf32)
    );
    assert_eq!(
        gh.len(),
        16 + maskwords * 4 + nbuckets * 4 + nhashed * 4,
        "the Bloom words are 4 bytes wide"
    );
    // DT_SYMENT names the ELF32 entry size; every tag is 8 bytes.
    let dynamic = elf32_body(&res.image, ".dynamic");
    assert!(dynamic.len().is_multiple_of(8));
    let mut syment = None;
    for e in dynamic.as_chunks::<8>().0.iter() {
        let (t, v) = (
            u32::from_le_bytes(e[0..4].try_into().unwrap()) as u64,
            u32::from_le_bytes(e[4..8].try_into().unwrap()) as u64,
        );
        if t == dynamic::DT_SYMENT {
            syment = Some(v);
        }
    }
    assert_eq!(syment, Some(16));
}

#[test]
fn code_padding_is_the_architecture_nop() {
    // `.text` claims two inputs; the second's alignment leaves a
    // gap the script gave no fill for.
    let script = parse_linker_script("SECTIONS { . = 0x1000; .text : { *(.text) *(.text.hot) } }")
        .expect("script parses");
    let build = |machine: u16, class: ElfClass, first: usize| {
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &alloc::vec![0xccu8; first],
            )
            .sec(
                ".text.hot",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                16,
                &[0xccu8; 4],
            )
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, first as u64)
            .build_class(machine, class, machine != EM_386)
    };
    let objs = alloc::vec![parse_lds_object("a.o", build(EM_386, ElfClass::Elf32, 5)).expect("p")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    // 11 bytes of padding: five `66 90` pairs and a trailing `90`.
    let body = elf32_body(&res.image, ".text");
    assert_eq!(
        &body[5..16],
        &[
            0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x66, 0x90, 0x90
        ]
    );
    // aarch64 pads only whole instructions, so the gap is a
    // multiple of four here.
    let objs =
        alloc::vec![parse_lds_object("a.o", build(EM_AARCH64, ElfClass::Elf64, 8)).expect("p")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let shoff = u64::from_le_bytes(res.image[40..48].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(res.image[60..62].try_into().unwrap()) as usize;
    let shstrndx = u16::from_le_bytes(res.image[62..64].try_into().unwrap()) as usize;
    let sh = |i: usize| -> Elf64Shdr { read_struct(&res.image, shoff + i * 64).unwrap() };
    let str_sh = sh(shstrndx);
    let names = &res.image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
    let text = (1..shnum)
        .map(sh)
        .find(|h| strz(names, h.sh_name as usize) == ".text")
        .expect("has .text");
    let body = &res.image[text.sh_offset as usize..(text.sh_offset + text.sh_size) as usize];
    assert_eq!(
        &body[8..16],
        &[0x1f, 0x20, 0x03, 0xd5, 0x1f, 0x20, 0x03, 0xd5]
    );
}

#[test]
fn orphan_anchors_on_the_canonically_named_section() {
    // bfd puts a code orphan after the output section named
    // `.text`, not after the last executable one.
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(
            ".text32",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 16],
        )
        .sec(
            ".inittext",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            1,
            &[0u8; 4],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .build_class(EM_386, ElfClass::Elf32, false);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &LdsOptions::default()).expect("links");
    let order: Vec<String> = elf32_sections(&res.image)
        .into_iter()
        .filter(|s| s.5 & SHF_EXECINSTR != 0)
        .map(|s| s.0)
        .collect();
    assert_eq!(
        order,
        alloc::vec![
            ".text".to_string(),
            ".inittext".to_string(),
            ".text32".to_string()
        ]
    );
}

#[test]
fn elf32_object_in_an_x86_64_link_is_rejected() {
    let script = parse_linker_script(I386_SCRIPT).expect("script parses");
    let a = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0u8; 4],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .build_class(EM_X86_64, ElfClass::Elf32, true);
    let objs = alloc::vec![parse_lds_object("a.o", a).expect("parses")];
    let e = link_with_script(&script, objs, &LdsOptions::default())
        .expect_err("an ELF32 x86-64 object has no emulation here");
    assert!(format!("{e}").contains("ELF class"), "{e}");
}

// ------------------------------------------- COMDAT / linkonce

const GROUP_SCRIPT: &str = r#"
SECTIONS {
  . = 0x1000;
  .text : { *(.text .text.*) *(.gnu.linkonce.t.*) }
  .rodata : { *(.rodata .rodata.*) }
  .data : { *(.data .data.*) }
  .eh_frame : { *(.eh_frame) }
}
"#;

fn link_group(objs: Vec<Vec<u8>>, opts: &LdsOptions) -> Result<LdsResult, C5Error> {
    let script = parse_linker_script(GROUP_SCRIPT).expect("script parses");
    let inputs: Vec<LdsObject> = objs
        .into_iter()
        .enumerate()
        .map(|(i, b)| {
            parse_lds_object(&format!("{}.o", (b'a' + i as u8) as char), b).expect("parses")
        })
        .collect();
    link_with_script(&script, inputs, opts)
}

fn body_has(image: &[u8], section: &str, pat: &[u8]) -> bool {
    image_section(image, section)
        .1
        .windows(pat.len())
        .any(|w| w == pat)
}

/// A COMDAT group is keyed on its signature symbol's name alone.
/// The later group loses every member whatever the members are
/// named and however large they are, and nothing is diagnosed.
#[test]
fn a_comdat_group_is_kept_once_per_signature() {
    let a = TestObj::new()
        .sec(
            ".text.aaa",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xa1; 4],
        )
        .sec(".rodata.aaa", SHT_PROGBITS, SHF_ALLOC, 4, &[0xa2; 4])
        .sym("sig", STB_WEAK, STT_FUNC, 0, 0, 4)
        .sym("aonly", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .group(comdat::GRP_COMDAT, 0, &[0, 1])
        .build(EM_X86_64);
    let b = TestObj::new()
        .sec(
            ".text.bbb",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xb1; 8],
        )
        .sec(".rodata.bbb", SHT_PROGBITS, SHF_ALLOC, 4, &[0xb2; 8])
        .sec(
            ".data.bbb",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_WRITE,
            4,
            &[0xb5; 4],
        )
        .sym("sig", STB_WEAK, STT_FUNC, 0, 0, 8)
        .sym("bonly", STB_GLOBAL, STT_OBJECT, 2, 0, 4)
        .group(comdat::GRP_COMDAT, 0, &[0, 1, 2])
        .build(EM_X86_64);
    let res = link_group(alloc::vec![a, b], &LdsOptions::default()).expect("links");
    assert!(
        body_has(&res.image, ".text", &[0xa1; 4]),
        "the first copy stays"
    );
    assert!(
        !body_has(&res.image, ".text", &[0xb1; 8]),
        "the later copy is gone"
    );
    assert!(
        !body_has(&res.image, ".rodata", &[0xb2; 8]),
        "and so is every member"
    );
    let secs = readelf_sections(&res.image);
    assert!(
        !secs.iter().any(|s| s.0 == ".data"),
        "a member the kept group has no counterpart for is dropped too"
    );
    let names: Vec<String> = image_symbols(&res.image)
        .into_iter()
        .map(|(n, _, _)| n)
        .collect();
    assert!(names.iter().any(|n| n == "aonly"), "{names:?}");
    assert!(
        !names.iter().any(|n| n == "bonly"),
        "a dropped member defines nothing"
    );
}

/// The dedup runs on `GRP_COMDAT`, not on the presence of a group:
/// a plain group keeps both copies, and duplicate definitions in
/// them collide as they would outside any group.
#[test]
fn a_group_without_grp_comdat_is_not_deduplicated() {
    let unit = |flags: u32, fill: u8| {
        TestObj::new()
            .sec(
                ".text.g",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[fill; 4],
            )
            .sym("gsig", STB_LOCAL, STT_NOTYPE, 0, 0, 0)
            .sym("dup", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            .group(flags, 0, &[0])
            .build(EM_X86_64)
    };
    let e = link_group(
        alloc::vec![unit(0, 0xa1), unit(0, 0xb1)],
        &LdsOptions::default(),
    )
    .expect_err("a plain group deduplicates nothing");
    assert!(
        format!("{e}").contains("multiple definition of `dup`"),
        "{e}"
    );
    let res = link_group(
        alloc::vec![
            unit(comdat::GRP_COMDAT, 0xa1),
            unit(comdat::GRP_COMDAT, 0xb1)
        ],
        &LdsOptions::default(),
    )
    .expect("the same objects with GRP_COMDAT set link");
    assert!(!body_has(&res.image, ".text", &[0xb1; 4]));
}

/// A reference by name reaches the surviving definition; a local or
/// section-relative reference into a dropped member has nowhere to
/// go and is reported, because the surviving group's contents need
/// bear no relation to the dropped one's.
#[test]
fn a_reference_into_a_dropped_group_resolves_by_name_or_is_reported() {
    let a = TestObj::new()
        .sec(
            ".text.f",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xa1; 8],
        )
        .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
        .group(comdat::GRP_COMDAT, 0, &[0])
        .build(EM_X86_64);
    // Symtab: null, section symbols 1..=3, then f(4), bloc(5).
    let b = |sym: u32, refsec: &str, flags: u64| {
        TestObj::new()
            .sec(
                ".text.f",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xb1; 8],
            )
            .sec(refsec, SHT_PROGBITS, flags, 8, &[0u8; 8])
            .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
            .sym("bloc", STB_LOCAL, STT_NOTYPE, 0, 4, 0)
            .group(comdat::GRP_COMDAT, 0, &[0])
            .reloc(1, 0, sym, rt::R_X86_64_64, 0)
            .build(EM_X86_64)
    };
    let res = link_group(
        alloc::vec![a.clone(), b(4, ".data.b", SHF_ALLOC | SHF_WRITE)],
        &LdsOptions::default(),
    )
    .expect("a named reference binds to the kept copy");
    let f = find_sym(&image_symbols(&res.image), "f");
    assert_eq!(
        u64::from_le_bytes(
            image_section(&res.image, ".data").1[..8]
                .try_into()
                .unwrap()
        ),
        f,
    );
    for sym in [5u32, 1u32] {
        let e = link_group(
            alloc::vec![a.clone(), b(sym, ".data.b", SHF_ALLOC | SHF_WRITE)],
            &LdsOptions::default(),
        )
        .expect_err("a local or section reference into a dropped member");
        assert!(
            format!("{e}").contains("discarded section `.text.f'"),
            "{e}"
        );
    }
    // A section describing the image rather than taking part in it
    // resolves the same reference to nothing instead.
    let res = link_group(
        alloc::vec![a, b(5, ".debug_info", 0)],
        &LdsOptions::default(),
    )
    .expect("a debug reference is tolerated");
    assert_eq!(
        image_section(&res.image, ".debug_info").1,
        alloc::vec![0u8; 8]
    );
}

/// `.gnu.linkonce.*` is the older form of the same rule, keyed on
/// the section's own name. The key spaces do not meet: a linkonce
/// section and a COMDAT group both defining one symbol collide.
#[test]
fn gnu_linkonce_sections_deduplicate_by_section_name() {
    let linkonce = |fill: u8, only: &str| {
        TestObj::new()
            .sec(
                ".gnu.linkonce.t.foo",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[fill; 4],
            )
            .sym("foo", STB_GLOBAL, STT_FUNC, 0, 0, 4)
            .sym(only, STB_GLOBAL, STT_FUNC, 0, 2, 0)
            .build(EM_X86_64)
    };
    let res = link_group(
        alloc::vec![linkonce(0xa1, "aonly_lo"), linkonce(0xb1, "bonly_lo")],
        &LdsOptions::default(),
    )
    .expect("links");
    assert!(body_has(&res.image, ".text", &[0xa1; 4]));
    assert!(!body_has(&res.image, ".text", &[0xb1; 4]));
    let names: Vec<String> = image_symbols(&res.image)
        .into_iter()
        .map(|(n, _, _)| n)
        .collect();
    assert!(names.iter().any(|n| n == "aonly_lo") && !names.iter().any(|n| n == "bonly_lo"));
    let grouped = TestObj::new()
        .sec(
            ".text.foo",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc1; 4],
        )
        .sym("foo", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .group(comdat::GRP_COMDAT, 0, &[0])
        .build(EM_X86_64);
    let e = link_group(
        alloc::vec![linkonce(0xa1, "aonly_lo"), grouped],
        &LdsOptions::default(),
    )
    .expect_err("the two mechanisms do not deduplicate against each other");
    assert!(
        format!("{e}").contains("multiple definition of `foo`"),
        "{e}"
    );
}

/// Group dedup runs before garbage collection, so a dropped member
/// is neither a root nor a path to one.
#[test]
fn a_dropped_group_member_is_no_garbage_collection_root() {
    let root = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0u8; 8],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("f", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 0, 3, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    // `.text.only` exists only in the object whose group member
    // names it, so the two members define no symbol in common.
    // Symtab there: null, sections 1..=3, f(4), only(5).
    let member = |fill: u8, refs_only: bool| {
        let mut o = TestObj::new().sec(
            ".text.f",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            8,
            &[fill; 8],
        );
        if refs_only {
            o = o.sec(
                ".text.only",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[0xbb; 8],
            );
        }
        o = o.sym("f", STB_WEAK, STT_FUNC, 0, 0, 8);
        if refs_only {
            o = o.sym("only", STB_GLOBAL, STT_FUNC, 1, 0, 8);
        }
        o = o.group(comdat::GRP_COMDAT, 0, &[0]);
        if refs_only {
            o = o.reloc(0, 0, 5, rt::R_X86_64_64, 0);
        }
        o.build(EM_X86_64)
    };
    let opts = |gc: bool| LdsOptions {
        gc_sections: gc,
        entry_override: Some("_start".to_string()),
        ..Default::default()
    };
    let objs = || alloc::vec![root.clone(), member(0xa1, false), member(0xb1, true)];
    let kept = link_group(objs(), &opts(false)).expect("links");
    assert!(
        body_has(&kept.image, ".text", &[0xbb; 8]),
        "nothing collects it"
    );
    let collected = link_group(objs(), &opts(true)).expect("links");
    assert!(
        !body_has(&collected.image, ".text", &[0xbb; 8]),
        "the only reference lived in a dropped member"
    );
    let live = link_group(alloc::vec![root, member(0xa1, true)], &opts(true)).expect("links");
    assert!(
        body_has(&live.image, ".text", &[0xbb; 8]),
        "the same reference from the winning group keeps it"
    );
}

/// An FDE describing code that left the link describes nothing, so
/// the entry goes with it rather than being relocated.
#[test]
fn an_fde_for_a_dropped_group_member_is_dropped() {
    let unit = |fill: u8| {
        let mut eh = eh_cie_zr();
        eh.extend_from_slice(&eh_fde(0x1c));
        TestObj::new()
            .sec(
                ".text.f",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                8,
                &[fill; 8],
            )
            .sec(".eh_frame", SHT_PROGBITS, SHF_ALLOC, 8, &eh)
            .sym("f", STB_WEAK, STT_FUNC, 0, 0, 8)
            .group(comdat::GRP_COMDAT, 0, &[0])
            .reloc(1, 0x20, 1, rt::R_X86_64_PC32, 0)
            .build(EM_X86_64)
    };
    let res =
        link_group(alloc::vec![unit(0xa1), unit(0xb1)], &LdsOptions::default()).expect("links");
    let (addr, body) = image_section(&res.image, ".eh_frame");
    assert_eq!(body.len(), 24 + 24, "one CIE and the surviving copy's FDE");
    let fdes = eh_frame::scan(&body, addr).expect("scans");
    assert_eq!(
        fdes.iter().map(|e| e.pc).collect::<Vec<_>>(),
        alloc::vec![find_sym(&image_symbols(&res.image), "f")],
    );
}

/// The i386 shape the gcc PIC thunk arrives in: an ELF32 `SHT_REL`
/// object whose group holds one section signed by the thunk.
#[test]
fn an_elf32_group_parses_and_deduplicates() {
    let thunk = "__x86.get_pc_thunk.ax";
    let unit = |fill: u8| {
        TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[fill; 4],
            )
            .sec(
                ".text.__x86.get_pc_thunk.ax",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                1,
                &[0x8b, 0x04, 0x24, 0xc3],
            )
            .sym(thunk, STB_GLOBAL, STT_FUNC, 1, 0, 4)
            .vis(2)
            .group(comdat::GRP_COMDAT, 0, &[1])
            .build_class(EM_386, ElfClass::Elf32, false)
    };
    let parsed = parse_lds_object("a.o", unit(0xa1)).expect("parses");
    assert_eq!(parsed.groups.len(), 1);
    assert_eq!(parsed.groups[0].flags, comdat::GRP_COMDAT);
    assert_eq!(parsed.groups[0].signature, thunk);
    assert_eq!(
        parsed.sections[parsed.groups[0].members[0]].name,
        ".text.__x86.get_pc_thunk.ax"
    );
    let opts = LdsOptions {
        entry_override: Some(thunk.to_string()),
        ..Default::default()
    };
    let res = link_group(alloc::vec![unit(0xa1), unit(0xb1)], &opts).expect("links");
    let text = elf32_body(&res.image, ".text");
    assert_eq!(
        text.windows(4)
            .filter(|w| *w == [0x8b, 0x04, 0x24, 0xc3])
            .count(),
        1,
        "one thunk body: {text:02x?}"
    );
}

// ------------------------------------- shared-object symbol binding

/// A `-shared` layout naming every dynamic table, the PLT and the GOT,
/// with symbols the script defines, plain, provided and hidden.
const SHARED_SCRIPT: &str = r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .rela.dyn : { *(.rela.*) }
  .plt : { *(.plt) *(.plt.*) }
  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  . = ALIGN(0x10000);
  .dynamic : { *(.dynamic) }
  .got : { *(.got) *(.igot) }
  .got.plt : { *(.got.plt) *(.igot.plt) }
  .data : { *(.data*) }
  mysec : { *(mysec) }
  .bss : { *(.bss*) }
  script_sym = .;
  hid_ref_sym = .;
  prot_ref_sym = .;
  PROVIDE(prov_sym = .);
  HIDDEN(hid_sym = .);
}
"#;

fn shared_opts(machine: u16) -> LdsOptions {
    LdsOptions {
        emit: LdsEmit::Dyn,
        shared: true,
        max_page_size: if machine == EM_AARCH64 {
            0x10000
        } else {
            0x1000
        },
        ..Default::default()
    }
}

/// `.dynsym` as `(name, st_info, st_other)`, in table order.
fn dynsym_entries(image: &[u8]) -> Vec<(String, u8, u8)> {
    let (_, syms) = image_section(image, ".dynsym");
    let (_, strtab) = image_section(image, ".dynstr");
    syms.as_chunks::<24>()
        .0
        .iter()
        .map(|e| {
            let name = u32::from_le_bytes(e[..4].try_into().unwrap()) as usize;
            (strz(&strtab, name), e[4], e[5])
        })
        .collect()
}

/// System V gABI, symbol visibility: a global takes the most
/// constraining visibility among its definition and its references.
/// Measured against GNU ld 2.46.1 `-shared -T`: a definition one
/// reference declares hidden stays out of `.dynsym`, one a reference
/// or its definition declares protected is exported as protected, and
/// so are the `__start_` / `__stop_` bounds; a script symbol follows
/// its references the same way.
#[test]
fn a_dynamic_symbol_takes_the_most_constraining_visibility() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let defs = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[1; 8])
        .sec("mysec", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[1; 8])
        .sym("func", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("pfunc", STB_GLOBAL, STT_FUNC, 0, 4, 1)
        .vis(STV_PROTECTED)
        .sym("u", STB_GLOBAL, STT_FUNC, 0, 8, 1)
        .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .build(EM_X86_64);
    let names = [
        ("data", STV_HIDDEN),
        ("func", STV_PROTECTED),
        ("__start_mysec", STV_DEFAULT),
        ("hid_ref_sym", STV_HIDDEN),
        ("prot_ref_sym", STV_PROTECTED),
        ("script_sym", STV_DEFAULT),
    ];
    let mut refs = TestObj::new().sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 48]);
    for (k, (name, vis)) in names.iter().enumerate() {
        // Symtab: null(0), the section(1), then the names in order.
        refs = refs
            .sym(name, STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .vis(*vis)
            .reloc(0, 8 * k as u64, 2 + k as u32, rt::R_X86_64_64, 0);
    }
    let objs = alloc::vec![
        parse_lds_object("defs.o", defs).expect("parses"),
        parse_lds_object("refs.o", refs.build(EM_X86_64)).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &shared_opts(EM_X86_64)).expect("links");
    let dynsym = dynsym_entries(&res.image);
    let vis = |name: &str| dynsym.iter().find(|e| e.0 == name).map(|e| e.2 & 0x3);
    for (name, want) in [
        ("func", Some(STV_PROTECTED)),
        ("pfunc", Some(STV_PROTECTED)),
        ("u", Some(STV_DEFAULT)),
        ("data", None),
        ("__start_mysec", Some(STV_PROTECTED)),
        ("hid_ref_sym", None),
        ("prot_ref_sym", Some(STV_PROTECTED)),
        ("script_sym", Some(STV_DEFAULT)),
        ("prov_sym", None),
        ("hid_sym", None),
    ] {
        assert_eq!(vis(name), want, "{name}");
    }
}

/// A shared object imports a default-visibility weak reference nothing
/// defines, as GNU ld 2.46.1 does: a WEAK UND `.dynsym` row named by the GOT
/// slot's GLOB_DAT and the address field's R_X86_64_64, so the loader writes
/// 0 or another component's definition rather than the load base.
#[test]
fn a_shared_object_imports_an_undefined_weak_reference() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let a = TestObj::new()
        // mov w@GOTPCREL(%rip), %rax; ret
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x48, 0x8b, 0x05, 0, 0, 0, 0, 0xc3],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("w", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        // Symtab: null(0), sections(1, 2), w(3).
        .reloc(0, 3, 3, rt::R_X86_64_REX_GOTPCRELX, -4)
        .reloc(1, 0, 3, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("w.o", a).expect("parses")];
    let res = link_with_script(&script, objs, &shared_opts(EM_X86_64)).expect("links");
    let row = dynsym_entries(&res.image).into_iter().find(|e| e.0 == "w");
    assert_eq!(
        row.map(|e| (e.1, e.2)),
        Some(((STB_WEAK << 4) | STT_NOTYPE, STV_DEFAULT))
    );
    let named: Vec<u32> = (dyn_relocs(&res.image).into_iter())
        .filter(|r| r.2 == "w")
        .map(|r| r.1)
        .collect();
    assert!(
        named.contains(&rt::R_X86_64_GLOB_DAT) && named.contains(&rt::R_X86_64_64),
        "{named:?}"
    );
}

/// `.symtab` as `(name, st_info, st_other)`, in table order.
fn symtab_entries(image: &[u8]) -> Vec<(String, u8, u8)> {
    let (_, syms) = image_section(image, ".symtab");
    let (_, strtab) = image_section(image, ".strtab");
    (syms.as_chunks::<24>().0.iter())
        .map(|e| {
            let name = u32::from_le_bytes(e[..4].try_into().unwrap()) as usize;
            (strz(&strtab, name), e[4], e[5])
        })
        .collect()
}

/// In a shared object's `.symtab`, a global forced local by a hidden or
/// internal visibility is written LOCAL DEFAULT, and a definition a
/// reference declares protected GLOBAL PROTECTED, as GNU ld 2.46.1 writes
/// them.
#[test]
fn a_shared_objects_symtab_states_the_merged_visibility_as_gnu_ld_does() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let defs = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3; 16],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[1; 8])
        .sym("hfunc", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .vis(STV_HIDDEN)
        .sym("ifunc_", STB_GLOBAL, STT_FUNC, 0, 4, 1)
        .vis(STV_INTERNAL)
        .sym("func", STB_GLOBAL, STT_FUNC, 0, 8, 1)
        .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .build(EM_X86_64);
    let refs = TestObj::new()
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 16])
        // Symtab: null(0), the section(1), data(2), func(3).
        .sym("data", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .vis(STV_HIDDEN)
        .sym("func", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
        .vis(STV_PROTECTED)
        .reloc(0, 0, 2, rt::R_X86_64_64, 0)
        .reloc(0, 8, 3, rt::R_X86_64_64, 0)
        .build(EM_X86_64);
    let objs = alloc::vec![
        parse_lds_object("defs.o", defs).expect("parses"),
        parse_lds_object("refs.o", refs).expect("parses"),
    ];
    let res = link_with_script(&script, objs, &shared_opts(EM_X86_64)).expect("links");
    let symtab = symtab_entries(&res.image);
    let row = |name: &str| {
        let e = symtab
            .iter()
            .find(|e| e.0 == name)
            .unwrap_or_else(|| panic!("{name}"));
        (e.1 >> 4, e.2 & 0x3)
    };
    for (name, want) in [
        ("hfunc", (STB_LOCAL, STV_DEFAULT)),
        ("ifunc_", (STB_LOCAL, STV_DEFAULT)),
        ("data", (STB_LOCAL, STV_DEFAULT)),
        ("func", (STB_GLOBAL, STV_PROTECTED)),
    ] {
        assert_eq!(row(name), want, "{name}");
    }
}

/// `.rela.dyn` as `(offset, type, symbol, addend)`, the symbol by name.
fn dyn_relocs(image: &[u8]) -> Vec<(u64, u32, String, i64)> {
    let syms = dynsym_entries(image);
    let (_, rela) = image_section(image, ".rela.dyn");
    let word = |c: &[u8], at: usize| u64::from_le_bytes(c[at..at + 8].try_into().unwrap());
    (rela.as_chunks::<24>().0.iter())
        .map(|c| {
            let info = word(c, 8);
            let sym = syms.get((info >> 32) as usize).map(|s| s.0.clone());
            (
                word(c, 0),
                info as u32,
                sym.unwrap_or_default(),
                word(c, 16) as i64,
            )
        })
        .collect()
}

/// The address of output section `name`, if the image has it.
fn section_addr(image: &[u8], name: &str) -> Option<u64> {
    readelf_sections(image)
        .iter()
        .find(|s| s.0 == name)
        .map(|s| s.2)
}

fn u32_at(bytes: &[u8], at: usize) -> u32 {
    u32::from_le_bytes(bytes[at..at + 4].try_into().unwrap())
}

/// `-shared` options under `-Bsymbolic` (`Some(true)`),
/// `-Bsymbolic-functions` (`Some(false)`) or neither.
fn binding_opts(machine: u16, symbolic: Option<bool>) -> LdsOptions {
    LdsOptions {
        symbolic: symbolic == Some(true),
        symbolic_functions: symbolic == Some(false),
        ..shared_opts(machine)
    }
}

/// A unit calling `func`, loading `data`'s address through the GOT,
/// and holding `&func` and `&data + 4` in `.data`: `.text` is the call,
/// the GOT load, a return, then `func` at 16; `.data` is `data` and
/// the two pointers. Symtab: null(0), sections(1, 2), func(3),
/// data(4), caller(5).
fn preemption_unit(machine: u16) -> Vec<u8> {
    let mut text = [0u8; 20];
    let (call, got_page, got_lo, abs) = if machine == EM_AARCH64 {
        for (k, w) in [0x9400_0000u32, 0x9000_0000, 0xf940_0000, 0xd65f_03c0]
            .iter()
            .enumerate()
        {
            text[4 * k..4 * k + 4].copy_from_slice(&w.to_le_bytes());
        }
        text[16..20].copy_from_slice(&0xd65f_03c0u32.to_le_bytes());
        (
            (0, rt::R_AARCH64_CALL26, 0),
            Some((4, rt::R_AARCH64_ADR_GOT_PAGE)),
            (8, rt::R_AARCH64_LD64_GOT_LO12_NC, 0),
            rt::R_AARCH64_ABS64,
        )
    } else {
        text[..12].copy_from_slice(&[0xe8, 0, 0, 0, 0, 0x48, 0x8b, 0x05, 0, 0, 0, 0]);
        text[12] = 0xc3;
        text[16] = 0xc3;
        (
            (1, rt::R_X86_64_PLT32, -4),
            None,
            (8, rt::R_X86_64_REX_GOTPCRELX, -4),
            rt::R_X86_64_64,
        )
    };
    let mut o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 24])
        .sym("func", STB_GLOBAL, STT_FUNC, 0, 16, 4)
        .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .sym("caller", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .reloc(0, call.0, 3, call.1, call.2)
        .reloc(0, got_lo.0, 4, got_lo.1, got_lo.2)
        .reloc(1, 8, 3, abs, 0)
        .reloc(1, 16, 4, abs, 4);
    if let Some((at, rtype)) = got_page {
        o = o.reloc(0, at, 4, rtype, 0);
    }
    o.build(machine)
}

fn link_preemption(machine: u16, symbolic: Option<bool>) -> LdsResult {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let objs = alloc::vec![parse_lds_object("u.o", preemption_unit(machine)).expect("parses")];
    link_with_script(&script, objs, &binding_opts(machine, symbolic)).expect("links")
}

/// Where the call at the start of `.text` branches to.
fn call_target(machine: u16, image: &[u8]) -> u64 {
    let (text_addr, text) = image_section(image, ".text");
    if machine == EM_AARCH64 {
        let imm = (u32_at(&text, 0) & 0x03ff_ffff) << 6;
        return text_addr.wrapping_add((((imm as i32) >> 6) as i64 * 4) as u64);
    }
    let disp = u32_at(&text, 1) as i32 as i64;
    (text_addr as i64 + 5 + disp) as u64
}

/// GNU ld 2.46.1 `-shared -T`, measured with gcc objects on both
/// targets: a call to the object's own default-visibility function goes
/// through a lazy PLT entry past the header, and the entry through a
/// `.got.plt` slot a `JUMP_SLOT` naming the definition's own `.dynsym`
/// entry binds; the function takes no `.got` slot. `-Bsymbolic` and
/// `-Bsymbolic-functions` call the function in place.
#[test]
fn a_shared_objects_call_to_its_own_function_takes_a_lazy_plt_entry() {
    for machine in [EM_X86_64, EM_AARCH64] {
        let res = link_preemption(machine, None);
        let plt = section_addr(&res.image, ".plt").expect("a .plt");
        let entry = plt + if machine == EM_AARCH64 { 32 } else { 16 };
        assert_eq!(call_target(machine, &res.image), entry, "{machine}");
        let gotplt = section_addr(&res.image, ".got.plt").expect("a .got.plt");
        let slot = gotplt + 24;
        let (_, stubs) = image_section(&res.image, ".plt");
        let stub = &stubs[(entry - plt) as usize..];
        let through = if machine == EM_AARCH64 {
            let page = ((u32_at(stub, 0) >> 29 & 3) | (u32_at(stub, 0) >> 5 & 0x7ffff) << 2) as u64;
            (entry & !0xfff) + (page << 12) + ((u32_at(stub, 4) >> 10 & 0xfff) as u64) * 8
        } else {
            (entry as i64 + 6 + u32_at(stub, 2) as i32 as i64) as u64
        };
        assert_eq!(through, slot, "{machine}: the entry loads func's slot");
        let relocs = dyn_relocs(&res.image);
        let jump_slot = if machine == EM_AARCH64 {
            rt::R_AARCH64_JUMP_SLOT
        } else {
            rt::R_X86_64_JUMP_SLOT
        };
        assert!(
            relocs.contains(&(slot, jump_slot, String::from("func"), 0)),
            "{machine}: {relocs:?}"
        );
        let (_, got) = image_section(&res.image, ".got");
        let header = if machine == EM_AARCH64 { 8 } else { 0 };
        assert_eq!(got.len(), header + 8, "{machine}: one .got slot, data's");
        for symbolic in [Some(true), Some(false)] {
            let res = link_preemption(machine, symbolic);
            let func = find_sym(&image_symbols(&res.image), "func");
            assert_eq!(call_target(machine, &res.image), func, "{symbolic:?}");
        }
    }
}

/// GNU ld 2.46.1 keeps a GOT reference to a preemptible definition on
/// its slot, bound by `GLOB_DAT` against the definition, and writes the
/// slot zero; x86-64 does not relax the load to an address.
/// `-Bsymbolic` relaxes it, and `-Bsymbolic-functions` keeps an
/// object's slot.
#[test]
fn a_got_reference_to_a_preemptible_definition_keeps_its_slot() {
    for machine in [EM_X86_64, EM_AARCH64] {
        let glob_dat = if machine == EM_AARCH64 {
            rt::R_AARCH64_GLOB_DAT
        } else {
            rt::R_X86_64_GLOB_DAT
        };
        for symbolic in [None, Some(false), Some(true)] {
            let res = link_preemption(machine, symbolic);
            let relocs = dyn_relocs(&res.image);
            let data_slot = relocs
                .iter()
                .find(|r| r.1 == glob_dat && r.2 == "data")
                .map(|r| r.0);
            assert_eq!(
                data_slot.is_some(),
                symbolic != Some(true),
                "{machine} {symbolic:?}: {relocs:?}"
            );
            let (_, text) = image_section(&res.image, ".text");
            if machine == EM_X86_64 {
                let kept = text[6] == 0x8b;
                assert_eq!(kept, symbolic != Some(true), "{symbolic:?}: mov kept");
            }
            if let Some(slot) = data_slot {
                let (got, body) = image_section(&res.image, ".got");
                let at = (slot - got) as usize;
                assert_eq!(body[at..at + 8], [0; 8], "{machine}: the loader fills it");
            }
        }
    }
}

/// GNU ld 2.46.1 leaves an address-width field naming a preemptible
/// definition to an `R_X86_64_64` / `R_AARCH64_ABS64` against the
/// symbol, with the addend, and writes nothing in place.
/// `-Bsymbolic-functions` takes a `RELATIVE` for the function only.
#[test]
fn an_address_field_names_a_preemptible_definition() {
    for machine in [EM_X86_64, EM_AARCH64] {
        let (abs, relative) = if machine == EM_AARCH64 {
            (rt::R_AARCH64_ABS64, rt::R_AARCH64_RELATIVE)
        } else {
            (rt::R_X86_64_64, rt::R_X86_64_RELATIVE)
        };
        for (symbolic, func_form, data_form) in [
            (None, abs, abs),
            (Some(false), relative, abs),
            (Some(true), relative, relative),
        ] {
            let res = link_preemption(machine, symbolic);
            let (data_addr, data) = image_section(&res.image, ".data");
            let relocs = dyn_relocs(&res.image);
            let at = |off: u64| relocs.iter().find(|r| r.0 == data_addr + off).cloned();
            let (_, ftype, fname, _) = at(8).expect("&func has a dynamic entry");
            let (_, dtype, dname, daddend) = at(16).expect("&data + 4 has one");
            assert_eq!((ftype, dtype), (func_form, data_form), "{symbolic:?}");
            if func_form == abs {
                assert_eq!(fname, "func");
            }
            if data_form == abs {
                assert_eq!((dname.as_str(), daddend), ("data", 4));
                assert_eq!(data[16..24], [0; 8], "{machine}: nothing in place");
            }
        }
    }
}

/// GNU ld 2.46.1 on a field neither a stub, a slot nor a dynamic
/// relocation can redirect: x86-64 refuses a PC-relative one in a
/// read-only section and leaves one in a writable section to an
/// `R_X86_64_PC32` against the symbol; aarch64 refuses `adrp` and binds
/// a PC-relative data field directly. Under `-Bsymbolic` each binds
/// directly.
#[test]
fn a_pc_relative_field_follows_ld_against_a_preemptible_definition() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let defs = |machine: u16| {
        TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0; 4])
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
            .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            .build(machine)
    };
    let site = |machine: u16, sec: &str, rtype: u32| {
        let flags = if sec == ".text" {
            SHF_ALLOC | SHF_EXECINSTR
        } else {
            SHF_ALLOC | SHF_WRITE
        };
        let body: &[u8] = if machine == EM_AARCH64 && sec == ".text" {
            &[0, 0, 0, 0x90]
        } else {
            &[0x48, 0x8d, 0x05, 0, 0, 0, 0, 0]
        };
        let at = if machine == EM_X86_64 && sec == ".text" {
            3
        } else {
            0
        };
        TestObj::new()
            .sec(sec, SHT_PROGBITS, flags, 4, body)
            .sym("data", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
            .reloc(0, at, 2, rtype, 0)
            .build(machine)
    };
    let link = |machine: u16, sec: &str, rtype: u32, symbolic: bool| {
        let objs = alloc::vec![
            parse_lds_object("defs.o", defs(machine)).expect("parses"),
            parse_lds_object("site.o", site(machine, sec, rtype)).expect("parses"),
        ];
        let opts = binding_opts(machine, symbolic.then_some(true));
        link_with_script(&script, objs, &opts)
    };
    for (machine, sec, rtype) in [
        (EM_X86_64, ".text", rt::R_X86_64_PC32),
        (EM_AARCH64, ".text", rt::R_AARCH64_ADR_PREL_PG_HI21),
    ] {
        let e = alloc::format!("{}", link(machine, sec, rtype, false).expect_err("refused"));
        assert!(
            e.contains("site.o(.text+0x")
                && e.contains("against symbol `data`")
                && e.contains("when making a shared object")
                && e.contains("recompile with -fPIC"),
            "{e}"
        );
        link(machine, sec, rtype, true).expect("-Bsymbolic binds it");
    }
    let res = link(EM_X86_64, ".data", rt::R_X86_64_PC32, false).expect("links");
    let relocs = dyn_relocs(&res.image);
    assert!(
        relocs
            .iter()
            .any(|r| r.1 == rt::R_X86_64_PC32 && r.2 == "data"),
        "{relocs:?}"
    );
    let res = link(EM_AARCH64, ".data", rt::R_AARCH64_PREL32, false).expect("links");
    assert!(
        !readelf_sections(&res.image)
            .iter()
            .any(|s| s.0 == ".rela.dyn" && s.3 > 0),
        "aarch64 binds the field in place"
    );
}

/// GNU ld 2.46.1 binds every reference to a protected, hidden or
/// internal definition, and to one the version script makes local,
/// directly: the call reaches the function, the GOT load relaxes, and
/// the pointer takes a `RELATIVE`.
#[test]
fn a_definition_the_loader_cannot_preempt_binds_directly() {
    let base = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let local =
        alloc::format!("{SHARED_SCRIPT}\nVERSION {{ V1 {{ global: caller; local: *; }}; }}");
    let local = parse_linker_script(&local).expect("script parses");
    let cases: [(&LinkerScript, u8); 4] = [
        (&base, STV_PROTECTED),
        (&base, STV_HIDDEN),
        (&base, STV_INTERNAL),
        (&local, STV_DEFAULT),
    ];
    for (script, vis) in cases {
        let unit = preemption_unit(EM_X86_64);
        let mut o = parse_lds_object("u.o", unit).expect("parses");
        for s in o
            .symbols
            .iter_mut()
            .filter(|s| s.name == "func" || s.name == "data")
        {
            s.other = vis;
        }
        let res = link_with_script(script, alloc::vec![o], &shared_opts(EM_X86_64)).expect("links");
        let func = find_sym(&image_symbols(&res.image), "func");
        assert_eq!(call_target(EM_X86_64, &res.image), func, "vis {vis}");
        let (_, text) = image_section(&res.image, ".text");
        assert_eq!(text[6], 0x8d, "vis {vis}: the load relaxes");
        let relocs = dyn_relocs(&res.image);
        assert!(
            relocs.iter().all(|r| r.1 == rt::R_X86_64_RELATIVE),
            "vis {vis}: {relocs:?}"
        );
    }
}

/// GNU ld 2.46.1 makes a symbol the script defines preemptible when it
/// is exported, provided or not, and binds a hidden one directly. Under
/// `-Bsymbolic-functions` an untyped script symbol binds directly, as
/// bfd counts only an object as data.
#[test]
fn a_script_symbol_is_preemptible_unless_hidden() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let names = ["script_sym", "prov_sym", "hid_sym"];
    let mut o = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc3; 4],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 24]);
    for (k, name) in names.iter().enumerate() {
        o = o.sym(name, STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0).reloc(
            1,
            8 * k as u64,
            3 + k as u32,
            rt::R_X86_64_64,
            0,
        );
    }
    let unit = o.build(EM_X86_64);
    for (symbolic, want) in [
        (None, [true, true, false]),
        (Some(false), [false, false, false]),
    ] {
        let objs = alloc::vec![parse_lds_object("s.o", unit.clone()).expect("parses")];
        let opts = binding_opts(EM_X86_64, symbolic);
        let res = link_with_script(&script, objs, &opts).expect("links");
        let relocs = dyn_relocs(&res.image);
        for (name, preempted) in names.iter().zip(want) {
            let named = relocs
                .iter()
                .any(|r| r.1 == rt::R_X86_64_64 && r.2 == *name);
            assert_eq!(named, preempted, "{name} {symbolic:?}: {relocs:?}");
        }
    }
}

/// A `.note.badc` body listing `names` as data the unit reaches through
/// a symbol (record 12).
fn badc_extern_data_note(names: &[&str]) -> Vec<u8> {
    let mut desc: Vec<u8> = Vec::new();
    for n in names {
        desc.extend_from_slice(n.as_bytes());
        desc.push(0);
    }
    let mut note = Vec::new();
    for w in [5u32, desc.len() as u32, 12] {
        note.extend_from_slice(&w.to_le_bytes());
    }
    note.extend_from_slice(b"badc\0\0\0\0");
    note.extend_from_slice(&desc);
    note.resize(note.len().next_multiple_of(4), 0);
    note
}

/// badc reaches an aarch64 object through an `adrp` / `add` pair its
/// note lists, which a link rewrites into a load of the object's GOT
/// slot where the object binds at load time. A preemptible definition
/// takes the rewrite and a `GLOB_DAT`; a load through the pair's low
/// bits is refused, since the pair's page is the slot's.
#[test]
fn a_noted_page_pair_loads_a_preemptible_definitions_slot() {
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let unit = |second: u32, rtype: u32| {
        let mut text = Vec::new();
        for w in [0x9000_0001u32, second, 0xd65f_03c0] {
            text.extend_from_slice(&w.to_le_bytes());
        }
        TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &text)
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
            .sec(".note.badc", SHT_NOTE, 0, 4, &badc_extern_data_note(&["g"]))
            .sym("g", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
            // Symtab: null(0), sections(1..=3), g(4).
            .reloc(0, 0, 4, rt::R_AARCH64_ADR_PREL_PG_HI21, 0)
            .reloc(0, 4, 4, rtype, 0)
            .build(EM_AARCH64)
    };
    // add x1, x1, :lo12:g, then ldr w1, [x1, :lo12:g].
    let link = |second: u32, rtype: u32| {
        let objs = alloc::vec![parse_lds_object("n.o", unit(second, rtype)).expect("parses")];
        link_with_script(&script, objs, &shared_opts(EM_AARCH64))
    };
    let res = link(0x9100_0021, rt::R_AARCH64_ADD_ABS_LO12_NC).expect("links");
    let (text_addr, text) = image_section(&res.image, ".text");
    let relocs = dyn_relocs(&res.image);
    let slot = relocs
        .iter()
        .find(|r| r.1 == rt::R_AARCH64_GLOB_DAT && r.2 == "g")
        .unwrap_or_else(|| panic!("g's slot: {relocs:?}"))
        .0;
    let adrp = u32_at(&text, 0);
    let page = ((adrp >> 29 & 3) | (adrp >> 5 & 0x7ffff) << 2) as u64;
    assert_eq!(
        (text_addr & !0xfff) + (page << 12),
        slot & !0xfff,
        "adrp takes the slot's page"
    );
    let ldr = 0xf940_0021 | (((slot & 0xfff) / 8) as u32) << 10;
    assert_eq!(u32_at(&text, 4), ldr, "the add becomes ldr x1, [x1, slot]");
    let e = link(0xb940_0021, rt::R_AARCH64_LDST32_ABS_LO12_NC).expect_err("refused");
    assert!(
        alloc::format!("{e}").contains("recompile with -fPIC"),
        "{e}"
    );
}

/// A script placing every section an i386 dynamic link builds.
const I386_DYN_SCRIPT: &str = r#"
SECTIONS {
  . = SIZEOF_HEADERS;
  .hash : { *(.hash) }
  .gnu.hash : { *(.gnu.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .rel.dyn : { *(.rel.*) }
  .plt : { *(.plt) }
  .text : { *(.text*) }
  . = ALIGN(0x1000);
  .dynamic : { *(.dynamic) }
  .got : { *(.got) }
  .got.plt : { *(.got.plt) }
  .data : { *(.data*) }
  .bss : { *(.bss*) }
}
"#;

/// `.rel.dyn` of an ELF32 image as `(offset, type, symbol)`.
fn elf32_dyn_relocs(image: &[u8]) -> Vec<(u64, u32, String)> {
    let names = elf32_symbols_of(image, ".dynsym", ".dynstr");
    let Some(rel) = elf32_sections(image)
        .into_iter()
        .find(|s| s.0 == ".rel.dyn")
    else {
        return Vec::new();
    };
    let body = &image[rel.3 as usize..(rel.3 + rel.4) as usize];
    (body.as_chunks::<8>().0.iter())
        .map(|c| {
            let info = u32_at(c, 4);
            let sym = names.get((info >> 8) as usize).map(|s| s.0.clone());
            (u32_at(c, 0) as u64, info & 0xff, sym.unwrap_or_default())
        })
        .collect()
}

/// `(name, value)` of every entry of the ELF32 symbol table `table`.
fn elf32_symbols_of(image: &[u8], table: &str, strings: &str) -> Vec<(String, u64)> {
    let secs = elf32_sections(image);
    let (Some(t), Some(s)) = (
        secs.iter().find(|s| s.0 == table),
        secs.iter().find(|s| s.0 == strings),
    ) else {
        return Vec::new();
    };
    let names = &image[s.3 as usize..(s.3 + s.4) as usize];
    let body = &image[t.3 as usize..(t.3 + t.4) as usize];
    (body.as_chunks::<16>().0.iter())
        .map(|e| (strz(names, u32_at(e, 0) as usize), u32_at(e, 4) as u64))
        .collect()
}

fn i32_at(bytes: &[u8], at: usize) -> i64 {
    u32_at(bytes, at) as i32 as i64
}

/// Opcode and ModRM of the loads [`i386_got_unit`] holds, in order.
const I386_GOT_INSNS: [[u8; 2]; 10] = [
    [0x8b, 0x83],
    [0x85, 0x8b],
    [0x03, 0x8b],
    [0x3b, 0x93],
    [0xff, 0x93],
    [0xff, 0xa3],
    [0xff, 0xb3],
    [0x8b, 0x83],
    [0x8b, 0x83],
    [0x8b, 0x83],
];

/// i386 loads through the GOT as gas encodes them, each with `rtype`:
/// `mov`, `test`, `add`, `cmp` and `push` of `loc`, a call and a jump
/// through `fn`'s slot, `mov` of `loc + 4`'s slot, and `mov` of an
/// absolute `abs` and of a hidden `hid`. `fn` is at 61 of `.text`;
/// `.data` holds `loc` and, at 8, `hid`. Symtab: null(0), sections(1,
/// 2), _start(3), fn(4), loc(5), hid(6), abs(7).
fn i386_got_unit(rtype: u32) -> Vec<u8> {
    let mut text = Vec::new();
    for i in I386_GOT_INSNS {
        text.extend_from_slice(&i);
        text.extend_from_slice(&[0; 4]);
    }
    text.extend_from_slice(&[0xc3, 0xc3]);
    let mut o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 12])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 61)
        .sym("fn", STB_GLOBAL, STT_FUNC, 0, 61, 1)
        .sym("loc", STB_GLOBAL, STT_OBJECT, 1, 0, 8)
        .sym("hid", STB_GLOBAL, STT_OBJECT, 1, 8, 4)
        .vis(STV_HIDDEN)
        .sym("abs", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x1234, 0);
    for (k, sym, addend) in [
        (0, 5, 0),
        (1, 5, 0),
        (2, 5, 0),
        (3, 5, 0),
        (4, 4, 0),
        (5, 4, 0),
        (6, 5, 0),
        (7, 5, 4),
        (8, 7, 0),
        (9, 6, 0),
    ] {
        o = o.reloc(0, 6 * k + 2, sym, rtype, addend);
    }
    o.build_class(EM_386, ElfClass::Elf32, false)
}

/// `-shared` (`Some(true)`), `-pie` (`Some(false)`) or a
/// position-dependent executable (`None`).
fn i386_opts(pic: Option<bool>) -> LdsOptions {
    LdsOptions {
        emit: if pic.is_some() {
            LdsEmit::Dyn
        } else {
            LdsEmit::Exec
        },
        shared: pic == Some(true),
        ..Default::default()
    }
}

fn link_i386_with(objs: Vec<(&str, Vec<u8>)>, opts: &LdsOptions) -> Result<LdsResult, C5Error> {
    let script = parse_linker_script(I386_DYN_SCRIPT).expect("script parses");
    let objs = (objs.into_iter())
        .map(|(n, b)| parse_lds_object(n, b).expect("parses"))
        .collect();
    link_with_script(&script, objs, opts)
}

/// [`link_i386_with`] under [`i386_opts`], a shared object linked
/// `-Bsymbolic` so that its definitions bind in place.
fn link_i386(objs: Vec<(&str, Vec<u8>)>, pic: Option<bool>) -> Result<LdsResult, C5Error> {
    let opts = LdsOptions {
        symbolic: pic == Some(true),
        ..i386_opts(pic)
    };
    link_i386_with(objs, &opts)
}

/// The address of each of `names` in the image's `.symtab`.
fn i386_addrs<const N: usize>(image: &[u8], names: [&str; N]) -> [i64; N] {
    let syms = elf32_symbols_of(image, ".symtab", ".strtab");
    names.map(|n| {
        let s = syms.iter().find(|s| s.0 == n);
        s.unwrap_or_else(|| panic!("no `{n}'")).1 as i64
    })
}

/// GNU ld 2.46.1 relaxes `R_386_GOT32X` loads of a symbol the link
/// resolves locally, measured on gas's encodings of each form: a
/// position-dependent executable turns `mov`, `test`, an ALU op and
/// `push` into immediates and a call or jump into a direct branch; a
/// position-independent image turns only `mov` into `lea` of the
/// GOT-relative offset, and `mov` of an absolute symbol into an
/// immediate, and keeps the other loads on a slot `R_386_RELATIVE`
/// fills. A nonzero addend keeps the slot in both.
#[test]
fn i386_got32x_loads_relax_as_gnu_ld_relaxes_them() {
    for pic in [None, Some(false), Some(true)] {
        let res = link_i386(alloc::vec![("u.o", i386_got_unit(rt::R_386_GOT32X))], pic)
            .unwrap_or_else(|e| panic!("{pic:?}: {e}"));
        let img = &res.image;
        let [t, f, l, h] = i386_addrs(img, ["_start", "fn", "loc", "hid"]);
        let g = elf32_section(img, ".got.plt").2 as i64;
        let got = elf32_section(img, ".got");
        assert_eq!(got.4, 4, "{pic:?}: one slot, for `loc + 4`");
        let s = got.2 as i64;
        let imm = |op: [u8; 2], v: i64| [op[0], op[1]].into_iter().chain((v as u32).to_le_bytes());
        let mut want: Vec<u8> = Vec::new();
        if pic.is_none() {
            want.extend(imm([0xc7, 0xc0], l));
            want.extend(imm([0xf7, 0xc1], l));
            want.extend(imm([0x81, 0xc1], l));
            want.extend(imm([0x81, 0xfa], l));
        } else {
            want.extend(imm([0x8d, 0x83], l - g));
            want.extend(imm([0x85, 0x8b], s - g));
            want.extend(imm([0x03, 0x8b], s - g));
            want.extend(imm([0x3b, 0x93], s - g));
        }
        want.extend(imm([0x67, 0xe8], f - (t + 30)));
        want.push(0xe9);
        want.extend(((f - (t + 35)) as u32).to_le_bytes());
        want.push(0x90);
        if pic.is_none() {
            want.extend(imm([0x2e, 0x68], l));
        } else {
            want.extend(imm([0xff, 0xb3], s - g));
        }
        want.extend(imm([0x8b, 0x83], s + 4 - g));
        want.extend(imm([0xc7, 0xc0], 0x1234));
        if pic.is_none() {
            want.extend(imm([0xc7, 0xc0], h));
        } else {
            want.extend(imm([0x8d, 0x83], h - g));
        }
        want.extend([0xc3, 0xc3]);
        assert_eq!(elf32_body(img, ".text"), want, "{pic:?}");
        let slot = u32_at(elf32_body(img, ".got"), 0) as i64;
        assert_eq!(slot, l, "{pic:?}: the slot holds `loc`");
        if pic.is_some() {
            let relocs = elf32_dyn_relocs(img);
            assert_eq!(
                relocs,
                [(s as u64, rt::R_386_RELATIVE, String::new())],
                "{pic:?}"
            );
        }
    }
}

/// GNU ld 2.46.1 keeps every `R_386_GOT32` load on a slot: the field is
/// the slot's offset from `_GLOBAL_OFFSET_TABLE_` plus the addend and
/// the slot holds the address. A position-independent image fills each
/// slot with an `R_386_RELATIVE` but the absolute symbol's, which holds
/// a number, as bfd leaves it in a PIE.
#[test]
fn i386_got32_keeps_every_load_on_a_slot() {
    for pic in [None, Some(false), Some(true)] {
        let res = link_i386(alloc::vec![("u.o", i386_got_unit(rt::R_386_GOT32))], pic)
            .unwrap_or_else(|e| panic!("{pic:?}: {e}"));
        let img = &res.image;
        let [f, l, h] = i386_addrs(img, ["fn", "loc", "hid"]);
        let g = elf32_section(img, ".got.plt").2 as i64;
        let (got_addr, got) = (elf32_section(img, ".got").2 as i64, elf32_body(img, ".got"));
        assert_eq!(got.len(), 16, "{pic:?}: slots for loc, fn, abs and hid");
        let text = elf32_body(img, ".text");
        for (k, want, addend) in [
            (0, l, 0),
            (1, l, 0),
            (2, l, 0),
            (3, l, 0),
            (4, f, 0),
            (5, f, 0),
            (6, l, 0),
            (7, l, 4),
            (8, 0x1234, 0),
            (9, h, 0),
        ] {
            assert_eq!(text[6 * k..6 * k + 2], I386_GOT_INSNS[k], "kept form");
            let slot = g + i32_at(text, 6 * k + 2) - addend - got_addr;
            assert_eq!(i32_at(got, slot as usize), want, "{pic:?}: load {k}");
        }
        if pic.is_some() {
            let relocs = elf32_dyn_relocs(img);
            let abs_slot = (g + i32_at(text, 6 * 8 + 2)) as u64;
            assert_eq!(relocs.len(), 3, "{relocs:?}");
            assert!(
                (relocs.iter()).all(|r| r.1 == rt::R_386_RELATIVE && r.0 != abs_slot),
                "{relocs:?}"
            );
        }
    }
}

/// A GOT load with no base register, as GNU ld 2.46.1 links it: a
/// position-dependent executable relaxes `mov` and `call` and gives
/// `lea foo@GOT` the slot's GOT-relative offset; a position-independent
/// image refuses the `mov`, having no GOT address to give, and still
/// takes the `lea`.
#[test]
fn an_i386_got_load_without_a_base_register_follows_gnu_ld() {
    // mov loc@GOT, %eax; lea loc@GOT, %eax; call *fn@GOT; ret; fn: ret;
    // the `mov` with `mov`, the call where `call`. Symtab: null(0),
    // sections(1, 2), loc(3), _start(4), fn(5).
    let unit = |mov: Option<u32>, call: bool| {
        let text = [
            0x8b, 0x05, 0, 0, 0, 0, 0x8d, 0x05, 0, 0, 0, 0, 0xff, 0x15, 0, 0, 0, 0, 0xc3, 0xc3,
        ];
        let mut o = TestObj::new()
            .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
            .sym("loc", STB_LOCAL, STT_OBJECT, 1, 0, 4)
            .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 19)
            .sym("fn", STB_GLOBAL, STT_FUNC, 0, 19, 1)
            .reloc(0, 8, 3, rt::R_386_GOT32, 0);
        if let Some(t) = mov {
            o = o.reloc(0, 2, 3, t, 0);
        }
        if call {
            o = o.reloc(0, 14, 5, rt::R_386_GOT32X, 0);
        }
        o.build_class(EM_386, ElfClass::Elf32, false)
    };
    let res = link_i386(
        alloc::vec![("b.o", unit(Some(rt::R_386_GOT32X), true))],
        None,
    )
    .expect("links");
    let img = &res.image;
    let [t, f, l] = i386_addrs(img, ["_start", "fn", "loc"]);
    let (g, s) = (
        elf32_section(img, ".got.plt").2 as i64,
        elf32_section(img, ".got").2 as i64,
    );
    let text = elf32_body(img, ".text");
    assert_eq!(text[..2], [0xc7, 0xc0]);
    assert_eq!(i32_at(text, 2), l);
    assert_eq!(text[6..8], [0x8d, 0x05]);
    assert_eq!(i32_at(text, 8), s - g, "lea takes the offset");
    assert_eq!(text[12..14], [0x67, 0xe8]);
    assert_eq!(i32_at(text, 14), f - (t + 18));
    for t in [rt::R_386_GOT32X, rt::R_386_GOT32] {
        let e = link_i386(alloc::vec![("b.o", unit(Some(t), false))], Some(false))
            .expect_err("refused");
        let want = alloc::format!(
            "b.o: direct GOT relocation {} against `loc' without base register can not be \
             used when making a shared object",
            rt::i386_reloc_desc(t)
        );
        assert!(alloc::format!("{e}").contains(&want), "{e}");
    }
    let res = link_i386(alloc::vec![("b.o", unit(None, false))], Some(false)).expect("links");
    let img = &res.image;
    let (g, got) = (
        elf32_section(img, ".got.plt").2 as i64,
        elf32_section(img, ".got"),
    );
    let text = elf32_body(img, ".text");
    let lea = g + i32_at(text, 8);
    assert!(
        (got.2 as i64..(got.2 + got.4) as i64).contains(&lea),
        "the lea names a slot"
    );
}

/// Two objects' locals of one name are two symbols, and a GOT reference
/// to each reaches a slot of its own.
#[test]
fn same_named_locals_take_a_got_slot_each() {
    // mov loc@GOT(%ebx), %eax at 0; `loc` at `off` in `.data`.
    // Symtab: null(0), sections(1, 2), loc(3).
    let unit = |off: u64, entry: bool| {
        let mut o = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0x8b, 0x83, 0, 0, 0, 0, 0xc3],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 16])
            .sym("loc", STB_LOCAL, STT_OBJECT, 1, off, 4)
            .reloc(0, 2, 3, rt::R_386_GOT32, 0);
        if entry {
            o = o.sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 7);
        }
        o.build_class(EM_386, ElfClass::Elf32, false)
    };
    let res = link_i386(
        alloc::vec![("a.o", unit(0, true)), ("b.o", unit(8, false))],
        None,
    )
    .expect("links");
    let img = &res.image;
    let (g, got) = (
        elf32_section(img, ".got.plt").2 as i64,
        elf32_section(img, ".got"),
    );
    let (data, text) = (
        elf32_section(img, ".data").2 as i64,
        elf32_body(img, ".text"),
    );
    let body = elf32_body(img, ".got");
    let held: Vec<i64> = [2, 10]
        .iter()
        .map(|&at| i32_at(body, (g + i32_at(text, at) - got.2 as i64) as usize))
        .collect();
    assert_eq!(held, [data, data + 16 + 8], "each object's `loc`");
}

/// GNU ld 2.46.1 builds neither `.got`, `.got.plt` nor
/// `_GLOBAL_OFFSET_TABLE_` for a position-dependent executable whose
/// every GOT load relaxes.
#[test]
fn an_i386_executable_whose_got_loads_all_relax_has_no_got() {
    // mov loc@GOT(%ebx), %eax; ret. Symtab: null(0), sections(1, 2),
    // _start(3), loc(4).
    let o = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0x8b, 0x83, 0, 0, 0, 0, 0xc3],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 7)
        .sym("loc", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .reloc(0, 2, 4, rt::R_386_GOT32X, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    let res = link_i386(alloc::vec![("a.o", o)], None).expect("links");
    let img = &res.image;
    let secs = elf32_sections(img);
    assert!(
        !secs.iter().any(|s| s.0.starts_with(".got")),
        "{:?}",
        secs.iter().map(|s| &s.0).collect::<Vec<_>>()
    );
    let syms = elf32_symbols_of(img, ".symtab", ".strtab");
    assert!(!syms.iter().any(|s| s.0 == GOT_SYMBOL), "{syms:?}");
    assert_eq!(elf32_body(img, ".text")[..2], [0xc7, 0xc0]);
}

/// An i386 unit calling `foo`, loading `bar`'s address through the GOT
/// and holding `&bar` and `&_start` in `.data`. Symtab: null(0),
/// sections(1, 2), _start(3), foo(4), bar(5).
fn i386_import_user() -> Vec<u8> {
    // call foo; mov bar@GOT(%ebx), %eax; ret
    let text = [0xe8, 0, 0, 0, 0, 0x8b, 0x83, 0, 0, 0, 0, 0xc3];
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 12)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .reloc(0, 1, 4, rt::R_386_PLT32, -4)
        .reloc(0, 7, 5, rt::R_386_GOT32X, 0)
        .reloc(1, 0, 5, rt::R_386_32, 0)
        .reloc(1, 4, 3, rt::R_386_32, 0)
        .build_class(EM_386, ElfClass::Elf32, false)
}

/// An i386 executable, position-independent where `pic`, against a
/// library exporting `foo` and the object `bar`.
fn i386_import_opts(pic: bool) -> LdsOptions {
    let mut lib = shared_input("libone.so", &["foo"], &["bar"]);
    lib.lib.machine = EM_386;
    LdsOptions {
        shared_libs: alloc::vec![lib],
        interp: Some(String::from("/lib/ld-linux.so.2")),
        ..i386_opts(pic.then_some(false))
    }
}

/// The slot `.rel.dyn` binds to `name` by `rtype`.
fn i386_slot(relocs: &[(u64, u32, String)], name: &str, rtype: u32) -> i64 {
    let slot = relocs.iter().find(|r| r.1 == rtype && r.2 == name);
    slot.unwrap_or_else(|| panic!("{name}'s slot: {relocs:?}"))
        .0 as i64
}

/// The lazy i386 PLT GNU ld 2.46.1 writes for one called import, at
/// `plt` with `.got.plt` at `g` and the import's slot at `slot`: through
/// `%ebx`, which holds `g` at the call, in a position-independent image
/// (`ff b3`, `ff a3`), and by absolute address otherwise (`ff 35`, `ff
/// 25`); the entry pushes its relocation's offset and jumps to the header.
fn i386_lazy_plt(pic: bool, plt: i64, g: i64, slot: i64) -> Vec<u8> {
    let indirect = |op: u8, to: i64| {
        let (modrm, field) = if pic {
            (op | 0x83, to - g)
        } else {
            (op | 0x05, to)
        };
        [0xff, modrm]
            .into_iter()
            .chain((field as u32).to_le_bytes())
    };
    let mut want: Vec<u8> = Vec::new();
    want.extend(indirect(0x30, g + 4));
    want.extend(indirect(0x20, g + 8));
    want.extend([0; 4]);
    want.extend(indirect(0x20, slot));
    want.extend([0x68, 0, 0, 0, 0, 0xe9]);
    want.extend(((plt - (plt + 32)) as u32).to_le_bytes());
    want
}

/// An i386 executable calls an import through a lazy PLT entry and loads
/// it through a GOT slot `R_386_GLOB_DAT` fills, as GNU ld 2.46.1 links
/// one (Intel386 psABI, procedure linkage table): the entry jumps through
/// its `.got.plt` slot, which holds the entry's `push` until an
/// `R_386_JUMP_SLOT` binds it; an address-width field naming the import
/// takes an `R_386_32` against it. A PIE reaches the slots from `%ebx`; a
/// position-dependent executable names their addresses, stays `ET_EXEC`
/// and takes no `R_386_RELATIVE`.
#[test]
fn an_i386_executable_reaches_an_import_through_a_lazy_plt_entry() {
    for pic in [true, false] {
        let res = link_i386_with(
            alloc::vec![("u.o", i386_import_user())],
            &i386_import_opts(pic),
        )
        .expect("links");
        let img = &res.image;
        let relocs = elf32_dyn_relocs(img);
        let foo = i386_slot(&relocs, "foo", rt::R_386_JUMP_SLOT);
        let bar = i386_slot(&relocs, "bar", rt::R_386_GLOB_DAT);
        let g = elf32_section(img, ".got.plt").2 as i64;
        assert_eq!(foo, g + 12, "{pic}: the first slot past the loader's");
        let (plt_addr, plt) = (elf32_section(img, ".plt").2 as i64, elf32_body(img, ".plt"));
        assert_eq!(plt, i386_lazy_plt(pic, plt_addr, g, foo), "{pic}");
        assert_eq!(i32_at(elf32_body(img, ".got.plt"), 12), plt_addr + 22);
        let (t, text) = (
            elf32_section(img, ".text").2 as i64,
            elf32_body(img, ".text"),
        );
        assert_eq!(
            t + 5 + i32_at(text, 1),
            plt_addr + 16,
            "the call reaches the entry"
        );
        assert_eq!(text[5..7], [0x8b, 0x83], "the load is kept");
        assert_eq!(i32_at(text, 7), bar - g);
        let data = elf32_section(img, ".data").2;
        assert!(
            relocs.contains(&(data, rt::R_386_32, String::from("bar"))),
            "{relocs:?}"
        );
        let [start] = i386_addrs(img, ["_start"]);
        if pic {
            assert!(relocs.contains(&(data + 4, rt::R_386_RELATIVE, String::new())));
        } else {
            assert_eq!(u16::from_le_bytes([img[16], img[17]]), ET_EXEC);
            assert!(
                relocs.iter().all(|r| r.1 != rt::R_386_RELATIVE),
                "{relocs:?}"
            );
            assert_eq!(
                i32_at(elf32_body(img, ".data"), 4),
                start,
                "&_start in place"
            );
        }
    }
}

/// A position-dependent x86-64 executable linked against a shared library
/// is an `ET_EXEC` with the dynamic tables, as GNU ld 2.46.1 links one,
/// its PLT entries reaching their slots through `%rip`.
#[test]
fn a_position_dependent_executable_imports_from_a_shared_library() {
    let script = parse_linker_script(&default_script(false)).expect("parses");
    let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
    let opts = LdsOptions {
        emit: LdsEmit::Exec,
        ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])])
    };
    let res = link_with_script(&script, objs, &opts).expect("links");
    let img = &res.image;
    assert_eq!(u16::from_le_bytes([img[16], img[17]]), ET_EXEC);
    let tags = dyn_tags(img);
    assert!(tags.iter().any(|t| t.0 == dynamic::DT_NEEDED), "{tags:?}");
    let (_, relaplt) = image_section(img, ".rela.plt");
    let slot = rela_entries(&relaplt)[0].0;
    let (plt_addr, plt) = image_section(img, ".plt");
    assert_eq!(plt[16..18], [0xff, 0x25]);
    assert_eq!(
        plt_addr as i64 + 22 + u32_at(&plt, 18) as i32 as i64,
        slot as i64
    );
}
/// An i386 shared object the engine links reads back as a library: its
/// machine, its soname, and the objects among its exports.
#[test]
fn an_i386_shared_object_reads_back_as_a_library() {
    // f: ret; .data: d. Symtab: null(0), sections(1, 2), f(3), d(4).
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
        .sym("f", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("d", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .build_class(EM_386, ElfClass::Elf32, false);
    let opts = LdsOptions {
        soname: Some(String::from("libone.so")),
        ..i386_opts(Some(true))
    };
    let res = link_i386_with(alloc::vec![("l.o", o)], &opts).expect("links");
    let lib = crate::c5::linker::object::read_dynamic_image(&res.image).expect("reads");
    assert_eq!((lib.machine, lib.soname.as_str()), (EM_386, "libone.so"));
    assert!(
        ["f", "d"].iter().all(|n| lib.exports.contains(*n)),
        "{lib:?}"
    );
    assert_eq!(lib.data_exports.iter().collect::<Vec<_>>(), ["d"]);
}

/// An i386 unit calling `func`, loading `data`'s address through the GOT
/// and holding `&func` and `&data + 4` in `.data`: `.text` is the call,
/// the load, a return, then `func` at 16; `.data` is `data` and the two
/// pointers. Symtab: null(0), sections(1, 2), func(3), data(4),
/// caller(5).
fn i386_preemption_unit(vis: u8) -> Vec<u8> {
    let mut text = [0u8; 17];
    text[..12].copy_from_slice(&[0xe8, 0, 0, 0, 0, 0x8b, 0x83, 0, 0, 0, 0, 0xc3]);
    text[16] = 0xc3;
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 12])
        .sym("func", STB_GLOBAL, STT_FUNC, 0, 16, 1)
        .vis(vis)
        .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .vis(vis)
        .sym("caller", STB_GLOBAL, STT_FUNC, 0, 0, 12)
        .reloc(0, 1, 3, rt::R_386_PLT32, -4)
        .reloc(0, 7, 4, rt::R_386_GOT32X, 0)
        .reloc(1, 4, 3, rt::R_386_32, 0)
        .reloc(1, 8, 4, rt::R_386_32, 4)
        .build_class(EM_386, ElfClass::Elf32, false)
}

/// GNU ld 2.46.1 links an i386 shared object's references to its own
/// default-visibility definitions as the x86-64 and aarch64 ones, with
/// the PLT reaching its slots through `%ebx` and each `R_386_32` keeping
/// its addend in the field it names, the table being `SHT_REL`. A call
/// goes through a lazy PLT entry whose slot `R_386_JUMP_SLOT` binds, a
/// GOT load keeps a slot `R_386_GLOB_DAT` fills, and each pointer takes
/// an `R_386_32` against its symbol. `-Bsymbolic` binds every reference directly, as does a
/// protected or hidden definition; `-Bsymbolic-functions` the
/// function's.
#[test]
fn an_i386_shared_objects_own_definitions_are_preemptible() {
    for (vis, symbolic) in [
        (STV_DEFAULT, None),
        (STV_DEFAULT, Some(false)),
        (STV_DEFAULT, Some(true)),
        (STV_PROTECTED, None),
        (STV_HIDDEN, None),
    ] {
        let what = alloc::format!("vis {vis} {symbolic:?}");
        let opts = LdsOptions {
            symbolic: symbolic == Some(true),
            symbolic_functions: symbolic == Some(false),
            ..i386_opts(Some(true))
        };
        let res = link_i386_with(alloc::vec![("u.o", i386_preemption_unit(vis))], &opts)
            .unwrap_or_else(|e| panic!("{what}: {e}"));
        let img = &res.image;
        let [func, data] = i386_addrs(img, ["func", "data"]);
        let relocs = elf32_dyn_relocs(img);
        let g = elf32_section(img, ".got.plt").2 as i64;
        let (t, text) = (
            elf32_section(img, ".text").2 as i64,
            elf32_body(img, ".text"),
        );
        let d = elf32_body(img, ".data");
        let preempt_func = vis == STV_DEFAULT && symbolic.is_none();
        let preempt_data = vis == STV_DEFAULT && symbolic != Some(true);
        let call = t + 5 + i32_at(text, 1);
        if preempt_func {
            let slot = i386_slot(&relocs, "func", rt::R_386_JUMP_SLOT);
            let plt_addr = elf32_section(img, ".plt").2 as i64;
            let plt = elf32_body(img, ".plt");
            assert_eq!(call, plt_addr + 16, "{what}");
            assert_eq!(plt, i386_lazy_plt(true, plt_addr, g, slot), "{what}");
            assert!(relocs.contains(&(data as u64 + 4, rt::R_386_32, String::from("func"))));
            assert_eq!(i32_at(d, 4), 0, "{what}: the field holds the addend");
        } else {
            assert_eq!(call, func, "{what}");
            assert!(relocs.contains(&(data as u64 + 4, rt::R_386_RELATIVE, String::new())));
            assert_eq!(i32_at(d, 4), func, "{what}");
        }
        if preempt_data {
            let slot = i386_slot(&relocs, "data", rt::R_386_GLOB_DAT);
            assert_eq!((text[5], i32_at(text, 7)), (0x8b, slot - g), "{what}");
            assert!(relocs.contains(&(data as u64 + 8, rt::R_386_32, String::from("data"))));
            assert_eq!(i32_at(d, 8), 4, "{what}: the field holds the addend");
        } else {
            assert_eq!((text[5], i32_at(text, 7)), (0x8d, data - g), "{what}: lea");
            assert!(relocs.contains(&(data as u64 + 8, rt::R_386_RELATIVE, String::new())));
            assert_eq!(i32_at(d, 8), data + 4, "{what}");
        }
    }
}

/// GNU ld 2.46.1 leaves a PC-relative field naming an i386 shared
/// object's preemptible definition to an `R_386_PC32` against it, in a
/// writable section or not, the field keeping its addend, and binds an
/// `R_386_GOTOFF` to the object's own definition.
#[test]
fn an_i386_pc_relative_field_takes_a_dynamic_relocation_and_gotoff_binds_directly() {
    // .text: call func; lea data@GOTOFF(%ebx), %eax. .data: data, then
    // `.long data - .`. Symtab: null(0), sections(1, 2), func(3), data(4).
    let text = [0xe8, 0, 0, 0, 0, 0x8d, 0x83, 0, 0, 0, 0, 0xc3];
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 8])
        .sym("func", STB_GLOBAL, STT_FUNC, 0, 11, 1)
        .sym("data", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .reloc(0, 1, 3, rt::R_386_PC32, -4)
        .reloc(0, 7, 4, rt::R_386_GOTOFF, 0)
        .reloc(1, 4, 4, rt::R_386_PC32, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    let res = link_i386_with(alloc::vec![("u.o", o)], &i386_opts(Some(true))).expect("links");
    let img = &res.image;
    let relocs = elf32_dyn_relocs(img);
    let (t, text) = (elf32_section(img, ".text").2, elf32_body(img, ".text"));
    let [data] = i386_addrs(img, ["data"]);
    assert!(
        relocs.contains(&(t + 1, rt::R_386_PC32, String::from("func"))),
        "{relocs:?}"
    );
    assert_eq!(i32_at(text, 1), -4, "the call keeps its addend");
    assert!(relocs.contains(&(data as u64 + 4, rt::R_386_PC32, String::from("data"))));
    let g = elf32_section(img, ".got.plt").2 as i64;
    assert_eq!(
        i32_at(text, 7),
        data - g,
        "GOTOFF binds the object's own data"
    );
}

/// aarch64 `bl foo` and `ret`, then `&foo` in `.data`. Symtab: null(0),
/// sections(1, 2), _start(3), foo(4).
fn aarch64_pointer_user() -> Vec<u8> {
    let mut text = Vec::new();
    for w in [0x9400_0000u32, 0xd65f_03c0] {
        text.extend_from_slice(&w.to_le_bytes());
    }
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .reloc(0, 0, 4, rt::R_AARCH64_CALL26, 0)
        .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64)
}

/// GNU ld 2.46.1's aarch64 PLT (AAELF64, PLT sequences): a 32-byte
/// header that saves x16 and x30 and branches through `.got.plt[2]`,
/// then per entry `adrp x16`, `ldr x17` of the entry's `.got.plt` slot,
/// `add x16`, `br x17`; each slot holds the header's address until its
/// `JUMP_SLOT` binds it. An executable gives a function whose address a
/// data word holds an entry too; a position-dependent one makes the entry
/// the function's address, which `.dynsym` states and the word holds with
/// no relocation of its own, so the function compares equal across the
/// image and the library.
#[test]
fn an_aarch64_executable_calls_through_a_lazy_plt_and_compares_function_addresses() {
    let script = parse_linker_script(&default_script(false)).expect("parses");
    for emit in [LdsEmit::Dyn, LdsEmit::Exec] {
        let objs = alloc::vec![parse_lds_object("a.o", aarch64_pointer_user()).expect("parses")];
        let mut lib = shared_input("libc.so.6", &["foo"], &[]);
        lib.lib.machine = EM_AARCH64;
        let opts = LdsOptions {
            emit,
            interp: Some(String::from("/lib/ld-linux-aarch64.so.1")),
            shared_libs: alloc::vec![lib],
            max_page_size: 0x10000,
            ..LdsOptions::default()
        };
        let res = link_with_script(&script, objs, &opts).expect("links");
        let img = &res.image;
        let (plt, stubs) = image_section(img, ".plt");
        let (gotplt, slots) = image_section(img, ".got.plt");
        let page = |at: u64, to: u64| {
            let imm = ((to & !0xfff).wrapping_sub(at & !0xfff) as i64 >> 12) as u32 & 0x1f_ffff;
            0x9000_0010 | (imm & 3) << 29 | (imm >> 2) << 5
        };
        let lo = |to: u64| (to & 0xfff) as u32;
        let (slot, entry) = (gotplt + 24, plt + 32);
        let want: Vec<u32> = alloc::vec![
            0xa9bf_7bf0,
            page(plt + 4, gotplt + 16),
            0xf940_0211 | (lo(gotplt + 16) / 8) << 10,
            0x9100_0210 | lo(gotplt + 16) << 10,
            0xd61f_0220,
            0xd503_201f,
            0xd503_201f,
            0xd503_201f,
            page(entry, slot),
            0xf940_0211 | (lo(slot) / 8) << 10,
            0x9100_0210 | lo(slot) << 10,
            0xd61f_0220,
        ];
        let words: Vec<u32> = (0..stubs.len() / 4)
            .map(|k| u32_at(&stubs, 4 * k))
            .collect();
        assert_eq!(words, want, "{emit:?}");
        assert_eq!(u64::from_le_bytes(slots[24..32].try_into().unwrap()), plt);
        let (_, relaplt) = image_section(img, ".rela.plt");
        assert_eq!(
            (rela_entries(&relaplt).iter())
                .map(|e| (e.0, e.2))
                .collect::<Vec<_>>(),
            [(slot, rt::R_AARCH64_JUMP_SLOT)]
        );
        let (data, held) = image_section(img, ".data");
        let foo = image_dynsyms(img)
            .into_iter()
            .find(|s| s.0 == "foo")
            .unwrap();
        let relocs = if section_addr(img, ".rela.dyn").is_some() {
            dyn_relocs(img)
        } else {
            Vec::new()
        };
        let abs = relocs.into_iter().find(|r| r.0 == data);
        if emit == LdsEmit::Exec {
            assert_eq!(
                (foo.1, foo.2),
                (entry, SHN_UNDEF),
                "the entry is foo's address"
            );
            assert_eq!(u64::from_le_bytes(held[..8].try_into().unwrap()), entry);
            assert_eq!(abs, None);
        } else {
            assert_eq!(foo.1, 0);
            assert_eq!(
                abs.map(|r| (r.1, r.2)),
                Some((rt::R_AARCH64_ABS64, String::from("foo")))
            );
        }
    }
}

/// GNU ld 2.46.1 makes a default-visibility undefined weak symbol an
/// executable reaches through the GOT a dynamic symbol, its slot bound by
/// `GLOB_DAT`, so the loader writes 0 or a library's definition; the load
/// is not relaxed.
#[test]
fn an_executable_imports_an_undefined_weak_symbol_it_reaches_through_the_got() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    // mov wk@GOTPCREL(%rip), %rax; ret. Symtab: null(0), section(1),
    // _start(2), wk(3).
    let o = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0x48, 0x8b, 0x05, 0, 0, 0, 0, 0xc3],
        )
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("wk", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 3, 3, rt::R_X86_64_REX_GOTPCRELX, -4)
        .build(EM_X86_64);
    let objs = alloc::vec![parse_lds_object("a.o", o).expect("parses")];
    let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &[])]);
    let res = link_with_script(&script, objs, &opts).expect("links");
    let syms = image_dynsyms(&res.image);
    assert!(
        syms.iter().any(|s| s.0 == "wk" && s.2 == SHN_UNDEF),
        "{syms:?}"
    );
    let (got, _) = image_section(&res.image, ".got");
    let relocs = dyn_relocs(&res.image);
    assert!(
        relocs.contains(&(got, rt::R_X86_64_GLOB_DAT, String::from("wk"), 0)),
        "{relocs:?}"
    );
    let (_, text) = image_section(&res.image, ".text");
    assert_eq!(text[1], 0x8b, "the load is kept");
}

/// x86-64 `mov bar(%rip), %eax` (PC32), `mov $baz, %eax` (32S), `mov
/// $foo, %eax` (32S) and `ret`, then `&bar` in `.data`. Symtab: null(0),
/// sections(1, 2), _start(3), bar(4), baz(5), foo(6).
fn direct_user() -> Vec<u8> {
    let text = [
        0x8b, 0x05, 0, 0, 0, 0, 0xc7, 0xc0, 0, 0, 0, 0, 0xc7, 0xc0, 0, 0, 0, 0, 0xc3,
    ];
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 19)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .sym("baz", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .reloc(0, 2, 4, rt::R_X86_64_PC32, -4)
        .reloc(1, 0, 4, rt::R_X86_64_64, 0)
        .build(EM_X86_64)
}

/// GNU ld 2.46.1 gives an executable a copy of a library object its code
/// reaches by an address the link fixes (System V gABI, `R_*_COPY`): in
/// `.dynbss`, at the largest alignment up to the defining section's that
/// divides the object's offset, or in `.data.rel.ro` for an object the
/// library keeps read-only. `.dynsym` defines the object at its copy,
/// which the loader fills and every reference names; a PIE leaves a data
/// word naming it to a relocation against the symbol, where a
/// position-dependent executable writes the copy's address. A function
/// such code takes the address of has its PLT entry as its address.
#[test]
fn an_executable_reaches_an_imported_object_through_a_copy() {
    for emit in [LdsEmit::Dyn, LdsEmit::Exec] {
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let mut o = parse_lds_object("a.o", direct_user()).expect("parses");
        if emit == LdsEmit::Exec {
            for (at, sym) in [(8, 5), (14, 6)] {
                o.sections[0].relocs.push(RawReloc {
                    offset: at,
                    sym,
                    rtype: rt::R_X86_64_32S,
                    addend: 0,
                });
            }
        }
        let mut lib = shared_input("libc.so.6", &["foo"], &["bar", "baz"]);
        lib.lib
            .copy_layout
            .insert(String::from("bar"), (12, 4, false));
        lib.lib
            .copy_layout
            .insert(String::from("baz"), (4, 4, true));
        let opts = LdsOptions {
            emit,
            ..dynamic_opts(alloc::vec![lib])
        };
        let res = link_with_script(&script, alloc::vec![o], &opts).expect("links");
        let img = &res.image;
        let what = alloc::format!("{emit:?}");
        let syms = image_dynsyms(img);
        let row = |n: &str| syms.iter().find(|s| s.0 == n).cloned().unwrap();
        let bss = section_index(img, ".bss") as u16;
        let bar = row("bar");
        assert_eq!(bar.2, bss, "{what}: bar is defined at its copy");
        let relocs = dyn_relocs(img);
        assert!(
            relocs.contains(&(bar.1, rt::R_X86_64_COPY, String::from("bar"), 0)),
            "{what}: {relocs:?}"
        );
        let (t, text) = image_section(img, ".text");
        assert_eq!(t as i64 + 6 + u32_at(&text, 2) as i32 as i64, bar.1 as i64);
        let (data, word) = image_section(img, ".data");
        if emit == LdsEmit::Dyn {
            assert!(relocs.contains(&(data, rt::R_X86_64_64, String::from("bar"), 0)));
            continue;
        }
        assert_eq!(u64::from_le_bytes(word[..8].try_into().unwrap()), bar.1);
        let baz = row("baz");
        assert_eq!(
            baz.2,
            section_index(img, ".data.rel.ro") as u16,
            "read-only copy"
        );
        assert_eq!(u32_at(&text, 8) as u64, baz.1);
        let foo = row("foo");
        let (plt, _) = image_section(img, ".plt");
        assert_eq!(
            (foo.1, foo.2),
            (plt + 16, SHN_UNDEF),
            "foo's PLT entry is its address"
        );
        assert_eq!(u32_at(&text, 14) as u64, foo.1);
    }
}

/// A library object's copy takes bfd's alignment: the largest power of two
/// up to its section's alignment that divides its offset in the section;
/// one in a read-only section is copied to `.data.rel.ro`.
#[test]
fn a_library_states_the_layout_a_copy_of_its_object_takes() {
    // .data (align 32): a at 0, b at 8, c at 0x20; .rodata: r.
    // Symtab: null(0), sections(1, 2), a(3), b(4), c(5), r(6).
    let o = TestObj::new()
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 32, &[0; 0x28])
        .sec(".rodata", SHT_PROGBITS, SHF_ALLOC, 4, &[0; 4])
        .sym("a", STB_GLOBAL, STT_OBJECT, 0, 0, 4)
        .sym("b", STB_GLOBAL, STT_OBJECT, 0, 8, 4)
        .sym("c", STB_GLOBAL, STT_OBJECT, 0, 0x20, 8)
        .sym("r", STB_GLOBAL, STT_OBJECT, 1, 0, 4)
        .build(EM_X86_64);
    let script = parse_linker_script(SHARED_SCRIPT).expect("script parses");
    let objs = alloc::vec![parse_lds_object("l.o", o).expect("parses")];
    let res = link_with_script(&script, objs, &shared_opts(EM_X86_64)).expect("links");
    let lib = crate::c5::linker::object::read_dynamic_image(&res.image).expect("reads");
    let layout: Vec<(&str, (u64, u64, bool))> = (lib.copy_layout.iter())
        .map(|(n, l)| (n.as_str(), *l))
        .collect();
    assert_eq!(
        layout,
        [
            ("a", (4, 32, false)),
            ("b", (4, 8, false)),
            ("c", (8, 32, false)),
            ("r", (4, 4, true)),
        ]
    );
}

/// GNU ld 2.46.1 writes an i386 `R_386_16` naming a load address with the
/// link-time value in a position-independent link too, taking no dynamic
/// relocation, and reports an `R_386_8` or `R_386_16` the value does not
/// fit as truncated, as in any other link.
#[test]
fn an_i386_narrow_field_takes_the_link_time_value_in_a_position_independent_link() {
    // .data: d, then `.word d`, `.word d + 2`, and `.byte d` where `byte`.
    // Symtab: null(0), section(1), d(2).
    let unit = |byte: bool| {
        let o = TestObj::new()
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 9])
            .sym("d", STB_GLOBAL, STT_OBJECT, 0, 0, 4)
            .reloc(0, 4, 2, rt::R_386_16, 0)
            .reloc(0, 6, 2, rt::R_386_16, 2);
        if byte {
            o.reloc(0, 8, 2, rt::R_386_8, 0)
        } else {
            o
        }
        .build_class(EM_386, ElfClass::Elf32, false)
    };
    for pic in [Some(true), Some(false)] {
        let res = link_i386_with(alloc::vec![("n.o", unit(false))], &i386_opts(pic))
            .unwrap_or_else(|e| panic!("{pic:?}: {e}"));
        let img = &res.image;
        let [d] = i386_addrs(img, ["d"]);
        let data = elf32_body(img, ".data");
        let half = |at: usize| u16::from_le_bytes([data[at], data[at + 1]]) as i64;
        assert_eq!((half(4), half(6)), (d, d + 2), "{pic:?}");
        assert!(elf32_dyn_relocs(img).is_empty(), "{pic:?}");
        let e = link_i386_with(alloc::vec![("n.o", unit(true))], &i386_opts(pic))
            .expect_err("does not fit");
        assert!(
            alloc::format!("{e}").contains("relocation truncated"),
            "{e}"
        );
    }
}

/// `.text` with `_start`, and section `name` holding `foo - .` and, on
/// x86-64, `foo`; `foo` is undefined.
fn pc_word_user(machine: u16, name: &str, flags: u64) -> Vec<u8> {
    // Symtab: null(0), sections(1, 2), _start(3), foo(4).
    let o = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3],
        )
        .sec(name, SHT_PROGBITS, flags, 8, &[0; 16])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0);
    if machine == EM_386 {
        return (o.reloc(1, 0, 4, rt::R_386_PC32, 0)).build_class(EM_386, ElfClass::Elf32, false);
    }
    (o.reloc(1, 0, 4, rt::R_X86_64_PC32, 0))
        .reloc(1, 8, 4, rt::R_X86_64_64, 0)
        .build(EM_X86_64)
}

/// A PC-relative word naming a library's function in an x86-64 PIE's data
/// makes the function's PLT entry its address, as GNU ld 2.46.1 links it,
/// so it compares equal to the library's own; an address-width word keeps
/// its relocation against the symbol. A shared object leaves both to
/// relocations naming the function and takes no PLT entry for them; a PIE
/// or shared object's word in read-only data is refused.
#[test]
fn an_x86_64_pie_s_pc_relative_word_makes_a_library_function_s_plt_entry_its_address() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let rw = SHF_ALLOC | SHF_WRITE;
    let link = |name: &str, flags: u64, shared: bool| {
        let o = parse_lds_object("a.o", pc_word_user(EM_X86_64, name, flags)).expect("parses");
        let opts = LdsOptions {
            shared,
            interp: (!shared).then(|| String::from("/lib64/ld-linux-x86-64.so.2")),
            ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &[])])
        };
        link_with_script(&script, alloc::vec![o], &opts)
    };
    let img = link(".data", rw, false).expect("links").image;
    let foo = image_dynsyms(&img).into_iter().find(|s| s.0 == "foo");
    let (plt, _) = image_section(&img, ".plt");
    assert_eq!(foo.map(|s| (s.1, s.2)), Some((plt + 16, SHN_UNDEF)));
    let (data, word) = image_section(&img, ".data");
    assert_eq!(
        data as i64 + u32_at(&word, 0) as i32 as i64,
        plt as i64 + 16
    );
    let relocs = dyn_relocs(&img);
    assert!(
        relocs.contains(&(data + 8, rt::R_X86_64_64, String::from("foo"), 0)),
        "{relocs:?}"
    );
    assert!(
        relocs.iter().all(|r| r.1 != rt::R_X86_64_PC32),
        "{relocs:?}"
    );
    let img = link(".data", rw, true).expect("links").image;
    let (data, _) = image_section(&img, ".data");
    let relocs = dyn_relocs(&img);
    assert!(
        relocs.contains(&(data, rt::R_X86_64_PC32, String::from("foo"), 0)),
        "{relocs:?}"
    );
    assert!(section_addr(&img, ".rela.plt").is_none(), "no PLT entry");
    for shared in [false, true] {
        let e = link(".rodata", SHF_ALLOC, shared).expect_err("refused");
        assert!(
            alloc::format!("{e}").contains("R_X86_64_PC32 (2) against `foo'"),
            "{e}"
        );
    }
}

/// An i386 PC-relative word naming a library's function takes an
/// `R_386_PC32` naming it in a PIE and a shared object, as GNU ld 2.46.1
/// links it, the field holding the addend; a position-dependent
/// executable makes the function's PLT entry its address.
#[test]
fn an_i386_pc_relative_word_naming_a_library_function_takes_a_relocation_naming_it() {
    for pic in [Some(false), Some(true), None] {
        let mut lib = shared_input("libone.so", &["foo"], &[]);
        lib.lib.machine = EM_386;
        let opts = LdsOptions {
            shared_libs: alloc::vec![lib],
            interp: (pic != Some(true)).then(|| String::from("/lib/ld-linux.so.2")),
            ..i386_opts(pic)
        };
        let unit = pc_word_user(EM_386, ".data", SHF_ALLOC | SHF_WRITE);
        let res = link_i386_with(alloc::vec![("u.o", unit)], &opts).expect("links");
        let img = &res.image;
        let data = elf32_section(img, ".data").2;
        let relocs = elf32_dyn_relocs(img);
        let foo = elf32_symbols_of(img, ".dynsym", ".dynstr")
            .into_iter()
            .find(|s| s.0 == "foo");
        let field = i32_at(elf32_body(img, ".data"), 0);
        if pic.is_some() {
            let want = (data, rt::R_386_PC32, String::from("foo"));
            assert!(relocs.contains(&want), "{pic:?}: {relocs:?}");
            assert_eq!((foo.map(|s| s.1), field), (Some(0), 0), "{pic:?}");
            continue;
        }
        let plt = elf32_section(img, ".plt").2;
        assert_eq!(
            foo.map(|s| s.1),
            Some(plt + 16),
            "the PLT entry is foo's address"
        );
        assert_eq!(data as i64 + field, plt as i64 + 16);
        assert!(relocs.iter().all(|r| r.1 != rt::R_386_PC32), "{relocs:?}");
    }
}

/// `.init` with `_init`, `.fini` with `_fini` and `myfini`, an entry each
/// in `.init_array` and `.fini_array`, and one in `.preinit_array` where
/// `pre`; `_start` calls the import `foo`.
fn init_fini_user(pre: bool) -> Vec<u8> {
    let sections = 5 + pre as u32;
    let o = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xe8, 0, 0, 0, 0, 0xc3],
        )
        .sec(".init", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &[0xc3])
        .sec(
            ".fini",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc3, 0xc3],
        )
        .sec(
            ".init_array",
            SHT_INIT_ARRAY,
            SHF_ALLOC | SHF_WRITE,
            8,
            &[0; 8],
        )
        .sec(
            ".fini_array",
            SHT_FINI_ARRAY,
            SHF_ALLOC | SHF_WRITE,
            8,
            &[0; 8],
        );
    let o = if pre {
        o.sec(
            ".preinit_array",
            SHT_PREINIT_ARRAY,
            SHF_ALLOC | SHF_WRITE,
            8,
            &[0; 8],
        )
    } else {
        o
    };
    // Symtab: null(0), sections(1..=sections), then these in order.
    (o.sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 6))
        .sym("_init", STB_GLOBAL, STT_FUNC, 1, 0, 1)
        .sym("_fini", STB_GLOBAL, STT_FUNC, 2, 0, 1)
        .sym("myfini", STB_GLOBAL, STT_FUNC, 2, 1, 1)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .reloc(0, 1, sections + 5, rt::R_X86_64_PLT32, -4)
        .build(EM_X86_64)
}

/// `.dynamic` names the `-init` and `-fini` functions the link defines in
/// `DT_INIT` and `DT_FINI` and the arrays after them, ahead of the symbol
/// tables, and `DT_SYMBOLIC` before the search path, in GNU ld 2.46.1's
/// order; a shared object refuses `.preinit_array` input, as the gABI
/// gives `DT_PREINIT_ARRAY` to an executable alone.
#[test]
fn dynamic_tags_name_the_init_and_fini_functions_ahead_of_the_arrays() {
    use dynamic::{
        DT_FINI, DT_FINI_ARRAY, DT_FINI_ARRAYSZ, DT_GNU_HASH, DT_HASH, DT_INIT, DT_INIT_ARRAY,
        DT_INIT_ARRAYSZ, DT_NEEDED, DT_PREINIT_ARRAY, DT_PREINIT_ARRAYSZ, DT_RUNPATH, DT_SONAME,
        DT_SYMBOLIC,
    };
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let link = |pre: bool, opts: LdsOptions| {
        let o = parse_lds_object("a.o", init_fini_user(pre)).expect("parses");
        let libs = alloc::vec![shared_input("libc.so.6", &["foo"], &[])];
        let opts = LdsOptions {
            shared_libs: libs,
            ..opts
        };
        link_with_script(&script, alloc::vec![o], &opts)
    };
    // The tags ahead of the hash tables, with their values.
    let head = |img: &[u8]| -> Vec<(u64, u64)> {
        (dyn_tags(img).into_iter())
            .take_while(|t| t.0 != DT_HASH && t.0 != DT_GNU_HASH)
            .collect()
    };
    let arrays = |img: &[u8]| {
        let (init, fini) = (
            section_addr(img, ".init_array"),
            section_addr(img, ".fini_array"),
        );
        [
            (DT_INIT_ARRAY, init.unwrap()),
            (DT_INIT_ARRAYSZ, 8),
            (DT_FINI_ARRAY, fini.unwrap()),
            (DT_FINI_ARRAYSZ, 8),
        ]
    };
    let img = link(true, dynamic_opts(Vec::new())).expect("links").image;
    let (init, fini) = (section_addr(&img, ".init"), section_addr(&img, ".fini"));
    let pre = section_addr(&img, ".preinit_array").unwrap();
    let mut want = alloc::vec![
        (DT_NEEDED, head(&img)[0].1),
        (DT_INIT, init.unwrap()),
        (DT_FINI, fini.unwrap()),
        (DT_PREINIT_ARRAY, pre),
        (DT_PREINIT_ARRAYSZ, 8),
    ];
    want.extend(arrays(&img));
    assert_eq!(head(&img), want);
    let shared = LdsOptions {
        shared: true,
        interp: None,
        soname: Some(String::from("libx.so")),
        symbolic: true,
        rpath: alloc::vec![String::from("/opt/x")],
        new_dtags: true,
        fini_function: String::from("myfini"),
        ..dynamic_opts(Vec::new())
    };
    let img = link(false, shared.clone()).expect("links").image;
    let h = head(&img);
    let tags: Vec<u64> = h.iter().map(|t| t.0).collect();
    assert_eq!(
        tags[..6],
        [
            DT_NEEDED,
            DT_SONAME,
            DT_SYMBOLIC,
            DT_RUNPATH,
            DT_INIT,
            DT_FINI
        ]
    );
    assert_eq!(h[5].1, section_addr(&img, ".fini").unwrap() + 1, "myfini");
    assert_eq!(h[6..], arrays(&img));
    let none = LdsOptions {
        init_function: String::from("nosuch"),
        ..shared.clone()
    };
    let img = link(false, none).expect("links").image;
    assert!(
        head(&img).iter().all(|t| t.0 != DT_INIT),
        "no DT_INIT for nosuch"
    );
    let e = link(true, shared).expect_err("refused");
    assert!(
        alloc::format!("{e}").contains("a.o: .preinit_array section is not allowed in DSO"),
        "{e}"
    );
}

/// The symbol table lists each import as `.dynsym` does: undefined, with
/// the type the library gives it and the binding of the references, as
/// GNU ld 2.46.1 lists them.
#[test]
fn the_symbol_table_lists_the_imports() {
    let body = [
        0xe8, 0, 0, 0, 0, // call foo
        0x48, 0x8b, 0x05, 0, 0, 0, 0, // mov bar@GOTPCREL(%rip), %rax
        0x48, 0x8b, 0x05, 0, 0, 0, 0, // mov wk@GOTPCREL(%rip), %rax
        0xc3,
    ];
    // Symtab: null(0), section(1), _start(2), foo(3), bar(4), wk(5).
    let unit = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &body)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 20)
        .sym("foo", STB_GLOBAL, STT_FUNC, usize::MAX, 0, 0)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .sym("wk", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 1, 3, rt::R_X86_64_PLT32, -4)
        .reloc(0, 8, 4, rt::R_X86_64_REX_GOTPCRELX, -4)
        .reloc(0, 15, 5, rt::R_X86_64_REX_GOTPCRELX, -4)
        .build(EM_X86_64);
    for emit in [LdsEmit::Dyn, LdsEmit::Exec] {
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let o = parse_lds_object("a.o", unit.clone()).expect("parses");
        let opts = LdsOptions {
            emit,
            ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])])
        };
        let img = link_with_script(&script, alloc::vec![o], &opts)
            .expect("links")
            .image;
        let mut und: Vec<(String, u8)> = (image_sym_rows(&img).into_iter())
            .filter(|s| s.2 == SHN_UNDEF && !s.0.is_empty())
            .map(|s| (s.0, s.1))
            .collect();
        und.sort();
        let row = |n: &str, bind: u8, kind: u8| (String::from(n), (bind << 4) | kind);
        assert_eq!(
            und,
            [
                row("bar", STB_GLOBAL, STT_OBJECT),
                row("foo", STB_GLOBAL, STT_FUNC),
                row("wk", STB_WEAK, STT_NOTYPE),
            ],
            "{emit:?}"
        );
    }
}

/// An archive's symbol index lists what GNU ar 2.46.1 lists for an ELF
/// object of either class: global, weak and GNU-unique definitions in a
/// section, commons and absolute symbols, in table order; not locals or
/// undefined names.
#[test]
fn the_archive_index_lists_an_elf_objects_definitions_in_either_class() {
    for class in [ElfClass::Elf64, ElfClass::Elf32] {
        let o = TestObj::new()
            .sec(
                ".text",
                SHT_PROGBITS,
                SHF_ALLOC | SHF_EXECINSTR,
                4,
                &[0xc3; 4],
            )
            .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
            .sym("l", STB_LOCAL, STT_FUNC, 0, 0, 1)
            .sym("g", STB_GLOBAL, STT_FUNC, 0, 1, 1)
            .sym("w", STB_WEAK, STT_FUNC, 0, 2, 1)
            .sym("u", 10, STT_OBJECT, 1, 0, 4)
            .sym("c", STB_GLOBAL, STT_OBJECT, usize::MAX - 2, 8, 8)
            .sym("a", STB_GLOBAL, STT_NOTYPE, usize::MAX - 1, 0x1234, 0)
            .sym("undef", STB_GLOBAL, STT_NOTYPE, usize::MAX, 0, 0)
            .sym("wundef", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0);
        let wide = class == ElfClass::Elf64;
        let bytes = o.build_class(if wide { EM_X86_64 } else { EM_386 }, class, wide);
        let names = crate::c5::linker::archive::elf_archive_symbols(&bytes).expect("reads");
        assert_eq!(names, ["g", "w", "u", "c", "a"], "{class:?}");
    }
}

/// `_start` calling `wf`, an undefined weak name, through `call wf@PLT`;
/// where `addressed`, `movl $wf, %eax` takes its address first.
fn weak_caller(addressed: bool) -> Vec<u8> {
    let body = [0xb8, 0, 0, 0, 0, 0xe8, 0, 0, 0, 0, 0xc3];
    // Symtab: null(0), section(1), _start(2), wf(3).
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &body)
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 11)
        .sym("wf", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 6, 3, rt::R_X86_64_PLT32, -4);
    if addressed {
        o.reloc(0, 1, 3, rt::R_X86_64_32, 0)
    } else {
        o
    }
    .build(EM_X86_64)
}

/// An executable linked against a library calls an undefined weak name
/// through a PLT entry its `JUMP_SLOT` binds, the name a weak undefined
/// `.dynsym` row, so that a library the loader finds can define it; one
/// its code also addresses directly resolves to 0, call and all. A shared
/// object linked against no library imports it the same way. GNU ld
/// 2.46.1 links each so on x86-64.
#[test]
fn an_undefined_weak_function_an_executable_calls_takes_a_plt_entry() {
    let link = |emit: LdsEmit, shared: bool, addressed: bool| {
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let o = parse_lds_object("a.o", weak_caller(addressed)).expect("parses");
        let libs = if shared {
            Vec::new()
        } else {
            alloc::vec![shared_input("libc.so.6", &["foo"], &[])]
        };
        let opts = LdsOptions {
            emit,
            shared,
            interp: (!shared).then(|| String::from("/lib64/ld-linux-x86-64.so.2")),
            ..dynamic_opts(libs)
        };
        link_with_script(&script, alloc::vec![o], &opts)
            .expect("links")
            .image
    };
    for (emit, shared) in [
        (LdsEmit::Dyn, false),
        (LdsEmit::Exec, false),
        (LdsEmit::Dyn, true),
    ] {
        let what = alloc::format!("{emit:?} shared={shared}");
        let img = link(emit, shared, false);
        let wf = dynsym_entries(&img).into_iter().find(|s| s.0 == "wf");
        assert_eq!(
            wf.map(|s| s.1),
            Some((STB_WEAK << 4) | STT_NOTYPE),
            "{what}"
        );
        let (plt, _) = image_section(&img, ".plt");
        let (t, text) = image_section(&img, ".text");
        assert_eq!(
            t as i64 + 10 + u32_at(&text, 6) as i32 as i64,
            plt as i64 + 16,
            "{what}"
        );
        let (_, rela) = image_section(&img, ".rela.plt");
        let slots = rela_entries(&rela);
        assert_eq!(slots.len(), 1, "{what}");
        assert_eq!(slots[0].2, rt::R_X86_64_JUMP_SLOT, "{what}");
    }
    let img = link(LdsEmit::Exec, false, true);
    assert!(dynsym_entries(&img).iter().all(|s| s.0 != "wf"));
    let (t, text) = image_section(&img, ".text");
    assert_eq!(u32_at(&text, 1), 0, "the address is 0");
    assert_eq!(
        t as i64 + 10 + u32_at(&text, 6) as i32 as i64,
        0,
        "the call reaches 0"
    );
}

/// An aarch64 PIE linked against a library exports an undefined weak name
/// a data word holds, which takes an `R_AARCH64_ABS64` naming it; a
/// position-dependent executable writes 0 with no relocation, as GNU ld
/// 2.46.1 links them.
#[test]
fn an_aarch64_pie_exports_an_undefined_weak_name_a_data_word_holds() {
    // Symtab: null(0), sections(1, 2), _start(3), wf(4).
    let unit = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            4,
            &[0xc0, 0x03, 0x5f, 0xd6],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .sym("wf", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(1, 0, 4, rt::R_AARCH64_ABS64, 0)
        .build(EM_AARCH64);
    for emit in [LdsEmit::Dyn, LdsEmit::Exec] {
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let o = parse_lds_object("a.o", unit.clone()).expect("parses");
        let mut lib = shared_input("libc.so.6", &["foo"], &[]);
        lib.lib.machine = EM_AARCH64;
        let opts = LdsOptions {
            emit,
            interp: Some(String::from("/lib/ld-linux-aarch64.so.1")),
            max_page_size: 0x10000,
            ..dynamic_opts(alloc::vec![lib])
        };
        let img = link_with_script(&script, alloc::vec![o], &opts)
            .expect("links")
            .image;
        let (data, word) = image_section(&img, ".data");
        let relocs = match section_addr(&img, ".rela.dyn") {
            Some(_) => dyn_relocs(&img),
            None => Vec::new(),
        };
        if emit == LdsEmit::Dyn {
            let want = (data, rt::R_AARCH64_ABS64, String::from("wf"), 0);
            assert!(relocs.contains(&want), "{relocs:?}");
        } else {
            assert!(relocs.iter().all(|r| r.0 != data), "{relocs:?}");
            assert_eq!(u64::from_le_bytes(word[..8].try_into().unwrap()), 0);
        }
    }
}

/// `.data` holding `bar - .` in a field of `rtype`; where `code`, `.text`
/// also loads `bar` PC-relative, a reference that needs the object at a
/// fixed address.
fn pc_word_data_user(rtype: u32, code: bool) -> Vec<u8> {
    let text = [0x8b, 0x05, 0, 0, 0, 0, 0xc3];
    // Symtab: null(0), sections(1, 2), _start(3), bar(4).
    let o = TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 7)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .reloc(1, 0, 4, rtype, 0);
    if code {
        o.reloc(0, 2, 4, rt::R_X86_64_PC32, -4)
    } else {
        o
    }
    .build(EM_X86_64)
}

/// An executable whose only references to a library's data object are
/// address-width PC-relative words in writable data leaves each to a
/// relocation of its type naming the object and takes no copy, as GNU ld
/// 2.46.1 links them. One that code also reaches at a fixed address
/// copies the object and binds the word to the copy, and so does a
/// narrower `R_X86_64_PC32` word, which the loader could not fill with a
/// library's address more than 2 GiB away.
#[test]
fn a_writable_pc_relative_word_takes_a_dynamic_relocation_rather_than_a_copy() {
    for emit in [LdsEmit::Dyn, LdsEmit::Exec] {
        for (rtype, code) in [
            (rt::R_X86_64_PC64, false),
            (rt::R_X86_64_PC64, true),
            (rt::R_X86_64_PC32, false),
        ] {
            let what = alloc::format!("{emit:?} {rtype} code={code}");
            let script =
                parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
            let o = parse_lds_object("a.o", pc_word_data_user(rtype, code)).expect("parses");
            let opts = LdsOptions {
                emit,
                ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &[], &["bar"])])
            };
            let img = link_with_script(&script, alloc::vec![o], &opts)
                .expect("links")
                .image;
            let (data, word) = image_section(&img, ".data");
            let relocs = dyn_relocs(&img);
            let dynamic = (data, rtype, String::from("bar"), 0);
            if rtype == rt::R_X86_64_PC64 && !code {
                assert!(relocs.contains(&dynamic), "{what}: {relocs:?}");
                assert!(section_addr(&img, ".dynbss").is_none(), "{what}: no copy");
                continue;
            }
            let bar = (image_dynsyms(&img).into_iter())
                .find(|s| s.0 == "bar")
                .unwrap();
            assert!(!relocs.contains(&dynamic), "{what}: {relocs:?}");
            assert!(relocs.contains(&(bar.1, rt::R_X86_64_COPY, String::from("bar"), 0)));
            assert_eq!(
                data as i64 + u32_at(&word, 0) as i32 as i64,
                bar.1 as i64,
                "{what}"
            );
        }
    }
}

/// An i386 executable leaves a writable `R_386_PC32` word naming a
/// library's data object to a relocation naming it, with no copy, as GNU
/// ld 2.46.1 links one.
#[test]
fn an_i386_writable_pc_relative_word_takes_a_dynamic_relocation_rather_than_a_copy() {
    // Symtab: null(0), sections(1, 2), _start(3), bar(4).
    let unit = TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0xc3],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 1)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .reloc(1, 0, 4, rt::R_386_PC32, 0)
        .build_class(EM_386, ElfClass::Elf32, false);
    for pic in [Some(false), None] {
        let mut lib = shared_input("libone.so", &[], &["bar"]);
        lib.lib.machine = EM_386;
        let opts = LdsOptions {
            shared_libs: alloc::vec![lib],
            interp: Some(String::from("/lib/ld-linux.so.2")),
            ..i386_opts(pic)
        };
        let res = link_i386_with(alloc::vec![("u.o", unit.clone())], &opts).expect("links");
        let data = elf32_section(&res.image, ".data").2;
        let relocs = elf32_dyn_relocs(&res.image);
        let want = (data, rt::R_386_PC32, String::from("bar"));
        assert!(relocs.contains(&want), "{pic:?}: {relocs:?}");
        assert!(relocs.iter().all(|r| r.1 != rt::R_386_COPY), "{pic:?}");
    }
}

/// `_start` and an absolute field of `rtype` naming the library object
/// `bar`, in `.data` where `writable` and in `.text` otherwise.
fn narrow_import_user(machine: u16, rtype: u32, writable: bool) -> Vec<u8> {
    let field = if writable { 1 } else { 0 };
    // Symtab: null(0), sections(1, 2), _start(3), bar(4).
    TestObj::new()
        .sec(
            ".text",
            SHT_PROGBITS,
            SHF_ALLOC | SHF_EXECINSTR,
            16,
            &[0; 8],
        )
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 8, &[0; 8])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 4)
        .sym("bar", STB_GLOBAL, STT_OBJECT, usize::MAX, 0, 0)
        .reloc(field, 4, 4, rtype, 0)
        .build(machine)
}

/// An absolute field narrower than an address cannot hold a library
/// object's address in a PIE, and a position-dependent x86-64
/// executable's writable data takes no copy for one, so GNU ld 2.46.1
/// refuses both; a position-dependent executable's code reaches the
/// object through a copy.
#[test]
fn a_narrow_absolute_field_naming_a_library_object_is_refused_where_gnu_ld_refuses_it() {
    for (machine, rtype) in [
        (EM_X86_64, rt::R_X86_64_32),
        (EM_X86_64, rt::R_X86_64_32S),
        (EM_AARCH64, rt::R_AARCH64_ABS32),
    ] {
        for (emit, writable, refused) in [
            (
                LdsEmit::Dyn,
                false,
                Some("a position-independent executable"),
            ),
            (
                LdsEmit::Dyn,
                true,
                Some("a position-independent executable"),
            ),
            (
                LdsEmit::Exec,
                true,
                (machine == EM_X86_64).then_some("a position-dependent executable"),
            ),
            (LdsEmit::Exec, false, None),
        ] {
            let what = alloc::format!("{machine} {rtype} {emit:?} writable={writable}");
            let script =
                parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
            let unit = narrow_import_user(machine, rtype, writable);
            let o = parse_lds_object("a.o", unit).expect("parses");
            let mut lib = shared_input("libc.so.6", &[], &["bar"]);
            lib.lib.machine = machine;
            let opts = LdsOptions {
                emit,
                max_page_size: 0x10000,
                ..dynamic_opts(alloc::vec![lib])
            };
            let res = link_with_script(&script, alloc::vec![o], &opts);
            match refused {
                Some(kind) => {
                    let e = alloc::format!("{}", res.expect_err("refused"));
                    let want =
                        alloc::format!("against symbol `bar` can not be used when making {kind}");
                    assert!(e.contains(&want), "{what}: {e}");
                }
                None => {
                    let img = res.unwrap_or_else(|e| panic!("{what}: {e}")).image;
                    let copy = match machine {
                        EM_AARCH64 => rt::R_AARCH64_COPY,
                        _ => rt::R_X86_64_COPY,
                    };
                    assert!(
                        dyn_relocs(&img).iter().any(|r| r.1 == copy),
                        "{what}: a copy"
                    );
                }
            }
        }
    }
}

/// `_start` taking the address of the undefined weak name `wf` PC-relative
/// (`lea wf(%rip), %rax`), and `.data` holding `wf - .`.
fn weak_pc_user() -> Vec<u8> {
    let text = [0x48, 0x8d, 0x05, 0, 0, 0, 0, 0xc3];
    // Symtab: null(0), sections(1, 2), _start(3), wf(4).
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 16, &text)
        .sec(".data", SHT_PROGBITS, SHF_ALLOC | SHF_WRITE, 4, &[0; 4])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 8)
        .sym("wf", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 3, 4, rt::R_X86_64_PC32, -4)
        .reloc(1, 0, 4, rt::R_X86_64_PC32, 0)
        .build(EM_X86_64)
}

/// An x86-64 PIE's PC-relative reference in code to an undefined weak name
/// would yield the load base rather than 0, so GNU ld 2.46.1 refuses it,
/// with or without libraries; a position-dependent executable resolves it
/// to 0.
#[test]
fn a_pies_pc_relative_reference_in_code_to_an_undefined_weak_name_is_refused() {
    for (emit, libs) in [
        (LdsEmit::Dyn, false),
        (LdsEmit::Dyn, true),
        (LdsEmit::Exec, true),
    ] {
        let what = alloc::format!("{emit:?} libs={libs}");
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let o = parse_lds_object("a.o", weak_pc_user()).expect("parses");
        let opts = match libs {
            true => LdsOptions {
                emit,
                ..dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &[])])
            },
            false => LdsOptions {
                emit,
                ..LdsOptions::default()
            },
        };
        let res = link_with_script(&script, alloc::vec![o], &opts);
        if emit == LdsEmit::Exec {
            let img = res.unwrap_or_else(|e| panic!("{what}: {e}")).image;
            let (t, text) = image_section(&img, ".text");
            assert_eq!(t as i64 + 7 + u32_at(&text, 3) as i32 as i64, 0, "{what}");
            continue;
        }
        let e = alloc::format!("{}", res.expect_err("refused"));
        let want = "a.o(.text+0x3): R_X86_64_PC32 (2) against undefined symbol `wf` can not be \
                    used when making a position-independent executable";
        assert!(e.contains(want), "{what}: {e}");
        assert!(!e.contains(".data"), "{what}: the data word links: {e}");
    }
}

/// aarch64 code and data reaching the undefined weak name `wf`
/// PC-relative: `adr`, `adrp` + `add`, and `.word wf - .`.
fn aarch64_weak_pc_user() -> Vec<u8> {
    let text: Vec<u8> = [0x1000_0000u32, 0x9000_0000, 0x9100_0000, 0xd65f_03c0]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
    // Symtab: null(0), sections(1, 2), _start(3), wf(4).
    TestObj::new()
        .sec(".text", SHT_PROGBITS, SHF_ALLOC | SHF_EXECINSTR, 4, &text)
        .sec(".rodata", SHT_PROGBITS, SHF_ALLOC, 4, &[0xff; 4])
        .sym("_start", STB_GLOBAL, STT_FUNC, 0, 0, 16)
        .sym("wf", STB_WEAK, STT_NOTYPE, usize::MAX, 0, 0)
        .reloc(0, 0, 4, rt::R_AARCH64_ADR_PREL_LO21, 0)
        .reloc(0, 4, 4, rt::R_AARCH64_ADR_PREL_PG_HI21, 0)
        .reloc(0, 8, 4, rt::R_AARCH64_ADD_ABS_LO12_NC, 0)
        .reloc(1, 0, 4, rt::R_AARCH64_PREL32, 0)
        .build(EM_AARCH64)
}

/// GNU ld 2.46.1 resolves an aarch64 PC-relative field naming an undefined
/// weak name as if the name were at the field, the page of it for `adrp`,
/// so each field holds 0, in a position-dependent executable and a PIE
/// linked against no library; a dynamically linked PIE refuses one for a
/// name a library may bind.
#[test]
fn an_aarch64_pc_relative_field_naming_an_undefined_weak_name_holds_0() {
    for (emit, libs) in [
        (LdsEmit::Exec, false),
        (LdsEmit::Dyn, false),
        (LdsEmit::Dyn, true),
    ] {
        let what = alloc::format!("{emit:?} libs={libs}");
        let script = parse_linker_script(&default_script(emit == LdsEmit::Dyn)).expect("parses");
        let o = parse_lds_object("a.o", aarch64_weak_pc_user()).expect("parses");
        let mut opts = LdsOptions {
            emit,
            max_page_size: 0x10000,
            ..LdsOptions::default()
        };
        if libs {
            let mut lib = shared_input("libc.so.6", &["foo"], &[]);
            lib.lib.machine = EM_AARCH64;
            opts.shared_libs = alloc::vec![lib];
            opts.interp = Some(String::from("/lib/ld-linux-aarch64.so.1"));
        }
        let res = link_with_script(&script, alloc::vec![o], &opts);
        if libs {
            let e = alloc::format!("{}", res.expect_err("refused"));
            assert!(e.contains("R_AARCH64_ADR_PREL_LO21"), "{what}: {e}");
            assert!(e.contains("R_AARCH64_PREL32"), "{what}: {e}");
            continue;
        }
        let img = res.unwrap_or_else(|e| panic!("{what}: {e}")).image;
        let (_, text) = image_section(&img, ".text");
        assert_eq!(u32_at(&text, 0), 0x1000_0000, "{what}: adr x0, .");
        assert_eq!(
            u32_at(&text, 4),
            0x9000_0000,
            "{what}: adrp x0, the page of ."
        );
        let (_, data) = image_section(&img, ".rodata");
        assert_eq!(u32_at(&data, 0), 0, "{what}");
    }
}
