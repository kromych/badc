//! Frame-shape checks over the badc binary's output: the return address
//! stays where the caller left it, so every instruction of a function has
//! it at a fixed offset from the CFA, and the parameters are homed inside
//! the frame rather than above it.
//!
//! x86_64: the prologue is `push rbp; mov rbp, rsp; sub rsp, N` behind the
//! entry instructions, the epilogue `leave` / `pop rbp` directly ahead of
//! the `ret` or the tail jump, and a frameless leaf touches rsp only
//! through balanced pushes. The DWARF check reads the rules the linked
//! image carries.
//!
//! aarch64: nothing ahead of the `stp x29, x30` frame record names an
//! argument register or moves sp by a `sub`, and the epilogue drops the
//! frame before restoring the record.
//!
//! The disassembler is `llvm-objdump`, then `objdump`, on PATH; the CFI
//! dumper `dwarfdump`, then `llvm-dwarfdump`. A missing tool skips the
//! check that needs it.

use std::path::{Path, PathBuf};
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn tempdir(name: &str) -> PathBuf {
    let mut p = std::env::temp_dir();
    p.push(format!("badc-frame-test-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&p);
    std::fs::create_dir_all(&p).expect("create temp dir");
    p
}

fn run(cmd: &mut Command, what: &str) -> std::process::Output {
    let out = cmd.output().expect(what);
    if !out.status.success() {
        panic!(
            "{what} failed: status={} stdout={:?} stderr={:?}",
            out.status,
            String::from_utf8_lossy(&out.stdout),
            String::from_utf8_lossy(&out.stderr)
        );
    }
    out
}

/// Every parameter shape the x86_64 prologue homes: register scalars in
/// both banks, stack-passed scalars, a register-passed and a memory-passed
/// aggregate, an out-pointer return, a variadic callee, an alloca frame,
/// an address-taken parameter, an assigned parameter, a leaf.
const SHAPES: &str = r#"
#include <stdarg.h>
struct Small { long a, b; };
struct Big { long a, b, c, d; };
int leaf(int a, int b) { return a + b; }
long regs(long a, long b, double d, float f, char c) { return a + b + (long)d + (long)f + c; }
long stack7(long a, long b, long c, long d, long e, long f, long g, long h) {
    return a + b + c + d + e + f + g + h;
}
long *addr(long a) { static long *p; p = &a; return p; }
long small(struct Small s, long x) { return s.a + s.b + x; }
long big(long x, struct Big s, long y) { return x + s.a + s.b + s.c + s.d + y; }
struct Big ret_big(long x, long y) { struct Big s; s.a = x; s.b = y; s.c = x + y; s.d = 0; return s; }
long vsum(int n, ...) {
    va_list ap; long t = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) t += va_arg(ap, long);
    va_end(ap);
    return t;
}
long dyn(long n, long v) { long *p = __builtin_alloca(n * 8); p[0] = v; return p[0] + n; }
long modify(long a, long b) { a += b; b = a * 2; return a + b; }
long tail(long a, long b) { return regs(a, b, 1.0, 2.0f, 3); }
int main(void) {
    struct Small s = {1, 2};
    struct Big g = {1, 2, 3, 4};
    long r = leaf(1, 2) + regs(1, 2, 3.0, 4.0f, 5) + stack7(1, 2, 3, 4, 5, 6, 7, 8) + *addr(9)
        + small(s, 3) + big(1, g, 2) + ret_big(3, 4).c + vsum(3, 1L, 2L, 3L) + dyn(2, 5)
        + modify(1, 2) + tail(1, 2);
    return r == 1 + 2 + 15 + 36 + 9 + 6 + 13 + 7 + 6 + 7 + 9 + 3 + 6 ? 0 : 1;
}
"#;

/// Every parameter shape the aarch64 prologue homes: register scalars in
/// both banks, parameters past the eight argument registers, an
/// address-taken parameter, aggregates in registers and on the stack, an
/// out-pointer return, a variadic callee, an alloca frame, a leaf.
const A64_SHAPES: &str = r#"
#include <stdarg.h>
struct Small { long a, b; };
struct Big { long a, b, c, d; };
int leaf(int a, int b) { return a + b; }
long regs(long a, long b, double d, float f, char c) { return a + b + (long)d + (long)f + c; }
long stack10(long a, long b, long c, long d, long e, long f, long g, long h, long i, long j) {
    return a + b + c + d + e + f + g + h + i + j;
}
long *addr(long a) { static long *p; p = &a; return p; }
long small(struct Small s, long x) { return s.a + s.b + x; }
long big(long x, struct Big s, long y) { return x + s.a + s.b + s.c + s.d + y; }
struct Big ret_big(long x, long y) { struct Big s; s.a = x; s.b = y; s.c = x + y; s.d = 0; return s; }
long vsum(int n, ...) {
    va_list ap; long t = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++) t += va_arg(ap, long);
    va_end(ap);
    return t;
}
long dyn(long n, long v) { long *p = __builtin_alloca(n * 8); p[0] = v; return p[0] + n; }
long modify(long a, long b) { a += b; b = a * 2; return a + b; }
int main(void) {
    struct Small s = {1, 2};
    struct Big g = {1, 2, 3, 4};
    long r = leaf(1, 2) + regs(1, 2, 3.0, 4.0f, 5)
        + stack10(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) + *addr(9)
        + small(s, 3) + big(1, g, 2) + ret_big(3, 4).c + vsum(3, 1L, 2L, 3L) + dyn(2, 5)
        + modify(1, 2);
    return r == 1 + 2 + 15 + 55 + 9 + 6 + 13 + 7 + 6 + 7 + 9 ? 0 : 1;
}
"#;

