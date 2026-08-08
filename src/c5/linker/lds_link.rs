//! Script-driven native link: consumes a parsed linker script
//! (`lds.rs`) plus ELF64 ET_REL inputs read at full fidelity (every
//! section with its own bytes, flags, and relocations), lays output
//! sections out exactly as the script directs, and writes the final
//! ELF image.
//!
//! Kept apart from the default `link.rs` path: that path merges
//! family streams at fixed addresses and stays byte-identical when no
//! script is given. Here relocations are applied only after the
//! script assigns every input section its final address.
//!
//! Layout runs the statement walk repeatedly until section addresses
//! and symbol values stop changing, which is how forward references
//! (`kimage_limit` used before its assignment) and self-referential
//! sizing (RELR content depends on final addresses) resolve; GNU ld's
//! relaxation passes serve the same purpose. Diagnostics (ASSERT,
//! undefined symbols, backwards dot moves) fire only on the final
//! pass, when values are settled.

#![cfg(feature = "std")]
#![allow(dead_code)]

use alloc::borrow::ToOwned;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};
/// Per-member `(input offsets, pooled offsets)` produced by pool builders.
type PoolMemberMaps = HashMap<usize, (Vec<u64>, Vec<u64>)>;

use crate::c5::error::C5Error;

use super::lds::{
    AssignOp, Assignment, BinOp, Command, DataWidth, Expr, InputSpec, LinkerScript, OutputSection,
    OutputSectionType, SectionContent, SectionsItem, SortKind, UnOp, glob_match,
};
use super::object::{Elf64Ehdr, Elf64Shdr, read_struct};
use crate::c5::object::elf_reloc_types as rt;

fn err(msg: &str) -> C5Error {
    C5Error::Compile(format!("error: {msg}"))
}

// ELF constants.
const SHT_PROGBITS: u32 = 1;
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
/// `R_*_NONE`: recorded under `--emit-relocs`, applies nothing.
const R_NONE: u32 = 0;
const SHT_NOTE: u32 = 7;
const SHT_NOBITS: u32 = 8;
const SHT_REL: u32 = 9;
const SHT_INIT_ARRAY: u32 = 14;
const SHT_FINI_ARRAY: u32 = 15;
const SHT_PREINIT_ARRAY: u32 = 16;
const SHT_GROUP: u32 = 17;
const SHT_SYMTAB_SHNDX: u32 = 18;
const SHT_RELR: u32 = 19;
const SHT_LLVM_ADDRSIG: u32 = 0x6fff4c03;

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;
const SHF_MERGE: u64 = 0x10;
const SHF_STRINGS: u64 = 0x20;
const SHF_INFO_LINK: u64 = 0x40;
const SHF_LINK_ORDER: u64 = 0x80;
const SHF_GROUP: u64 = 0x200;
const SHF_TLS: u64 = 0x400;
const SHF_COMPRESSED: u64 = 0x800;
const SHF_EXCLUDE: u64 = 0x8000_0000;
const SHF_GNU_RETAIN: u64 = 0x0020_0000;

const SHN_UNDEF: u16 = 0;
const SHN_LORESERVE: u16 = 0xff00;
const SHN_ABS: u16 = 0xfff1;
const SHN_COMMON: u16 = 0xfff2;
const SHN_XINDEX: u16 = 0xffff;

const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
const STB_WEAK: u8 = 2;
const STT_NOTYPE: u8 = 0;
const STT_OBJECT: u8 = 1;
const STT_FUNC: u8 = 2;
const STT_SECTION: u8 = 3;
const STT_FILE: u8 = 4;
const STT_COMMON: u8 = 5;
const STV_DEFAULT: u8 = 0;
const STV_HIDDEN: u8 = 2;

const PT_LOAD: u32 = 1;
const PT_NOTE: u32 = 4;
const PT_GNU_STACK: u32 = 0x6474e551;
const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

const ET_EXEC: u16 = 2;
const ET_DYN: u16 = 3;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;

#[repr(C)]
#[derive(Clone, Copy, Default)]
struct Elf64Phdr {
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_paddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

fn align_up(v: u64, align: u64) -> u64 {
    if align <= 1 {
        return v;
    }
    v.wrapping_add(align - 1) & !(align - 1)
}

// ------------------------------------------------------------- inputs

/// One relocation, as read from a `.rela.<sec>` table.
#[derive(Debug, Clone, Copy)]
pub struct RawReloc {
    pub offset: u64,
    pub sym: u32,
    pub rtype: u32,
    pub addend: i64,
}

/// One symbol table entry, verbatim.
#[derive(Debug, Clone)]
pub struct RawSym {
    pub name: String,
    pub info: u8,
    pub other: u8,
    pub shndx: u32,
    pub value: u64,
    pub size: u64,
}

impl RawSym {
    fn binding(&self) -> u8 {
        self.info >> 4
    }
    fn kind(&self) -> u8 {
        self.info & 0xf
    }
}

/// One input section with its own identity preserved.
#[derive(Debug, Clone)]
pub struct RawSection {
    pub name: String,
    pub shtype: u32,
    pub flags: u64,
    pub addralign: u64,
    pub entsize: u64,
    /// Byte range within the owning object's file image; empty for
    /// SHT_NOBITS.
    pub data_off: usize,
    pub size: u64,
    pub relocs: Vec<RawReloc>,
    pub orig_shndx: u32,
}

/// One ET_REL input at full fidelity.
pub struct LdsObject {
    pub source: String,
    pub bytes: Vec<u8>,
    pub machine: u16,
    pub sections: Vec<RawSection>,
    pub symbols: Vec<RawSym>,
    /// Original section header index -> `sections` index.
    pub shndx_map: HashMap<u32, usize>,
}

impl LdsObject {
    fn section_data(&self, s: &RawSection) -> &[u8] {
        if s.shtype == SHT_NOBITS {
            return &[];
        }
        &self.bytes[s.data_off..s.data_off + s.size as usize]
    }
}

/// Parse an ELF64 little-endian ET_REL object preserving every
/// section. Symbol/string/reloc tables are consumed into structured
/// form; group and addrsig metadata is dropped.
pub fn parse_lds_object(source: &str, bytes: Vec<u8>) -> Result<LdsObject, C5Error> {
    if bytes.len() < 64 || &bytes[0..4] != b"\x7fELF" {
        return Err(err(&format!("{source}: not an ELF object")));
    }
    let ehdr: Elf64Ehdr = read_struct(&bytes, 0)?;
    if ehdr.e_ident[4] != 2 || ehdr.e_ident[5] != 1 {
        return Err(err(&format!("{source}: not a little-endian ELF64 object")));
    }
    if ehdr.e_type != 1 {
        return Err(err(&format!(
            "{source}: not a relocatable object (e_type {})",
            ehdr.e_type
        )));
    }
    let shoff = ehdr.e_shoff as usize;
    let mut shnum = ehdr.e_shnum as usize;
    // Extended section count: e_shnum 0 stores the real count in
    // section header 0's sh_size.
    if shnum == 0 && shoff != 0 {
        let sh0: Elf64Shdr = read_struct(&bytes, shoff)?;
        shnum = sh0.sh_size as usize;
    }
    let mut shdrs: Vec<Elf64Shdr> = Vec::with_capacity(shnum);
    for i in 0..shnum {
        shdrs.push(read_struct(&bytes, shoff + i * 64)?);
    }
    let mut shstrndx = ehdr.e_shstrndx as usize;
    if shstrndx == SHN_XINDEX as usize {
        shstrndx = shdrs[0].sh_link as usize;
    }
    let shstr = section_bytes(&bytes, shdrs.get(shstrndx), source)?;
    let sec_name = |sh: &Elf64Shdr| -> String { strz(shstr, sh.sh_name as usize) };

    // Symbol table (at most one in ET_REL).
    let mut symbols: Vec<RawSym> = Vec::new();
    let mut symtab_idx: Option<usize> = None;
    let mut shndx_ext: Vec<u32> = Vec::new();
    for (i, sh) in shdrs.iter().enumerate() {
        if sh.sh_type == SHT_SYMTAB_SHNDX {
            let raw = section_bytes(&bytes, Some(sh), source)?;
            shndx_ext = raw
                .chunks_exact(4)
                .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
                .collect();
        }
        if sh.sh_type == SHT_SYMTAB {
            symtab_idx = Some(i);
        }
    }
    if let Some(si) = symtab_idx {
        let sh = &shdrs[si];
        let strtab = section_bytes(&bytes, shdrs.get(sh.sh_link as usize), source)?;
        let raw = section_bytes(&bytes, Some(sh), source)?;
        let count = raw.len() / 24;
        symbols.reserve(count);
        for k in 0..count {
            let sym: Elf64Sym = read_struct(raw, k * 24)?;
            let shndx = if sym.st_shndx == SHN_XINDEX {
                shndx_ext.get(k).copied().unwrap_or(0)
            } else {
                sym.st_shndx as u32
            };
            symbols.push(RawSym {
                name: strz(strtab, sym.st_name as usize),
                info: sym.st_info,
                other: sym.st_other,
                shndx,
                value: sym.st_value,
                size: sym.st_size,
            });
        }
    }

    // Content sections. Metadata section types are consumed or
    // dropped, never placed.
    let mut sections: Vec<RawSection> = Vec::new();
    let mut shndx_map: HashMap<u32, usize> = HashMap::new();
    for (i, sh) in shdrs.iter().enumerate() {
        if i == 0 {
            continue;
        }
        match sh.sh_type {
            SHT_SYMTAB | SHT_STRTAB | SHT_RELA | SHT_REL | SHT_GROUP | SHT_SYMTAB_SHNDX
            | SHT_LLVM_ADDRSIG => continue,
            _ => {}
        }
        if sh.sh_flags & SHF_EXCLUDE != 0 && sh.sh_flags & SHF_ALLOC == 0 {
            continue;
        }
        let data_off = if sh.sh_type == SHT_NOBITS {
            0
        } else {
            let end = (sh.sh_offset as usize).checked_add(sh.sh_size as usize);
            match end {
                Some(e) if e <= bytes.len() => sh.sh_offset as usize,
                _ => {
                    return Err(err(&format!(
                        "{source}: section {} extends past end of file",
                        sec_name(sh)
                    )));
                }
            }
        };
        shndx_map.insert(i as u32, sections.len());
        sections.push(RawSection {
            name: sec_name(sh),
            shtype: sh.sh_type,
            flags: sh.sh_flags,
            addralign: sh.sh_addralign.max(1),
            entsize: sh.sh_entsize,
            data_off,
            size: sh.sh_size,
            relocs: Vec::new(),
            orig_shndx: i as u32,
        });
    }
    // Attach relocation tables to their sections via sh_info.
    for sh in &shdrs {
        if sh.sh_type != SHT_RELA && sh.sh_type != SHT_REL {
            continue;
        }
        let Some(&target) = shndx_map.get(&sh.sh_info) else {
            continue;
        };
        let raw = section_bytes(&bytes, Some(sh), source)?;
        if sh.sh_type == SHT_RELA {
            let count = raw.len() / 24;
            let list = &mut sections[target].relocs;
            list.reserve(count);
            for k in 0..count {
                let re: Elf64Rela = read_struct(raw, k * 24)?;
                list.push(RawReloc {
                    offset: re.r_offset,
                    sym: (re.r_info >> 32) as u32,
                    rtype: re.r_info as u32,
                    addend: re.r_addend,
                });
            }
        } else {
            return Err(err(&format!(
                "{source}: SHT_REL (implicit-addend) relocations are not supported"
            )));
        }
    }
    Ok(LdsObject {
        source: source.to_string(),
        bytes,
        machine: ehdr.e_machine,
        sections,
        symbols,
        shndx_map,
    })
}

fn section_bytes<'a>(
    bytes: &'a [u8],
    sh: Option<&Elf64Shdr>,
    source: &str,
) -> Result<&'a [u8], C5Error> {
    let sh = sh.ok_or_else(|| err(&format!("{source}: missing section header")))?;
    if sh.sh_type == SHT_NOBITS {
        return Ok(&[]);
    }
    let start = sh.sh_offset as usize;
    let end = start
        .checked_add(sh.sh_size as usize)
        .filter(|&e| e <= bytes.len())
        .ok_or_else(|| err(&format!("{source}: section extends past end of file")))?;
    Ok(&bytes[start..end])
}

fn strz(tab: &[u8], off: usize) -> String {
    if off >= tab.len() {
        return String::new();
    }
    let end = tab[off..]
        .iter()
        .position(|&b| b == 0)
        .map(|p| off + p)
        .unwrap_or(tab.len());
    String::from_utf8_lossy(&tab[off..end]).into_owned()
}

