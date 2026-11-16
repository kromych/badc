//! link.exe's `/DELAYLOAD:dll`: the imports from a DLL bind through its
//! delay-load descriptor (PE data directory 13). The link defines each
//! import's slot `__imp_X`, holding `__imp_load_X` until
//! `__delayLoadHelper2` stores the import's address, and `X`, a jump through
//! the slot; `__imp_load_X` reaches the helper through `__tailMerge_<dll>`.

use super::import_slots::PREFIX;
use super::link::{Supplier, supplier};
use super::object::{
    NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol, STT_FUNC, STT_NOTYPE,
    STT_OBJECT, STT_SECTION, STV_HIDDEN, SharedLibrary,
};
use crate::c5::codegen::{A64Exit, A64Step, PrologueStep, UnwindSteps};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::object::elf_reloc_types::{
    R_AARCH64_ABS64, R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26,
    R_AARCH64_JUMP26, R_AARCH64_LDST64_ABS_LO12_NC, R_PE_ADDR32NB, R_X86_64_64, R_X86_64_PC32,
    R_X86_64_PLT32,
};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

/// The delay-load helper, which `delayimp.lib` or badc's C library supplies.
pub const HELPER: &str = "__delayLoadHelper2";

/// The descriptor table, sized to its terminating null descriptor.
pub(crate) const TABLE: &str = "__DELAY_IMPORT_DIRECTORY";

/// `ImgDelayDescr`; `dlattrRva` makes its fields RVAs.
const DESCRIPTOR: usize = 32;
const ATTR_RVA: u32 = 1;
const ORDINAL_FLAG: u64 = 1 << 63;

/// An object of no content referencing the helper, for a library to supply.
pub fn delay_load_root(machine: NativeMachine) -> NativeObject {
    let mut o = NativeObject::empty(machine);
    o.symbols = vec![global(HELPER, NativeSymSection::Undef, 0, STT_NOTYPE)];
    o
}

pub(crate) struct Delayed {
    pub(crate) object: Option<NativeObject>,
    pub(crate) warnings: Vec<(Code, String)>,
}

struct Import<'a> {
    name: &'a str,
    /// The DLL's spelling.
    symbol: &'a str,
    ordinal: Option<u16>,
    hint: u16,
    /// A reference names `X` rather than its slot, which takes the thunk.
    called: bool,
}

/// The object defining the imports `objs` take from the DLLs `dlls` names,
/// each bound to its DLL as the import table binds it.
pub(crate) fn delay_imports(
    objs: &[NativeObject],
    libs: &[SharedLibrary],
    dlls: &[String],
) -> Result<Delayed, C5Error> {
    let Some(machine) = objs.first().map(|o| o.machine) else {
        return Ok(Delayed {
            object: None,
            warnings: Vec::new(),
        });
    };
    let defined: BTreeSet<&str> = (objs.iter())
        .flat_map(|o| &o.symbols)
        .filter(|s| s.binding != 0 && s.section != NativeSymSection::Undef)
        .map(|s| s.name.as_str())
        .collect();
    let mut routing: BTreeMap<&str, &str> = BTreeMap::new();
    for o in objs {
        for (name, idx) in &o.import_dylib_map {
            if let Some(dll) = o.dylibs.get(*idx as usize) {
                routing.entry(name.as_str()).or_insert(dll.as_str());
            }
        }
    }
    let mut called: BTreeMap<&str, bool> = BTreeMap::new();
    let undefined = (objs.iter())
        .flat_map(|o| &o.symbols)
        .filter(|s| s.binding != 0 && s.section == NativeSymSection::Undef);
    for s in undefined {
        let (name, slot) = match s.name.strip_prefix(PREFIX) {
            Some(t) if !t.is_empty() && !defined.contains(s.name.as_str()) => (t, true),
            _ => (s.name.as_str(), false),
        };
        if !defined.contains(name) {
            *called.entry(name).or_default() |= !slot;
        }
    }
    let mut by_dll: Vec<(Option<&str>, Vec<Import>)> =
        dlls.iter().map(|_| (None, Vec::new())).collect();
    for (&name, &call) in &called {
        let usable = |i: usize| !libs[i].soname.is_empty();
        let (dll, lib) = match supplier(name, routing.contains_key(name), true, libs, usable) {
            Some(Supplier::Routing) => (routing[name], None),
            Some(Supplier::Library(i)) => (libs[i].soname.as_str(), Some(&libs[i])),
            None => continue,
        };
        let Some(k) = dlls.iter().position(|d| d.eq_ignore_ascii_case(dll)) else {
            continue;
        };
        if lib.is_some_and(|l| l.data_exports.contains(name)) {
            return Err(super::link_err(
                Code::LINK,
                "",
                &format!("`{name}` is data, which the delay-loaded `{dll}` cannot supply"),
            ));
        }
        by_dll[k].0 = Some(dll);
        by_dll[k].1.push(Import {
            name,
            symbol: lib
                .and_then(|l| l.export_symbols.get(name))
                .map_or(name, String::as_str),
            ordinal: lib.and_then(|l| l.export_ordinals.get(name).copied()),
            hint: lib
                .and_then(|l| l.export_hints.get(name).copied())
                .unwrap_or(0),
            called: call,
        });
    }
    let warnings = (dlls.iter().zip(&by_dll))
        .filter(|(_, (dll, _))| dll.is_none())
        .map(|(d, _)| {
            let text = format!("`--delayload={d}`: the link imports nothing from `{d}`");
            (Code::UNUSED_DELAY_LOAD, text)
        })
        .collect();
    let groups: Vec<(&str, Vec<Import>)> = (by_dll.into_iter())
        .filter_map(|(dll, imports)| Some((dll?, imports)))
        .collect();
    let object = (!groups.is_empty()).then(|| Builder::new(machine).build(&groups));
    Ok(Delayed { object, warnings })
}

