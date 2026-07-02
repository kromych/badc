//! C99 6.7.6.2 variable-length array regression tests.
//!
//! The runnable fixtures go through the JIT, whose lowering is the same
//! as the AOT Mach-O / ELF backends; those backends also run the same
//! fixtures through their `fixture_parity` tables (see
//! `super::native::NATIVE_FIXTURES`, `super::native_elf`,
//! `super::native_elf_x64`). The constraint-violation fixtures assert a
//! clean compile-time diagnostic rather than a miscompile.

use crate::Compiler;

/// Compile a fixture and return the diagnostic message, panicking if it
/// compiled. Used for the C99 constraint violations that must be
/// rejected, not silently accepted.
fn compile_error(name: &str) -> String {
    let src = super::load_fixture(name);
    match Compiler::new(super::with_prelude(&src)).compile() {
        Ok(_) => panic!("{name}: expected a compile error, but it compiled"),
        Err(e) => alloc::format!("{e}"),
    }
}

#[test]
fn multidim_vla_rejected() {
    assert!(
        compile_error("vla_multidim_rejected.c").contains("multidimensional variable-length"),
        "wrong diagnostic for a multidimensional VLA"
    );
}

#[test]
fn file_scope_vla_rejected() {
    assert!(
        compile_error("vla_file_scope_rejected.c").contains("variable-length array"),
        "wrong diagnostic for a file-scope VLA"
    );
}

#[test]
fn vla_initializer_rejected() {
    assert!(
        compile_error("vla_initializer_rejected.c").contains("may not have an initializer"),
        "wrong diagnostic for an initialized VLA"
    );
}

/// The runnable fixtures execute through the JIT on the hosts where the
/// loader is implemented (Linux aarch64 / x86_64, macOS arm64). Each
/// fixture self-checks and returns 0 on success.
#[cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]
mod jit_lane {
    use crate::{Compiler, jit_run};

    fn jit_fixture_exit(name: &str) -> i32 {
        let src = super::super::load_fixture(name);
        let program = Compiler::new(super::super::with_prelude(&src))
            .compile()
            .expect("compile failed");
        jit_run(&program, &[name.to_string()]).expect("jit_run failed")
    }

    #[test]
    fn basic_sum() {
        assert_eq!(jit_fixture_exit("vla_basic_sum.c"), 0);
    }

    #[test]
    fn runtime_sizeof() {
        assert_eq!(jit_fixture_exit("vla_runtime_sizeof.c"), 0);
    }

    #[test]
    fn size_from_arg() {
        assert_eq!(jit_fixture_exit("vla_size_from_arg.c"), 0);
    }

    #[test]
    fn scope_reclaim_loop() {
        assert_eq!(jit_fixture_exit("vla_scope_reclaim_loop.c"), 0);
    }

    #[test]
    fn param_decay() {
        assert_eq!(jit_fixture_exit("vla_param_decay.c"), 0);
    }
}
