//! `-ftrivial-auto-var-init`: the initialization supplied for an
//! automatic object declared without one. The fixture probes every object
//! shape after a callee has written over the stack and exits with the
//! count of bytes that miss the selected byte; it runs here under the
//! interpreter and, where the loader exists, the JIT, and
//! `tests/cli_fixture_smoke.rs` runs the linked image on each native
//! host. The object-level tests state what the flag must not change, and
//! the corpus run states that no fixture's result depends on it.

use crate::{
    AUTO_VAR_INIT_PATTERN_BYTE, AutoVarInit, CompileOptions, Compiler, Program, Target, Vm,
};

/// Compile `src` for the host under `mode`. `=pattern` passes the byte the
/// fixture checks against.
fn program_for(src: &str, mode: AutoVarInit) -> Program {
    program_for_target(src, mode, Target::host())
}

/// `program_for` for an explicit target. The fixture's probes compare
/// objects against a pattern whose width the target fixes, so the data
/// model is part of what the flag has to satisfy.
fn program_for_target(src: &str, mode: AutoVarInit, target: Target) -> Program {
    let mut opts = CompileOptions::default().with_auto_var_init(mode);
    if mode == AutoVarInit::Pattern {
        opts = opts.with_defines(alloc::vec![(
            "EXPECT".to_string(),
            alloc::format!("{AUTO_VAR_INIT_PATTERN_BYTE:#x}"),
        )]);
    }
    Compiler::with_options(super::with_prelude(src), target, opts)
        .compile()
        .unwrap_or_else(|e| panic!("compile: {e}"))
}

fn fixture_program(mode: AutoVarInit) -> Program {
    program_for(&super::load_fixture("trivial_auto_var_init.c"), mode)
}

fn vm_exit(program: Program) -> i64 {
    Vm::new(program)
        .with_pointer_tracking()
        .run()
        .unwrap_or_else(|e| panic!("run: {e}"))
}

#[test]
fn zero_fills_every_uninitialized_object_under_the_interpreter() {
    assert_eq!(vm_exit(fixture_program(AutoVarInit::Zero)), 0);
}

#[test]
fn pattern_fills_every_uninitialized_object_under_the_interpreter() {
    assert_eq!(vm_exit(fixture_program(AutoVarInit::Pattern)), 0);
}

/// `long` is 4 bytes on the Windows targets and 8 on the others, so the
/// fixture runs for both data models rather than for the host's alone.
#[test]
fn every_uninitialized_object_is_filled_under_llp64() {
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        for mode in [AutoVarInit::Zero, AutoVarInit::Pattern] {
            let src = super::load_fixture("trivial_auto_var_init.c");
            assert_eq!(
                vm_exit(program_for_target(&src, mode, target)),
                0,
                "{target:?} {mode:?}"
            );
        }
    }
}

/// The runnable fixture and the corpus execute through the JIT on the
/// hosts where the loader is implemented.
#[cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]
mod jit_lane {
    use super::{fixture_program, program_for};
    use crate::{AutoVarInit, NativeOptions, jit_run, jit_run_with_options};

    fn jit_exit(mode: AutoVarInit) -> i32 {
        jit_run(
            &fixture_program(mode),
            &["trivial_auto_var_init".to_string()],
        )
        .unwrap_or_else(|e| panic!("jit_run: {e}"))
    }

    #[test]
    fn zero_fills_every_uninitialized_object_under_the_jit() {
        assert_eq!(jit_exit(AutoVarInit::Zero), 0);
    }

    #[test]
    fn pattern_fills_every_uninitialized_object_under_the_jit() {
        assert_eq!(jit_exit(AutoVarInit::Pattern), 0);
    }

    /// Every registered fixture exits under `=zero` at `-O` as it does
    /// without the flag: the supplied initializer is overwritten by the
    /// program's own stores before any read a correct program makes, so
    /// no result may move, and the promotion has to take the extra
    /// store in its stride.
    #[test]
    fn zero_leaves_every_fixture_result_unchanged() {
        let failures = crate::c5::tests::parity_failures(
            crate::c5::tests::fixture_tables::JIT_FIXTURES,
            |name, expected| {
                let program = program_for(&crate::c5::tests::load_fixture(name), AutoVarInit::Zero);
                let opts = NativeOptions::new().with_optimize();
                match jit_run_with_options(&program, &[name.to_string()], opts) {
                    Ok(code) if code == *expected => None,
                    Ok(code) => Some(alloc::format!("{name}: exit {code}, expected {expected}")),
                    Err(e) => Some(alloc::format!("{name}: {e}")),
                }
            },
        );
        assert!(
            failures.is_empty(),
            "{} of {} fixtures moved under =zero:\n  {}",
            failures.len(),
            crate::c5::tests::fixture_tables::JIT_FIXTURES.len(),
            failures.join("\n  ")
        );
    }
}

/// The emitted text of `src` for `target` under `mode`.
#[cfg(feature = "full")]
fn text_for(src: &str, target: Target, mode: AutoVarInit, optimize: bool) -> alloc::vec::Vec<u8> {
    use crate::NativeOptions;
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_auto_var_init(mode)
            .with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile: {e}"));
    let opts = NativeOptions {
        optimize,
        ..NativeOptions::default()
    };
    crate::c5::codegen::lower_for(&program, target, opts)
        .unwrap_or_else(|e| panic!("lower: {e}"))
        .text
}

/// Objects the flag leaves alone: one carrying the attribute in either
/// position, and an explicit-register variable, whose "storage" is the
/// register. The control is the same source without the opt-outs, which
/// the flag does change.
#[test]
#[cfg(feature = "full")]
fn the_attribute_and_a_register_binding_opt_out() {
    for (target, sp) in [(Target::LinuxX64, "rsp"), (Target::LinuxAarch64, "sp")] {
        let opted_out = alloc::format!(
            "int trailing(int v) {{ int __attribute__((uninitialized)) x; x = v; return x; }}\n\
             int leading(int v) {{ __attribute__((uninitialized)) int a[4]; a[0] = v; return a[0]; }}\n\
             unsigned long reg(void) {{ register unsigned long p asm(\"{sp}\"); return p; }}\n"
        );
        let control = "int trailing(int v) { int x; x = v; return x; }\n\
                       int leading(int v) { int a[4]; a[0] = v; return a[0]; }\n";
        for mode in [AutoVarInit::Zero, AutoVarInit::Pattern] {
            assert_eq!(
                text_for(&opted_out, target, mode, false),
                text_for(&opted_out, target, AutoVarInit::Uninitialized, false),
                "{target:?} {mode:?}: an opted-out object must get no store"
            );
            assert_ne!(
                text_for(control, target, mode, false),
                text_for(control, target, AutoVarInit::Uninitialized, false),
                "{target:?} {mode:?}: the control must get the store"
            );
        }
    }
}

/// A scalar the `-O` promotion lifts into a register and the program
/// writes before it reads costs nothing: the supplied value is a dead
/// immediate the emitters skip, so the text is the unflagged one.
#[test]
#[cfg(feature = "full")]
fn a_promoted_scalar_written_before_any_read_costs_nothing_at_o() {
    let src = "int f(int v) { int x; x = v * 3; return x + 1; }\n\
               long g(long *p) { long n; n = *p; return n; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        for mode in [AutoVarInit::Zero, AutoVarInit::Pattern] {
            assert_eq!(
                text_for(src, target, mode, true),
                text_for(src, target, AutoVarInit::Uninitialized, true),
                "{target:?} {mode:?}"
            );
        }
    }
}
