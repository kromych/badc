//! Code shape of the `tests/perf` hot paths at `-O`, on both ELF targets.
//!
//! Each source is a reduction of a loop from `fib.c`, `qsort.c`, `sieve.c`
//! or `munchausen.c`, and each test states the shape the emitted function
//! must have. A test whose shape is not produced yet is `#[ignore]`d under
//! a `TODO`; `cargo test -- --ignored perf_codegen` reproduces the defect.
//!
//! The checks decode the function's machine code: AArch64 by instruction
//! class masks, x86-64 through [`x64_insns`].

use super::codegen::{function_bytes, function_words, optimized_function_full_pool};
use crate::Target;

/// The relocatable object of `src` at `-O` or `-O0`, over the full register
/// pool so the pressure caps do not move registers.
pub(super) fn object_at(src: &str, target: Target, optimize: bool) -> Vec<u8> {
    object_with(src, target, optimize, (usize::MAX, usize::MAX))
}

/// The `-O` object of `src` over integer / FP banks capped to `caps`.
fn object_with_pool(src: &str, target: Target, caps: (usize, usize)) -> Vec<u8> {
    object_with(src, target, true, caps)
}

fn object_with(src: &str, target: Target, optimize: bool, caps: (usize, usize)) -> Vec<u8> {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, emit_native_with_options};
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(optimize),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
    let level = if optimize {
        NativeOptions::new().with_optimize()
    } else {
        NativeOptions::new()
    };
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..level
    };
    crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(caps.0, caps.1, || {
        emit_native_with_options(&program, target, opts)
    })
    .unwrap_or_else(|e| panic!("emit ({target:?}): {e}"))
}

pub(super) fn a64_at(src: &str, name: &str, optimize: bool) -> Vec<u32> {
    function_words(&object_at(src, Target::LinuxAarch64, optimize), name)
}

pub(super) fn x64_at(src: &str, name: &str, optimize: bool) -> Vec<X64Insn> {
    x64_insns(&function_bytes(
        &object_at(src, Target::LinuxX64, optimize),
        name,
    ))
}

fn a64(src: &str, name: &str) -> Vec<u32> {
    a64_at(src, name, true)
}

fn x64(src: &str, name: &str) -> Vec<X64Insn> {
    x64_at(src, name, true)
}

/// One decoded x86-64 instruction. `op` is the opcode with `0x0F00` set for
/// the two-byte map and `0x3800` / `0x3A00` for the three-byte ones; `imm`
/// is the sign-extended immediate or displacement of a relative branch, and
/// `disp` the sign-extended displacement of a memory operand.
#[derive(Debug, Clone, Copy)]
pub(super) struct X64Insn {
    pub(super) at: usize,
    pub(super) len: usize,
    pub(super) rex: u8,
    pub(super) op: u16,
    pub(super) modrm: Option<u8>,
    pub(super) sib: Option<u8>,
    pub(super) imm: i64,
    pub(super) disp: i64,
}

impl X64Insn {
    pub(super) fn is_jmp(&self) -> bool {
        matches!(self.op, 0xEB | 0xE9)
    }
    pub(super) fn is_jcc(&self) -> bool {
        matches!(self.op, 0x70..=0x7F | 0x0F80..=0x0F8F)
    }
    pub(super) fn target(&self) -> usize {
        (self.at as i64 + self.len as i64 + self.imm) as usize
    }
    /// ModRM `mod == 3`: both operands are registers.
    pub(super) fn reg_form(&self) -> bool {
        self.modrm.is_some_and(|m| m >> 6 == 3)
    }
    /// The base register of a memory operand, REX-extended; `None` for a
    /// register form and for the RIP-relative and absolute forms.
    pub(super) fn mem_base(&self) -> Option<u8> {
        let m = self.modrm?;
        let (md, rm) = (m >> 6, m & 7);
        let base = match (md, rm, self.sib) {
            (3, _, _) => return None,
            (0, 5, _) => return None,
            (_, 4, Some(s)) if md == 0 && s & 7 == 5 => return None,
            (_, 4, Some(s)) => s & 7,
            _ => rm,
        };
        Some(base | ((self.rex & 1) << 3))
    }
    pub(super) fn rex_w(&self) -> bool {
        self.rex & 8 != 0
    }
    /// The ModRM `reg` and `rm` register numbers, REX-extended.
    pub(super) fn regs(&self) -> (u8, u8) {
        let m = self.modrm.unwrap_or(0);
        (
            ((m >> 3) & 7) | ((self.rex & 4) << 1),
            (m & 7) | ((self.rex & 1) << 3),
        )
    }
    /// `movslq r32, r64` between registers.
    fn is_movsxd_rr(&self) -> bool {
        self.op == 0x63 && self.rex_w() && self.reg_form()
    }
}

/// Instruction boundaries of `code`, for the integer and scalar-SSE subset
/// the backend emits. An opcode outside the subset panics rather than
/// desynchronizing the walk.
pub(super) fn x64_insns(code: &[u8]) -> Vec<X64Insn> {
    let mut out = Vec::new();
    let mut i = 0;
    while i < code.len() {
        let at = i;
        let mut op16 = false;
        while matches!(
            code[i],
            0x66 | 0x67 | 0xF0 | 0xF2 | 0xF3 | 0x2E | 0x36 | 0x3E | 0x26 | 0x64 | 0x65
        ) {
            op16 |= code[i] == 0x66;
            i += 1;
        }
        let mut rex = 0;
        if code[i] & 0xF0 == 0x40 {
            rex = code[i];
            i += 1;
        }
        let mut op = u16::from(code[i]);
        i += 1;
        if op == 0x0F {
            op = 0x0F00 | u16::from(code[i]);
            i += 1;
            if matches!(op, 0x0F38 | 0x0F3A) {
                op = (op & 0xFF) << 8 | u16::from(code[i]);
                i += 1;
            }
        } else if matches!(op, 0xC4 | 0xC5) {
            // VEX: the inverted R / X / B and W fold into `rex`, the map
            // selects the opcode page as the escape bytes do.
            let (rxb, map, w) = if op == 0xC4 {
                let (b1, b2) = (code[i], code[i + 1]);
                i += 2;
                (!b1 >> 5, b1 & 0x1F, b2 >> 7)
            } else {
                i += 1;
                ((!code[i - 1] >> 5) & 4, 1, 0)
            };
            rex = 0x40 | (w << 3) | (rxb & 7);
            let page = match map {
                1 => 0x0F00,
                2 => 0x3800,
                3 => 0x3A00,
                _ => panic!("VEX map {map} at {at:#x}: {code:02x?}"),
            };
            op = page | u16::from(code[i]);
            i += 1;
        }
        let wide = if op16 { 2 } else { 4 };
        // (has ModRM, immediate bytes); 0xF6 / 0xF7 add theirs below.
        let (has_modrm, mut imm_len) = match op {
            0x00..=0x3F => match op & 7 {
                0..=3 => (true, 0),
                4 => (false, 1),
                5 => (false, wide),
                _ => panic!("x86-64 opcode {op:#x} at {at:#x}: {code:02x?}"),
            },
            0x50..=0x5F | 0x90..=0x99 | 0xC3 | 0xC9 | 0xCC | 0xF4 => (false, 0),
            // 0xD8..0xDF: the x87 escapes, ModRM in both the memory and
            // the register form, never an immediate.
            0x63
            | 0x84..=0x8B
            | 0x8D
            | 0x8F
            | 0xD0..=0xD3
            | 0xD8..=0xDF
            | 0xF6
            | 0xF7
            | 0xFE
            | 0xFF => (true, 0),
            0x68 | 0xA9 | 0xE8 | 0xE9 => (false, 4),
            0x6A | 0x70..=0x7F | 0xA8 | 0xB0..=0xB7 | 0xEB => (false, 1),
            0x69 | 0x81 | 0xC7 => (true, wide),
            0x6B | 0x80 | 0x83 | 0xC0 | 0xC1 | 0xC6 => (true, 1),
            0xB8..=0xBF => (false, if rex & 8 != 0 { 8 } else { wide }),
            0xC2 => (false, 2),
            0x0F05 | 0x0F0B | 0x0F31 | 0x0FA2 | 0x0FC8..=0x0FCF => (false, 0),
            0x3800..=0x38FF => (true, 0),
            0x3A00..=0x3AFF => (true, 1),
            0x0F80..=0x0F8F => (false, 4),
            0x0F70..=0x0F73 | 0x0FA4 | 0x0FAC | 0x0FBA | 0x0FC2 | 0x0FC4..=0x0FC6 => (true, 1),
            0x0F01
            | 0x0F10..=0x0F17
            | 0x0F1E
            | 0x0F1F
            | 0x0F28..=0x0F2F
            | 0x0F40..=0x0F6F
            | 0x0F74..=0x0F76
            | 0x0F7E
            | 0x0F7F
            | 0x0F90..=0x0F9F
            | 0x0FA3
            | 0x0FAB
            | 0x0FAF
            | 0x0FB0
            | 0x0FB1
            | 0x0FB6..=0x0FB8
            | 0x0FBC..=0x0FBF
            | 0x0FC0
            | 0x0FC1
            | 0x0FD0..=0x0FFE => (true, 0),
            _ => panic!("x86-64 opcode {op:#x} at {at:#x}: {code:02x?}"),
        };
        let (mut modrm, mut sib, mut disp) = (None, None, 0i64);
        if has_modrm {
            let m = code[i];
            i += 1;
            modrm = Some(m);
            let (md, rm) = (m >> 6, m & 7);
            if md != 3 && rm == 4 {
                sib = Some(code[i]);
                i += 1;
            }
            let disp_len = match md {
                0 if rm == 5 || sib.is_some_and(|s| s & 7 == 5) => 4,
                1 => 1,
                2 => 4,
                _ => 0,
            };
            disp = match disp_len {
                1 => i64::from(code[i] as i8),
                4 => i64::from(i32::from_le_bytes(code[i..i + 4].try_into().unwrap())),
                _ => 0,
            };
            i += disp_len;
            // `test r/m, imm` is the /0 and /1 rows of the 0xF6 / 0xF7 groups.
            if (m >> 3) & 7 < 2 {
                imm_len += match op {
                    0xF6 => 1,
                    0xF7 => wide,
                    _ => 0,
                };
            }
        }
        let mut raw = [0u8; 8];
        raw[..imm_len].copy_from_slice(&code[i..i + imm_len]);
        let shift = 64 - 8 * imm_len as u32;
        let imm = if imm_len == 0 {
            0
        } else {
            (i64::from_le_bytes(raw) << shift) >> shift
        };
        i += imm_len;
        out.push(X64Insn {
            at,
            len: i - at,
            rex,
            op,
            modrm,
            sib,
            imm,
            disp,
        });
    }
    assert_eq!(i, code.len(), "x86-64 walk overran the function");
    out
}

/// The decoder's lengths over one instruction of each operand layout.
#[test]
fn x64_walk_finds_instruction_boundaries() {
    let code: &[u8] = &[
        0x55, // push rbp
        0x48, 0x89, 0xE5, // mov rbp, rsp
        0x48, 0x81, 0xEC, 0x10, 0x00, 0x00, 0x00, // sub rsp, 0x10
        0x48, 0x63, 0xD0, // movsxd rdx, eax
        0x48, 0x8D, 0x34, 0x17, // lea rsi, [rdi + rdx]
        0x48, 0x0F, 0xBE, 0x36, // movsx rsi, byte [rsi]
        0x4C, 0x89, 0x64, 0x24, 0x08, // mov [rsp + 8], r12
        0x48, 0x8B, 0x05, 0x00, 0x00, 0x00, 0x00, // mov rax, [rip + 0]
        0x41, 0xF6, 0xC0, 0x01, // test r8b, 1
        0x48, 0xF7, 0xD8, // neg rax
        0x49, 0xBA, 1, 2, 3, 4, 5, 6, 7, 8, // movabs r10, imm64
        0x66, 0x81, 0xC1, 0x34, 0x12, // add cx, 0x1234
        0x66, 0x0F, 0x3A, 0x0B, 0xC0, 0x09, // roundsd xmm0, xmm0, 9
        0xC4, 0xC2, 0x89, 0xB9, 0xC7, // vfmadd231sd xmm0, xmm14, xmm15
        0x75, 0x05, // jne +5
        0x0F, 0x8C, 0xFB, 0xFF, 0xFF, 0xFF, // jl -5
        0xEB, 0xFC, // jmp -4
        0xC9, // leave
        0xC3, // ret
    ];
    let lens: Vec<usize> = x64_insns(code).iter().map(|i| i.len).collect();
    assert_eq!(
        lens,
        [1, 3, 7, 3, 4, 4, 5, 7, 4, 3, 10, 5, 6, 5, 2, 6, 2, 1, 1]
    );
    let insns = x64_insns(code);
    assert_eq!(insns[12].op, 0x3A0B);
    assert_eq!((insns[13].op, insns[13].regs()), (0x38B9, (0, 15)));
    // `lea rsi, [rdi + rdx]` has base rdi and no displacement; `mov
    // [rsp + 8], r12` base rsp and 8; the RIP-relative load has no base.
    assert_eq!((insns[4].mem_base(), insns[4].disp), (Some(7), 0));
    assert_eq!((insns[6].mem_base(), insns[6].disp), (Some(4), 8));
    assert_eq!(insns[7].mem_base(), None);
    assert_eq!(insns[14].target(), insns[14].at + 2 + 5);
    assert_eq!(insns[16].target(), insns[16].at - 2);
}

fn sext(v: u32, bits: u32) -> i64 {
    i64::from(((v << (32 - bits)) as i32) >> (32 - bits))
}

/// `(target word index, unconditional)` of a direct branch at word `i`.
pub(super) fn a64_branch(w: u32, i: usize) -> Option<(i64, bool)> {
    let at = i as i64;
    if w & 0xFC00_0000 == 0x1400_0000 {
        Some((at + sext(w & 0x03FF_FFFF, 26), true))
    } else if w & 0xFF00_0010 == 0x5400_0000 || w & 0x7E00_0000 == 0x3400_0000 {
        Some((at + sext((w >> 5) & 0x7_FFFF, 19), false))
    } else if w & 0x7E00_0000 == 0x3600_0000 {
        Some((at + sext((w >> 5) & 0x3FFF, 14), false))
    } else {
        None
    }
}

/// `sxtw xd, wn`.
fn a64_is_sxtw(w: u32) -> bool {
    w & 0xFFFF_FC00 == 0x9340_7C00
}

/// `sxtw`, or an access that sign-extends its index word.
fn a64_extends_word(w: u32) -> bool {
    a64_is_sxtw(w) || a64_reg_offset(w).is_some_and(|(option, _)| option == A64_SXTW)
}

/// The shapes a test misses, so one run reports both targets.
#[derive(Default)]
pub(super) struct Misses(Vec<String>);

impl Misses {
    pub(super) fn expect(&mut self, ok: bool, what: impl FnOnce() -> String) {
        if !ok {
            self.0.push(what());
        }
    }
    pub(super) fn finish(self) {
        assert!(self.0.is_empty(), "\n{}", self.0.join("\n"));
    }
}

/// Every direct branch lands on an instruction that is neither the next one
/// nor an unconditional branch.
pub(super) fn a64_branches_land_on_code(ws: &[u32]) -> bool {
    ws.iter().enumerate().all(|(i, &w)| {
        let Some((t, _)) = a64_branch(w, i) else {
            return true;
        };
        let lands_on_b = usize::try_from(t)
            .ok()
            .and_then(|t| ws.get(t))
            .is_some_and(|&tw| matches!(a64_branch(tw, 0), Some((_, true))));
        t != i as i64 + 1 && !lands_on_b
    })
}

pub(super) fn x64_branches_land_on_code(insns: &[X64Insn]) -> bool {
    insns.iter().filter(|i| i.is_jmp() || i.is_jcc()).all(|b| {
        let lands_on_jmp = insns.iter().any(|t| t.at == b.target() && t.is_jmp());
        b.target() != b.at + b.len && !lands_on_jmp
    })
}

/// `sieve.c`'s counting loop: the skip edge of the `if` is a split critical
/// edge whose phi moves the allocator coalesces away.
const COUNT_ZERO: &str = "long count_zero(const char *p, int n) {\n\
    long c = 0;\n\
    for (int i = 0; i < n; i++) { if (!p[i]) c++; }\n\
    return c;\n}\n";

/// `qsort.c`'s partition step: two nested scans and an `if` closing the body.
const STEP: &str = "void step(int *a, int i, int j, int pivot) {\n\
    while (i <= j) {\n\
        while (a[i] < pivot) i++;\n\
        while (a[j] > pivot) j--;\n\
        if (i <= j) { int t = a[i]; a[i] = a[j]; a[j] = t; i++; j--; }\n\
    }\n}\n";

/// `munchausen.c`'s driver: an inlined predicate with an early `return 0`
/// and a final comparison, both reaching the caller's `if`.
const TALLY: &str = "static _Bool same(int a, int b) {\n\
    int t = 0;\n\
    while (a > 0) { t += a % 10; if (t > b) return 0; a = a / 10; }\n\
    return t == b;\n}\n\
    long tally(int n) {\n\
    long c = 0;\n\
    for (int i = 0; i < n; i++) { if (same(i, i)) c++; }\n\
    return c;\n}\n";

const FIB: &str = "long fib(int n) {\n\
    if (n < 2) return (long)n;\n\
    return fib(n - 1) + fib(n - 2);\n}\n";

const SUM: &str = "long sum(const int *a, int n) {\n\
    long s = 0;\n\
    for (int i = 0; i < n; i++) s += a[i];\n\
    return s;\n}\n";

const SUM1000: &str = "long sum1000(const int *a) {\n\
    long s = 0;\n\
    for (int i = 0; i < 1000; i++) s += a[i];\n\
    return s;\n}\n";

const DIGITS: &str = "extern int table[10];\n\
    int digits(int n) {\n\
    int total = 0;\n\
    while (n > 0) { int digit = n % 10; total += table[digit]; n = n / 10; }\n\
    return total;\n}\n";

const CHAIN: &str = "unsigned chain(unsigned seed, int n) {\n\
    unsigned s = seed;\n\
    for (int i = 0; i < n; i++) s = s * 1103515245u + 12345u;\n\
    return s;\n}\n";

const MARK: &str = "void mark(char *p, int i, int n) {\n\
    for (int j = i * i; j < n; j += i) p[j] = 1;\n}\n";

const DROP: &str = "#include <stdlib.h>\nvoid drop(void *p) { free(p); }\n";

const MID: &str = "int mid(int lo, int hi) { return (lo + hi) / 2; }\n";

