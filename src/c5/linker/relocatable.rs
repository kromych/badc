//! Relocatable (`ld -r`) link: merge ELF64 ET_REL inputs into one
//! ET_REL output without resolving any relocation.
//!
//! Unlike `object.rs`, which classifies sections into the fixed
//! text/rodata/data/bss families the final-image writers consume, this
//! reader keeps every section verbatim (name, type, flags, alignment,
//! entsize, bytes) so arbitrary named sections survive the merge the
//! way GNU ld preserves them. Same-name input sections concatenate
//! with alignment padding, COMDAT groups dedup by signature, the
//! symbol tables merge (locals kept per object, globals resolved
//! without requiring definitions), and every relocation is rewritten:
//! section-symbol entries retarget the merged section with the
//! placement offset folded into the addend, named-symbol entries
//! re-index into the merged table.

#![cfg(feature = "std")]

use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use crate::c5::error::C5Error;

use super::lds::{
    BinOp, DataWidth, Expr, LinkerScript, SectionContent, SectionsItem, SortKind, UnOp,
};
use super::object::{Elf64Ehdr, Elf64Shdr, read_struct};

pub const EM_X86_64: u16 = 62;
pub const EM_AARCH64: u16 = 183;

const ET_REL: u16 = 1;
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_NOTE: u32 = 7;
const SHT_NOBITS: u32 = 8;
const SHT_REL: u32 = 9;
const SHT_GROUP: u32 = 17;
const SHT_SYMTAB_SHNDX: u32 = 18;

const SHF_MERGE: u64 = 0x10;
const SHF_INFO_LINK: u64 = 0x40;
const SHF_LINK_ORDER: u64 = 0x80;
const SHF_GROUP: u64 = 0x200;
const GRP_COMDAT: u32 = 1;

const SHN_UNDEF: u16 = 0;
const SHN_LORESERVE: u16 = 0xff00;
const SHN_ABS: u16 = 0xfff1;
const SHN_COMMON: u16 = 0xfff2;
const SHN_XINDEX: u16 = 0xffff;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STT_SECTION: u8 = 3;
const STT_FILE: u8 = 4;

const ELF64_SHDR_SIZE: usize = 64;
const ELF64_SYM_SIZE: usize = 24;
const ELF64_RELA_SIZE: usize = 24;

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
        "linker::relocatable: {msg}",
    )))
}

/// Where a symbol's `st_shndx` points, with section indices mapped to
/// the carried-section table.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum EtSymRef {
    Undef,
    Abs,
    Common,
    Section(usize),
}

#[derive(Debug, Clone)]
pub struct EtSym {
    pub name: String,
    pub binding: u8,
    pub kind: u8,
    pub other: u8,
    pub sec: EtSymRef,
    pub value: u64,
    pub size: u64,
}

#[derive(Debug, Clone, Copy)]
pub struct EtReloc {
    pub offset: u64,
    /// Index into [`EtRel::symbols`].
    pub sym: u32,
    pub rtype: u32,
    pub addend: i64,
}

#[derive(Debug, Clone)]
pub struct EtSection {
    pub name: String,
    pub sh_type: u32,
    pub flags: u64,
    pub addralign: u64,
    pub entsize: u64,
    /// File bytes; empty for SHT_NOBITS.
    pub bytes: Vec<u8>,
    /// sh_size for SHT_NOBITS sections.
    pub nobits_size: u64,
    /// Carried-section index sh_link names (SHF_LINK_ORDER).
    pub link_target: Option<usize>,
    pub relocs: Vec<EtReloc>,
    /// Index into [`EtRel::groups`] when this section is a member.
    pub group: Option<usize>,
}

impl EtSection {
    // Accessor for consumers and tests; the merge reads the raw
    // fields directly.
    #[allow(dead_code)]
    pub fn size(&self) -> u64 {
        if self.sh_type == SHT_NOBITS {
            self.nobits_size
        } else {
            self.bytes.len() as u64
        }
    }
}

#[derive(Debug, Clone)]
pub struct EtGroup {
    pub flags: u32,
    /// Name of the signature symbol (`symtab[sh_info]`).
    pub signature: String,
    /// Carried-section indices of the members.
    pub members: Vec<usize>,
}

/// One parsed ET_REL input, section contents kept verbatim.
#[derive(Debug, Clone)]
pub struct EtRel {
    pub source: String,
    pub machine: u16,
    pub osabi: u8,
    pub abiversion: u8,
    pub eflags: u32,
    pub sections: Vec<EtSection>,
    pub symbols: Vec<EtSym>,
    pub groups: Vec<EtGroup>,
}

impl EtRel {
    /// Names this object defines with external binding (GLOBAL / WEAK /
    /// COMMON), used for archive member selection.
    pub fn defined_globals(&self) -> impl Iterator<Item = &str> {
        self.symbols.iter().filter_map(|s| {
            (s.binding != STB_LOCAL && s.sec != EtSymRef::Undef && !s.name.is_empty())
                .then_some(s.name.as_str())
        })
    }

    /// Names this object references but does not define. Weak
    /// references are excluded: they never pull archive members.
    pub fn strong_undefs(&self) -> impl Iterator<Item = &str> {
        self.symbols.iter().filter_map(|s| {
            (s.binding == STB_GLOBAL && s.sec == EtSymRef::Undef && !s.name.is_empty())
                .then_some(s.name.as_str())
        })
    }
}

fn cstr(bytes: &[u8], off: usize) -> Result<String, C5Error> {
    let start = off.min(bytes.len());
    let end = bytes[start..]
        .iter()
        .position(|&b| b == 0)
        .map(|p| start + p)
        .ok_or_else(|| err("unterminated string-table entry"))?;
    Ok(String::from_utf8_lossy(&bytes[start..end]).into_owned())
}

fn section_slice<'a>(bytes: &'a [u8], sh: &Elf64Shdr) -> Result<&'a [u8], C5Error> {
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    let off = sh.sh_offset as usize;
    let size = sh.sh_size as usize;
    if off.checked_add(size).is_none_or(|end| end > bytes.len()) {
        return Err(err(&format!(
            "section at offset 0x{off:x} size 0x{size:x} runs past end of file",
        )));
    }
    Ok(&bytes[off..off + size])
}