fn global(name: &str, section: NativeSymSection, value: u64, kind: u8) -> NativeSymbol {
    NativeSymbol {
        name: name.to_string(),
        section,
        value,
        size: 0,
        binding: 1,
        kind,
        visibility: 0,
        input_section: None,
    }
}

/// `user32.dll` as `user32_dll`, the spelling link.exe gives its names.
fn mangled(dll: &str) -> String {
    let keep = |c: char| if c.is_ascii_alphanumeric() { c } else { '_' };
    dll.chars()
        .map(keep)
        .collect::<String>()
        .to_ascii_lowercase()
}

/// x86-64 `__tailMerge`: the argument registers saved,
/// `__delayLoadHelper2(descriptor, rax)`, then a jump to its result.
const X64_TAIL_MERGE: &[u8] = &[
    0x48, 0x89, 0x4c, 0x24, 0x08, 0x48, 0x89, 0x54, 0x24, 0x10, 0x4c, 0x89, 0x44, 0x24, 0x18, 0x4c,
    0x89, 0x4c, 0x24, 0x20, 0x48, 0x83, 0xec, 0x68, 0x66, 0x0f, 0x7f, 0x44, 0x24, 0x20, 0x66, 0x0f,
    0x7f, 0x4c, 0x24, 0x30, 0x66, 0x0f, 0x7f, 0x54, 0x24, 0x40, 0x66, 0x0f, 0x7f, 0x5c, 0x24, 0x50,
    0x48, 0x8b, 0xd0, 0x48, 0x8d, 0x0d, 0, 0, 0, 0, 0xe8, 0, 0, 0, 0, 0x66, 0x0f, 0x6f, 0x44, 0x24,
    0x20, 0x66, 0x0f, 0x6f, 0x4c, 0x24, 0x30, 0x66, 0x0f, 0x6f, 0x54, 0x24, 0x40, 0x66, 0x0f, 0x6f,
    0x5c, 0x24, 0x50, 0x48, 0x8b, 0x4c, 0x24, 0x70, 0x48, 0x8b, 0x54, 0x24, 0x78, 0x4c, 0x8b, 0x84,
    0x24, 0x80, 0, 0, 0, 0x4c, 0x8b, 0x8c, 0x24, 0x88, 0, 0, 0, 0x48, 0x83, 0xc4, 0x68, 0xff, 0xe0,
];
/// The descriptor's and the helper's fields, the end of `sub rsp, 0x68`.
const X64_DESCRIPTOR_AT: usize = 0x36;
const X64_HELPER_AT: usize = 0x3b;
const X64_PROLOGUE: u32 = 0x18;
const X64_FRAME: u32 = 0x68;

/// arm64 `__tailMerge`: x0-x8 and q0-q7 saved,
/// `__delayLoadHelper2(descriptor, x17)`, then a branch to its result.
const A64_TAIL_MERGE: &[u32] = &[
    0xa9b27bfd, 0x910003fd, 0xa90107e0, 0xa9020fe2, 0xa90317e4, 0xa9041fe6, 0xf9002be8, 0xad0307e0,
    0xad040fe2, 0xad0517e4, 0xad061fe6, 0xaa1103e1, 0x90000000, 0x91000000, 0x94000000, 0xaa0003f0,
    0xad461fe6, 0xad4517e4, 0xad440fe2, 0xad4307e0, 0xf9402be8, 0xa9441fe6, 0xa94317e4, 0xa9420fe2,
    0xa94107e0, 0xa8ce7bfd, 0xd61f0200,
];
/// The descriptor's `adrp`, the `bl`, and `ldp x29, x30, [sp], #0xe0`.
const A64_DESCRIPTOR_AT: usize = 0x30;
const A64_HELPER_AT: usize = 0x38;
const A64_EPILOGUE_AT: u32 = 0x64;
const A64_FRAME: u32 = 0xe0;

