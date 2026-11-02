//! Tests for the optional pointer-tracking mode.
//!
//! Tracking is opt-in via `Vm::with_pointer_tracking`. With it on, every
//! load/store into the heap region consults the allocations table and
//! turns dangling-pointer access into a `Runtime` error.

use super::{compile_str, run_str, try_run_fixture};
use crate::Vm;

fn expect_error_containing(name: &str, needle: &str) {
    match try_run_fixture(name) {
        Err(e) => {
            let msg = e.to_string();
            assert!(
                msg.contains(needle),
                "expected error containing {:?}, got {:?}",
                needle,
                msg,
            );
        }
        Ok(code) => panic!(
            "expected error containing {:?}, but program exited with {}",
            needle, code
        ),
    }
}

#[test]
fn use_after_free_is_caught() {
    expect_error_containing("use_after_free.c", "use-after-free");
}

#[test]
fn double_free_is_caught() {
    expect_error_containing("double_free.c", "double free");
}

#[test]
fn heap_oob_read_is_caught() {
    // p[100] lands far past the 8-byte allocation -- not inside any live
    // allocation, so the access check rejects it.
    expect_error_containing("oob_read.c", "out-of-bounds");
}

#[test]
fn correct_allocate_then_free_is_silent() {
    // bst_free.c builds a small tree, then frees every node post-order
    // and returns 0. No use-after-free; tracking should not trip.
    let result = try_run_fixture("bst_free.c");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn long_lived_allocations_are_silent() {
    // binary_search_tree.c never frees -- every alloc stays live for the
    // whole run, so the access check should never see a freed entry.
    let result = try_run_fixture("binary_search_tree.c");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn memset_overrunning_allocation_is_caught() {
    // memset(p, 0, 100) where p is an 8-byte alloc -- the block check sees
    // the run extends past the allocation and emits a single OOB error.
    expect_error_containing("memset_oob.c", "out-of-bounds");
}

#[test]
fn memcpy_with_oversized_source_is_caught() {
    // memcpy reads 100 bytes from an 8-byte src -- flagged at the source
    // pointer before any bytes are copied.
    expect_error_containing("memcpy_oob_src.c", "out-of-bounds");
}

#[test]
fn memcpy_with_oversized_destination_is_caught() {
    // memcpy writes 100 bytes into an 8-byte dst -- src is fine, dst trips
    // the block check.
    expect_error_containing("memcpy_oob_dst.c", "out-of-bounds");
}

// ---- Code/data segregation ----

fn expect_either(name: &str, a: &str, b: &str) {
    match super::try_run_fixture(name) {
        Err(e) => {
            let msg = e.to_string();
            assert!(
                msg.contains(a) || msg.contains(b),
                "expected error containing {:?} or {:?}, got {:?}",
                a,
                b,
                msg,
            );
        }
        Ok(code) => panic!(
            "expected error containing {:?} / {:?}, but program exited with {}",
            a, b, code
        ),
    }
}

#[test]
fn dereferencing_a_function_pointer_is_refused() {
    // *fp where fp = target. The function pointer carries the CODE_BASE
    // bias, so the load lands in the code segment and the access check
    // refuses it.
    expect_either(
        "code_as_data.c",
        "code is not data",
        "is not a data pointer",
    );
}

#[test]
fn calling_a_forged_code_pointer_is_refused() {
    // `fp = 42; fp(0);` -- 42 isn't in the code address space, so Jsri's
    // decode rejects it instead of jumping to a garbage PC.
    expect_either(
        "forge_code_pointer.c",
        "non-code address",
        "is not a code pointer",
    );
}

#[test]
fn negative_size_argument_is_caught() {
    // memset(p, 0, -1) used to walk the address space (and accidentally
    // trip the code-segment guard). With the new size validation it
    // surfaces a clear "negative size" error at the intrinsic boundary.
    expect_error_containing("negative_size_memset.c", "negative size");
}

// ---- Allocation functions ----

/// C99 7.20.3: space that cannot be allocated is a null pointer, with
/// `errno` set to ENOMEM as the C libraries set it, and a failed `realloc`
/// leaves the old object as it was. The guest memory stops at 4 GiB, so
/// the terabyte `calloc` a native C library grants lazily is refused too.
#[test]
fn an_allocation_the_interpreter_cannot_hold_is_a_null_pointer() {
    let src = "#include <errno.h>\n\
        int main(void) {\n\
            errno = 0;\n\
            if (malloc((size_t)-1 / 2) || errno != ENOMEM) return 1;\n\
            errno = 0;\n\
            if (malloc((size_t)-1) || errno != ENOMEM) return 2;\n\
            errno = 0;\n\
            if (calloc((size_t)-1 / 2, 4) || errno != ENOMEM) return 3;\n\
            errno = 0;\n\
            if (calloc(1, (size_t)1 << 40) || errno != ENOMEM) return 4;\n\
            unsigned char *q = calloc(4, 4);\n\
            if (!q) return 5;\n\
            for (int i = 0; i < 16; i++) if (q[i]) return 6;\n\
            memcpy(q, \"keep\", 5);\n\
            errno = 0;\n\
            if (realloc(q, (size_t)-1 / 2) || errno != ENOMEM) return 7;\n\
            if (memcmp(q, \"keep\", 5)) return 8;\n\
            unsigned char *r = realloc(q, 64);\n\
            if (!r || memcmp(r, \"keep\", 5)) return 9;\n\
            unsigned char *s = realloc(0, 8);\n\
            void *z1 = malloc(0), *z2 = malloc(0);\n\
            if (!s || (z1 && z1 == z2)) return 10;\n\
            if (read(-1, r, (size_t)-1 / 2) != -1) return 11;\n\
            free(r); free(s); free(z1); free(z2);\n\
            return 0;\n\
        }\n";
    assert_eq!(run_str(src), 0);
}

#[test]
fn a_fill_or_resize_past_the_interpreters_memory_is_a_runtime_error() {
    // The size is checked against the memory before anything is built for
    // it; an unknown pointer is as `free` reports it.
    for (body, needle) in [
        (
            "char *p = malloc(8); memset(p, 0, (size_t)-1 / 2);",
            "past memory len",
        ),
        ("char c; realloc(&c, 8);", "realloc of unknown pointer"),
    ] {
        let src = format!("int main(void) {{ {body} return 0; }}\n");
        let err = Vm::new(compile_str(&src)).run().expect_err(body);
        assert!(err.to_string().contains(needle), "{body}: {err}");
    }
}