/// Disassemble `obj` with the first of `llvm-objdump` / `objdump` on PATH
/// that decodes it. `anchor` is a function the output must name, so a tool
/// that cannot decode the object's format is passed over. `None` when
/// neither is installed or neither decodes it.
fn disassemble_named(obj: &Path, anchor: &str) -> Option<String> {
    for tool in ["llvm-objdump", "objdump"] {
        let Ok(out) = Command::new(tool)
            .args(["-d", "--no-show-raw-insn"])
            .arg(obj)
            .output()
        else {
            continue;
        };
        let text = String::from_utf8_lossy(&out.stdout).into_owned();
        if out.status.success() && text.contains(anchor) {
            return Some(text);
        }
    }
    None
}

fn disassemble(obj: &Path) -> Option<String> {
    disassemble_named(obj, "<stack7>:")
}

/// `(name, [(mnemonic, operands)])` per function of a disassembly.
fn functions(dis: &str) -> Vec<(String, Vec<(String, String)>)> {
    let mut out: Vec<(String, Vec<(String, String)>)> = Vec::new();
    for line in dis.lines() {
        if let Some(rest) = line.split_once(" <").map(|(_, r)| r)
            && let Some(name) = rest.strip_suffix(">:")
        {
            out.push((name.to_string(), Vec::new()));
            continue;
        }
        let Some((addr, body)) = line.split_once(':') else {
            continue;
        };
        let addr = addr.trim();
        if addr.is_empty() || !addr.bytes().all(|b| b.is_ascii_hexdigit()) {
            continue;
        }
        let body = body.trim();
        let (mnemonic, operands) = body.split_once(char::is_whitespace).unwrap_or((body, ""));
        if let Some((_, insts)) = out.last_mut() {
            insts.push((mnemonic.to_string(), operands.trim().to_string()));
        }
    }
    out
}

fn moves_rsp(mnemonic: &str, operands: &str) -> bool {
    (mnemonic.starts_with("sub") || mnemonic.starts_with("add")) && operands.ends_with("%rsp")
}

/// The frame rules over one function's instructions.
fn check_function(name: &str, insts: &[(String, String)], what: &str) {
    let frame_at = insts
        .iter()
        .position(|(m, o)| m.starts_with("push") && o == "%rbp");
    match frame_at {
        Some(k) => {
            for (m, o) in &insts[..k] {
                assert!(
                    m == "endbr64" || m.starts_with("nop") || m.starts_with("call"),
                    "{what}: {name}: `{m} {o}` ahead of `push %rbp`"
                );
            }
        }
        None => {
            let first_push = insts.iter().position(|(m, _)| m.starts_with("push"));
            for (j, (m, o)) in insts.iter().enumerate() {
                assert!(
                    !(m.starts_with("pop") && first_push.is_none_or(|p| j < p)),
                    "{what}: {name}: `{m} {o}` pops with nothing pushed"
                );
                assert!(
                    !moves_rsp(m, o) && m != "leave",
                    "{what}: {name}: `{m} {o}` moves rsp without a frame"
                );
            }
        }
    }
    for (j, (m, o)) in insts.iter().enumerate() {
        if m == "leave" || (m.starts_with("pop") && o == "%rbp") {
            let next = insts.get(j + 1).map(|(m, _)| m.as_str()).unwrap_or("");
            assert!(
                next.starts_with("ret") || next.starts_with("jmp"),
                "{what}: {name}: `{next}` between the frame teardown and the return"
            );
        }
    }
}