/// Parse one ELF64 little-endian ET_REL object, keeping every section
/// verbatim. Symbol / string / relocation tables and SHT_GROUP
/// sections are consumed into structured form rather than carried.
pub fn parse_et_rel(bytes: &[u8], source: &str) -> Result<EtRel, C5Error> {
    if bytes.len() < 4 || &bytes[0..4] != b"\x7fELF" {
        return Err(err(&format!("{source}: not an ELF object")));
    }
    let ehdr: Elf64Ehdr = read_struct(bytes, 0)?;
    if ehdr.e_ident[4] != 2 || ehdr.e_ident[5] != 1 {
        return Err(err(&format!("{source}: not a little-endian ELF64 object")));
    }
    if ehdr.e_type != ET_REL {
        return Err(err(&format!(
            "{source}: e_type {} is not ET_REL",
            ehdr.e_type
        )));
    }
    if ehdr.e_shentsize as usize != ELF64_SHDR_SIZE {
        return Err(err(&format!(
            "{source}: section header entry size {} != {ELF64_SHDR_SIZE}",
            ehdr.e_shentsize
        )));
    }
    let e_shnum = ehdr.e_shnum as usize;
    let e_shoff = ehdr.e_shoff as usize;
    if e_shnum
        .checked_mul(ELF64_SHDR_SIZE)
        .and_then(|t| e_shoff.checked_add(t))
        .is_none_or(|end| end > bytes.len())
    {
        return Err(err(&format!(
            "{source}: section header table runs past end of file"
        )));
    }
    let mut shdrs: Vec<Elf64Shdr> = Vec::with_capacity(e_shnum);
    for i in 0..e_shnum {
        shdrs.push(read_struct(bytes, e_shoff + i * ELF64_SHDR_SIZE)?);
    }
    let shstr = shdrs
        .get(ehdr.e_shstrndx as usize)
        .ok_or_else(|| err(&format!("{source}: e_shstrndx out of range")))?;
    let shstr_bytes = section_slice(bytes, shstr)?;

    // First walk: pick the symtab, classify each header as carried or
    // consumed, and build the shndx -> carried-index map.
    let mut symtab_idx: Option<usize> = None;
    let mut carried: Vec<Option<usize>> = alloc::vec![None; e_shnum];
    let mut sections: Vec<EtSection> = Vec::new();
    let mut group_shndx: Vec<usize> = Vec::new();
    for (i, sh) in shdrs.iter().enumerate().skip(1) {
        match sh.sh_type {
            SHT_SYMTAB => {
                if symtab_idx.replace(i).is_some() {
                    return Err(err(&format!("{source}: more than one SHT_SYMTAB")));
                }
            }
            SHT_SYMTAB_SHNDX => {
                return Err(err(&format!(
                    "{source}: SHT_SYMTAB_SHNDX (>= 0xff00 sections) is not supported"
                )));
            }
            SHT_REL => {
                return Err(err(&format!(
                    "{source}: SHT_REL relocations are not supported (x86_64 / aarch64 \
                     objects use SHT_RELA)"
                )));
            }
            SHT_RELA | SHT_GROUP => {
                if sh.sh_type == SHT_GROUP {
                    group_shndx.push(i);
                }
            }
            SHT_STRTAB => {
                // Consumed when it serves the symtab or the header
                // names; a free-standing string table is carried.
                let is_shstr = i == ehdr.e_shstrndx as usize;
                let serves_symtab = shdrs
                    .iter()
                    .any(|s| s.sh_type == SHT_SYMTAB && s.sh_link as usize == i);
                if !is_shstr && !serves_symtab {
                    carried[i] = Some(sections.len());
                    sections.push(read_carried(bytes, sh, shstr_bytes)?);
                }
            }
            _ => {
                carried[i] = Some(sections.len());
                sections.push(read_carried(bytes, sh, shstr_bytes)?);
            }
        }
    }
    // Resolve SHF_LINK_ORDER links now that the map exists.
    for (i, sh) in shdrs.iter().enumerate().skip(1) {
        if let Some(ci) = carried[i]
            && sections[ci].flags & SHF_LINK_ORDER != 0
        {
            sections[ci].link_target = carried.get(sh.sh_link as usize).copied().flatten();
        }
    }

    // Symbol table.
    let mut symbols: Vec<EtSym> = Vec::new();
    if let Some(si) = symtab_idx {
        let symtab_sh = &shdrs[si];
        if symtab_sh.sh_entsize != ELF64_SYM_SIZE as u64 {
            return Err(err(&format!("{source}: .symtab entry size mismatch")));
        }
        let strtab_sh = shdrs
            .get(symtab_sh.sh_link as usize)
            .ok_or_else(|| err(&format!("{source}: .symtab sh_link out of range")))?;
        let strtab = section_slice(bytes, strtab_sh)?;
        let symtab = section_slice(bytes, symtab_sh)?;
        let n = symtab.len() / ELF64_SYM_SIZE;
        symbols.reserve(n);
        for j in 0..n {
            let off = j * ELF64_SYM_SIZE;
            let st_name = u32::from_le_bytes(symtab[off..off + 4].try_into().unwrap());
            let st_info = symtab[off + 4];
            let st_other = symtab[off + 5];
            let st_shndx = u16::from_le_bytes(symtab[off + 6..off + 8].try_into().unwrap());
            let st_value = u64::from_le_bytes(symtab[off + 8..off + 16].try_into().unwrap());
            let st_size = u64::from_le_bytes(symtab[off + 16..off + 24].try_into().unwrap());
            let sec = match st_shndx {
                SHN_UNDEF => EtSymRef::Undef,
                SHN_ABS => EtSymRef::Abs,
                SHN_COMMON => EtSymRef::Common,
                SHN_XINDEX => {
                    return Err(err(&format!("{source}: SHN_XINDEX symbol unsupported")));
                }
                s if s >= SHN_LORESERVE => {
                    return Err(err(&format!(
                        "{source}: reserved st_shndx 0x{s:x} unsupported"
                    )));
                }
                s => match carried.get(s as usize).copied().flatten() {
                    Some(ci) => EtSymRef::Section(ci),
                    None => {
                        // Symbol into a consumed section (group /
                        // rela / symtab): only meaningful for the
                        // section symbols the assembler emits; treat
                        // as undefined and reject if a reloc uses it.
                        EtSymRef::Undef
                    }
                },
            };
            symbols.push(EtSym {
                name: if st_name == 0 {
                    String::new()
                } else {
                    cstr(strtab, st_name as usize)?
                },
                binding: st_info >> 4,
                kind: st_info & 0xf,
                other: st_other,
                sec,
                value: st_value,
                size: st_size,
            });
        }
    }

    // Relocation sections attach to their carried target.
    for sh in shdrs.iter().skip(1) {
        if sh.sh_type != SHT_RELA {
            continue;
        }
        if sh.sh_entsize != ELF64_RELA_SIZE as u64 {
            return Err(err(&format!("{source}: SHT_RELA entry size mismatch")));
        }
        let Some(ci) = carried.get(sh.sh_info as usize).copied().flatten() else {
            continue; // relocations for a consumed section carry nothing
        };
        let body = section_slice(bytes, sh)?;
        let n = body.len() / ELF64_RELA_SIZE;
        let relocs = &mut sections[ci].relocs;
        relocs.reserve(n);
        for j in 0..n {
            let off = j * ELF64_RELA_SIZE;
            let r_offset = u64::from_le_bytes(body[off..off + 8].try_into().unwrap());
            let r_info = u64::from_le_bytes(body[off + 8..off + 16].try_into().unwrap());
            let r_addend = i64::from_le_bytes(body[off + 16..off + 24].try_into().unwrap());
            relocs.push(EtReloc {
                offset: r_offset,
                sym: (r_info >> 32) as u32,
                rtype: (r_info & 0xffff_ffff) as u32,
                addend: r_addend,
            });
        }
    }

    // Groups.
    let mut groups: Vec<EtGroup> = Vec::new();
    for &gi in &group_shndx {
        let sh = &shdrs[gi];
        let body = section_slice(bytes, sh)?;
        if body.len() < 4 || body.len() % 4 != 0 {
            return Err(err(&format!("{source}: malformed SHT_GROUP body")));
        }
        let flags = u32::from_le_bytes(body[0..4].try_into().unwrap());
        let signature = symbols
            .get(sh.sh_info as usize)
            .map(|s| s.name.clone())
            .unwrap_or_default();
        let mut members = Vec::new();
        for w in body[4..].chunks_exact(4) {
            let shndx = u32::from_le_bytes(w.try_into().unwrap()) as usize;
            // Rela members are implied by their target; record only
            // carried sections.
            if let Some(ci) = carried.get(shndx).copied().flatten() {
                members.push(ci);
            }
        }
        let g = groups.len();
        for &ci in &members {
            sections[ci].group = Some(g);
        }
        groups.push(EtGroup {
            flags,
            signature,
            members,
        });
    }

    Ok(EtRel {
        source: source.to_string(),
        machine: ehdr.e_machine,
        osabi: ehdr.e_ident[7],
        abiversion: ehdr.e_ident[8],
        eflags: ehdr.e_flags,
        sections,
        symbols,
        groups,
    })
}

fn read_carried(bytes: &[u8], sh: &Elf64Shdr, shstr: &[u8]) -> Result<EtSection, C5Error> {
    let name = cstr(shstr, sh.sh_name as usize)?;
    Ok(EtSection {
        name,
        sh_type: sh.sh_type,
        flags: sh.sh_flags,
        addralign: sh.sh_addralign.max(1),
        entsize: sh.sh_entsize,
        bytes: if sh.sh_type == SHT_NOBITS {
            Vec::new()
        } else {
            section_slice(bytes, sh)?.to_vec()
        },
        nobits_size: if sh.sh_type == SHT_NOBITS {
            sh.sh_size
        } else {
            0
        },
        link_target: None,
        relocs: Vec::new(),
        group: None,
    })
}

// ---- Linker-script subset -------------------------------------------

/// One `*(pattern)` input spec inside an output section statement.
#[derive(Debug, Clone)]
pub struct GatherSpec {
    pub patterns: Vec<String>,
    /// `SORT(...)`: matched input sections order by section name.
    pub sort: bool,
}

/// One statement inside an output section body, in source order.
#[derive(Debug, Clone)]
pub enum SecStmt {
    Gather(GatherSpec),
    /// `. = ALIGN(n);`
    AlignDot(u64),
    /// `<name> = .;`
    DefineSym(String),
    /// `BYTE(v)` -- one literal byte at the cursor.
    Byte(u8),
}

#[derive(Debug, Clone)]
pub struct OutSecRule {
    pub name: String,
    pub align: u64,
    pub stmts: Vec<SecStmt>,
}

/// The `SECTIONS`-only linker-script subset the kernel's
/// `scripts/module.lds` uses: `/DISCARD/` patterns, named output
/// sections gathering `*(glob)` specs (with `SORT` / `KEEP`),
/// `ALIGN` attributes, and `sym = .` assignments.
/// TODO: replace with the full linker-script engine once it lands.
#[derive(Debug, Clone, Default)]
pub struct LdScript {
    pub discard: Vec<String>,
    pub outsecs: Vec<OutSecRule>,
}