#[test]
fn codeless_blocks_cost_no_branch() {
    let mut m = Misses::default();
    for (src, name) in [(COUNT_ZERO, "count_zero"), (STEP, "step"), (TALLY, "tally")] {
        let ws = a64(src, name);
        m.expect(a64_branches_land_on_code(&ws), || {
            format!("aarch64 {name}: a branch to a branch or to the next: {ws:08x?}")
        });
        let insns = x64(src, name);
        m.expect(x64_branches_land_on_code(&insns), || {
            format!("x86-64 {name}: a branch to a branch or to the next: {insns:x?}")
        });
    }
    m.finish();
}

#[test]
fn counted_loop_is_entered_through_its_guard() {
    let mut m = Misses::default();
    let ws = a64(SUM, "sum");
    let first = ws.iter().enumerate().find_map(|(i, &w)| a64_branch(w, i));
    m.expect(matches!(first, Some((_, false))), || {
        format!("aarch64: the first branch is not the guard: {ws:08x?}")
    });
    let insns = x64(SUM, "sum");
    let first = insns.iter().find(|i| i.is_jmp() || i.is_jcc());
    m.expect(first.is_some_and(X64Insn::is_jcc), || {
        format!("x86-64: the first branch is not the guard: {insns:x?}")
    });
    m.finish();
}

/// Under `n >= 2` the decrement `n - 2` stays inside `int`, so only the
/// parameter's entry extension remains.
#[test]
fn guarded_decrement_is_not_renormalized() {
    let mut m = Misses::default();
    let ws = a64(FIB, "fib");
    let n = ws.iter().filter(|&&w| a64_is_sxtw(w)).count();
    m.expect(n <= 1, || format!("aarch64: {n} sxtw: {ws:08x?}"));
    let insns = x64(FIB, "fib");
    let n = insns.iter().filter(|i| i.is_movsxd_rr()).count();
    m.expect(n <= 1, || format!("x86-64: {n} movslq: {insns:x?}"));
    m.finish();
}

/// `i` stays in `[0, 1000]`, so no use of it needs a sign extension.
#[test]
fn bounded_counter_is_not_renormalized() {
    let mut m = Misses::default();
    let ws = a64(SUM1000, "sum1000");
    m.expect(!ws.iter().any(|&w| a64_is_sxtw(w)), || {
        format!("aarch64: sxtw of the counter: {ws:08x?}")
    });
    let insns = x64(SUM1000, "sum1000");
    m.expect(!insns.iter().any(X64Insn::is_movsxd_rr), || {
        format!("x86-64: movslq of the counter: {insns:x?}")
    });
    m.finish();
}

/// Whether an instruction in the span of a backward branch satisfies `pred`.
fn a64_in_loop(ws: &[u32], pred: impl Fn(u32) -> bool) -> bool {
    ws.iter().enumerate().any(|(i, &w)| {
        matches!(a64_branch(w, i), Some((t, _)) if t >= 0 && t as usize <= i
            && ws[t as usize..=i].iter().any(|&x| pred(x)))
    })
}

fn x64_in_loop(insns: &[X64Insn], pred: impl Fn(&X64Insn) -> bool) -> bool {
    insns
        .iter()
        .filter(|b| (b.is_jmp() || b.is_jcc()) && b.target() <= b.at)
        .any(|b| {
            insns
                .iter()
                .any(|i| i.at >= b.target() && i.at <= b.at && pred(i))
        })
}

/// `mov wd, wm`, the zero extension of a low word.
fn a64_is_mask(w: u32) -> bool {
    w & 0xFFE0_FFE0 == 0x2A00_03E0
}

/// `movl r32, r32`.
fn x64_is_mask(i: &X64Insn) -> bool {
    matches!(i.op, 0x89 | 0x8B) && !i.rex_w() && i.reg_form()
}

/// Arithmetic wraps, so a counter keeps its extension wherever its bound
/// does not keep the step inside `int`: a disequality, `i <= n` (n can be
/// INT_MAX), a step that is not a constant, a bound on the side the step
/// moves away from, and a second back edge whose step is not a constant.
/// On aarch64 the subscript's access may perform it.
#[test]
fn counter_that_can_leave_int_keeps_its_extension() {
    const SRCS: [&str; 6] = [
        "long f(const int *a, int n) { long s = 0; for (int i = 0; i != n; i++) s += a[i]; return s; }",
        "long f(const int *a, int n) { long s = 0; for (int i = 0; i <= n; i++) s += a[i]; return s; }",
        "long f(const int *a, int n, int k) { long s = 0; for (int i = 0; i < n; i += k) s += a[i]; return s; }",
        "long f(const int *a, int n) { long s = 0; for (int i = n; i > 0; i++) s += a[i]; return s; }",
        "long f(const int *a, int n) { long s = 0; for (int i = n; i < 0; i--) s += a[i]; return s; }",
        "long f(const int *a, int n, int k) { long s = 0; int i = 0;\n\
         while (i < n) { if (a[i] & 1) { i += 1; continue; } s += a[i]; i += k; } return s; }",
    ];
    let mut m = Misses::default();
    for src in SRCS {
        let ws = a64(src, "f");
        m.expect(a64_in_loop(&ws, a64_extends_word), || {
            format!("aarch64: no sxtw in the loop of `{src}`: {ws:08x?}")
        });
        let insns = x64(src, "f");
        m.expect(x64_in_loop(&insns, X64Insn::is_movsxd_rr), || {
            format!("x86-64: no movslq in the loop of `{src}`: {insns:x?}")
        });
    }
    m.finish();
}

/// The bounded twins: the guard keeps the step inside the type, so the
/// loop holds no extension. `i < n` leaves room for `i + 1` whatever `n`
/// is; the decreasing counter ends at -1; an unsigned counter below an
/// unsigned bound cannot reach 2^32.
#[test]
fn bounded_counters_hold_no_extension_in_their_loops() {
    const SRCS: [&str; 4] = [
        "long f(const int *a, int n) { long s = 0; for (int i = 0; i < n; i++) s += a[i]; return s; }",
        "long f(const int *a) { long s = 0; for (int i = 999; i >= 0; i--) s += a[i]; return s; }",
        "long f(const int *a, unsigned n) { long s = 0; for (unsigned i = 0; i < n; i++) s += a[i]; return s; }",
        "long f(const int *a, int n) { long s = 0; int i = 0;\n\
         while (i < n) { if (a[i] & 1) { i += 1; continue; } s += a[i]; i += 1; } return s; }",
    ];
    let mut m = Misses::default();
    for src in SRCS {
        let ws = a64(src, "f");
        m.expect(
            !a64_in_loop(&ws, |w| a64_is_sxtw(w) || a64_is_mask(w)),
            || format!("aarch64: an extension in the loop of `{src}`: {ws:08x?}"),
        );
        let insns = x64(src, "f");
        m.expect(
            !x64_in_loop(&insns, |i| i.is_movsxd_rr() || x64_is_mask(i)),
            || format!("x86-64: an extension in the loop of `{src}`: {insns:x?}"),
        );
    }
    m.finish();
}

/// A guard on another value, and a guard whose block has ended, say
/// nothing about `i + 1`: the sum is renormalized behind the branch for
/// its 64-bit read. Under a guard on `i` itself it is not, and the one
/// extension is the parameter's, ahead of the branch.
#[test]
fn unguarded_increment_keeps_its_renormalization() {
    const SRCS: [(&str, bool); 3] = [
        (
            "long f(int i, int j) { long s = 0; if (j < 100) s += (long)(i + 1); return s; }",
            true,
        ),
        (
            "long f(int i) { long s = 0; if (i < 100) s = 1; s += (long)(i + 1); return s; }",
            true,
        ),
        (
            "long f(int i) { long s = 0; if (i < 100) s += (long)(i + 1); return s; }",
            false,
        ),
    ];
    let mut m = Misses::default();
    for (src, renormalized) in SRCS {
        let ws = a64(src, "f");
        let branch = ws
            .iter()
            .enumerate()
            .position(|(i, &w)| matches!(a64_branch(w, i), Some((_, false))))
            .expect("a conditional branch");
        m.expect(
            ws[branch..].iter().any(|&w| a64_is_sxtw(w)) == renormalized,
            || format!("aarch64 `{src}`: {ws:08x?}"),
        );
        let insns = x64(src, "f");
        let branch = insns.iter().position(X64Insn::is_jcc).expect("a jcc");
        m.expect(
            insns[branch..].iter().any(X64Insn::is_movsxd_rr) == renormalized,
            || format!("x86-64 `{src}`: {insns:x?}"),
        );
    }
    m.finish();
}

/// An unsigned renormalization read above bit 31 stays: a conversion to
/// `unsigned long`, a right shift, a division, a 64-bit comparison, an
/// 8-byte store and a call argument.
#[test]
fn unsigned_renormalization_read_at_64_bits_is_kept() {
    const SRCS: [&str; 6] = [
        "unsigned long f(unsigned long a, unsigned long b) { return (unsigned)(a + b); }",
        "unsigned long f(unsigned long a, unsigned long b) { return (unsigned)(a + b) >> 4; }",
        "unsigned long f(unsigned long a, unsigned long b) { return (unsigned)(a + b) / 3u; }",
        "int f(unsigned long a, unsigned long b, long c) { return (long)(unsigned)(a + b) < c; }",
        "void f(unsigned long a, unsigned long b, unsigned long *p) { *p = (unsigned)(a + b); }",
        "extern unsigned long sink(unsigned long);\n\
         unsigned long f(unsigned long a, unsigned long b) { return sink((unsigned)(a + b)); }",
    ];
    let mut m = Misses::default();
    for src in SRCS {
        let ws = a64(src, "f");
        m.expect(ws.iter().any(|&w| a64_is_mask(w)), || {
            format!("aarch64: no mask in `{src}`: {ws:08x?}")
        });
        let insns = x64(src, "f");
        m.expect(insns.iter().any(x64_is_mask), || {
            format!("x86-64: no mask in `{src}`: {insns:x?}")
        });
    }
    m.finish();
}

/// `a + b` wraps to zero for a = b = INT_MIN. Its zero test reads the low
/// word; a test of the whole register sees the carry above it.
#[test]
fn zero_test_of_a_wrapped_sum_reads_the_low_word() {
    const SRC: &str = "int f(int a, int b) { if ((a + b) != 0) return 1; return 0; }";
    let mut m = Misses::default();
    let ws = a64(SRC, "f");
    // `cbz xN` / `cbnz xN`.
    m.expect(!ws.iter().any(|&w| w & 0xFE00_0000 == 0xB400_0000), || {
        format!("aarch64: a 64-bit zero test: {ws:08x?}")
    });
    let insns = x64(SRC, "f");
    // `test r64, r64`.
    m.expect(
        !insns
            .iter()
            .any(|i| i.op == 0x85 && i.rex_w() && i.reg_form()),
        || format!("x86-64: a 64-bit zero test: {insns:x?}"),
    );
    m.finish();
}

/// `n % 10` lies in `(-10, 10)`: the promoted `digit` needs no extension
/// past the one of `n` at the loop head and the one of the `int` result.
#[test]
fn remainder_by_a_constant_is_not_renormalized() {
    let mut m = Misses::default();
    let ws = a64(DIGITS, "digits");
    let n = ws.iter().filter(|&&w| a64_is_sxtw(w)).count();
    m.expect(n <= 2, || format!("aarch64: {n} sxtw: {ws:08x?}"));
    let insns = x64(DIGITS, "digits");
    let n = insns.iter().filter(|i| i.is_movsxd_rr()).count();
    m.expect(n <= 2, || format!("x86-64: {n} movslq: {insns:x?}"));
    m.finish();
}

/// `qsort.c`'s `qs`. The recursive call in the enclosing loop lies on no
/// path from the swap's extension of `j` to its second one that does not
/// run the first again, so the second reads the first: x86-64 extends
/// nothing between the swap's two stores.
#[test]
fn swap_extends_an_index_once() {
    const QS: &str = "void qs(int *a, int lo, int hi) {\n\
        if (lo >= hi) return;\n\
        int pivot = a[(lo + hi) / 2];\n\
        int i = lo, j = hi;\n\
        while (i <= j) {\n\
            while (a[i] < pivot) i++;\n\
            while (a[j] > pivot) j--;\n\
            if (i <= j) { int t = a[i]; a[i] = a[j]; a[j] = t; i++; j--; }\n\
        }\n\
        qs(a, lo, j);\n\
        qs(a, i, hi);\n}\n";
    let insns = x64(QS, "qs");
    let stores: Vec<usize> = (0..insns.len())
        .filter(|&k| insns[k].op == 0x89 && !insns[k].rex_w() && !insns[k].reg_form())
        .collect();
    assert_eq!(stores.len(), 2, "{insns:x?}");
    assert!(
        !insns[stores[0]..stores[1]]
            .iter()
            .any(X64Insn::is_movsxd_rr),
        "x86-64: an extension between the swap's stores: {insns:x?}"
    );
}

/// Of the two masks in `s * K + C`, only the second one's result is read
/// above bit 31; the parameter's entry conversion is one more.
#[test]
fn unsigned_chain_masks_once_per_iteration() {
    let mut m = Misses::default();
    // `mov wd, wm`.
    let ws = a64(CHAIN, "chain");
    let n = ws
        .iter()
        .filter(|&&w| w & 0xFFE0_FFE0 == 0x2A00_03E0)
        .count();
    m.expect(n <= 2, || format!("aarch64: {n} masks: {ws:08x?}"));
    let insns = x64(CHAIN, "chain");
    let mask = |i: &&X64Insn| matches!(i.op, 0x89 | 0x8B) && !i.rex_w() && i.reg_form();
    let n = insns.iter().filter(mask).count();
    m.expect(n <= 2, || format!("x86-64: {n} masks: {insns:x?}"));
    m.finish();
}

/// A parameter's home is written at the object's width, as the body's
/// stores of it are, so an assigned one leaves its slot whatever its type:
/// unsigned, `_Bool`, an enumeration, and `long` where it is 32 bits wide.
#[test]
fn assigned_narrow_parameter_is_promoted() {
    const SRC: &str = "enum tone { LOW, HIGH };\n\
        unsigned u32(unsigned s, int n) { for (int i = 0; i < n; i++) s = s * 3u + 1u; return s; }\n\
        unsigned char u8(unsigned char s, int n) { for (int i = 0; i < n; i++) s = s * 3 + 1; return s; }\n\
        _Bool flag(_Bool s, int n) { for (int i = 0; i < n; i++) s = !s; return s; }\n\
        enum tone tone(enum tone s, int n) { for (int i = 0; i < n; i++) s = (enum tone)(s ^ 1); return s; }\n\
        long wide(long s, int n) { for (int i = 0; i < n; i++) s = s * 3 + 1; return s; }\n\
        unsigned long uwide(unsigned long s, int n) { for (int i = 0; i < n; i++) s = s * 3 + 1; return s; }\n";
    let mut m = Misses::default();
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::WindowsX64] {
        for name in ["u32", "u8", "flag", "tone", "wide", "uwide"] {
            let (body, insts) = optimized_function_full_pool(SRC, name, target);
            let in_memory = insts
                .iter()
                .any(|(_, i)| i.starts_with("LoadLocal") || i.starts_with("StoreLocal"));
            m.expect(!in_memory, || {
                format!("{target:?} {name}: the parameter stays in its slot: {body}")
            });
        }
    }
    m.finish();
}

/// `a /= 10` divides by the same constant as `a = a / 10`.
#[test]
fn compound_division_by_a_constant_takes_no_divide() {
    const SRC: &str = "int tenth(int a) { a /= 10; return a; }\n\
        unsigned rem7(unsigned a) { a %= 7; return a; }\n";
    let mut m = Misses::default();
    for name in ["tenth", "rem7"] {
        let ws = a64(SRC, name);
        // `sdiv` / `udiv`, either width.
        m.expect(!ws.iter().any(|&w| w & 0x7FE0_F800 == 0x1AC0_0800), || {
            format!("aarch64 {name}: a hardware divide: {ws:08x?}")
        });
        let insns = x64(SRC, name);
        // `div` / `idiv` are the /6 and /7 rows of the 0xF7 group.
        let divides = |i: &X64Insn| i.op == 0xF7 && i.modrm.is_some_and(|b| (b >> 3) & 7 >= 6);
        m.expect(!insns.iter().any(divides), || {
            format!("x86-64 {name}: a hardware divide: {insns:x?}")
        });
    }
    m.finish();
}

/// A byte access through an `int` index addresses `base + index` in the
/// access itself.
#[test]
fn byte_index_folds_into_the_access() {
    let mut m = Misses::default();
    for (src, name) in [(COUNT_ZERO, "count_zero"), (MARK, "mark")] {
        let ws = a64(src, name);
        // `ldrb` / `strb` with a register offset.
        m.expect(ws.iter().any(|&w| w & 0xFFA0_0C00 == 0x3820_0800), || {
            format!("aarch64 {name}: no register-offset byte access: {ws:08x?}")
        });
        let insns = x64(src, name);
        let indexed = |i: &X64Insn| {
            i.op != 0x8D && i.sib.is_some_and(|s| (s >> 3) & 7 != 4 || i.rex & 2 != 0)
        };
        m.expect(insns.iter().any(indexed), || {
            format!("x86-64 {name}: no base + index access: {insns:x?}")
        });
    }
    m.finish();
}

/// `ldrsw x0, [x0, w1, sxtw #2]` extends the index inside the access.
#[test]
fn a64_int_index_extends_inside_the_access() {
    const SRC: &str = "long at(const int *a, int i) { return a[i]; }\n";
    let ws = a64(SRC, "at");
    assert!(
        !ws.iter().any(|&w| a64_is_sxtw(w)),
        "a separate sxtw: {ws:08x?}"
    );
}

/// `(option, S)` of an integer load or store with a register offset.
fn a64_reg_offset(w: u32) -> Option<(u32, bool)> {
    (w & 0x3F20_0C00 == 0x3820_0800).then_some(((w >> 13) & 7, w & 0x1000 != 0))
}

const A64_LSL: u32 = 0b011;
const A64_UXTW: u32 = 0b010;
const A64_SXTW: u32 = 0b110;

