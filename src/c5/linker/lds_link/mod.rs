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
//!
//! The phases, one submodule each: `inputs` reads an ET_REL,
//! `sections` flattens and claims them, `pools` merges SHF_MERGE and
//! `.eh_frame`, `layout` walks the statements, `eval` evaluates script
//! expressions, `veneers` reserves erratum stubs, `dynamic_sections`
//! and `got` size the dynamic tables and slots, `reloc` /
//! `reloc_aarch64` apply relocations, `synth` fills synthetic content,
//! `phdrs` and `symtab` build the program headers and the symbol
//! table, and `write` assembles the image.

#![cfg(feature = "std")]
#![allow(dead_code)]

mod dynamic_sections;
mod eval;
mod got;
mod inputs;
mod layout;
mod phdrs;
mod pools;
mod reloc;
mod reloc_aarch64;
mod sections;
mod symtab;
mod synth;
#[cfg(test)]
mod tests;
mod veneers;
mod write;

use super::comdat::SecId;
use super::link_err;

/// The tag this module's diagnostics carry.
pub(super) const MODULE: &str = "";
use super::dynamic::{DynTables, HashStyle, VerDef};
use super::gnu_property;
use super::lds::{Assignment, DataWidth, Expr, LinkerScript, OutputSectionType};
use super::object::{ElfClass, SharedLibrary};
use crate::c5::diag::{Code, Config, Control, Diagnostic, Sink};
use crate::c5::error::C5Error;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::{HashMap, HashSet};

use inputs::RawSection;
pub use inputs::{LdsObject, parse_lds_object};
use sections::is_debug_section;

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

const SHT_X86_64_UNWIND: u32 = 0x7000_0001;

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

const STV_PROTECTED: u8 = 3;

const PT_LOAD: u32 = 1;

const PT_DYNAMIC: u32 = 2;

const PT_INTERP: u32 = 3;

const PT_PHDR: u32 = 6;

const PT_NOTE: u32 = 4;

const PT_GNU_EH_FRAME: u32 = 0x6474e550;

const PT_GNU_STACK: u32 = 0x6474e551;

const PT_GNU_PROPERTY: u32 = 0x6474e553;

const PF_X: u32 = 1;

const PF_W: u32 = 2;

const PF_R: u32 = 4;

const ET_EXEC: u16 = 2;

const ET_DYN: u16 = 3;

const EM_386: u16 = 3;

const EM_X86_64: u16 = 62;

const EM_AARCH64: u16 = 183;

/// ELF class an emulation's machine is linked at. Only i386 among the
/// machines badc targets is ELF32.
fn class_for_machine(machine: u16) -> ElfClass {
    match machine {
        EM_386 => ElfClass::Elf32,
        _ => ElfClass::Elf64,
    }
}

/// True where the target's default relocation format carries an
/// explicit addend (`SHT_RELA`). i386 uses `SHT_REL`.
fn machine_uses_rela(machine: u16) -> bool {
    machine != EM_386
}

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

/// A shared library input and how the link named it.
#[derive(Debug, Clone)]
pub struct SharedInput {
    pub lib: SharedLibrary,
    /// Named under a linker script's `AS_NEEDED`: it takes a dependency
    /// record only where the link binds to it.
    pub as_needed: bool,
}

#[derive(Debug, Clone)]
pub struct LdsOptions {
    pub emit: LdsEmit,
    /// `-shared` rather than `-pie`. Both emit `ET_DYN`; the two
    /// differ in the output kind a diagnostic names.
    pub shared: bool,
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
    /// The levels the command line asked for. A link diagnostic has no
    /// source position, so the pragmas never apply to one.
    pub diag: Config,
    /// `-soname`: recorded as `DT_SONAME`.
    pub soname: Option<String>,
    /// Output file base name. Names the base version definition where
    /// no soname was given, as bfd's does.
    pub output_name: String,
    /// `--hash-style`.
    pub hash_style: HashStyle,
    /// `-Bsymbolic`: `DT_SYMBOLIC` and `DF_SYMBOLIC`.
    pub symbolic: bool,
    /// `-n` / `--nmagic`: a `PT_LOAD` aligns to the strongest
    /// alignment among its sections rather than to a page.
    pub nmagic: bool,
    /// `--eh-frame-hdr`: build the unwinder's FDE search table.
    pub eh_frame_hdr: bool,
    /// `--gc-sections`: drop every allocatable input section no kept
    /// section reaches.
    pub gc_sections: bool,
    /// `-u` / `--undefined`: names the link must resolve. Each is a
    /// garbage-collection root.
    pub undefined: Vec<String>,
    /// `--dynamic-linker`: the `PT_INTERP` program interpreter.
    pub interp: Option<String>,
    /// Shared libraries named on the command line, in order. Each takes
    /// a `DT_NEEDED` and satisfies references its exports name.
    pub shared_libs: Vec<SharedInput>,
    /// `-rpath`: the library search path recorded in the image.
    pub rpath: Vec<String>,
    /// `--enable-new-dtags`: record the search path as `DT_RUNPATH`.
    pub new_dtags: bool,
    /// `--fix-cortex-a53-843419`: rewrite the erratum sequences, as
    /// ADR where the page is in range and through a veneer otherwise.
    pub fix_cortex_a53_843419: bool,
}

