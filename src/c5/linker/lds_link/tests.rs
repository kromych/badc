use super::dynamic_sections::encode_relr;
use super::inputs::{RawReloc, strz};
use super::synth::sha1;
use super::*;
use crate::c5::linker::default_script::default_script;
use crate::c5::linker::lds::parse_linker_script;
use crate::c5::linker::object::NativeMachine;
use crate::c5::linker::object::{Elf32Shdr, Elf64Shdr, read_struct};
use crate::c5::linker::{comdat, dynamic, eh_frame};
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

/// `--emit-relocs`: every applied relocation reappears as a
/// `.rela.<outsec>` entry whose `r_offset` is the final address and
/// from which `S + A` reconstructs. This is what
/// `arch/x86/tools/relocs` reads to build the KASLR table.
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
/// script symbol's own visibility. The kernel script bounds its
/// tables this way.
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

/// The `tramp_alias` sequence linked through a script: each half takes
/// its own 16-bit group of the target's final address. Words checked
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

#[test]
fn relr_encoding_round_trips() {
    let addrs = [0x1000u64, 0x1008, 0x1010, 0x1400, 0x1408 + 63 * 8];
    let words = encode_relr(&addrs, 8);
    let mut got: Vec<u64> = Vec::new();
    let mut base = 0u64;
    for w in words {
        if w & 1 == 0 {
            got.push(w);
            base = w + 8;
        } else {
            let mut r = w >> 1;
            let mut i = 0u64;
            while r != 0 {
                if r & 1 != 0 {
                    got.push(base + i * 8);
                }
                r >>= 1;
                i += 1;
            }
            base += 63 * 8;
        }
    }
    assert_eq!(got, addrs);
}

#[test]
fn sha1_matches_known_vectors() {
    assert_eq!(
        sha1(b"abc"),
        [
            0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a, 0xba, 0x3e, 0x25, 0x71, 0x78, 0x50,
            0xc2, 0x6c, 0x9c, 0xd0, 0xd8, 0x9d
        ]
    );
    assert_eq!(
        sha1(b""),
        [
            0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55, 0xbf, 0xef, 0x95, 0x60,
            0x18, 0x90, 0xaf, 0xd8, 0x07, 0x09
        ]
    );
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
        build_id_sha1: true,
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
        build_id_sha1: true,
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
             address, which no load address supplies [B6012]"
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

/// A final link with no `-T` runs the built-in default script.
/// This is the shape of kbuild's RELR probe: `void *p = &p;`
/// linked `-shared -Bsymbolic -z pack-relative-relocs`.
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

/// A script that discards the dynamic tables gets no dynamic
/// sections, which is how the kernel's own `-shared` links stay
/// unchanged.
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
        lib: SharedLibrary {
            soname: soname.to_string(),
            machine: NativeMachine::X86_64,
            exports: funcs.iter().chain(data).map(|s| s.to_string()).collect(),
            data_exports: data.iter().map(|s| s.to_string()).collect(),
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

/// A call to an imported function reaches it through a PLT stub and
/// a load through a GOT slot the loader fills from a `GLOB_DAT`
/// entry naming the symbol.
#[test]
fn an_import_binds_through_a_stub_and_a_got_slot() {
    let script = parse_linker_script(&default_script(true)).expect("parses");
    let objs = alloc::vec![parse_lds_object("a.o", import_user()).expect("parses")];
    let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &["foo"], &["bar"])]);
    let res = link_with_script(&script, objs, &opts).expect("links");
    // Imports lead the table, in name order, so a relocation can
    // name one by index.
    let syms = image_dynsyms(&res.image);
    assert_eq!(syms[1].0, "bar");
    assert_eq!(syms[2].0, "foo");
    assert_eq!((syms[1].2, syms[2].2), (SHN_UNDEF, SHN_UNDEF));

    let (got_addr, _) = image_section(&res.image, ".got");
    let (_, rela) = image_section(&res.image, ".rela.dyn");
    let entries: Vec<(u64, u32, u32)> = rela
        .as_chunks::<24>()
        .0
        .iter()
        .map(|c| {
            let info = u64::from_le_bytes(c[8..16].try_into().unwrap());
            (
                u64::from_le_bytes(c[..8].try_into().unwrap()),
                (info >> 32) as u32,
                info as u32,
            )
        })
        .collect();
    let glob: Vec<&(u64, u32, u32)> = entries
        .iter()
        .filter(|e| e.2 == rt::R_X86_64_GLOB_DAT)
        .collect();
    assert_eq!(glob.len(), 2, "one slot per import");
    assert_eq!(
        (glob[0].0, glob[0].1),
        (got_addr, 1),
        "bar's slot names bar"
    );
    assert_eq!(
        (glob[1].0, glob[1].1),
        (got_addr + 8, 2),
        "foo's slot names foo"
    );

    let (text_addr, text) = image_section(&res.image, ".text");
    let (plt_addr, plt) = image_section(&res.image, ".plt");
    assert_eq!(plt.len(), 16, "only the called import takes a stub");
    let call = i32::from_le_bytes(text[1..5].try_into().unwrap()) as i64;
    assert_eq!(
        text_addr as i64 + 5 + call,
        plt_addr as i64,
        "the call reaches the stub"
    );
    let load = i32::from_le_bytes(text[8..12].try_into().unwrap()) as i64;
    assert_eq!(
        text_addr as i64 + 12 + load,
        got_addr as i64,
        "the load keeps its GOT slot rather than relaxing to an address"
    );
    assert_eq!(
        text[5..8],
        [0x48, 0x8b, 0x05],
        "so the load is not rewritten"
    );
    // The stub jumps through the slot: ff 25 <rip-relative>.
    assert_eq!(plt[..2], [0xff, 0x25]);
    let disp = i32::from_le_bytes(plt[2..6].try_into().unwrap()) as i64;
    assert_eq!(plt_addr as i64 + 6 + disp, got_addr as i64 + 8);
}

/// A reference that would need the imported object copied into this
/// image is refused rather than left pointing at nothing.
#[test]
fn a_direct_reference_to_imported_data_is_refused() {
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
    let opts = dynamic_opts(alloc::vec![shared_input("libc.so.6", &[], &["bar"])]);
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

/// An unresolved default-visibility weak reference keeps
/// symbol-based dynamic entries (ABS64 at its slots, GLOB_DAT for
/// its GOT entry) instead of resolving statically; a hidden global
/// is emitted with local binding in a dynamic link.
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
