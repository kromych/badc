//! `-fpatchable-function-entry` and `-pg` object shapes, contrasted with
//! gcc 16.2.1 (Fedora 44) on the same source: the NOP areas and their
//! `__patchable_function_entries` records, the `__fentry__` / `mcount`
//! calls and the `__mcount_loc` table.

use crate::c5::linker::relocatable::{
    EtRel, EtSection, EtSym, EtSymRef, RelinkOptions, link_relocatable, parse_et_rel,
};
use crate::c5::{
    CompileOptions, Compiler, Hardening, NativeOptions, OutputKind, PatchableEntry, Profiling,
    Target, emit_native_with_options,
};

const SRC: &str = "int counter;\n\
                   int one(void) { return 1; }\n\
                   int two(int x) { return x + counter; }\n\
                   __attribute__((section(\".noinstr.text\"))) int three(void) { return 3; }\n\
                   __attribute__((no_instrument_function)) int four(void) { return 4; }\n\
                   __attribute__((patchable_function_entry(2,1))) int five(void) { return 5; }\n\
                   __attribute__((patchable_function_entry(0))) int eight(void) { return 8; }\n";

const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_LINK_ORDER: u64 = 0x80;
const R_X86_64_64: u32 = 1;
const R_X86_64_PLT32: u32 = 4;
const R_AARCH64_ABS64: u32 = 257;
const STT_SECTION: u8 = 3;
const STT_FUNC: u8 = 2;
const X86_NOP: u8 = 0x90;
const A64_NOP: [u8; 4] = 0xd503_201fu32.to_le_bytes();

fn compile(src: &str, target: Target, opts: NativeOptions) -> EtRel {
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile: {e}"));
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..opts
    };
    let bytes = emit_native_with_options(&program, target, opts).expect("emit");
    parse_et_rel(&bytes, "unit").expect("parse")
}

fn func<'a>(rel: &'a EtRel, name: &str) -> &'a EtSym {
    rel.symbols
        .iter()
        .find(|s| s.name == name && s.kind == STT_FUNC)
        .unwrap_or_else(|| panic!("no function symbol `{name}`"))
}

fn section_of(sym: &EtSym) -> usize {
    match sym.sec {
        EtSymRef::Section(i) => i,
        other => panic!("`{}` is not section-defined: {other:?}", sym.name),
    }
}

fn section<'a>(rel: &'a EtRel, name: &str) -> &'a EtSection {
    rel.sections
        .iter()
        .find(|s| s.name == name)
        .unwrap_or_else(|| panic!("no section `{name}`"))
}

/// The section a relocation's symbol is a section symbol of.
fn reloc_section(rel: &EtRel, sym: u32) -> usize {
    let s = &rel.symbols[sym as usize];
    assert_eq!(
        s.kind, STT_SECTION,
        "relocation against a non-section symbol"
    );
    section_of(s)
}

/// `(section, offset)` of every `__patchable_function_entries` record.
/// A compiled object holds one record per section; a relocatable merge
/// folds them into one section, as `ld -r` does.
fn patchable_records(rel: &EtRel, rtype: u32) -> Vec<(usize, u64)> {
    let mut out = Vec::new();
    for (i, s) in rel.sections.iter().enumerate() {
        if s.name != "__patchable_function_entries" {
            continue;
        }
        assert_eq!(
            s.flags,
            SHF_WRITE | SHF_ALLOC | SHF_LINK_ORDER,
            "flags of section {i}"
        );
        assert_eq!(s.addralign, 8);
        assert_eq!(s.entsize, 0);
        assert_eq!(s.bytes.len(), 8 * s.relocs.len(), "zero-filled slots");
        assert!(s.bytes.iter().all(|&b| b == 0));
        for (k, r) in s.relocs.iter().enumerate() {
            assert_eq!((r.offset, r.rtype), ((8 * k) as u64, rtype));
            let text = reloc_section(rel, r.sym);
            if s.relocs.len() == 1 {
                assert_eq!(
                    s.link_target,
                    Some(text),
                    "sh_link names the function's text section"
                );
            } else {
                assert!(s.link_target.is_some());
            }
            out.push((text, r.addend as u64));
        }
    }
    out
}

