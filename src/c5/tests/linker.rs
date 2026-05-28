//! Cross-translation-unit linker tests.
//!
//! Each test compiles two or more inline sources to
//! [`crate::c5::LinkUnit`]s, runs them through
//! [`crate::c5::link_units`], and asserts on the resulting
//! [`crate::c5::Program`] -- usually by running it under the VM.

use super::TEST_PRELUDE;
use crate::c5::{Compiler, LinkUnit, Vm, link_units};

fn compile_unit(src: &str) -> LinkUnit {
    Compiler::new(format!("{TEST_PRELUDE}{src}"))
        .compile_to_link_unit()
        .unwrap()
}

fn compile_unit_bare(src: &str) -> LinkUnit {
    Compiler::new(src.to_string())
        .compile_to_link_unit()
        .unwrap()
}

fn link_and_run(units: Vec<LinkUnit>) -> i64 {
    let program = link_units(units).expect("link_units failed");
    Vm::new(program).run().expect("VM run failed")
}

#[test]
fn extern_function_call_across_two_units() {
    // TU A defines `add`; TU B has `extern int add(int, int);`
    // and calls it from `main`.
    let a = compile_unit("int add(int a, int b) { return a + b; }");
    let b = compile_unit(
        "
        extern int add(int a, int b);
        int main() { return add(40, 2); }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 42);
}

#[test]
fn extern_call_resolves_to_function_at_unit_local_pc_zero() {
    // C99 6.9 + linker concat: a defining function whose
    // unit-local `Symbol::val` is 0 (the first function in the
    // TU) must still be the canonical target for cross-unit
    // forward decls. The rebase loop in `linker::link::merge`
    // gates on the parser's `defined_here` flag rather than
    // `val > 0`; without that the forward-decl resolver only
    // saw later-defined siblings and the extern call dispatched
    // to whichever function landed at the merged text's PC 0.
    //
    // TU `a` defines two functions in declaration order:
    // `first` (lands at unit-local PC 0) and `second`. TU `b`
    // forward-declares both and calls them; the answer
    // distinguishes `first` from `second`.
    let a = compile_unit(
        "
        int first(int n) { return n + 10; }
        int second(int n) { return n + 200; }
        ",
    );
    let b = compile_unit(
        "
        extern int first(int);
        extern int second(int);
        int main() { return first(1) + second(2); }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 213);
}

#[test]
fn extern_global_read_and_write_across_units() {
    // TU A defines `counter`; TU B has `extern int counter;`
    // and reads / writes it through `main`.
    let a = compile_unit("int counter = 5;");
    let b = compile_unit(
        "
        extern int counter;
        int main() { counter = counter + 7; return counter; }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 12);
}

#[test]
fn extern_global_array_indexed_across_units() {
    // C99 6.7.1: `extern T x[N];` declares an array whose
    // storage lives in another TU. The parser allocates a
    // tentative local slot so single-TU `Compiler::compile()`
    // stays permissive; `compile_to_link_unit` re-classifies
    // the symbol as `Undefined` and clears `val` so the
    // walker emits `Inst::ImmData(0)` plus an
    // `extern_imm_data_refs` entry. The linker resolves the
    // slot from the defining TU's data segment. Pre-fix the
    // walker read the dummy parser offset and emitted
    // `Inst::ImmData(<dummy>)` with no extern_*_refs entry,
    // so the merged image dereferenced data near the .bss
    // start instead of the canonical array. Reproduced as
    // -4 (`BZ_DATA_ERROR`) on bzip2's reference-stream
    // scenario when crctable.c was its own translation unit.
    let a = compile_unit(
        "
        int table[4] = { 11, 22, 33, 44 };
        ",
    );
    let b = compile_unit(
        "
        extern int table[4];
        int main() { return table[0] + table[1] + table[2] + table[3]; }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 110);
}