struct Builder {
    o: NativeObject,
    /// The section symbol of each family the relocations name.
    sections: Vec<(NativeSymSection, usize)>,
}

impl Builder {
    fn new(machine: NativeMachine) -> Self {
        let mut o = NativeObject::empty(machine);
        o.source = String::from("delay-load imports");
        o.rodata_align = 2;
        o.relro_align = 8;
        o.data_align = 8;
        o.bss_align = 8;
        Builder {
            o,
            sections: Vec::new(),
        }
    }

    fn x64(&self) -> bool {
        self.o.machine == NativeMachine::X86_64
    }

    fn symbol(&mut self, s: NativeSymbol) -> usize {
        self.o.symbols.push(s);
        self.o.symbols.len() - 1
    }

    fn local(&mut self, name: String, section: NativeSymSection, value: u64, kind: u8) -> usize {
        self.symbol(NativeSymbol {
            name,
            binding: 0,
            ..global("", section, value, kind)
        })
    }

    fn section(&mut self, section: NativeSymSection) -> usize {
        if let Some(&(_, at)) = self.sections.iter().find(|(s, _)| *s == section) {
            return at;
        }
        let at = self.local(String::new(), section, 0, STT_SECTION);
        self.sections.push((section, at));
        at
    }

    fn text_reloc(&mut self, offset: usize, sym_idx: usize, rtype: u32, addend: i64) {
        let r = NativeReloc {
            offset: offset as u64,
            sym_idx,
            rtype,
            addend,
        };
        self.o.text_relocs.push(r);
    }

    /// A 32-bit image-relative field at `offset` in the descriptor blob.
    fn rva(&mut self, offset: usize, section: NativeSymSection, addend: usize) {
        let sym_idx = self.section(section);
        self.o.relro_relocs.push(NativeReloc {
            offset: offset as u64,
            sym_idx,
            rtype: R_PE_ADDR32NB,
            addend: addend as i64,
        });
    }

    fn code(&mut self, words: &[u32]) {
        self.o
            .text
            .extend(words.iter().flat_map(|w| w.to_le_bytes()));
    }

    fn tail_merge(&mut self, at: usize, descriptor: usize, helper: usize) {
        let table = self.section(NativeSymSection::RelRo);
        let addend = descriptor as i64;
        if self.x64() {
            self.o.text.extend_from_slice(X64_TAIL_MERGE);
            self.text_reloc(at + X64_DESCRIPTOR_AT, table, R_X86_64_PC32, addend - 4);
            self.text_reloc(at + X64_HELPER_AT, helper, R_X86_64_PLT32, -4);
            let steps = vec![(X64_PROLOGUE, PrologueStep::Alloc(X64_FRAME))];
            (self.o.unwind).push((at as u64, UnwindSteps::X64 { leaf: false, steps }));
        } else {
            self.code(A64_TAIL_MERGE);
            let page = at + A64_DESCRIPTOR_AT;
            self.text_reloc(page, table, R_AARCH64_ADR_PREL_PG_HI21, addend);
            self.text_reloc(page + 4, table, R_AARCH64_ADD_ABS_LO12_NC, addend);
            self.text_reloc(at + A64_HELPER_AT, helper, R_AARCH64_CALL26, 0);
            let steps = vec![A64Step::SaveFpLrX(A64_FRAME), A64Step::SetFp];
            let exits = vec![A64Exit {
                at: A64_EPILOGUE_AT,
                steps: vec![A64Step::SaveFpLrX(A64_FRAME)],
            }];
            (self.o.unwind).push((at as u64, UnwindSteps::A64 { steps, exits }));
        }
    }

    /// `__imp_load_X`: the slot's address to the tail merge.
    fn load_thunk(&mut self, at: usize, slot: usize, tail_merge: usize) {
        if self.x64() {
            // lea rax, [slot]; jmp tail_merge
            (self.o.text).extend_from_slice(&[0x48, 0x8d, 0x05, 0, 0, 0, 0, 0xe9, 0, 0, 0, 0]);
            self.text_reloc(at + 3, slot, R_X86_64_PC32, -4);
            self.text_reloc(at + 8, tail_merge, R_X86_64_PLT32, -4);
        } else {
            // adrp x17, slot; add x17, x17, :lo12:slot; b tail_merge
            self.code(&[0x90000011, 0x91000231, 0x14000000]);
            self.text_reloc(at, slot, R_AARCH64_ADR_PREL_PG_HI21, 0);
            self.text_reloc(at + 4, slot, R_AARCH64_ADD_ABS_LO12_NC, 0);
            self.text_reloc(at + 8, tail_merge, R_AARCH64_JUMP26, 0);
        }
    }