// ------------------------------------------------------------ options

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum OrphanHandling {
    Place,
    Warn,
    Error,
    Discard,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LdsEmit {
    Exec,
    Dyn,
}

#[derive(Debug, Clone)]
pub struct LdsOptions {
    pub emit: LdsEmit,
    pub entry_override: Option<String>,
    pub max_page_size: u64,
    pub orphan_handling: OrphanHandling,
    pub build_id_sha1: bool,
    pub strip_debug: bool,
    /// `-X`: drop compiler-temporary local symbols (`.L*`).
    pub discard_locals: bool,
    /// `--discard-none`: keep every local symbol.
    pub discard_none: bool,
    /// `-z pack-relative-relocs`: RELR-pack aligned relative entries.
    pub pack_relative_relocs: bool,
    /// `--no-apply-dynamic-relocs` clears this: RELA-covered slots
    /// keep their input bytes. RELR-covered slots always get the
    /// link-time value (the format stores the addend in place).
    pub apply_dynamic_relocs: bool,
    /// `--emit-relocs`: carry every applied input relocation into the
    /// output as `.rela.<outsec>` entries against the output symtab.
    pub emit_relocs: bool,
    pub emit_warnings: bool,
}

impl Default for LdsOptions {
    fn default() -> Self {
        LdsOptions {
            emit: LdsEmit::Exec,
            entry_override: None,
            max_page_size: 0x1000,
            orphan_handling: OrphanHandling::Place,
            build_id_sha1: false,
            strip_debug: false,
            discard_locals: false,
            discard_none: false,
            pack_relative_relocs: false,
            apply_dynamic_relocs: true,
            emit_relocs: false,
            emit_warnings: true,
        }
    }
}

// ------------------------------------------------------------- engine

/// Where an input section ended up.
#[derive(Debug, Clone, Copy, PartialEq)]
enum SecFate {
    /// Not yet claimed by any spec.
    Unclaimed,
    /// Claimed by output section `out` (index into `outs`).
    Placed {
        out: usize,
    },
    Discarded,
}

#[derive(Debug, Clone, Copy)]
struct InSecId {
    obj: usize,
    sec: usize,
}

/// A content element of an output section, in statement order.
#[derive(Debug, Clone)]
enum Piece {
    /// The claimed input sections of one spec, in claim order
    /// (indices into `insecs`).
    Inputs(Vec<usize>),
    Data(DataWidth, Expr),
    Assign(Assignment),
    Assert(Expr, String),
    Fill(Expr),
}

/// Output section under construction.
struct OutSec {
    name: String,
    address: Option<Expr>,
    stype: Option<OutputSectionType>,
    at: Option<Expr>,
    align_attr: Option<Expr>,
    pieces: Vec<Piece>,
    phdrs: Vec<String>,
    fill: Option<Expr>,
    // Computed per pass:
    addr: u64,
    lma: u64,
    size: u64,
    align: u64,
    flags: u64,
    shtype: u32,
    entsize: u64,
    alloc: bool,
    removed: bool,
    file_bytes: bool,
    /// Fixed byte layout of the section body: (offset, length,
    /// source), rebuilt each pass.
    chunks: Vec<(u64, u64, ChunkSrc)>,
}

#[derive(Debug, Clone)]
enum ChunkSrc {
    Input(usize),
    Bytes(Vec<u8>),
    /// Fill pattern applied over the range.
    Pad(Vec<u8>),
}

/// Attachment of an expression value / symbol. A plain number and an
/// address taken from the location counter outside any output section
/// are both absolute in expressions, but only the latter picks up a
/// symtab section through section_for_dot (ld's rel_from_abs).
#[derive(Debug, Clone, Copy, PartialEq)]
enum Att {
    Abs,
    DotAbs,
    Out(usize),
}

#[derive(Debug, Clone, Copy)]
struct Val {
    v: u64,
    att: Att,
}

impl Val {
    fn abs(v: u64) -> Val {
        Val { v, att: Att::Abs }
    }
}

#[derive(Debug, Clone)]
struct ScriptSym {
    val: Val,
    hidden: bool,
    /// Output section carrying the symbol in the symtab when the
    /// value came from the location counter outside any output
    /// section (ld's section_for_dot fixup); the value itself stays
    /// absolute for expression purposes.
    final_out: Option<usize>,
}

/// One input section's per-pass placement.
#[derive(Clone, Copy, Default)]
struct Placement {
    out: usize,
    off: u64,
    placed: bool,
}

/// Merged SHF_MERGE pool for one output section + (entsize, strings)
/// class.
struct MergePool {
    /// Pool bytes.
    bytes: Vec<u8>,
    /// Per input section: mapping from input offsets (entry starts)
    /// to pool offsets, as parallel sorted vectors.
    maps: HashMap<usize, (Vec<u64>, Vec<u64>)>,
    /// Which input (index into `insecs`) carries the pool bytes.
    rep: usize,
    /// Pool alignment (all members share it -- it is part of the pool key).
    align: u64,
}

struct DynReloc {
    offset: u64,
    rtype: u32,
    addend: i64,
}

pub struct LdsLinker<'a> {
    script: &'a LinkerScript,
    objects: Vec<LdsObject>,
    opts: LdsOptions,
    machine: u16,

    /// Flattened input sections across objects.
    insecs: Vec<InSecId>,
    /// First `insecs` index of each object.
    obj_base: Vec<usize>,
    fates: Vec<SecFate>,
    /// insec index -> merge pool key, for merged sections.
    merge_of: HashMap<usize, usize>,
    pools: Vec<MergePool>,

    outs: Vec<OutSec>,
    /// Statement stream of the SECTIONS block with input claims
    /// resolved; `usize` indexes `outs`.
    stmts: Vec<Stmt>,

    /// Global symbol resolution: name -> defining (obj, sym index).
    globals: HashMap<String, (usize, usize)>,
    /// Common symbols coalesced into a synthetic bss chunk:
    /// name -> (insec index, offset, size, align).
    commons: HashMap<String, (usize, u64)>,

    // Per-pass state.
    placements: Vec<Placement>,
    script_now: HashMap<String, ScriptSym>,
    script_prev: HashMap<String, ScriptSym>,
    dot: u64,
    cur_out: Option<usize>,
    /// ld's dot-attachment state for assignments outside output
    /// sections: the last allocated output section visited, whether a
    /// top-level dot assignment makes following symbols prefer the
    /// next section, the statement index being executed, whether the
    /// `end` symbol was assigned yet, and per-output-section copies
    /// of that flag at visit time.
    dot_section: Option<usize>,
    prefer_next: bool,
    cur_stmt: usize,
    found_end: bool,
    after_end: Vec<bool>,
    lma_delta: u64,
    final_pass: bool,
    errors: Vec<String>,
    warnings: Vec<String>,
    undefined: BTreeSet<String>,
    referenced: HashSet<String>,

    /// Synthetic content owned by the pseudo-object (last in
    /// `objects`): index of the pseudo object.
    synth_obj: usize,
    dyn_relas: Vec<DynReloc>,
    /// Reserved-but-never-written `.rela.dyn` slots (see
    /// `count_reserved_none_slots`), computed once per link.
    dyn_nones: Option<u64>,
    relr_addrs: Vec<u64>,
    /// GOT slots, keyed by referenced symbol name (a GOT reference to
    /// an undefined symbol still needs a slot).
    got_slots: Vec<String>,
    got_map: HashMap<String, usize>,
    /// `--emit-relocs`: every relocation applied to an output section,
    /// recorded on the final pass and written back as `.rela.<outsec>`.
    emitted: Vec<EmittedReloc>,
    /// Where `build_symtab` put each symbol, for resolving `emitted`.
    sym_index: SymIndex,
}

/// Where each symbol landed in `build_symtab`'s output, for resolving
/// `--emit-relocs` records. Positions index that vector, not the ELF
/// table, which the writer reorders locals-first.
#[derive(Default)]
struct SymIndex {
    /// Output section index -> its section symbol.
    sec: HashMap<usize, usize>,
    /// (object, input symbol index) -> emitted local.
    local: HashMap<(usize, u32), usize>,
    /// Global, script-defined and undefined-weak symbols by name.
    by_name: HashMap<String, usize>,
}

/// One applied relocation kept for `--emit-relocs`. The referenced
/// symbol is named by its input slot; the output symtab index is
/// resolved once the table exists.
#[derive(Debug, Clone, Copy)]
struct EmittedReloc {
    out: usize,
    addr: u64,
    rtype: u32,
    /// Resolved `S + A`. The emitted addend is this less the final
    /// value of the symbol the entry names, which is not the input
    /// addend whenever the reference folds into an output section
    /// symbol.
    target: u64,
    obj: usize,
    sym: u32,
}

#[derive(Debug, Clone)]
enum Stmt {
    Assign(Assignment),
    Assert(Expr, String),
    Open(usize),
}

const SYNTH_RELA: &str = ".rela.dyn";
const SYNTH_RELR: &str = ".relr.dyn";
const SYNTH_GOT: &str = ".got";
const SYNTH_GOTPLT: &str = ".got.plt";
const SYNTH_BUILD_ID: &str = ".note.gnu.build-id";
const SYNTH_COMMON: &str = "COMMON";

#[derive(Debug)]
pub struct LdsResult {
    pub image: Vec<u8>,
    pub map: String,
    pub warnings: Vec<String>,
}

pub fn link_with_script(
    script: &LinkerScript,
    inputs: Vec<LdsObject>,
    opts: &LdsOptions,
) -> Result<LdsResult, C5Error> {
    let mut linker = LdsLinker::new(script, inputs, opts.clone())?;
    linker.run()
}

impl<'a> LdsLinker<'a> {
    fn new(
        script: &'a LinkerScript,
        mut objects: Vec<LdsObject>,
        opts: LdsOptions,
    ) -> Result<Self, C5Error> {
        if objects.is_empty() {
            return Err(err("no input objects"));
        }
        let machine = objects[0].machine;
        for o in &objects[1..] {
            if o.machine != machine {
                return Err(err(&format!(
                    "{}: machine {} differs from {}'s {}",
                    o.source, o.machine, objects[0].source, machine
                )));
            }
        }
        if opts.strip_debug {
            for o in &mut objects {
                if !o.sections.iter().any(|s| is_debug_section(&s.name)) {
                    continue;
                }
                o.sections.retain(|s| !is_debug_section(&s.name));
                o.shndx_map = o
                    .sections
                    .iter()
                    .enumerate()
                    .map(|(i, s)| (s.orig_shndx, i))
                    .collect();
            }
        }
        // Pseudo-object for linker-synthesized sections.
        let synth_obj = objects.len();
        objects.push(LdsObject {
            source: "<linker>".to_string(),
            bytes: Vec::new(),
            machine,
            sections: Vec::new(),
            symbols: Vec::new(),
            shndx_map: HashMap::new(),
        });

        let mut linker = LdsLinker {
            script,
            objects,
            opts,
            machine,
            insecs: Vec::new(),
            obj_base: Vec::new(),
            fates: Vec::new(),
            merge_of: HashMap::new(),
            pools: Vec::new(),
            outs: Vec::new(),
            stmts: Vec::new(),
            globals: HashMap::new(),
            commons: HashMap::new(),
            placements: Vec::new(),
            script_now: HashMap::new(),
            script_prev: HashMap::new(),
            dot: 0,
            cur_out: None,
            dot_section: None,
            prefer_next: false,
            cur_stmt: 0,
            found_end: false,
            after_end: Vec::new(),
            lma_delta: 0,
            final_pass: false,
            errors: Vec::new(),
            warnings: Vec::new(),
            undefined: BTreeSet::new(),
            referenced: HashSet::new(),
            synth_obj,
            dyn_relas: Vec::new(),
            dyn_nones: None,
            relr_addrs: Vec::new(),
            got_slots: Vec::new(),
            got_map: HashMap::new(),
            emitted: Vec::new(),
            sym_index: SymIndex::default(),
        };
        linker.resolve_globals()?;
        linker.synthesize_sections();
        linker.flatten_inputs();
        linker.build_statements()?;
        linker.claim_inputs()?;
        linker.build_merge_pools();
        Ok(linker)
    }

    // ---------------------------------------------------- symbol prep

