//! End-to-end tests: load a C source from `fixtures/c/`, compile, run, and
//! check the exit code. These exercise the whole pipeline.

use super::run_fixture;

#[test]
fn arithmetic() {
    assert_eq!(run_fixture("arithmetic.c"), 60);
}

#[test]
fn goto() {
    assert_eq!(run_fixture("goto.c"), 5);
}

#[test]
fn function_pointers() {
    // (10+20) * (10-5) = 150
    assert_eq!(run_fixture("function_pointers.c"), 150);
}

#[test]
fn switch_statement() {
    // a == 2 -> res = 20, falls through to case 3 -> res += 5 -> 25
    assert_eq!(run_fixture("switch_statement.c"), 25);
}

#[test]
fn switch_default_routing() {
    assert_eq!(run_fixture("switch_default_routing.c"), 100);
}

#[test]
fn control_flow() {
    assert_eq!(run_fixture("control_flow.c"), 1);
}

#[test]
fn do_while() {
    assert_eq!(run_fixture("do_while.c"), 5);
}

#[test]
fn break_continue() {
    // 1 + 3 = 4 (loop breaks at i==5, skips even values)
    assert_eq!(run_fixture("break_continue.c"), 4);
}

#[test]
fn for_loop() {
    assert_eq!(run_fixture("for_loop.c"), 10);
}

#[test]
fn recursion_factorial() {
    assert_eq!(run_fixture("recursion_factorial.c"), 120);
}

#[test]
fn pointers() {
    assert_eq!(run_fixture("pointers.c"), 200);
}

#[test]
fn nested_function_calls() {
    assert_eq!(run_fixture("nested_function_calls.c"), 100);
}

#[test]
fn printf_runs_to_completion() {
    assert_eq!(run_fixture("printf.c"), 0);
}

#[test]
fn memory_ops() {
    assert_eq!(run_fixture("memory_ops.c"), 0);
}

#[test]
fn file_io() {
    std::fs::write("test_dummy.txt", "1234567890").unwrap();
    let res = run_fixture("file_io.c");
    std::fs::remove_file("test_dummy.txt").unwrap();
    assert_eq!(res, 0);
}

#[test]
fn pointer_arithmetic_scaling() {
    // p+1 advances by sizeof(int)=8 bytes.
    assert_eq!(run_fixture("pointer_arithmetic_scaling.c"), 108);
}

#[test]
fn expression_precedence() {
    assert_eq!(run_fixture("expression_precedence.c"), 1);
}

#[test]
fn variable_shadowing() {
    // Inner block's `int i; i = 20;` doesn't leak.
    assert_eq!(run_fixture("variable_shadowing.c"), 10);
}

#[test]
fn pointer_arithmetic() {
    assert_eq!(run_fixture("pointer_arithmetic.c"), 3);
}

#[test]
fn memset_mcmp() {
    assert_eq!(run_fixture("memset_mcmp.c"), 42);
}

#[test]
fn memcpy_copies_bytes_between_allocations() {
    // memset src to 'A', memcpy into dst, return dst[0].
    assert_eq!(run_fixture("memcpy_basic.c"), 'A' as i64);
}

#[test]
fn shebang_line_is_skipped() {
    // A leading `#!/usr/bin/env badc` line lets a .c file be made
    // executable; the lexer absorbs it the same way it absorbs
    // `#include`. The fixture's `main` returns 7.
    assert_eq!(run_fixture("shebang.c"), 7);
}

#[test]
fn sizeof_handles_type_names() {
    // sizeof(int) / sizeof(char) / sizeof(<ptr>) all return the platform
    // word size (1 for char, 8 otherwise). Returns 0 on success.
    assert_eq!(run_fixture("sizeof_basic.c"), 0);
}

#[test]
fn sizeof_handles_expressions() {
    // sizeof(x), sizeof(*p) etc. -- the operand isn't evaluated.
    assert_eq!(run_fixture("sizeof_expr.c"), 0);
}

#[test]
fn sizeof_threads_through_malloc_write_and_return() {
    // sizeof(struct Packet) used in three positions in one program:
    // malloc size, write count, and the function's return value. Tests
    // that the same constant survives arithmetic and call-site
    // propagation. struct Packet has 3 x 8-byte fields -> 24.
    assert_eq!(run_fixture("sizeof_with_write.c"), 24);
}

#[test]
fn struct_basic_field_access() {
    // struct Point { int x; int y; }; allocate, set fields, read them.
    // Returns 3*3 + 4*4 = 25.
    assert_eq!(run_fixture("struct_basic.c"), 25);
}

