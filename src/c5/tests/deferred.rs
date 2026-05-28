//! Deferred-issue fixtures.
//!
//! Each test below pins a known-broken behavior in the dialect
//! or a target-specific interaction. The currently-broken ones
//! are `#[ignore]`'d so a default `cargo test` stays green;
//! `cargo test -- --ignored` re-validates that the failure mode
//! still matches what the comment documents.
//!
//! When one of these starts passing, the `#[ignore]` attribute
//! is removed and the fixture moves into the regular
//! `JIT_FIXTURES` / `NATIVE_FIXTURES` lists.
//!
//! The fixtures themselves live in
//! `tests/fixtures/c/deferred_*.c`. The prefix makes them easy
//! to grep for and skips the normal fixture-parity tables (which
//! only pick up unprefixed names).
//!
//! Gating: gated identically to `super::jit` so the fixtures
//! load into the in-process JIT on the platforms that support
//! it. PE-specific and Linux-ELF-specific deferred fixtures are
//! checked in separate per-format harnesses below.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use crate::{CompileOptions, Compiler, LinkUnit, Target, jit_run, link_units};

/// Compile a fixture and run it through the JIT, returning the
/// exit code. Routes through `compile_to_link_unit` + the
/// embedded runtime sources so the merged Program carries
/// everything `lib/*.c` provides (libc-`exit` wrapper,
/// `environ` slot, ...). Panics on compile / load failure.
fn jit_fixture_exit(name: &str) -> i32 {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let target = Target::default_target();
    let user = Compiler::new(super::with_prelude(&src))
        .compile_to_link_unit()
        .expect("compile failed");
    let mut units: Vec<LinkUnit> = vec![user];
    for (rt_name, rt_body) in crate::embedded_runtime() {
        let copts = CompileOptions::default().with_source_label((*rt_name).to_string());
        let unit = Compiler::with_options(rt_body.to_string(), target, copts)
            .compile_to_link_unit()
            .expect("compile runtime");
        units.push(unit);
    }
    let program = link_units(units).expect("link_units failed");
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
    let exit = jit_fixture_exit("unsigned_arith_high_half.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn unsigned_right_shift_is_logical() {
    // `unsigned int x >> 1` lowers to `BinOp::Shru` (ARM64 LSR /
    // x86_64 SHR) when the LHS has an unsigned type, so the high
    // bit zero-extends rather than sign-extending.
    let exit = jit_fixture_exit("unsigned_right_shift.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn unsigned_divide_and_modulo_use_unsigned_ops() {
    // C99 6.3.1.8: when either operand of `/` or `%` is unsigned,
    // both operands convert to the unsigned common type and the
    // operation is unsigned. `BinOp::Divu` / `BinOp::Modu` (UDIV on
    // ARM64, `DIV` with `xor edx, edx` on x86_64) are routed
    // when the C99 common type is unsigned.
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
    let exit = jit_fixture_exit("c99_arith_common_width.c");
    assert_eq!(exit, 0, "C99 arith common-type width regression");
}

#[test]
fn u16_load_store_is_two_bytes() {
    // `*(u16*)p` reads/writes exactly 2 bytes via `LoadKind::I16`
    // / `LoadKind::U16` / `StoreKind::I16` and the matching
    // aarch64 LDRSH / LDRH / STRH and x86_64 movsx16 / movzx16 /
    // mov16 helpers.
    let exit = jit_fixture_exit("u16_load_store.c");
    assert_eq!(exit, 0, "fixture should exit 0");
}

#[test]
fn integer_boundary_c99_final_boss() {
    // Comprehensive C99 spec encoding for every signed / unsigned
    // x {char, short, int, long} combination across load, store,
    // sign / zero extension, narrowing cast, overflow, shift, and
    // compare. Each CHECK carries a unique exit code so a
    // regression pinpoints the exact boundary.
    let exit = jit_fixture_exit("integer_boundary_c99.c");
    assert_eq!(exit, 0, "C99 integer boundary regression");
}

// ---- Linux ELF TLS interaction ----
//
// The bug is Linux-ELF specific. macOS arm64's JIT doesn't
// support TLS at all (Mach-O __thread_data + dyld
// __tlv_bootstrap is future work) and would SIGSEGV the test
// runner on a `_Thread_local` access. Gate this test to Linux
// so it actually exercises the failure mode.
#[cfg(target_os = "linux")]
#[test]
#[ignore = "TODO: Linux ELF TLS layout shifts when static-local state lands nearby"]
fn linux_elf_tls_layout_with_static_locals() {
    let exit = jit_fixture_exit("deferred_tls_with_static_locals.c");
    assert_eq!(
        exit, 0,
        "fixture should exit 0 once the layout bug is fixed"
    );
}

// ---- size_t / ssize_t / time_t typedef widths ----
//
// `size_t`, `ssize_t` and `time_t` are byte-counting typedefs;
// C99 7.17 (size_t) and POSIX `<sys/types.h>` (ssize_t /
// time_t) require them to span at least the address space. On
// 64-bit hosts the c5 prelude aliases them to `long` so a libc
// bridge that takes one doesn't truncate inputs above 2^31.
#[test]
fn width_typedefs_are_pointer_wide() {
    // `<stddef.h>`, `<sys/types.h>` and `<time.h>` alias the
    // byte-counting typedefs to `long`, so `sizeof(size_t)` etc.
    // return 8 on 64-bit hosts.
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
    // Each `&libc_fn` in a static initializer routes through a
    // per-Sys trampoline (a tiny synthesized c5 function that
    // re-pushes its declared args and re-dispatches via
    // JsrExt). The CodeReloc machinery patches the recorded
    // data slot to the trampoline's address at load time.
    let exit = jit_fixture_exit("libc_address_in_static_init.c");
    assert_eq!(
        exit, 0,
        "static-init libc fn-pointer slots should resolve at load time, not zero-fill"
    );
}

// C99 7.15.1 requires `vfprintf` / `vsnprintf` to format with
// arguments drawn from a `va_list`. c5's `va_list` is `long *`
// walking 16-byte c5 stack slots; the platform's libc va_list
// has a different shape, so forwarding c5's `va_list` to libc's
// `vfprintf` would have the formatter walk the wrong memory.
// The stdio.h prelude redirects `vfprintf` / `vprintf` /
// `vsnprintf` to the c5-side `c5_vsnprintf` family in <c5io.h>,
// which walks the c5-shaped cursor directly. This fixture
// exercises that redirect end-to-end.
#[test]
fn libc_vfprintf_with_c5_va_list() {
    let exit = jit_fixture_exit("deferred_libc_vfprintf_va_list.c");
    assert_eq!(
        exit, 0,
        "vsnprintf via c5 va_list should format `%d %d, 42, 99` as `42 99`"
    );
}
