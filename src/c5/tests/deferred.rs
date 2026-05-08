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
//! tracking GitHub issue.
//!
//! The fixtures themselves live in `fixtures/c/deferred_*.c`. The
//! prefix makes them easy to grep for and skips the normal
//! fixture-parity tables (which only pick up unprefixed names).
//!
//! Each test below carries the matching `gh #N` -- the GitHub
//! issue tracking the bug. See `gh issue list --label deferred`
//! (or just `gh issue list` and grep for the `c5:` / target
//! prefix) for the latest status.
//!
//! Gating: gated identically to `super::jit` so the fixtures load
//! into the in-process JIT on the platforms that support it. PE-
//! and Linux-ELF-specific deferred fixtures (#12 / #13 / #14) are
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
#[ignore = "deferred (gh #20): unsigned arithmetic high-half not masked through registers"]
fn unsigned_arith_high_half_not_masked() {
    // Today this fixture exits 1 (the very first check fires)
    // because `~u` carries the sign-extended high half across
    // the comparison. Fix: mask the result of unsigned bitwise
    // / shift / arithmetic ops to the slot width before the
    // comparison observes it, or store-and-reload.
    let exit = jit_fixture_exit("deferred_unsigned_arith_high_half.c");
    assert_eq!(exit, 0, "fixture should exit 0 once gh #20 lands");
}

