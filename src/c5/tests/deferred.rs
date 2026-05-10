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

// ---- Unsigned-arithmetic regressions ----

#[test]
fn unsigned_arith_high_half_masked() {
    // C99 6.5: unsigned bitwise / shift / arithmetic results at
    // the type's storage width. The 64-bit accumulator carries
    // sign-extended bits past the operand width after `~`, `<<`,
    // `+`/`-`/`*`; the post-op mask in the compiler discards
    // them so register-resident comparisons agree with C99.
    // Was deferred (#20); fixture is now a regression marker.
    let exit = jit_fixture_exit("unsigned_arith_high_half.c");
    assert_eq!(exit, 0, "fixture should exit 0");
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
fn unsigned_divide_and_modulo_use_unsigned_ops() {
    // C99 6.3.1.8: when either operand of `/` or `%` is unsigned,
    // both operands convert to the unsigned common type and the
    // operation is unsigned. `Op::Divu` / `Op::Modu` (UDIV on
    // ARM64, `DIV` with `xor edx, edx` on x86_64) are routed
    // when the C99 common type is unsigned. Was deferred (#21);
    // fixture is now a regression marker.
    let exit = jit_fixture_exit("unsigned_div_mod.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn mixed_signed_unsigned_div_mod() {
    // C99 6.3.1.8: a mixed signed/unsigned `/` or `%` converts
    // the signed operand to the unsigned common type by adding
    // 2^N (per 6.3.1.3). The pre-divide pass masks each operand
    // to the common-unsigned width when one of them is signed,
    // so `(int)-1 / (uint)2` lands as `0xFFFFFFFFu / 2u =
    // 0x7FFFFFFFu` instead of the sign-extended-i64 udiv result.
    // Was deferred (#22 div/mod arm); fixture is now a
    // regression marker.
    let exit = jit_fixture_exit("mixed_signed_unsigned_div.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn c99_arith_common_width_full() {
    // After Add / Sub / Mul, c5 truncates the 64-bit accumulator
    // to the C99 6.3.1.8 common type's storage width:
    //   * unsigned common -> mask `(1 << N) - 1` (wrap-modulo-2^N).
    //   * signed common (UB per C99 6.5p5) -> match clang / gcc
    //     and truncate-and-sign-extend via `Shl K; Shr K`.
    // Was deferred (#22 signed-overflow arm); fixture is now a
    // regression marker.
    let exit = jit_fixture_exit("c99_arith_common_width.c");
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

// ---- Address-of-libc-fn in static initializer ----
//
// Static-init paths emit `Imm 0` plus a runtime-patch warning
// when the right-hand side names a libc symbol. Dispatch
// tables that name libc callbacks (e.g. a VFS-style table of
// `&open`, `&read`, `&close`, ...) rely on the address being
// real at first read; any code path that reads a slot before
// the runtime patch fires sees a NULL function pointer.
// Affects every target -- the right fix is a GOT/IAT-trampoline
// pipeline that resolves at load time.
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
// garbage. The general fix is either to match c5's va_list to
// the platform's, or to ship c5-side wrappers around every
// libc function that takes a va_list.
#[test]
#[ignore = "deferred (gh #18): c5 va_list incompatible with libc vfprintf / vsnprintf et al."]
fn libc_vfprintf_with_c5_va_list() {
    let exit = jit_fixture_exit("deferred_libc_vfprintf_va_list.c");
    assert_eq!(
        exit, 0,
        "vsnprintf via c5 va_list should work once the ABI gap closes"
    );
}