    fn resolve_globals(&mut self) -> Result<(), C5Error> {
        // Strong definitions win over weak; two strongs collide.
        let mut strong: HashMap<String, (usize, usize)> = HashMap::new();
        let mut weak: HashMap<String, (usize, usize)> = HashMap::new();
        let mut common: HashMap<String, (u64, u64, usize, usize)> = HashMap::new();
        for (oi, o) in self.objects.iter().enumerate() {
            for (si, s) in o.symbols.iter().enumerate() {
                if s.name.is_empty() || s.binding() == STB_LOCAL {
                    continue;
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

    fn push_synth_section(&mut self, name: &str, shtype: u32, flags: u64) -> usize {
        let synth = self.synth_obj;
        let obj = &mut self.objects[synth];
        let idx = obj.sections.len();
        let orig_shndx = idx as u32 + 1;
        obj.sections.push(RawSection {
            name: name.to_string(),
            shtype,
            flags,
            addralign: 8,
            entsize: 0,
            data_off: 0,
            size: 0,
            relocs: Vec::new(),
            orig_shndx,
        });
        obj.shndx_map.insert(orig_shndx, idx);
        idx
    }

    fn synthesize_sections(&mut self) {
        if self.opts.build_id_sha1 {
            let idx = self.push_synth_section(SYNTH_BUILD_ID, SHT_NOTE, SHF_ALLOC);
            let synth = self.synth_obj;
            let sec = &mut self.objects[synth].sections[idx];
            sec.addralign = 4;
            sec.size = 36; // 12-byte header + "GNU\0" + 20-byte sha1
        }
        if self.opts.emit == LdsEmit::Dyn {
            let rela = self.push_synth_section(SYNTH_RELA, SHT_RELA, SHF_ALLOC);
            // `.relr.dyn` exists only where RELR packing was asked for.
            // Creating it unconditionally leaves an empty section no
            // script names, which `--orphan-handling=error` rejects.
            let relr = self
                .opts
                .pack_relative_relocs
                .then(|| self.push_synth_section(SYNTH_RELR, SHT_RELR, SHF_ALLOC));
            let got = self.push_synth_section(SYNTH_GOT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let gotplt = self.push_synth_section(SYNTH_GOTPLT, SHT_PROGBITS, SHF_ALLOC | SHF_WRITE);
            let synth = self.synth_obj;
            self.objects[synth].sections[rela].entsize = 24;
            if let Some(relr) = relr {
                self.objects[synth].sections[relr].entsize = 8;
            }
            self.objects[synth].sections[got].entsize = 8;
            // .got: one reserved header slot; GOT slots append per use.
            self.objects[synth].sections[got].size = 8;
            // .got.plt: three reserved slots, no PLT entries.
            self.objects[synth].sections[gotplt].entsize = 8;
            self.objects[synth].sections[gotplt].size = 24;
        }
    }

    fn flatten_inputs(&mut self) {
        for (oi, o) in self.objects.iter().enumerate() {
            self.obj_base.push(self.insecs.len());
            for si in 0..o.sections.len() {
                self.insecs.push(InSecId { obj: oi, sec: si });
                self.fates.push(SecFate::Unclaimed);
            }
        }
        self.placements = alloc::vec![Placement::default(); self.insecs.len()];
    }

    fn insec(&self, i: usize) -> &RawSection {
        let id = self.insecs[i];
        &self.objects[id.obj].sections[id.sec]
    }

    fn insec_index(&self, obj: usize, sec: usize) -> usize {
        self.obj_base[obj] + sec
    }

    // ------------------------------------------------------- claiming

    fn build_statements(&mut self) -> Result<(), C5Error> {
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
                        name: o.name.clone(),
                        address: o.address.clone(),
                        stype: o.stype,
                        at: o.at.clone(),
                        align_attr: o.align.clone(),
                        pieces: Vec::new(),
                        phdrs: o.phdrs.clone(),
                        fill: o.fill.clone(),
                        addr: 0,
                        lma: 0,
                        size: 0,
                        align: 1,
                        flags: 0,
                        shtype: SHT_PROGBITS,
                        entsize: 0,
                        alloc: false,
                        removed: false,
                        file_bytes: false,
                        chunks: Vec::new(),
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
    fn claim_inputs(&mut self) -> Result<(), C5Error> {
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
        let (name, flags) = {
            let s = self.insec(i);
            (s.name.clone(), s.flags)
        };
        // Same-name output section: append there.
        if let Some((oi, _)) = self.outs.iter().enumerate().find(|(_, o)| o.name == name) {
            self.fates[i] = SecFate::Placed { out: oi };
            self.outs[oi].pieces.push(Piece::Inputs(alloc::vec![i]));
            return;
        }
        // New output section named after the input, placed after the
        // last section of the same allocation class (walk the
        // statement stream to keep layout order consistent).
        let class = |f: u64| -> u32 {
            if f & SHF_ALLOC == 0 {
                3
            } else if f & SHF_EXECINSTR != 0 {
                0
            } else if f & SHF_WRITE == 0 {
                1
            } else {
                2
            }
        };
        let want = class(flags);
        let mut insert_after: Option<usize> = None; // index into stmts
        for (si, st) in self.stmts.iter().enumerate() {
            if let Stmt::Open(oi) = st {
                let of = self.section_input_flags(*oi);
                if class(of) <= want {
                    insert_after = Some(si);
                }
            }
        }
        let new_out = self.outs.len();
        self.outs.push(OutSec {
            name,
            address: None,
            stype: None,
            at: None,
            align_attr: None,
            pieces: alloc::vec![Piece::Inputs(alloc::vec![i])],
            phdrs: Vec::new(),
            fill: None,
            addr: 0,
            lma: 0,
            size: 0,
            align: 1,
            flags: 0,
            shtype: SHT_PROGBITS,
            entsize: 0,
            alloc: false,
            removed: false,
            file_bytes: false,
            chunks: Vec::new(),
        });
        let pos = insert_after.map(|s| s + 1).unwrap_or(self.stmts.len());
        self.stmts.insert(pos, Stmt::Open(new_out));
        self.fates[i] = SecFate::Placed { out: new_out };
    }

    /// Union of the input flags currently claimed by output `oi`.
    fn section_input_flags(&self, oi: usize) -> u64 {
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

    // ---------------------------------------------------- merge pools

    /// Deduplicate SHF_MERGE sections without relocations, following
    /// bfd's merge pass (`bfd/merge.c`): a separate pool per output
    /// section and (entsize, strings, alignment) class. A section
    /// whose entsize/alignment relation fails bfd's sanity check, or
    /// whose size is not an entsize multiple, stays unmerged. The
    /// pool replaces the first member's bytes; other members
    /// contribute nothing and their offsets remap.
    fn build_merge_pools(&mut self) {
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

    /// Effective placed size of input section `i` (0 for non-
    /// representative members of a merge pool).
    fn insec_placed_size(&self, i: usize) -> u64 {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return self.pools[p].bytes.len() as u64;
            }
            return 0;
        }
        self.insec(i).size
    }

    // --------------------------------------------------------- layout

    fn run(&mut self) -> Result<LdsResult, C5Error> {
        let mut prev_fingerprint: Option<Vec<u64>> = None;
        let mut converged = false;
        for _pass in 0..48 {
            self.layout_pass(false)?;
            let fp = self.fingerprint();
            if prev_fingerprint.as_ref() == Some(&fp) {
                converged = true;
                break;
            }
            prev_fingerprint = Some(fp);
        }
        if !converged {
            return Err(err("script layout did not converge"));
        }
        self.layout_pass(true)?;
        if !self.errors.is_empty() {
            return Err(err(&self.errors.join("\n")));
        }
        if !self.undefined.is_empty() {
            let list: Vec<String> = self
                .undefined
                .iter()
                .take(30)
                .map(|s| format!("  undefined reference to `{s}'"))
                .collect();
            let extra = if self.undefined.len() > 30 {
                format!("\n  ... {} undefined symbols total", self.undefined.len())
            } else {
                String::new()
            };
            return Err(err(&format!("{}{}", list.join("\n"), extra)));
        }
        self.finish()
    }

    fn fingerprint(&self) -> Vec<u64> {
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
        fp
    }

    fn layout_pass(&mut self, final_pass: bool) -> Result<(), C5Error> {
        self.final_pass = final_pass;
        self.script_prev = core::mem::take(&mut self.script_now);
        // Dynamic machinery is sized from the previous pass's placement
        // (the `placed` flags and offsets still hold here); do it before
        // resetting for this pass. Skipped on the first pass, where no
        // placement exists yet -- the relocation sections start empty
        // and gain their size once a pass has run.
        self.size_dynamic_sections();
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
        let alloc = !info_type && !(explicit_zero && non_alloc_inputs);

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
        let mut file_bytes = false;
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
                            if let Some(f) = &fill_bytes
                                && !nobits
                                && !all_nobits
                            {
                                chunks.push((off, aligned - off, ChunkSrc::Pad(f.clone())));
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
                            if new_off > off
                                && let Some(f) = &fill_bytes
                                && !all_nobits
                            {
                                chunks.push((off, new_off - off, ChunkSrc::Pad(f.clone())));
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
        // Merge-related flags survive only when every input agrees.
        let mut flags =
            in_flags & !(SHF_GROUP | SHF_LINK_ORDER | SHF_INFO_LINK | SHF_GNU_RETAIN | SHF_EXCLUDE);
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
        if self.outs[oi].name == SYNTH_RELA && self.opts.emit == LdsEmit::Dyn && size > 0 {
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
        self.cur_out = None;
    }

    fn synth_out_type(&self, oi: usize) -> Option<u32> {
        for p in &self.outs[oi].pieces {
            if let Piece::Inputs(v) = p {
                for &i in v {
                    let id = self.insecs[i];
                    if id.obj == self.synth_obj {
                        let t = self.objects[id.obj].sections[id.sec].shtype;
                        if t == SHT_RELA || t == SHT_RELR {
                            return Some(t);
                        }
                    }
                }
            }
        }
        None
    }

    // ---------------------------------------------------- assignments

    fn exec_assignment(&mut self, a: &Assignment, after_sections: bool) {
        if a.symbol == "." {
            let v = self.eval(&a.value).v;
            let new = self.apply_assign_op(self.dot, a.op, v);
            if after_sections {
                return; // `. = ASSERT(...)` after SECTIONS: check only
            }
            self.dot = new;
            return;
        }
        if a.provide {
            // PROVIDE defines only referenced, otherwise-undefined
            // symbols; an inactive PROVIDE never evaluates its value.
            if self.globals.contains_key(&a.symbol) || !self.referenced.contains(&a.symbol) {
                return;
            }
        }
        if a.symbol.trim_start_matches('_') == "end" {
            self.found_end = true;
        }
        let cur = self.lookup(&a.symbol);
        let rhs = self.eval(&a.value);
        let value = match a.op {
            AssignOp::Set => rhs,
            _ => {
                let base = cur.map(|v| v.v).unwrap_or(0);
                Val {
                    v: self.apply_assign_op(base, a.op, rhs.v),
                    att: rhs.att,
                }
            }
        };
        // Computed every pass: the dynamic-fixup sizing consults the
        // previous pass's table before the final one runs.
        let final_out = if value.att == Att::DotAbs {
            self.section_for_dot()
        } else {
            None
        };
        self.script_now.insert(
            a.symbol.clone(),
            ScriptSym {
                val: value,
                hidden: a.hidden,
                final_out,
            },
        );
    }

    /// ld's section_for_dot: the symtab section for a symbol assigned
    /// from the location counter outside any output section.
    /// Assignments attach to the previous allocated section, except
    /// that after a top-level dot assignment (or before any section)
    /// they attach to the section following the statement; past the
    /// `end` assignment the previous section wins again. The walks
    /// skip removed and non-allocated sections.
    fn section_for_dot(&self) -> Option<usize> {
        // `removed` is only settled after the last pass; an empty
        // section is already known stripped here (sizes converged).
        let stripped = |oi: usize| self.outs[oi].size == 0 || self.outs[oi].name == "/DISCARD/";
        let is_alloc =
            |oi: usize| self.outs[oi].alloc && !stripped(oi) && self.outs[oi].flags & SHF_TLS == 0;
        let opens: Vec<usize> = self
            .stmts
            .iter()
            .filter_map(|s| match s {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .collect();
        if self.dot_section.is_none() || self.prefer_next {
            let mut nxt = self
                .stmts
                .iter()
                .skip(self.cur_stmt + 1)
                .filter_map(|s| match s {
                    Stmt::Open(oi) => Some(*oi),
                    _ => None,
                })
                .peekable();
            let mut os = nxt.next();
            while let Some(o) = os {
                if !self.after_end[o] && stripped(o) {
                    os = nxt.next();
                } else {
                    break;
                }
            }
            if self.dot_section.is_none() || os.is_none_or(|o| !self.after_end[o]) {
                // Walk backward from the found section (or the last
                // one) to the nearest allocated section.
                let start = match os {
                    Some(o) => opens.iter().position(|&x| x == o)?,
                    None => opens.len().checked_sub(1)?,
                };
                return opens[..=start].iter().rev().copied().find(|&o| is_alloc(o));
            }
        }
        let s = self.dot_section?;
        let pos = opens.iter().position(|&x| x == s)?;
        if let Some(o) = opens[..=pos].iter().rev().copied().find(|&o| is_alloc(o)) {
            return Some(o);
        }
        opens.iter().copied().find(|&o| is_alloc(o))
    }

    fn apply_assign_op(&self, base: u64, op: AssignOp, v: u64) -> u64 {
        match op {
            AssignOp::Set => v,
            AssignOp::Add => base.wrapping_add(v),
            AssignOp::Sub => base.wrapping_sub(v),
            AssignOp::Mul => base.wrapping_mul(v),
            AssignOp::Div => {
                if v == 0 {
                    0
                } else {
                    ((base as i64) / (v as i64)) as u64
                }
            }
            AssignOp::Shl => base.wrapping_shl(v as u32),
            AssignOp::Shr => base.wrapping_shr(v as u32),
            AssignOp::And => base & v,
            AssignOp::Or => base | v,
        }
    }

    fn exec_assert(&mut self, e: &Expr, msg: &str) {
        let v = self.eval(e);
        if self.final_pass && v.v == 0 {
            self.errors.push(format!("assertion failed: {msg}"));
        }
    }

    // ----------------------------------------------------- evaluation

    fn lookup(&mut self, name: &str) -> Option<Val> {
        if name == "." {
            // Inside an output section dot is section-relative;
            // outside it is absolute and marks the evaluation so a
            // defined symbol can still pick up a symtab section
            // through section_for_dot.
            let att = match self.cur_out {
                Some(o) => Att::Out(o),
                None => Att::DotAbs,
            };
            return Some(Val { v: self.dot, att });
        }
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val);
        }
        if let Some(&(oi, si)) = self.globals.get(name)
            && let Some(v) = self.object_sym_val(oi, si)
        {
            return Some(v);
        }
        if let Some(s) = self.script_prev.get(name) {
            return Some(s.val);
        }
        None
    }

    /// Value of a defined object symbol under the current pass's
    /// placement (falling back to the previous pass for sections not
    /// yet placed this pass).
    fn object_sym_val(&self, oi: usize, si: usize) -> Option<Val> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(Val::abs(sym.value)),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // Sections placed earlier in this pass carry
                        // exact values; later ones fall back to the
                        // previous pass's placement, which matches at
                        // convergence.
                        let off = if self.merge_of.contains_key(&i) {
                            self.merge_remap(i, sym.value)
                        } else {
                            sym.value
                        };
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            self.placements[i].off
                        };
                        Some(Val {
                            v: self.outs[out].addr.wrapping_add(base).wrapping_add(off),
                            att: Att::Out(out),
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    fn eval(&mut self, e: &Expr) -> Val {
        self.eval_with_dot(e, self.dot)
    }

    fn eval_with_dot(&mut self, e: &Expr, dot: u64) -> Val {
        let saved = self.dot;
        self.dot = dot;
        let v = self.eval_inner(e);
        self.dot = saved;
        v
    }

    fn eval_inner(&mut self, e: &Expr) -> Val {
        match e {
            Expr::Number(n) => Val::abs(*n),
            Expr::Symbol(name) => match self.lookup(name) {
                Some(v) => v,
                None => {
                    if self.final_pass {
                        self.undefined.insert(name.clone());
                    }
                    Val::abs(0)
                }
            },
            Expr::Unary(op, a) => {
                let a = self.eval_inner(a);
                let v = match op {
                    UnOp::Neg => a.v.wrapping_neg(),
                    UnOp::Not => (a.v == 0) as u64,
                    UnOp::BitNot => !a.v,
                };
                Val::abs(v)
            }
            Expr::Binary(op, a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                let v = match op {
                    BinOp::Add => a.v.wrapping_add(b.v),
                    BinOp::Sub => a.v.wrapping_sub(b.v),
                    BinOp::Mul => a.v.wrapping_mul(b.v),
                    BinOp::Div => {
                        if b.v == 0 {
                            if self.final_pass {
                                self.errors.push("division by zero in script".to_string());
                            }
                            0
                        } else {
                            ((a.v as i64) / (b.v as i64)) as u64
                        }
                    }
                    BinOp::Rem => {
                        if b.v == 0 {
                            0
                        } else {
                            ((a.v as i64) % (b.v as i64)) as u64
                        }
                    }
                    BinOp::Shl => a.v.wrapping_shl(b.v as u32),
                    BinOp::Shr => a.v.wrapping_shr(b.v as u32),
                    BinOp::Eq => (a.v == b.v) as u64,
                    BinOp::Ne => (a.v != b.v) as u64,
                    BinOp::Lt => (a.v < b.v) as u64,
                    BinOp::Le => (a.v <= b.v) as u64,
                    BinOp::Gt => (a.v > b.v) as u64,
                    BinOp::Ge => (a.v >= b.v) as u64,
                    BinOp::BitAnd => a.v & b.v,
                    BinOp::BitOr => a.v | b.v,
                    BinOp::BitXor => a.v ^ b.v,
                    BinOp::LogAnd => ((a.v != 0) && (b.v != 0)) as u64,
                    BinOp::LogOr => ((a.v != 0) || (b.v != 0)) as u64,
                };
                // Section-relative + absolute keeps the section;
                // difference of two section values is absolute.
                let att = match (op, a.att, b.att) {
                    (BinOp::Add, Att::Out(s), Att::Abs) => Att::Out(s),
                    (BinOp::Add, Att::Abs, Att::Out(s)) => Att::Out(s),
                    (BinOp::Sub, Att::Out(s), Att::Abs) => Att::Out(s),
                    // A dot address plus/minus a number stays a dot
                    // address; any other combination is a number.
                    (BinOp::Add, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    (BinOp::Add, Att::Abs, Att::DotAbs) => Att::DotAbs,
                    (BinOp::Sub, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    _ => Att::Abs,
                };
                Val { v, att }
            }
            Expr::Ternary(c, t, f) => {
                let c = self.eval_inner(c);
                if c.v != 0 {
                    self.eval_inner(t)
                } else {
                    self.eval_inner(f)
                }
            }
            Expr::AlignDot(a) => {
                let a = self.eval_inner(a);
                let att = match self.cur_out {
                    Some(o) => Att::Out(o),
                    None => Att::DotAbs,
                };
                Val {
                    v: align_up(self.dot, a.v),
                    att,
                }
            }
            Expr::Align2(v, a) => {
                let (v, a) = (self.eval_inner(v), self.eval_inner(a));
                Val {
                    v: align_up(v.v, a.v),
                    att: v.att,
                }
            }
            Expr::Absolute(a) => Val::abs(self.eval_inner(a).v),
            Expr::Addr(name) => match self.find_out(name) {
                Some(oi) => Val {
                    v: self.outs[oi].addr,
                    att: Att::Out(oi),
                },
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("ADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Loadaddr(name) => match self.find_out(name) {
                Some(oi) => Val::abs(self.outs[oi].lma),
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("LOADADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Sizeof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].size)
                    .unwrap_or(0),
            ),
            Expr::Alignof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].align)
                    .unwrap_or(0),
            ),
            Expr::SizeofHeaders => {
                let phnum = self.phdr_count_estimate();
                Val::abs(64 + phnum as u64 * 56)
            }
            Expr::Defined(name) => {
                let defined = self.script_now.contains_key(name)
                    || self.script_prev.contains_key(name)
                    || self.globals.contains_key(name);
                Val::abs(defined as u64)
            }
            Expr::Min(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.min(b.v))
            }
            Expr::Max(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.max(b.v))
            }
            Expr::Assert(inner, msg) => {
                let v = self.eval_inner(inner);
                if self.final_pass && v.v == 0 {
                    self.errors.push(format!("assertion failed: {msg}"));
                }
                v
            }
        }
    }

    fn find_out(&self, name: &str) -> Option<usize> {
        self.outs.iter().position(|o| o.name == name)
    }

    fn phdr_count_estimate(&self) -> usize {
        self.script.phdrs().map(|p| p.len()).unwrap_or(4)
    }

    // -------------------------------------------- dynamic reloc sizing

    /// Compute the ET_DYN dynamic-relocation payload (RELA + RELR) and
    /// GOT slots from the previous pass's layout, updating the
    /// synthetic input sections' sizes for this pass.
    fn size_dynamic_sections(&mut self) {
        if self.opts.emit != LdsEmit::Dyn {
            return;
        }
        self.dyn_relas.clear();
        self.relr_addrs.clear();
        // GOT slot set stays stable across passes (driven by reloc
        // types alone), so compute it once.
        if self.got_slots.is_empty() && self.got_map.is_empty() {
            let mut slots: Vec<String> = Vec::new();
            let mut map: HashMap<String, usize> = HashMap::new();
            for i in 0..self.insecs.len() {
                let SecFate::Placed { .. } = self.fates[i] else {
                    continue;
                };
                let id = self.insecs[i];
                for r in &self.objects[id.obj].sections[id.sec].relocs {
                    if matches!(
                        r.rtype,
                        rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC
                    ) {
                        let name = self.objects[id.obj].symbols[r.sym as usize].name.clone();
                        if name.is_empty() {
                            continue;
                        }
                        map.entry(name.clone()).or_insert_with(|| {
                            slots.push(name);
                            slots.len() - 1
                        });
                    }
                }
            }
            self.got_slots = slots;
            self.got_map = map;
        }
        // Collect absolute-64 sites in allocated output sections; each
        // becomes a RELATIVE entry. bfd packs a site into RELR when
        // its input offset is even and the input section's alignment
        // is above one (the output address parity then follows);
        // other sites keep RELA entries.
        let mut rel_addrs: Vec<(u64, i64, bool)> = Vec::new();
        let mut sym_relas: Vec<DynReloc> = Vec::new();
        let abs64 = if self.machine == EM_AARCH64 {
            rt::R_AARCH64_ABS64
        } else {
            rt::R_X86_64_64
        };
        for i in 0..self.insecs.len() {
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if !self.outs[out].alloc || self.outs[out].removed {
                continue;
            }
            let p = self.placements[i];
            if !p.placed {
                continue;
            }
            let id = self.insecs[i];
            let base = self.outs[out].addr + p.off;
            let packable = self.objects[id.obj].sections[id.sec].addralign > 1;
            for r in &self.objects[id.obj].sections[id.sec].relocs {
                if r.rtype != abs64 {
                    continue;
                }
                // Only a load-address (section-relative) target needs a
                // load-time RELATIVE fixup; an absolute constant does
                // not. An unresolved default-visibility weak reference
                // keeps a symbol-based entry, as bfd leaves its
                // resolution to load time.
                if !self.reloc_is_relative(id.obj, r.sym as usize) {
                    if self.undefweak_dynamic(id.obj, r.sym as usize) {
                        sym_relas.push(DynReloc {
                            offset: base + r.offset,
                            rtype: abs64,
                            addend: r.addend,
                        });
                    }
                    continue;
                }
                let target = self.resolve_sym_prevpass(id.obj, r.sym as usize, r.addend);
                let Some(target) = target else { continue };
                rel_addrs.push((
                    base + r.offset,
                    target as i64,
                    packable && r.offset % 2 == 0,
                ));
            }
        }
        // GOT slots are RELATIVE targets too; a slot for an unresolved
        // weak reference gets GLOB_DAT instead.
        let got_base = self.got_addr_prevpass();
        if let Some(got_base) = got_base {
            for (k, name) in self.got_slots.clone().iter().enumerate() {
                let slot = got_base + 8 + k as u64 * 8;
                if let Some(v) = self.resolve_name(name) {
                    rel_addrs.push((slot, v as i64, true));
                } else {
                    sym_relas.push(DynReloc {
                        offset: slot,
                        rtype: if self.machine == EM_AARCH64 {
                            rt::R_AARCH64_GLOB_DAT
                        } else {
                            rt::R_X86_64_GLOB_DAT
                        },
                        addend: 0,
                    });
                }
            }
        }
        rel_addrs.sort_by_key(|&(a, _, _)| a);
        let mut relas: Vec<DynReloc> = Vec::new();
        let mut relr: Vec<u64> = Vec::new();
        for (addr, addend, packable) in rel_addrs {
            if self.opts.pack_relative_relocs && packable {
                relr.push(addr);
            } else {
                relas.push(DynReloc {
                    offset: addr,
                    rtype: if self.machine == EM_AARCH64 {
                        rt::R_AARCH64_RELATIVE
                    } else {
                        rt::R_X86_64_RELATIVE
                    },
                    addend,
                });
            }
        }
        relas.extend(sym_relas);
        relas.sort_by_key(|d| d.offset);
        let relr_words = encode_relr(&relr);
        self.dyn_relas = relas;
        self.relr_addrs = relr;
        // Update synthetic section sizes.
        let nones = match self.dyn_nones {
            Some(n) => n,
            None => {
                let n = self.count_reserved_none_slots();
                self.dyn_nones = Some(n);
                n
            }
        };
        let synth = self.synth_obj;
        for sec in &mut self.objects[synth].sections {
            match sec.name.as_str() {
                SYNTH_RELA => sec.size = (nones + self.dyn_relas.len() as u64) * 24,
                SYNTH_RELR => sec.size = relr_words.len() as u64 * 8,
                // The reserved header entry (`_GLOBAL_OFFSET_TABLE_[0]`)
                // exists only once something needs the GOT; bfd leaves
                // an unused `.got` empty, which scripts assert on.
                SYNTH_GOT => {
                    sec.size = if self.got_slots.is_empty() {
                        0
                    } else {
                        8 + self.got_slots.len() as u64 * 8
                    }
                }
                _ => {}
            }
        }
    }

    /// bfd sizes dynamic reloc sections at check_relocs time: every
    /// 64-bit absolute reloc against a non-local symbol in an
    /// allocated section reserves a slot, with no discard check on the
    /// global-symbol path. A slot whose section the script discards is
    /// never written (the section is not relocated) and never
    /// reclaimed by RELR packing, so it survives as a zeroed
    /// R_*_NONE entry. Reserve the same slots for size parity.
    fn count_reserved_none_slots(&self) -> u64 {
        let abs64 = if self.machine == EM_AARCH64 {
            rt::R_AARCH64_ABS64
        } else {
            rt::R_X86_64_64
        };
        let mut n = 0u64;
        for i in 0..self.insecs.len() {
            if self.fates[i] != SecFate::Discarded {
                continue;
            }
            let id = self.insecs[i];
            let s = &self.objects[id.obj].sections[id.sec];
            if s.flags & SHF_ALLOC == 0 {
                continue;
            }
            for r in &s.relocs {
                if r.rtype != abs64 {
                    continue;
                }
                let sym = &self.objects[id.obj].symbols[r.sym as usize];
                if sym.binding() != STB_LOCAL {
                    n += 1;
                }
            }
        }
        n
    }

    /// Resolve a symbol name to a final value through the global table
    /// or a script assignment. Used for GOT slot fills.
    fn resolve_name(&self, name: &str) -> Option<u64> {
        if let Some(&(oi, si)) = self.globals.get(name) {
            return self.resolve_sym_prevpass(oi, si, 0);
        }
        self.script_now
            .get(name)
            .or_else(|| self.script_prev.get(name))
            .map(|s| s.val.v)
    }

    /// An undefined default-visibility weak reference that nothing in
    /// the link satisfies. bfd exports it as a dynamic symbol and
    /// keeps a symbol-based reloc for its sites and GOT slot.
    fn undefweak_dynamic(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        sym.shndx as u16 == SHN_UNDEF
            && sym.binding() == STB_WEAK
            && sym.other & 0x3 == 0
            && !sym.name.is_empty()
            && !self.globals.contains_key(&sym.name)
            // During sizing the current pass's script table is swapped
            // out; the previous pass's values match at convergence.
            && !self.script_now.contains_key(&sym.name)
            && !self.script_prev.contains_key(&sym.name)
    }

    /// True when an ABS64 site against this symbol names a load
    /// address (a section-relative definition or an Out-attributed
    /// script symbol), so an ET_DYN image needs a RELATIVE fixup for
    /// it. An absolute constant or an undefined symbol does not.
    fn reloc_is_relative(&self, oi: usize, si: usize) -> bool {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS | SHN_UNDEF | SHN_COMMON => {
                if sym.binding() != STB_LOCAL {
                    if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                        return self.reloc_is_relative(doi, dsi);
                    }
                    if let Some(s) = self
                        .script_now
                        .get(&sym.name)
                        .or_else(|| self.script_prev.get(&sym.name))
                    {
                        // A symbol assigned from the top-level location
                        // counter is rebased into its section before
                        // emission (ld's ldexp_finalize_syms), so it is
                        // a load address like an in-section one.
                        return matches!(s.val.att, Att::Out(_)) || s.final_out.is_some();
                    }
                }
                false
            }
            _ => true,
        }
    }

    fn resolve_sym_prevpass(&self, oi: usize, si: usize, addend: i64) -> Option<u64> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(sym.value.wrapping_add(addend as u64)),
            SHN_UNDEF => {
                if let Some(&(doi, dsi)) = self.globals.get(&sym.name) {
                    return self.resolve_sym_prevpass(doi, dsi, addend);
                }
                // A reference the objects leave undefined can bind to
                // a script-defined symbol; without this the dynamic
                // fixup collection drops the slot entirely. During
                // sizing the current pass's table is already swapped
                // out, so fall back to the previous pass's values,
                // which match at convergence.
                self.script_now
                    .get(&sym.name)
                    .or_else(|| self.script_prev.get(&sym.name))
                    .map(|s| s.val.v.wrapping_add(addend as u64))
            }
            _ => {
                // Prev-pass placement offsets survive the reset; at
                // convergence they equal the current pass's.
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                let p = self.placements[i];
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // In a merge pool a section symbol's addend picks
                        // the entry, so the combined offset is remapped; a
                        // named symbol anchors at its own entry and the
                        // addend applies to the remapped address (matches
                        // bfd -- an addend past the entry, e.g. one past a
                        // string's NUL, must stay relative to that entry).
                        let off = if self.merge_of.contains_key(&i) {
                            if sym.kind() == STT_SECTION {
                                self.merge_remap(i, sym.value.wrapping_add(addend as u64))
                            } else {
                                self.merge_remap(i, sym.value).wrapping_add(addend as u64)
                            }
                        } else {
                            sym.value.wrapping_add(addend as u64)
                        };
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            p.off
                        };
                        Some(self.outs[out].addr.wrapping_add(base).wrapping_add(off))
                    }
                    _ => None,
                }
            }
        }
    }

    fn got_addr_prevpass(&self) -> Option<u64> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_GOT)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some(self.outs[out].addr + self.placements[i].off),
            _ => None,
        }
    }
}