    /// `X`: a jump through its slot.
    fn call_thunk(&mut self, at: usize, slot: usize) {
        if self.x64() {
            // jmp [slot]
            (self.o.text).extend_from_slice(&[0xff, 0x25, 0, 0, 0, 0]);
            self.text_reloc(at + 2, slot, R_X86_64_PC32, -4);
        } else {
            // adrp x16, slot; ldr x16, [x16, :lo12:slot]; br x16
            self.code(&[0x90000010, 0xf9400210, 0xd61f0200]);
            self.text_reloc(at, slot, R_AARCH64_ADR_PREL_PG_HI21, 0);
            self.text_reloc(at + 4, slot, R_AARCH64_LDST64_ABS_LO12_NC, 0);
        }
    }

    /// The descriptors, their null terminator and the name tables are
    /// relro, the names rodata, the slots data, the module handles bss.
    fn build(mut self, groups: &[(&str, Vec<Import>)]) -> NativeObject {
        let helper = self.symbol(global(HELPER, NativeSymSection::Undef, 0, STT_NOTYPE));
        let table_size = (groups.len() + 1) * DESCRIPTOR;
        self.o.relro = vec![0; table_size];
        self.symbol(NativeSymbol {
            size: table_size as u64,
            visibility: STV_HIDDEN,
            ..global(TABLE, NativeSymSection::RelRo, 0, STT_OBJECT)
        });
        let pad = if self.x64() { 0xcc } else { 0 };
        let abs64 = if self.x64() {
            R_X86_64_64
        } else {
            R_AARCH64_ABS64
        };
        for (j, (dll, imports)) in groups.iter().enumerate() {
            let descriptor = j * DESCRIPTOR;
            let name_at = self.o.rodata.len();
            self.o.rodata.extend(dll.bytes().chain([0]));
            self.o.relro[descriptor..descriptor + 4].copy_from_slice(&ATTR_RVA.to_le_bytes());
            self.rva(descriptor + 4, NativeSymSection::RoData, name_at);
            self.rva(descriptor + 8, NativeSymSection::Bss, j * 8);
            self.rva(descriptor + 12, NativeSymSection::Data, self.o.data.len());
            self.rva(descriptor + 16, NativeSymSection::RelRo, self.o.relro.len());
            self.o.bss_size += 8;
            self.o
                .text
                .resize(self.o.text.len().next_multiple_of(16), pad);
            let merge_at = self.o.text.len();
            let merge = format!("__tailMerge_{}", mangled(dll));
            let merge = self.local(merge, NativeSymSection::Text, merge_at as u64, STT_FUNC);
            self.tail_merge(merge_at, descriptor, helper);
            for imp in imports {
                let int_at = self.o.relro.len();
                self.o.relro.extend([0; 8]);
                match imp.ordinal {
                    Some(n) => {
                        let entry = ORDINAL_FLAG | u64::from(n);
                        self.o.relro[int_at..int_at + 8].copy_from_slice(&entry.to_le_bytes());
                    }
                    None => {
                        self.o
                            .rodata
                            .resize(self.o.rodata.len().next_multiple_of(2), 0);
                        let hint_at = self.o.rodata.len();
                        self.o.rodata.extend(imp.hint.to_le_bytes());
                        self.o.rodata.extend(imp.symbol.bytes().chain([0]));
                        self.rva(int_at, NativeSymSection::RoData, hint_at);
                    }
                }
                let slot_at = self.o.data.len() as u64;
                self.o.data.extend([0; 8]);
                let slot = format!("{PREFIX}{}", imp.name);
                let slot = self.symbol(NativeSymbol {
                    size: 8,
                    ..global(&slot, NativeSymSection::Data, slot_at, STT_OBJECT)
                });
                let load_at = self.o.text.len();
                let load = format!("__imp_load_{}", imp.name);
                let load = self.local(load, NativeSymSection::Text, load_at as u64, STT_FUNC);
                self.load_thunk(load_at, slot, merge);
                self.o.data_relocs.push(NativeReloc {
                    offset: slot_at,
                    sym_idx: load,
                    rtype: abs64,
                    addend: 0,
                });
                if imp.called {
                    let at = self.o.text.len() as u64;
                    self.symbol(global(imp.name, NativeSymSection::Text, at, STT_FUNC));
                    self.call_thunk(at as usize, slot);
                }
            }
            self.o.relro.extend([0; 8]);
            self.o.data.extend([0; 8]);
        }
        self.o
    }
}