/// Every element size and both signednesses of the load take an `int`
/// index as `sxtw` and an `unsigned` one as `uxtw`, with no extension left
/// outside the access; a store does the same.
#[test]
fn a64_word_index_extends_at_every_element_size() {
    let mut m = Misses::default();
    let elements = [
        ("signed char", false),
        ("unsigned char", false),
        ("short", true),
        ("unsigned short", true),
        ("int", true),
        ("unsigned", true),
        ("long", true),
    ];
    for (index, option) in [("int", A64_SXTW), ("unsigned", A64_UXTW)] {
        for (ty, scaled) in elements {
            let src = format!(
                "long get(const {ty} *a, {index} i) {{ return a[i]; }}\n\
                 void put({ty} *a, {index} i, {ty} v) {{ a[i] = v; }}\n"
            );
            for name in ["get", "put"] {
                let ws = a64(&src, name);
                let forms: Vec<_> = ws.iter().filter_map(|&w| a64_reg_offset(w)).collect();
                m.expect(forms == [(option, scaled)], || {
                    format!("{ty}[{index}] {name}: {forms:?} in {ws:08x?}")
                });
                // `sxtw xd, wn` / `mov wd, wm` into the access's index register.
                let rm = ws.iter().find(|&&w| a64_reg_offset(w).is_some());
                let rm = rm.map_or(32, |w| (w >> 16) & 31);
                let widens =
                    |w: u32| (a64_is_sxtw(w) || w & 0xFFE0_FFE0 == 0x2A00_03E0) && w & 31 == rm;
                m.expect(!ws.iter().any(|&w| widens(w)), || {
                    format!("{ty}[{index}] {name}: widened outside: {ws:08x?}")
                });
            }
        }
    }
    m.finish();
}

/// The index also reaches a 64-bit addition: the extension keeps its
/// register for that reader, and the access reads the register whole.
#[test]
fn a64_index_extension_with_a_full_width_reader_stays_in_a_register() {
    const SRC: &str = "long keep(const int *a, int n) { int i = n * 3; return a[i] + (long)i; }\n";
    let ws = a64(SRC, "keep");
    assert_eq!(
        ws.iter().filter(|&&w| a64_is_sxtw(w)).count(),
        1,
        "{ws:08x?}"
    );
    let forms: Vec<_> = ws.iter().filter_map(|&w| a64_reg_offset(w)).collect();
    assert_eq!(forms, [(A64_LSL, true)], "{ws:08x?}");
}

/// A `long` index has no extension to take.
#[test]
fn a64_full_width_index_keeps_lsl() {
    const SRC: &str = "long atl(const int *a, long i) { return a[i]; }\n\
        void putl(char *a, long i) { a[i] = 1; }\n";
    for (name, form) in [("atl", (A64_LSL, true)), ("putl", (A64_LSL, false))] {
        let ws = a64(SRC, name);
        let forms: Vec<_> = ws.iter().filter_map(|&w| a64_reg_offset(w)).collect();
        assert_eq!(forms, [form], "{name}: {ws:08x?}");
    }
}

/// x86-64 has no extending index: the same subscripts lower with the
/// index extended in a register, and a floating element, which takes no
/// indexed form, lowers on both targets.
#[test]
fn word_index_lowers_where_no_access_extends_it() {
    const SRC: &str = "long at(const int *a, int i) { return a[i]; }\n\
        void put(short *a, unsigned i, short v) { a[i] = v; }\n\
        double atd(const double *a, int i) { return a[i]; }\n";
    let insns = x64(SRC, "at");
    assert!(insns.iter().any(X64Insn::is_movsxd_rr), "{insns:x?}");
    assert!(!x64(SRC, "put").is_empty() && !x64(SRC, "atd").is_empty());
    let ws = a64(SRC, "atd");
    assert!(ws.iter().all(|&w| a64_reg_offset(w).is_none()), "{ws:08x?}");
}

/// x86-64 stores an immediate byte without a register.
#[test]
fn x64_constant_store_takes_an_immediate() {
    let insns = x64(MARK, "mark");
    assert!(
        insns.iter().any(|i| i.op == 0xC6 && !i.reg_form()),
        "no `mov byte [mem], imm8`: {insns:x?}"
    );
}

/// Every store form writes a constant from the instruction, at each width,
/// through a segment and for a floating constant's bits, with no register
/// loaded. The encodings are clang's.
#[test]
fn x64_constant_store_is_one_instruction_in_every_form() {
    const SRC: &str = "struct s { long a; int b; short c; char d; };\n\
        void fields(struct s *s) { s->a = -5; s->b = 7; s->c = 300; s->d = 'x'; }\n\
        void at(int *a, long i) { a[i] = 42; }\n\
        void frame(void) { volatile int v = 3; }\n\
        void seg(__seg_gs long *p) { *p = -2; }\n\
        void flt(float *f, double *d) { *f = 1.5f; *d = 0.0; }\n";
    let mut m = Misses::default();
    for (name, stores) in [
        (
            "fields",
            &[
                &[0x48u8, 0xC7, 0x07, 0xFB, 0xFF, 0xFF, 0xFF][..],
                &[0xC7, 0x47, 0x08, 0x07, 0x00, 0x00, 0x00],
                &[0x66, 0xC7, 0x47, 0x0C, 0x2C, 0x01],
                &[0xC6, 0x47, 0x0E, 0x78],
            ][..],
        ),
        ("at", &[&[0xC7, 0x04, 0xB7, 0x2A, 0x00, 0x00, 0x00]]),
        ("frame", &[&[0xC7, 0x45, 0xF8, 0x03, 0x00, 0x00, 0x00]]),
        ("seg", &[&[0x65, 0x48, 0xC7, 0x07, 0xFE, 0xFF, 0xFF, 0xFF]]),
        (
            "flt",
            &[
                &[0xC7, 0x07, 0x00, 0x00, 0xC0, 0x3F],
                &[0x48, 0xC7, 0x06, 0x00, 0x00, 0x00, 0x00],
            ],
        ),
    ] {
        let insns = x64_encodings(SRC, name);
        for store in stores {
            m.expect(insns.iter().any(|i| i == store), || {
                format!("{name}: no {store:02x?}: {insns:02x?}")
            });
        }
        // `mov r, imm` in either form, `xor r, r`, `movq xmm, r`.
        let builds_a_register = |i: &X64Insn| {
            matches!(i.op, 0xB8..=0xBF | 0x0F6E)
                || (matches!(i.op, 0xC6 | 0xC7 | 0x31 | 0x33) && i.reg_form())
        };
        let decoded = x64(SRC, name);
        m.expect(!decoded.iter().any(builds_a_register), || {
            format!("{name}: a register is built: {decoded:x?}")
        });
    }
    m.finish();
}

/// A constant keeps its register where the store cannot carry it -- a
/// quadword beyond a sign-extended imm32 -- and where it has another
/// reader, here the returned value.
#[test]
fn x64_constant_store_keeps_a_register_the_constant_needs() {
    const SRC: &str = "void wide(long *p) { *p = 0x80000000L; }\n\
        long twice(long *p, long *q) { return *p = *q = 9; }\n";
    for name in ["wide", "twice"] {
        let insns = x64(SRC, name);
        let imm_store = |i: &X64Insn| matches!(i.op, 0xC6 | 0xC7) && !i.reg_form();
        assert!(!insns.iter().any(imm_store), "{name}: {insns:x?}");
        let reg_store = |i: &X64Insn| i.op == 0x89 && !i.reg_form();
        assert!(insns.iter().any(reg_store), "{name}: {insns:x?}");
    }
}

/// The zero test of a loaded byte reads memory in the compare.
#[test]
fn x64_zero_test_of_a_loaded_byte_reads_memory() {
    let insns = x64(COUNT_ZERO, "count_zero");
    // `cmp byte [mem], imm8` is the /7 row of the 0x80 group.
    let cmp_mem =
        |i: &X64Insn| i.op == 0x80 && !i.reg_form() && i.modrm.is_some_and(|b| (b >> 3) & 7 == 7);
    assert!(
        insns.iter().any(cmp_mem),
        "no `cmp byte [mem], 0`: {insns:x?}"
    );
}

/// The bytes of each instruction of `name`, in order.
fn x64_encodings(src: &str, name: &str) -> Vec<Vec<u8>> {
    let code = function_bytes(&object_at(src, Target::LinuxX64, true), name);
    x64_insns(&code)
        .iter()
        .map(|i| code[i.at..i.at + i.len].to_vec())
        .collect()
}

/// A load that only a branch reads is compared in memory at its own
/// width, whatever its signedness and addressing form; AArch64 keeps the
/// load and its `cbz`.
#[test]
fn x64_zero_test_compares_memory_at_the_load_width() {
    const SRC: &str = "struct s { long a; short b; };\n\
        long z8(const signed char *p) { if (*p) return 1; return 2; }\n\
        long zu8(const unsigned char *p) { if (!*p) return 1; return 2; }\n\
        long z16(const short *p) { if (*p) return 1; return 2; }\n\
        long zu16(const unsigned short *p) { if (*p) return 1; return 2; }\n\
        long z32(const int *p) { if (*p) return 1; return 2; }\n\
        long zu32(const unsigned *p) { if (*p) return 1; return 2; }\n\
        long z64(const long *p) { if (*p) return 1; return 2; }\n\
        long zidx(const int *a, long i) { if (a[i]) return 1; return 2; }\n\
        long zfield(const struct s *s) { if (s->b) return 1; return 2; }\n";
    let mut m = Misses::default();
    for (name, cmp) in [
        ("z8", &[0x80u8, 0x3F, 0x00][..]),
        ("zu8", &[0x80, 0x3F, 0x00]),
        ("z16", &[0x66, 0x83, 0x3F, 0x00]),
        ("zu16", &[0x66, 0x83, 0x3F, 0x00]),
        ("z32", &[0x83, 0x3F, 0x00]),
        ("zu32", &[0x83, 0x3F, 0x00]),
        ("z64", &[0x48, 0x83, 0x3F, 0x00]),
        ("zidx", &[0x83, 0x3C, 0xB7, 0x00]),
        ("zfield", &[0x66, 0x83, 0x7F, 0x08, 0x00]),
    ] {
        let insns = x64_encodings(SRC, name);
        let at = insns.iter().position(|i| i == cmp);
        // The branch follows at once and no register is loaded or tested.
        let jcc = at.and_then(|at| insns.get(at + 1));
        m.expect(jcc.is_some_and(|j| matches!(j[0], 0x74 | 0x75)), || {
            format!("{name}: no `cmp $0, mem; jcc`: {insns:02x?}")
        });
        let loads_or_tests = |i: &Vec<u8>| {
            let op = i.iter().find(|&&b| b != 0x66 && b & 0xF0 != 0x40);
            matches!(op, Some(0x85 | 0x8B | 0x63 | 0x0F))
        };
        m.expect(!insns.iter().any(loads_or_tests), || {
            format!("{name}: a load or a test is left: {insns:02x?}")
        });
        let ws = a64(SRC, name);
        // `cbz` / `cbnz`.
        m.expect(ws.iter().any(|&w| w & 0x7E00_0000 == 0x3400_0000), || {
            format!("aarch64 {name}: {ws:08x?}")
        });
    }
    m.finish();
}

/// The load stays a load when its value has another reader, when it is
/// volatile, and when an instruction between it and the branch writes the
/// flags.
#[test]
fn x64_zero_test_keeps_the_load_where_memory_cannot_stand_in() {
    const SRC: &str = "long other_reader(const signed char *p) {\n\
            signed char c = *p; if (c) return c; return 2; }\n\
        long is_volatile(const volatile char *p) { if (*p) return 1; return 2; }\n\
        long flags_between(const char *p, long a, long b) {\n\
            char c = *p; long s = a + b; if (c) return s; return 2; }\n";
    for name in ["other_reader", "is_volatile", "flags_between"] {
        let insns = x64(SRC, name);
        let cmp_mem = |i: &X64Insn| {
            matches!(i.op, 0x80 | 0x83)
                && !i.reg_form()
                && i.modrm.is_some_and(|b| (b >> 3) & 7 == 7)
        };
        assert!(!insns.iter().any(cmp_mem), "{name}: {insns:x?}");
        // `movsx r64, m8` and `test r, r`.
        assert!(
            insns.iter().any(|i| i.op == 0x0FBE && !i.reg_form())
                && insns.iter().any(|i| i.op == 0x85 && i.reg_form()),
            "{name}: {insns:x?}"
        );
    }
}

/// A comparison that reaches its branch through a one-input phi -- the
/// second operand of `&&`, the return of an inlined predicate -- decides
/// the branch through the flags.
#[test]
fn comparison_behind_a_join_branches_on_the_flags() {
    const BOTH: &str = "int g(int);\n\
        int both(int a, int b) { if (a < 3 && b < 7) return g(a); return 0; }\n";
    let mut m = Misses::default();
    for (src, name) in [(TALLY, "tally"), (BOTH, "both")] {
        let ws = a64(src, name);
        // `cset`: `csinc rd, zr, zr, cond`.
        m.expect(!ws.iter().any(|&w| w & 0x7FFF_0FE0 == 0x1A9F_07E0), || {
            format!("aarch64 {name}: cset: {ws:08x?}")
        });
        let insns = x64(src, name);
        m.expect(
            !insns.iter().any(|i| matches!(i.op, 0x0F90..=0x0F9F)),
            || format!("x86-64 {name}: setcc: {insns:x?}"),
        );
    }
    m.finish();
}

/// The SSA dump of `name`, at `-O` or at the default level.
pub(super) fn ssa_dump(src: &str, name: &str, optimize: bool) -> String {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind};
    let target = Target::LinuxX64;
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(optimize),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile: {e}"));
    let native = if optimize {
        NativeOptions::new().with_optimize()
    } else {
        NativeOptions::new()
    };
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..native.with_dump_ssa()
    };
    let dump = crate::c5::codegen::lower_for(&program, target, opts)
        .unwrap_or_else(|e| panic!("lower: {e:?}"))
        .ssa_dump;
    let head = format!("; name={name}\n");
    let start = dump.find(&head).expect("function in the dump") + head.len();
    let body = &dump[start..];
    body.split("\n; ").next().unwrap_or(body).to_string()
}

/// The `-O` pipeline hands the allocator no one-input phi and no block
/// that only continues its single predecessor; the default level keeps
/// the blocks the walker made.
#[test]
fn straight_line_blocks_are_merged_at_o_only() {
    const BOTH: &str = "int g(int);\n\
        int both(int a, int b) { if (a < 3 && b < 7) return g(a); return 0; }\n";
    let blocks = |dump: &str| dump.matches("\n  block ").count();
    // A phi whose incoming list closes after its first entry.
    let one_input = |dump: &str| {
        dump.lines().any(|l| {
            l.split_once("Phi { incoming=[")
                .is_some_and(|(_, rest)| !rest.split(']').next().unwrap_or("").contains(','))
        })
    };
    for (src, name) in [(TALLY, "tally"), (BOTH, "both")] {
        let dump = ssa_dump(src, name, true);
        assert!(!one_input(&dump), "{name}: a one-input phi:\n{dump}");
    }
    // Entry test, second test, the call, `return 0`.
    let dump = ssa_dump(BOTH, "both", true);
    assert_eq!(blocks(&dump), 4, "{dump}");
    let dump = ssa_dump(BOTH, "both", false);
    assert_eq!(blocks(&dump), 5, "{dump}");
}

/// The divisor is a constant once `dv` is inlined.
#[test]
fn division_by_an_inlined_constant_takes_no_divide() {
    const SRC: &str = "static int dv(int a, int d) { return a / d; }\n\
        int tenth(int a) { return dv(a, 10); }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "tenth");
    m.expect(!ws.iter().any(|&w| w & 0x7FE0_F800 == 0x1AC0_0800), || {
        format!("aarch64: a hardware divide: {ws:08x?}")
    });
    let insns = x64(SRC, "tenth");
    let divides = |i: &X64Insn| i.op == 0xF7 && i.modrm.is_some_and(|b| (b >> 3) & 7 >= 6);
    m.expect(!insns.iter().any(divides), || {
        format!("x86-64: a hardware divide: {insns:x?}")
    });
    m.finish();
}

/// `a[i] * a[i]` reads the element once.
#[test]
fn repeated_indexed_load_reads_memory_once() {
    const SRC: &str = "long sq(const int *a, int i) { return (long)a[i] * a[i]; }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "sq");
    // `ldrsw` with a register offset.
    let n = ws
        .iter()
        .filter(|&&w| w & 0xFFE0_0C00 == 0xB8A0_0800)
        .count();
    m.expect(n == 1, || format!("aarch64: {n} loads: {ws:08x?}"));
    let insns = x64(SRC, "sq");
    let n = insns
        .iter()
        .filter(|i| i.op == 0x63 && !i.reg_form())
        .count();
    m.expect(n == 1, || format!("x86-64: {n} loads: {insns:x?}"));
    m.finish();
}

/// `free` returns nothing, so its call site has no result to extend.
#[test]
fn void_external_call_result_is_not_extended() {
    let mut m = Misses::default();
    let ws = a64(DROP, "drop");
    // `uxtb w0, w0`.
    m.expect(!ws.contains(&0x5300_1C00), || {
        format!("aarch64: uxtb w0: {ws:08x?}")
    });
    let insns = x64(DROP, "drop");
    // `movzx rax, al`.
    let movzx_al = |i: &X64Insn| i.op == 0x0FB6 && i.modrm == Some(0xC0);
    m.expect(!insns.iter().any(movzx_al), || {
        format!("x86-64: movzbq %al: {insns:x?}")
    });
    m.finish();
}

/// A `void` prototype reaches the binding as `void`, not as the `unsigned
/// char` whose band the tag shares, and asks for no extension; the
/// `unsigned char` of the same band asks for its own.
#[test]
fn void_binding_asks_for_no_extension() {
    use crate::c5::codegen::{ReturnExt, return_extension};
    use crate::c5::compiler::types::is_void_ty;
    let program = crate::Compiler::with_target(
        "#pragma dylib(libc, \"libc.so.6\")\n\
         #pragma binding(libc::ext_void, \"ext_void\")\n\
         #pragma binding(libc::ext_uchar, \"ext_uchar\")\n\
         void ext_void(void);\n\
         unsigned char ext_uchar(void);\n\
         int main(void) { ext_void(); return ext_uchar(); }\n"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let tag = |name: &str| {
        program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter())
            .find(|b| b.local_name == name)
            .unwrap_or_else(|| panic!("binding {name}"))
            .return_type_tag
    };
    assert!(is_void_ty(tag("ext_void")));
    assert!(!is_void_ty(tag("ext_uchar")));
    for target in [
        Target::LinuxX64,
        Target::WindowsX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsAarch64,
    ] {
        assert_eq!(return_extension(tag("ext_void"), target), ReturnExt::None);
        assert_eq!(return_extension(tag("ext_uchar"), target), ReturnExt::Zero8);
    }
}

/// `long` is 4 bytes on LLP64 and 8 on LP64, and `return_is_low_word` is
/// asked before the target is fixed, so it answers for the types that are
/// narrow on every target and for no others. `char` shares tag 0 with "no
/// prototype recorded", which is why it is out as well.
#[test]
fn only_target_independent_narrow_returns_ride_the_low_word() {
    use crate::c5::codegen::return_is_low_word;
    use crate::c5::compiler::types::{UNSIGNED_BIT, void_ty};
    use crate::c5::token::Ty;
    for ty in [Ty::Bool, Ty::Short, Ty::Int] {
        assert!(return_is_low_word(ty as i64), "{ty:?}");
        assert!(
            return_is_low_word(ty as i64 | UNSIGNED_BIT),
            "unsigned {ty:?}"
        );
        assert!(!return_is_low_word(ty as i64 + Ty::Ptr as i64), "{ty:?} *");
    }
    for ty in [Ty::Char, Ty::Long, Ty::LongLong, Ty::Float, Ty::Double] {
        assert!(!return_is_low_word(ty as i64), "{ty:?}");
    }
    assert!(!return_is_low_word(void_ty()));
    assert!(!return_is_low_word(0));
}