fn is_debug_section(name: &str) -> bool {
    name.starts_with(".debug")
        || name.starts_with(".zdebug")
        || name.starts_with(".stab")
        || name == ".line"
        || name.starts_with(".gnu.linkonce.wi.")
}

/// The fill pattern for a numeric fill value: the value's big-endian
/// bytes with leading zeros trimmed (at least one byte). `0xcccccccc`
/// fills with `cc`, `0x9090` with `90 90`.
fn fill_pattern(v: u64) -> Vec<u8> {
    let be = v.to_be_bytes();
    let first = be.iter().position(|&b| b != 0).unwrap_or(7);
    be[first..].to_vec()
}

/// Pack sorted 8-aligned addresses into SHT_RELR words: an even
/// entry relocates its own address and rebases the window at
/// `addr + 8`; each following odd entry's bits `1..=63` relocate
/// `base + (bit-1)*8` and advance the base by `63*8`.
fn encode_relr(addrs: &[u64]) -> Vec<u64> {
    let mut out: Vec<u64> = Vec::new();
    let mut i = 0usize;
    while i < addrs.len() {
        out.push(addrs[i]);
        let mut base = addrs[i] + 8;
        i += 1;
        loop {
            let mut word: u64 = 0;
            while i < addrs.len() {
                let d = addrs[i].wrapping_sub(base);
                if d >= 63 * 8 || !d.is_multiple_of(8) {
                    break;
                }
                word |= 1u64 << (d / 8);
                i += 1;
            }
            if word == 0 {
                break;
            }
            out.push((word << 1) | 1);
            base += 63 * 8;
        }
    }
    out
}

