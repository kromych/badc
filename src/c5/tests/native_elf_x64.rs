//! End-to-end Linux/x86_64 ELF tests. Mirror of
//! [`super::native_elf`] (the Linux/aarch64 suite) for the x86_64
//! target.
//!
//! Gated to `linux + x86_64` because the produced binary is an ELF
//! that the host kernel must agree to load and execute. CI runs this
//! module on the `ubuntu-latest` runner (x86_64 by default); macOS
//! / arm64 / Windows lanes compile it out entirely.

#![cfg(all(target_os = "linux", target_arch = "x86_64"))]

use std::io::Write;
use std::path::Path;
use std::process::Command;

use super::fixture_tables::NATIVE_ELF_X64_FIXTURES;
use crate::{Compiler, NativeOptions, Target, emit_native, emit_native_with_options};

#[derive(Debug)]
#[allow(dead_code)]
enum RunOutcome {
    Exit(i32),
    Signal(i32),
    BuildError(String),
}

impl RunOutcome {
    fn matches(&self, expected: i32) -> bool {
        matches!(self, RunOutcome::Exit(c) if *c == expected)
    }
}

fn build_and_run(src: &str, stem: &str) -> i32 {
    match build_and_run_outcome(src, stem) {
        RunOutcome::Exit(c) => c,
        other => panic!("expected normal exit, got {other:?}"),
    }
}

fn build_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    build_and_run_outcome_with_options(src, stem, NativeOptions::default())
}

fn build_and_run_outcome_with_options(src: &str, stem: &str, opts: NativeOptions) -> RunOutcome {
    let program = match Compiler::new(super::with_prelude(src)).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match emit_native_with_options(&program, Target::LinuxX64, opts) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("emit_native: {e}")),
    };

    let path = super::unique_temp_path("badc-elf64-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        // sync_all + retry-on-ETXTBUSY mirror the aarch64 module --
        // see [`super::native_elf::build_and_run_outcome`] for why.
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);

    let output = exec_with_retry(&path);
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                use std::os::unix::process::ExitStatusExt;
                let signal = o.status.signal().unwrap_or(0);
                RunOutcome::Signal(signal)
            }
        }
        Err(e) => panic!("could not exec the produced binary: {e}"),
    }
}

fn exec_with_retry(path: &Path) -> std::io::Result<std::process::Output> {
    exec_with_retry_args(path, &[])
}

/// `exec_with_retry` for a caller that needs to configure the command
/// (environment, working directory). The closure is called afresh per
/// attempt because `Command` is consumed by `output`.
fn exec_with_retry_cmd(
    mut build: impl FnMut() -> Command,
) -> std::io::Result<std::process::Output> {
    for attempt in 0..10 {
        match build().output() {
            Ok(o) => return Ok(o),
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
            }
            Err(e) => return Err(e),
        }
    }
    build().output()
}

fn exec_with_retry_args(path: &Path, args: &[&str]) -> std::io::Result<std::process::Output> {
    for attempt in 0..10 {
        match Command::new(path).args(args).output() {
            Ok(o) => return Ok(o),
            Err(e) if e.raw_os_error() == Some(26) => {
                std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
            }
            Err(e) => return Err(e),
        }
    }
    Command::new(path).args(args).output()
}

fn set_executable(path: &Path) {
    use std::os::unix::fs::PermissionsExt;
    let meta = std::fs::metadata(path).unwrap();
    let mut perms = meta.permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(path, perms).unwrap();
}

/// Build through the multi-object link path (ET_REL merge +
/// `write_native_image_from_merged`) and run the produced image.
/// Exercises the merged stream layout -- the direct
/// `emit_native` path above never produces a relro region.
#[cfg(feature = "full")]
fn link_and_run_outcome(src: &str, stem: &str) -> RunOutcome {
    let program = match Compiler::with_target(src.to_string(), Target::LinuxX64).compile() {
        Ok(p) => p,
        Err(e) => return RunOutcome::BuildError(format!("compile: {e}")),
    };
    let bytes = match super::link_executable_with_runtime(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    ) {
        Ok(b) => b,
        Err(e) => return RunOutcome::BuildError(format!("link: {e}")),
    };
    let path = super::unique_temp_path("badc-elf64-test", stem, ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path);
    let _ = std::fs::remove_file(&path);
    match output {
        Ok(o) => {
            if let Some(code) = o.status.code() {
                RunOutcome::Exit(code)
            } else {
                use std::os::unix::process::ExitStatusExt;
                RunOutcome::Signal(o.status.signal().unwrap_or(0))
            }
        }
        Err(e) => panic!("could not exec the produced binary: {e}"),
    }
}