/// Imports returning each narrow integer type, read (`read_*`) and called for
/// effect (`drop_*`).
const NARROW_RESULTS: &str = "#pragma dylib(libc, \"libc.so.6\")\n\
    #pragma binding(libc::ext_bool, \"ext_bool\")\n\
    #pragma binding(libc::ext_uchar, \"ext_uchar\")\n\
    #pragma binding(libc::ext_short, \"ext_short\")\n\
    #pragma binding(libc::ext_ushort, \"ext_ushort\")\n\
    _Bool ext_bool(void);\n\
    unsigned char ext_uchar(void);\n\
    short ext_short(void);\n\
    unsigned short ext_ushort(void);\n\
    int read_bool(void) { return ext_bool(); }\n\
    int read_uchar(void) { return ext_uchar(); }\n\
    int read_short(void) { return ext_short(); }\n\
    int read_ushort(void) { return ext_ushort(); }\n\
    void drop_bool(void) { ext_bool(); }\n\
    void drop_uchar(void) { ext_uchar(); }\n\
    void drop_short(void) { ext_short(); }\n\
    void drop_ushort(void) { ext_ushort(); }\n";

/// `(function suffix, AArch64 word, x86-64 two-byte opcode)` of the extension
/// each narrow result takes in the return register: `uxtb w0`, `sxth x0`,
/// `uxth w0`; `movzx` / `movsx` of `al` / `ax` into `rax`.
const NARROW_EXTENSIONS: [(&str, u32, u16); 4] = [
    ("bool", 0x5300_1C00, 0x0FB6),
    ("uchar", 0x5300_1C00, 0x0FB6),
    ("short", 0x9340_3C00, 0x0FBF),
    ("ushort", 0x5300_3C00, 0x0FB7),
];

/// The host ABIs leave the bits above a narrow result unspecified, so a
/// result that is read is extended at the call site.
#[test]
fn read_narrow_external_result_keeps_its_extension() {
    let mut m = Misses::default();
    for (ty, word, op) in NARROW_EXTENSIONS {
        let name = format!("read_{ty}");
        let ws = a64(NARROW_RESULTS, &name);
        m.expect(ws.contains(&word), || {
            format!("aarch64 {name}: no {word:08x}: {ws:08x?}")
        });
        let insns = x64(NARROW_RESULTS, &name);
        let extends = |i: &X64Insn| i.op == op && i.rex_w() && i.modrm == Some(0xC0);
        m.expect(insns.iter().any(extends), || {
            format!("x86-64 {name}: no {op:#x} on rax: {insns:x?}")
        });
    }
    m.finish();
}

/// A result nothing reads takes no extension, whatever its width.
#[test]
fn unread_narrow_external_result_is_not_extended() {
    let mut m = Misses::default();
    for (ty, word, op) in NARROW_EXTENSIONS {
        let name = format!("drop_{ty}");
        let ws = a64(NARROW_RESULTS, &name);
        m.expect(!ws.contains(&word), || {
            format!("aarch64 {name}: {word:08x}: {ws:08x?}")
        });
        let insns = x64(NARROW_RESULTS, &name);
        let extends = |i: &X64Insn| i.op == op && i.modrm == Some(0xC0);
        m.expect(!insns.iter().any(extends), || {
            format!("x86-64 {name}: {op:#x} on rax: {insns:x?}")
        });
    }
    m.finish();
}

/// One function per return width, plus a callee defined here and the three
/// ways a caller reads its result: at 32 bits, at 64, and as a zero test.
const RETURN_WIDTHS: &str = "int ret_int(int n) { return n * 3; }\n\
    unsigned ret_uint(unsigned n) { return n * 3u; }\n\
    long ret_long(long n) { return n * 3; }\n\
    long widen_int(int n) { return n * 3; }\n\
    short ret_short(short n) { return (short)(n * 3); }\n\
    signed char ret_char(signed char n) { return (signed char)(n * 3); }\n\
    __attribute__((noinline)) static int callee(int n) { return n + 1; }\n\
    int caller_low(int n) { return callee(n) + 1; }\n\
    long caller_wide(int n) { return callee(n); }\n\
    int caller_test(int n) { if (callee(n)) return 7; return 9; }\n";

/// An `int` / `unsigned` result occupies the low word of the return
/// register and bits 32..63 carry none of it, so the epilogue renormalizes
/// nothing. A `long` return reads the whole register and keeps its
/// extension, and a `short` / `char` return keeps the narrowing to its own
/// width -- that width is part of the result.
#[test]
fn a_low_word_return_is_not_renormalized() {
    let mut m = Misses::default();
    // `sxth x0, w0` / `sxtb x0, w0`, and `movsx rax, ax` / `movsx rax, al`.
    for (name, extended, word, op) in [
        ("ret_int", false, 0x9340_7C00u32, 0x63u16),
        ("ret_uint", false, 0x2A00_03E0, 0x89),
        ("ret_long", false, 0x9340_7C00, 0x63),
        ("widen_int", true, 0x9340_7C00, 0x63),
        ("ret_short", true, 0x9340_3C00, 0x0FBF),
        ("ret_char", true, 0x9340_1C00, 0x0FBE),
    ] {
        let ws = a64(RETURN_WIDTHS, name);
        // Every shape here extends the return register, so the word is exact.
        let a64_has = ws.contains(&word);
        m.expect(a64_has == extended, || {
            format!("aarch64 {name}: {word:08x} present={a64_has}: {ws:08x?}")
        });
        let insns = x64(RETURN_WIDTHS, name);
        let x64_has = insns
            .iter()
            .any(|i| i.op == op && i.modrm == Some(0xC0) && (op == 0x89 || i.rex_w()));
        m.expect(x64_has == extended, || {
            format!("x86-64 {name}: {op:#x} present={x64_has}: {insns:x?}")
        });
    }
    m.finish();
}

/// The reading side widens the result instead: a caller that reads a
/// same-unit `int` call at 64 bits extends it, one that reads its low word
/// or tests it against zero does not.
#[test]
fn a_call_result_is_extended_where_it_is_read_wide() {
    let mut m = Misses::default();
    for (name, extended) in [
        ("caller_low", false),
        ("caller_wide", true),
        ("caller_test", false),
    ] {
        let ws = a64(RETURN_WIDTHS, name);
        // The argument's own entry extension sits ahead of the `bl`.
        let after_call = ws.iter().position(|&w| w & 0xFC00_0000 == 0x9400_0000);
        let tail = &ws[after_call.map_or(0, |i| i + 1)..];
        m.expect(tail.iter().any(|&w| a64_is_sxtw(w)) == extended, || {
            format!("aarch64 {name}: sxtw after the call != {extended}: {ws:08x?}")
        });
        let insns = x64(RETURN_WIDTHS, name);
        let after = insns.iter().position(|i| i.op == 0xE8).map_or(0, |i| i + 1);
        m.expect(
            insns[after..].iter().any(X64Insn::is_movsxd_rr) == extended,
            || format!("x86-64 {name}: movslq after the call != {extended}: {insns:x?}"),
        );
    }
    m.finish();
}

/// No lowering in `drop` writes x19, so the frame has no slot for it.
#[test]
fn a64_external_call_alone_does_not_save_x19() {
    let ws = a64(DROP, "drop");
    let saves = |w: u32| {
        let str_sp = w & 0xFFC0_03FF == 0xF900_03F3 || w & 0xFFE0_0FFF == 0xF800_0FF3;
        let pair = w & 0x7E40_0000 == 0x2800_0000 && (w & 31 == 19 || (w >> 10) & 31 == 19);
        str_sp || pair
    };
    assert!(!ws.iter().any(|&w| saves(w)), "x19 saved: {ws:08x?}");
}

/// x19 is saved in exactly the functions a lowering writes it in. Capped to
/// one or two registers per bank, a modulo's dividend, divisor and result all
/// spill and the quotient takes x19; with a register to spare it does not.
#[test]
fn a64_x19_is_saved_exactly_where_it_is_written() {
    const SRC: &str = "long rem(long a, long b, long c, long d) {\n\
        long r = a % b; long s = c % d; long t = (a + c) % (b + d);\n\
        return r * s + t - a - b - c - d;\n}\n";
    // `sdiv` / `udiv` into x19; `str x19, [sp, #imm]` or the pre-indexed form.
    let divides_into_x19 = |w: u32| w & 0xFFE0_F81F == 0x9AC0_0813;
    let saves_x19 = |w: u32| w & 0xFFC0_03FF == 0xF900_03F3 || w & 0xFFE0_0FFF == 0xF800_0FF3;
    let mut written = 0;
    for caps in [(1, 1), (2, 2), (3, 3), (usize::MAX, usize::MAX)] {
        let ws = function_words(&object_with_pool(SRC, Target::LinuxAarch64, caps), "rem");
        let writes = ws.iter().any(|&w| divides_into_x19(w));
        let saves = ws.iter().any(|&w| saves_x19(w));
        assert_eq!(writes, saves, "caps {caps:?}: {ws:08x?}");
        written += usize::from(writes);
    }
    assert!(written > 0, "no cap reached the spilled modulo");
}

/// The bias of a signed division by 2 is the sign bit: one logical shift.
#[test]
fn signed_halving_reads_the_sign_bit_once() {
    let mut m = Misses::default();
    let ws = a64(MID, "mid");
    // `asr xd, xn, #63`.
    m.expect(!ws.iter().any(|&w| w & 0xFFFF_FC00 == 0x937F_FC00), || {
        format!("aarch64: asr #63: {ws:08x?}")
    });
    let insns = x64(MID, "mid");
    let sar63 = |i: &X64Insn| {
        i.op == 0xC1 && i.rex_w() && i.imm == 63 && i.modrm.is_some_and(|b| (b >> 3) & 7 == 7)
    };
    m.expect(!insns.iter().any(sar63), || {
        format!("x86-64: sar $63: {insns:x?}")
    });
    m.finish();
}

/// The base case of `fib` reaches its `ret` without building the frame.
#[test]
#[ignore = "TODO: an early return pays the whole prologue and epilogue"]
fn early_return_precedes_the_frame() {
    let mut m = Misses::default();
    let ws = a64(FIB, "fib");
    let guard = ws
        .iter()
        .enumerate()
        .position(|(i, &w)| matches!(a64_branch(w, i), Some((_, false))));
    // A pre-indexed store or pair through sp, or `sub sp, sp, #imm`.
    let moves_sp = |w: u32| {
        let rn_sp = (w >> 5) & 31 == 31;
        (w & 0x3B20_0C00 == 0x3800_0C00 && rn_sp)
            || (w & 0x3FC0_0000 == 0x2980_0000 && rn_sp)
            || w & 0xFF80_03FF == 0xD100_03FF
    };
    let frame = ws.iter().position(|&w| moves_sp(w));
    m.expect(guard.is_some_and(|g| frame.is_none_or(|f| g < f)), || {
        format!("aarch64: the frame precedes the guard: {ws:08x?}")
    });
    let insns = x64(FIB, "fib");
    let guard = insns.iter().position(X64Insn::is_jcc);
    let frame = insns.iter().position(|i| matches!(i.op, 0x50..=0x57));
    m.expect(guard.is_some_and(|g| frame.is_none_or(|f| g < f)), || {
        format!("x86-64: the frame precedes the guard: {insns:x?}")
    });
    m.finish();
}

/// `b - t` with `t` already in the result register needs no staging copy.
#[test]
fn x64_reversed_subtract_takes_no_staging_copy() {
    const SRC: &str = "long sub_rev(long a, long b) { long t = a * 3; return b - t; }\n";
    let insns = x64(SRC, "sub_rev");
    assert!(insns.len() <= 4, "{} instructions: {insns:x?}", insns.len());
}

/// A reversed floating quotient keeps the divisor out of the result's
/// register, so `divsd` reads it where it was computed, not from one of
/// the scratch registers xmm13..xmm15.
#[test]
fn x64_reversed_fp_quotient_takes_no_staging_copy() {
    const SRC: &str = "double fdiv_rev(double a, double b) { double t = a * 3.0; return b / t; }\n";
    let insns = x64(SRC, "fdiv_rev");
    let div = insns.iter().find(|i| i.op == 0x0F5E);
    assert!(div.is_some_and(|d| d.regs().1 < 13), "{insns:x?}");
}

fn saves_rcx(i: &X64Insn) -> bool {
    matches!(i.op, 0x51 | 0x59) && i.rex & 1 == 0
}

/// A variable shift in a loop takes its count in rcx and keeps the loop's
/// values out of it, so rcx is not saved around the shift.
#[test]
fn x64_variable_shift_saves_no_rcx() {
    const SRC: &str = "unsigned long ones(unsigned long v, int n) {\n\
        unsigned long acc = 0;\n\
        for (int i = 0; i < n; i++) acc += (v >> i) & 1;\n\
        return acc;\n}\n";
    let insns = x64(SRC, "ones");
    assert!(!insns.iter().any(saves_rcx), "{insns:x?}");
}

/// A value that arrives in rcx and is read after a variable shift -- a
/// fourth parameter -- leaves rcx to the count instead of being saved.
#[test]
fn x64_variable_shift_moves_a_live_value_out_of_rcx() {
    const SRC: &str =
        "long past_fourth(long x, long c, long z, long k) { return (x << c) + k + z; }\n";
    let insns = x64(SRC, "past_fourth");
    assert!(!insns.iter().any(saves_rcx), "{insns:x?}");
}

/// `push r` or `pop r` of a low register `r`.
fn saves(i: &X64Insn, r: u16) -> bool {
    (i.op == 0x50 + r || i.op == 0x58 + r) && i.rex & 1 == 0
}

/// A one-operand `mul`, `imul`, `div` or `idiv`: the F7 group, /4 to /7.
fn uses_rdx_rax(i: &X64Insn) -> bool {
    i.op == 0xF7 && i.modrm.is_some_and(|m| (m >> 3) & 7 >= 4)
}

/// A division, a remainder and a division by a constant (a high multiply)
/// save neither rax nor rdx when neither holds a value across them, on
/// either x86-64 convention and at either width.
#[test]
fn x64_division_saves_nothing_it_does_not_clobber() {
    const SRC: &str = "long q2(long a, long b) { return a / b * 3; }\n\
        long r2(long a, long b) { return a % b + 1; }\n\
        unsigned long uq(unsigned long a, unsigned long b) { return a / b; }\n\
        int iq(int a, int b, int c) { return a / b + c; }\n\
        unsigned ur(unsigned a, unsigned b) { return a % b; }\n\
        long long by7(long long a) { return a / 7; }\n";
    let mut m = Misses::default();
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let obj = object_at(SRC, target, true);
        for name in ["q2", "r2", "uq", "iq", "ur", "by7"] {
            let insns = x64_insns(&function_bytes(&obj, name));
            let saved = insns.iter().any(|i| saves(i, 0) || saves(i, 2));
            m.expect(insns.iter().any(uses_rdx_rax) && !saved, || {
                format!("{target:?} {name}: {insns:x?}")
            });
        }
    }
    m.finish();
}

/// Six values live across a division, one more than the caller-saved
/// registers outside rdx:rax, leave the sixth in rdx, which the division
/// saves around itself; nothing is live in rax, which it does not save.
#[test]
fn x64_division_saves_rdx_a_live_value_holds() {
    const SRC: &str = "long keep(long a, long b, long c, long d, long e, long f) {\n\
        long q = a / b;\n\
        return q + a + b + c + d + e + f;\n}\n";
    let insns = x64(SRC, "keep");
    let div = insns.iter().position(uses_rdx_rax);
    let push = insns.iter().position(|i| saves(i, 2) && i.op == 0x52);
    let pop = insns.iter().position(|i| saves(i, 2) && i.op == 0x5A);
    let around = div
        .zip(push.zip(pop))
        .is_some_and(|(d, (p, q))| p < d && d < q);
    assert!(around, "{insns:x?}");
    assert!(!insns.iter().any(|i| saves(i, 0)), "{insns:x?}");
}

/// The parameter's entry extension reads the incoming register.
#[test]
fn parameter_entry_extension_is_one_instruction() {
    let mut m = Misses::default();
    let ws = a64(FIB, "fib");
    let copy_then_extend = ws.windows(2).any(|p| {
        let mov = p[0] & 0xFFE0_FFE0 == 0xAA00_03E0;
        let rd = p[0] & 31;
        mov && a64_is_sxtw(p[1]) && p[1] & 31 == rd && (p[1] >> 5) & 31 == rd
    });
    m.expect(!copy_then_extend, || {
        format!("aarch64: mov + sxtw: {ws:08x?}")
    });
    let insns = x64(FIB, "fib");
    let copy_then_extend = insns.windows(2).any(|p| {
        let mov = matches!(p[0].op, 0x89 | 0x8B) && p[0].rex_w() && p[0].reg_form();
        let rd = if p[0].op == 0x89 {
            p[0].regs().1
        } else {
            p[0].regs().0
        };
        mov && p[1].is_movsxd_rr() && p[1].regs() == (rd, rd)
    });
    m.expect(!copy_then_extend, || {
        format!("x86-64: mov + movslq: {insns:x?}")
    });
    m.finish();
}

/// Each narrow kind converts in its entry move, also where the home is the
/// incoming register.
#[test]
fn narrow_parameter_converts_in_its_entry_move() {
    const SRC: &str = "long w8(signed char c) { return c; }\n\
        long w16(short s) { return s; }\n\
        long w32(int n) { return n; }\n";
    const RET: u32 = 0xD65F_03C0;
    let mut m = Misses::default();
    // `sxtb` / `sxth` / `sxtw x0, w0`; `movsbq %dil` / `movswq %di` /
    // `movslq %edi` into %rax.
    for (name, sbfm, op) in [
        ("w8", 0x9340_1C00, 0x0FBE),
        ("w16", 0x9340_3C00, 0x0FBF),
        ("w32", 0x9340_7C00, 0x63),
    ] {
        let ws = a64(SRC, name);
        m.expect(ws == [sbfm, RET], || format!("aarch64 {name}: {ws:08x?}"));
        let insns = x64(SRC, name);
        let one = insns.len() == 2
            && insns[0].op == op
            && insns[0].rex_w()
            && insns[0].regs() == (0, 7)
            && insns[1].op == 0xC3;
        m.expect(one, || format!("x86-64 {name}: {insns:x?}"));
    }
    m.finish();
}

