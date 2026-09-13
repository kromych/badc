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

mod common;
use common::TempDir;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn tempdir(name: &str) -> TempDir {
    TempDir::new(&format!("badc-frame-test-{name}"))
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
            return Some(canonical_text(&text));
        }
    }
    None
}

/// One spelling for the two places the disassemblers differ, so a check
/// that matches operand text sees the same string whichever produced it:
/// llvm-objdump writes `#0x10` where GNU objdump writes `#16`, and
/// llvm-objdump separates operands with `, ` where GNU objdump writes a
/// bare comma. Immediates become hex and every operand comma gets its
/// space.
fn canonical_text(text: &str) -> String {
    let mut out = String::with_capacity(text.len() + text.len() / 16);
    let b = hex_immediates(text);
    let bytes = b.as_bytes();
    for (i, &c) in bytes.iter().enumerate() {
        out.push(c as char);
        // A comma inside a disassembly line always separates operands.
        if c == b',' && bytes.get(i + 1).is_some_and(|n| !n.is_ascii_whitespace()) {
            out.push(' ');
        }
    }
    out
}

fn hex_immediates(text: &str) -> String {
    let b = text.as_bytes();
    let mut out = String::with_capacity(text.len());
    let mut i = 0;
    while i < b.len() {
        if b[i] != b'#' {
            out.push(b[i] as char);
            i += 1;
            continue;
        }
        let mut j = i + 1;
        let neg = b.get(j) == Some(&b'-');
        if neg {
            j += 1;
        }
        let start = j;
        while j < b.len() && b[j].is_ascii_digit() {
            j += 1;
        }
        // A hex immediate already carries `0x`; leave it and anything
        // that is not a plain decimal run alone.
        if start == j || b.get(j) == Some(&b'x') {
            out.push('#');
            i += 1;
            continue;
        }
        let v: u64 = text[start..j].parse().expect("a run of ascii digits");
        out.push('#');
        if neg {
            out.push('-');
        }
        out.push_str(&format!("0x{v:x}"));
        i = j;
    }
    out
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

/// Parameters every ABI carries in registers, read once each and neither
/// assigned to nor address-taken: the body's own entry store fills each
/// home at the declared width, so the prologue writes none of them a
/// second time at the full register width. `many` overflows the Win64
/// integer bank, which leaves two parameters read where the caller left
/// them.
const HOME_SHAPES: &str = r#"
long widths(char a, short b, int c, long d) { return (long)a + b + c + d; }
double banks(int a, double b, float c, long d) { return a + b + (double)c + d; }
long many(long a, long b, long c, long d, long e, long f) {
    return a + b + c + d + e + f;
}
"#;

/// The frame addresses `insts` stores to, in order. An aarch64 store
/// whose address the emit materialised in x16 / x17 names that register;
/// the `sub` / `add` that built it from x29 is the instruction before it,
/// so `staged` resolves the store to the key a direct `stur` produces. A
/// store relative to sp -- the frame record, the callee-saved area -- is
/// no parameter home and is left out.
fn frame_stores(insts: &[(String, String)]) -> Vec<String> {
    let mut staged: Option<(&str, String)> = None;
    let mut out: Vec<String> = Vec::new();
    for (m, o) in insts {
        let address = staged.take();
        if (m == "sub" || m == "add")
            && let Some((rd, rest)) = o.split_once(", ")
            && let Some(off) = rest.strip_prefix("x29, #")
        {
            let sign = if m == "sub" { "-" } else { "" };
            staged = Some((rd, format!("x29, #{sign}{off}")));
            continue;
        }
        if m.starts_with("mov") {
            // AT&T order puts the destination last, so a load's trailing
            // operand is a register and only a store's names memory.
            if let Some((_, dst)) = o.split_once(", ")
                && dst.contains("(%rbp")
            {
                out.push(dst.replace(",%riz", ""));
            }
            continue;
        }
        if m.starts_with("st")
            && let Some(open) = o.rfind('[')
            && let Some(close) = o[open..].find(']')
        {
            let inner = &o[open + 1..open + close];
            if inner.starts_with("x29") {
                out.push(inner.to_string());
            } else if let Some((reg, addr)) = address
                && reg == inner
            {
                out.push(addr);
            }
        }
    }
    out
}

#[test]
fn each_parameter_home_is_written_once() {
    let dir = tempdir("homes");
    let src = dir.join("homes.c");
    std::fs::write(&src, HOME_SHAPES).expect("write source");
    let mut checked = 0;
    for target in [
        "linux-x64",
        "linux-aarch64",
        "macos-aarch64",
        "windows-x64",
        "windows-arm64",
    ] {
        for opt in [&[][..], &["-O"][..]] {
            let obj = dir.join(format!("homes-{target}{}.o", opt.join("")));
            run(
                Command::new(badc())
                    .arg(format!("--target={target}"))
                    .args(opt)
                    .arg("-c")
                    .arg("-o")
                    .arg(&obj)
                    .arg(&src),
                "compile homes",
            );
            let Some(dis) = disassemble_named(&obj, "many>:") else {
                eprintln!("no disassembler for {target} on PATH -- skipping");
                return;
            };
            let what = format!("{target} {}", opt.join(" "));
            let funcs = functions(&dis);
            assert_eq!(funcs.len(), 3, "{what}: {} functions found", funcs.len());
            for (name, insts) in &funcs {
                let stores = frame_stores(insts);
                for (i, addr) in stores.iter().enumerate() {
                    assert!(
                        !stores[..i].contains(addr),
                        "{what}: {name}: writes {addr} twice: {stores:?}"
                    );
                }
                // Every register-carried parameter is homed at -O0, and
                // four of `many`'s six reach a register under every ABI.
                if opt.is_empty() && name.trim_start_matches('_') == "many" {
                    assert!(
                        stores.len() >= 4,
                        "{what}: many homes {} parameters",
                        stores.len()
                    );
                }
            }
            checked += 1;
        }
    }
    assert_eq!(checked, 10);
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
}

/// Kernel-shaped inline asm: paravirt call sites binding the stack pointer
/// (`ASM_CALL_CONSTRAINT`), a feature test through a link-time memory
/// operand beside an immediate, register outputs into locals, and the
/// self-initialised output locals of `PVOP_CALL_ARGS`.
const KERNEL_ASM: &str = r#"
struct pv_ops_t { void *pad[7]; unsigned long long (*read_msr)(unsigned int); };
extern struct pv_ops_t pv_ops;
struct cpuinfo { int pad[11]; unsigned int cap[24]; };
extern struct cpuinfo boot_cpu_data;
register unsigned long current_stack_pointer asm("rsp");
static inline unsigned long long pv_read_msr(unsigned int msr)
{
    unsigned long eax = eax, edx = edx, ecx = ecx, edi = edi, esi = esi;
    asm volatile("call *%[opptr]"
                 : "=a" (eax), "=d" (edx), "=c" (ecx), "=D" (edi), "=S" (esi),
                   "+r" (current_stack_pointer)
                 : [type] "i" (7), [opptr] "m" (pv_ops.read_msr), "D" ((unsigned long)msr)
                 : "memory", "cc", "r8", "r9", "r10", "r11");
    return ((unsigned long long)edx << 32) | (unsigned int)eax;
}
unsigned long long one(unsigned int a) { return pv_read_msr(a); }
unsigned long long eight(unsigned int a)
{
    unsigned long long v = pv_read_msr(a);
    v += pv_read_msr(a + 1); v += pv_read_msr(a + 2); v += pv_read_msr(a + 3);
    v += pv_read_msr(a + 4); v += pv_read_msr(a + 5); v += pv_read_msr(a + 6);
    return v + pv_read_msr(a + 7);
}
int has(void)
{
    asm goto("testb $1, %[cap]\n jnz %l[yes]\n jmp %l[no]\n"
             : : [cap] "m" (((const char *)boot_cpu_data.cap)[25]) : : yes, no);
yes:
    return 1;
no:
    return 0;
}
unsigned long rdgs(void)
{
    unsigned long gsbase;
    asm volatile("swapgs" ::: "memory");
    asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
    asm volatile("swapgs" ::: "memory");
    return gsbase;
}
void wrgs(unsigned long gsbase)
{
    asm volatile("swapgs" ::: "memory");
    asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
    asm volatile("swapgs" ::: "memory");
}
"#;

/// The frame reports of `KERNEL_ASM` under the kernel's flags, by function.
fn kernel_asm_frames(dir: &Path) -> std::collections::BTreeMap<String, (u64, String)> {
    let src = dir.join("kasm.c");
    std::fs::write(&src, KERNEL_ASM).expect("write source");
    let out = Command::new(badc())
        .args([
            "--target=linux-x64",
            "-O",
            "-c",
            "-mcmodel=kernel",
            "-mno-sse",
            "-fno-pic",
            "-fcf-protection=branch",
            "-fstack-protector-strong",
            "-mstack-protector-guard=tls",
            "-mstack-protector-guard-reg=gs",
            "-mstack-protector-guard-symbol=__ref_stack_chk_guard",
            "-Wframe-larger-than=0",
        ])
        .arg("-o")
        .arg(dir.join("kasm.o"))
        .arg(&src)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    let mut frames = std::collections::BTreeMap::new();
    for line in stderr.lines().filter(|l| l.contains("B4005")) {
        let (_, rest) = line.split_once("function `").expect("a function name");
        let (name, rest) = rest.split_once("`: stack frame of ").expect("a size");
        let (bytes, rest) = rest.split_once(" bytes").expect("a byte count");
        let parts = rest
            .split_once("bound: ")
            .map(|(_, p)| p.split(" [B4005]").next().unwrap_or("").to_string())
            .unwrap_or_default();
        frames.insert(name.to_string(), (bytes.parse().expect("a number"), parts));
    }
    frames
}

/// Inline-asm operands move between their registers and their places
/// without a frame slot: the frame holds the locals and the saved
/// registers alone, a statement that binds rsp without naming it shares
/// the region, so the frame does not grow with the statement count, a
/// link-time memory operand needs no register, a register output into a
/// local is no address-taking for the canary, and a statement without
/// locals keeps the function a frameless leaf.
#[test]
fn x86_64_inline_asm_operands_take_no_frame_scratch() {
    let dir = tempdir("kasm");
    let frames = kernel_asm_frames(&dir);
    for (name, (bytes, parts)) in &frames {
        assert!(
            !parts.contains("inline-asm scratch"),
            "{name}: {bytes} bytes: {parts}"
        );
        assert!(!parts.contains("canary"), "{name}: {bytes} bytes: {parts}");
    }
    let one = frames.get("one").expect("`one` has a frame");
    let eight = frames.get("eight").expect("`eight` has a frame");
    // The eight inlined copies share the five output locals; the sum
    // across the sites keeps a callee-saved register or two, since each
    // site clobbers every caller-saved one.
    let locals = |parts: &str| {
        parts
            .split(", ")
            .find(|p| p.ends_with("in locals"))
            .map(String::from)
    };
    assert_eq!(locals(&one.1), locals(&eight.1), "{frames:?}");
    assert!(eight.0 <= one.0 + 16, "{frames:?}");
    // Five output locals, the saved frame pointer, and at most two
    // callee-saved registers.
    assert!(one.0 <= 48 + 8 + 16, "{frames:?}");
    assert!(
        frames.get("rdgs").is_some_and(|(b, _)| *b <= 24),
        "{frames:?}"
    );
    for leaf in ["has", "wrgs"] {
        assert!(
            !frames.contains_key(leaf),
            "{leaf} keeps no frame: {frames:?}"
        );
    }
}

/// The SIMD intrinsic wrappers are `static inline` bodies of one
/// instruction over a pair of by-value vector parameters and a vector
/// return. At -O each splices into its caller on the flat path: the
/// caller holds the instruction and no call, and no wrapper body is
/// emitted, so the frame report names the kernel's functions only.
#[test]
fn simd_wrappers_inline_at_opt() {
    let dir = tempdir("simd-inline");
    let src = dir.join("k.c");
    std::fs::write(
        &src,
        "#include <x86intrin.h>\n\
         __m128i t(__m128i a, __m128i b) { return _mm_add_epi32(a, b); }\n\
         __m128i chain(__m128i a, __m128i b, __m128i c) {\n\
             __m128i x = _mm_add_epi32(a, b);\n\
             __m128i y = _mm_xor_si128(x, c);\n\
             __m128i z = _mm_shuffle_epi8(y, a);\n\
             return _mm_sub_epi32(z, b);\n\
         }\n",
    )
    .expect("write source");
    let out = run(
        Command::new(badc())
            .args(["-q", "-O", "-c", "--target=linux-x64", "--dump-ssa"])
            .arg("-Wframe-larger-than=0")
            .arg("-o")
            .arg(dir.join("k.o"))
            .arg(&src),
        "compile the kernel at -O",
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    let chain = stderr
        .split("; name=")
        .find(|s| s.starts_with("chain\n"))
        .expect("chain is dumped");
    assert!(!chain.contains(" Call {"), "chain keeps a call:\n{chain}");
    for op in ["paddd128", "pxor128", "pshufb128", "psubd128"] {
        assert!(
            chain.contains(&format!("X86Simd {{ op=__builtin_ia32_{op},")),
            "chain lacks {op}:\n{chain}"
        );
    }
    let reports: Vec<&str> = stderr.lines().filter(|l| l.contains("B4005")).collect();
    assert_eq!(reports.len(), 2, "{reports:?}");
    for name in ["t", "chain"] {
        assert!(
            reports
                .iter()
                .any(|l| l.contains(&format!("function `{name}`"))),
            "{name} has no frame report: {reports:?}"
        );
    }
}

/// Compile `source` at -O for `target` with the SSA dump and a frame report
/// for every function; returns the compiler's stderr.
fn dump_opt(source: &str, target: &str, name: &str) -> String {
    let dir = tempdir(name);
    let src = dir.join("k.c");
    std::fs::write(&src, source).expect("write source");
    let out = run(
        Command::new(badc())
            .args(["-q", "-O", "-c", "--dump-ssa", "-Wframe-larger-than=0"])
            .arg(format!("--target={target}"))
            .arg("-o")
            .arg(dir.join("k.o"))
            .arg(&src),
        "compile at -O",
    );
    String::from_utf8_lossy(&out.stderr).into_owned()
}

/// The SSA of function `name` and its frame report line.
fn function_dump<'a>(stderr: &'a str, name: &str) -> (&'a str, &'a str) {
    let body = stderr
        .split("; name=")
        .find(|s| s.starts_with(&format!("{name}\n")))
        .unwrap_or_else(|| panic!("{name} is not dumped:\n{stderr}"));
    let report = stderr
        .lines()
        .find(|l| l.contains("B4005") && l.contains(&format!("function `{name}`")))
        .unwrap_or_else(|| panic!("{name} has no frame report:\n{stderr}"));
    (body, report)
}

/// A function whose vectors are values: no object address and no 16-byte
/// copy remain, a 128-bit phi carries the loop, an asm statement defines
/// its output, and the frame holds no locals and no over-aligned region.
fn assert_vectors_in_registers(body: &str, report: &str) {
    for form in ["LocalAddr(", "Mcpy {"] {
        assert!(!body.contains(form), "{form} remains:\n{body}");
    }
    assert!(
        body.lines()
            .any(|l| l.contains("Phi {") && l.contains("kind=V128")),
        "no 128-bit phi:\n{body}"
    );
    assert!(
        body.lines()
            .any(|l| l.contains("InlineAsm {") && l.contains("args=[-")),
        "no asm value output:\n{body}"
    );
    for region in ["in locals", "over-aligned region"] {
        assert!(!report.contains(region), "{report}");
    }
}

/// NEON intrinsic chains at -O: the loop's vectors live in SIMD registers,
/// the two live across the call spill whole, and the wrapper bodies inline
/// away. A vector whose address reaches a call stays an object.
#[test]
fn neon_vectors_live_in_registers_at_opt() {
    let stderr = dump_opt(
        "#include <arm_neon.h>\n\
         unsigned sum16(const unsigned char *p);\n\
         void take(uint8x16_t *v);\n\
         unsigned gen(int disks, unsigned long bytes, unsigned char **dptr) {\n\
             unsigned acc = 0;\n\
             const uint8x16_t x1d = vdupq_n_u8(0x1d);\n\
             for (unsigned long d = 0; d < bytes; d += 16) {\n\
                 uint8x16_t wp = vld1q_u8(&dptr[disks - 1][d]), wq = wp;\n\
                 for (int z = disks - 2; z >= 0; z--) {\n\
                     uint8x16_t wd = vld1q_u8(&dptr[z][d]);\n\
                     uint8x16_t w2 = (uint8x16_t)vshrq_n_s8((int8x16_t)wq, 7);\n\
                     wp = veorq_u8(wp, wd);\n\
                     wq = veorq_u8(veorq_u8(vshlq_n_u8(wq, 1), vandq_u8(w2, x1d)), wd);\n\
                 }\n\
                 acc += sum16(dptr[0] + d);\n\
                 vst1q_u8(&dptr[disks - 1][d], wp);\n\
                 vst1q_u8(&dptr[disks - 2][d], wq);\n\
             }\n\
             return acc;\n\
         }\n\
         void escape(const unsigned char *p) {\n\
             uint8x16_t v = vld1q_u8(p);\n\
             take(&v);\n\
         }\n",
        "linux-aarch64",
        "neon-registers",
    );
    let (body, report) = function_dump(&stderr, "gen");
    assert_vectors_in_registers(body, report);
    assert!(report.contains("in spill slots"), "{report}");
    assert!(
        !stderr.contains("; name=veorq_u8"),
        "a wrapper stays out of line"
    );
    let (body, report) = function_dump(&stderr, "escape");
    assert!(
        body.contains("LocalAddr("),
        "the escaping vector is promoted:\n{body}"
    );
    assert!(report.contains("over-aligned region"), "{report}");
}

/// x86_64 inline asm with `x` operands at -O: plain and read-write outputs
/// carry their 128-bit values, so the chain's frame holds no vector object.
#[test]
fn x86_64_asm_vector_operands_live_in_registers_at_opt() {
    let stderr = dump_opt(
        "typedef unsigned char u8x16 __attribute__((vector_size(16)));\n\
         static inline u8x16 load16(const unsigned char *p) {\n\
             u8x16 r;\n\
             __asm__(\"movdqu %1, %0\" : \"=x\"(r) : \"m\"(p[0]));\n\
             return r;\n\
         }\n\
         static inline void store16(unsigned char *p, u8x16 v) {\n\
             __asm__(\"movdqu %1, %0\" : \"=m\"(p[0]) : \"x\"(v));\n\
         }\n\
         static inline u8x16 xor16(u8x16 a, u8x16 b) {\n\
             u8x16 r;\n\
             __asm__(\"movdqa %1, %0\\n\\tpxor %2, %0\" : \"=x\"(r) : \"x\"(a), \"x\"(b));\n\
             return r;\n\
         }\n\
         static inline u8x16 shl1(u8x16 a) {\n\
             u8x16 r = a;\n\
             __asm__(\"paddb %0, %0\" : \"+x\"(r));\n\
             return r;\n\
         }\n\
         unsigned sum16(const unsigned char *p);\n\
         unsigned chain(unsigned char *p, unsigned char *q, int n) {\n\
             u8x16 acc = load16(p);\n\
             unsigned s = 0;\n\
             for (int i = 0; i < n; i++) {\n\
                 acc = xor16(shl1(acc), load16(q));\n\
                 s += sum16(q);\n\
             }\n\
             store16(p, acc);\n\
             return s;\n\
         }\n",
        "linux-x64",
        "x64-asm-registers",
    );
    let (body, report) = function_dump(&stderr, "chain");
    assert_vectors_in_registers(body, report);
    assert!(
        body.lines()
            .any(|l| l.contains("paddb") && !l.contains("args=[-")),
        "the read-write operand carries no input value:\n{body}"
    );
}

/// A caller whose pre-inline frame is past the inliner's absolute bound
/// still absorbs the NEON wrappers: once its vectors are values a splice
/// leaves no frame cell, so none of the calls stays out of line.
#[test]
fn neon_wrappers_inline_into_a_large_frame() {
    let mut source = String::from(
        "#include <arm_neon.h>\n\
         void fold(unsigned char *out, const unsigned char *p) {\n\
             uint8x16_t w = vld1q_u8(p);\n",
    );
    for i in 1..=150 {
        source.push_str(&format!("    w = veorq_u8(w, vld1q_u8(p + {i}));\n"));
    }
    source.push_str("    vst1q_u8(out, w);\n}\n");
    let stderr = dump_opt(&source, "linux-aarch64", "neon-large-frame");
    let (body, report) = function_dump(&stderr, "fold");
    assert!(!body.contains("Call {"), "a wrapper call remains:\n{body}");
    for region in ["in locals", "over-aligned region"] {
        assert!(!report.contains(region), "{report}");
    }
}
