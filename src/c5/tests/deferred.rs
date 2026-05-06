//! Deferred-issue fixtures.
//!
//! Each test below pins a known-broken behavior in the dialect or
//! a known-broken interaction on a specific target lane. They're
//! all `#[ignore]`'d so a normal `cargo test` stays green; running
//! `cargo test -- --ignored` re-validates that the failure mode
//! still matches what the comment documents.
//!
//! When one of these starts passing, that's the signal to delete
//! the `#[ignore]` attribute, move the fixture into the regular
//! `JIT_FIXTURES` / `NATIVE_FIXTURES` lists, and close the
//! tracking task.
//!
//! The fixtures themselves live in `fixtures/c/deferred_*.c`. The
//! prefix makes them easy to grep for and skips the normal
//! fixture-parity tables (which only pick up unprefixed names).
//!
//! Gating: gated identically to `super::jit` so the fixtures load
//! into the in-process JIT on the platforms that support it. PE-
//! and Linux-ELF-specific deferred fixtures (`#47`, `#48`) are
//! checked in separate per-format harnesses below.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use crate::{Compiler, jit_run};

/// Compile a fixture and run it through the JIT, returning the
/// exit code. Panics on compile / load failure -- this helper is
/// only used inside `#[ignore]`'d tests so a panic counts as
/// "still broken in the documented way".
fn jit_fixture_exit(name: &str) -> i32 {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let program = Compiler::new(super::with_prelude(&src))
        .compile()
        .expect("compile failed");
    let argv = vec![name.to_string()];
    jit_run(&program, &argv).expect("jit_run failed")
}

// ---- Unsigned-arithmetic gaps from c99-gaps.md ----

#[test]
#[ignore = "deferred: unsigned arithmetic high-half not masked through registers"]
fn unsigned_arith_high_half_not_masked() {
    // Today this fixture exits 1 (the very first check fires)
    // because `~u` carries the sign-extended high half across
    // the comparison. Fix: mask the result of unsigned bitwise
    // / shift / arithmetic ops to the slot width before the
    // comparison observes it, or store-and-reload.
    let exit = jit_fixture_exit("deferred_unsigned_arith_high_half.c");
    assert_eq!(exit, 0, "fixture should exit 0 once the bug is fixed");
}

#[test]
#[ignore = "deferred: unsigned right shift uses arithmetic shift"]
fn unsigned_right_shift_is_arithmetic() {
    // `unsigned int x >> 1` lowers to `Op::Shr` which is
    // ARM64 ASR / x86_64 SAR -- arithmetic. Logical shift
    // requires a separate `Op::Shru`.
    let exit = jit_fixture_exit("deferred_unsigned_right_shift.c");
    assert_eq!(exit, 0, "fixture should exit 0 once the bug is fixed");
}

#[test]
#[ignore = "deferred: unsigned divide / modulo use signed ops"]
fn unsigned_divide_and_modulo_are_signed() {
    // `Op::Div` / `Op::Mod` lower to SDIV (ARM64) / IDIV
    // (x86_64). Unsigned operands with the high bit set come
    // out wrong (or fault on overflow). Fix: dedicated
    // `Op::Divu` / `Op::Modu` routed when either operand is
    // unsigned.
    let exit = jit_fixture_exit("deferred_unsigned_div_mod.c");
    assert_eq!(exit, 0, "fixture should exit 0 once the bug is fixed");
}

#[test]
#[ignore = "deferred: signed -> unsigned promotion in mixed expressions"]
fn mixed_signed_unsigned_no_promotion() {
    // C99 sec 6.3.1.8 promotes the signed operand to the unsigned
    // common type. Today the dialect picks the op based on the
    // operator (signed for arithmetic; mixed-sensitive for
    // compares) without converting.
    let exit = jit_fixture_exit("deferred_mixed_signed_unsigned.c");
    assert_eq!(exit, 0, "fixture should exit 0 once the bug is fixed");
}

// ---- Linux ELF TLS interaction (#47) ----
//
// The bug is Linux-ELF specific. macOS arm64's JIT doesn't
// support TLS at all (Mach-O __thread_data + dyld
// __tlv_bootstrap is future work) and would SIGSEGV the test
// runner on a `_Thread_local` access. Gate this test to Linux
// so it actually exercises the failure mode.
#[cfg(target_os = "linux")]
#[test]
#[ignore = "deferred (#47): Linux ELF TLS layout shifts when static-local state lands nearby"]
fn linux_elf_tls_layout_with_static_locals() {
    let exit = jit_fixture_exit("deferred_tls_with_static_locals.c");
    assert_eq!(
        exit, 0,
        "fixture should exit 0 once the layout bug is fixed"
    );
}

// ---- Optimizer regression on sqlite3 aggregates (#46) ----
//
// The current placeholder fixture exits 0 -- a minimal repro
// hasn't been bisected out of sqlite3 yet. The test panics under
// `--ignored` so the issue keeps surfacing in the deferred-test
// failure list until someone replaces the placeholder with a
// real bisected repro.
#[test]
#[ignore = "deferred (#46): optimizer SIGSEGVs on sqlite3 aggregate codegen; minimal repro not yet extracted"]
fn optimizer_aggregates_minimal_repro_pending() {
    // Once a real repro is in place this test should compile via
    // `jit_run_with_options(..., NativeOptions::new().with_optimize())`
    // and assert that the program exits cleanly. The current
    // panic keeps the deferred issue visible.
    let _ = jit_fixture_exit("deferred_optimizer_aggregates.c");
    panic!("(#46) placeholder fixture: bisect minimal repro from sqlite3 aggregate codegen");
}

