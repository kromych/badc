//! x86_64 frame-shape checks over the badc binary's output: the return
//! address stays where the caller pushed it, so every instruction of a
//! function has it at a fixed offset from the CFA. The prologue is
//! `push rbp; mov rbp, rsp; sub rsp, N` behind the entry instructions,
//! the epilogue `leave` / `pop rbp` directly ahead of the `ret` or the
//! tail jump, and a frameless leaf touches rsp only through balanced
//! pushes. The DWARF check reads the rules the linked image carries.
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

/// Disassemble `obj` with the first of `llvm-objdump` / `objdump` on PATH
/// that decodes it. `None` when neither is installed or neither decodes
/// the object's format.
fn disassemble(obj: &Path) -> Option<String> {
    for tool in ["llvm-objdump", "objdump"] {
        let Ok(out) = Command::new(tool)
            .args(["-d", "--no-show-raw-insn"])
            .arg(obj)
            .output()
        else {
            continue;
        };
        let text = String::from_utf8_lossy(&out.stdout).into_owned();
        if out.status.success() && text.contains("<stack7>:") {
            return Some(text);
        }
    }
    None
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