/// The NOP area start recorded for `name`, if any: the nearest record
/// at or ahead of the symbol with no other function between them.
fn area_of(rel: &EtRel, records: &[(usize, u64)], name: &str) -> Option<u64> {
    let f = func(rel, name);
    let sec = section_of(f);
    let area = records
        .iter()
        .filter(|&&(s, off)| s == sec && off <= f.value)
        .map(|&(_, off)| off)
        .max()?;
    let taken = rel.symbols.iter().any(|s| {
        s.kind == STT_FUNC
            && s.sec == EtSymRef::Section(sec)
            && area <= s.value
            && s.value < f.value
    });
    (!taken).then_some(area)
}

/// `(section, offset)` of every `__mcount_loc` entry.
fn mcount_entries(rel: &EtRel) -> Vec<(usize, u64)> {
    let s = section(rel, "__mcount_loc");
    assert_eq!(s.flags, SHF_ALLOC, "gcc emits `__mcount_loc` as \"a\"");
    assert_eq!(s.addralign, 1);
    assert_eq!(s.entsize, 0);
    assert!(s.bytes.iter().all(|&b| b == 0));
    assert_eq!(s.bytes.len(), s.relocs.len() * 8);
    let mut out = Vec::new();
    for (i, r) in s.relocs.iter().enumerate() {
        assert_eq!((r.offset, r.rtype), ((i * 8) as u64, R_X86_64_64));
        out.push((reloc_section(rel, r.sym), r.addend as u64));
    }
    out
}

fn mcount_entry(rel: &EtRel, entries: &[(usize, u64)], name: &str) -> Option<u64> {
    let f = func(rel, name);
    let sec = section_of(f);
    entries
        .iter()
        .find(|&&(s, off)| s == sec && off >= f.value && off < f.value + f.size)
        .map(|&(_, off)| off)
}

fn plt32_call_at(rel: &EtRel, f: &EtSym, off: u64, callee: &str) {
    let sec = &rel.sections[section_of(f)];
    let at = off as usize;
    assert_eq!(
        &sec.bytes[at..at + 5],
        &[0xe8, 0, 0, 0, 0],
        "`call rel32` at {off:#x}"
    );
    let r = sec
        .relocs
        .iter()
        .find(|r| r.offset == off + 1)
        .unwrap_or_else(|| panic!("no relocation on the call at {off:#x}"));
    assert_eq!(r.rtype, R_X86_64_PLT32);
    assert_eq!(r.addend, -4);
    assert_eq!(rel.symbols[r.sym as usize].name, callee);
    assert_eq!(rel.symbols[r.sym as usize].sec, EtSymRef::Undef);
}

fn kernel_x86_64_options() -> NativeOptions {
    NativeOptions {
        patchable_function_entry: PatchableEntry {
            nops: 16,
            before: 16,
        },
        profiling: Profiling {
            enabled: true,
            fentry: true,
            record_mcount: true,
            nop_mcount: false,
        },
        min_function_alignment: 16,
        ..NativeOptions::default()
    }
}