/// Match `pat` against `name` with `*` (any run), `?` (any one), and
/// `[...]` character classes with ranges (`[0-9a-zA-Z_]`, leading `!`
/// or `^` negates).
pub fn glob_match(pat: &str, name: &str) -> bool {
    let (p, n): (Vec<char>, Vec<char>) = (pat.chars().collect(), name.chars().collect());
    fn class(p: &[char], d: char) -> Option<(bool, usize)> {
        // `p` starts after `[`; returns (matched, chars consumed
        // including `]`) or None when the class is unterminated.
        let (neg, mut i) = match p.first() {
            Some('!' | '^') => (true, 1),
            _ => (false, 0),
        };
        let mut hit = false;
        while i < p.len() && p[i] != ']' {
            if i + 2 < p.len() && p[i + 1] == '-' && p[i + 2] != ']' {
                if (p[i]..=p[i + 2]).contains(&d) {
                    hit = true;
                }
                i += 3;
            } else {
                if p[i] == d {
                    hit = true;
                }
                i += 1;
            }
        }
        (i < p.len()).then_some((hit != neg, i + 1))
    }
    fn m(p: &[char], n: &[char]) -> bool {
        match (p.first(), n.first()) {
            (None, None) => true,
            (Some('*'), _) => m(&p[1..], n) || (!n.is_empty() && m(p, &n[1..])),
            (Some('?'), Some(_)) => m(&p[1..], &n[1..]),
            (Some('['), Some(&d)) => match class(&p[1..], d) {
                Some((true, used)) => m(&p[1 + used..], &n[1..]),
                _ => false,
            },
            (Some(c), Some(d)) if c == d => m(&p[1..], &n[1..]),
            _ => false,
        }
    }
    m(&p, &n)
}

/// Lower a parsed linker script to the relocatable link's model.
///
/// An ET_REL output has no addresses, so only the statements that
/// shape section membership survive: `/DISCARD/` patterns, the input
/// specs each output section gathers, `sym = .` definitions, `BYTE`
/// literals, and `. = ALIGN(n)` inside a section body, which sets the
/// offset of what follows. Everything an address would be needed for
/// -- output-section addresses, `AT`, `:phdr`, top-level assignments,
/// `ASSERT` -- is dropped, as GNU ld drops it under `-r`.
pub fn lower_script(script: &LinkerScript) -> LdScript {
    let mut out = LdScript::default();
    for item in script.all_sections() {
        let SectionsItem::Output(os) = item else {
            continue;
        };
        if os.name == "/DISCARD/" {
            for c in &os.contents {
                if let SectionContent::Input(spec) = c {
                    for pat in &spec.patterns {
                        out.discard.push(pat.pattern.clone());
                    }
                }
            }
            continue;
        }
        let mut stmts: Vec<SecStmt> = Vec::new();
        for c in &os.contents {
            match c {
                SectionContent::Input(spec) if !spec.patterns.is_empty() => {
                    stmts.push(SecStmt::Gather(GatherSpec {
                        patterns: spec.patterns.iter().map(|p| p.pattern.clone()).collect(),
                        sort: spec.file_sort != SortKind::None
                            || spec.patterns.iter().any(|p| p.sort != SortKind::None),
                    }));
                }
                SectionContent::Assign(a) if a.symbol == "." => {
                    if let Some(n) = const_align(&a.value) {
                        stmts.push(SecStmt::AlignDot(n));
                    }
                }
                SectionContent::Assign(a) if a.value == Expr::Symbol(".".to_string()) => {
                    stmts.push(SecStmt::DefineSym(a.symbol.clone()));
                }
                SectionContent::Data(DataWidth::Byte, Expr::Number(v)) => {
                    stmts.push(SecStmt::Byte(*v as u8));
                }
                _ => {}
            }
        }
        out.outsecs.push(OutSecRule {
            name: os.name.clone(),
            align: os.align.as_ref().and_then(const_expr).unwrap_or(0),
            stmts,
        });
    }
    out
}

/// The alignment of `. = ALIGN(n)` when `n` is a constant.
fn const_align(e: &Expr) -> Option<u64> {
    match e {
        Expr::AlignDot(inner) => const_expr(inner),
        _ => None,
    }
}

/// Evaluate an expression built only from literals and operators.
/// Anything naming a symbol or the location counter has no value in a
/// relocatable link and yields `None`.
fn const_expr(e: &Expr) -> Option<u64> {
    Some(match e {
        Expr::Number(n) => *n,
        Expr::Unary(op, a) => {
            let a = const_expr(a)?;
            match op {
                UnOp::Neg => 0u64.wrapping_sub(a),
                UnOp::Not => u64::from(a == 0),
                UnOp::BitNot => !a,
            }
        }
        Expr::Binary(op, a, b) => {
            let (a, b) = (const_expr(a)?, const_expr(b)?);
            match op {
                BinOp::Add => a.wrapping_add(b),
                BinOp::Sub => a.wrapping_sub(b),
                BinOp::Mul => a.wrapping_mul(b),
                BinOp::Div => a.checked_div(b)?,
                BinOp::Rem => a.checked_rem(b)?,
                BinOp::Shl => a.checked_shl(u32::try_from(b).ok()?)?,
                BinOp::Shr => a.checked_shr(u32::try_from(b).ok()?)?,
                BinOp::BitAnd => a & b,
                BinOp::BitOr => a | b,
                BinOp::BitXor => a ^ b,
                _ => return None,
            }
        }
        _ => return None,
    })
}

/// Parse a linker script for a relocatable link. The grammar is the
/// full one; [`lower_script`] keeps what an ET_REL output can honor.
pub fn parse_module_script(text: &str) -> Result<LdScript, C5Error> {
    Ok(lower_script(&super::lds::parse_linker_script(text)?))
}

// ---- Merge ----------------------------------------------------------

/// Which local symbols survive the merge. A relocation against a
/// discarded local retargets the containing section's symbol with the
/// local's value folded into the addend, as GNU ld converts them.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum DiscardLocals {
    /// Keep every local (`--discard-none`, the default).
    #[default]
    None,
    /// `-X` / `--discard-locals`: drop `.L*` temporaries.
    Temporaries,
    /// `-x` / `--discard-all`: drop every named local.
    All,
}

#[derive(Debug, Clone, Default)]
pub struct RelinkOptions {
    pub script: Option<LdScript>,
    pub discard_locals: DiscardLocals,
    pub strip_debug: bool,
    /// `--build-id=sha1`: append a `.note.gnu.build-id` section.
    pub build_id_sha1: bool,
    /// `-z noexecstack` (`Some(false)`) / `-z execstack`
    /// (`Some(true)`): ensure a `.note.GNU-stack` marker section with
    /// the requested execute flag, as GNU ld does.
    pub gnu_stack: Option<bool>,
    /// Machine constraint from `-m <emulation>`.
    pub expect_machine: Option<u16>,
}

/// (object index, carried-section index) of one input section.
type SecId = (usize, usize);

#[derive(Debug, Clone, Copy)]
struct Contribution {
    obj: usize,
    sec: usize,
    offset: u64,
}

struct OutSec {
    name: String,
    sh_type: u32,
    flags: u64,
    addralign: u64,
    entsize: u64,
    entsize_conflict: bool,
    bytes: Vec<u8>,
    nobits: u64,
    contribs: Vec<Contribution>,
    /// Script `sym = .` definitions: (name, offset).
    defined_syms: Vec<(String, u64)>,
    /// First contribution's SHF_LINK_ORDER target.
    link_from: Option<SecId>,
    /// NOP fill for executable-section padding (machine-dependent).
    exec_fill: ExecFill,
}

/// Executable-gap fill selection.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ExecFill {
    Zero,
    X86,
    Aarch64,
}

impl OutSec {
    fn new(name: &str, exec_fill: ExecFill) -> Self {
        OutSec {
            name: name.to_owned(),
            sh_type: 0,
            flags: 0,
            addralign: 1,
            entsize: 0,
            entsize_conflict: false,
            bytes: Vec::new(),
            nobits: 0,
            contribs: Vec::new(),
            defined_syms: Vec::new(),
            link_from: None,
            exec_fill,
        }
    }

    fn cursor(&self) -> u64 {
        if self.sh_type == SHT_NOBITS {
            self.nobits
        } else {
            self.bytes.len() as u64
        }
    }