#[test]
fn x86_64_prologue_and_epilogue_keep_the_return_address_in_place() {
    let dir = tempdir("shape");
    let src = dir.join("shapes.c");
    std::fs::write(&src, SHAPES).expect("write source");
    let mut checked = 0;
    for target in ["linux-x64", "windows-x64"] {
        for opt in [&[][..], &["-O"][..]] {
            let obj = dir.join(format!("shapes-{target}{}.o", opt.join("")));
            run(
                Command::new(badc())
                    .arg(format!("--target={target}"))
                    .args(opt)
                    .arg("-c")
                    .arg("-o")
                    .arg(&obj)
                    .arg(&src),
                "compile shapes",
            );
            let Some(dis) = disassemble(&obj) else {
                eprintln!("no disassembler for {target} on PATH -- skipping");
                return;
            };
            let what = format!("{target} {}", opt.join(" "));
            let funcs = functions(&dis);
            assert!(funcs.len() >= 12, "{what}: {} functions found", funcs.len());
            for (name, insts) in &funcs {
                check_function(name, insts, &what);
            }
            // The stack-passed parameters are read where the caller left
            // them, above the return address.
            let stack7 = &funcs.iter().find(|(n, _)| n == "stack7").unwrap().1;
            let incoming = if target == "linux-x64" {
                "0x18(%rbp)"
            } else {
                "0x48(%rbp)"
            };
            assert!(
                stack7.iter().any(|(_, o)| o.starts_with(incoming)),
                "{what}: stack7 does not read its last parameter at {incoming}"
            );
            checked += 1;
        }
    }
    assert_eq!(checked, 4);
    let _ = std::fs::remove_dir_all(&dir);
}

/// Whether `operands` names an argument register. The parameter homes are
/// the only reason an aarch64 prologue would name one, and they belong
/// inside the frame; `x8` carries the indirect-result pointer, which is
/// stored into a body local.
fn names_arg_reg(operands: &str) -> bool {
    operands
        .split(|c: char| !c.is_ascii_alphanumeric())
        .any(|t| {
            let Some(n) = t
                .strip_prefix(['x', 'w', 'd', 's', 'q', 'v'])
                .and_then(|r| r.parse::<u32>().ok())
            else {
                return false;
            };
            n < 8 && t.len() == 2
        })
}

#[test]
fn aarch64_homes_the_parameters_inside_the_frame() {
    let dir = tempdir("a64shape");
    let src = dir.join("shapes.c");
    std::fs::write(&src, A64_SHAPES).expect("write source");
    let mut checked = 0;
    for target in ["linux-aarch64", "macos-aarch64", "windows-arm64"] {
        for opt in [&[][..], &["-O"][..]] {
            let obj = dir.join(format!("shapes-{target}{}.o", opt.join("")));
            run(
                Command::new(badc())
                    .arg(format!("--target={target}"))
                    .args(opt)
                    .arg("-c")
                    .arg("-o")
                    .arg(&obj)
                    .arg(&src),
                "compile shapes",
            );
            let Some(dis) = disassemble_named(&obj, "stack10>:") else {
                eprintln!("no disassembler for {target} on PATH -- skipping");
                return;
            };
            let what = format!("{target} {}", opt.join(" "));
            let funcs = functions(&dis);
            assert!(funcs.len() >= 11, "{what}: {} functions found", funcs.len());
            for (name, insts) in &funcs {
                // A variadic callee reserves its register save area above
                // the frame record, where the cursor `va_list` walks it and
                // the caller's stack arguments as one region.
                if name.trim_start_matches('_') == "vsum" {
                    continue;
                }
                check_a64_function(name, insts, &what);
            }
            // The parameters past the argument registers are read where the
            // caller left them, above the frame record.
            let stack10 = &funcs
                .iter()
                .find(|(n, _)| n.trim_start_matches('_') == "stack10")
                .unwrap()
                .1;
            for incoming in ["x29, #0x10", "x29, #0x18"] {
                assert!(
                    stack10.iter().any(|(_, o)| o.contains(incoming)),
                    "{what}: stack10 does not read a parameter at [{incoming}]"
                );
            }
            checked += 1;
        }
    }
    assert_eq!(checked, 6);
    let _ = std::fs::remove_dir_all(&dir);
}