impl Default for LdsOptions {
    fn default() -> Self {
        LdsOptions {
            emit: LdsEmit::Exec,
            shared: false,
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
            diag: Config::new(),
            soname: None,
            output_name: String::new(),
            hash_style: HashStyle::default(),
            symbolic: false,
            nmagic: false,
            eh_frame_hdr: false,
            gc_sections: false,
            undefined: Vec::new(),
            interp: None,
            shared_libs: Vec::new(),
            rpath: Vec::new(),
            new_dtags: false,
            fix_cortex_a53_843419: false,
        }
    }
}

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
    /// Created by orphan placement rather than named by the script.
    orphan: bool,
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

impl OutSec {
    /// A section with nothing laid yet.
    fn empty(name: String) -> OutSec {
        OutSec {
            name,
            address: None,
            stype: None,
            at: None,
            align_attr: None,
            pieces: Vec::new(),
            phdrs: Vec::new(),
            fill: None,
            orphan: false,
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
        }
    }
}

#[derive(Debug, Clone)]
enum ChunkSrc {
    Input(usize),
    Bytes(Vec<u8>),
    /// Fill pattern applied over the range.
    Pad(Vec<u8>),
    /// Zero-initialized area reserved for erratum workaround veneers,
    /// written after relocations settle the instruction bytes.
    Veneers,
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

    /// Value an expression naming the symbol that holds it sees. Only
    /// the definition taken from the location counter picks up a
    /// section for its own symtab entry, so what it hands on is a
    /// number (bfd's rel_from_abs).
    fn as_reference(self) -> Val {
        match self.att {
            Att::DotAbs => Val::abs(self.v),
            _ => self,
        }
    }
}

#[derive(Debug, Clone)]
struct ScriptSym {
    val: Val,
    hidden: bool,
    /// Symbol type the definition took from its expression.
    kind: u8,
    /// Output section carrying the symbol in the symtab when the
    /// value came from the location counter outside any output
    /// section (ld's section_for_dot fixup); the value itself stays
    /// absolute for expression purposes.
    final_out: Option<usize>,
    /// Visibility that does not localize the binding, used by the
    /// synthesized `__start_` / `__stop_` pair. `hidden` stays the
    /// `PROVIDE_HIDDEN` path, which does localize.
    vis: Option<u8>,
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

/// A `.eh_frame` input rewritten with its duplicate CIEs dropped.
struct EhFrame {
    bytes: Vec<u8>,
    /// Size before the rewrite, for end-of-section references.
    orig_size: u64,
    /// Surviving ranges as (input offset, length, new offset), sorted.
    kept: Vec<(u64, u64, u64)>,
    /// Per FDE: its new offset, and the input section and new offset of
    /// the CIE it names.
    fdes: Vec<(u64, usize, u64)>,
}

impl EhFrame {
    /// New offset of `off`, or `None` when the entry holding it went
    /// away.
    fn remap(&self, off: u64) -> Option<u64> {
        if off >= self.orig_size {
            return Some(self.bytes.len() as u64);
        }
        match self.kept.binary_search_by_key(&off, |k| k.0) {
            Ok(k) => Some(self.kept[k].2),
            Err(0) => None,
            Err(k) => {
                let (o, len, new) = self.kept[k - 1];
                (off - o < len).then_some(new + (off - o))
            }
        }
    }
}

struct DynReloc {
    offset: u64,
    rtype: u32,
    addend: i64,
    /// `.dynsym` index the entry names; 0 where the fixup needs no
    /// symbol.
    sym: u32,
}

pub struct LdsLinker<'a> {
    script: &'a LinkerScript,
    objects: Vec<LdsObject>,
    opts: LdsOptions,
    machine: u16,
    class: ElfClass,