#[test]
fn unsigned_right_shift_is_logical() {
    // `unsigned int x >> 1` lowers to `Op::Shru` (ARM64 LSR /
    // x86_64 SHR) when the LHS has an unsigned type, so the high
    // bit zero-extends rather than sign-extending. Was deferred
    // until Op::Shru / ShruI landed; kept around as a regression
    // marker.
    let exit = jit_fixture_exit("unsigned_right_shift.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
#[ignore = "deferred (gh #21): unsigned divide / modulo use signed ops"]
fn unsigned_divide_and_modulo_are_signed() {
    // `Op::Div` / `Op::Mod` lower to SDIV (ARM64) / IDIV
    // (x86_64). Unsigned operands with the high bit set come
    // out wrong (or fault on overflow). Fix: dedicated
    // `Op::Divu` / `Op::Modu` routed when either operand is
    // unsigned.
    let exit = jit_fixture_exit("deferred_unsigned_div_mod.c");
    assert_eq!(exit, 0, "fixture should exit 0 once gh #21 lands");
}

#[test]
#[ignore = "deferred (gh #22): signed -> unsigned promotion in mixed expressions"]
fn mixed_signed_unsigned_no_promotion() {
    // C99 sec 6.3.1.8 promotes the signed operand to the unsigned
    // common type. Today the dialect picks the op based on the
    // operator (signed for arithmetic; mixed-sensitive for
    // compares) without converting.
    let exit = jit_fixture_exit("deferred_mixed_signed_unsigned.c");
    assert_eq!(exit, 0, "fixture should exit 0 once gh #22 lands");
}

#[test]
#[ignore = "deferred (gh #22): arithmetic results not masked to common-type width when mixed signed/unsigned"]
fn c99_arith_common_width() {
    // After Add / Sub / Mul, c5 keeps the 64-bit accumulator
    // value. C99 6.3.1.8 / 6.5 say the result lives at the
    // common type's width, wrap-modulo-2^N for unsigned. Today
    // c5 only masks when *both* operands are unsigned (the
    // canonical `uint + uint` wrap case); mixed signed/unsigned
    // (e.g. `(uint)0xFFFFFFFF + 1` where 1 is a bare int
    // literal) keeps the wider value. Tracked by exit-code
    // numbers in the fixture; today only code 5 (signed-overflow
    // truncate-to-int convention from clang) fires from the
    // failure list, the rest of the gaps surface only when
    // results bypass typed storage (which sqlite happens not
    // to do).
    let exit = jit_fixture_exit("deferred_c99_arith_common_width.c");
    assert_eq!(exit, 0, "C99 arith common-type width regression");
}

#[test]
fn u16_load_store_is_two_bytes() {
    // `*(u16*)p` reads/writes exactly 2 bytes via Op::Lh / Op::Lhu
    // / Op::Sh and the matching aarch64 LDRSH / LDRH / STRH and
    // x86_64 movsx16 / movzx16 / mov16 helpers. Was deferred until
    // real `Ty::Short` storage class landed; kept as a regression
    // marker.
    let exit = jit_fixture_exit("u16_load_store.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn integer_boundary_c99_final_boss() {
    // Comprehensive C99 spec encoding for every signed / unsigned
    // x {char, short, int, long} combination across load, store,
    // sign / zero extension, narrowing cast, overflow, shift, and
    // compare. Each CHECK carries a unique exit code so a
    // regression pinpoints the exact boundary. Was deferred until
    // (a) `signed char` became a real 1-byte type with `Op::Lcs`
    // sign-extending load, (b) the cast lowering started masking
    // / sign-extending to the target storage width.
    let exit = jit_fixture_exit("integer_boundary_c99.c");
    assert_eq!(exit, 0, "C99 integer boundary regression");
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
#[ignore = "deferred (gh #12): Linux ELF TLS layout shifts when static-local state lands nearby"]
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
#[ignore = "deferred (gh #23): optimizer SIGSEGVs on sqlite3 aggregate codegen; minimal repro not yet extracted"]
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
    let exit = jit_fixture_exit("width_typedefs.c");
    assert_eq!(
        exit, 0,
        "size_t / ssize_t / time_t should be pointer-wide on 64-bit hosts"
    );
}

// ---- PE/x64 struct fp-call (#50) ----
//
// Same reasoning as #51: the bug only fires on PE/x64. The
// fixture passes on JIT today; panic so the issue stays in
// the --ignored failure list.
#[test]
#[ignore = "deferred (gh #14): function-pointer call through struct field returns wrong on PE/x64"]
fn struct_fp_call_per_target() {
    let _ = jit_fixture_exit("deferred_struct_fp_call.c");
    panic!("(#50) PE/x64 struct fp-call repro pending; JIT lane passes the fixture in isolation");
}

// ---- Function-pointer-decay through `**fp` returning struct
//      pointer (#60) ----
//
// `(*fp)(args)` and `(**fp)(args)` both auto-decay to a regular
// call per C; the dialect's conservative pop-redundant-load fix
// catches the int-return form but not the struct-pointer-return
// form (the over-deref still leaves a pointer-typed `ty` so the
// fix's `!is_pointer_ty` check skips). sqlite's
// `(**(finder_type*)pVfs->pAppData)(...)` inside `unixOpen` is
// the in-the-wild trigger; it's currently patched in the
// vendored sqlite3.c with a temp-variable workaround. A proper
// fix needs the type encoding to distinguish "pointer to function"
// from "pointer to data" -- bigger than this iteration.
#[test]
#[ignore = "deferred (gh #19): `(**fp)(args)` over-derefs through function code when the function pointer's return type is a struct pointer"]
fn fn_ptr_double_deref_struct_return() {
    let exit = jit_fixture_exit("deferred_fn_ptr_struct_return.c");
    assert_eq!(
        exit, 0,
        "double-deref of a function pointer should auto-decay to the call regardless of the return type"
    );
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
#[ignore = "deferred (gh #16): libc data globals (stdin/stdout/stderr) need a Windows arm in __c5_lazy_stream"]
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
fn libc_address_in_static_init() {
    // #54 fixed: each `&libc_fn` in a static initializer now
    // routes through a per-Sys trampoline (a tiny synthesized
    // c5 function that re-pushes its declared args and
    // re-dispatches via JsrExt). The CodeReloc machinery
    // patches the recorded data slot to the trampoline's
    // address at load time. Test stays around as a regression
    // marker.
    let exit = jit_fixture_exit("libc_address_in_static_init.c");
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
#[ignore = "deferred (gh #18): c5 va_list incompatible with libc vfprintf / vsnprintf et al."]
fn libc_vfprintf_with_c5_va_list() {
    let exit = jit_fixture_exit("deferred_libc_vfprintf_va_list.c");
    assert_eq!(
        exit, 0,
        "vsnprintf via c5 va_list should work once the ABI gap closes"
    );
}
