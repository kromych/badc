//! Tests for the optional pointer-tracking mode.
//!
//! Tracking is opt-in via `Vm::with_pointer_tracking`. With it on, every
//! load/store into the heap region consults the allocations table and
//! turns dangling-pointer access into a `Runtime` error.

use super::try_run_fixture;

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
    // p[100] lands far past the 8-byte allocation — not inside any live
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
    // binary_search_tree.c never frees — every alloc stays live for the
    // whole run, so the access check should never see a freed entry.
    let result = try_run_fixture("binary_search_tree.c");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn memset_overrunning_allocation_is_caught() {
    // memset(p, 0, 100) where p is an 8-byte alloc — the block check sees
    // the run extends past the allocation and emits a single OOB error.
    expect_error_containing("memset_oob.c", "out-of-bounds");
}

#[test]
fn memcpy_with_oversized_source_is_caught() {
    // memcpy reads 100 bytes from an 8-byte src — flagged at the source
    // pointer before any bytes are copied.
    expect_error_containing("memcpy_oob_src.c", "out-of-bounds");
}

#[test]
fn memcpy_with_oversized_destination_is_caught() {
    // memcpy writes 100 bytes into an 8-byte dst — src is fine, dst trips
    // the block check.
    expect_error_containing("memcpy_oob_dst.c", "out-of-bounds");
}

// ---- Code/data segregation ----

#[test]
fn dereferencing_a_function_pointer_is_refused() {
    // *fp where fp = target. The function pointer carries the CODE_BASE
    // bias, so the load lands in the code segment and the access check
    // refuses it.
    expect_error_containing("code_as_data.c", "code is not data");
}

#[test]
fn calling_a_forged_code_pointer_is_refused() {
    // `fp = 42; fp(0);` — 42 isn't in the code address space, so Jsri's
    // decode rejects it instead of jumping to a garbage PC.
    expect_error_containing("forge_code_pointer.c", "non-code address");
}

// ---- mprotect ----

#[test]
fn mprotect_read_only_refuses_writes() {
    expect_error_containing("mprotect_blocks_write.c", "permission denied");
}

#[test]
fn mprotect_write_only_refuses_reads() {
    expect_error_containing("mprotect_blocks_read.c", "permission denied");
}

#[test]
fn mprotect_read_only_still_allows_reads() {
    use super::try_run_fixture;
    // After mprotect(PROT_READ), the existing data is still readable —
    // the program returns 'X' (88).
    assert_eq!(
        try_run_fixture("mprotect_allows_read.c").unwrap(),
        'X' as i64
    );
}