    /// Flattened input sections across objects.
    insecs: Vec<InSecId>,
    /// First `insecs` index of each object.
    obj_base: Vec<usize>,
    fates: Vec<SecFate>,
    /// Sections a losing COMDAT group or `.gnu.linkonce` duplicate
    /// owns. They contribute nothing: no bytes, no symbols, no
    /// garbage-collection roots or edges.
    comdat_dropped: HashSet<SecId>,
    /// insec index -> merge pool key, for merged sections.
    merge_of: HashMap<usize, usize>,
    /// Orphan class -> the output section later orphans stack after.
    orphan_anchor: HashMap<u32, usize>,
    pools: Vec<MergePool>,
    /// insec index -> `.eh_frame` rewrite, for the inputs that lost a
    /// CIE to deduplication.
    eh_of: HashMap<usize, usize>,
    eh_frames: Vec<EhFrame>,
    /// Undefined references bound to an input shared library, sorted.
    /// Their `.dynsym` indices are `1 + position`, which is what the
    /// symbol-named dynamic relocations carry.
    imports: Vec<String>,
    import_of: HashMap<String, usize>,
    /// The subset reached by a call, in the order of their PLT stubs.
    plt_syms: Vec<String>,
    plt_of: HashMap<String, usize>,
    /// Program headers `SIZEOF_HEADERS` accounts for where the script
    /// declares none, measured from the previous round's layout.
    phdrs: usize,

    outs: Vec<OutSec>,
    /// Statement stream of the SECTIONS block with input claims
    /// resolved; `usize` indexes `outs`.
    stmts: Vec<Stmt>,