#[test]
fn x86_64_call_padding_form_matches_gcc() {
    // gcc -O2 -fpatchable-function-entry=16,16 -pg -mfentry -mrecord-mcount
    // -fmin-function-alignment=16: `one` at 0x10 behind 16 NOPs, 11 bytes
    // (`call __fentry__; mov $1, %eax; ret`), its record at `.text + 0`
    // and its `__mcount_loc` entry at the call; `four` keeps the area and
    // the record, no call and no entry; `five` (2,1) sits at an aligned
    // address plus one with the call at +1; `eight` (0) has no record;
    // `three` records against `.noinstr.text`.
    let rel = compile(SRC, Target::LinuxX64, kernel_x86_64_options());
    let text = section(&rel, ".text");
    assert_eq!(text.addralign, 16);
    let records = patchable_records(&rel, R_X86_64_64);
    let entries = mcount_entries(&rel);
    assert_eq!(records.len(), 5, "one, two, three, four, five");
    assert_eq!(entries.len(), 5, "one, two, three, five, eight");

    for name in ["one", "two", "four"] {
        let f = func(&rel, name);
        let area = area_of(&rel, &records, name).expect(name);
        assert_eq!(area % 16, 0, "`{name}`: the area takes the alignment");
        assert_eq!(f.value, area + 16, "`{name}`: 16 NOPs ahead of the symbol");
        let sec = &rel.sections[section_of(f)];
        assert!(
            sec.bytes[area as usize..f.value as usize]
                .iter()
                .all(|&b| b == X86_NOP)
        );
    }
    let one = func(&rel, "one");
    plt32_call_at(&rel, one, one.value, "__fentry__");
    assert_eq!(one.size, 11, "`call`, `mov $1, %eax`, `ret`");
    assert_eq!(mcount_entry(&rel, &entries, "one"), Some(one.value));

    let four = func(&rel, "four");
    assert_eq!(four.size, 6, "no_instrument_function: `mov $4, %eax; ret`");
    assert_eq!(text.bytes[four.value as usize], 0xb8);
    assert_eq!(mcount_entry(&rel, &entries, "four"), None);

    let five = func(&rel, "five");
    let area = area_of(&rel, &records, "five").expect("five");
    assert_eq!(area % 16, 0);
    assert_eq!(five.value, area + 1);
    assert_eq!(text.bytes[area as usize], X86_NOP);
    assert_eq!(text.bytes[five.value as usize], X86_NOP);
    plt32_call_at(&rel, five, five.value + 1, "__fentry__");
    assert_eq!(five.size, 12, "the NOP after the symbol counts");
    assert_eq!(mcount_entry(&rel, &entries, "five"), Some(five.value + 1));

    let eight = func(&rel, "eight");
    assert_eq!(area_of(&rel, &records, "eight"), None);
    assert_eq!(eight.value % 16, 0);
    plt32_call_at(&rel, eight, eight.value, "__fentry__");
    assert_eq!(mcount_entry(&rel, &entries, "eight"), Some(eight.value));

    let three = func(&rel, "three");
    let noinstr = rel
        .sections
        .iter()
        .position(|s| s.name == ".noinstr.text")
        .expect(".noinstr.text");
    assert_eq!(section_of(three), noinstr);
    assert_eq!(rel.sections[noinstr].addralign, 16);
    assert_eq!(area_of(&rel, &records, "three"), Some(0));
    assert_eq!(three.value, 16);
    plt32_call_at(&rel, three, 16, "__fentry__");
    assert_eq!(mcount_entry(&rel, &entries, "three"), Some(16));
}

#[test]
fn an_area_without_nops_ahead_of_the_symbol_starts_at_it() {
    // gcc -fpatchable-function-entry=16: `one` at the area's first byte,
    // 22 bytes (16 NOPs, `mov`, `ret`), recorded at `.text + 0`.
    let rel = compile(
        SRC,
        Target::LinuxX64,
        NativeOptions {
            patchable_function_entry: PatchableEntry {
                nops: 16,
                before: 0,
            },
            ..NativeOptions::default()
        },
    );
    let records = patchable_records(&rel, R_X86_64_64);
    let one = func(&rel, "one");
    assert_eq!(area_of(&rel, &records, "one"), Some(one.value));
    assert_eq!(one.size, 22);
    let text = section(&rel, ".text");
    let at = one.value as usize;
    assert!(text.bytes[at..at + 16].iter().all(|&b| b == X86_NOP));
    assert_eq!(text.bytes[at + 16], 0xb8);
}

#[test]
fn aarch64_call_ops_form_matches_gcc() {
    // gcc -fpatchable-function-entry=4,2 -fmin-function-alignment=8: two
    // NOPs at an 8-byte aligned address (the literal slot), the symbol,
    // two more NOPs, then the body; `one` is 16 bytes. `five` (2,1) has
    // one NOP on each side.
    let rel = compile(
        SRC,
        Target::LinuxAarch64,
        NativeOptions {
            patchable_function_entry: PatchableEntry { nops: 4, before: 2 },
            min_function_alignment: 8,
            ..NativeOptions::default()
        },
    );
    assert!(section(&rel, ".text").addralign >= 8);
    let records = patchable_records(&rel, R_AARCH64_ABS64);
    assert_eq!(records.len(), 5);
    for name in ["one", "two", "three", "four"] {
        let f = func(&rel, name);
        let area = area_of(&rel, &records, name).expect(name);
        assert_eq!(area % 8, 0, "`{name}`: the literal slot is 8-byte aligned");
        assert_eq!(f.value, area + 8);
        let sec = &rel.sections[section_of(f)];
        let a = area as usize;
        assert!(
            sec.bytes[a..a + 16].chunks(4).all(|w| w == A64_NOP),
            "`{name}`: four NOPs"
        );
        assert_ne!(
            &sec.bytes[a + 16..a + 20],
            &A64_NOP,
            "`{name}`: the body follows"
        );
    }
    assert_eq!(func(&rel, "one").size, 16);
    let five = func(&rel, "five");
    let area = area_of(&rel, &records, "five").expect("five");
    assert_eq!(five.value, area + 4);
    assert_eq!(five.size, 12);
    assert_eq!(area_of(&rel, &records, "eight"), None);
    assert!(!rel.sections.iter().any(|s| s.name == "__mcount_loc"));
}