/// The `int` entry conversion is left out where only the low word is read;
/// a `signed char` one is not, since it sets the low word too.
#[test]
fn parameter_conversion_follows_the_bits_read() {
    const SRC: &str = "void put(int n, int *p) { *p = n; }\n\
        void put8(signed char c, int *p) { *p = c; }\n";
    // SBFM of either width: the `sxt*` forms.
    let sbfm = |ws: &[u32]| {
        ws.iter()
            .filter(|&&w| w & 0x7F80_0000 == 0x1300_0000)
            .count()
    };
    let movsx = |insns: &[X64Insn]| {
        insns
            .iter()
            .filter(|i| matches!(i.op, 0x63 | 0x0FBE | 0x0FBF))
            .count()
    };
    let mut m = Misses::default();
    let ws = a64(SRC, "put");
    m.expect(sbfm(&ws) == 0, || format!("aarch64 put: {ws:08x?}"));
    let ws = a64(SRC, "put8");
    m.expect(sbfm(&ws) == 1, || format!("aarch64 put8: {ws:08x?}"));
    let insns = x64(SRC, "put");
    m.expect(movsx(&insns) == 0, || format!("x86-64 put: {insns:x?}"));
    let insns = x64(SRC, "put8");
    m.expect(movsx(&insns) == 1, || format!("x86-64 put8: {insns:x?}"));
    m.finish();
}

/// Nothing reads the counter above bit 31: the multiply, the increment and
/// the 32-bit compare use its low word. The one extension left is the result's.
#[test]
fn unread_block_exit_value_keeps_no_extension() {
    const SRC: &str = "int low_only(int n) {\n\
        int s = 0;\n\
        for (int i = 0; i < n; i++) s += i * 3;\n\
        return s;\n}\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "low_only");
    let n = ws.iter().filter(|&&w| a64_is_sxtw(w)).count();
    m.expect(n <= 1, || format!("aarch64: {n} sxtw: {ws:08x?}"));
    let insns = x64(SRC, "low_only");
    let n = insns.iter().filter(|i| i.is_movsxd_rr()).count();
    m.expect(n <= 1, || format!("x86-64: {n} movslq: {insns:x?}"));
    m.finish();
}

/// `sqrt` lowers to one instruction, which needs no frame and no scratch.
#[test]
fn inline_intrinsic_keeps_the_leaf_frameless() {
    const SRC: &str = "#include <math.h>\ndouble root(double x) { return sqrt(x); }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "root");
    m.expect(ws.len() == 2, || format!("aarch64: {ws:08x?}"));
    let insns = x64(SRC, "root");
    m.expect(insns.len() == 2, || format!("x86-64: {insns:x?}"));
    m.finish();
}

/// `stp x29, x30, [sp, #imm]`, pre-indexed or at an offset: the frame record.
fn a64_has_frame_record(ws: &[u32]) -> bool {
    ws.iter().any(|&w| {
        matches!(w & 0xFFC0_0000, 0xA980_0000 | 0xA900_0000)
            && w & 31 == 29
            && (w >> 10) & 31 == 30
            && (w >> 5) & 31 == 31
    })
}

/// `push rbp`.
fn x64_has_frame_record(insns: &[X64Insn]) -> bool {
    insns.iter().any(|i| i.op == 0x55 && i.rex == 0)
}

/// `munchausen.c`'s predicate: the loop's values fit the caller-saved
/// registers once the reads of instructions no emitter lowers -- the
/// division's pieces the value numbering merged away -- keep nothing live,
/// so neither target saves a register or takes a frame.
#[test]
fn munchausen_predicate_is_a_frameless_leaf() {
    const SRC: &str = "int cache[10];\n\
        _Bool is_munchausen(const int number) {\n\
        int n = number;\n\
        int total = 0;\n\
        while (n > 0) {\n\
            int digit = n % 10;\n\
            total += cache[digit];\n\
            if (total > number) return 0;\n\
            n = n / 10;\n\
        }\n\
        return total == number;\n}\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "is_munchausen");
    m.expect(!a64_has_frame_record(&ws), || format!("aarch64: {ws:08x?}"));
    let insns = x64(SRC, "is_munchausen");
    let pushes = insns.iter().any(|i| matches!(i.op, 0x50..=0x57));
    m.expect(!pushes, || format!("x86-64: {insns:x?}"));
    m.finish();
}

/// Intrinsics that lower to register and memory instructions leave a leaf
/// without a frame record: the rounding and absolute-value forms, a trap, a
/// `va_list` walked by the cursor or System V forms, and a thread-local
/// access that is no call.
#[test]
fn register_only_intrinsics_keep_the_leaf_frameless() {
    const SRC: &str = "#include <math.h>\n\
        _Thread_local int tv;\n\
        double rounds(double x) { return floor(x) + ceil(x) + trunc(x) + fabs(x); }\n\
        float rootf(float x) { return sqrtf(x); }\n\
        void trap(void) { __builtin_trap(); }\n\
        int tls(void) { return tv; }\n";
    let mut m = Misses::default();
    for name in ["rounds", "rootf", "trap", "tls"] {
        let ws = a64(SRC, name);
        m.expect(!a64_has_frame_record(&ws), || {
            format!("aarch64 {name}: {ws:08x?}")
        });
        let insns = x64(SRC, name);
        m.expect(!x64_has_frame_record(&insns), || {
            format!("x86-64 {name}: {insns:x?}")
        });
    }
    m.finish();
}

/// An intrinsic whose lowering reads the frame pointer, the stack pointer or
/// the return slot, or moves the stack pointer, keeps the frame record in a
/// function that holds nothing else. The stack pointer a function reads is
/// then not above the frame pointer another reads at the same depth, which
/// `register_var_stack_pointer.c` checks at run time.
#[test]
fn frame_bound_intrinsics_keep_the_frame_record() {
    const SRC: &str = "#include <stdarg.h>\n\
        #if defined(__x86_64__)\n\
        #define SP \"rsp\"\n\
        #else\n\
        #define SP \"sp\"\n\
        #endif\n\
        void *frame(void) { return __builtin_frame_address(0); }\n\
        void *ret(void) { return __builtin_return_address(0); }\n\
        unsigned long stack(void) { register unsigned long sp asm(SP); return sp; }\n\
        void copy(va_list *d, va_list *s) { va_copy(*d, *s); }\n\
        long first(int n, ...) { va_list ap; va_start(ap, n); long r = va_arg(ap, long);\n\
            va_end(ap); return r; }\n";
    let mut m = Misses::default();
    for name in ["frame", "ret", "stack", "copy", "first"] {
        let ws = a64(SRC, name);
        m.expect(a64_has_frame_record(&ws), || {
            format!("aarch64 {name}: {ws:08x?}")
        });
        let insns = x64(SRC, name);
        m.expect(x64_has_frame_record(&insns), || {
            format!("x86-64 {name}: {insns:x?}")
        });
    }
    m.finish();
}

/// The Mach-O thread-local access calls the descriptor's routine through
/// `blr`, which overwrites x30: the same function that is a frameless leaf on
/// ELF keeps its frame record there.
#[test]
fn macho_thread_local_access_keeps_the_frame_record() {
    const SRC: &str = "_Thread_local int tv;\nint tls(void) { return tv; }\n";
    let ws = function_words(&object_at(SRC, Target::MacOSAarch64, true), "tls");
    // `blr xn`.
    assert!(
        ws.iter().any(|&w| w & 0xFFFF_FC1F == 0xD63F_0000),
        "{ws:08x?}"
    );
    assert!(a64_has_frame_record(&ws), "{ws:08x?}");
}

/// The x86-64 frame of `fib`: a 16-byte `sub` fits the imm8 form, a
/// callee-saved register is saved by `push`, and zeroing a low register
/// needs no REX.W.
#[test]
fn x64_frame_takes_the_short_encodings() {
    let mut m = Misses::default();
    let insns = x64(FIB, "fib");
    let long_sub =
        |i: &X64Insn| i.op == 0x81 && i.modrm == Some(0xEC) && i8::try_from(i.imm).is_ok();
    m.expect(!insns.iter().any(long_sub), || {
        format!("`sub rsp, imm32` for a small frame: {insns:x?}")
    });
    // `push rbx`.
    m.expect(insns.iter().any(|i| i.op == 0x53 && i.rex == 0), || {
        format!("rbx saved by a store: {insns:x?}")
    });
    let insns = x64(COUNT_ZERO, "count_zero");
    let wide_zero =
        |i: &X64Insn| i.op == 0x31 && i.rex == 0x48 && i.reg_form() && i.regs().0 == i.regs().1;
    m.expect(!insns.iter().any(wide_zero), || {
        format!("`xor r64, r64` on a low register: {insns:x?}")
    });
    m.finish();
}

/// A 32-bit zero test of a sum whose high half nothing else reads branches
/// on the low word: `cbz w` / `test r32`, with no compare and no entry
/// extension of the operands.
#[test]
fn wrapped_zero_test_branches_on_the_low_word() {
    const SRC: &str = "int nz(int a, int b) { if ((a + b) != 0) return 1; return 0; }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "nz");
    // `cbz` / `cbnz` with sf = 0.
    let cbz_w = |w: u32| w & 0xFE00_0000 == 0x3400_0000;
    m.expect(ws.iter().any(|&w| cbz_w(w)), || {
        format!("aarch64: no cbz w: {ws:08x?}")
    });
    m.expect(
        !ws.iter()
            .any(|&w| a64_is_sxtw(w) || w & 0xFF20_001F == 0x7100_001F),
        || format!("aarch64: an extension or a compare: {ws:08x?}"),
    );
    let insns = x64(SRC, "nz");
    let test32 = |i: &X64Insn| i.op == 0x85 && !i.rex_w() && i.reg_form();
    m.expect(insns.iter().any(test32), || {
        format!("x86-64: no test r32: {insns:x?}")
    });
    m.expect(!insns.iter().any(X64Insn::is_movsxd_rr), || {
        format!("x86-64: an entry extension: {insns:x?}")
    });
    m.finish();
}

/// A branch on a 32-bit conversion of a 64-bit value tests the low word:
/// `cbz w` / `test r32`, with no sign or zero extension into a scratch
/// register.
#[test]
fn zero_test_of_a_32_bit_conversion_branches_on_the_low_word() {
    const SRC: &str = "\
long long ls32(long long k, long long x) { long long n = 0; for (; (int)k; k += x) n++; return n; }\n\
long long lu32(long long k, long long x) { long long n = 0; for (; (unsigned)k; k += x) n++; return n; }\n";
    let mut m = Misses::default();
    for name in ["ls32", "lu32"] {
        let ws = a64(SRC, name);
        // `cbz` / `cbnz`, sf = 0 and sf = 1.
        let cbz = |w: u32, sf: u32| w & 0xFE00_0000 == 0x3400_0000 | sf << 31;
        m.expect(
            ws.iter().any(|&w| cbz(w, 0)) && !ws.iter().any(|&w| cbz(w, 1)),
            || format!("aarch64 {name}: not cbz w: {ws:08x?}"),
        );
        m.expect(
            !ws.iter().any(|&w| a64_is_sxtw(w) || a64_is_mask(w)),
            || format!("aarch64 {name}: an extension: {ws:08x?}"),
        );
        let insns = x64(SRC, name);
        let test = |i: &X64Insn| i.op == 0x85 && i.reg_form();
        m.expect(
            insns.iter().any(test) && !insns.iter().any(|i| test(i) && i.rex_w()),
            || format!("x86-64 {name}: not test r32: {insns:x?}"),
        );
        m.expect(
            !insns.iter().any(|i| i.is_movsxd_rr() || x64_is_mask(i)),
            || format!("x86-64 {name}: an extension: {insns:x?}"),
        );
    }
    m.finish();
}

/// Unoptimized, `k` lives in its frame slot and the branch on `(int)k`
/// reads that slot once. It compares the low word (the loop runs while
/// bits 0..31 are not all zero), never the quadword: `cmpq $0, mem` loops
/// forever on `k = 1 << 32`.
#[test]
fn x64_low_word_test_of_a_slot_compares_four_bytes() {
    const SRC: &str = "long long lw(long long x) { long long n = 0;\n\
for (long long k = 1LL << 32; (int)k; k += x) n++; return n; }\n";
    let insns = x64_at(SRC, "lw", false);
    // `cmp r/m64, imm8` (83 /7) against 0 on a memory operand.
    let quad_zero_cmp = |i: &X64Insn| {
        i.op == 0x83
            && i.rex_w()
            && !i.reg_form()
            && i.modrm.is_some_and(|m| (m >> 3) & 7 == 7)
            && i.imm == 0
    };
    assert!(
        !insns.iter().any(quad_zero_cmp),
        "the low-word test compares the quadword: {insns:x?}"
    );
}

/// An aarch64 indirect call whose target sits in a register no argument
/// lands in calls through it; a target in a register an argument takes
/// moves out of the way first, and the call reads the copy.
#[test]
fn a64_indirect_call_takes_its_target_where_the_arguments_leave_it() {
    const SRC: &str = "long call1(long (*f)(long), long a) { return f(a) + 1; }\n\
int g_x, g_y, g_out; void (*g_adder)(int *, int, int);\n\
int driver(void) { g_x = 7; g_y = 35; g_adder(&g_out, g_x, g_y); return g_out; }\n";
    let blr = |ws: &[u32]| {
        ws.iter()
            .find(|&&w| w & 0xFFFF_FC1F == 0xD63F_0000)
            .map(|&w| (w >> 5) & 31)
    };
    // `mov xd, xm` (`orr xd, xzr, xm`) into the called register.
    let copied_into = |ws: &[u32], rd: u32| {
        ws.iter()
            .any(|&w| w & 0xFFE0_FFE0 == 0xAA00_03E0 && w & 31 == rd)
    };
    let ws = a64(SRC, "driver");
    let r = blr(&ws).expect("driver calls through a register");
    assert!(
        !copied_into(&ws, r),
        "driver: the target is copied: {ws:08x?}"
    );
    let ws = a64(SRC, "call1");
    let r = blr(&ws).expect("call1 calls through a register");
    assert!(
        r != 0 && copied_into(&ws, r),
        "call1: the call reads x0 or no copy: {ws:08x?}"
    );
}

/// A value whose own register hint is taken leaves the hints of the
/// values still to be colored alone, so the arguments of a call land in
/// their registers: no rotation through x16 ahead of the call.
#[test]
fn call_arguments_need_no_rotation() {
    const SRC: &str = "int g_x, g_y, g_out; void (*g_adder)(int *, int, int);\n\
int driver(void) { g_x = 7; g_y = 35; g_adder(&g_out, g_x, g_y); return g_out; }\n";
    let ws = a64(SRC, "driver");
    // `mov x16, xN` (`orr x16, xzr, xN`).
    let to_x16 = |w: u32| w & 0xFFE0_FFFF == 0xAA00_03F0;
    assert!(
        !ws.iter().any(|&w| to_x16(w)),
        "the arguments rotate through x16: {ws:08x?}"
    );
}

/// A self tail call under a constant accumulator -- `1 + f(x)`,
/// `f(x) - k`, `f(x) * 2` folded to a shift -- becomes a loop: the
/// functions call nothing.
#[test]
fn tail_call_under_a_constant_accumulator_becomes_a_loop() {
    const SRC: &str = "long depth(const unsigned char *pc) { if (*pc) return 1 + depth(pc + 1); return 0; }\n\
long down(long n) { if (n) return down(n - 1) - 3; return 100; }\n\
long twice(long n) { if (n) return twice(n - 1) * 2; return 1; }\n";
    let mut m = Misses::default();
    for name in ["depth", "down", "twice"] {
        let ws = a64(SRC, name);
        // `bl`
        m.expect(!ws.iter().any(|&w| w & 0xFC00_0000 == 0x9400_0000), || {
            format!("aarch64 {name}: a call: {ws:08x?}")
        });
        let insns = x64(SRC, name);
        m.expect(!insns.iter().any(|i| i.op == 0xE8), || {
            format!("x86-64 {name}: a call: {insns:x?}")
        });
    }
    m.finish();
}

/// A branch on a mask it alone reads tests the bits in place: aarch64
/// `tbz` / `tbnz` for one bit in either half, x86-64 `test $imm` at the
/// narrowest width that holds the mask, or `bt` for a bit above them. No
/// `and` into a scratch register.
#[test]
fn zero_test_of_a_mask_tests_the_bits_in_place() {
    const SRC: &str = "int m1(long k) { if (k & 1) return 3; return 5; }\n\
int m40(long k) { if (k & (1L << 40)) return 3; return 5; }\n\
int mneg(long k) { if (k & -8) return 3; return 5; }\n";
    let mut m = Misses::default();
    let and_imm = |w: u32| w & 0x7F80_0000 == 0x1200_0000;
    for (name, bit) in [("m1", 0), ("m40", 40)] {
        let ws = a64(SRC, name);
        let tb =
            |w: u32| w & 0x7E00_0000 == 0x3600_0000 && ((w >> 31) << 5 | (w >> 19) & 31) == bit;
        m.expect(
            ws.iter().any(|&w| tb(w)) && !ws.iter().any(|&w| and_imm(w)),
            || format!("aarch64 {name}: not tbz #{bit}: {ws:08x?}"),
        );
    }
    let slash = |i: &X64Insn| i.modrm.map_or(8, |m| (m >> 3) & 7);
    let and = |i: &X64Insn| {
        matches!(i.op, 0x21 | 0x23 | 0x24 | 0x25) || (matches!(i.op, 0x81 | 0x83) && slash(i) == 4)
    };
    type Form = fn(&X64Insn) -> bool;
    let cases: [(&str, Form); 3] = [
        ("m1", |i| i.op == 0xF6 && i.imm == 1 && !i.rex_w()),
        ("m40", |i| i.op == 0x0FBA && i.imm == 40 && i.rex_w()),
        ("mneg", |i| i.op == 0xF7 && i.imm == -8 && i.rex_w()),
    ];
    for (name, form) in cases {
        let insns = x64(SRC, name);
        m.expect(
            insns.iter().any(|i| form(i) && matches!(slash(i), 0 | 4)) && !insns.iter().any(and),
            || format!("x86-64 {name}: the mask is not tested in place: {insns:x?}"),
        );
    }
    m.finish();
}