    /// Global symbol resolution: name -> defining (obj, sym index).
    globals: HashMap<String, (usize, usize)>,
    /// Common symbols coalesced into a synthetic bss chunk:
    /// name -> (insec index, offset, size, align).
    commons: HashMap<String, (usize, u64)>,
    /// Every symbol the script assigns anywhere. A script assignment
    /// outranks a synthesized section bound whatever order the two
    /// reach the symbol table in.
    script_assigned: HashSet<String>,

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
    sink: Sink,
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
    /// Dynamic tables, rebuilt each pass from the current placement.
    dyn_tables: Option<DynTables>,
    /// Version definitions from the script's `VERSION` command, base
    /// node first. Empty when the script defines none.
    verdefs: Vec<VerDef>,
    /// `--emit-relocs` records, gathered on the final pass.
    emitted: Vec<EmittedReloc>,
    /// Where `build_symtab` put each symbol, for resolving `emitted`.
    sym_index: SymIndex,
    /// Merged `.note.gnu.property` body, empty when no input carries a
    /// property that survives the merge.
    gnu_property: Vec<u8>,
    /// Per output section, bytes reserved after its last input piece
    /// for erratum veneers; multiples of the page size so the insertion
    /// preserves every following page offset and the site set with it.
    veneer_reserve: BTreeMap<usize, u64>,
    /// Veneer symbols the fix pass placed: (name, output section,
    /// address).
    veneer_syms: Vec<(String, usize, u64)>,
    /// Per input section, its code ranges from `$x`/`$d` mapping
    /// symbols; a section absent here is scanned whole.
    code_spans: HashMap<usize, Vec<(u64, u64)>>,
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

/// One applied relocation kept for `--emit-relocs`; the output symtab
/// index is resolved once that table exists.
#[derive(Debug, Clone, Copy)]
struct EmittedReloc {
    out: usize,
    addr: u64,
    rtype: u32,
    /// Resolved `S + A`; the emitted addend is this less the final
    /// value of the symbol the entry names.
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

const SYNTH_REL: &str = ".rel.dyn";

const SYNTH_RELR: &str = ".relr.dyn";

const SYNTH_GOT: &str = ".got";

const SYNTH_GOTPLT: &str = ".got.plt";

const SYNTH_BUILD_ID: &str = ".note.gnu.build-id";

const SYNTH_COMMON: &str = "COMMON";

const SYNTH_DYNSYM: &str = ".dynsym";

const SYNTH_DYNSTR: &str = ".dynstr";

const SYNTH_HASH: &str = ".hash";

const SYNTH_GNU_HASH: &str = ".gnu.hash";

const SYNTH_VERSYM: &str = ".gnu.version";

const SYNTH_VERDEF: &str = ".gnu.version_d";

const SYNTH_DYNAMIC: &str = ".dynamic";

const SYNTH_EH_FRAME_HDR: &str = ".eh_frame_hdr";

const SYNTH_INTERP: &str = ".interp";

const SYNTH_PLT: &str = ".plt";

const SYNTH_GNU_PROPERTY: &str = ".note.gnu.property";

const OUT_EH_FRAME: &str = ".eh_frame";

#[derive(Debug)]
pub struct LdsResult {
    pub image: Vec<u8>,
    pub map: String,
    pub warnings: Vec<Diagnostic>,
}

pub fn link_with_script(
    script: &LinkerScript,
    inputs: Vec<LdsObject>,
    opts: &LdsOptions,
) -> Result<LdsResult, C5Error> {
    let mut linker = LdsLinker::new(script, inputs, opts.clone())?;
    linker.run()
}

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
    fn new(
        script: &'a LinkerScript,
        mut objects: Vec<LdsObject>,
        opts: LdsOptions,
    ) -> Result<Self, C5Error> {
        if objects.is_empty() {
            return Err(link_err(MODULE, "no input objects"));
        }
        let machine = objects[0].machine;
        for o in &objects[1..] {
            if o.machine != machine {
                return Err(link_err(
                    MODULE,
                    &format!(
                        "{}: machine {} differs from {}'s {}",
                        o.source, o.machine, objects[0].source, machine
                    ),
                ));
            }
        }
        for o in &objects {
            if o.class != class_for_machine(machine) {
                return Err(link_err(
                    MODULE,
                    &format!(
                        "{}: ELF class does not match machine {}",
                        o.source,
                        super::relocatable::elf_machine_desc(machine)
                    ),
                ));
            }
        }
        // Property notes are merged into one synthesized note rather
        // than concatenated: a consumer reading the first note must see
        // the whole image's claim, not one input's. Every input counts
        // towards the merge, including those with no property section.
        let prop_notes: Vec<Vec<&[u8]>> = objects
            .iter()
            .map(|o| {
                o.sections
                    .iter()
                    .filter(|s| s.name == SYNTH_GNU_PROPERTY && s.shtype == SHT_NOTE)
                    .filter_map(|s| o.bytes.get(s.data_off..s.data_off + s.size as usize))
                    .collect()
            })
            .collect();
        let gnu_property = gnu_property::merge_section(
            &prop_notes,
            class_for_machine(machine).addr_size() as usize,
        )
        .unwrap_or_default();
        // `.note.GNU-stack` conveys stack executability and nothing
        // else; bfd consumes it and never places it. Keeping it would
        // put a PROGBITS input in whatever `*(.note*)` rule claims it,
        // which then stops being a note section.
        let drop_input = |s: &RawSection| {
            s.name == ".note.GNU-stack"
                || (s.name == SYNTH_GNU_PROPERTY && s.shtype == SHT_NOTE)
                || (opts.strip_debug && is_debug_section(&s.name))
        };
        for o in &mut objects {
            if !o.sections.iter().any(drop_input) {
                continue;
            }
            let orig: Vec<u32> = o.sections.iter().map(|s| s.orig_shndx).collect();
            o.sections.retain(|s| !drop_input(s));
            o.shndx_map = o
                .sections
                .iter()
                .enumerate()
                .map(|(i, s)| (s.orig_shndx, i))
                .collect();
            for g in &mut o.groups {
                g.members
                    .retain_mut(|m| match o.shndx_map.get(&orig[*m]).copied() {
                        Some(i) => {
                            *m = i;
                            true
                        }
                        None => false,
                    });
            }
        }
        // Pseudo-object for linker-synthesized sections.
        let synth_obj = objects.len();
        objects.push(LdsObject {
            source: "<linker>".to_string(),
            bytes: Vec::new(),
            machine,
            class: class_for_machine(machine),
            sections: Vec::new(),
            symbols: Vec::new(),
            groups: Vec::new(),
            shndx_map: HashMap::new(),
        });

        let class = class_for_machine(machine);
        let sink = Sink::new(opts.diag.clone(), Control::default());
        let mut linker = LdsLinker {
            script,
            objects,
            opts,
            machine,
            class,
            insecs: Vec::new(),
            obj_base: Vec::new(),
            fates: Vec::new(),
            comdat_dropped: HashSet::new(),
            merge_of: HashMap::new(),
            orphan_anchor: HashMap::new(),
            pools: Vec::new(),
            eh_of: HashMap::new(),
            eh_frames: Vec::new(),
            imports: Vec::new(),
            import_of: HashMap::new(),
            plt_syms: Vec::new(),
            plt_of: HashMap::new(),
            phdrs: 4,
            outs: Vec::new(),
            stmts: Vec::new(),
            globals: HashMap::new(),
            commons: HashMap::new(),
            script_assigned: HashSet::new(),
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
            sink,
            undefined: BTreeSet::new(),
            referenced: HashSet::new(),
            synth_obj,
            dyn_relas: Vec::new(),
            dyn_nones: None,
            relr_addrs: Vec::new(),
            got_slots: Vec::new(),
            got_map: HashMap::new(),
            dyn_tables: None,
            verdefs: Vec::new(),
            emitted: Vec::new(),
            sym_index: SymIndex::default(),
            gnu_property,
            veneer_reserve: BTreeMap::new(),
            veneer_syms: Vec::new(),
            code_spans: HashMap::new(),
        };
        linker.dedup_groups();
        linker.resolve_globals()?;
        linker.synthesize_sections();
        linker.flatten_inputs();
        linker.build_statements()?;
        linker.collect_script_assigned();
        linker.gc_sections();
        linker.claim_inputs()?;
        linker.build_merge_pools();
        linker.build_eh_frame_dedup();
        linker.build_imports();
        linker.build_code_spans();
        Ok(linker)
    }

