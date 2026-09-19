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
            0x63 | 0x84..=0x8B | 0x8D | 0x8F | 0xD0..=0xD3 | 0xF6 | 0xF7 | 0xFE | 0xFF => (true, 0),
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

/// The shapes a test misses, so one run reports both targets.
#[derive(Default)]
struct Misses(Vec<String>);

impl Misses {
    fn expect(&mut self, ok: bool, what: impl FnOnce() -> String) {
        if !ok {
            self.0.push(what());
        }
    }
    fn finish(self) {
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
#[ignore = "TODO: the range of a value is not narrowed by the branch guarding its block"]
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
#[ignore = "TODO: an induction variable is not bounded by its loop guard"]
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

/// `n % 10` lies in `(-10, 10)`: the promoted `digit` needs no extension
/// past the one of `n` at the loop head and the one of the `int` result.
#[test]
#[ignore = "TODO: a remainder by a constant is re-extended when read through a promoted local"]
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

/// Of the two masks in `s * K + C`, only the second one's result is read
/// above bit 31; the parameter's entry conversion is one more.
#[test]
#[ignore = "TODO: an unsigned renormalization is kept where its high half is unread"]
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
#[ignore = "TODO: x86-64 builds a stored constant in a register first"]
fn x64_constant_store_takes_an_immediate() {
    let insns = x64(MARK, "mark");
    assert!(
        insns.iter().any(|i| i.op == 0xC6 && !i.reg_form()),
        "no `mov byte [mem], imm8`: {insns:x?}"
    );
}

/// The zero test of a loaded byte reads memory in the compare.
#[test]
#[ignore = "TODO: x86-64 loads and extends a byte that is only tested against zero"]
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
fn ssa_dump(src: &str, name: &str, optimize: bool) -> String {
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
#[ignore = "TODO: x86-64 stages the subtrahend through r10 when it shares the result register"]
fn x64_reversed_subtract_takes_no_staging_copy() {
    const SRC: &str = "long sub_rev(long a, long b) { long t = a * 3; return b - t; }\n";
    let insns = x64(SRC, "sub_rev");
    assert!(insns.len() <= 4, "{} instructions: {insns:x?}", insns.len());
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