    fn align_cursor(&mut self, align: u64) {
        let align = align.max(1);
        if self.sh_type == SHT_NOBITS {
            self.nobits = self.nobits.next_multiple_of(align);
            return;
        }
        let n = (self.bytes.len() as u64).next_multiple_of(align) as usize;
        // Executable-section padding is NOP fill with the same
        // instruction boundaries GNU ld emits (binutils nop_fill:
        // maximal multi-byte NOPs, then one sized remainder), so a
        // decoder sees the same instruction stream.
        const SHF_EXECINSTR: u64 = 0x4;
        if self.flags & SHF_EXECINSTR != 0 && self.exec_fill != ExecFill::Zero {
            let mut gap = n - self.bytes.len();
            match self.exec_fill {
                ExecFill::X86 => {
                    const NOPS: [&[u8]; 11] = [
                        &[],
                        &[0x90],
                        &[0x66, 0x90],
                        &[0x0f, 0x1f, 0x00],
                        &[0x0f, 0x1f, 0x40, 0x00],
                        &[0x0f, 0x1f, 0x44, 0x00, 0x00],
                        &[0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
                        &[0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
                        &[0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
                        &[0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
                        &[0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
                    ];
                    while gap >= 10 {
                        self.bytes.extend_from_slice(NOPS[10]);
                        gap -= 10;
                    }
                    self.bytes.extend_from_slice(NOPS[gap]);
                }
                ExecFill::Aarch64 => {
                    while gap >= 4 {
                        self.bytes.extend_from_slice(&[0x1f, 0x20, 0x03, 0xd5]);
                        gap -= 4;
                    }
                }
                ExecFill::Zero => {}
            }
        }
        self.bytes.resize(n, 0);
    }

    fn append(&mut self, objs: &[EtRel], obj: usize, sec: usize) {
        let s = &objs[obj].sections[sec];
        if self.contribs.is_empty() && self.sh_type == 0 {
            self.sh_type = s.sh_type;
        }
        // NOBITS joining file-backed content (or the reverse)
        // materializes the zero bytes.
        if self.sh_type == SHT_NOBITS && s.sh_type != SHT_NOBITS {
            let n = self.nobits as usize;
            self.bytes = alloc::vec![0; n];
            self.nobits = 0;
            self.sh_type = s.sh_type;
        }
        self.flags |= s.flags & !SHF_GROUP;
        self.addralign = self.addralign.max(s.addralign);
        if s.entsize != 0 {
            if self.entsize == 0 && !self.entsize_conflict {
                self.entsize = s.entsize;
            } else if self.entsize != s.entsize {
                // Mixed element sizes: the output cannot claim
                // mergeable fixed-size entries.
                self.entsize = 0;
                self.entsize_conflict = true;
                self.flags &= !SHF_MERGE;
            }
        }
        if self.link_from.is_none() && s.flags & SHF_LINK_ORDER != 0 {
            self.link_from = s.link_target.map(|t| (obj, t));
        }
        self.align_cursor(s.addralign);
        let offset = self.cursor();
        if self.sh_type == SHT_NOBITS {
            self.nobits += s.nobits_size;
        } else if s.sh_type == SHT_NOBITS {
            let n = self.bytes.len() + s.nobits_size as usize;
            self.bytes.resize(n, 0);
        } else {
            self.bytes.extend_from_slice(&s.bytes);
        }
        self.contribs.push(Contribution { obj, sec, offset });
    }
}

/// GNU-property note merge per the psABI. Presence rule per class:
/// `UINT32_AND` (feature_1_and) survives only when every input
/// carries it, values ANDed; `UINT32_OR` (ISA_1_NEEDED) survives on
/// any input, values ORed; `UINT32_OR_AND` (ISA_1_USED /
/// FEATURE_2_USED) needs every input, values ORed. An input without
/// a property note drops the all-input classes, matching GNU ld.
/// ELF object-attribute sections carry one attribute set, not a
/// concatenation of the inputs': BFD reads the first subsection length
/// and rejects anything past it. Only the first copy is kept, and the
/// rest must agree.
/// TODO: merge per tag -- the AArch64 `aeabi_feature_and_bits` set is
/// an AND across inputs, so disagreeing objects have a defined result.
fn is_attributes_section(sh_type: u32) -> bool {
    const SHT_GNU_ATTRIBUTES: u32 = 0x6fff_fff5;
    /// `SHT_ARM_ATTRIBUTES` / `SHT_AARCH64_ATTRIBUTES`, the same value.
    const SHT_ARCH_ATTRIBUTES: u32 = 0x7000_0003;
    matches!(sh_type, SHT_GNU_ATTRIBUTES | SHT_ARCH_ATTRIBUTES)
}

fn merge_property_notes(notes: &[Vec<u8>], n_inputs: usize, align: u64) -> Option<EtSection> {
    // Generic ranges (0xb000....) plus the processor-specific ranges
    // shared by x86_64 and aarch64 (0xc000....).
    let is_and = |ty: u32| {
        (0xb0000000..=0xb0007fff).contains(&ty) || (0xc0000000..=0xc0007fff).contains(&ty)
    };
    let is_or = |ty: u32| {
        (0xb0008000..=0xb000ffff).contains(&ty) || (0xc0008000..=0xc000ffff).contains(&ty)
    };
    let is_or_and = |ty: u32| (0xc0010000..=0xc0017fff).contains(&ty);
    let mut and_props: BTreeMap<u32, (u32, usize)> = BTreeMap::new();
    let mut or_and_props: BTreeMap<u32, (u32, usize)> = BTreeMap::new();
    let mut or_props: BTreeMap<u32, u32> = BTreeMap::new();
    for note in notes {
        // Note payload: nhdr(12) + "GNU\0" + properties, each
        // (pr_type u32, pr_datasz u32, data, pad to 8).
        let mut off = 0usize;
        while off + 12 <= note.len() {
            let namesz = u32::from_le_bytes(note[off..off + 4].try_into().unwrap()) as usize;
            let descsz = u32::from_le_bytes(note[off + 4..off + 8].try_into().unwrap()) as usize;
            let ntype = u32::from_le_bytes(note[off + 8..off + 12].try_into().unwrap());
            let name_end = off + 12 + namesz.next_multiple_of(4);
            let desc_end = name_end + descsz;
            if desc_end > note.len() {
                break;
            }
            // NT_GNU_PROPERTY_TYPE_0 = 5, name "GNU".
            if ntype == 5 && namesz >= 4 && &note[off + 12..off + 15] == b"GNU" {
                let mut d = name_end;
                while d + 8 <= desc_end {
                    let pty = u32::from_le_bytes(note[d..d + 4].try_into().unwrap());
                    let dsz = u32::from_le_bytes(note[d + 4..d + 8].try_into().unwrap()) as usize;
                    if d + 8 + dsz > desc_end || dsz != 4 {
                        break; // only u32 payloads participate
                    }
                    let v = u32::from_le_bytes(note[d + 8..d + 12].try_into().unwrap());
                    if is_and(pty) {
                        let e = and_props.entry(pty).or_insert((u32::MAX, 0));
                        e.0 &= v;
                        e.1 += 1;
                    } else if is_or_and(pty) {
                        let e = or_and_props.entry(pty).or_insert((0, 0));
                        e.0 |= v;
                        e.1 += 1;
                    } else if is_or(pty) {
                        *or_props.entry(pty).or_insert(0) |= v;
                    }
                    d += 8 + dsz.next_multiple_of(8);
                }
            }
            off = desc_end.next_multiple_of(4);
        }
    }
    let mut props: Vec<(u32, u32)> = Vec::new();
    for (ty, (v, seen)) in and_props.into_iter().chain(or_and_props) {
        if seen == n_inputs && v != 0 {
            props.push((ty, v));
        }
    }
    for (ty, v) in or_props {
        if v != 0 {
            props.push((ty, v));
        }
    }
    if props.is_empty() {
        return None;
    }
    props.sort_by_key(|&(ty, _)| ty);
    let mut body: Vec<u8> = Vec::new();
    body.extend_from_slice(&4u32.to_le_bytes());
    body.extend_from_slice(&((props.len() * 16) as u32).to_le_bytes());
    body.extend_from_slice(&5u32.to_le_bytes());
    body.extend_from_slice(b"GNU\0");
    for (ty, v) in props {
        body.extend_from_slice(&ty.to_le_bytes());
        body.extend_from_slice(&4u32.to_le_bytes());
        body.extend_from_slice(&v.to_le_bytes());
        body.extend_from_slice(&0u32.to_le_bytes());
    }
    Some(EtSection {
        name: ".note.gnu.property".to_string(),
        sh_type: SHT_NOTE,
        flags: 0x2, // SHF_ALLOC
        addralign: align,
        entsize: 0,
        bytes: body,
        nobits_size: 0,
        link_target: None,
        relocs: Vec::new(),
        group: None,
    })
}

/// Merge parsed ET_REL objects into one ET_REL image.
pub fn link_relocatable(objs: &[EtRel], opts: &RelinkOptions) -> Result<Vec<u8>, C5Error> {
    if objs.is_empty() {
        return Err(err("no input objects"));
    }
    let machine = opts.expect_machine.unwrap_or(objs[0].machine);
    for o in objs {
        if o.machine != machine {
            return Err(err(&format!(
                "{}: machine {} does not match the link's machine {}",
                o.source, o.machine, machine
            )));
        }
    }

    // COMDAT dedup: first group with a signature wins; later ones drop
    // their member sections. `twin` maps a dropped member to the kept
    // group's same-name member so stray relocations can retarget.
    let mut kept_groups: Vec<(usize, usize)> = Vec::new(); // (obj, group idx)
    let mut sig_first: HashMap<&str, usize> = HashMap::new(); // -> kept_groups idx
    let mut dropped: HashSet<SecId> = HashSet::new();
    let mut twin: HashMap<SecId, SecId> = HashMap::new();
    for (oi, o) in objs.iter().enumerate() {
        for (gi, g) in o.groups.iter().enumerate() {
            if g.flags & GRP_COMDAT == 0 {
                kept_groups.push((oi, gi));
                continue;
            }
            match sig_first.get(g.signature.as_str()) {
                None => {
                    sig_first.insert(g.signature.as_str(), kept_groups.len());
                    kept_groups.push((oi, gi));
                }
                Some(&kept) => {
                    let (koi, kgi) = kept_groups[kept];
                    let kept_members = &objs[koi].groups[kgi].members;
                    for (mi, &sec) in g.members.iter().enumerate() {
                        dropped.insert((oi, sec));
                        let name = &o.sections[sec].name;
                        let t = kept_members
                            .iter()
                            .find(|&&ks| objs[koi].sections[ks].name == *name)
                            .or(kept_members.get(mi));
                        if let Some(&ks) = t {
                            twin.insert((oi, sec), (koi, ks));
                        }
                    }
                }
            }
        }
    }

    // Property notes leave the generic name-merge; script discards and
    // --strip-debug drop sections outright.
    let empty = LdScript::default();
    let script = opts.script.as_ref().unwrap_or(&empty);
    let mut prop_notes: Vec<Vec<u8>> = Vec::new();
    let mut prop_align = 4u64;
    for (oi, o) in objs.iter().enumerate() {
        for (si, s) in o.sections.iter().enumerate() {
            if s.name == ".note.gnu.property" && s.sh_type == SHT_NOTE {
                prop_notes.push(s.bytes.clone());
                prop_align = prop_align.max(s.addralign);
                dropped.insert((oi, si));
            } else if (opts.strip_debug && s.name.starts_with(".debug"))
                || script.discard.iter().any(|p| glob_match(p, &s.name))
            {
                dropped.insert((oi, si));
            }
        }
    }

    let exec_fill = match machine {
        EM_X86_64 => ExecFill::X86,
        EM_AARCH64 => ExecFill::Aarch64,
        _ => ExecFill::Zero,
    };

    // Output sections. Script rules first (in script order), orphans
    // by first-seen name; kept-group members keep their own identity
    // and never merge across groups.
    let mut outsecs: Vec<OutSec> = Vec::new();
    let mut group_outsec: HashMap<SecId, usize> = HashMap::new();
    let mut claimed: HashSet<SecId> = HashSet::new();
    for rule in &script.outsecs {
        let mut out = OutSec::new(&rule.name, exec_fill);
        out.addralign = rule.align;
        for stmt in &rule.stmts {
            match stmt {
                SecStmt::AlignDot(n) => out.align_cursor(*n),
                SecStmt::Byte(v) => {
                    if out.sh_type == 0 || out.sh_type == SHT_NOBITS {
                        out.sh_type = SHT_PROGBITS;
                    }
                    out.bytes.push(*v);
                }
                SecStmt::DefineSym(name) => {
                    let at = out.cursor();
                    out.defined_syms.push((name.clone(), at));
                }
                SecStmt::Gather(g) => {
                    let mut matches: Vec<SecId> = Vec::new();
                    for (oi, o) in objs.iter().enumerate() {
                        for (si, s) in o.sections.iter().enumerate() {
                            if dropped.contains(&(oi, si))
                                || claimed.contains(&(oi, si))
                                || s.group.is_some()
                            {
                                continue;
                            }
                            if g.patterns.iter().any(|p| glob_match(p, &s.name)) {
                                matches.push((oi, si));
                            }
                        }
                    }
                    if g.sort {
                        matches.sort_by(|&(ao, as_), &(bo, bs)| {
                            objs[ao].sections[as_]
                                .name
                                .cmp(&objs[bo].sections[bs].name)
                                .then(ao.cmp(&bo))
                        });
                    }
                    for (oi, si) in matches {
                        claimed.insert((oi, si));
                        out.append(objs, oi, si);
                    }
                }
            }
        }
        if !out.contribs.is_empty() || !out.defined_syms.is_empty() || out.cursor() > 0 {
            if out.sh_type == 0 {
                out.sh_type = SHT_PROGBITS;
            }
            outsecs.push(out);
        }
    }
    let mut by_name: HashMap<String, usize> = HashMap::new();
    for (oi, o) in objs.iter().enumerate() {
        for (si, s) in o.sections.iter().enumerate() {
            if dropped.contains(&(oi, si)) || claimed.contains(&(oi, si)) {
                continue;
            }
            if s.group.is_some() {
                // Each kept group's member is its own output section.
                let idx = outsecs.len();
                let mut out = OutSec::new(&s.name, exec_fill);
                out.flags = s.flags; // keep SHF_GROUP
                out.append(objs, oi, si);
                out.flags |= SHF_GROUP;
                outsecs.push(out);
                group_outsec.insert((oi, si), idx);
                continue;
            }
            let idx = *by_name.entry(s.name.clone()).or_insert_with(|| {
                outsecs.push(OutSec::new(&s.name, exec_fill));
                outsecs.len() - 1
            });
            if is_attributes_section(s.sh_type) {
                if outsecs[idx].bytes.is_empty() {
                    outsecs[idx].append(objs, oi, si);
                } else if outsecs[idx].bytes != s.bytes {
                    return Err(err(&format!(
                        "{}: `{}` disagrees with an earlier object's;                          object attributes are not merged per tag",
                        o.source, s.name
                    )));
                }
                continue;
            }
            outsecs[idx].append(objs, oi, si);
        }
    }
    if let Some(exec) = opts.gnu_stack {
        const SHF_EXECINSTR: u64 = 0x4;
        let flags = if exec { SHF_EXECINSTR } else { 0 };
        match outsecs.iter_mut().find(|o| o.name == ".note.GNU-stack") {
            Some(o) => o.flags = flags,
            None => {
                let mut out = OutSec::new(".note.GNU-stack", exec_fill);
                out.sh_type = SHT_PROGBITS;
                out.flags = flags;
                outsecs.push(out);
            }
        }
    }
    if let Some(p) = merge_property_notes(&prop_notes, objs.len(), prop_align) {
        let mut out = OutSec::new(&p.name, exec_fill);
        out.sh_type = p.sh_type;
        out.flags = p.flags;
        out.addralign = p.addralign;
        out.bytes = p.bytes;
        outsecs.push(out);
    }
    if opts.build_id_sha1 {
        // Note body: nhdr + "GNU\0" + 20-byte digest, patched over
        // the final file bytes at write time.
        let mut out = OutSec::new(".note.gnu.build-id", exec_fill);
        out.sh_type = SHT_NOTE;
        out.flags = 0x2; // SHF_ALLOC
        out.addralign = 4;
        out.bytes.extend_from_slice(&4u32.to_le_bytes());
        out.bytes.extend_from_slice(&20u32.to_le_bytes());
        out.bytes.extend_from_slice(&3u32.to_le_bytes()); // NT_GNU_BUILD_ID
        out.bytes.extend_from_slice(b"GNU\0");
        out.bytes.extend_from_slice(&[0u8; 20]);
        outsecs.push(out);
    }
    if outsecs.len() >= (SHN_LORESERVE as usize) - 8 {
        return Err(err(
            "output would need extended section numbering (>= 0xff00 sections); unsupported",
        ));
    }

    // Placement lookup: input section -> (outsec, offset).
    let mut placed: HashMap<SecId, (usize, u64)> = HashMap::new();
    for (idx, out) in outsecs.iter().enumerate() {
        for c in &out.contribs {
            placed.insert((c.obj, c.sec), (idx, c.offset));
        }
    }

    // Global resolution. States keyed by name in first-appearance
    // order; definitions in comdat-dropped sections defer to the kept
    // copy and never conflict.
    #[derive(Clone)]
    enum GState {
        Undef { binding: u8, kind: u8, other: u8 },
        Common { size: u64, align: u64, other: u8 },
        Def { obj: usize, sym: usize, weak: bool },
    }
    let mut order: Vec<String> = Vec::new();
    let mut globals: HashMap<String, GState> = HashMap::new();
    // GNU ld adopts a definite symbol type from any occurrence when
    // the winning entry is STT_NOTYPE (an assembler definition typed
    // by a C reference, e.g. `extern const char x[]`).
    let mut kind_hint: HashMap<String, u8> = HashMap::new();
    let vis_rank = |v: u8| -> u8 { [0u8, 3, 2, 1][(v & 3) as usize] };
    let merge_other = |a: u8, b: u8| -> u8 {
        if vis_rank(b & 3) > vis_rank(a & 3) {
            (a & !3) | (b & 3)
        } else {
            a
        }
    };
    for (oi, o) in objs.iter().enumerate() {
        for (yi, sym) in o.symbols.iter().enumerate() {
            if sym.binding == STB_LOCAL || sym.name.is_empty() {
                continue;
            }
            if let EtSymRef::Section(si) = sym.sec
                && dropped.contains(&(oi, si))
            {
                continue; // definition owned by the kept COMDAT copy
            }
            let name = sym.name.clone();
            if sym.kind != 0 && !kind_hint.contains_key(&name) {
                kind_hint.insert(name.clone(), sym.kind);
            }
            let cur = globals.get(&name).cloned();
            if cur.is_none() {
                order.push(name.clone());
            }
            let next = match (cur, sym.sec) {
                (None, EtSymRef::Undef) => GState::Undef {
                    binding: sym.binding,
                    kind: sym.kind,
                    other: sym.other,
                },
                (None, EtSymRef::Common) => GState::Common {
                    size: sym.size,
                    align: sym.value,
                    other: sym.other,
                },
                (None, _) => GState::Def {
                    obj: oi,
                    sym: yi,
                    weak: sym.binding == STB_WEAK,
                },
                (Some(GState::Undef { binding, other, .. }), sec) => match sec {
                    EtSymRef::Undef => GState::Undef {
                        // A strong reference anywhere keeps the merged
                        // reference strong.
                        binding: if sym.binding == STB_GLOBAL {
                            STB_GLOBAL
                        } else {
                            binding
                        },
                        kind: sym.kind,
                        other: merge_other(other, sym.other),
                    },
                    EtSymRef::Common => GState::Common {
                        size: sym.size,
                        align: sym.value,
                        other: merge_other(sym.other, other),
                    },
                    _ => GState::Def {
                        obj: oi,
                        sym: yi,
                        weak: sym.binding == STB_WEAK,
                    },
                },
                (Some(GState::Common { size, align, other }), sec) => match sec {
                    EtSymRef::Undef => GState::Common { size, align, other },
                    EtSymRef::Common => GState::Common {
                        size: size.max(sym.size),
                        align: align.max(sym.value),
                        other: merge_other(other, sym.other),
                    },
                    // A definition supersedes the tentative common.
                    _ => GState::Def {
                        obj: oi,
                        sym: yi,
                        weak: sym.binding == STB_WEAK,
                    },
                },
                (Some(GState::Def { obj, sym: ds, weak }), sec) => match sec {
                    EtSymRef::Undef | EtSymRef::Common => GState::Def { obj, sym: ds, weak },
                    _ => {
                        let new_weak = sym.binding == STB_WEAK;
                        if !weak && !new_weak {
                            return Err(err(&format!(
                                "multiple definition of `{name}' in {} and {}",
                                objs[obj].source, o.source
                            )));
                        }
                        if weak && !new_weak {
                            GState::Def {
                                obj: oi,
                                sym: yi,
                                weak: false,
                            }
                        } else {
                            GState::Def { obj, sym: ds, weak }
                        }
                    }
                },
            };
            globals.insert(name, next);
        }
    }
    // Script-defined symbols are global definitions in their section.
    let mut script_syms: Vec<(String, usize, u64)> = Vec::new(); // (name, outsec, offset)
    for (idx, out) in outsecs.iter().enumerate() {
        for (name, off) in &out.defined_syms {
            if let Some(GState::Def { obj, .. }) = globals.get(name) {
                return Err(err(&format!(
                    "multiple definition of `{name}' (linker script and {})",
                    objs[*obj].source
                )));
            }
            if !globals.contains_key(name) {
                order.push(name.clone());
            }
            globals.remove(name);
            script_syms.push((name.clone(), idx, *off));
        }
    }

    // ---- Output symbol table ----
    struct OutSym {
        name: String,
        info: u8,
        other: u8,
        shndx: u16, // SHN_* or 1-based output section index
        value: u64,
        size: u64,
    }
    let mut syms: Vec<OutSym> = Vec::new();
    syms.push(OutSym {
        name: String::new(),
        info: 0,
        other: 0,
        shndx: SHN_UNDEF,
        value: 0,
        size: 0,
    });
    // One STT_SECTION per output section, in section order.
    let mut secsym_of_outsec: Vec<u32> = Vec::with_capacity(outsecs.len());
    for i in 0..outsecs.len() {
        secsym_of_outsec.push(syms.len() as u32);
        syms.push(OutSym {
            name: String::new(),
            info: STT_SECTION, // STB_LOCAL << 4 | STT_SECTION
            other: 0,
            shndx: (i + 1) as u16, // patched to final index at write
            value: 0,
            size: 0,
        });
    }
    // Per-object locals. An object that keeps locals but carries no
    // STT_FILE symbol gets one synthesized from its basename, as GNU
    // ld does for assembler objects without a `.file` directive.
    let mut local_map: HashMap<(usize, u32), u32> = HashMap::new();
    for (oi, o) in objs.iter().enumerate() {
        let has_file = o.symbols.iter().any(|s| s.kind == STT_FILE);
        let keeps_locals = o.symbols.iter().enumerate().any(|(yi, s)| {
            yi != 0
                && s.binding == STB_LOCAL
                && s.kind != STT_SECTION
                && match s.sec {
                    EtSymRef::Section(si) => placed.contains_key(&(oi, si)),
                    EtSymRef::Undef => false,
                    _ => true,
                }
        });
        if !has_file && keeps_locals {
            let base = o
                .source
                .rsplit(['/', '('])
                .next()
                .unwrap_or(&o.source)
                .trim_end_matches(')');
            syms.push(OutSym {
                name: base.to_string(),
                info: (STB_LOCAL << 4) | STT_FILE,
                other: 0,
                shndx: SHN_ABS,
                value: 0,
                size: 0,
            });
        }
        for (yi, sym) in o.symbols.iter().enumerate() {
            if yi == 0 || sym.binding != STB_LOCAL || sym.kind == STT_SECTION {
                continue;
            }
            let (shndx, value) = match sym.sec {
                EtSymRef::Abs => (SHN_ABS, sym.value),
                EtSymRef::Undef => {
                    if sym.kind == STT_FILE {
                        (SHN_ABS, sym.value)
                    } else {
                        continue;
                    }
                }
                EtSymRef::Common => (SHN_COMMON, sym.value),
                EtSymRef::Section(si) => {
                    let Some(&(outsec, off)) = placed.get(&(oi, si)) else {
                        continue; // section dropped; its locals go with it
                    };
                    ((outsec + 1) as u16, sym.value + off)
                }
            };
            let discard = match opts.discard_locals {
                DiscardLocals::None => false,
                DiscardLocals::Temporaries => sym.name.starts_with(".L"),
                DiscardLocals::All => sym.kind != STT_FILE,
            };
            if discard {
                continue;
            }
            local_map.insert((oi, yi as u32), syms.len() as u32);
            syms.push(OutSym {
                name: sym.name.clone(),
                info: (STB_LOCAL << 4) | sym.kind,
                other: sym.other,
                shndx,
                value,
                size: sym.size,
            });
        }
    }
    let first_global = syms.len() as u32;
    let mut global_index: HashMap<&str, u32> = HashMap::new();
    for name in &order {
        let idx = syms.len() as u32;
        let hinted = |kind: u8| -> u8 {
            if kind == 0 {
                kind_hint.get(name.as_str()).copied().unwrap_or(0)
            } else {
                kind
            }
        };
        if let Some(state) = globals.get(name.as_str()) {
            let out = match state {
                GState::Undef {
                    binding,
                    kind,
                    other,
                } => OutSym {
                    name: name.clone(),
                    info: (binding << 4) | hinted(*kind),
                    other: *other,
                    shndx: SHN_UNDEF,
                    value: 0,
                    size: 0,
                },
                GState::Common { size, align, other } => OutSym {
                    name: name.clone(),
                    info: (STB_GLOBAL << 4) | 1, // STT_OBJECT
                    other: *other,
                    shndx: SHN_COMMON,
                    value: *align,
                    size: *size,
                },
                GState::Def { obj, sym, .. } => {
                    let s = &objs[*obj].symbols[*sym];
                    let (shndx, value) = match s.sec {
                        EtSymRef::Abs => (SHN_ABS, s.value),
                        EtSymRef::Section(si) => {
                            let &(outsec, off) = placed.get(&(*obj, si)).ok_or_else(|| {
                                err(&format!(
                                    "{}: definition of `{}' in a discarded section",
                                    objs[*obj].source, name
                                ))
                            })?;
                            ((outsec + 1) as u16, s.value + off)
                        }
                        _ => unreachable!(),
                    };
                    OutSym {
                        name: name.clone(),
                        info: (s.binding << 4) | hinted(s.kind),
                        other: s.other,
                        shndx,
                        value,
                        size: s.size,
                    }
                }
            };
            syms.push(out);
        } else if let Some((_, outsec, off)) = script_syms.iter().find(|(n, _, _)| n == name) {
            syms.push(OutSym {
                name: name.clone(),
                info: STB_GLOBAL << 4, // STT_NOTYPE
                other: 0,
                shndx: (*outsec + 1) as u16,
                value: *off,
                size: 0,
            });
        } else {
            continue;
        }
        global_index.insert(name.as_str(), idx);
    }

    // Per-object symbol-index mapping for relocation rewrite.
    let map_sym = |oi: usize, r: &EtReloc| -> Result<(u32, i64), C5Error> {
        let o = &objs[oi];
        let sym = o.symbols.get(r.sym as usize).ok_or_else(|| {
            err(&format!(
                "{}: relocation references symbol {} past the symbol table",
                o.source, r.sym
            ))
        })?;
        if r.sym == 0 {
            return Ok((0, r.addend));
        }
        if sym.kind == STT_SECTION {
            let EtSymRef::Section(si) = sym.sec else {
                return Err(err(&format!(
                    "{}: section symbol {} has no section",
                    o.source, r.sym
                )));
            };
            let (tobj, tsec) = twin.get(&(oi, si)).copied().unwrap_or((oi, si));
            let &(outsec, off) = placed.get(&(tobj, tsec)).ok_or_else(|| {
                err(&format!(
                    "{}: relocation against discarded section `{}'",
                    o.source, o.sections[si].name
                ))
            })?;
            return Ok((secsym_of_outsec[outsec], r.addend + off as i64));
        }
        if sym.binding == STB_LOCAL {
            if let Some(idx) = local_map.get(&(oi, r.sym)) {
                return Ok((*idx, r.addend));
            }
            // Discarded local: convert to the containing section's
            // symbol with the local's value folded into the addend.
            if let EtSymRef::Section(si) = sym.sec {
                let (tobj, tsec) = twin.get(&(oi, si)).copied().unwrap_or((oi, si));
                if let Some(&(outsec, off)) = placed.get(&(tobj, tsec)) {
                    return Ok((
                        secsym_of_outsec[outsec],
                        r.addend + off as i64 + sym.value as i64,
                    ));
                }
            }
            return Err(err(&format!(
                "{}: relocation against discarded local `{}'",
                o.source, sym.name
            )));
        }
        let idx = global_index.get(sym.name.as_str()).ok_or_else(|| {
            err(&format!(
                "{}: relocation against unmapped global `{}'",
                o.source, sym.name
            ))
        })?;
        Ok((*idx, r.addend))
    };

    // Rewrite relocations per output section.
    let mut out_relocs: Vec<Vec<(u64, u32, u32, i64)>> = alloc::vec![Vec::new(); outsecs.len()];
    for (idx, out) in outsecs.iter().enumerate() {
        for c in &out.contribs {
            for r in &objs[c.obj].sections[c.sec].relocs {
                let (sym, addend) = map_sym(c.obj, r)?;
                out_relocs[idx].push((c.offset + r.offset, sym, r.rtype, addend));
            }
        }
    }

    // Kept groups that still have placed members.
    let mut out_groups: Vec<OutGroup> = Vec::new();
    for &(oi, gi) in &kept_groups {
        let g = &objs[oi].groups[gi];
        let members: Vec<usize> = g
            .members
            .iter()
            .filter_map(|&si| group_outsec.get(&(oi, si)).copied())
            .collect();
        if !members.is_empty() {
            out_groups.push(OutGroup {
                signature: g.signature.clone(),
                flags: g.flags,
                members,
            });
        }
    }

    let raw_syms: Vec<RawSym> = syms
        .iter()
        .map(|s| RawSym {
            name: s.name.clone(),
            info: s.info,
            other: s.other,
            shndx: s.shndx,
            value: s.value,
            size: s.size,
        })
        .collect();
    let sig_index: Vec<u32> = out_groups
        .iter()
        .map(|g| {
            global_index
                .get(g.signature.as_str())
                .copied()
                // A local signature falls back to the first member's
                // section symbol (null + outsec order => 1 + index).
                .unwrap_or_else(|| g.members.first().map(|&m| 1 + m as u32).unwrap_or(0))
        })
        .collect();
    write_et_rel(
        machine,
        objs,
        &outsecs,
        &out_relocs,
        &out_groups,
        &sig_index,
        raw_syms,
        first_global,
        opts.build_id_sha1,
    )
}

struct OutGroup {
    signature: String,
    flags: u32,
    members: Vec<usize>, // outsec indices
}

struct RawSym {
    name: String,
    info: u8,
    other: u8,
    shndx: u16,
    value: u64,
    size: u64,
}

/// Serialize the merged image. Layout: ehdr, section bodies in order
/// (each `.rela.X` follows its `X`, a group section precedes its first
/// member), `.symtab`, `.strtab`, `.shstrtab`, section header table.
#[allow(clippy::too_many_arguments)]
fn write_et_rel(
    machine: u16,
    objs: &[EtRel],
    outsecs: &[OutSec],
    out_relocs: &[Vec<(u64, u32, u32, i64)>],
    out_groups: &[OutGroup],
    group_sig_sym: &[u32],
    mut syms: Vec<RawSym>,
    first_global: u32,
    build_id: bool,
) -> Result<Vec<u8>, C5Error> {
    // Final section numbering. Entries: (kind, payload index).
    enum Ent {
        Sec(usize),
        Rela(usize),
        Group(usize),
        Symtab,
        Strtab,
        Shstrtab,
    }
    let mut ents: Vec<Ent> = Vec::new();
    // Group precedes its first member; every member of a group carries
    // the group's entry only once.
    let mut group_before: HashMap<usize, usize> = HashMap::new(); // outsec -> group
    for (gi, g) in out_groups.iter().enumerate() {
        if let Some(&first) = g.members.first() {
            group_before.insert(first, gi);
        }
    }
    let mut final_of_outsec: Vec<u16> = alloc::vec![0; outsecs.len()];
    let mut final_of_group: Vec<u16> = alloc::vec![0; out_groups.len()];
    for (i, _) in outsecs.iter().enumerate() {
        if let Some(&gi) = group_before.get(&i) {
            final_of_group[gi] = (ents.len() + 1) as u16;
            ents.push(Ent::Group(gi));
        }
        final_of_outsec[i] = (ents.len() + 1) as u16;
        ents.push(Ent::Sec(i));
        if !out_relocs[i].is_empty() {
            ents.push(Ent::Rela(i));
        }
    }
    let symtab_final = (ents.len() + 1) as u32;
    ents.push(Ent::Symtab);
    ents.push(Ent::Strtab);
    ents.push(Ent::Shstrtab);
    let shnum = ents.len() + 1;

    // Patch symbol st_shndx from outsec numbering to final numbering.
    for s in syms.iter_mut() {
        if s.shndx != SHN_UNDEF && s.shndx < SHN_LORESERVE {
            s.shndx = final_of_outsec[(s.shndx - 1) as usize];
        }
    }

    // String tables.
    let mut strtab: Vec<u8> = alloc::vec![0];
    let mut strmap: HashMap<String, u32> = HashMap::new();
    let intern = |t: &mut Vec<u8>, m: &mut HashMap<String, u32>, s: &str| -> u32 {
        if s.is_empty() {
            return 0;
        }
        *m.entry(s.to_string()).or_insert_with(|| {
            let at = t.len() as u32;
            t.extend_from_slice(s.as_bytes());
            t.push(0);
            at
        })
    };
    let mut symtab_bytes: Vec<u8> = Vec::with_capacity(syms.len() * ELF64_SYM_SIZE);
    for s in &syms {
        let name_off = intern(&mut strtab, &mut strmap, &s.name);
        symtab_bytes.extend_from_slice(&name_off.to_le_bytes());
        symtab_bytes.push(s.info);
        symtab_bytes.push(s.other);
        symtab_bytes.extend_from_slice(&s.shndx.to_le_bytes());
        symtab_bytes.extend_from_slice(&s.value.to_le_bytes());
        symtab_bytes.extend_from_slice(&s.size.to_le_bytes());
    }

    let mut shstr: Vec<u8> = alloc::vec![0];
    let mut shstrmap: HashMap<String, u32> = HashMap::new();

    // Group bodies (final indices; a group lists its members and their
    // rela sections).
    let mut rela_final: HashMap<usize, u16> = HashMap::new();
    for (fi, e) in ents.iter().enumerate() {
        if let Ent::Rela(i) = e {
            rela_final.insert(*i, (fi + 1) as u16);
        }
    }
    let group_body = |g: &OutGroup| -> Vec<u8> {
        let mut b = Vec::new();
        b.extend_from_slice(&g.flags.to_le_bytes());
        for &m in &g.members {
            b.extend_from_slice(&(final_of_outsec[m] as u32).to_le_bytes());
            if let Some(&rf) = rela_final.get(&m) {
                b.extend_from_slice(&(rf as u32).to_le_bytes());
            }
        }
        b
    };

    // Body serialization.
    let mut file: Vec<u8> = alloc::vec![0; 64];
    let mut shdrs: Vec<[u8; ELF64_SHDR_SIZE]> = Vec::with_capacity(shnum);
    shdrs.push([0; ELF64_SHDR_SIZE]);
    let mut build_id_desc_off: Option<usize> = None;
    for e in &ents {
        let (name, sh_type, flags, off_align, link, info, entsize, addralign, body, nobits): (
            String,
            u32,
            u64,
            u64,
            u32,
            u32,
            u64,
            u64,
            Vec<u8>,
            u64,
        ) = match e {
            Ent::Sec(i) => {
                let o = &outsecs[*i];
                // SHF_LINK_ORDER sh_link is patched after numbering.
                (
                    o.name.clone(),
                    o.sh_type,
                    o.flags,
                    o.addralign,
                    0,
                    0,
                    o.entsize,
                    o.addralign,
                    o.bytes.clone(),
                    o.nobits,
                )
            }
            Ent::Rela(i) => {
                let o = &outsecs[*i];
                let mut b = Vec::with_capacity(out_relocs[*i].len() * ELF64_RELA_SIZE);
                for &(off, sym, rtype, addend) in &out_relocs[*i] {
                    b.extend_from_slice(&off.to_le_bytes());
                    b.extend_from_slice(&(((sym as u64) << 32) | rtype as u64).to_le_bytes());
                    b.extend_from_slice(&addend.to_le_bytes());
                }
                (
                    format!(".rela{}", o.name),
                    SHT_RELA,
                    SHF_INFO_LINK | (o.flags & SHF_GROUP),
                    8,
                    symtab_final,
                    final_of_outsec[*i] as u32,
                    ELF64_RELA_SIZE as u64,
                    8,
                    b,
                    0,
                )
            }
            Ent::Group(gi) => {
                let g = &out_groups[*gi];
                (
                    ".group".to_string(),
                    SHT_GROUP,
                    0,
                    4,
                    symtab_final,
                    group_sig_sym[*gi],
                    4,
                    4,
                    group_body(g),
                    0,
                )
            }
            Ent::Symtab => (
                ".symtab".to_string(),
                SHT_SYMTAB,
                0,
                8,
                (symtab_final + 1), // .strtab follows
                first_global,
                ELF64_SYM_SIZE as u64,
                8,
                symtab_bytes.clone(),
                0,
            ),
            Ent::Strtab => (
                ".strtab".to_string(),
                SHT_STRTAB,
                0,
                1,
                0,
                0,
                0,
                1,
                strtab.clone(),
                0,
            ),
            Ent::Shstrtab => (
                String::new(), // interned below with the final table
                SHT_STRTAB,
                0,
                1,
                0,
                0,
                0,
                1,
                Vec::new(),
                0,
            ),
        };
        let is_shstr = matches!(e, Ent::Shstrtab);
        let name_off = if is_shstr {
            intern(&mut shstr, &mut shstrmap, ".shstrtab")
        } else {
            intern(&mut shstr, &mut shstrmap, &name)
        };
        let align = off_align.max(1);
        let sh_offset = if sh_type == SHT_NOBITS {
            file.len() as u64
        } else {
            let at = (file.len() as u64).next_multiple_of(align);
            file.resize(at as usize, 0);
            if build_id
                && let Ent::Sec(i) = e
                && outsecs[*i].name == ".note.gnu.build-id"
            {
                build_id_desc_off = Some(file.len() + 16);
            }
            file.extend_from_slice(&body);
            at
        };
        let sh_size = if sh_type == SHT_NOBITS {
            nobits
        } else {
            body.len() as u64
        };
        let mut h = [0u8; ELF64_SHDR_SIZE];
        h[0..4].copy_from_slice(&name_off.to_le_bytes());
        h[4..8].copy_from_slice(&sh_type.to_le_bytes());
        h[8..16].copy_from_slice(&flags.to_le_bytes());
        h[24..32].copy_from_slice(&sh_offset.to_le_bytes());
        h[32..40].copy_from_slice(&sh_size.to_le_bytes());
        h[40..44].copy_from_slice(&link.to_le_bytes());
        h[44..48].copy_from_slice(&info.to_le_bytes());
        h[48..56].copy_from_slice(&addralign.to_le_bytes());
        h[56..64].copy_from_slice(&entsize.to_le_bytes());
        shdrs.push(h);
    }
    // The shstrtab body was interned during the walk; append it now
    // and fix its header's offset/size.
    {
        let at = file.len() as u64;
        file.extend_from_slice(&shstr);
        let h = shdrs.last_mut().unwrap();
        h[24..32].copy_from_slice(&at.to_le_bytes());
        h[32..40].copy_from_slice(&(shstr.len() as u64).to_le_bytes());
    }
    // SHF_LINK_ORDER sh_link fixup: resolve via first contribution's
    // link target now that final numbering exists.
    {
        let mut placed_final: HashMap<SecId, u16> = HashMap::new();
        for (i, out) in outsecs.iter().enumerate() {
            for c in &out.contribs {
                placed_final.insert((c.obj, c.sec), final_of_outsec[i]);
            }
        }
        for (i, out) in outsecs.iter().enumerate() {
            if let Some(t) = out.link_from
                && let Some(&fin) = placed_final.get(&t)
            {
                let hi = final_of_outsec[i] as usize;
                shdrs[hi][40..44].copy_from_slice(&(fin as u32).to_le_bytes());
            }
        }
    }

    let e_shoff = (file.len() as u64).next_multiple_of(8);
    file.resize(e_shoff as usize, 0);
    for h in &shdrs {
        file.extend_from_slice(h);
    }
    // ELF header.
    file[0..4].copy_from_slice(b"\x7fELF");
    file[4] = 2; // ELFCLASS64
    file[5] = 1; // ELFDATA2LSB
    file[6] = 1; // EV_CURRENT
    file[7] = objs[0].osabi;
    file[8] = objs[0].abiversion;
    file[16..18].copy_from_slice(&ET_REL.to_le_bytes());
    file[18..20].copy_from_slice(&machine.to_le_bytes());
    file[20..24].copy_from_slice(&1u32.to_le_bytes());
    file[24..32].copy_from_slice(&0u64.to_le_bytes()); // e_entry
    file[32..40].copy_from_slice(&0u64.to_le_bytes()); // e_phoff
    file[40..48].copy_from_slice(&e_shoff.to_le_bytes());
    file[48..52].copy_from_slice(&objs[0].eflags.to_le_bytes());
    file[52..54].copy_from_slice(&64u16.to_le_bytes()); // e_ehsize
    file[54..56].copy_from_slice(&0u16.to_le_bytes()); // e_phentsize
    file[56..58].copy_from_slice(&0u16.to_le_bytes()); // e_phnum
    file[58..60].copy_from_slice(&(ELF64_SHDR_SIZE as u16).to_le_bytes());
    file[60..62].copy_from_slice(&(shnum as u16).to_le_bytes());
    file[62..64].copy_from_slice(&((shnum - 1) as u16).to_le_bytes()); // shstrtab last

    if let Some(off) = build_id_desc_off {
        let digest = sha1(&file);
        file[off..off + 20].copy_from_slice(&digest);
    }
    Ok(file)
}

/// SHA-1 (FIPS 180-4) for `--build-id=sha1`.
fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let ml = (data.len() as u64) * 8;
    let mut msg = data.to_vec();
    msg.push(0x80);
    while msg.len() % 64 != 56 {
        msg.push(0);
    }
    msg.extend_from_slice(&ml.to_be_bytes());
    let mut w = [0u32; 80];
    for chunk in msg.chunks_exact(64) {
        for (i, word) in chunk.chunks_exact(4).enumerate() {
            w[i] = u32::from_be_bytes(word.try_into().unwrap());
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let (mut a, mut b, mut c, mut d, mut e) = (h[0], h[1], h[2], h[3], h[4]);
        for (i, &wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | ((!b) & d), 0x5A827999),
                20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
                40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
                _ => (b ^ c ^ d, 0xCA62C1D6),
            };
            let tmp = a
                .rotate_left(5)
                .wrapping_add(f)
                .wrapping_add(e)
                .wrapping_add(k)
                .wrapping_add(wi);
            e = d;
            d = c;
            c = b;
            b = a.rotate_left(30);
            a = tmp;
        }
        h[0] = h[0].wrapping_add(a);
        h[1] = h[1].wrapping_add(b);
        h[2] = h[2].wrapping_add(c);
        h[3] = h[3].wrapping_add(d);
        h[4] = h[4].wrapping_add(e);
    }
    let mut out = [0u8; 20];
    for (i, x) in h.iter().enumerate() {
        out[i * 4..i * 4 + 4].copy_from_slice(&x.to_be_bytes());
    }
    out
}