// ------------------------------------------------------ finalization

/// A finished symbol destined for the output `.symtab`.
struct FinalSym {
    name: String,
    info: u8,
    other: u8,
    /// Kept-output-section index (into the emit order), or one of
    /// the SHN_* reserved values.
    shndx: u16,
    value: u64,
    size: u64,
}

impl<'a> LdsLinker<'a> {
    fn finish(&mut self) -> Result<LdsResult, C5Error> {
        // Emission order: statement order, kept sections only. An
        // empty output section is removed; symbols assigned inside it
        // survive, re-parented below.
        let mut emit_order: Vec<usize> = Vec::new();
        let opens: Vec<usize> = self
            .stmts
            .iter()
            .filter_map(|st| match st {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .collect();
        for oi in opens {
            if self.outs[oi].name == "/DISCARD/" {
                continue;
            }
            if self.outs[oi].size == 0 {
                self.outs[oi].removed = true;
                continue;
            }
            emit_order.push(oi);
        }
        // Output-section index (1-based in the final header table).
        let mut shndx_of_out: HashMap<usize, u16> = HashMap::new();
        for (k, &oi) in emit_order.iter().enumerate() {
            shndx_of_out.insert(oi, (k + 1) as u16);
        }
        // Symbols in removed sections re-parent to the nearest kept
        // section opened before them in statement order.
        let mut reparent: HashMap<usize, u16> = HashMap::new();
        {
            let mut last_kept: u16 = SHN_ABS;
            for st in &self.stmts {
                if let Stmt::Open(oi) = st {
                    match shndx_of_out.get(oi) {
                        Some(&k) => last_kept = k,
                        None => {
                            reparent.insert(*oi, last_kept);
                        }
                    }
                }
            }
        }
        let out_shndx = |oi: usize| -> u16 {
            shndx_of_out
                .get(&oi)
                .copied()
                .or_else(|| reparent.get(&oi).copied())
                .unwrap_or(SHN_ABS)
        };

        // Section content buffers (file-backed sections only).
        let mut contents: HashMap<usize, Vec<u8>> = HashMap::new();
        for &oi in &emit_order {
            let o = &self.outs[oi];
            if o.shtype == SHT_NOBITS {
                continue;
            }
            let mut buf = alloc::vec![0u8; o.size as usize];
            for (off, len, src) in &o.chunks {
                let (off, len) = (*off as usize, *len as usize);
                match src {
                    ChunkSrc::Input(i) => {
                        let data = self.chunk_input_bytes(*i);
                        let n = data.len().min(len);
                        buf[off..off + n].copy_from_slice(&data[..n]);
                    }
                    ChunkSrc::Bytes(b) => {
                        let n = b.len().min(len);
                        buf[off..off + n].copy_from_slice(&b[..n]);
                    }
                    ChunkSrc::Pad(pat) => {
                        if !pat.is_empty() {
                            for k in 0..len {
                                buf[off + k] = pat[k % pat.len()];
                            }
                        }
                    }
                }
            }
            contents.insert(oi, buf);
        }

        // Apply relocations into the content buffers.
        let relr_set: HashSet<u64> = self.relr_addrs.iter().copied().collect();
        self.apply_relocations(&mut contents, &relr_set)?;
        self.fill_synth_contents(&mut contents, &relr_set);

        // Entry point.
        let entry_name: Option<String> = self
            .opts
            .entry_override
            .clone()
            .or_else(|| self.script.entry().map(|s| s.to_string()));
        let entry = match &entry_name {
            Some(name) => match self.final_sym_value(name) {
                Some(v) => v,
                None => {
                    self.warnings.push(format!(
                        "warning: cannot find entry symbol {name}; defaulting to first text address"
                    ));
                    self.default_entry(&emit_order)
                }
            },
            None => self.default_entry(&emit_order),
        };

        // Program headers.
        let phdrs = self.build_phdrs(&emit_order)?;

        // Symbol table.
        let mut sym_index = SymIndex::default();
        let syms = self.build_symtab(&emit_order, &out_shndx, &mut sym_index);
        self.sym_index = sym_index;

        // Assemble the image.
        let image = self.write_image(&emit_order, &shndx_of_out, contents, phdrs, syms, entry)?;
        let map = self.render_map(&emit_order);
        Ok(LdsResult {
            image,
            map,
            warnings: core::mem::take(&mut self.warnings),
        })
    }

    /// Bytes an input chunk contributes: its own section data, or the
    /// merge pool for a pool representative (empty for other members).
    fn chunk_input_bytes(&self, i: usize) -> &[u8] {
        if let Some(&p) = self.merge_of.get(&i) {
            if self.pools[p].rep == i {
                return &self.pools[p].bytes;
            }
            return &[];
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

    fn default_entry(&self, emit_order: &[usize]) -> u64 {
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc && o.flags & SHF_EXECINSTR != 0 {
                return o.addr;
            }
        }
        0
    }

    fn final_sym_value(&self, name: &str) -> Option<u64> {
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val.v);
        }
        let &(oi, si) = self.globals.get(name)?;
        self.resolve_sym_prevpass(oi, si, 0)
    }

    // ---------------------------------------------------- relocations

    fn apply_relocations(
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
            let relocs = self.objects[id.obj].sections[id.sec].relocs.clone();
            let Some(buf) = contents.get_mut(&out) else {
                continue;
            };
            for r in &relocs {
                let site = (place.off + r.offset) as usize;
                let p = sec_addr + r.offset;
                let target = self.resolve_reloc_target(id.obj, r, &mut errors);
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
            return Err(err(&errors.join("\n")));
        }
        Ok(())
    }

    /// `S + A` for a relocation, or `None` when the reloc is skipped
    /// (undefined weak resolves to zero and still applies).
    fn resolve_reloc_target(
        &self,
        oi: usize,
        r: &RawReloc,
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
                    None => {
                        errors.push(format!(
                            "{}: `{}' resolves into a discarded section",
                            self.objects[oi].source, sym.name
                        ));
                        None
                    }
                };
            }
            if sym.name == "_GLOBAL_OFFSET_TABLE_" {
                return self
                    .got_addr_prevpass()
                    .map(|g| g.wrapping_add(r.addend as u64));
            }
            if let Some(s) = self.script_now.get(&sym.name) {
                return Some(s.val.v.wrapping_add(r.addend as u64));
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
            _ => self.resolve_sym_prevpass(oi, r.sym as usize, r.addend),
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
                rt::R_X86_64_PC64 => {
                    w(buf, site, &sa.wrapping_sub(p).to_le_bytes());
                }
                rt::R_X86_64_PC32 | rt::R_X86_64_PLT32 => {
                    let v = sa.wrapping_sub(p) as i64;
                    if (v as i32) as i64 != v {
                        errors.push(format!(
                            "relocation truncated: R_X86_64_PC32 against `{}' (0x{v:x})",
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
                rt::R_X86_64_GOTPCREL | 41 | rt::R_X86_64_REX_GOTPCRELX => {
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
            EM_AARCH64 => self.apply_aarch64(buf, site, p, sa, r, alloc, relr_set, errors, oi),
            _ => errors.push(format!("unsupported machine {machine}")),
        }
    }

    #[allow(clippy::too_many_arguments)]
    fn apply_aarch64(
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
        let name = || {
            let sym = &self.objects[oi].symbols[r.sym as usize];
            if sym.name.is_empty() {
                format!("section symbol {}", sym.shndx)
            } else {
                sym.name.clone()
            }
        };
        let rd32 = |buf: &[u8], site: usize| -> u32 {
            u32::from_le_bytes([buf[site], buf[site + 1], buf[site + 2], buf[site + 3]])
        };
        let wr32 = |buf: &mut [u8], site: usize, v: u32| {
            buf[site..site + 4].copy_from_slice(&v.to_le_bytes());
        };
        let page = |v: u64| v & !0xfffu64;
        match r.rtype {
            rt::R_AARCH64_ABS64 => {
                // Write the value in place unless it is a load-address
                // (slide-dependent) fixup deferred to the loader. A
                // slide-invariant absolute constant is always written;
                // an RELR-packed relative keeps its link-time value in
                // place (the RELR format has no explicit addend);
                // `--no-apply-dynamic-relocs` leaves only the RELA
                // relative slots at zero for the kernel to fill.
                let relative = self.opts.emit == LdsEmit::Dyn
                    && alloc
                    && self.reloc_is_relative(oi, r.sym as usize);
                let deferred =
                    relative && !relr_set.contains(&p) && !self.opts.apply_dynamic_relocs;
                if !deferred && site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.to_le_bytes());
                }
            }
            rt::R_AARCH64_ABS32 => {
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(sa as u32).to_le_bytes());
                }
            }
            259 => {
                // R_AARCH64_ABS16
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(sa as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL64 => {
                if site + 8 <= buf.len() {
                    buf[site..site + 8].copy_from_slice(&sa.wrapping_sub(p).to_le_bytes());
                }
            }
            rt::R_AARCH64_PREL32 => {
                let v = sa.wrapping_sub(p) as i64;
                if (v as i32) as i64 != v {
                    errors.push(format!(
                        "relocation truncated: R_AARCH64_PREL32 against `{}'",
                        name()
                    ));
                }
                if site + 4 <= buf.len() {
                    buf[site..site + 4].copy_from_slice(&(v as i32).to_le_bytes());
                }
            }
            262 => {
                // R_AARCH64_PREL16
                let v = sa.wrapping_sub(p);
                if site + 2 <= buf.len() {
                    buf[site..site + 2].copy_from_slice(&(v as u16).to_le_bytes());
                }
            }
            rt::R_AARCH64_CALL26 | rt::R_AARCH64_JUMP26 => {
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 27)..(1i64 << 27)).contains(&v) {
                    errors.push(format!(
                        "branch out of range to `{}' (0x{v:x}); veneers TODO",
                        name()
                    ));
                    return;
                }
                let insn = rd32(buf, site) & 0xfc00_0000;
                wr32(buf, site, insn | (((v >> 2) as u32) & 0x03ff_ffff));
            }
            rt::R_AARCH64_ADR_PREL_PG_HI21 => {
                let v = (page(sa) as i64).wrapping_sub(page(p) as i64);
                if !(-(1i64 << 32)..(1i64 << 32)).contains(&v) {
                    errors.push(format!(
                        "ADR_PREL_PG_HI21 out of range against `{}'",
                        name()
                    ));
                    return;
                }
                let imm = (v >> 12) as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            274 => {
                // R_AARCH64_ADR_PREL_LO21
                let v = sa.wrapping_sub(p) as i64;
                if !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("ADR_PREL_LO21 out of range against `{}'", name()));
                    return;
                }
                let imm = v as u32;
                let insn = rd32(buf, site) & 0x9f00_001f;
                wr32(
                    buf,
                    site,
                    insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                );
            }
            rt::R_AARCH64_ADD_ABS_LO12_NC => {
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (((sa & 0xfff) as u32) << 10));
            }
            rt::R_AARCH64_LDST8_ABS_LO12_NC
            | rt::R_AARCH64_LDST16_ABS_LO12_NC
            | rt::R_AARCH64_LDST32_ABS_LO12_NC
            | rt::R_AARCH64_LDST64_ABS_LO12_NC
            | rt::R_AARCH64_LDST128_ABS_LO12_NC => {
                let scale = rt::aarch64_ldst_lo12_scale(r.rtype).unwrap_or(1);
                let imm = ((sa & 0xfff) / scale as u64) as u32;
                let insn = rd32(buf, site) & 0xffc0_03ff;
                wr32(buf, site, insn | (imm << 10));
            }
            280 => {
                // R_AARCH64_CONDBR19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("CONDBR19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            279 => {
                // R_AARCH64_TSTBR14
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 15)..(1i64 << 15)).contains(&v) {
                    errors.push(format!("TSTBR14 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xfff8_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x3fff) << 5));
            }
            273 => {
                // R_AARCH64_LD_PREL_LO19
                let v = sa.wrapping_sub(p) as i64;
                if v % 4 != 0 || !(-(1i64 << 20)..(1i64 << 20)).contains(&v) {
                    errors.push(format!("LD_PREL_LO19 out of range against `{}'", name()));
                    return;
                }
                let insn = rd32(buf, site) & 0xff00_001f;
                wr32(buf, site, insn | ((((v >> 2) as u32) & 0x7ffff) << 5));
            }
            263..=269 => {
                // R_AARCH64_MOVW_UABS_G0..G3 (with _NC variants):
                // 16-bit chunks of the absolute value into movz/movk.
                let (shift, check) = match r.rtype {
                    263 => (0, true),
                    264 => (0, false),
                    265 => (16, true),
                    266 => (16, false),
                    267 => (32, true),
                    268 => (32, false),
                    _ => (48, false),
                };
                if check && (sa >> shift) > 0xffff && r.rtype != 269 {
                    errors.push(format!(
                        "MOVW_UABS overflow against `{}' (0x{sa:x})",
                        name()
                    ));
                }
                let imm = ((sa >> shift) & 0xffff) as u32;
                let insn = rd32(buf, site) & 0xffe0_001f;
                wr32(buf, site, insn | (imm << 5));
            }
            rt::R_AARCH64_ADR_GOT_PAGE | rt::R_AARCH64_LD64_GOT_LO12_NC => {
                let slot = self.got_slot_addr(oi, r);
                let Some(slot) = slot else {
                    errors.push(format!("no GOT slot for `{}'", name()));
                    return;
                };
                if r.rtype == rt::R_AARCH64_ADR_GOT_PAGE {
                    let v = (page(slot) as i64).wrapping_sub(page(p) as i64);
                    let imm = (v >> 12) as u32;
                    let insn = rd32(buf, site) & 0x9f00_001f;
                    wr32(
                        buf,
                        site,
                        insn | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5),
                    );
                } else {
                    let imm = (((slot & 0xfff) / 8) as u32) & 0xfff;
                    let insn = rd32(buf, site) & 0xffc0_03ff;
                    wr32(buf, site, insn | (imm << 10));
                }
            }
            0 => {}
            other => {
                errors.push(format!(
                    "unsupported relocation {} against `{}'",
                    rt::aarch64_reloc_desc(other),
                    name()
                ));
            }
        }
    }

    fn got_slot_addr(&self, oi: usize, r: &RawReloc) -> Option<u64> {
        let name = &self.objects[oi].symbols[r.sym as usize].name;
        let idx = *self.got_map.get(name)?;
        Some(self.got_addr_prevpass()? + 8 + idx as u64 * 8)
    }

    /// Write the synthesized sections' content: dynamic relocation
    /// tables, GOT slots, and the build-id note body (digest patched
    /// after the image is assembled).
    fn fill_synth_contents(
        &mut self,
        contents: &mut HashMap<usize, Vec<u8>>,
        relr_set: &HashSet<u64>,
    ) {
        let synth = self.synth_obj;
        for sec_idx in 0..self.objects[synth].sections.len() {
            let name = self.objects[synth].sections[sec_idx].name.clone();
            let i = self.insec_index(synth, sec_idx);
            let SecFate::Placed { out } = self.fates[i] else {
                continue;
            };
            if self.outs[out].removed {
                continue;
            }
            let off = self.placements[i].off as usize;
            let mut bytes: Vec<u8> = Vec::new();
            match name.as_str() {
                SYNTH_RELA => {
                    // Reserved slots stay zeroed (R_*_NONE) ahead of
                    // the live entries, as bfd leaves them.
                    bytes.resize(self.dyn_nones.unwrap_or(0) as usize * 24, 0);
                    for d in &self.dyn_relas {
                        bytes.extend_from_slice(&d.offset.to_le_bytes());
                        bytes.extend_from_slice(&(d.rtype as u64).to_le_bytes());
                        bytes.extend_from_slice(&d.addend.to_le_bytes());
                    }
                }
                SYNTH_RELR => {
                    for wdd in encode_relr(&self.relr_addrs) {
                        bytes.extend_from_slice(&wdd.to_le_bytes());
                    }
                }
                SYNTH_GOT if self.got_slots.is_empty() => {}
                SYNTH_GOT => {
                    bytes.extend_from_slice(&0u64.to_le_bytes());
                    let base = self.got_addr_prevpass().unwrap_or(0);
                    for (k, gname) in self.got_slots.clone().iter().enumerate() {
                        let v = self.resolve_name(gname).unwrap_or(0);
                        let slot_addr = base + 8 + k as u64 * 8;
                        let write = relr_set.contains(&slot_addr) || self.opts.apply_dynamic_relocs;
                        bytes.extend_from_slice(&if write { v } else { 0 }.to_le_bytes());
                    }
                }
                SYNTH_GOTPLT => {
                    bytes.extend_from_slice(&[0u8; 24]);
                }
                SYNTH_BUILD_ID => {
                    bytes.extend_from_slice(&4u32.to_le_bytes()); // namesz
                    bytes.extend_from_slice(&20u32.to_le_bytes()); // descsz
                    bytes.extend_from_slice(&3u32.to_le_bytes()); // NT_GNU_BUILD_ID
                    bytes.extend_from_slice(b"GNU\0");
                    bytes.extend_from_slice(&[0u8; 20]);
                }
                _ => continue,
            }
            if let Some(buf) = contents.get_mut(&out) {
                let n = bytes.len().min(buf.len().saturating_sub(off));
                buf[off..off + n].copy_from_slice(&bytes[..n]);
            }
        }
    }

    // -------------------------------------------------------- phdrs

    fn build_phdrs(
        &mut self,
        emit_order: &[usize],
    ) -> Result<Vec<(Elf64Phdr, Vec<usize>)>, C5Error> {
        if let Some(defs) = self.script.phdrs() {
            let defs = defs.to_owned();
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
            let mut inherit: Vec<usize> = Vec::new();
            for &oi in emit_order {
                if !self.outs[oi].alloc {
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
                for &k in &inherit {
                    segs[k].1.push(oi);
                }
            }
            Ok(segs)
        } else {
            // No PHDRS command: bfd's default segment assignment. A new
            // PT_LOAD begins only at a read-only-to-writable transition
            // (so read-only content keeps read-only pages) or where a
            // file-backed section follows a NOBITS one (file content
            // can't trail zero-fill in the same segment). Executable
            // sections OR their bit into the current segment rather than
            // forcing a split, which is why a writable segment can carry
            // code (the RWE segment ld emits without a PHDRS command).
            let mut segs: Vec<(Elf64Phdr, Vec<usize>)> = Vec::new();
            let mut cur: Option<usize> = None;
            let mut cur_writable = false;
            let mut prev_nobits = false;
            for &oi in emit_order {
                let o = &self.outs[oi];
                if !o.alloc {
                    continue;
                }
                let writable = o.flags & SHF_WRITE != 0;
                let nobits = o.shtype == SHT_NOBITS;
                let start_new = match cur {
                    None => true,
                    Some(_) => (writable && !cur_writable) || (!nobits && prev_nobits),
                };
                if start_new {
                    segs.push((
                        Elf64Phdr {
                            p_type: PT_LOAD,
                            p_flags: PF_R,
                            p_align: self.opts.max_page_size,
                            ..Default::default()
                        },
                        Vec::new(),
                    ));
                    cur = Some(segs.len() - 1);
                    cur_writable = writable;
                }
                cur_writable |= writable;
                prev_nobits = nobits;
                let k = cur.expect("current segment exists");
                segs[k].1.push(oi);
                let mut fl = PF_R;
                if writable {
                    fl |= PF_W;
                }
                if o.flags & SHF_EXECINSTR != 0 {
                    fl |= PF_X;
                }
                segs[k].0.p_flags |= fl;
            }
            // PT_NOTE per run of NOTE sections.
            let mut note_members: Vec<usize> = Vec::new();
            for &oi in emit_order {
                let o = &self.outs[oi];
                if o.alloc && o.shtype == SHT_NOTE {
                    note_members.push(oi);
                }
            }
            if !note_members.is_empty() {
                segs.push((
                    Elf64Phdr {
                        p_type: PT_NOTE,
                        p_flags: PF_R,
                        p_align: 4,
                        ..Default::default()
                    },
                    note_members,
                ));
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
            Ok(segs)
        }
    }

    // ------------------------------------------------------- symtab

    fn build_symtab(
        &self,
        emit_order: &[usize],
        out_shndx: &dyn Fn(usize) -> u16,
        index: &mut SymIndex,
    ) -> Vec<FinalSym> {
        let track = self.opts.emit_relocs;
        let mut syms: Vec<FinalSym> = Vec::new();
        // Section symbols.
        for &oi in emit_order {
            if track {
                index.sec.insert(oi, syms.len());
            }
            syms.push(FinalSym {
                name: String::new(),
                info: STT_SECTION,
                other: 0,
                shndx: out_shndx(oi),
                value: self.outs[oi].addr,
                size: 0,
            });
        }
        // Local symbols per input object, in input order.
        for (obj_i, o) in self.objects.iter().enumerate() {
            if obj_i == self.synth_obj {
                continue;
            }
            for (sym_i, sym) in o.symbols.iter().enumerate() {
                if sym.binding() != STB_LOCAL || sym.kind() == STT_SECTION {
                    continue;
                }
                if sym.kind() == STT_FILE {
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(FinalSym {
                        name: sym.name.clone(),
                        info: sym.info,
                        other: sym.other,
                        shndx: SHN_ABS,
                        value: 0,
                        size: 0,
                    });
                    continue;
                }
                if !self.opts.discard_none && self.opts.discard_locals && sym.name.starts_with(".L")
                {
                    continue;
                }
                if let Some(fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                    if track {
                        index.local.insert((obj_i, sym_i as u32), syms.len());
                    }
                    syms.push(fs);
                }
            }
        }
        // A symbol's visibility aggregates over every reference and
        // definition; hidden or internal globals cannot be preempted
        // and are emitted with local binding. bfd applies the forcing
        // from the dynamic-symbol adjustment, so only links with
        // dynamic sections see it.
        let mut forced_vis: HashMap<&str, u8> = HashMap::new();
        if self.opts.emit == LdsEmit::Dyn {
            for o in &self.objects {
                for sym in &o.symbols {
                    let vis = sym.other & 0x3;
                    if sym.binding() == STB_LOCAL || sym.name.is_empty() || vis == 0 || vis == 3 {
                        continue;
                    }
                    let e = forced_vis.entry(sym.name.as_str()).or_insert(vis);
                    // INTERNAL(1) constrains more than HIDDEN(2).
                    *e = (*e).min(vis);
                }
            }
        }
        // Resolved global definitions, name order (the table order is
        // not part of the contract; nm sorts).
        let mut global_defs: Vec<(&String, (usize, usize))> =
            self.globals.iter().map(|(n, &d)| (n, d)).collect();
        global_defs.sort_by(|a, b| a.0.cmp(b.0));
        for (name, (obj_i, sym_i)) in global_defs {
            if self.script_now.contains_key(name) {
                continue; // script assignment overrides
            }
            if let Some(mut fs) = self.finalize_sym(obj_i, sym_i, out_shndx) {
                if let Some(&vis) = forced_vis.get(name.as_str()) {
                    fs.info = (STB_LOCAL << 4) | (fs.info & 0xf);
                    fs.other = vis;
                }
                if track {
                    index.by_name.insert(name.clone(), syms.len());
                }
                syms.push(fs);
            }
        }
        // Script-defined symbols.
        let mut script_syms: Vec<(&String, &ScriptSym)> = self.script_now.iter().collect();
        script_syms.sort_by(|a, b| a.0.cmp(b.0));
        for (name, s) in script_syms {
            let shndx = match (s.val.att, s.final_out) {
                (Att::Out(oi), _) => out_shndx(oi),
                (_, Some(oi)) => out_shndx(oi),
                (_, None) => SHN_ABS,
            };
            let vis = forced_vis
                .get(name.as_str())
                .copied()
                .or(s.hidden.then_some(STV_HIDDEN));
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (if vis.is_some() { STB_LOCAL } else { STB_GLOBAL } << 4) | STT_NOTYPE,
                other: vis.unwrap_or(STV_DEFAULT),
                shndx,
                value: s.val.v,
                size: 0,
            });
        }
        // Referenced-but-undefined weak symbols surface as UNDEF.
        let mut weak_undefs: BTreeSet<&String> = BTreeSet::new();
        for o in &self.objects {
            for sym in &o.symbols {
                if sym.shndx as u16 == SHN_UNDEF
                    && sym.binding() == STB_WEAK
                    && !sym.name.is_empty()
                    && !self.globals.contains_key(&sym.name)
                    && !self.script_now.contains_key(&sym.name)
                {
                    weak_undefs.insert(&sym.name);
                }
            }
        }
        for name in weak_undefs {
            if track {
                index.by_name.insert(name.clone(), syms.len());
            }
            syms.push(FinalSym {
                name: name.clone(),
                info: (STB_WEAK << 4) | STT_NOTYPE,
                other: 0,
                shndx: SHN_UNDEF,
                value: 0,
                size: 0,
            });
        }
        syms
    }

    fn finalize_sym(
        &self,
        obj_i: usize,
        sym_i: usize,
        out_shndx: &dyn Fn(usize) -> u16,
    ) -> Option<FinalSym> {
        let sym = &self.objects[obj_i].symbols[sym_i];
        match sym.shndx as u16 {
            SHN_ABS => Some(FinalSym {
                name: sym.name.clone(),
                info: sym.info,
                other: sym.other,
                shndx: SHN_ABS,
                value: sym.value,
                size: sym.size,
            }),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[obj_i].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(obj_i, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        let value = self.resolve_sym_prevpass(obj_i, sym_i, 0)?;
                        let shndx = if self.outs[out].removed {
                            SHN_ABS
                        } else {
                            out_shndx(out)
                        };
                        Some(FinalSym {
                            name: sym.name.clone(),
                            info: sym.info,
                            other: sym.other,
                            shndx,
                            value,
                            size: sym.size,
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    /// `--emit-relocs` payloads: the recorded relocations grouped by
    /// output section, each entry naming the output symtab index of
    /// the symbol the input relocation referenced.
    fn emitted_rela_sections(
        &self,
        final_of: &[u32],
        syms: &[FinalSym],
    ) -> Result<Vec<(usize, Vec<u8>)>, C5Error> {
        let index = &self.sym_index;
        if self.emitted.is_empty() {
            return Ok(Vec::new());
        }
        let mut by_out: BTreeMap<usize, Vec<&EmittedReloc>> = BTreeMap::new();
        for r in &self.emitted {
            by_out.entry(r.out).or_default().push(r);
        }
        let mut unresolved: Vec<String> = Vec::new();
        let mut out: Vec<(usize, Vec<u8>)> = Vec::new();
        for (oi, mut recs) in by_out {
            recs.sort_by_key(|r| r.addr);
            let mut body: Vec<u8> = Vec::with_capacity(recs.len() * 24);
            for r in recs {
                let slot = self.emitted_sym_slot(r, index);
                let sym = match slot {
                    Some(pos) => final_of[pos],
                    None => {
                        if unresolved.len() < 10 {
                            let s = &self.objects[r.obj].symbols[r.sym as usize];
                            unresolved.push(format!(
                                "  {}: --emit-relocs: symbol `{}' referenced at {:#x} is not \
                                 in the output symbol table",
                                self.objects[r.obj].source, s.name, r.addr
                            ));
                        }
                        0
                    }
                };
                // `S + A` reconstructs from the entry, so the addend
                // is the resolved target less the named symbol's value.
                let base = slot.map_or(0, |pos| syms[pos].value);
                let addend = r.target.wrapping_sub(base) as i64;
                body.extend_from_slice(&r.addr.to_le_bytes());
                body.extend_from_slice(&(((sym as u64) << 32) | r.rtype as u64).to_le_bytes());
                body.extend_from_slice(&addend.to_le_bytes());
            }
            out.push((oi, body));
        }
        if !unresolved.is_empty() {
            return Err(err(&unresolved.join("\n")));
        }
        Ok(out)
    }

    /// The `build_symtab` slot an emitted relocation's symbol maps to:
    /// a global by name, a section reference through the output
    /// section's symbol, otherwise the surviving local.
    fn emitted_sym_slot(&self, r: &EmittedReloc, index: &SymIndex) -> Option<usize> {
        let sym = self.objects[r.obj].symbols.get(r.sym as usize)?;
        if sym.binding() != STB_LOCAL && !sym.name.is_empty() {
            return index.by_name.get(&sym.name).copied();
        }
        if sym.kind() == STT_SECTION {
            let sec = *self.objects[r.obj].shndx_map.get(&sym.shndx)?;
            let i = self.insec_index(r.obj, sec);
            let SecFate::Placed { out } = self.fates[i] else {
                return None;
            };
            return index.sec.get(&out).copied();
        }
        index.local.get(&(r.obj, r.sym)).copied()
    }

    // -------------------------------------------------------- writer

    fn write_image(
        &mut self,
        emit_order: &[usize],
        shndx_of_out: &HashMap<usize, u16>,
        contents: HashMap<usize, Vec<u8>>,
        mut phdrs: Vec<(Elf64Phdr, Vec<usize>)>,
        syms: Vec<FinalSym>,
        entry: u64,
    ) -> Result<Vec<u8>, C5Error> {
        let phnum = phdrs.len();
        let headers_end = 64 + phnum as u64 * 56;

        // File offsets. PT_LOAD members get congruent placement;
        // everything else follows section order.
        let mut file_off: HashMap<usize, u64> = HashMap::new();
        let mut pos = headers_end;
        // Which PT_LOAD each section belongs to (first membership).
        let mut load_of: HashMap<usize, usize> = HashMap::new();
        for (k, (ph, members)) in phdrs.iter().enumerate() {
            if ph.p_type != PT_LOAD {
                continue;
            }
            for &oi in members {
                load_of.entry(oi).or_insert(k);
            }
        }
        let mut load_positions: HashMap<usize, (u64, u64)> = HashMap::new(); // seg -> (off, vaddr)
        for &oi in emit_order {
            let (alloc, addr, size, nobits, salign) = {
                let o = &self.outs[oi];
                (o.alloc, o.addr, o.size, o.shtype == SHT_NOBITS, o.align)
            };
            if !alloc {
                continue;
            }
            match load_of.get(&oi) {
                Some(&seg) => {
                    if !load_positions.contains_key(&seg) {
                        // Smallest offset at or past the cursor
                        // congruent to the segment's vaddr modulo its
                        // alignment.
                        let a = phdrs[seg].0.p_align.max(1);
                        let want = addr % a;
                        let have = pos % a;
                        let off = if want >= have {
                            pos - have + want
                        } else {
                            pos - have + a + want
                        };
                        load_positions.insert(seg, (off, addr));
                    }
                    let (seg_off, seg_vaddr) = load_positions[&seg];
                    if nobits {
                        file_off.insert(oi, pos);
                    } else {
                        let off = seg_off + (addr - seg_vaddr);
                        file_off.insert(oi, off);
                        pos = pos.max(off + size);
                    }
                }
                None => {
                    let off = align_up(pos, salign.min(self.opts.max_page_size).max(1));
                    file_off.insert(oi, off);
                    if !nobits {
                        pos = off + size;
                    }
                }
            }
        }
        // Non-alloc sections after the load image.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.alloc {
                continue;
            }
            let off = align_up(pos, o.align.max(1));
            file_off.insert(oi, off);
            if o.shtype != SHT_NOBITS {
                pos = off + o.size;
            }
        }

        // Program header extents.
        for (ph, members) in phdrs.iter_mut() {
            if members.is_empty() {
                continue;
            }
            let first = members[0];
            ph.p_vaddr = self.outs[first].addr;
            ph.p_paddr = self.outs[first].lma;
            ph.p_offset = file_off[&first];
            let mut file_end = ph.p_offset;
            let mut mem_end = ph.p_vaddr;
            for &oi in members.iter() {
                let o = &self.outs[oi];
                mem_end = mem_end.max(o.addr + o.size);
                if o.shtype != SHT_NOBITS {
                    file_end = file_end.max(file_off[&oi] + o.size);
                }
            }
            ph.p_filesz = file_end - ph.p_offset;
            ph.p_memsz = mem_end - ph.p_vaddr;
        }

        // Symbol/string tables.
        let mut strtab: Vec<u8> = alloc::vec![0];
        let mut sym_bytes: Vec<u8> = Vec::new();
        let mut locals = 1u32;
        let mut final_of: Vec<u32> = alloc::vec![0; syms.len()];
        {
            let push = |s: &FinalSym, strtab: &mut Vec<u8>, sym_bytes: &mut Vec<u8>| {
                let name_off = if s.name.is_empty() {
                    0
                } else {
                    let off = strtab.len() as u32;
                    strtab.extend_from_slice(s.name.as_bytes());
                    strtab.push(0);
                    off
                };
                sym_bytes.extend_from_slice(&name_off.to_le_bytes());
                sym_bytes.push(s.info);
                sym_bytes.push(s.other);
                sym_bytes.extend_from_slice(&s.shndx.to_le_bytes());
                sym_bytes.extend_from_slice(&s.value.to_le_bytes());
                sym_bytes.extend_from_slice(&s.size.to_le_bytes());
            };
            // Null entry.
            sym_bytes.extend_from_slice(&[0u8; 24]);
            let mut next = 1u32;
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 == STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                    locals += 1;
                }
            }
            for (i, s) in syms.iter().enumerate() {
                if s.info >> 4 != STB_LOCAL {
                    push(s, &mut strtab, &mut sym_bytes);
                    final_of[i] = next;
                    next += 1;
                }
            }
        }

        // `--emit-relocs`: one `.rela.<outsec>` per output section that
        // took relocations, entries in address order, `r_offset` the
        // final address and `r_info` naming the output symtab entry the
        // input relocation referenced.
        let rela: Vec<(usize, Vec<u8>)> = self.emitted_rela_sections(&final_of, &syms)?;

        // Section header string table.
        let mut shstrtab: Vec<u8> = alloc::vec![0];
        let mut shname: HashMap<String, u32> = HashMap::new();
        let intern = |name: &str, shstrtab: &mut Vec<u8>, shname: &mut HashMap<String, u32>| {
            if let Some(&off) = shname.get(name) {
                return off;
            }
            let off = shstrtab.len() as u32;
            shstrtab.extend_from_slice(name.as_bytes());
            shstrtab.push(0);
            shname.insert(name.to_string(), off);
            off
        };

        let symtab_off = align_up(pos, 8);
        let strtab_off = symtab_off + sym_bytes.len() as u64;
        let shstr_names: Vec<u32> = emit_order
            .iter()
            .map(|&oi| intern(&self.outs[oi].name.clone(), &mut shstrtab, &mut shname))
            .collect();
        let n_symtab = intern(".symtab", &mut shstrtab, &mut shname);
        let n_strtab = intern(".strtab", &mut shstrtab, &mut shname);
        let n_shstrtab = intern(".shstrtab", &mut shstrtab, &mut shname);
        let rela_names: Vec<u32> = rela
            .iter()
            .map(|(oi, _)| {
                let n = format!(".rela{}", self.outs[*oi].name);
                intern(&n, &mut shstrtab, &mut shname)
            })
            .collect();
        let shstr_off = strtab_off + strtab.len() as u64;
        let mut rela_off: Vec<u64> = Vec::with_capacity(rela.len());
        let mut pos_after = shstr_off + shstrtab.len() as u64;
        for (_, body) in &rela {
            let at = align_up(pos_after, 8);
            rela_off.push(at);
            pos_after = at + body.len() as u64;
        }
        let shoff = align_up(pos_after, 8);
        // null + sections + symtab + strtab + shstrtab + one per rela
        let shnum = emit_order.len() + 4 + rela.len();

        let mut image: Vec<u8> = alloc::vec![0u8; shoff as usize + shnum * 64];

        // ELF header.
        let e_type = match self.opts.emit {
            LdsEmit::Exec => ET_EXEC,
            LdsEmit::Dyn => ET_DYN,
        };
        image[0..4].copy_from_slice(b"\x7fELF");
        image[4] = 2;
        image[5] = 1;
        image[6] = 1;
        image[16..18].copy_from_slice(&e_type.to_le_bytes());
        image[18..20].copy_from_slice(&self.machine.to_le_bytes());
        image[20..24].copy_from_slice(&1u32.to_le_bytes());
        image[24..32].copy_from_slice(&entry.to_le_bytes());
        image[32..40].copy_from_slice(&64u64.to_le_bytes());
        image[40..48].copy_from_slice(&shoff.to_le_bytes());
        image[52..54].copy_from_slice(&64u16.to_le_bytes());
        image[54..56].copy_from_slice(&56u16.to_le_bytes());
        image[56..58].copy_from_slice(&(phnum as u16).to_le_bytes());
        image[58..60].copy_from_slice(&64u16.to_le_bytes());
        image[60..62].copy_from_slice(&(shnum as u16).to_le_bytes());
        // `.shstrtab` keeps its index whether or not `--emit-relocs`
        // appended tables after it.
        image[62..64].copy_from_slice(&((emit_order.len() + 3) as u16).to_le_bytes());

        // Program headers.
        for (k, (ph, _)) in phdrs.iter().enumerate() {
            let at = 64 + k * 56;
            image[at..at + 4].copy_from_slice(&ph.p_type.to_le_bytes());
            image[at + 4..at + 8].copy_from_slice(&ph.p_flags.to_le_bytes());
            image[at + 8..at + 16].copy_from_slice(&ph.p_offset.to_le_bytes());
            image[at + 16..at + 24].copy_from_slice(&ph.p_vaddr.to_le_bytes());
            image[at + 24..at + 32].copy_from_slice(&ph.p_paddr.to_le_bytes());
            image[at + 32..at + 40].copy_from_slice(&ph.p_filesz.to_le_bytes());
            image[at + 40..at + 48].copy_from_slice(&ph.p_memsz.to_le_bytes());
            image[at + 48..at + 56].copy_from_slice(&ph.p_align.to_le_bytes());
        }

        // Section bodies.
        for &oi in emit_order {
            let o = &self.outs[oi];
            if o.shtype == SHT_NOBITS {
                continue;
            }
            if let Some(body) = contents.get(&oi) {
                let off = file_off[&oi] as usize;
                image[off..off + body.len()].copy_from_slice(body);
            }
        }
        image[symtab_off as usize..symtab_off as usize + sym_bytes.len()]
            .copy_from_slice(&sym_bytes);
        image[strtab_off as usize..strtab_off as usize + strtab.len()].copy_from_slice(&strtab);
        image[shstr_off as usize..shstr_off as usize + shstrtab.len()].copy_from_slice(&shstrtab);
        for (k, (_, body)) in rela.iter().enumerate() {
            let at = rela_off[k] as usize;
            image[at..at + body.len()].copy_from_slice(body);
        }

        // Section headers.
        let wr_shdr = |idx: usize, sh: Elf64Shdr, image: &mut Vec<u8>| {
            let at = shoff as usize + idx * 64;
            image[at..at + 4].copy_from_slice(&sh.sh_name.to_le_bytes());
            image[at + 4..at + 8].copy_from_slice(&sh.sh_type.to_le_bytes());
            image[at + 8..at + 16].copy_from_slice(&sh.sh_flags.to_le_bytes());
            image[at + 16..at + 24].copy_from_slice(&sh.sh_addr.to_le_bytes());
            image[at + 24..at + 32].copy_from_slice(&sh.sh_offset.to_le_bytes());
            image[at + 32..at + 40].copy_from_slice(&sh.sh_size.to_le_bytes());
            image[at + 40..at + 44].copy_from_slice(&sh.sh_link.to_le_bytes());
            image[at + 44..at + 48].copy_from_slice(&sh.sh_info.to_le_bytes());
            image[at + 48..at + 56].copy_from_slice(&sh.sh_addralign.to_le_bytes());
            image[at + 56..at + 64].copy_from_slice(&sh.sh_entsize.to_le_bytes());
        };
        for (k, &oi) in emit_order.iter().enumerate() {
            let o = &self.outs[oi];
            wr_shdr(
                k + 1,
                Elf64Shdr {
                    sh_name: shstr_names[k],
                    sh_type: o.shtype,
                    sh_flags: o.flags,
                    sh_addr: o.addr,
                    sh_offset: file_off[&oi],
                    sh_size: o.size,
                    sh_link: 0,
                    sh_info: 0,
                    sh_addralign: o.align,
                    sh_entsize: o.entsize,
                },
                &mut image,
            );
        }
        let symtab_idx = emit_order.len() + 1;
        wr_shdr(
            symtab_idx,
            Elf64Shdr {
                sh_name: n_symtab,
                sh_type: SHT_SYMTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: symtab_off,
                sh_size: sym_bytes.len() as u64,
                sh_link: (symtab_idx + 1) as u32,
                sh_info: locals,
                sh_addralign: 8,
                sh_entsize: 24,
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 1,
            Elf64Shdr {
                sh_name: n_strtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: strtab_off,
                sh_size: strtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        wr_shdr(
            symtab_idx + 2,
            Elf64Shdr {
                sh_name: n_shstrtab,
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: shstr_off,
                sh_size: shstrtab.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
            &mut image,
        );
        for (k, (oi, body)) in rela.iter().enumerate() {
            wr_shdr(
                symtab_idx + 3 + k,
                Elf64Shdr {
                    sh_name: rela_names[k],
                    sh_type: SHT_RELA,
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: rela_off[k],
                    sh_size: body.len() as u64,
                    sh_link: symtab_idx as u32,
                    sh_info: shndx_of_out[oi] as u32,
                    sh_addralign: 8,
                    sh_entsize: 24,
                },
                &mut image,
            );
        }

        // Build-id digest over the whole image with the digest field
        // zeroed (it already is), then patched in place.
        if self.opts.build_id_sha1
            && let Some((out, off)) = self.build_id_location()
            && !self.outs[out].removed
            && self.outs[out].shtype != SHT_NOBITS
        {
            let file_at = file_off[&out] + off + 16;
            let digest = sha1(&image);
            let at = file_at as usize;
            if at + 20 <= image.len() {
                image[at..at + 20].copy_from_slice(&digest);
            }
        }
        Ok(image)
    }

    fn build_id_location(&self) -> Option<(usize, u64)> {
        let synth = self.synth_obj;
        let sec = self.objects[synth]
            .sections
            .iter()
            .position(|s| s.name == SYNTH_BUILD_ID)?;
        let i = self.insec_index(synth, sec);
        match self.fates[i] {
            SecFate::Placed { out } => Some((out, self.placements[i].off)),
            _ => None,
        }
    }

    // ----------------------------------------------------------- map

    fn render_map(&self, emit_order: &[usize]) -> String {
        use core::fmt::Write as _;
        let mut s = String::new();
        let _ = writeln!(s, "Memory Configuration\n");
        let _ = writeln!(
            s,
            "Name             Origin             Length             Attributes"
        );
        let _ = writeln!(
            s,
            "*default*        0x0000000000000000 0xffffffffffffffff\n"
        );
        let _ = writeln!(s, "Linker script and memory map\n");
        for &oi in emit_order {
            let o = &self.outs[oi];
            let _ = writeln!(
                s,
                "{:<15} 0x{:016x} 0x{:x}{}",
                o.name,
                o.addr,
                o.size,
                if o.lma != o.addr {
                    format!(" load address 0x{:016x}", o.lma)
                } else {
                    String::new()
                }
            );
            for (off, len, src) in &o.chunks {
                if let ChunkSrc::Input(i) = src {
                    let id = self.insecs[*i];
                    let _ = writeln!(
                        s,
                        " {:<14} 0x{:016x} 0x{:x} {}",
                        self.insec(*i).name,
                        o.addr + off,
                        len,
                        self.objects[id.obj].source
                    );
                }
            }
        }
        s
    }
}

/// SHA-1 (FIPS 180-4), for `--build-id=sha1`.
fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let ml = (data.len() as u64).wrapping_mul(8);
    let mut block = [0u8; 64];
    let process = |h: &mut [u32; 5], chunk: &[u8]| {
        let mut w = [0u32; 80];
        for i in 0..16 {
            w[i] = u32::from_be_bytes([
                chunk[i * 4],
                chunk[i * 4 + 1],
                chunk[i * 4 + 2],
                chunk[i * 4 + 3],
            ]);
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let (mut a, mut b, mut c, mut d, mut e) = (h[0], h[1], h[2], h[3], h[4]);
        for (i, &wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | ((!b) & d), 0x5A827999u32),
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
            c = b.rotate_left(30);
            b = a;
            a = tmp;
        }
        h[0] = h[0].wrapping_add(a);
        h[1] = h[1].wrapping_add(b);
        h[2] = h[2].wrapping_add(c);
        h[3] = h[3].wrapping_add(d);
        h[4] = h[4].wrapping_add(e);
    };
    let mut i = 0;
    while i + 64 <= data.len() {
        process(&mut h, &data[i..i + 64]);
        i += 64;
    }
    let rest = data.len() - i;
    block[..rest].copy_from_slice(&data[i..]);
    block[rest] = 0x80;
    if rest + 1 > 56 {
        for b in block[rest + 1..].iter_mut() {
            *b = 0;
        }
        process(&mut h, &block.clone());
        block = [0u8; 64];
    }
    block[56..64].copy_from_slice(&ml.to_be_bytes());
    process(&mut h, &block.clone());
    let mut out = [0u8; 20];
    for (k, hv) in h.iter().enumerate() {
        out[k * 4..k * 4 + 4].copy_from_slice(&hv.to_be_bytes());
    }
    out
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

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::lds::parse_linker_script;

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
    }

    impl TestObj {
        fn new() -> Self {
            TestObj {
                secs: Vec::new(),
                syms: Vec::new(),
                entsizes: Vec::new(),
                sym_vis: Vec::new(),
            }
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
        fn reloc(mut self, sec: usize, offset: u64, sym: u32, rtype: u32, addend: i64) -> Self {
            self.secs[sec].5.push(RawReloc {
                offset,
                sym,
                rtype,
                addend,
            });
            self
        }
        fn sym(
            mut self,
            name: &str,
            bind: u8,
            kind: u8,
            sec: usize,
            value: u64,
            size: u64,
        ) -> Self {
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
            let nsec = self.secs.len();
            let mut bodies: Vec<u8> = Vec::new();
            let mut body_off: Vec<usize> = Vec::new();
            for (_, shtype, _, _, body, _) in &self.secs {
                body_off.push(64 + bodies.len());
                if *shtype != SHT_NOBITS {
                    bodies.extend_from_slice(body);
                }
            }
            // Symtab: null + one section symbol per section + named.
            let mut strtab: Vec<u8> = alloc::vec![0];
            let mut symtab: Vec<u8> = alloc::vec![0; 24];
            for k in 0..nsec {
                let mut e = [0u8; 24];
                e[4] = STT_SECTION;
                e[6..8].copy_from_slice(&((k + 1) as u16).to_le_bytes());
                symtab.extend_from_slice(&e);
            }
            for (k, (name, bind, kind, sec, value, size)) in self.syms.iter().enumerate() {
                let noff = strtab.len() as u32;
                strtab.extend_from_slice(name.as_bytes());
                strtab.push(0);
                let mut e = [0u8; 24];
                e[0..4].copy_from_slice(&noff.to_le_bytes());
                e[4] = (bind << 4) | kind;
                if let Some(&(_, other)) = self.sym_vis.iter().find(|&&(i, _)| i == k) {
                    e[5] = other;
                }
                let shndx: u16 = if *sec == usize::MAX {
                    0
                } else if *sec == usize::MAX - 1 {
                    SHN_ABS
                } else {
                    (*sec + 1) as u16
                };
                e[6..8].copy_from_slice(&shndx.to_le_bytes());
                e[8..16].copy_from_slice(&value.to_le_bytes());
                e[16..24].copy_from_slice(&size.to_le_bytes());
                symtab.extend_from_slice(&e);
            }
            let mut out: Vec<u8> = alloc::vec![0; 64];
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
                    out.extend_from_slice(&r.offset.to_le_bytes());
                    let info = ((r.sym as u64) << 32) | r.rtype as u64;
                    out.extend_from_slice(&info.to_le_bytes());
                    out.extend_from_slice(&r.addend.to_le_bytes());
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
                rela_names.push(add_name(
                    &format!(".rela{}", self.secs[*target].0),
                    &mut shstr,
                ));
            }
            let n_shstr = add_name(".shstrtab", &mut shstr);
            let shstr_at = out.len();
            out.extend_from_slice(&shstr);
            while !out.len().is_multiple_of(8) {
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
                let mut h = [0u8; 64];
                h[0..4].copy_from_slice(&name.to_le_bytes());
                h[4..8].copy_from_slice(&shtype.to_le_bytes());
                h[8..16].copy_from_slice(&flags.to_le_bytes());
                h[24..32].copy_from_slice(&(off as u64).to_le_bytes());
                h[32..40].copy_from_slice(&(size as u64).to_le_bytes());
                h[40..44].copy_from_slice(&link.to_le_bytes());
                h[44..48].copy_from_slice(&info.to_le_bytes());
                h[48..56].copy_from_slice(&align.to_le_bytes());
                h[56..64].copy_from_slice(&entsize.to_le_bytes());
                h
            };
            let mut shdrs: Vec<[u8; 64]> = alloc::vec![[0u8; 64]];
            for (k, (_, shtype, flags, align, body, _)) in self.secs.iter().enumerate() {
                let entsize = self
                    .entsizes
                    .iter()
                    .find(|(s, _)| *s == k)
                    .map(|(_, e)| *e)
                    .unwrap_or(0);
                shdrs.push(hdr(
                    names[k],
                    *shtype,
                    *flags,
                    body_off[k],
                    body.len(),
                    0,
                    0,
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
                8,
                24,
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
                    SHT_RELA,
                    0,
                    *at,
                    count * 24,
                    symtab_shndx as u32,
                    (*target + 1) as u32,
                    8,
                    24,
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
            out[4] = 2;
            out[5] = 1;
            out[6] = 1;
            out[16..18].copy_from_slice(&1u16.to_le_bytes());
            out[18..20].copy_from_slice(&machine.to_le_bytes());
            out[40..48].copy_from_slice(&(shoff as u64).to_le_bytes());
            out[52..54].copy_from_slice(&64u16.to_le_bytes());
            out[58..60].copy_from_slice(&64u16.to_le_bytes());
            out[60..62].copy_from_slice(&(shnum as u16).to_le_bytes());
            out[62..64].copy_from_slice(&((shnum - 1) as u16).to_le_bytes());
            out
        }
    }

    fn readelf_sections(image: &[u8]) -> Vec<(String, u32, u64, u64, u64)> {
        let shoff = u64::from_le_bytes(image[40..48].try_into().unwrap()) as usize;
        let shnum = u16::from_le_bytes(image[60..62].try_into().unwrap()) as usize;
        let shstrndx = u16::from_le_bytes(image[62..64].try_into().unwrap()) as usize;
        let sh = |i: usize| -> Elf64Shdr { read_struct(image, shoff + i * 64).unwrap() };
        let str_sh = sh(shstrndx);
        let strtab =
            &image[str_sh.sh_offset as usize..(str_sh.sh_offset + str_sh.sh_size) as usize];
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
                let strtab =
                    &image[strh.sh_offset as usize..(strh.sh_offset + strh.sh_size) as usize];
                let n = (h.sh_size / 24) as usize;
                return (0..n)
                    .map(|k| {
                        let s: Elf64Sym =
                            read_struct(image, h.sh_offset as usize + k * 24).unwrap();
                        (strz(strtab, s.st_name as usize), s.st_value, s.st_shndx)
                    })
                    .collect();
            }
        }
        Vec::new()
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
        let disp =
            i32::from_le_bytes(res.image[text_off + 1..text_off + 5].try_into().unwrap()) as i64;
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
    /// `.rela.<outsec>` entry whose `r_offset` is the final address,
    /// whose symbol index names the output symtab entry the input
    /// relocation referenced, and whose addend is the input's. This is
    /// what `arch/x86/tools/relocs` reads to build the KASLR table.
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
        let plain = link_with_script(&script, two_objects(), &LdsOptions::default())
            .expect("link succeeds");
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
        let e =
            link_with_script(&script, two_objects(), &opts).expect_err("orphan must fail the link");
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

    #[test]
    fn relr_encoding_round_trips() {
        let addrs = [0x1000u64, 0x1008, 0x1010, 0x1400, 0x1408 + 63 * 8];
        let words = encode_relr(&addrs);
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
                let strh: Elf64Shdr =
                    read_struct(&res.image, shoff + h.sh_link as usize * 64).unwrap();
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
}