#[test]
fn struct_value_assignment_after_multi_tu_dedupe() {
    // The linker dedupes per-unit `structs` tables by name when
    // building `merged_structs`, so a unit's local struct id can
    // drift relative to its position in the merged list. Without
    // a per-unit struct-id remap on AST snapshots, the walker's
    // `struct_size(ty)` indexes the wrong merged entry and emits
    // `Inst::Mcpy` with the wrong byte count.
    //
    // TU A defines a few unrelated named structs ahead of the one
    // both TUs care about; TU B then declares the same shared
    // struct as TU A and exercises a struct-value assignment that
    // requires the full byte count to copy correctly. The
    // assertion checks every field landed in the destination so
    // a truncated Mcpy would surface as a non-zero return.
    let a = compile_unit(
        "
        struct unrelated_a { int x, y; };
        struct unrelated_b { int a, b, c; };
        struct shared { int p; int q; int r; int s; int t; int u; };
        int build(struct shared *out) {
            out->p = 1; out->q = 2; out->r = 3;
            out->s = 4; out->t = 5; out->u = 6;
            return 0;
        }
        ",
    );
    let b = compile_unit(
        "
        struct shared { int p; int q; int r; int s; int t; int u; };
        extern int build(struct shared *out);
        int main() {
            struct shared a;
            struct shared b;
            build(&a);
            b = a;
            return b.p + b.q + b.r + b.s + b.t + b.u;
        }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 21);
}

#[test]
fn static_function_is_not_exported_cross_tu() {
    // TU A has a `static` helper -- internal linkage.
    // TU B has its own `helper` with the same name -- legal
    // because static keeps the name file-scoped.
    let a = compile_unit(
        "
        static int helper(int n) { return n + 100; }
        int call_a() { return helper(1); }
        ",
    );
    let b = compile_unit(
        "
        static int helper(int n) { return n + 200; }
        int call_b() { return helper(2); }
        extern int call_a();
        int main() { return call_a() + call_b(); }
        ",
    );
    // call_a uses A's static helper: 1 + 100 = 101.
    // call_b uses B's static helper: 2 + 200 = 202.
    // Sum = 303.
    assert_eq!(link_and_run(alloc::vec![b, a]), 303);
}