/// A relocated `const` initializer routes its unit's read-only
/// content to the relro region; after the loader's fixups the pages
/// are re-protected (PT_GNU_RELRO), so a store faults while a
/// writable global stays writable.
#[test]
#[cfg(feature = "full")]
fn relro_const_store_faults() {
    let decls = "const unsigned char tab[2048] = {7, 7, 7, 7};\n\
                 const char *const cp = \"hello\";\n\
                 int wglobal = 5;\n";
    let read = format!("{decls}int main(void) {{ return cp[0] == 'h' && tab[3] == 7 ? 0 : 1; }}");
    match link_and_run_outcome(&read, "relro_read") {
        RunOutcome::Exit(0) => {}
        other => panic!("relocated-pointer read must exit 0, got {other:?}"),
    }
    let tab_store =
        format!("{decls}int main(void) {{ *(unsigned char *)&tab[5] = 9; return tab[5]; }}");
    match link_and_run_outcome(&tab_store, "relro_tab_store") {
        RunOutcome::Signal(_) => {}
        other => panic!("store to relro const table must fault, got {other:?}"),
    }
    let slot_store = format!(
        "{decls}int main(void) {{ *(const char **)&cp = (const char *)tab; return cp == 0; }}"
    );
    match link_and_run_outcome(&slot_store, "relro_slot_store") {
        RunOutcome::Signal(_) => {}
        other => panic!("store to the relocated pointer slot must fault, got {other:?}"),
    }
    let control = format!("{decls}int main(void) {{ wglobal = 6; return wglobal == 6 ? 0 : 2; }}");
    match link_and_run_outcome(&control, "relro_control") {
        RunOutcome::Exit(0) => {}
        other => panic!("writable global must stay writable, got {other:?}"),
    }
}

// ---- Smoke tests -- mirror the aarch64 module's shapes. ----

#[test]
fn return_42() {
    assert_eq!(build_and_run("int main() { return 42; }", "ret42"), 42);
}

#[test]
fn return_zero() {
    assert_eq!(build_and_run("int main() { return 0; }", "ret0"), 0);
}

#[test]
fn return_value_truncates_to_byte() {
    assert_eq!(build_and_run("int main() { return 257; }", "ret257"), 1);
}

#[test]
fn arithmetic_and_locals() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(build_and_run(src, "locals"), 42);
}