/// A callee that keeps its frame, so it takes the `PACIASP`/`AUTIASP`
/// pair, plus a second function so the section holds more than one
/// record.
const PROT_SRC: &str = "extern void sink(int);\n\
                        extern int use(int *);\n\
                        int framed(int x) { int a = x; sink(a); return use(&a) + a; }\n\
                        int leaf(int x) { return x + 1; }\n";

const A64_BTI_C: [u8; 4] = 0xd503_245fu32.to_le_bytes();
const A64_PACIASP: [u8; 4] = 0xd503_233fu32.to_le_bytes();

/// The words a function's entry opens with, `count` of them.
fn entry_words(rel: &EtRel, name: &str, count: usize) -> Vec<[u8; 4]> {
    let f = func(rel, name);
    let at = f.value as usize;
    rel.sections[section_of(f)].bytes[at..at + 4 * count]
        .chunks(4)
        .map(|w| w.try_into().unwrap())
        .collect()
}

fn aarch64_protected(patchable: PatchableEntry, bti: bool, pac_ret: bool) -> EtRel {
    compile(
        PROT_SRC,
        Target::LinuxAarch64,
        NativeOptions {
            patchable_function_entry: patchable,
            min_function_alignment: 8,
            hardening: Hardening {
                bti,
                pac_ret,
                ..Hardening::NONE
            },
            ..NativeOptions::default()
        },
    )
}

#[test]
fn aarch64_signing_follows_the_nops() {
    // gcc -mbranch-protection=pac-ret -fpatchable-function-entry=4,2:
    // the two NOPs open the entry and `PACIASP` follows them. The
    // kernel's `ftrace_init_nop` rewrites the first of the two to
    // `MOV X9, X30` and the second to a call, so it requires a NOP at
    // the symbol; a signature taken ahead of the pair would be taken
    // on a link register the call then overwrites.
    let rel = aarch64_protected(PatchableEntry { nops: 4, before: 2 }, false, true);
    assert_eq!(
        entry_words(&rel, "framed", 3),
        [A64_NOP, A64_NOP, A64_PACIASP],
        "signed entry"
    );
    // Without signing the NOPs still open the entry and the prologue
    // follows them directly.
    let plain = aarch64_protected(PatchableEntry { nops: 4, before: 2 }, false, false);
    let opens = entry_words(&plain, "framed", 3);
    assert_eq!(opens[..2], [A64_NOP, A64_NOP]);
    assert_ne!(opens[2], A64_PACIASP);

    // The record names the area's first byte, `arch/arm64/kernel/ftrace.c`
    // reads the ops literal from the two words there and patches at
    // `record + 8` and `record + 12`. Both must be NOPs at rest.
    let records = patchable_records(&rel, R_AARCH64_ABS64);
    let area = area_of(&rel, &records, "framed").expect("framed");
    let f = func(&rel, "framed");
    assert_eq!(f.value, area + 8);
    assert_eq!(area % 8, 0);
    let sec = &rel.sections[section_of(f)];
    let a = area as usize;
    assert!(sec.bytes[a..a + 16].chunks(4).all(|w| w == A64_NOP));
}

