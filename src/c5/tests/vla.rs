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
        compile_error("vla_multidim_rejected.c").contains("non-constant inner array dimension"),
        "wrong diagnostic for a VLA with a non-constant inner dimension"
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

/// A VLA's array type under the interpreter, for both data models: `&v`,
/// `*&v`, `sizeof` and arithmetic on the pointer read the run-time size.
#[test]
fn vla_array_type_runs_under_the_interpreter() {
    for t in [crate::Target::LinuxX64, crate::Target::WindowsAarch64] {
        assert_eq!(super::run_fixture_for("vla_array_type.c", t), 0, "{t:?}");
    }
}

/// A block-scope typedef of a variable-length array type (C99 6.7.7p2)
/// under the interpreter, for both data models.
#[test]
fn vla_typedef_runs_under_the_interpreter() {
    for t in [crate::Target::LinuxX64, crate::Target::WindowsAarch64] {
        assert_eq!(
            super::run_fixture_for("vla_typedef_block_scope.c", t),
            0,
            "{t:?}"
        );
    }
}

/// What a variably modified typedef may not declare: an object of static
/// storage duration or with linkage (C99 6.7.5.2p2) and a member
/// (6.7.2.1p8), which gcc 16 and clang 22 reject; a jump into its scope
/// (6.8.6.1p1); and an array of it, which badc does not lay out.
#[test]
fn vla_typedef_constraints_are_diagnosed() {
    for (body, text) in [
        (
            "static U u;",
            "variable-length array `u` may not have static storage duration",
        ),
        (
            "extern U u;",
            "variable-length array `u` may not have linkage",
        ),
        (
            "struct S { U m; } s;",
            "field `m` has a variably modified type",
        ),
        (
            "U a[2];",
            "a non-constant inner array dimension is not supported",
        ),
        (
            "typedef U W[3];",
            "a non-constant inner array dimension is not supported",
        ),
    ] {
        let src = alloc::format!("int f(int n) {{ typedef char U[n]; {body} return n; }}\n");
        match Compiler::new(src).compile() {
            Ok(_) => panic!("{body}: compiled"),
            Err(e) => {
                let msg = alloc::format!("{e}");
                assert!(msg.contains(text), "{body}: {msg}");
            }
        }
    }
    let src = "int f(int n) { goto l; typedef char U[n]; l: return n; }\n";
    let msg = alloc::format!("{}", Compiler::new(src.into()).compile().unwrap_err());
    assert!(msg.contains("jumps into the scope of `U`"), "{msg}");
    let src = "int n = 3; typedef char U[n];\n";
    let msg = alloc::format!("{}", Compiler::new(src.into()).compile().unwrap_err());
    assert!(msg.contains("only allowed at block scope"), "{msg}");
}

/// C99 6.5.3.4p2: `sizeof` of a variable-length array is evaluated, so it
/// is no constant: an array bound of it declares a variable-length array
/// (`int b[sizeof a]`), and a context that requires a constant rejects it,
/// as gcc 16 does. The run's values are gcc's.
#[test]
fn sizeof_of_a_vla_is_not_a_constant() {
    let src = "int f(int n) { char a[n];\n\
               int b[sizeof a]; char c[sizeof a][2];\n\
               _Static_assert(sizeof(sizeof a) == sizeof(void *), \"\");\n\
               return (int)(sizeof b / sizeof b[0]) + (int)sizeof c * 10\n\
                 + (int)sizeof(int[sizeof(char[n])]) * 100 + __builtin_constant_p(sizeof a); }\n\
               int main(void) { return f(3) != 1263; }\n";
    for t in [crate::Target::LinuxX64, crate::Target::WindowsAarch64] {
        let program = Compiler::with_target(super::with_prelude(src), t)
            .compile()
            .unwrap_or_else(|e| panic!("{t:?}: {e}"));
        assert_eq!(super::Vm::new(program).run().unwrap(), 0, "{t:?}");
    }
    for body in [
        "switch (n) { case sizeof a: return 1; }",
        "enum { E = sizeof a };",
        "_Static_assert(sizeof a == 3, \"\");",
        "static int x = sizeof a;",
    ] {
        let src = alloc::format!("int f(int n) {{ char a[n]; {body} return n; }}\n");
        match Compiler::new(src).compile() {
            Ok(_) => panic!("{body}: compiled"),
            Err(e) => {
                let msg = alloc::format!("{e}");
                assert!(
                    msg.contains("`sizeof` of a variable-length array is not a constant"),
                    "{body}: {msg}"
                );
            }
        }
    }
}

/// An object declared through `typeof` of a VLA would need its storage
/// sized at run time; it is rejected rather than declared as the element
/// pointer the decayed operand has.
#[test]
fn typeof_of_a_vla_is_rejected() {
    let src = "int f(int n) { int v[n]; __typeof__(v) w; return sizeof w; }";
    match Compiler::new(super::with_prelude(src)).compile() {
        Ok(_) => panic!("`typeof` of a VLA compiled"),
        Err(e) => {
            let msg = alloc::format!("{e}");
            assert!(msg.contains("`typeof` of a variable-length array"), "{msg}");
        }
    }
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