#[test]
fn struct_self_referential_linked_list() {
    // struct Node { int v; struct Node *next; };
    // Build list of [4,3,2,1,0], sum via traversal -- expects 10.
    assert_eq!(run_fixture("struct_linked_list.c"), 10);
}

#[test]
fn global_initializer_int() {
    // `int answer = 42;` smoke test -- the c5 frontend writes
    // the initializer's bytes into `.data` at the symbol's
    // offset. Returns answer + sentinel = 141.
    assert_eq!(run_fixture("global_initializer_int.c"), 141);
}

#[test]
fn global_initializer_pointer() {
    // `int *p = &target;` exercises the address-of-global
    // relocation channel. The VM ignores the relocation entries
    // (it stores the target's data offset directly), so this
    // test catches frontend bugs; native parity tests catch
    // per-format relocation bugs.
    assert_eq!(run_fixture("global_initializer_pointer.c"), 0);
}

#[test]
fn static_linked_list() {
    // Static linked list: 3 nodes in `.data`, head pointer
    // initialized to `&node_a`. Walks the list via the
    // statically-relocated head pointer; the node `next`
    // pointers are wired up at runtime since c5 doesn't yet
    // have struct-field-initializer syntax.
    assert_eq!(run_fixture("static_linked_list.c"), 0);
}

#[test]
fn thread_local_initializer() {
    // `_Thread_local int counter = 7;` -- the VM doesn't
    // distinguish .tdata from .tbss (single-threaded), so
    // tls_data bytes are read directly. Returns 0 on
    // success.
    assert_eq!(run_fixture("thread_local_initializer.c"), 0);
}

#[test]
fn struct_sizeof_reports_aggregate_size() {
    // sizeof(struct Three) == 24, etc. Returns 0 on success.
    assert_eq!(run_fixture("struct_sizeof.c"), 0);
}

#[test]
fn adjacent_string_literals_concatenate() {
    // C concatenates `"abc" "def" "ghi"` into one string. The lexer used
    // to put a NUL between each part, breaking lookups past the first
    // segment -- which made original c4.c's keyword table truncate.
    assert_eq!(run_fixture("adjacent_strings.c"), 'f' as i64);
}

#[test]
fn predefined_constants_are_visible() {
    // PROT_*, O_*, STDIN_FILENO, NULL, EXIT_SUCCESS/FAILURE -- each is
    // an integer constant the lexer pre-binds before any user code is
    // parsed. Returns 0 if every comparison holds.
    assert_eq!(run_fixture("predefined_constants.c"), 0);
}

#[test]
fn c99_qualifiers_parse_as_no_ops() {
    // const, volatile, restrict, signed, unsigned, short, long, _Bool,
    // register, auto, inline -- recognised by the lexer and consumed at
    // every declaration position the parser visits. Returns 0 if every
    // shape parsed and ran.
    assert_eq!(run_fixture("c99_qualifiers.c"), 0);
}

#[test]
fn integer_literal_suffixes_are_consumed() {
    // u/U/l/L/ll/LL/ULL etc. on decimal and hex integer literals --
    // accepted by the lexer and the value preserved verbatim (c5 has a
    // single 64-bit int representation; the suffix is informational).
    // Returns 0 if every literal lands at the expected value.
    assert_eq!(run_fixture("integer_suffixes.c"), 0);
}

#[test]
fn original_c4_compiles_and_runs_hello() {
    // The canonical self-hosting test: Robert Swierczek's original c4.c
    // runs under badc, compiles hello.c, and runs the resulting program
    // -- which prints "Hello 123" then exits 0. We only check the exit
    // code; the printed output goes to the real stdout.
    let exit = super::run_fixture_with_args(
        "c4.c",
        ["c4.c", concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c")],
    );
    assert_eq!(exit, 0);
}

#[test]
fn quicksort() {
    assert_eq!(run_fixture("quicksort.c"), 0);
}

#[test]
fn linked_list() {
    assert_eq!(run_fixture("linked_list.c"), 10);
}

#[test]
fn binary_search_tree() {
    assert_eq!(run_fixture("binary_search_tree.c"), 0);
}

#[test]
fn bst_free() {
    assert_eq!(run_fixture("bst_free.c"), 0);
}

#[test]
fn double_pointers() {
    assert_eq!(run_fixture("double_pointers.c"), 0);
}