// ---- size_t / ssize_t / time_t typedef widths (#52) ----
//
// `typedef int size_t;` etc. left over from before M31 made
// `int` 4 bytes wide. Each width typedef should be pointer-wide
// on 64-bit hosts; today they're 4 bytes and any libc bridge
// that takes one truncates inputs > 2^31. JIT lane reproduces
// this directly because `sizeof(size_t) == 4` is the broken
// state on every host.
#[test]
fn width_typedefs_are_pointer_wide() {
    // #52 fixed: `<stddef.h>`, `<sys/types.h>` and `<time.h>`
    // now alias the byte-counting typedefs to `long`, so
    // `sizeof(size_t)` etc. return 8 on 64-bit hosts. Test
    // stays around as a regression marker.
    let exit = jit_fixture_exit("deferred_width_typedefs.c");
    assert_eq!(
        exit, 0,
        "size_t / ssize_t / time_t should be pointer-wide on 64-bit hosts"
    );
}

// ---- Per-target long width (#51) ----
//
// On Windows (LLP64) `long` should be 4 bytes and `long long`
// 8; the dialect picks 8 for both and collapses `long long`
// onto Ty::Long. JIT runs only on LP64 hosts where
// `sizeof(long) == sizeof(long long) == 8` happens to match
// the platform ABI, so the bug doesn't surface here. The test
// panics under `--ignored` so the gap stays visible until
// per-target long-width plus a separate `Ty::LongLong` lands
// (and a Windows-target test rig can run the fixture against
// `__BADC_WINDOWS__`).
#[test]
#[ignore = "deferred (#51): long width -- Windows LLP64 vs Linux/macOS LP64; long/long long collapsed"]
fn long_width_per_target() {
    let _ = jit_fixture_exit("deferred_long_width.c");
    panic!("(#51) per-target long width unimplemented; Windows-side fixture run is pending");
}

// ---- PE/x64 struct fp-call (#50) ----
//
// Same reasoning as #51: the bug only fires on PE/x64. The
// fixture passes on JIT today; panic so the issue stays in
// the --ignored failure list.
#[test]
#[ignore = "deferred (#50): function-pointer call through struct field returns wrong on PE/x64"]
fn struct_fp_call_per_target() {
    let _ = jit_fixture_exit("deferred_struct_fp_call.c");
    panic!("(#50) PE/x64 struct fp-call repro pending; JIT lane passes the fixture in isolation");
}

// ---- libc data globals on Windows (stdin/stdout/stderr) ----
//
// `__c5_lazy_stream` in stdio.h has #ifdef arms for `__APPLE__`
// (dlsym `__stdoutp`) and `__linux__` (dlsym `stdout`), but no
// arm for Windows. Windows doesn't expose those as data
// symbols at all -- programs go through `__acrt_iob_func(int)`
// to get a `FILE *`. With no Windows arm, the lazy resolver
// returns NULL and the first `fprintf(stdout, ...)` after that
// reaches msvcrt with an invalid handle.
//
// JIT lane (macOS / Linux) resolves the data export via dlsym
// today and the fixture exits 0; the test panics under
// `--ignored` so the Windows-only failure stays surfaced.
#[test]
#[ignore = "deferred: libc data globals (stdin/stdout/stderr) need a Windows arm in __c5_lazy_stream"]
fn libc_data_globals_windows() {
    let _ = jit_fixture_exit("deferred_libc_data_globals_windows.c");
    panic!("libc data globals: Windows arm of __c5_lazy_stream pending; macOS / Linux lanes pass");
}

// ---- Address-of-libc-fn in static initializer ----
//
// Static-init paths emit `Imm 0` plus a runtime-patch warning
// when the right-hand side names a libc symbol. sqlite3's
// UnixOSData VFS dispatch table relies on a runtime callback
// to fill the slots; any code path that reads one of those
// slots before the runtime patch fires sees a NULL function
// pointer. Affects every target -- the right fix is a
// GOT/IAT-trampoline pipeline that resolves at load time.
#[test]
#[ignore = "deferred: address-of-libc-fn in static initializer lowered as 0; needs GOT/IAT trampoline"]
fn libc_address_in_static_init() {
    let exit = jit_fixture_exit("deferred_libc_address_in_static_init.c");
    assert_eq!(
        exit, 0,
        "static-init libc fn-pointer slots should resolve at load time, not zero-fill"
    );
}

// ---- libc vfprintf called with a c5 va_list ----
//
// c5's `va_list` is `long *` walking 16-byte c5 stack slots;
// the platform's libc vfprintf expects its own struct-shaped
// va_list. Forwarding `vfprintf(out, fmt, ap)` from a c5
// function corrupts the formatter -- the second `%d` reads
// garbage. Same shape blocked sqlite3 shell.c's `cli_printf`
// chain; the workaround there was to route through
// `sqlite3_vmprintf` (c5-compiled). The general fix is either
// to match c5's va_list to the platform's, or to ship c5-side
// wrappers around every libc function that takes a va_list.
#[test]
#[ignore = "deferred: c5 va_list incompatible with libc vfprintf / vsnprintf et al."]
fn libc_vfprintf_with_c5_va_list() {
    let exit = jit_fixture_exit("deferred_libc_vfprintf_va_list.c");
    assert_eq!(
        exit, 0,
        "vsnprintf via c5 va_list should work once the ABI gap closes"
    );
}
