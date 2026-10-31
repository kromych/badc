//! In-process runs join the on-demand sources as a native link joins them.

#![cfg(any(
    target_os = "linux",
    all(target_os = "macos", target_arch = "aarch64"),
    target_os = "windows",
))]

use crate::c5::linker::OnDemandSources;
use crate::{Compiler, NativeOptions, Target, jit_run_with_options, jit_run_with_sources};

/// `<d.c>`, which nothing asks for, would end the run with 99.
const POOL: &[(&str, &str)] = &[
    ("<a.c>", "int g(void); int f(void) { return g() + 1; }"),
    (
        "<b.c>",
        "extern int counter; int g(void) { return counter * 10; }",
    ),
    (
        "<c.c>",
        "int g(void); int counter = 4; int (*pg)(void) = g;",
    ),
    (
        "<d.c>",
        "void exit(int); int unused(void) { return 0; }\n\
         __attribute__((constructor)) static void d(void) { exit(99); }",
    ),
];

fn jit_exit(src: &str) -> i32 {
    let program = Compiler::new(src.to_string()).compile().expect("compile");
    jit_run_with_options(&program, &[], NativeOptions::new(), &mut |_| {}).expect("jit_run")
}

fn jit_exit_with_pool(src: &str, pool: &[(&str, &'static str)]) -> i32 {
    let program = Compiler::new(src.to_string()).compile().expect("compile");
    let pool = OnDemandSources::of(Target::host(), pool);
    jit_run_with_sources(&program, &[], NativeOptions::new(), &pool, &mut |_| {})
        .expect("jit_run_with_sources")
}

const STRING_EXTENSIONS: &str = "#include <string.h>\n\
    int main(void) { const char *s = \"abc\";\n\
      char *p = strchrnul(s, 'z'); char *q = memrchr(s, 'a', 3);\n\
      return (int)(p - s) * 10 + (int)(q - s); }";

/// The program's `memrchr` wins over `string_ext.c`'s.
const OWN_DEFINITION: &str = "#include <string.h>\n\
    void *memrchr(const void *s, int c, size_t n) { (void)c; (void)n; return (void *)s; }\n\
    int main(void) { const char *s = \"abc\";\n\
      return (int)(strchrnul(s, 'b') - s) + (memrchr(s, 'c', 3) == s) * 10; }";

/// Pulls `<a.c>`, which pulls `<b.c>`, which pulls `<c.c>`; `<d.c>` stays out.
const TRANSITIVE: &str = "int f(void); extern int (*pg)(void);\n\
    int main(void) { return f() + pg(); }";

/// `<a.c>`'s `g` is the program's; `<b.c>` stays out.
const PROGRAM_FIRST: &str = "int f(void); int g(void) { return 6; }\n\
    int main(void) { return f(); }";

#[test]
fn a_function_only_the_on_demand_sources_define_runs_under_the_jit() {
    assert_eq!(jit_exit(STRING_EXTENSIONS), 30);
}

#[test]
fn the_programs_definition_wins_over_an_on_demand_source_under_the_jit() {
    assert_eq!(jit_exit(OWN_DEFINITION), 11);
}

#[test]
fn on_demand_members_pull_the_members_they_need_under_the_jit() {
    assert_eq!(jit_exit_with_pool(TRANSITIVE, POOL), 81);
}

#[test]
fn a_members_reference_binds_to_the_programs_definition_under_the_jit() {
    let pool = [
        POOL[0],
        ("<b.c>", "void exit(int); int g(void) { exit(99); }"),
    ];
    assert_eq!(jit_exit_with_pool(PROGRAM_FIRST, &pool), 7);
}