#[test]
fn transitively_dead_static_chain_is_dropped_from_object() {
    // A static helper `a` that calls another static `b`. Nothing
    // in the TU references `a`, so `a`, `b`, and everything else
    // reachable only from `a` should drop. The parser's lexical
    // `was_referenced` flag would keep `b` alive (its callee
    // reference is set when `a`'s body is parsed); the codegen's
    // transitive reachability pass over `Inst::Call` /
    // `Inst::ImmCode` recovers the dead status.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int dead_leaf(int x) { return x + 1; }\n\
         static int dead_caller(int x) { return dead_leaf(x) * 2; }\n\
         int main(void) { return 0; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_leaf = bytes.windows(9).any(|w| w == b"dead_leaf");
    let has_caller = bytes.windows(11).any(|w| w == b"dead_caller");
    assert!(!has_leaf, "transitively-dead leaf must drop");
    assert!(!has_caller, "lexically-dead caller must drop");
}

#[test]
fn address_taken_static_survives_dce() {
    // A static function whose address is stored in a global
    // function-pointer table must survive DCE: the table entry
    // becomes a `program.code_relocs` root. Mirrors the vtable
    // pattern (`static const VTable v = { .fp = doubled };`).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int doubled(int n) { return n + n; }\n\
         typedef int (*fp_t)(int);\n\
         const fp_t vtable[] = { doubled };\n\
         int main(void) { return vtable[0](21); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_doubled = bytes.windows(7).any(|w| w == b"doubled");
    assert!(
        has_doubled,
        "address-taken static must survive DCE via code_relocs root"
    );
}

#[test]
fn unreferenced_static_function_is_dropped_from_object() {
    // C99 6.2.2p3: a file-scope `static` function has internal
    // linkage and is reachable only from the current TU. The
    // parser already emits a `warn_unused_static_functions`
    // diagnostic when no in-TU call site references it; the
    // codegen also drops the body so the resulting object
    // doesn't carry dead code. Verifies the
    // `function_is_unreachable_static` gate in `walk_program`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         static int unused_helper(int x) {{ return x * 2; }}\n\
         static int used_helper(int x) {{ return x + 1; }}\n\
         int main(void) {{ return used_helper(41); }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    // Walk for the function names by byte-substring lookup; the
    // strtab carries them as NUL-terminated entries among the
    // section header / symbol-table bytes.
    let has_used = bytes.windows(11).any(|w| w == b"used_helper");
    let has_unused = bytes.windows(13).any(|w| w == b"unused_helper");
    assert!(
        has_used,
        "reachable static helper must survive into the object"
    );
    assert!(
        !has_unused,
        "unreachable static helper must not appear in the object"
    );
}

#[test]
fn thread_local_storage_round_trips_through_et_rel() {
    // `_Thread_local` storage now rides the native ET_REL object:
    // elf_reloc emits `.tdata` (initialised slice) + `.tbss`
    // (zero-fill remainder), and `parse_native_elf` concatenates
    // them back into `tls_data` / `tls_bss_size`. Verifies the
    // bytes survive the write -> parse round-trip; the link-time
    // PT_TLS layout is guarded separately until it lands.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        !program.tls_data.is_empty(),
        "source declares `_Thread_local`, so tls_data must be non-empty"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(6).any(|w| w == b".tdata"),
        "ET_REL must carry a `.tdata` section header name"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let total = obj.tls_data.len() + obj.tls_bss_size;
    assert_eq!(
        total,
        program.tls_data.len(),
        "round-tripped TLS size (tdata + tbss) must match the source's tls_data",
    );
    // `counter = 7` is a 4-byte initialised int; its little-endian
    // image leads the `.tdata` bytes.
    assert!(
        obj.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS byte image must round-trip; got {:?}",
        obj.tls_data,
    );
}

#[test]
fn thread_local_storage_links_into_pt_tls_executable() {
    // A single `_Thread_local`-bearing object links through the
    // native path into an executable with a PT_TLS segment. The
    // local-exec tpoff baked into `.text` stays valid because the
    // merged TLS block keeps the source's size: `link_native_objects`
    // carries the single unit's `tls_data` / `tls_init_size` forward
    // and `write_native_image_from_merged` lays out PT_TLS from them.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.tls_init_size, program.tls_init_size,
        "merged tls_init_size must match the source's"
    );
    assert_eq!(
        merged.tls_data.len(),
        program.tls_data.len(),
        "merged tls_data length must match the source's total TLS size"
    );
    assert!(
        merged.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS image must survive the merge"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxX64,
    )
    .expect("write executable");
    // ELF64: e_phoff @ 0x20 (u64), e_phentsize @ 0x36 (u16),
    // e_phnum @ 0x38 (u16). Scan the program header table for a
    // PT_TLS (p_type == 7) whose p_filesz covers the 4-byte int.
    let phoff = u64::from_le_bytes(exe[0x20..0x28].try_into().unwrap()) as usize;
    let phentsize = u16::from_le_bytes(exe[0x36..0x38].try_into().unwrap()) as usize;
    let phnum = u16::from_le_bytes(exe[0x38..0x3a].try_into().unwrap()) as usize;
    const PT_TLS: u32 = 7;
    let pt_tls = (0..phnum).find_map(|i| {
        let base = phoff + i * phentsize;
        let p_type = u32::from_le_bytes(exe[base..base + 4].try_into().unwrap());
        if p_type == PT_TLS {
            // p_filesz @ +0x20, p_memsz @ +0x28 within the phdr.
            let p_filesz = u64::from_le_bytes(exe[base + 0x20..base + 0x28].try_into().unwrap());
            let p_memsz = u64::from_le_bytes(exe[base + 0x28..base + 0x30].try_into().unwrap());
            Some((p_filesz, p_memsz))
        } else {
            None
        }
    });
    let (p_filesz, p_memsz) = pt_tls.expect("executable must carry a PT_TLS segment");
    assert_eq!(
        p_filesz, program.tls_init_size as u64,
        "PT_TLS p_filesz must equal the initialised TLS image size"
    );
    assert_eq!(
        p_memsz,
        program.tls_data.len() as u64,
        "PT_TLS p_memsz must cover the full per-thread TLS block"
    );
}

#[test]
fn pragma_export_round_trips_into_shared_library() {
    // `#pragma export(<name>)` rides the ET_REL `.note.badc`
    // NT_BADC_EXPORTS record: `parse_native_elf` recovers the name,
    // `link_native_objects` unions it, and the shared-library writer
    // promotes only the exported name. A symbol not named by the
    // pragma stays private.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         #pragma export(exported_fn)\n\
         int exported_fn(int x) {{ return x + 1; }}\n\
         int internal_fn(int x) {{ return x + 2; }}\n\
         int main(void) {{ return exported_fn(1) + internal_fn(1); }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        program.exports.iter().any(|e| e.name == "exported_fn"),
        "compiler must record the `#pragma export` name"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.exports.contains(&"exported_fn".to_string()),
        "export name must round-trip through the `.note.badc` record"
    );
    assert!(
        !obj.exports.contains(&"internal_fn".to_string()),
        "a symbol not named by `#pragma export` must not appear in the note"
    );
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.exports,
        alloc::vec!["exported_fn".to_string()],
        "linker unions only the exported names"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
    )
    .expect("write shared library");
    // e_type @ 0x10: ET_DYN (3) for a shared object.
    assert_eq!(
        u16::from_le_bytes(so[0x10..0x12].try_into().unwrap()),
        3,
        "shared library must be ET_DYN"
    );
}

#[test]
fn unresolved_external_function_errors_cleanly() {
    // TU references `foo` but no unit defines it.
    let only = compile_unit_bare(
        "
        extern int foo(int);
        int main() { return foo(7); }
        ",
    );
    let result = link_units(alloc::vec![only]);
    let err = result.expect_err("link should fail with undefined reference");
    let msg = format!("{}", err);
    assert!(
        msg.contains("undefined reference") && msg.contains("foo"),
        "unexpected error message: {msg}"
    );
    // The message MUST NOT carry the `internal compiler error:`
    // marker -- undefined externs are a user-level link error,
    // not a c5 bug. Regression for the polish item that split
    // `link_err` away from `err()` in the linker.
    assert!(
        !msg.contains("internal compiler error"),
        "undefined-reference diagnostic must not be tagged as ICE: {msg}"
    );
}

#[test]
fn duplicate_function_definition_across_units_is_rejected() {
    // Two TUs that each define `foo` should hard-fail at link
    // time. Pre-fix, the second definition silently shadowed the
    // first and the produced binary used whichever copy the
    // linker iterated to last.
    let a = compile_unit("int foo(void) { return 1; }");
    let b = compile_unit(
        "
        int foo(void) { return 2; }
        int main() { return foo(); }
        ",
    );
    let result = link_units(alloc::vec![a, b]);
    let err = result.expect_err("link should fail with duplicate definition");
    let msg = format!("{}", err);
    assert!(
        msg.contains("multiple definition") && msg.contains("foo"),
        "unexpected error message: {msg}"
    );
    assert!(
        !msg.contains("internal compiler error"),
        "duplicate-definition diagnostic must not be tagged as ICE: {msg}"
    );
}

#[test]
fn user_ssa_funcs_threaded_through_link_with_pc_rebase() {
    use crate::c5::link_units;
    // Two TUs with locally-defined functions only. The merge
    // rebases each unit's user_ssa_funcs by the unit's
    // text_base; the resulting program.user_ssa_funcs covers
    // every user function with merged-PC ent_pc / end_pc.
    let a = compile_unit(
        "
        int add(int a, int b) { return a + b; }
        int twice(int x) { return add(x, x); }
        ",
    );
    let b = compile_unit(
        "
        extern int twice(int x);
        int main(void) { return twice(11); }
        ",
    );
    let a_user_count = a.user_ssa_funcs.len();
    let b_user_count = b.user_ssa_funcs.len();
    assert!(a_user_count >= 2, "a should have add + twice");
    assert!(b_user_count >= 1, "b should have main");
    let program = link_units(alloc::vec![a, b]).expect("link_units failed");
    assert_eq!(
        program.user_ssa_funcs.len(),
        a_user_count + b_user_count,
        "every per-unit user fn should appear in the merged list",
    );
    // Every merged ent_pc is unique and bounds a non-empty
    // `[ent_pc, end_pc)` range. The linker rebases per-unit
    // ent_pcs by `text_base[i]`, so two units' functions cannot
    // share an ent_pc after the shift; a wrongly-rebased entry
    // would collide with a sibling's range or wrap to PC 0.
    let mut seen: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    for f in &program.user_ssa_funcs {
        assert!(
            seen.insert(f.ent_pc),
            "merged ent_pc {} appears twice across user_ssa_funcs",
            f.ent_pc,
        );
        assert!(
            f.ent_pc < f.end_pc,
            "merged ent_pc {} >= end_pc {}",
            f.ent_pc,
            f.end_pc,
        );
    }
}

#[test]
fn user_ssa_funcs_call_target_pc_resolves_for_cross_tu_extern() {
    use crate::c5::link_units;
    // Across-TU call: TU B's main calls TU A's add. At
    // compile_to_link_unit time, B's user_ssa_funcs entry for
    // main carries an Inst::Call with target_pc == 0 (B doesn't
    // know A's PC yet). `resolve_extern_refs` patches the slot
    // through the walker-recorded `extern_call_refs` channel
    // against the merged symbol table.
    let a = compile_unit("int add(int a, int b) { return a + b; }");
    let b = compile_unit(
        "
        extern int add(int a, int b);
        int main(void) { return add(40, 2); }
        ",
    );

    // Pre-link state: B emits one `Inst::Call` for the
    // forward-declared `add`. Its `target_pc` is whatever the
    // walker stamped from `live_fun_val(add)` -- the extern's
    // tentative `Symbol::val` if any, 0 when the parser has no
    // placeholder. Either way, an `extern_call_refs` entry was
    // recorded so the resolver can rewrite the slot post-merge.
    let mut pre_call_count = 0usize;
    for f in &b.user_ssa_funcs {
        for inst in &f.insts {
            if matches!(inst, crate::c5::ir::Inst::Call { .. }) {
                pre_call_count += 1;
            }
        }
    }
    assert!(
        pre_call_count >= 1,
        "expected at least one Inst::Call pre-link in B",
    );

    let program = link_units(alloc::vec![b, a]).expect("link_units failed");

    // Post-link sanity: B's `main` carries a single
    // `Inst::Call` whose `target_pc` matches the merged
    // `ent_pc` of A's `add`. Locate both functions by name
    // through the merged `finished_functions` and compare.
    let add_ent = program
        .finished_functions
        .iter()
        .find(|f| f.name == "add")
        .map(|f| f.ent_pc)
        .expect("merged finished_functions must include `add`");
    let main_ent = program
        .finished_functions
        .iter()
        .find(|f| f.name == "main")
        .map(|f| f.ent_pc)
        .expect("merged finished_functions must include `main`");
    let main_ssa = program
        .user_ssa_funcs
        .iter()
        .find(|f| f.ent_pc == main_ent)
        .expect("main's FunctionSsa must be in user_ssa_funcs");
    let main_call_targets: alloc::vec::Vec<usize> = main_ssa
        .insts
        .iter()
        .filter_map(|i| {
            if let crate::c5::ir::Inst::Call { target_pc, .. } = i {
                Some(*target_pc)
            } else {
                None
            }
        })
        .collect();
    assert_eq!(
        main_call_targets,
        alloc::vec![add_ent],
        "main's single Inst::Call should resolve to add's merged ent_pc",
    );

    // End-to-end: the program runs and returns 42, requiring
    // the cross-TU call to dispatch correctly.
    assert_eq!(Vm::new(program).run().expect("VM run failed"), 42);
}

#[test]
fn extern_global_int_pointer_initializer_resolves_across_units() {
    // Cross-TU `int *p = &x;` initializer: TU A defines `x`,
    // TU B declares `extern int x;` plus a static initializer
    // for a pointer pointing at it.
    let a = compile_unit("int x = 99;");
    let b = compile_unit(
        "
        extern int x;
        int *p = &x;
        int main() { return *p; }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a]), 99);
}