#[test]
fn while_loop_terminates() {
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    assert_eq!(build_and_run(src, "while"), 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(build_and_run(src, "fncall"), 40);
}

#[test]
fn recursion_factorial() {
    let src = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { return fact(5); }
    "#;
    assert_eq!(build_and_run(src, "fact"), 120);
}

#[test]
fn printf_through_libc_got() {
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(build_and_run(src, "printf"), 0);
}

#[test]
fn malloc_memset_memcmp_roundtrip() {
    let src = r#"
        int main() {
            int *a;
            int *b;
            a = malloc(16);
            b = malloc(16);
            memset(a, 7, 16);
            memset(b, 7, 16);
            if (memcmp(a, b, 16) == 0) {
                free(a);
                free(b);
                return 1;
            }
            return 0;
        }
    "#;
    assert_eq!(build_and_run(src, "malloc"), 1);
}

/// The full-runtime startup publishes the process environment vector
/// through `environ` (POSIX 8.3). `__c5_entry` reads envp off the initial
/// stack (`&argv[argc + 1]`) and assigns it; without that the global is
/// NULL and `environ[i]` faults. The self-contained `emit_native` stub
/// used by the fixture parity table does not link the runtime, so this is
/// linked through `link_executable_with_runtime` and run.
#[test]
fn environ_populated_through_runtime() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    // Compile for the exact link target with the driver's default
    // options (mirroring the CLI), no header prelude: the program's
    // `extern char **environ` resolves to the runtime's single
    // definition as a plain undefined reference.
    let program = Compiler::with_options(
        "extern char **environ; \
         int main(void) { \
             if (environ == 0) { return 1; } \
             int n = 0; \
             for (char **e = environ; *e != 0; e++) { n++; } \
             return n > 0 ? 0 : 2; \
         }"
        .to_string(),
        Target::LinuxX64,
        // `no_entry_point` matches the CLI's `-c` path: the program is a
        // relocatable unit, so `extern char **environ` stays an undefined
        // reference resolved at link against the runtime's definition,
        // rather than a tentative definition that would collide.
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile environ program");
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link LinuxX64 with runtime");
    let path = super::unique_temp_path("badc-environ", "env", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec environ binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "environ must be non-null and non-empty under the full runtime",
    );
}

/// A `static` constructor runs before `main` (sets a global main
/// returns). Full link path: runtime.c walks the linker's `.init_array`.
#[test]
fn constructor_runs_before_main() {
    use crate::{Compiler, NativeOptions, Target};
    let program = Compiler::new(super::with_prelude(
        "static int g;\n\
         __attribute__((constructor)) static void ctor(void) { g = 42; }\n\
         int main(void) { return g; }\n",
    ))
    .compile()
    .expect("compile constructor program");
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link with runtime");
    let path = super::unique_temp_path("badc-ctor", "run", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec constructor binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(42),
        "the constructor must run before main and set the global",
    );
}

/// Constructor priority ordering plus a destructor firing at exit; the
/// stdout sequence pins the whole order.
#[test]
fn constructor_priority_and_destructor_order() {
    use crate::{Compiler, NativeOptions, Target};
    let program = Compiler::new(super::with_prelude(
        "#include <stdio.h>\n\
         __attribute__((constructor(102))) static void c2(void) { printf(\"c2\\n\"); }\n\
         __attribute__((constructor(101))) static void c1(void) { printf(\"c1\\n\"); }\n\
         __attribute__((constructor)) static void c3(void) { printf(\"c3\\n\"); }\n\
         __attribute__((destructor)) static void d1(void) { printf(\"d1\\n\"); }\n\
         int main(void) { printf(\"main\\n\"); return 0; }\n",
    ))
    .compile()
    .expect("compile ctor/dtor program");
    let bytes =
        super::link_executable_with_runtime(&program, Target::LinuxX64, NativeOptions::default())
            .expect("link with runtime");
    let path = super::unique_temp_path("badc-ctor-order", "run", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec ctor/dtor binary");
    let _ = std::fs::remove_file(&path);
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert_eq!(
        stdout, "c1\nc2\nc3\nmain\nd1\n",
        "constructors run priority-ascending then unprioritized, main, then the destructor at exit",
    );
}

// ---- Fixture parity. Same table as the aarch64 module so a drift
//      in either backend shows up as an arch-specific failure. ----

fn build_and_run_fixture(name: &str) -> RunOutcome {
    build_and_run_fixture_with_options(name, NativeOptions::default(), "")
}

fn build_and_run_fixture_with_options(name: &str, opts: NativeOptions, suffix: &str) -> RunOutcome {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let stem = name.trim_end_matches(".c");
    build_and_run_outcome_with_options(&src, &format!("fixture-{stem}{suffix}"), opts)
}

#[test]
fn fixture_parity() {
    let failures = super::parity_failures(NATIVE_ELF_X64_FIXTURES, |name, expected| {
        let outcome = build_and_run_fixture(name);
        (!outcome.matches(*expected))
            .then(|| format!("{name}: expected exit {expected}, got {outcome:?}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} ELF fixtures regressed:\n  {}",
        failures.len(),
        NATIVE_ELF_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// A code-stream `.align` boundary above the section default is
/// accepted (it was rejected before the writers honored a raised text
/// alignment), and the executable PT_LOAD keeps p_offset == p_vaddr
/// modulo the page size, so the raised in-segment placement holds at
/// the mapped address. The absolute-boundary semantics are locked at
/// run time by the `inline_asm_x64_align_above_section.c` fixture.
#[test]
fn inline_asm_align_beyond_section_default_accepted() {
    let program = Compiler::new(super::with_prelude(
        "int main(void) { __asm__(\".align 64\"); return 0; }\n",
    ))
    .compile()
    .expect("compile");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let rd_u16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_phoff = rd_u64(0x20) as usize;
    let e_phnum = rd_u16(0x38) as usize;
    const PF_X: u32 = 1;
    let mut exec_seen = false;
    for i in 0..e_phnum {
        let ph = e_phoff + i * 56;
        let p_type = u32::from_le_bytes(bytes[ph..ph + 4].try_into().unwrap());
        let p_flags = u32::from_le_bytes(bytes[ph + 4..ph + 8].try_into().unwrap());
        if p_type == 1 && p_flags & PF_X != 0 {
            let p_offset = rd_u64(ph + 8);
            let p_vaddr = rd_u64(ph + 16);
            assert_eq!(p_offset % 4096, p_vaddr % 4096, "offset/vaddr congruence");
            exec_seen = true;
        }
    }
    assert!(exec_seen, "no executable PT_LOAD");
}

/// When a dynamic import binds a versioned default symbol, the writer
/// wires DT_VERSYM / DT_VERNEED into `.dynamic` and must also give the
/// `.gnu.version` / `.gnu.version_r` payloads real section headers so
/// section-based tooling (readelf -V, objcopy) can find them. Ties the
/// expectation to DT_VERSYM so the check is non-vacuous only when the
/// host glibc actually resolves a versioned default.
#[test]
fn versioned_import_emits_gnu_version_section_headers() {
    const SHT_STRTAB: u32 = 3;
    const SHT_DYNAMIC: u32 = 6;
    const SHT_DYNSYM: u32 = 11;
    const SHT_GNU_VERNEED: u32 = 0x6fff_fffe;
    const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;
    let src = super::load_fixture("elf_symbol_version_default.c");
    let program = Compiler::new(super::with_prelude(&src))
        .compile()
        .expect("compile");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let rd_u16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd_u32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd_u64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd_u64(0x28) as usize;
    let e_shnum = rd_u16(0x3C) as usize;
    let e_shstrndx = rd_u16(0x3E) as usize;
    let shdr = |i: usize| e_shoff + i * 64;
    let sh_name = |i: usize| rd_u32(shdr(i));
    let sh_type = |i: usize| rd_u32(shdr(i) + 4);
    let sh_offset = |i: usize| rd_u64(shdr(i) + 24) as usize;
    let sh_size = |i: usize| rd_u64(shdr(i) + 32) as usize;
    let sh_link = |i: usize| rd_u32(shdr(i) + 40) as usize;
    let sh_entsize = |i: usize| rd_u64(shdr(i) + 56);
    let shstr_off = sh_offset(e_shstrndx);
    let name_at = |noff: u32| -> String {
        let start = shstr_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };
    // Does `.dynamic` carry DT_VERSYM (0x6fff_fff0)? If so, the payloads
    // exist and their section headers are required.
    let mut has_dt_versym = false;
    if let Some(dyn_i) = (0..e_shnum).find(|&i| sh_type(i) == SHT_DYNAMIC) {
        let (off, size) = (sh_offset(dyn_i), sh_size(dyn_i));
        let mut p = off;
        while p + 16 <= off + size {
            let d_tag = rd_u64(p);
            if d_tag == 0x6fff_fff0 {
                has_dt_versym = true;
                break;
            }
            if d_tag == 0 {
                break;
            }
            p += 16;
        }
    }
    if !has_dt_versym {
        return; // no versioned import resolved on this host
    }
    let versym = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_GNU_VERSYM)
        .expect("DT_VERSYM present but no SHT_GNU_versym header");
    let verneed = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_GNU_VERNEED)
        .expect("DT_VERNEED present but no SHT_GNU_verneed header");
    assert_eq!(name_at(sh_name(versym)), ".gnu.version");
    assert_eq!(name_at(sh_name(verneed)), ".gnu.version_r");
    assert_eq!(sh_entsize(versym), 2);
    assert_eq!(
        sh_type(sh_link(versym)),
        SHT_DYNSYM,
        "versym.sh_link -> .dynsym"
    );
    assert_eq!(sh_type(sh_link(verneed)), SHT_STRTAB);
    assert_eq!(name_at(sh_name(sh_link(verneed))), ".dynstr");
    assert_eq!(e_shstrndx, e_shnum - 1, "shstrtab must be the last section");

    // The version sections shift .text's index; the PLT .symtab's
    // function symbols (e.g. `main`) must name the shifted .text index,
    // not the pre-shift one, or a debugger / objdump attributes them to
    // the wrong section.
    const SHT_SYMTAB: u32 = 2;
    let text_idx = (0..e_shnum)
        .find(|&i| sh_type(i) == 1 && name_at(sh_name(i)) == ".text") // SHT_PROGBITS
        .expect(".text section present") as u16;
    let symtab = (0..e_shnum)
        .find(|&i| sh_type(i) == SHT_SYMTAB)
        .expect(".symtab present when a versioned import resolves");
    let (sym_off, sym_size) = (sh_offset(symtab), sh_size(symtab));
    let str_off = sh_offset(sh_link(symtab));
    let sym_name = |noff: u32| -> String {
        let start = str_off + noff as usize;
        let len = bytes[start..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8_lossy(&bytes[start..start + len]).into_owned()
    };
    let mut saw_main = false;
    let mut p = sym_off;
    while p + 24 <= sym_off + sym_size {
        let st_name = rd_u32(p);
        let st_shndx = rd_u16(p + 6);
        if sym_name(st_name) == "main" {
            saw_main = true;
            assert_eq!(st_shndx, text_idx, "`main` st_shndx must name .text");
        }
        p += 24;
    }
    assert!(saw_main, "`main` must appear in the PLT .symtab");
}

/// Post-call sub-word extension on the libc return register.
/// See the matching test in `super::native::atoi_negative_sign_extends`.
/// The x86_64 ELF backend uses `movsxd` for `Sign32`; glibc
/// happens to zero the upper bits today but the contract isn't
/// binding.
#[test]
fn atoi_negative_sign_extends() {
    let outcome = build_and_run_fixture("atoi_negative.c");
    assert!(
        matches!(outcome, RunOutcome::Exit(0)),
        "atoi('-17') should sign-extend to -1 in i64, got {outcome:?}"
    );
}

#[test]
fn fixture_parity_native_optimized() {
    let opts = NativeOptions::new().with_optimize();
    let failures = super::parity_failures(NATIVE_ELF_X64_FIXTURES, |name, expected| {
        let outcome = build_and_run_fixture_with_options(name, opts, "-O");
        (!outcome.matches(*expected))
            .then(|| format!("{name} (-O): expected exit {expected}, got {outcome:?}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} ELF/x64 fixtures regressed under -O:\n  {}",
        failures.len(),
        NATIVE_ELF_X64_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// A `%c` RIP-relative operand whose `i`-class value arrives through an
/// always_inline helper's parameter resolves only under -O: the inliner
/// relocates the parameter cell into the caller and store-forwarding
/// carries the address into the asm input capture. gcc likewise
/// rejects the shape at -O0, so no -O0 parity entry exists.
#[test]
fn riprel_param_fixture_runs_under_optimize() {
    let outcome = build_and_run_fixture_with_options(
        "inline_asm_x64_riprel_param.c",
        NativeOptions::new().with_optimize(),
        "-O",
    );
    assert!(
        matches!(outcome, RunOutcome::Exit(42)),
        "expected exit 42, got {outcome:?}"
    );
}

// ---- Standalone tests for fixtures that need argv / env / CWD
//      setup the parity harness can't provide. ----

#[test]
fn file_io_natively() {
    // The fixture opens `test_dummy.txt` relative to the CWD, so the
    // binary runs in a per-process directory holding that file.
    let cwd = super::unique_temp_path("badc-elf64-test", "file_io-cwd", "");
    std::fs::create_dir_all(&cwd).unwrap();
    std::fs::write(cwd.join("test_dummy.txt"), "1234567890").unwrap();

    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("file_io.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile file_io.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf64-test", "file_io", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = (|| {
        for attempt in 0..10 {
            match Command::new(&bin_path).current_dir(&cwd).output() {
                Ok(o) => return Ok(o),
                Err(e) if e.raw_os_error() == Some(26) => {
                    std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                }
                Err(e) => return Err(e),
            }
        }
        Command::new(&bin_path).current_dir(&cwd).output()
    })()
    .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    let _ = std::fs::remove_dir_all(&cwd);
    assert_eq!(output.status.code(), Some(0));
}

#[test]
fn getenv_value_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("getenv_value.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src)
        .compile()
        .expect("compile getenv_value.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf64-test", "getenv", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = (|| {
        for attempt in 0..10 {
            match Command::new(&bin_path)
                .env("C4RS_TEST_GETENV", "Vox")
                .output()
            {
                Ok(o) => return Ok(o),
                Err(e) if e.raw_os_error() == Some(26) => {
                    std::thread::sleep(std::time::Duration::from_millis(10 * (attempt + 1)));
                }
                Err(e) => return Err(e),
            }
        }
        Command::new(&bin_path)
            .env("C4RS_TEST_GETENV", "Vox")
            .output()
    })()
    .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(output.status.code(), Some('V' as i32));
}

#[test]
fn original_c4_compiles_and_runs_hello_natively() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).unwrap();
    let program = Compiler::new(src).compile().expect("compile c4.c");
    let bytes = emit_native(&program, Target::LinuxX64).expect("emit_native");
    let bin_path = super::unique_temp_path("badc-elf64-test", "c4", ".bin");
    std::fs::write(&bin_path, &bytes).unwrap();
    set_executable(&bin_path);

    let output = exec_with_retry_args(
        &bin_path,
        &[concat!(
            env!("CARGO_MANIFEST_DIR"),
            "/tests/fixtures/c/c4_selfhost_hello.c"
        )],
    )
    .expect("exec native binary");
    let _ = std::fs::remove_file(&bin_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "c4 self-host failed:\nSTDOUT:\n{}\nSTDERR:\n{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
}

/// Cross-unit `extern _Thread_local` on Linux/x86_64. Two translation
/// units each define TLS storage; `main` reads its own and the other
/// unit's thread-locals both directly (extern) and through the defining
/// unit's accessors (local), then mutates one and re-reads it. Exercises
/// the merged-TLS layout, the `NT_BADC_ELF_TPOFF` note round-trip, the
/// PT_TLS alignment, and the branch-relaxation fixup bookkeeping (a TLS
/// access gated by a prior conditional read). `main` returns a bitmask
/// of failures, so exit 0 means every access resolved correctly.
#[test]
fn cross_unit_thread_local() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "\
_Thread_local int g_a = 11;\n\
_Thread_local int g_b = 22;\n\
int read_a(void) { return g_a; }\n\
int read_b(void) { return g_b; }\n\
void set_a(int v) { g_a = v; }\n";

    const UNIT_B: &str = "\
extern _Thread_local int g_a;\n\
extern _Thread_local int g_b;\n\
_Thread_local int g_c = 33;\n\
int read_a(void); int read_b(void); void set_a(int);\n\
int main(void) {\n\
    int f = 0;\n\
    if (g_a != 11) f |= 1;\n\
    if (g_b != 22) f |= 2;\n\
    if (g_c != 33) f |= 4;\n\
    if (read_a() != 11) f |= 8;\n\
    if (read_b() != 22) f |= 16;\n\
    set_a(99);\n\
    if (g_a != 99) f |= 32;\n\
    if (read_a() != 99) f |= 64;\n\
    return f;\n\
}\n";

    // Both units compile as relocatable objects (`-c` semantics:
    // no entry-point synthesis); the runtime supplies startup and calls
    // `main` by name. `programs[0]` (UNIT_B) names the entry.
    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf64-tls2", "cross_unit_tls", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "cross-unit thread-local mismatch (failure bitmask in exit code)"
    );
}

/// An inline candidate that returns the address of an extern (cross-TU)
/// data object must keep that symbol reference after the splice. The
/// optimizer inlines `get_shared` into `main`; the spliced `ImmData`
/// has to resolve to `shared_value`, not the caller's local data base.
#[test]
fn cross_unit_inlined_extern_data_ref() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "long shared_value = 0x12345678;\n";

    const UNIT_B: &str = "\
extern long shared_value;\n\
static long *get_shared(void) { return &shared_value; }\n\
long read_shared(void) { long *p = get_shared(); return *p; }\n\
int main(void) { return (read_shared() == 0x12345678) ? 0 : 1; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf64-inl-extref", "cross_unit_inline_extref", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "inlined extern-data reference resolved to the wrong symbol under -O"
    );
}

/// Two distinct extern data symbols both lower to `Inst::ImmData(0)`.
/// The cross-block ImmData dedup must not coalesce them: each binds to a
/// different cross-TU symbol. `sym_a` is referenced in the entry block
/// (the dedup canonical for the key) and `sym_b` only in a later block;
/// coalescing makes the later reference read `sym_a`.
#[test]
fn cross_unit_dedup_imm_distinct_symbols() {
    use crate::{CompileOptions, Program};

    const UNIT_A: &str = "long sym_a = 100;\nlong sym_b = 7;\n";

    const UNIT_B: &str = "\
extern long sym_a;\n\
extern long sym_b;\n\
long combine(int c) { long r = sym_a; if (c) { r += sym_b; } return r; }\n\
int main(void) { return (combine(1) == 107) ? 0 : 1; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_b = compile(UNIT_B);
    let prog_a = compile(UNIT_A);

    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_b, &prog_a],
        Target::LinuxX64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf64-dedup-imm", "cross_unit_dedup_imm", ".bin");
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "distinct extern data symbols were coalesced by the ImmData dedup under -O"
    );
}

/// A foreign (system-cc) caller that keeps a live value in r13 across a
/// call into a badc-compiled callee must find it intact on return. r13
/// is callee-saved under System V AMD64. badc reserves r10 / r11 (both
/// caller-saved) as its fixed scratch, so r13 is an ordinary
/// callee-saved allocation target: the prologue / epilogue save and
/// restore it exactly when the allocator colors a value into it, via the
/// same callee-save loop that covers rbx / r12 / r14 / r15. The badc
/// callee here computes `x + <large immediate>`; whether r13 ends up
/// untouched or holding an allocated value, a miss in the save loop would
/// corrupt the caller's r13. The cc caller pins a sentinel in r13 across
/// the call via inline asm and checks it survives. Links a badc
/// relocatable object with a cc-compiled `main` through the system
/// `-mno-sse` (`NativeOptions::no_fp_regs`): a System V variadic callee's
/// prologue normally spills xmm0..xmm7 behind a `test al, al` gate.
/// Freestanding x86_64 environments fault on any XMM access and their
/// callers do not maintain the `al` convention, so under `no_fp_regs` the
/// object must contain neither the `movsd` stores (f2 0f 11) nor the
/// gate (84 c0 0f 84); the default object contains both.
#[test]
fn variadic_prologue_no_fp_regs_omits_xmm_save() {
    use crate::{CompileOptions, OutputKind};

    const SRC: &str = "int sum(int n, ...) {\n\
         \t__builtin_va_list ap;\n\
         \t__builtin_va_start(ap, n);\n\
         \tint t = 0;\n\
         \tfor (int i = 0; i < n; i++) t += __builtin_va_arg(ap, int);\n\
         \t__builtin_va_end(ap);\n\
         \treturn t;\n\
         }\n";
    let emit = |no_fp_regs: bool| -> Vec<u8> {
        let prog = Compiler::with_options(
            SRC.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile variadic callee: {e}"));
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            no_fp_regs,
            ..NativeOptions::default()
        };
        emit_native_with_options(&prog, Target::LinuxX64, opts)
            .unwrap_or_else(|e| panic!("emit object (no_fp_regs={no_fp_regs}): {e}"))
    };
    let contains = |hay: &[u8], needle: &[u8]| hay.windows(needle.len()).any(|w| w == needle);

    let default_obj = emit(false);
    assert!(
        contains(&default_obj, &[0xf2, 0x0f, 0x11]),
        "default object lacks the movsd XMM spill"
    );
    assert!(
        contains(&default_obj, &[0x84, 0xc0, 0x0f, 0x84]),
        "default object lacks the al gate"
    );
    let no_fp_regs_obj = emit(true);
    assert!(
        !contains(&no_fp_regs_obj, &[0xf2, 0x0f, 0x11]),
        "no_fp_regs object still contains movsd XMM stores"
    );
    assert!(
        !contains(&no_fp_regs_obj, &[0x84, 0xc0, 0x0f, 0x84]),
        "no_fp_regs object still contains the al gate"
    );
}

/// driver, so it exercises the real ABI boundary the c5-to-c5 lanes
/// cannot.
#[test]
fn foreign_caller_r13_preserved() {
    use crate::{CompileOptions, OutputKind};

    // Locate a system C driver; without one the ABI boundary can't be
    // built, so skip rather than fail (the demo lanes cover it
    // where a compiler is present).
    let cc = ["cc", "gcc", "clang"].into_iter().find(|c| {
        Command::new(c)
            .arg("--version")
            .output()
            .map(|o| o.status.success())
            .unwrap_or(false)
    });
    let Some(cc) = cc else {
        eprintln!("skipping foreign_caller_r13_preserved: no system C driver (cc/gcc/clang)");
        return;
    };

    const CALLEE: &str = "long badc_cb(long x) { return x + 0x1234567890ABL; }\n";
    let prog = Compiler::with_options(
        CALLEE.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile callee: {e}"));
    let reloc = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let obj = emit_native_with_options(&prog, Target::LinuxX64, reloc)
        .unwrap_or_else(|e| panic!("emit callee object: {e}"));

    let obj_path = super::unique_temp_path("badc-elf64-r13", "callee_obj", ".bin");
    let main_path = super::unique_temp_path("badc-elf64-r13", "caller_main", ".c");
    let exe_path = super::unique_temp_path("badc-elf64-r13", "r13_exe", ".bin");
    std::fs::write(&obj_path, &obj).expect("write callee object");
    std::fs::write(
        &main_path,
        "extern long badc_cb(long);\n\
         int main(void) {\n\
         \tlong out;\n\
         \t__asm__ volatile(\"movq $0x1122334455667788, %%r13\" ::: \"r13\");\n\
         \tlong r = badc_cb(5);\n\
         \t__asm__ volatile(\"movq %%r13, %0\" : \"=r\"(out));\n\
         \treturn (out == 0x1122334455667788L && r == 5 + 0x1234567890ABL) ? 0 : 1;\n\
         }\n",
    )
    .expect("write caller main");

    let status = Command::new(cc)
        .arg(&main_path)
        .arg(&obj_path)
        .arg("-o")
        .arg(&exe_path)
        .status()
        .expect("invoke system C driver");
    assert!(
        status.success(),
        "system C driver failed to link badc object"
    );

    set_executable(&exe_path);
    let output = exec_with_retry(&exe_path).expect("run linked binary");
    let _ = std::fs::remove_file(&obj_path);
    let _ = std::fs::remove_file(&main_path);
    let _ = std::fs::remove_file(&exe_path);
    assert_eq!(
        output.status.code(),
        Some(0),
        "foreign caller's r13 was clobbered by the badc callee (callee-save violation)"
    );
}

/// A badc caller into a foreign (cc-compiled) callee that returns a 24-byte
/// aggregate by value. System V AMD64 3.2.3 returns an aggregate larger than
/// 16 bytes (MEMORY class) through a hidden pointer the caller passes in the
/// first integer-argument register (rdi); the callee writes the result there
/// and returns the pointer in rax. badc must allocate the result buffer and
/// pass its address ahead of the declared arguments. Links a badc executable
/// against a cc-built shared object, exercising the real ABI boundary the
/// c5-to-c5 struct-return lanes cannot.
#[test]
fn badc_caller_oversize_struct_return_from_foreign() {
    use crate::CompileOptions;

    let cc = ["cc", "gcc", "clang"].into_iter().find(|c| {
        Command::new(c)
            .arg("--version")
            .output()
            .map(|o| o.status.success())
            .unwrap_or(false)
    });
    let Some(cc) = cc else {
        eprintln!(
            "skipping badc_caller_oversize_struct_return_from_foreign: no system C driver \
             (cc/gcc/clang)"
        );
        return;
    };

    let dir = super::unique_temp_path("badc-elf64-outptr", "dir", "");
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let callee_c = dir.join("callee.c");
    let so_path = dir.join("libbig24.so");
    std::fs::write(
        &callee_c,
        "typedef struct { long a; long b; long c; } Big24;\n\
         Big24 make_big24(long x) { Big24 r; r.a = x; r.b = x + 1; r.c = x + 2; return r; }\n",
    )
    .expect("write callee source");
    let st = Command::new(cc)
        .args(["-shared", "-fPIC", "-o"])
        .arg(&so_path)
        .arg(&callee_c)
        .status()
        .expect("invoke system C driver");
    assert!(st.success(), "cc failed to build the shared object");

    let caller_src = format!(
        "#pragma dylib(ext, \"{}\")\n\
         #pragma binding(ext::make_big24, \"make_big24\")\n\
         typedef struct {{ long a; long b; long c; }} Big24;\n\
         Big24 make_big24(long x);\n\
         int main(void) {{\n\
         \tBig24 r = make_big24(10);\n\
         \treturn (r.a == 10 && r.b == 11 && r.c == 12) ? 0 : 1;\n\
         }}\n",
        so_path.display()
    );
    let prog = Compiler::with_options(caller_src, Target::LinuxX64, CompileOptions::default())
        .compile()
        .unwrap_or_else(|e| panic!("compile caller: {e}"));
    let exe =
        emit_native(&prog, Target::LinuxX64).unwrap_or_else(|e| panic!("emit caller exe: {e}"));
    let exe_path = dir.join("caller_exe");
    std::fs::write(&exe_path, &exe).expect("write caller exe");
    set_executable(&exe_path);

    // ETXTBSY: the image was just written, and a concurrent test in
    // this process may still hold a writable handle to its own output.
    let output = exec_with_retry_cmd(|| {
        let mut c = Command::new(&exe_path);
        c.env("LD_LIBRARY_PATH", &dir);
        c
    })
    .expect("run linked binary");
    let _ = std::fs::remove_dir_all(&dir);
    assert_eq!(
        output.status.code(),
        Some(0),
        "badc mis-returned a > 16-byte aggregate from a foreign callee (System V sret ABI)"
    );
}

/// A weak function definition is overridden by a strong definition in
/// a sibling unit (ELF STB_WEAK semantics), with no
/// multiple-definition error; calls resolve to the strong body.
#[test]
fn weak_definition_overridden_by_strong_at_runtime() {
    use crate::{CompileOptions, Program};

    const WEAK_UNIT: &str = "\
int pick(void) __attribute__((weak));\n\
int pick(void) { return 1; }\n\
int main(void) { return pick(); }\n";
    const STRONG_UNIT: &str = "int pick(void) { return 2; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_main = compile(WEAK_UNIT);
    let prog_strong = compile(STRONG_UNIT);
    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_main, &prog_strong],
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf64-weak", "weak_override", ".bin");
    {
        use std::io::Write;
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(2),
        "the strong definition must win over the weak one"
    );
}

/// The same override under `-O`: the weak body is small enough to inline,
/// but a weak definition is replaceable, so the call has to stay out of
/// line for the linker to bind it to the strong definition. gcc and clang
/// keep the call for the same reason.
#[test]
fn weak_definition_overridden_by_strong_under_optimize() {
    use crate::{CompileOptions, Program};

    const WEAK_UNIT: &str = "\
int pick(void) __attribute__((weak));\n\
int pick(void) { return 1; }\n\
int main(void) { return pick(); }\n";
    const STRONG_UNIT: &str = "int pick(void) { return 2; }\n";

    let compile = |src: &str| -> Program {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("compile: {e}"))
    };
    let prog_main = compile(WEAK_UNIT);
    let prog_strong = compile(STRONG_UNIT);
    let bytes = super::link_executable_with_runtime_multi(
        &[&prog_main, &prog_strong],
        Target::LinuxX64,
        NativeOptions::default().with_optimize(),
    )
    .unwrap_or_else(|e| panic!("link: {e}"));

    let path = super::unique_temp_path("badc-elf64-weak", "weak_override_opt", ".bin");
    {
        use std::io::Write;
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
        f.sync_all().expect("sync temp file");
    }
    set_executable(&path);
    let output = exec_with_retry(&path).expect("exec produced binary");
    let _ = std::fs::remove_file(&path);
    assert_eq!(
        output.status.code(),
        Some(2),
        "the inliner must not splice a weak body: the strong definition wins"
    );
}

/// An undefined weak function reference resolves to address 0; the
/// `if (fn) fn();` guard therefore skips the call.
#[test]
fn undefined_weak_function_guard() {
    let code = build_and_run(
        "extern void optional_hook(void) __attribute__((weak));\n\
         int main(void) {\n\
             if (optional_hook) {\n\
                 optional_hook();\n\
                 return 1;\n\
             }\n\
             return 0;\n\
         }\n",
        "undef_weak_guard",
    );
    assert_eq!(code, 0, "undefined weak must read as a null pointer");
}

/// The kernel `symbol_get(x)` idiom: a block-scope `extern typeof(x) x
/// __attribute__((weak, visibility("hidden")))` redeclaration takes the
/// address of an already-known name. Undefined, it must read as null so the
/// guard skips the call. Locks the block-scope carry of weak+hidden that a
/// file-scope `__attribute__((weak))` already exercised above.
#[test]
fn symbol_get_weak_hidden_undef_reads_null() {
    let code = build_and_run(
        "extern void optional_hook(void);\n\
         #define symbol_get(x) \
         ({ extern typeof(x) x __attribute__((weak, visibility(\"hidden\"))); &(x); })\n\
         int main(void) {\n\
             void (*fn)(void) = symbol_get(optional_hook);\n\
             if (fn) {\n\
                 fn();\n\
                 return 1;\n\
             }\n\
             return 0;\n\
         }\n",
        "symbol_get_weak_hidden",
    );
    assert_eq!(code, 0, "weak hidden undefined address must read as null");
}

/// The weak-hidden `symbol_get` guard again, under `-O`: the address
/// comparison folds must leave the weak-undefined case to the link,
/// which resolves it to null.
#[test]
fn symbol_get_weak_hidden_undef_reads_null_optimized() {
    let outcome = build_and_run_outcome_with_options(
        "extern void optional_hook(void);\n\
         #define symbol_get(x) \
         ({ extern typeof(x) x __attribute__((weak, visibility(\"hidden\"))); &(x); })\n\
         int main(void) {\n\
             void (*fn)(void) = symbol_get(optional_hook);\n\
             if (fn) {\n\
                 fn();\n\
                 return 1;\n\
             }\n\
             return 0;\n\
         }\n",
        "symbol_get_weak_hidden_opt",
        NativeOptions::new().with_optimize(),
    );
    assert!(
        outcome.matches(0),
        "weak hidden undefined address must read as null under -O, got {outcome:?}"
    );
}