    fn insec(&self, i: usize) -> &RawSection {
        let id = self.insecs[i];
        &self.objects[id.obj].sections[id.sec]
    }

    fn insec_index(&self, obj: usize, sec: usize) -> usize {
        self.obj_base[obj] + sec
    }

    fn run(&mut self) -> Result<LdsResult, C5Error> {
        let mut converged = false;
        // Each round settles the layout for the current header count,
        // then measures the count that layout produces.
        for _round in 0..4 {
            let mut prev_fingerprint: Option<Vec<u64>> = None;
            converged = false;
            for _pass in 0..48 {
                self.layout_pass(false)?;
                self.a53_size_reserve();
                let fp = self.fingerprint();
                if prev_fingerprint.as_ref() == Some(&fp) {
                    converged = true;
                    break;
                }
                prev_fingerprint = Some(fp);
            }
            if !converged {
                break;
            }
            let order = self.kept_order();
            let n = self.build_phdrs(&order)?.len();
            if n == self.phdr_count_estimate() {
                break;
            }
            self.phdrs = n;
        }
        if !converged {
            return Err(link_err(MODULE, "script layout did not converge"));
        }
        self.layout_pass(true)?;
        if !self.errors.is_empty() {
            return Err(link_err(MODULE, &self.errors.join("\n")));
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
            return Err(link_err(MODULE, &format!("{}{}", list.join("\n"), extra)));
        }
        let res = self.finish()?;
        // Writing the image can fail on its own: an `.eh_frame` the FDE
        // scan cannot read, or a synthesized table that outgrew the
        // section sized for it.
        if !self.errors.is_empty() {
            return Err(link_err(MODULE, &self.errors.join("\n")));
        }
        // A diagnostic the command line raised to an error does not
        // unwind at its site; it fails the link here, carrying every
        // diagnostic the link produced.
        if self.sink.has_errors() {
            return Err(C5Error::Compile(
                res.warnings
                    .iter()
                    .map(|d| d.to_string())
                    .collect::<Vec<_>>()
                    .join("\n"),
            ));
        }
        Ok(res)
    }

    fn find_out(&self, name: &str) -> Option<usize> {
        self.outs.iter().position(|o| o.name == name)
    }

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
                    ChunkSrc::Veneers => {}
                }
            }
            contents.insert(oi, buf);
        }
        self.patch_eh_frame(&mut contents);

        // Apply relocations into the content buffers.
        let relr_set: HashSet<u64> = self.relr_addrs.iter().copied().collect();
        self.apply_relocations(&mut contents, &relr_set)?;
        self.fill_synth_contents(&mut contents, &relr_set, &out_shndx);
        self.a53_apply_fix(&mut contents);

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
                    self.sink.emit(
                        Code::MISSING_ENTRY,
                        None,
                        format!(
                            "cannot find entry symbol {name}; defaulting to first text address"
                        ),
                    );
                    self.default_entry(&emit_order)
                }
            },
            // Nothing named an entry. A shared object has none, as bfd
            // leaves `e_entry` zero for one; an executable takes bfd's
            // default entry symbol and, failing that, its first text
            // address. A PIE is an executable.
            None if self.opts.shared => 0,
            None => self
                .final_sym_value("_start")
                .unwrap_or_else(|| self.default_entry(&emit_order)),
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
            warnings: self.sink.take(),
        })
    }
}