/// The aarch64 frame rules over one function's instructions: the frame
/// record is the first thing the prologue writes bar the callee-saved
/// registers it folds into the same allocation, and the epilogue drops the
/// frame before restoring the record.
fn check_a64_function(name: &str, insts: &[(String, String)], what: &str) {
    let record_at = insts
        .iter()
        .position(|(m, o)| m.starts_with("stp") && o.starts_with("x29, x30"));
    // A function with no record is a full leaf: it never touches sp.
    let Some(k) = record_at else {
        for (m, o) in insts {
            assert!(
                !o.starts_with("sp,") && !o.contains("[sp"),
                "{what}: {name}: `{m} {o}` moves sp with no frame record"
            );
        }
        return;
    };
    for (m, o) in &insts[..k] {
        assert!(
            !names_arg_reg(o),
            "{what}: {name}: `{m} {o}` homes a parameter ahead of the frame record"
        );
        assert!(
            !m.starts_with("sub") || !o.starts_with("sp"),
            "{what}: {name}: `{m} {o}` reserves stack ahead of the frame record"
        );
    }
    let (m, o) = insts
        .get(k + 1)
        .expect("an instruction after the frame record");
    assert!(
        (m == "mov" || m == "add") && o.starts_with("x29, sp"),
        "{what}: {name}: `{m} {o}` follows the frame record instead of setting fp"
    );
    // Between restoring the record and leaving the function nothing may
    // drop stack: the frame is already gone.
    for (j, (m, o)) in insts.iter().enumerate() {
        if !m.starts_with("ldp") || !o.starts_with("x29, x30") {
            continue;
        }
        for (m2, o2) in &insts[j + 1..] {
            if m2.starts_with("ret") || m2 == "b" || m2.starts_with("br") {
                break;
            }
            assert!(
                !m2.starts_with("add") || !o2.starts_with("sp,"),
                "{what}: {name}: `{m2} {o2}` drops stack after the frame record is restored"
            );
        }
    }
}

/// `--debug-frame` text of `path` from `dwarfdump` or `llvm-dwarfdump`.
fn debug_frame(path: &Path) -> Option<String> {
    for tool in ["dwarfdump", "llvm-dwarfdump"] {
        if let Ok(out) = Command::new(tool).arg("--debug-frame").arg(path).output()
            && out.status.success()
        {
            let text = String::from_utf8_lossy(&out.stdout).into_owned();
            if text.contains("FDE") {
                return Some(text);
            }
        }
    }
    None
}

#[test]
fn x86_64_debug_frame_follows_each_prologue_instruction() {
    let dir = tempdir("cfi");
    let src = dir.join("shapes.c");
    std::fs::write(&src, SHAPES).expect("write source");
    for opt in [&[][..], &["-O"][..]] {
        let exe = dir.join(format!("shapes{}", opt.join("")));
        run(
            Command::new(badc())
                .arg("--target=linux-x64")
                .arg("-g")
                .args(opt)
                .arg("-o")
                .arg(&exe)
                .arg(&src),
            "link shapes",
        );
        let Some(text) = debug_frame(&exe) else {
            eprintln!("no DWARF dumper on PATH -- skipping");
            return;
        };
        let what = opt.join(" ");
        let fdes = text.matches("FDE cie=").count();
        let framed = text.matches("DW_CFA_def_cfa_register: RBP").count();
        let min_framed = if opt.is_empty() { 12 } else { 6 };
        assert!(
            framed >= min_framed,
            "{what}: {framed} framed FDEs of {fdes}:\n{text}"
        );
        // Past `push rbp` the CFA moves to rsp + 16 with rbp saved below
        // it; the coarse post-prologue rule never appears.
        assert_eq!(
            text.matches("DW_CFA_def_cfa_offset: +16").count(),
            framed,
            "{what}:\n{text}"
        );
        assert_eq!(text.matches("DW_CFA_offset: RBP -16").count(), framed);
        assert!(!text.contains("DW_CFA_def_cfa: RBP"), "{what}:\n{text}");
        // A frameless leaf keeps the entry rule throughout: at -O `leaf`,
        // `regs` and `modify` have no frame.
        if !opt.is_empty() {
            assert!(
                fdes > framed + 2,
                "{what}: {framed} framed of {fdes}:\n{text}"
            );
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
}
