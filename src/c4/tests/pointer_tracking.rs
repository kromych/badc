//! Tests for the optional pointer-tracking mode.
//!
//! Tracking is opt-in via `Vm::with_pointer_tracking`. With it on, every
//! load/store into the heap region consults the allocations table and
//! turns dangling-pointer access into a `Runtime` error.

use super::run_fixture_tracked;

fn expect_error_containing(name: &str, needle: &str) {
    match run_fixture_tracked(name) {
        Err(e) => {
            let msg = e.to_string();
            assert!(
                msg.contains(needle),
                "expected error containing {:?}, got {:?}",
                needle,
                msg,
            );
        }
        Ok(code) => panic!("expected error containing {:?}, but program exited with {}", needle, code),
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
    let result = run_fixture_tracked("bst_free.c");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn long_lived_allocations_are_silent() {
    // binary_search_tree.c never frees — every alloc stays live for the
    // whole run, so the access check should never see a freed entry.
    let result = run_fixture_tracked("binary_search_tree.c");
    assert_eq!(result.unwrap(), 0);
}