#[test]
fn aarch64_a_signed_entry_with_a_nop_area_takes_its_own_landing_pad() {
    // gcc -mbranch-protection=pac-ret+bti -fpatchable-function-entry=4,2:
    // `BTI C`, the NOPs, then `PACIASP`. `PACIASP` stands in for the pad
    // only where it is the entry's first instruction; the NOP area moves
    // it, and the kernel tolerates nothing but a `BTI C` ahead of the
    // patch site (`ftrace_call_adjust`).
    let rel = aarch64_protected(PatchableEntry { nops: 4, before: 2 }, true, true);
    assert_eq!(
        entry_words(&rel, "framed", 4),
        [A64_BTI_C, A64_NOP, A64_NOP, A64_PACIASP],
        "pad, area, signature"
    );
    // Unsigned, the pad still leads and nothing stands between the NOPs
    // and the prologue.
    let pad_only = aarch64_protected(PatchableEntry { nops: 4, before: 2 }, true, false);
    let opens = entry_words(&pad_only, "framed", 4);
    assert_eq!(opens[..3], [A64_BTI_C, A64_NOP, A64_NOP]);
    assert_ne!(opens[3], A64_PACIASP);

    // With no area `PACIASP` opens the entry and is the pad itself.
    let bare = aarch64_protected(PatchableEntry::NONE, true, true);
    assert_eq!(entry_words(&bare, "framed", 1), [A64_PACIASP]);
    let unsigned = aarch64_protected(PatchableEntry::NONE, true, false);
    assert_eq!(entry_words(&unsigned, "framed", 1), [A64_BTI_C]);
}

#[test]
fn the_area_takes_the_function_alignment_on_both_targets() {
    for (target, nop) in [(Target::LinuxX64, 1usize), (Target::LinuxAarch64, 4)] {
        let rel = compile(
            SRC,
            target,
            NativeOptions {
                patchable_function_entry: PatchableEntry { nops: 2, before: 1 },
                min_function_alignment: 32,
                ..NativeOptions::default()
            },
        );
        let rtype = match target {
            Target::LinuxX64 => R_X86_64_64,
            _ => R_AARCH64_ABS64,
        };
        let records = patchable_records(&rel, rtype);
        for name in ["one", "two", "three", "four"] {
            let f = func(&rel, name);
            let area = area_of(&rel, &records, name).expect(name);
            assert_eq!(area % 32, 0, "{target:?} `{name}`");
            assert_eq!(f.value, area + nop as u64, "{target:?} `{name}`");
        }
        let eight = func(&rel, "eight");
        assert_eq!(
            eight.value % 32,
            0,
            "{target:?}: no area, the symbol is aligned"
        );
    }
}

#[test]
fn mcount_form_calls_after_the_prologue() {
    // gcc -pg -mno-fentry -mrecord-mcount: `one` is `push %rbp; mov
    // %rsp, %rbp; call mcount; mov $1, %eax; pop %rbp; ret`, 16 bytes,
    // with the `__mcount_loc` entry at the call. The frame is forced on
    // a leaf: `mcount` reads the return address through rbp.
    let rel = compile(
        SRC,
        Target::LinuxX64,
        NativeOptions {
            profiling: Profiling {
                enabled: true,
                fentry: false,
                record_mcount: true,
                nop_mcount: false,
            },
            ..NativeOptions::default()
        },
    );
    let one = func(&rel, "one");
    let text = section(&rel, ".text");
    let at = one.value as usize;
    assert_eq!(
        &text.bytes[at..at + 16],
        &[
            0x55, 0x48, 0x89, 0xe5, 0xe8, 0, 0, 0, 0, 0xb8, 1, 0, 0, 0, 0x5d, 0xc3
        ]
    );
    assert_eq!(one.size, 16);
    plt32_call_at(&rel, one, one.value + 4, "mcount");
    let entries = mcount_entries(&rel);
    assert_eq!(mcount_entry(&rel, &entries, "one"), Some(one.value + 4));
    assert_eq!(mcount_entry(&rel, &entries, "four"), None);
    assert!(!rel.symbols.iter().any(|s| s.name == "__fentry__"));
}