/// A volatile element at a constant index, and a packed field at an
/// unaligned offset, are one access through the base with the offset in
/// the instruction, as a plain field is: no separate `lea` / `add`.
#[test]
fn volatile_or_packed_access_takes_its_offset_in_the_instruction() {
    const SRC: &str = "void g(volatile unsigned *r) { r[4] = 0; }\n\
unsigned h(volatile unsigned *r) { return r[3]; }\n\
struct __attribute__((packed)) P { char c; int x; long y; };\n\
int gx(struct P *p) { return p->x; }\n\
void sy(struct P *p, long v) { p->y = v; }\n";
    let mut m = Misses::default();
    for name in ["g", "h", "gx", "sy"] {
        let ws = a64(SRC, name);
        let add_imm = |w: u32| w & 0xFF00_0000 == 0x9100_0000;
        // A load or store of one register with a non-zero immediate
        // offset: the scaled form (bit 24) or the unscaled one.
        let at_offset = |w: u32| {
            (w & 0x3B00_0000 == 0x3900_0000 && (w >> 10) & 0xFFF != 0)
                || (w & 0x3B20_0C00 == 0x3800_0000 && (w >> 12) & 0x1FF != 0)
        };
        m.expect(
            ws.iter().any(|&w| at_offset(w)) && !ws.iter().any(|&w| add_imm(w)),
            || format!("aarch64 {name}: the offset is not in the access: {ws:08x?}"),
        );
        let insns = x64(SRC, name);
        m.expect(!insns.iter().any(|i| i.op == 0x8D), || {
            format!("x86-64 {name}: a lea: {insns:x?}")
        });
    }
    m.finish();
}

/// A constant passed before and after a call is set again after it, not
/// kept across it in a callee-saved register: the registers that survive
/// the calls hold the target, `x` and the first result only.
#[test]
fn constant_is_not_kept_across_a_call() {
    const SRC: &str = "long twice(long (*f)(long, long, long, long, long, long, long), long x) {\n\
long a = f(x, 1, 2, 3, 4, 5, 6);\n\
return a + f(x, 6, 5, 4, 3, 2, 1);\n}\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "twice");
    // `movz` / `movn` of either width into x19..x28.
    let imm_to_saved = |w: u32| {
        w & 0x1F80_0000 == 0x1280_0000 && (w >> 29) & 3 != 3 && (19..=28).contains(&(w & 31))
    };
    m.expect(!ws.iter().any(|&w| imm_to_saved(w)), || {
        format!("aarch64: a constant in a callee-saved register: {ws:08x?}")
    });
    let insns = x64(SRC, "twice");
    let callee_saved = |r: u8| matches!(r, 3 | 12..=15);
    let imm_dst = |i: &X64Insn| match i.op {
        0xB8..=0xBF => Some((i.op as u8 & 7) | ((i.rex & 1) << 3)),
        0xC7 if i.reg_form() => Some(i.regs().1),
        _ => None,
    };
    m.expect(
        !insns.iter().any(|i| imm_dst(i).is_some_and(callee_saved)),
        || format!("x86-64: a constant in a callee-saved register: {insns:x?}"),
    );
    let pushes = insns.iter().filter(|i| matches!(i.op, 0x50..=0x57)).count();
    m.expect(pushes == 4, || {
        format!("x86-64: {pushes} pushes, not rbp and three: {insns:x?}")
    });
    m.finish();
}

/// An indirect call whose target sits in a register the argument moves
/// leave alone calls through it: no copy to a scratch, no spill. Here the
/// target survives the first call in a callee-saved register.
#[test]
fn x64_indirect_call_takes_its_target_in_place() {
    const SRC: &str = "long twice(long (*f)(long, long, long, long, long, long, long), long x) {\n\
long a = f(x, 1, 2, 3, 4, 5, 6);\n\
return a + f(x, 6, 5, 4, 3, 2, 1);\n}\n";
    let insns = x64(SRC, "twice");
    let callee_saved = |r: u8| matches!(r, 3 | 5 | 12..=15);
    let calls: Vec<u8> = insns
        .iter()
        .filter(|i| i.op == 0xFF && i.reg_form() && i.modrm.is_some_and(|m| (m >> 3) & 7 == 2))
        .map(|i| i.regs().1)
        .collect();
    assert!(
        calls.len() == 2 && calls.iter().all(|&r| callee_saved(r)),
        "the calls do not take the target where it lives: {insns:x?}"
    );
}

/// A negated floating constant is a constant: no sign flip at run time,
/// for a literal, a float, a stored zero and an inlined negation.
#[test]
fn negated_floating_constant_is_folded() {
    const SRC: &str = "double f(void) { return -2.5; }\n\
void g(double *d) { *d = -0.0; }\n\
float h(void) { return -2.5f; }\n\
static double neg(double x) { return -x; }\n\
double k(void) { return neg(1.5); }\n";
    let mut m = Misses::default();
    for name in ["f", "g", "h", "k"] {
        let ws = a64(SRC, name);
        // `fneg` of either precision.
        let fneg = |w: u32| w & 0xFF3F_FC00 == 0x1E21_4000;
        m.expect(!ws.iter().any(|&w| fneg(w)), || {
            format!("aarch64 {name}: fneg: {ws:08x?}")
        });
        let insns = x64(SRC, name);
        // `xorps` / `xorpd`.
        m.expect(!insns.iter().any(|i| i.op == 0x0F57), || {
            format!("x86-64 {name}: a sign flip: {insns:x?}")
        });
    }
    m.finish();
}

/// A floating comparison that an `int` result carries into a branch
/// fuses into the branch: no flag materialized, masked and retested.
#[test]
fn floating_compare_through_an_int_result_fuses_into_the_branch() {
    const SRC: &str = "static int lt(double a, double b) { return a < b; }\n\
int flt(double a, double b) { if (lt(a, b)) return 2; return 3; }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "flt");
    let fcmp = |w: u32| w & 0xFF20_FC1F == 0x1E20_2000;
    // `cset` / `csinc` of either width.
    let cset = |w: u32| w & 0x7FE0_0C00 == 0x1A80_0400;
    m.expect(
        ws.iter().any(|&w| fcmp(w)) && !ws.iter().any(|&w| cset(w)),
        || format!("aarch64: the comparison is materialized: {ws:08x?}"),
    );
    let insns = x64(SRC, "flt");
    let setcc = |i: &X64Insn| matches!(i.op, 0x0F90..=0x0F9F);
    m.expect(
        insns.iter().any(|i| i.op == 0x0F2E) && !insns.iter().any(setcc),
        || format!("x86-64: the comparison is materialized: {insns:x?}"),
    );
    m.finish();
}

/// `fmov <Dd>|<Sd>, #imm8`: `Some((single, imm8))`.
fn a64_fmov_imm(w: u32) -> Option<(bool, u8)> {
    (w & 0xFF20_1FE0 == 0x1E20_1000 && (w >> 22) & 3 < 2)
        .then_some(((w >> 22) & 3 == 0, (w >> 13) as u8))
}

/// `fmov <Dd>, <Xn>` or `fmov <Sd>, <Wn>`: a general register's bits
/// moved to an FP register.
fn a64_gpr_to_fp(w: u32) -> bool {
    w & 0xFFFF_FC00 == 0x9E67_0000 || w & 0xFFFF_FC00 == 0x1E27_0000
}

/// `movz` / `movn` / `movk` of either width.
fn a64_move_wide(w: u32) -> bool {
    w & 0x1F80_0000 == 0x1280_0000
}

/// `adrp` followed by an unsigned-offset `ldr` of a d (`single`: s)
/// register through the register the `adrp` wrote.
fn a64_literal_load(ws: &[u32], single: bool) -> bool {
    let ldr = if single { 0xBD40_0000 } else { 0xFD40_0000 };
    ws.windows(2).any(|p| {
        p[0] & 0x9F00_0000 == 0x9000_0000
            && p[1] & 0xFFC0_0000 == ldr
            && (p[1] >> 5) & 31 == p[0] & 31
    })
}

/// A floating constant only floating readers take is built in the FP
/// register they read: `fmov #imm8` in its own precision, `movi` for +0.0,
/// one integer move and a transfer for a pattern one move builds, and a
/// read-only literal past that -- also on a phi's edge.
#[test]
fn a64_floating_constants_are_built_in_fp_registers() {
    const SRC: &str = "double imm(double x) { return x * 2.5 + 1.0; }\n\
float immf(float x) { return x * 2.5f + 0.5f; }\n\
double zero(double x) { return x + 0.0; }\n\
double one_move(double x) { return x * 100.0; }\n\
double lit(double x) { return x > 0.001 ? x : 0.001; }\n\
float litf(float x) { return x * 0.1f; }\n\
double phi(int c) { return c ? 2.5 : 0.001; }\n";
    let mut m = Misses::default();
    let imm8s =
        |ws: &[u32]| -> Vec<(bool, u8)> { ws.iter().filter_map(|&w| a64_fmov_imm(w)).collect() };
    let crosses = |ws: &[u32]| ws.iter().any(|&w| a64_gpr_to_fp(w));
    let moves = |ws: &[u32]| ws.iter().filter(|&&w| a64_move_wide(w)).count();
    let ws = a64(SRC, "imm");
    m.expect(
        imm8s(&ws) == [(false, 0x04), (false, 0x70)] && !crosses(&ws) && moves(&ws) == 0,
        || format!("imm: not two double fmov #imm8: {ws:08x?}"),
    );
    let ws = a64(SRC, "immf");
    m.expect(
        imm8s(&ws) == [(true, 0x04), (true, 0x60)] && !crosses(&ws) && moves(&ws) == 0,
        || format!("immf: not two float fmov #imm8: {ws:08x?}"),
    );
    let ws = a64(SRC, "zero");
    m.expect(
        ws.iter().any(|&w| w & 0xFFFF_FFE0 == 0x2F00_E400) && !crosses(&ws) && moves(&ws) == 0,
        || format!("zero: not movi #0: {ws:08x?}"),
    );
    let ws = a64(SRC, "one_move");
    m.expect(
        moves(&ws) == 1 && crosses(&ws) && !a64_literal_load(&ws, false),
        || format!("one_move: not one move and a transfer: {ws:08x?}"),
    );
    for (name, single) in [("lit", false), ("litf", true)] {
        let ws = a64(SRC, name);
        m.expect(
            a64_literal_load(&ws, single) && !crosses(&ws) && moves(&ws) == 0,
            || format!("{name}: not a literal load: {ws:08x?}"),
        );
    }
    let ws = a64(SRC, "phi");
    m.expect(
        a64_literal_load(&ws, false) && imm8s(&ws) == [(false, 0x04)] && moves(&ws) == 0,
        || format!("phi: the incomes are not built in place: {ws:08x?}"),
    );
    m.finish();
}

/// A constant only a floating phi reads is rebuilt on the phi's edges:
/// nothing defines it in a general register.
#[test]
fn a64_constant_only_a_phi_reads_has_no_definition() {
    const SRC: &str = "double k(int c, double y) { double r = c ? 1.0 : 0.001; return r * y; }\n";
    let ws = a64(SRC, "k");
    assert!(
        !ws.iter().any(|&w| a64_move_wide(w)),
        "k: a constant is built in a general register: {ws:08x?}"
    );
}

/// The negative side: a constant an integer store also reads keeps its
/// general register, and the floating reader takes a transfer of it.
#[test]
fn a64_constant_with_an_integer_reader_stays_in_a_general_register() {
    const SRC: &str = "double m(double x, long *p) { *p = 0x4004000000000000; return x * 2.5; }\n";
    let ws = a64(SRC, "m");
    assert!(
        ws.iter().any(|&w| a64_gpr_to_fp(w)) && !ws.iter().any(|&w| a64_fmov_imm(w).is_some()),
        "m: the shared constant left the general register: {ws:08x?}"
    );
}

/// Rd, Rn and Rm of an FP arithmetic instruction, two-source or fused,
/// of either precision.
fn a64_fp_arith_regs(w: u32) -> Option<[u32; 3]> {
    (w & 0xFF20_0C00 == 0x1E20_0800 || w & 0xFF00_0000 == 0x1F00_0000).then_some([
        w & 31,
        (w >> 5) & 31,
        (w >> 16) & 31,
    ])
}

/// Twelve floating values live at once take the volatile registers past
/// the argument ones -- d19..d31 on AArch64, xmm8..xmm12 on System V
/// x86-64 -- before a callee-saved register that costs a save, or a spill.
#[test]
fn floating_pressure_takes_the_volatile_registers_first() {
    const SRC: &str = "double spread(double a, double b) {\n\
double v0 = a + 1.0, v1 = a + 2.0, v2 = a + 3.0, v3 = a + 4.0;\n\
double v4 = b + 5.0, v5 = b + 6.0, v6 = b + 7.0, v7 = b + 8.0;\n\
double v8 = a * b, v9 = a - b, v10 = a * 3.0, v11 = b * 5.0;\n\
return v0 * v1 + v2 * v3 + v4 * v5 + v6 * v7 + v8 * v9 + v10 * v11;\n}\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "spread");
    // A SIMD&FP load or store: the body reads and writes no memory.
    let fp_mem = |w: u32| w & 0x0E00_0000 == 0x0C00_0000;
    let high = |w: u32| a64_fp_arith_regs(w).is_some_and(|rs| rs.iter().any(|&r| r >= 19));
    m.expect(
        !ws.iter().any(|&w| fp_mem(w)) && ws.iter().any(|&w| high(w)),
        || format!("aarch64: a save or a spill: {ws:08x?}"),
    );
    let insns = x64(SRC, "spread");
    // `movss` / `movsd` / `movaps` / `movq` to memory.
    let spill = |i: &X64Insn| matches!(i.op, 0x0F11 | 0x0F29 | 0x0FD6) && !i.reg_form();
    let high = |i: &X64Insn| {
        let (reg, rm) = i.regs();
        matches!(i.op, 0x0F58 | 0x0F59 | 0x0F5C)
            && ((8..=12).contains(&reg) || i.reg_form() && (8..=12).contains(&rm))
    };
    m.expect(!insns.iter().any(spill) && insns.iter().any(high), || {
        format!("x86-64: a spill: {insns:x?}")
    });
    m.finish();
}

/// One function per count and width.
const COUNTS: &str = "int clz32(unsigned x) { return __builtin_clz(x); }\n\
int cls32(int x) { return __builtin_clrsb(x); }\n\
int cls64(long long x) { return __builtin_clrsbll(x); }\n\
int clz64(unsigned long long x) { return __builtin_clzll(x); }\n\
int ctz32(unsigned x) { return __builtin_ctz(x); }\n\
int ctz64(unsigned long long x) { return __builtin_ctzll(x); }\n\
int pop32(unsigned x) { return __builtin_popcount(x); }\n\
int pop64(unsigned long long x) { return __builtin_popcountll(x); }\n";

/// `clz Wd, Wn`, or `clz Xd, Xn` when `is64`.
fn a64_clz(w: u32, is64: bool) -> bool {
    w & 0xFFFF_FC00 == if is64 { 0xDAC0_1000 } else { 0x5AC0_1000 }
}

/// `cls Wd, Wn`, or `cls Xd, Xn` when `is64`.
fn a64_cls(w: u32, is64: bool) -> bool {
    w & 0xFFFF_FC00 == if is64 { 0xDAC0_1400 } else { 0x5AC0_1400 }
}

/// `rbit Wd, Wn`, or `rbit Xd, Xn` when `is64`.
fn a64_rbit(w: u32, is64: bool) -> bool {
    w & 0xFFFF_FC00 == if is64 { 0xDAC0_0000 } else { 0x5AC0_0000 }
}

/// A SIMD&FP data-processing instruction, or a load / store of a SIMD&FP
/// register.
fn a64_touches_simd_fp(w: u32) -> bool {
    (w >> 25) & 7 == 7 || ((w >> 25) & 5 == 4 && w & (1 << 26) != 0)
}

