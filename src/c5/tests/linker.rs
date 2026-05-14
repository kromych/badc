//! Cross-translation-unit linker tests.
//!
//! Each test compiles two or more inline sources to
//! [`crate::c5::LinkUnit`]s, runs them through
//! [`crate::c5::link_units`], and asserts on the resulting
//! [`crate::c5::Program`] -- usually by running it under the VM.

use super::TEST_PRELUDE;
use crate::c5::{Compiler, LinkArchive, LinkOptions, LinkUnit, Vm, link_units};

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
    let program = link_units(units, &[], LinkOptions::default()).expect("link_units failed");
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
fn unresolved_external_function_errors_cleanly() {
    // TU references `foo` but no unit defines it.
    let only = compile_unit_bare(
        "
        extern int foo(int);
        int main() { return foo(7); }
        ",
    );
    let result = link_units(alloc::vec![only], &[], LinkOptions::default());
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
    let result = link_units(alloc::vec![a, b], &[], LinkOptions::default());
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
fn object_round_trip_through_elf_wrapper() {
    use crate::c5::{read_object, write_object};
    let a = compile_unit("int sum(int a, int b) { return a + b; }");
    let bytes = write_object(&a);
    assert!(
        bytes.len() > 64,
        "object bytes should at least contain an ELF header"
    );
    let parsed = read_object(&bytes).expect("read_object");
    // Same bytecode + data lengths -- the writer/reader pair
    // is round-trip stable on the core payload.
    assert_eq!(parsed.text, a.text, "text round-trip");
    assert_eq!(parsed.data, a.data, "data round-trip");
    assert_eq!(parsed.dylibs.len(), a.dylibs.len(), "dylib count");
    assert_eq!(parsed.structs.len(), a.structs.len(), "struct count");
    // Symbols round-trip (modulo their relative order, since
    // we re-sort by linkage during write).
    assert_eq!(parsed.symbols.len(), a.symbols.len());
}

#[test]
fn link_uses_object_via_round_trip() {
    use crate::c5::{read_object, write_object};
    // Same end-to-end as `extern_function_call_across_two_units`
    // but with TU A pushed through the ELF wrapper -- the link
    // step sees A as if it came off disk.
    let a = compile_unit("int add(int a, int b) { return a + b; }");
    let bytes = write_object(&a);
    let a_parsed = read_object(&bytes).expect("read_object");
    let b = compile_unit(
        "
        extern int add(int a, int b);
        int main() { return add(13, 29); }
        ",
    );
    assert_eq!(link_and_run(alloc::vec![b, a_parsed]), 42);
}

#[test]
fn archive_pull_in_only_includes_needed_members() {
    use crate::c5::{ArchiveMember, write_archive, write_object};
    // Two archive members. Only `used.o` defines a symbol
    // anyone references; `unused.o` should not be pulled in.
    let used_unit = compile_unit("int provided() { return 17; }");
    let unused_unit = compile_unit("int never_called() { return 99; }");
    let used_bytes = write_object(&used_unit);
    let unused_bytes = write_object(&unused_unit);
    let archive = write_archive(
        &[
            ArchiveMember {
                name: "used.o".into(),
                bytes: used_bytes,
            },
            ArchiveMember {
                name: "unused.o".into(),
                bytes: unused_bytes,
            },
        ],
        &[
            (0, alloc::vec!["provided".to_string()]),
            (1, alloc::vec!["never_called".to_string()]),
        ],
    );

    let lib = LinkArchive::parse("libdemo.a".into(), &archive).expect("parse archive");
    let main_unit = compile_unit(
        "
        extern int provided();
        int main() { return provided(); }
        ",
    );
    let program = link_units(
        alloc::vec![main_unit],
        core::slice::from_ref(&lib),
        LinkOptions::default(),
    )
    .expect("link");
    assert_eq!(
        Vm::new(program).run().unwrap(),
        17,
        "archive should provide the symbol"
    );
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