#[test]
fn nop_mcount_puts_a_nop_of_the_calls_width_in_its_place() {
    // gcc -pg -mfentry -mnop-mcount -mrecord-mcount: `nopl 0x0(%rax,%rax,1)`
    // at the entry, recorded, and no `__fentry__` reference.
    let rel = compile(
        SRC,
        Target::LinuxX64,
        NativeOptions {
            profiling: Profiling {
                enabled: true,
                fentry: true,
                record_mcount: true,
                nop_mcount: true,
            },
            ..NativeOptions::default()
        },
    );
    let one = func(&rel, "one");
    let text = section(&rel, ".text");
    let at = one.value as usize;
    assert_eq!(&text.bytes[at..at + 5], &[0x0f, 0x1f, 0x44, 0x00, 0x00]);
    assert!(text.relocs.iter().all(|r| r.offset != one.value + 1));
    let entries = mcount_entries(&rel);
    assert_eq!(mcount_entry(&rel, &entries, "one"), Some(one.value));
    assert!(!rel.symbols.iter().any(|s| s.name == "__fentry__"));
}

#[test]
fn the_landing_pad_leads_the_nops_and_the_call() {
    // gcc -fcf-protection=branch -fpatchable-function-entry=3,1 -pg
    // -mfentry: `endbr64` at the symbol, the two NOPs, then the call,
    // which is what `__mcount_loc` records.
    let rel = compile(
        SRC,
        Target::LinuxX64,
        NativeOptions {
            patchable_function_entry: PatchableEntry { nops: 3, before: 1 },
            profiling: Profiling {
                enabled: true,
                fentry: true,
                record_mcount: true,
                nop_mcount: false,
            },
            hardening: Hardening {
                cf_protection_branch: true,
                ..Hardening::NONE
            },
            ..NativeOptions::default()
        },
    );
    let one = func(&rel, "one");
    let text = section(&rel, ".text");
    let at = one.value as usize;
    assert_eq!(text.bytes[at - 1], X86_NOP);
    assert_eq!(
        &text.bytes[at..at + 6],
        &[0xf3, 0x0f, 0x1e, 0xfa, X86_NOP, X86_NOP]
    );
    plt32_call_at(&rel, one, one.value + 6, "__fentry__");
    let entries = mcount_entries(&rel);
    assert_eq!(mcount_entry(&rel, &entries, "one"), Some(one.value + 6));
}

#[test]
fn the_records_survive_a_relocatable_merge() {
    // The kernel's module link is `ld -r`, and its loader reads the
    // records from the one section of the name: both units' records
    // land there and the `__mcount_loc` entries in one table.
    let a = compile(SRC, Target::LinuxX64, kernel_x86_64_options());
    let b = compile(
        "int nine(void) { return 9; }\n",
        Target::LinuxX64,
        kernel_x86_64_options(),
    );
    let bytes = link_relocatable(&[a, b], &RelinkOptions::default()).expect("merge");
    let rel = parse_et_rel(&bytes, "merged").expect("parse");
    let records = patchable_records(&rel, R_X86_64_64);
    assert_eq!(records.len(), 6);
    let nine = func(&rel, "nine");
    assert_eq!(area_of(&rel, &records, "nine"), Some(nine.value - 16));
    let entries = mcount_entries(&rel);
    assert_eq!(entries.len(), 6);
    assert_eq!(mcount_entry(&rel, &entries, "nine"), Some(nine.value));
}

#[test]
fn an_attribute_area_narrower_than_its_offset_is_rejected() {
    let Err(err) = Compiler::with_options(
        "__attribute__((patchable_function_entry(1, 2))) int f(void) { return 0; }\n".to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile() else {
        panic!("M > N is an error, as in gcc");
    };
    assert!(
        err.to_string().contains("patchable_function_entry"),
        "{err}"
    );
}

#[test]
fn profiling_needs_a_relocatable_x86_64_object() {
    let program = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxAarch64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let pg = NativeOptions {
        profiling: Profiling {
            enabled: true,
            ..Profiling::OFF
        },
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let Err(err) = emit_native_with_options(&program, Target::LinuxAarch64, pg) else {
        panic!("aarch64 `-pg` is refused by name");
    };
    assert!(err.to_string().contains("-pg"), "{err}");

    let program = Compiler::with_options(
        SRC.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let Err(err) = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Executable,
            ..pg
        },
    ) else {
        panic!("an image has no relocation for the profiling call");
    };
    assert!(err.to_string().contains("relocatable"), "{err}");
}