#[test]
fn cross_tu_call_through_secondary_dylib() {
    // Regression marker for the binding flat-index shift the
    // two-pass merge in `link.rs::merge` exists to prevent.
    //
    // The parser encodes each `Inst::CallExt`'s `binding_idx` as
    // `sum(prior dylibs' sizes) + within-dylib position`. With
    // two units that share the first dylib (libc) and one of
    // them also references a binding past that prefix (sitting
    // in a separate dylib), a single-pass merge would append
    // unit 2's libc bindings AFTER computing unit 1's remap --
    // silently shifting where the secondary dylib starts and
    // leaving unit 1's secondary-binding reference resolving to
    // a random libc import. The resulting binary SIGSEGV'd on
    // Linux ELF / Windows PE and got "lucky" on macOS Mach-O
    // (the wrong-index lookup happened to land on a benign
    // libc import for the specific demo shapes).
    //
    // Build two units with custom dylib tables that mimic the
    // header surface (libc has multiple bindings; libutil has
    // a single binding that unit 1 calls). Run the link and
    // assert the merged Program's binding index still names the
    // libutil binding after merging.
    use crate::c5::{Binding, DylibSpec, LinkSymbol, Linkage, SymbolKind};

    let mk_binding = |local: &str, real: &str| Binding {
        is_variadic: false,
        fixed_args: 0,
        return_type_tag: 0,
        returns_long_double: false,
        param_types: Vec::new(),
        local_name: local.to_string(),
        real_symbol: real.to_string(),
    };

    // Unit 1: declares libc {printf, malloc} + libutil {do_work},
    // body of `lib_call` calls binding flat-index 2, which under
    // the parser's scheme names libutil's `do_work`
    // (sum(libc.bindings)=2, plus position 0 within libutil).
    let lib_synthetic = crate::c5::ir::FunctionSsa {
        name: alloc::string::String::new(),
        ent_pc: 0,
        end_pc: 5,
        locals: 0,
        n_params: 0,
        is_variadic: false,
        insts: alloc::vec![crate::c5::ir::Inst::CallExt {
            binding_idx: 2,
            args: alloc::vec::Vec::new(),
            fp_arg_mask: 0,
        }],
        inst_src: alloc::vec![(0u32, 0u32)],
        blocks: alloc::vec![crate::c5::ir::Block {
            start_pc: 0,
            inst_range: 0..1,
            terminator: crate::c5::ir::Terminator::Return(crate::c5::ir::NO_VALUE),
            exit_acc: crate::c5::ir::NO_VALUE,
        }],
        extern_call_refs: alloc::vec::Vec::new(),
        extern_imm_code_refs: alloc::vec::Vec::new(),
        extern_imm_data_refs: alloc::vec::Vec::new(),
        extern_tls_refs: alloc::vec::Vec::new(),
    };
    let lib_unit = LinkUnit {
        dylibs: alloc::vec![
            DylibSpec {
                name: "libc".to_string(),
                path: "libc.so.6".to_string(),
                bindings: alloc::vec![
                    mk_binding("printf", "printf"),
                    mk_binding("malloc", "malloc"),
                ],
            },
            DylibSpec {
                name: "libutil".to_string(),
                path: "libutil.so.1".to_string(),
                bindings: alloc::vec![mk_binding("do_work", "do_work")],
            },
        ],
        symbols: alloc::vec![LinkSymbol {
            name: "lib_call".to_string(),
            linkage: Linkage::External,
            kind: SymbolKind::Function,
            value: 0,
            size: 0,
            type_tag: 0,
        }],
        synthetic_ssa_funcs: alloc::vec![lib_synthetic],
        ..Default::default()
    };

    // Unit 2: only references libc (two new bindings). If the
    // merge appends these to the merged libc *before* unit 1's
    // operand resolution, the flat index 2 now lands inside
    // libc -- not libutil.
    let other_unit = LinkUnit {
        dylibs: alloc::vec![DylibSpec {
            name: "libc".to_string(),
            path: "libc.so.6".to_string(),
            bindings: alloc::vec![mk_binding("printf", "printf"), mk_binding("fputs", "fputs"),],
        }],
        symbols: alloc::vec![LinkSymbol {
            name: "main".to_string(),
            linkage: Linkage::External,
            kind: SymbolKind::Function,
            value: 0,
            size: 0,
            type_tag: 0,
        }],
        ..Default::default()
    };

    let program = link_units(alloc::vec![other_unit, lib_unit]).expect("link_units failed");

    // Walk the merged synthetic_ssa_funcs for Inst::CallExt and
    // confirm each binding_idx resolves to libutil::do_work in
    // the merged dylib table -- not whatever libc binding the
    // buggy merge would have shifted it to.
    let mut found = false;
    for f in &program.synthetic_ssa_funcs {
        for inst in &f.insts {
            let crate::c5::ir::Inst::CallExt { binding_idx, .. } = inst else {
                continue;
            };
            let mut cursor = *binding_idx as usize;
            let mut resolved: Option<&str> = None;
            for d in program.dylibs.iter() {
                if cursor < d.bindings.len() {
                    resolved = Some(&d.bindings[cursor].real_symbol);
                    break;
                }
                cursor -= d.bindings.len();
            }
            assert_eq!(
                resolved,
                Some("do_work"),
                "merged CallExt binding_idx {} resolved to {:?}, not do_work; \
                 the binding flat-index shift hazard is back",
                binding_idx,
                resolved,
            );
            found = true;
        }
    }
    assert!(found, "expected to find a CallExt in the merged SSA");
}