/// The walker lowers every bit-count builtin to one `Inst::BitCount` of the
/// builtin's width, with clrsb, ffs and parity built on the clz, ctz and
/// popcount of it.
#[test]
fn bit_count_builtins_lower_to_one_instruction() {
    use crate::c5::ir::{BitCountOp, Inst};
    const SRC: &str = "int a(unsigned x) { return __builtin_clz(x); }\n\
int b(unsigned long long x) { return __builtin_clzll(x); }\n\
int c(unsigned x) { return __builtin_ctz(x); }\n\
int d(unsigned long long x) { return __builtin_ctzll(x); }\n\
int e(unsigned x) { return __builtin_popcount(x); }\n\
int f(unsigned long long x) { return __builtin_popcountll(x); }\n\
int g(int x) { return __builtin_clrsb(x); }\n\
int h(long long x) { return __builtin_clrsbll(x); }\n\
int i(int x) { return __builtin_ffs(x); }\n\
int j(long long x) { return __builtin_ffsll(x); }\n\
int k(unsigned x) { return __builtin_parity(x); }\n\
int l(unsigned long long x) { return __builtin_parityll(x); }\n";
    let target = Target::LinuxX64;
    let program = crate::Compiler::with_options(
        SRC.to_string(),
        target,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
        .expect("produce_ssa_funcs");
    let mut m = Misses::default();
    for (name, want) in [
        ("a", (BitCountOp::Clz, 4)),
        ("b", (BitCountOp::Clz, 8)),
        ("c", (BitCountOp::Ctz, 4)),
        ("d", (BitCountOp::Ctz, 8)),
        ("e", (BitCountOp::Popcount, 4)),
        ("f", (BitCountOp::Popcount, 8)),
        ("g", (BitCountOp::Clrsb, 4)),
        ("h", (BitCountOp::Clrsb, 8)),
        ("i", (BitCountOp::Ctz, 4)),
        ("j", (BitCountOp::Ctz, 8)),
        ("k", (BitCountOp::Popcount, 4)),
        ("l", (BitCountOp::Popcount, 8)),
    ] {
        let f = funcs.iter().find(|f| f.name == name).expect(name);
        let counts: Vec<_> = f
            .insts
            .iter()
            .filter_map(|i| match *i {
                Inst::BitCount { op, width, .. } => Some((op, width)),
                _ => None,
            })
            .collect();
        m.expect(counts == [want] && f.insts.len() < 16, || {
            format!("{name}: {counts:?} in {:?}", f.insts)
        });
    }
    m.finish();
}

/// AArch64 counts with `clz`, `rbit` + `clz` and `cnt` + `addv` through a
/// SIMD register, in the `W` forms for the 32-bit builtins: a zero operand
/// gives the register width with no further instruction.
#[test]
fn a64_bit_counts_take_the_count_instructions() {
    let mut m = Misses::default();
    for (name, is64) in [("clz32", false), ("clz64", true)] {
        let ws = a64(COUNTS, name);
        m.expect(ws.len() == 2 && a64_clz(ws[0], is64), || {
            format!("{name}: not one clz: {ws:08x?}")
        });
    }
    // `__builtin_clrsb` is `cls`, one instruction at both widths.
    for (name, is64) in [("cls32", false), ("cls64", true)] {
        let ws = a64(COUNTS, name);
        m.expect(ws.len() == 2 && a64_cls(ws[0], is64), || {
            format!("{name}: not one cls: {ws:08x?}")
        });
    }
    for (name, is64) in [("ctz32", false), ("ctz64", true)] {
        let ws = a64(COUNTS, name);
        m.expect(
            ws.len() == 3 && a64_rbit(ws[0], is64) && a64_clz(ws[1], is64),
            || format!("{name}: not rbit + clz: {ws:08x?}"),
        );
    }
    // `fmov s|d, w|x`; `cnt v.8b`; `addv b, v.8b`; `fmov w, s`.
    for (name, stage) in [("pop32", 0x1E27_0000), ("pop64", 0x9E67_0000)] {
        let ws = a64(COUNTS, name);
        let classes = [stage, 0x0E20_5800, 0x0E31_B800, 0x1E26_0000];
        m.expect(
            ws.len() == 5 && ws.iter().zip(classes).all(|(&w, c)| w & 0xFFFF_FC00 == c),
            || format!("{name}: not fmov + cnt + addv + fmov: {ws:08x?}"),
        );
    }
    m.finish();
}

/// x86-64 counts with `bsr` / `bsf` and `popcnt` at the builtin's operand
/// size, never `lzcnt` / `tzcnt`: a zero operand sets ZF, and `cmovz` then
/// takes `2 * bits - 1` into the `xor bits - 1` for clz, `bits` for ctz.
#[test]
fn x64_bit_counts_take_the_base_instructions() {
    let obj = object_at(COUNTS, Target::LinuxX64, true);
    let mut m = Misses::default();
    for (name, wide, scan, zero, flip) in [
        ("clz32", false, 0x0FBD, 63, Some(31)),
        ("clz64", true, 0x0FBD, 127, Some(63)),
        ("ctz32", false, 0x0FBC, 32, None),
        ("ctz64", true, 0x0FBC, 64, None),
    ] {
        let bytes = function_bytes(&obj, name);
        let insns = x64_insns(&bytes);
        // `bsr` / `bsf` without the F3 prefix that makes `lzcnt` / `tzcnt`.
        let found = insns
            .iter()
            .find(|i| i.op == scan && bytes[i.at] != 0xF3 && i.rex_w() == wide);
        let ok = found.is_some_and(|s| {
            let dst = s.regs().0;
            let seeded = |r: u8| {
                insns.iter().any(|i| {
                    (0xB8..=0xBF).contains(&i.op)
                        && (i.op as u8 & 7) | ((i.rex & 1) << 3) == r
                        && i.imm == zero
                })
            };
            let cmov = insns
                .iter()
                .find(|i| i.op == 0x0F44 && i.reg_form() && i.regs().0 == dst);
            let xor = |k: i64| {
                insns.iter().any(|i| {
                    matches!(i.op, 0x81 | 0x83)
                        && i.modrm.is_some_and(|m| (m >> 3) & 7 == 6)
                        && i.regs().1 == dst
                        && i.imm == k
                })
            };
            cmov.is_some_and(|c| seeded(c.regs().1)) && flip.is_none_or(xor)
        });
        m.expect(ok && insns.len() <= 5, || {
            format!("{name}: not the zero-guarded scan: {insns:x?}")
        });
    }
    for (name, wide) in [("pop32", false), ("pop64", true)] {
        let bytes = function_bytes(&obj, name);
        let insns = x64_insns(&bytes);
        m.expect(
            insns.len() == 2
                && insns[0].op == 0x0FB8
                && bytes[insns[0].at] == 0xF3
                && insns[0].rex_w() == wide,
            || format!("{name}: not one popcnt: {insns:x?}"),
        );
    }
    // `clrsb` keeps the `clz((x ^ (x << 1)) | 1)` expansion -- x86-64 has
    // no leading-sign-bit count -- but the `or` makes the operand
    // non-zero, so no `cmovz` guards the scan.
    for (name, wide) in [("cls32", false), ("cls64", true)] {
        let insns = x64_insns(&function_bytes(&obj, name));
        m.expect(
            insns.iter().any(|i| i.op == 0x0FBD && i.rex_w() == wide)
                && !insns.iter().any(|i| i.op == 0x0F44)
                && insns.len() <= 7,
            || format!("{name}: not the unguarded expansion: {insns:x?}"),
        );
    }
    m.finish();
}

/// One function per negation shape, then the shapes the rewrite must
/// leave alone: unary plus, a multiply by a constant that is not -1, a
/// subtraction from a non-zero constant, and a floating negation.
const NEGATES: &str = "int negi(int n) { return -n; }\n\
long negl(long n) { return -n; }\n\
unsigned negu(unsigned n) { return -n; }\n\
long zero_minus(long n) { return 0 - n; }\n\
long times_minus_one(long n) { return n * -1; }\n\
long sub_of_neg(long a, long b) { return a - (-b); }\n\
long neg_minus_one(long n) { return -n - 1; }\n\
long negneg(long n) { return -(-n); }\n\
int posi(int n) { return +n; }\n\
long posl(long n) { return +n; }\n\
long times_minus_two(long n) { return n * -2; }\n\
long const_minus(long n) { return 5 - n; }\n\
double negd(double x) { return -x; }\n";

/// The same source with `+` in place of the unary minus, to compare the
/// two against each other rather than against a shape written down here.
const PLUSES: &str = "int posi(int n) { return +n; }\n\
long posl(long n) { return +n; }\n\
int idi(int n) { return n; }\n\
long idl(long n) { return n; }\n";

/// The walker lowers integer `-x` to one `Inst::Neg`: no multiply, no
/// subtraction, no constant to materialise. C99 6.5.3.3p2 makes unary
/// plus the promoted operand, so `+n` emits what `n` alone emits, and a
/// floating operand keeps `Inst::Fneg` (6.5.3.3p3).
#[test]
fn integer_negation_lowers_to_one_negate() {
    use crate::c5::ir::{BinOp, Inst};
    let target = Target::LinuxX64;
    let funcs = |src: &str| {
        let program = crate::Compiler::with_options(
            src.to_string(),
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
            .expect("produce_ssa_funcs")
    };
    let negates = funcs(NEGATES);
    let count = |name: &str, pick: fn(&Inst) -> bool| {
        negates
            .iter()
            .find(|f| f.name == name)
            .unwrap_or_else(|| panic!("{name}"))
            .insts
            .iter()
            .filter(|i| pick(i))
            .count()
    };
    let negs = |i: &Inst| matches!(i, Inst::Neg(_));
    let muls = |i: &Inst| {
        matches!(
            i,
            Inst::Binop { op: BinOp::Mul, .. } | Inst::BinopI { op: BinOp::Mul, .. }
        )
    };
    let subs = |i: &Inst| {
        matches!(
            i,
            Inst::Binop { op: BinOp::Sub, .. } | Inst::BinopI { op: BinOp::Sub, .. }
        )
    };
    let mut m = Misses::default();
    for name in ["negi", "negl", "negu"] {
        m.expect(
            count(name, negs) == 1 && count(name, muls) == 0 && count(name, subs) == 0,
            || format!("{name}: not one negate and nothing else"),
        );
    }
    // The negative side: neither a multiply by another constant nor a
    // subtraction from a non-zero one is a negation, and the walker
    // leaves both alone.
    m.expect(
        count("times_minus_two", negs) == 0 && count("times_minus_two", muls) == 1,
        || "times_minus_two: the multiply is gone".to_string(),
    );
    m.expect(
        count("const_minus", negs) == 0 && count("const_minus", subs) == 1,
        || "const_minus: the subtraction is gone".to_string(),
    );
    m.expect(
        count("negd", negs) == 0 && count("negd", |i| matches!(i, Inst::Fneg(_))) == 1,
        || "negd: not a floating negation".to_string(),
    );
    // C99 6.5.3.3p2: `+n` is the promoted operand, nothing more.
    let pluses = funcs(PLUSES);
    let body = |name: &str| {
        pluses
            .iter()
            .find(|f| f.name == name)
            .unwrap_or_else(|| panic!("{name}"))
            .insts
            .iter()
            .map(Inst::variant_name)
            .collect::<Vec<_>>()
    };
    m.expect(
        body("posi") == body("idi") && body("posl") == body("idl"),
        || {
            format!(
                "unary plus emits {:?} where the operand alone emits {:?}",
                body("posi"),
                body("idi")
            )
        },
    );
    m.finish();
}

/// `NEG <Xd>, <Xm>`, the `SUB Xd, XZR, Xm` alias with no shift.
fn a64_neg(w: u32) -> bool {
    w & 0xFFE0_FFE0 == 0xCB00_03E0
}

/// `MUL <Xd>, <Xn>, <Xm>` (`MADD` with `Ra = XZR`), either width.
fn a64_mul(w: u32) -> bool {
    w & 0x7FE0_FC00 == 0x1B00_7C00
}

/// AArch64 negates with one `neg`: no constant register, no multiply.
/// The folds that reach the same instruction -- `0 - x`, `x * -1` -- land
/// there too, and the ones that cancel it leave nothing behind.
#[test]
fn a64_negation_takes_one_neg() {
    let mut m = Misses::default();
    // `neg x0, x0` then `ret`. An `int` / `unsigned` result rides the
    // low word of the return register, so the narrow forms renormalize
    // no more than the wide ones.
    for name in ["negl", "zero_minus", "times_minus_one", "negi", "negu"] {
        let ws = a64(NEGATES, name);
        m.expect(
            ws.len() == 2 && a64_neg(ws[0]) && !ws.iter().any(|&w| a64_mul(w)),
            || format!("{name}: not one neg: {ws:08x?}"),
        );
    }
    // `-(-x)` is `x`: the body is the return alone.
    let ws = a64(NEGATES, "negneg");
    m.expect(ws.len() == 1, || {
        format!("negneg: not just a return: {ws:08x?}")
    });
    // `a - -b` is `add`, `-x - 1` is `mvn`: neither keeps a negate.
    let ws = a64(NEGATES, "sub_of_neg");
    let a64_add = |w: u32| w & 0xFFE0_FC00 == 0x8B00_0000;
    m.expect(ws.len() == 2 && a64_add(ws[0]), || {
        format!("sub_of_neg: not one add: {ws:08x?}")
    });
    let ws = a64(NEGATES, "neg_minus_one");
    let a64_mvn = |w: u32| w & 0xFFE0_FFE0 == 0xAA20_03E0;
    m.expect(ws.len() == 2 && a64_mvn(ws[0]), || {
        format!("neg_minus_one: not one mvn: {ws:08x?}")
    });
    // The negative side keeps its multiply and its subtraction.
    let ws = a64(NEGATES, "times_minus_two");
    m.expect(
        ws.iter().any(|&w| a64_mul(w)) && !ws.iter().any(|&w| a64_neg(w)),
        || format!("times_minus_two: not a multiply: {ws:08x?}"),
    );
    let ws = a64(NEGATES, "const_minus");
    m.expect(!ws.iter().any(|&w| a64_neg(w)), || {
        format!("const_minus: a negate: {ws:08x?}")
    });
    m.finish();
}

/// A live negation between a comparison and the branch that reads it:
/// x86-64 `neg` writes the flags, so the comparison cannot be folded
/// into the branch across it.
const NEG_IN_FLAG_WINDOW: &str = "long guard(long a, long b) {\n\
long c = (a > 0);\n\
long d = -b;\n\
return c ? d : 0;\n}\n";

/// The comparison materializes through `setcc` and the branch tests that
/// value: fusing it into the branch would read the flags the intervening
/// `negq` left.
#[test]
fn x64_negation_does_not_fuse_a_comparison_into_the_branch() {
    let insns = x64(NEG_IN_FLAG_WINDOW, "guard");
    let jcc = insns
        .iter()
        .position(X64Insn::is_jcc)
        .expect("no conditional branch");
    let before = insns[jcc - 1];
    // `85 /r` TEST r/m, r and the CMP forms: the flags the branch reads
    // must come from one of them, not from the negate.
    let mut m = Misses::default();
    m.expect(
        matches!(before.op, 0x85 | 0x39 | 0x3B | 0x81 | 0x83) && before.op != 0xF7,
        || format!("the branch reads the flags of {before:x?}: {insns:x?}"),
    );
    m.finish();
}

/// x86-64 negates with `neg`, never the three-operand `imul` by -1.
#[test]
fn x64_negation_takes_neg() {
    // `F7 /3` is NEG r/m; `69` / `6B` / `0F AF` are the IMUL forms.
    let neg = |i: &X64Insn| i.op == 0xF7 && i.modrm.is_some_and(|m| (m >> 3) & 7 == 3);
    let imul = |i: &X64Insn| matches!(i.op, 0x69 | 0x6B | 0x0FAF);
    let mut m = Misses::default();
    for name in ["negi", "negl", "negu", "zero_minus", "times_minus_one"] {
        let insns = x64(NEGATES, name);
        m.expect(
            insns.iter().filter(|i| neg(i)).count() == 1
                && !insns.iter().any(imul)
                && insns.len() <= 4,
            || format!("{name}: not one neg: {insns:x?}"),
        );
    }
    for name in ["negneg", "sub_of_neg", "neg_minus_one", "const_minus"] {
        let insns = x64(NEGATES, name);
        m.expect(!insns.iter().any(&neg), || {
            format!("{name}: a negate the folds should have removed: {insns:x?}")
        });
    }
    let insns = x64(NEGATES, "times_minus_two");
    m.expect(insns.iter().any(imul) && !insns.iter().any(neg), || {
        format!("times_minus_two: not a multiply: {insns:x?}")
    });
    m.finish();
}

/// Counts whose operand carries a set bit in the counted width, and the
/// same counts over an operand that may be zero.
const COUNT_GUARDS: &str = "int ctz_set(unsigned x) { return __builtin_ctz(x | 1u); }\n\
int clz_set(unsigned x) { return __builtin_clz(x | 1u); }\n\
int ctz64_set(unsigned long long x) { return __builtin_ctzll(x | 1ull); }\n\
int ctz_any(unsigned x) { return __builtin_ctz(x); }\n\
int clz_any(unsigned x) { return __builtin_clz(x); }\n";

/// The x86-64 zero guard -- the width constant and the `cmovz` that takes
/// it when `bsf` / `bsr` leave the destination undefined -- is emitted
/// only where the operand can be zero.
#[test]
fn x64_count_drops_the_zero_guard_over_a_nonzero_operand() {
    let obj = object_at(COUNT_GUARDS, Target::LinuxX64, true);
    let cmovz = |i: &X64Insn| i.op == 0x0F44;
    let mov_imm = |i: &X64Insn| (0xB8..=0xBF).contains(&i.op);
    let mut m = Misses::default();
    for name in ["ctz_set", "clz_set", "ctz64_set"] {
        let insns = x64_insns(&function_bytes(&obj, name));
        m.expect(
            !insns.iter().any(cmovz) && !insns.iter().any(mov_imm),
            || format!("{name}: the guard is still emitted: {insns:x?}"),
        );
    }
    for name in ["ctz_any", "clz_any"] {
        let insns = x64_insns(&function_bytes(&obj, name));
        m.expect(insns.iter().any(cmovz) && insns.iter().any(mov_imm), || {
            format!("{name}: the guard is gone over an operand that can be zero: {insns:x?}")
        });
    }
    m.finish();
}

/// AArch64's `clz` / `rbit` + `clz` are total, so the non-zero fact
/// changes nothing there: both operand shapes take the same count.
#[test]
fn a64_counts_are_the_same_over_a_nonzero_operand() {
    let mut m = Misses::default();
    for (set, any, is64) in [("ctz_set", "ctz_any", false), ("clz_set", "clz_any", false)] {
        let a = a64(COUNT_GUARDS, set);
        let b = a64(COUNT_GUARDS, any);
        let counts = |ws: &[u32]| {
            ws.iter()
                .filter(|&&w| a64_clz(w, is64) || a64_rbit(w, is64))
                .count()
        };
        m.expect(counts(&a) == counts(&b), || {
            format!("{set} {a:08x?} vs {any} {b:08x?}")
        });
    }
    m.finish();
}

/// `-mgeneral-regs-only` keeps the AArch64 population count off the SIMD
/// registers: the general-register reduction, at both widths. `-mno-sse`
/// leaves x86-64 its `popcnt`, a general-register instruction.
#[test]
fn popcount_without_fp_registers_uses_none() {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, emit_native_with_options};
    let obj = |target: Target| {
        let program = Compiler::with_options(
            COUNTS.to_string(),
            target,
            CompileOptions::default()
                .with_no_entry_point(true)
                .with_optimize(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            no_fp_regs: true,
            ..NativeOptions::new().with_optimize()
        };
        emit_native_with_options(&program, target, opts).expect("emit")
    };
    let mut m = Misses::default();
    let a = obj(Target::LinuxAarch64);
    // `mul` of either width, then `lsr` by the top byte's position.
    for (name, is64) in [("pop32", false), ("pop64", true)] {
        let ws = function_words(&a, name);
        let mul = if is64 { 0x9B00_7C00 } else { 0x1B00_7C00 };
        let top = if is64 { 0xD378_FC00 } else { 0x5318_7C00 };
        m.expect(
            !ws.iter().any(|&w| a64_touches_simd_fp(w))
                && ws.iter().any(|&w| w & 0xFFE0_FC00 == mul)
                && ws.iter().any(|&w| w & 0xFFFF_FC00 == top),
            || format!("{name}: not the general-register count: {ws:08x?}"),
        );
    }
    let x = obj(Target::LinuxX64);
    for name in ["pop32", "pop64"] {
        let insns = x64_insns(&function_bytes(&x, name));
        m.expect(insns.iter().any(|i| i.op == 0x0FB8), || {
            format!("{name}: no popcnt: {insns:x?}")
        });
    }
    m.finish();
}

/// A count reads its operand at its width: the conversion of a wider value
/// to the 32-bit operand leaves no mask, while a mask inside the width, a
/// mask feeding the 64-bit count, and the zero extension of a 32-bit
/// parameter into it all stay.
#[test]
fn a_count_reads_its_operand_at_its_width() {
    const SRC: &str = "int word(unsigned long long x) { return __builtin_popcount(x); }\n\
int low16(unsigned x) { return __builtin_popcount(x & 0xffff); }\n\
int low32(unsigned long long x) { return __builtin_popcountll(x & 0xffffffff); }\n\
int wide(unsigned x) { return __builtin_popcountll(x); }\n";
    let mut m = Misses::default();
    for target in [Target::LinuxAarch64, Target::LinuxX64] {
        for (name, mask) in [
            ("word", None),
            ("low16", Some(0xffff_i64)),
            ("low32", Some(0xffff_ffff)),
            ("wide", Some(0xffff_ffff)),
        ] {
            let (body, insts) = super::codegen::optimized_function_full_pool(SRC, name, target);
            let text = |head: &str| {
                insts
                    .iter()
                    .find(|(_, i)| i.starts_with(head))
                    .map(|(id, i)| (*id, i.clone()))
            };
            let (Some((param, _)), Some((_, count))) = (text("ParamRef(0"), text("BitCount"))
            else {
                m.expect(false, || format!("{target:?} {name}: no count: {body}"));
                continue;
            };
            let operand = match mask {
                None => param,
                Some(k) => text(&format!("BinopI {{ op=and, lhs=v{param}, rhs_imm={k} }}"))
                    .map_or(u32::MAX, |(id, _)| id),
            };
            m.expect(count.contains(&format!("value=v{operand},")), || {
                format!("{target:?} {name}: the operand's mask: {body}")
            });
        }
    }
    m.finish();
}

/// The count's range is `0..=bits`: a comparison with the width stays, one
/// past it folds, and an inlined count of a constant folds to the width at
/// 0 and to the width's set bits at all-ones.
#[test]
fn a_count_ranges_over_zero_to_the_width() {
    const SRC: &str = "int full(unsigned x) { return __builtin_clz(x) == 32; }\n\
int never(unsigned long long x) { return __builtin_ctzll(x) > 64; }\n\
static int clz(unsigned x) { return __builtin_clz(x); }\n\
static int ctz(unsigned x) { return __builtin_ctz(x); }\n\
static int clzll(unsigned long long x) { return __builtin_clzll(x); }\n\
static int ctzll(unsigned long long x) { return __builtin_ctzll(x); }\n\
static int pop(unsigned x) { return __builtin_popcount(x); }\n\
static int popll(unsigned long long x) { return __builtin_popcountll(x); }\n\
long zeros(void) {\n\
    return clz(0) | ctz(0) << 8 | clzll(0) << 16 | (long)ctzll(0) << 24\n\
        | (long)pop(~0u) << 32 | (long)popll(~0ull) << 40;\n}\n";
    let mut m = Misses::default();
    // The instruction the function returns.
    let returned = |body: &str, insts: &[(u32, String)]| {
        let v = body
            .split("terminator Return(v")
            .nth(1)?
            .split(')')
            .next()?
            .parse::<u32>()
            .ok()?;
        insts
            .iter()
            .find(|(id, _)| *id == v)
            .map(|(_, i)| i.clone())
    };
    for target in [Target::LinuxAarch64, Target::LinuxX64] {
        let (body, insts) = super::codegen::optimized_function_full_pool(SRC, "full", target);
        m.expect(
            returned(&body, &insts).is_some_and(|i| i.starts_with("BinopI { op=eq, ")),
            || format!("{target:?} full: `clz == 32` folded: {body}"),
        );
        let (body, insts) = super::codegen::optimized_function_full_pool(SRC, "never", target);
        m.expect(
            returned(&body, &insts).is_some_and(|i| i == "Imm(0)"),
            || format!("{target:?} never: `ctzll > 64` kept: {body}"),
        );
        let (body, insts) = super::codegen::optimized_function_full_pool(SRC, "zeros", target);
        m.expect(
            insts.iter().any(|(_, i)| i == "Imm(70507261075488)")
                && !insts.iter().any(|(_, i)| i.starts_with("BitCount")),
            || format!("{target:?} zeros: not the folded widths: {body}"),
        );
    }
    m.finish();
}

/// A count between a comparison and its branch: AArch64's count instructions
/// leave the flags alone, so the comparison still feeds the branch; x86-64's
/// write them, so the comparison is materialized ahead of the count.
#[test]
fn a_count_keeps_the_flags_only_on_aarch64() {
    const SRC: &str = "long pick(long a, long b, unsigned x) {\n\
    int less = a < b;\n\
    int n = __builtin_clz(x);\n\
    if (less) return n;\n\
    return n + 7;\n}\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "pick");
    let cmp = ws.iter().position(|&w| w & 0xFF20_001F == 0xEB00_001F);
    let bcc = ws.iter().position(|&w| w & 0xFF00_0010 == 0x5400_0000);
    let clz = ws.iter().position(|&w| a64_clz(w, false));
    m.expect(
        matches!((cmp, clz, bcc), (Some(c), Some(z), Some(b)) if c < z && z < b)
            && !ws.iter().any(|&w| w & 0x7FE0_0C00 == 0x1A80_0400),
        || format!("aarch64: the comparison does not feed the branch: {ws:08x?}"),
    );
    let bytes = function_bytes(&object_at(SRC, Target::LinuxX64, true), "pick");
    let insns = x64_insns(&bytes);
    let scan = insns.iter().position(|i| i.op == 0x0FBD);
    let jcc = insns.iter().position(|i| i.is_jcc());
    let setcc = insns.iter().position(|i| (0x0F90..=0x0F9F).contains(&i.op));
    m.expect(
        matches!((setcc, scan, jcc), (Some(s), Some(z), Some(j)) if s < z && z < j),
        || format!("x86-64: the flags cross the scan: {insns:x?}"),
    );
    m.finish();
}

/// Counts of one value keep their operators: the builder's cache and the
/// value numbering key the operator, so a leading, trailing and set-bit
/// count of one operand stay three instructions.
#[test]
fn counts_of_one_value_do_not_merge() {
    const SRC: &str = "int trio(unsigned x) {\n\
    return __builtin_clz(x) * 1000000 + __builtin_ctz(x) * 1000 + __builtin_popcount(x);\n}\n";
    let mut m = Misses::default();
    for target in [Target::LinuxAarch64, Target::LinuxX64] {
        let (body, insts) = super::codegen::optimized_function_full_pool(SRC, "trio", target);
        let counts = insts
            .iter()
            .filter(|(_, i)| i.starts_with("BitCount"))
            .count();
        m.expect(counts == 3, || {
            format!("{target:?} trio: {counts} counts: {body}")
        });
    }
    m.finish();
}

/// `(rn, stores, fp)` of a load or store at an immediate offset, scaled
/// (`ldr` / `str`) or unscaled (`ldur` / `stur`); `None` for anything else.
/// `opc` 0 is a store at every width, and 2 the 128-bit vector store.
fn a64_mem_imm(w: u32) -> Option<(u32, bool, bool)> {
    let scaled = w & 0x3B00_0000 == 0x3900_0000;
    let unscaled = w & 0x3B20_0C00 == 0x3800_0000;
    if !scaled && !unscaled {
        return None;
    }
    let fp = (w >> 26) & 1 == 1;
    let opc = (w >> 22) & 3;
    Some(((w >> 5) & 31, opc == 0 || (fp && opc == 2), fp))
}

/// `add` / `sub` of an immediate off x29 into a general register: a frame
/// address materialized instead of folded into the access that reads it.
/// `sp` as the destination is the frame mechanism, not an access address.
fn a64_frame_address(w: u32) -> bool {
    matches!(w & 0xFF80_0000, 0x9100_0000 | 0xD100_0000) && (w >> 5) & 31 == 29 && w & 31 != 31
}

/// `fmov <Xd>, <Dn>`: the 64-bit vector-to-general transfer.
fn a64_fmov_d_to_x(w: u32) -> bool {
    w & 0xFFFE_0000 == 0x9E66_0000
}

/// The x86-64 stores the backend emits to a frame slot.
fn x64_is_store(i: &X64Insn) -> bool {
    matches!(
        i.op,
        0x88 | 0x89 | 0xC6 | 0xC7 | 0x0F11 | 0x0F29 | 0x0FD6 | 0x0F7F
    )
}

const RBP: u8 = 5;

/// Type punning through the address of a parameter (#1159's shape): one
/// store of the incoming register into the slot and one read of it back.
const BITS: &str = "unsigned long long bits(double d) { return *(unsigned long long *)&d; }\n";

/// The address of a parameter escaping into a call: the home store and the
/// address materialization both have to survive.
const KEEP: &str = "void sink(double *);\n\
    double keep(double d) { sink(&d); return d; }\n";

/// A load through the address of a local slot reads the slot directly: the
/// frame offset folds into the load, so no address is materialized.
#[test]
fn a_load_through_a_local_address_folds_the_frame_offset() {
    let mut m = Misses::default();
    let ws = a64(BITS, "bits");
    m.expect(!ws.iter().any(|&w| a64_frame_address(w)), || {
        format!("aarch64 bits: a frame address is materialized: {ws:08x?}")
    });
    let insns = x64(BITS, "bits");
    m.expect(
        !insns
            .iter()
            .any(|i| i.op == 0x8D && i.mem_base() == Some(RBP)),
        || format!("x86-64 bits: a frame address is materialized: {insns:x?}"),
    );
    // The address the call takes is not an access, so it still materializes.
    let ws = a64(KEEP, "keep");
    m.expect(ws.iter().any(|&w| a64_frame_address(w)), || {
        format!("aarch64 keep: the escaping address is gone: {ws:08x?}")
    });
    let insns = x64(KEEP, "keep");
    m.expect(
        insns
            .iter()
            .any(|i| i.op == 0x8D && i.mem_base() == Some(RBP)),
        || format!("x86-64 keep: the escaping address is gone: {insns:x?}"),
    );
    m.finish();
}

/// An address-taken parameter whose slot the body writes first is stored
/// once: the prologue's home store has no reader and is dropped.
#[test]
fn an_address_taken_parameter_is_homed_once() {
    let mut m = Misses::default();
    let ws = a64(BITS, "bits");
    let stores = ws
        .iter()
        .filter(|&&w| a64_mem_imm(w).is_some_and(|(rn, st, _)| rn == 29 && st))
        .count();
    m.expect(stores == 1, || {
        format!("aarch64 bits: {stores} stores into the frame: {ws:08x?}")
    });
    let insns = x64(BITS, "bits");
    let stores = insns
        .iter()
        .filter(|i| x64_is_store(i) && i.mem_base() == Some(RBP))
        .count();
    m.expect(stores == 1, || {
        format!("x86-64 bits: {stores} stores into the frame: {insns:x?}")
    });
    // The escaping address leaves the body no store of its own, so the
    // prologue's home store is the one that survives.
    let ws = a64(KEEP, "keep");
    let stores = ws
        .iter()
        .filter(|&&w| a64_mem_imm(w).is_some_and(|(rn, st, _)| rn == 29 && st))
        .count();
    m.expect(stores == 1, || {
        format!("aarch64 keep: {stores} stores into the frame: {ws:08x?}")
    });
    // A body store narrower than the read past it leaves the prologue's
    // bytes observable, so both stores stand.
    let insns = x64(WIDE, "wide");
    let stores = insns
        .iter()
        .filter(|i| x64_is_store(i) && i.mem_base() == Some(RBP))
        .count();
    m.expect(stores == 2, || {
        format!("x86-64 wide: {stores} stores into the frame: {insns:x?}")
    });
    m.finish();
}

/// A parameter read wider than the body's own store of it: the prologue's
/// home store keeps a reader, so it is the store under test below.
const WIDE: &str = "long double wide(double d) { return *(long double *)&d; }\n";

/// The prologue stores a floating parameter out of its own register bank;
/// the general bank is not a stop on the way to the cell.
#[test]
fn a_floating_parameter_homes_from_its_own_bank() {
    let mut m = Misses::default();
    let ws = a64(WIDE, "wide");
    let home = ws
        .iter()
        .position(|&w| a64_mem_imm(w).is_some_and(|(rn, st, _)| rn == 29 && st));
    m.expect(
        match home {
            Some(h) => {
                a64_mem_imm(ws[h]).is_some_and(|(_, _, fp)| fp)
                    && !ws[..h].iter().any(|&w| a64_fmov_d_to_x(w))
            }
            None => false,
        },
        || format!("aarch64 wide: the home store crosses banks: {ws:08x?}"),
    );
    let insns = x64(WIDE, "wide");
    let home = insns
        .iter()
        .find(|i| x64_is_store(i) && i.mem_base() == Some(RBP));
    m.expect(home.is_some_and(|i| i.op == 0x0F11), || {
        format!("x86-64 wide: the home store crosses banks: {insns:x?}")
    });
    m.finish();
}

/// The cases the frame-offset fold and the home-store elision must leave
/// alone: a store narrower than the cell the prologue fills, a volatile
/// access, and an object whose alignment puts it in the realigned region.
#[test]
fn a_local_access_folds_only_where_the_slot_form_says_the_same_thing() {
    // `p`'s address escapes and the body writes 4 of the 8 bytes the
    // prologue homes, so the prologue's store keeps its reader.
    const NARROW: &str = "void sinki(int *);\n\
        long narrow(int p) { sinki(&p); return p; }\n";
    // Each volatile access is performed once, in its own instruction.
    const VOL: &str = "int vol(int x) { volatile int v = x; return v + v; }\n";
    // The object lives in the over-aligned region, not at its slot.
    const OVER: &str = "unsigned long long over(double x) {\n\
        _Alignas(32) double d = x;\n\
        return *(unsigned long long *)&d;\n}\n";
    let mut m = Misses::default();

    let ws = a64(NARROW, "narrow");
    let stores = ws
        .iter()
        .filter(|&&w| a64_mem_imm(w).is_some_and(|(rn, st, _)| rn == 29 && st))
        .count();
    m.expect(stores == 2, || {
        format!("aarch64 narrow: {stores} stores into the frame: {ws:08x?}")
    });
    let insns = x64(NARROW, "narrow");
    let stores = insns
        .iter()
        .filter(|i| x64_is_store(i) && i.mem_base() == Some(RBP))
        .count();
    m.expect(stores == 2, || {
        format!("x86-64 narrow: {stores} stores into the frame: {insns:x?}")
    });

    let ws = a64(VOL, "vol");
    let (stores, loads) = ws.iter().fold((0, 0), |(s, l), &w| match a64_mem_imm(w) {
        Some((29, true, _)) => (s + 1, l),
        Some((29, false, _)) => (s, l + 1),
        _ => (s, l),
    });
    m.expect((stores, loads) == (1, 2), || {
        format!("aarch64 vol: {stores} stores, {loads} loads: {ws:08x?}")
    });
    let insns = x64(VOL, "vol");
    let frame = |i: &&X64Insn| i.mem_base() == Some(RBP);
    let stores = insns.iter().filter(|i| x64_is_store(i) && frame(i)).count();
    let loads = insns
        .iter()
        .filter(|i| !x64_is_store(i) && frame(i))
        .count();
    m.expect((stores, loads) == (1, 2), || {
        format!("x86-64 vol: {stores} stores, {loads} loads: {insns:x?}")
    });

    // Both accesses reach the realigned region off sp, neither off x29.
    let ws = a64(OVER, "over");
    let region = ws
        .iter()
        .filter(|&&w| a64_mem_imm(w).is_some_and(|(rn, _, _)| rn == 31))
        .count();
    m.expect(
        region == 2 && !ws.iter().any(|&w| a64_frame_address(w)),
        || format!("aarch64 over: {region} accesses off sp: {ws:08x?}"),
    );
    m.finish();
}

/// `fmov <Dd>, <Xn>` / `fmov <Sd>, <Wn>`: the general-to-vector transfers.
fn a64_fmov_x_to_d(w: u32) -> bool {
    matches!(w & 0xFFFE_0000, 0x9E67_0000 | 0x1E27_0000)
}

/// `mov <Xd>, #0` in either of the forms the emit builds a zero with.
fn a64_builds_zero(w: u32) -> bool {
    // `movz Rd, #0` and `orr Rd, xzr, #0`-style `mov Rd, #imm`.
    (w & 0x7F80_0000 == 0x5280_0000 && (w >> 5) & 0xFFFF == 0)
        || (w & 0x7F80_0000 == 0x1280_0000 && (w >> 5) & 0xFFFF == 0)
}

/// Stores of a zero at every integer width and at `double`, beside a
/// non-zero constant the same shape has to keep in a register.
const ZEROS: &str = "struct s { long a; int b; short c; char d; };\n\
    void zero(struct s *p) { p->a = 0; p->b = 0; p->c = 0; p->d = 0; }\n\
    void zerod(double *p) { *p = 0.0; }\n\
    void one(long *p) { *p = 1; }\n";

/// A `double` store whose value the allocator put in the general bank: an
/// integer reader of the same constant keeps it out of the FP file.
const GPR_FP_STORE: &str = "long via_gpr(double *p, long n) { *p = 0.0; return n ? 0 : 1; }\n";

/// A store of zero writes the zero register: no constant is built, and
/// every width has a form that reads xzr / wzr.
#[test]
fn a_store_of_zero_reads_the_zero_register() {
    let mut m = Misses::default();
    for name in ["zero", "zerod"] {
        let ws = a64(ZEROS, name);
        let stores: Vec<u32> = ws
            .iter()
            .filter(|&&w| a64_mem_imm(w).is_some_and(|(_, st, _)| st))
            .map(|&w| w & 31)
            .collect();
        m.expect(
            stores.len() == if name == "zero" { 4 } else { 1 }
                && stores.iter().all(|&rt| rt == 31)
                && !ws.iter().any(|&w| a64_builds_zero(w)),
            || format!("aarch64 {name}: the zero is built in a register: {ws:08x?}"),
        );
    }
    // A constant with no register-free form still takes one.
    let ws = a64(ZEROS, "one");
    m.expect(
        ws.iter()
            .any(|&w| a64_mem_imm(w).is_some_and(|(_, st, _)| st) && w & 31 != 31),
        || format!("aarch64 one: a non-zero constant reads xzr: {ws:08x?}"),
    );
    // x86-64 writes any constant from the instruction and is unchanged.
    let insns = x64(ZEROS, "zero");
    m.expect(
        insns
            .iter()
            .filter(|i| matches!(i.op, 0xC6 | 0xC7) && i.mem_base().is_some())
            .count()
            == 4,
        || format!("x86-64 zero: not four immediate stores: {insns:x?}"),
    );
    m.finish();
}

/// An FP-typed store of a value the allocator placed in the general bank
/// issues from it: `str x` writes the bits `fmov` into a V register and
/// `str d` would.
#[test]
fn a_floating_store_of_a_general_register_value_stays_in_the_bank() {
    let mut m = Misses::default();
    let ws = a64(GPR_FP_STORE, "via_gpr");
    m.expect(
        !ws.iter().any(|&w| a64_fmov_x_to_d(w))
            && ws
                .iter()
                .any(|&w| a64_mem_imm(w).is_some_and(|(_, st, fp)| st && !fp)),
        || format!("aarch64 via_gpr: the value crosses banks: {ws:08x?}"),
    );
    // A constant every reader takes in an FP register stays there, and a
    // `double` narrowed to `float` needs the FP file for the conversion.
    const FP: &str = "void setd(double *p) { *p = 3.5; }\n\
        void narrow(float *p, double d) { *p = (float)d; }\n";
    for name in ["setd", "narrow"] {
        let ws = a64(FP, name);
        m.expect(
            ws.iter()
                .any(|&w| a64_mem_imm(w).is_some_and(|(_, st, fp)| st && fp)),
            || format!("aarch64 {name}: no floating store: {ws:08x?}"),
        );
    }
    m.finish();
}
