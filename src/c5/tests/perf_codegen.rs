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

/// The `-O` relocatable object of `src`, over the full register pool so the
/// pressure caps do not move registers.
fn object(src: &str, target: Target) -> Vec<u8> {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, emit_native_with_options};
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(true),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::new().with_optimize()
    };
    crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(usize::MAX, usize::MAX, || {
        emit_native_with_options(&program, target, opts)
    })
    .unwrap_or_else(|e| panic!("emit ({target:?}): {e}"))
}

fn a64(src: &str, name: &str) -> Vec<u32> {
    function_words(&object(src, Target::LinuxAarch64), name)
}

fn x64(src: &str, name: &str) -> Vec<X64Insn> {
    x64_insns(&function_bytes(&object(src, Target::LinuxX64), name))
}

/// One decoded x86-64 instruction. `op` is the opcode with `0x0F00` set for
/// the two-byte map; `imm` is the sign-extended immediate or displacement
/// of a relative branch.
#[derive(Debug, Clone, Copy)]
struct X64Insn {
    at: usize,
    len: usize,
    rex: u8,
    op: u16,
    modrm: Option<u8>,
    sib: Option<u8>,
    imm: i64,
}

impl X64Insn {
    fn is_jmp(&self) -> bool {
        matches!(self.op, 0xEB | 0xE9)
    }
    fn is_jcc(&self) -> bool {
        matches!(self.op, 0x70..=0x7F | 0x0F80..=0x0F8F)
    }
    fn target(&self) -> usize {
        (self.at as i64 + self.len as i64 + self.imm) as usize
    }
    /// ModRM `mod == 3`: both operands are registers.
    fn reg_form(&self) -> bool {
        self.modrm.is_some_and(|m| m >> 6 == 3)
    }
    fn rex_w(&self) -> bool {
        self.rex & 8 != 0
    }
    /// The ModRM `reg` and `rm` register numbers, REX-extended.
    fn regs(&self) -> (u8, u8) {
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
fn x64_insns(code: &[u8]) -> Vec<X64Insn> {
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
            0x0F80..=0x0F8F => (false, 4),
            0x0F70..=0x0F73 | 0x0FA4 | 0x0FAC | 0x0FBA | 0x0FC2 | 0x0FC4..=0x0FC6 => (true, 1),
            0x0F10..=0x0F17
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
        let (mut modrm, mut sib) = (None, None);
        if has_modrm {
            let m = code[i];
            i += 1;
            modrm = Some(m);
            let (md, rm) = (m >> 6, m & 7);
            if md != 3 && rm == 4 {
                sib = Some(code[i]);
                i += 1;
            }
            i += match md {
                0 if rm == 5 || sib.is_some_and(|s| s & 7 == 5) => 4,
                1 => 1,
                2 => 4,
                _ => 0,
            };
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
        0x75, 0x05, // jne +5
        0x0F, 0x8C, 0xFB, 0xFF, 0xFF, 0xFF, // jl -5
        0xEB, 0xFC, // jmp -4
        0xC9, // leave
        0xC3, // ret
    ];
    let lens: Vec<usize> = x64_insns(code).iter().map(|i| i.len).collect();
    assert_eq!(lens, [1, 3, 7, 3, 4, 4, 5, 7, 4, 3, 10, 5, 2, 6, 2, 1, 1]);
    let insns = x64_insns(code);
    assert_eq!(insns[12].target(), insns[12].at + 2 + 5);
    assert_eq!(insns[14].target(), insns[14].at - 2);
}

fn sext(v: u32, bits: u32) -> i64 {
    i64::from(((v << (32 - bits)) as i32) >> (32 - bits))
}

/// `(target word index, unconditional)` of a direct branch at word `i`.
fn a64_branch(w: u32, i: usize) -> Option<(i64, bool)> {
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
fn a64_branches_land_on_code(ws: &[u32]) -> bool {
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

fn x64_branches_land_on_code(insns: &[X64Insn]) -> bool {
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
#[ignore = "TODO: a block left without code after allocation still takes its branch"]
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
#[ignore = "TODO: a rotated loop is entered by a jump to its bottom test"]
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

/// The parameter's home is written at register width and its other
/// accesses at the type's, which must not keep the object in memory.
#[test]
#[ignore = "TODO: an assigned parameter of a narrow unsigned type is not promoted"]
fn assigned_unsigned_parameter_is_promoted() {
    const SRC: &str = "unsigned step3(unsigned s, int n) {\n\
        for (int i = 0; i < n; i++) s = s * 3u + 1u;\n\
        return s;\n}\n";
    let mut m = Misses::default();
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let (body, insts) = optimized_function_full_pool(SRC, "step3", target);
        let in_memory = insts
            .iter()
            .any(|(_, i)| i.starts_with("LoadLocal") || i.starts_with("StoreLocal"));
        m.expect(!in_memory, || {
            format!("{target:?}: the parameter stays in its slot: {body}")
        });
    }
    m.finish();
}

/// `a /= 10` divides by the same constant as `a = a / 10`.
#[test]
#[ignore = "TODO: a compound division by a constant is not strength-reduced"]
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
#[ignore = "TODO: an index of scale 1 is added to the base in a separate instruction"]
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
#[ignore = "TODO: aarch64 extends an index into a register ahead of the access"]
fn a64_int_index_extends_inside_the_access() {
    const SRC: &str = "long at(const int *a, int i) { return a[i]; }\n";
    let ws = a64(SRC, "at");
    assert!(
        !ws.iter().any(|&w| a64_is_sxtw(w)),
        "a separate sxtw: {ws:08x?}"
    );
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
#[ignore = "TODO: a comparison reaching its branch through a one-input phi is materialized"]
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

/// The divisor is a constant once `dv` is inlined.
#[test]
#[ignore = "TODO: a divisor that becomes constant after inlining keeps the hardware divide"]
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
#[ignore = "TODO: a repeated indexed load is not forwarded"]
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
#[ignore = "TODO: the result register of a void external call is extended as a char"]
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

/// No lowering in `drop` writes x19, so the frame has no slot for it.
#[test]
#[ignore = "TODO: aarch64 saves x19 in every function holding an external call"]
fn a64_external_call_alone_does_not_save_x19() {
    let ws = a64(DROP, "drop");
    let saves = |w: u32| {
        let str_sp = w & 0xFFC0_03FF == 0xF900_03F3 || w & 0xFFE0_0FFF == 0xF800_0FF3;
        let pair = w & 0x7E40_0000 == 0x2800_0000 && (w & 31 == 19 || (w >> 10) & 31 == 19);
        str_sp || pair
    };
    assert!(!ws.iter().any(|&w| saves(w)), "x19 saved: {ws:08x?}");
}

/// The bias of a signed division by 2 is the sign bit: one logical shift.
#[test]
#[ignore = "TODO: signed division by 2 builds its bias with two shifts"]
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
#[ignore = "TODO: a narrow parameter is copied, then extended in place"]
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

/// Nothing reads the counter above bit 31: the multiply, the increment and
/// the 32-bit compare use its low word. The one extension left is the result's.
#[test]
#[ignore = "TODO: a block's unread exit value counts as a reader of its high half"]
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
#[ignore = "TODO: an intrinsic lowered inline counts as a call for the leaf rule"]
fn inline_intrinsic_keeps_the_leaf_frameless() {
    const SRC: &str = "#include <math.h>\ndouble root(double x) { return sqrt(x); }\n";
    let mut m = Misses::default();
    let ws = a64(SRC, "root");
    m.expect(ws.len() == 2, || format!("aarch64: {ws:08x?}"));
    let insns = x64(SRC, "root");
    m.expect(insns.len() == 2, || format!("x86-64: {insns:x?}"));
    m.finish();
}

/// The x86-64 frame of `fib`: a 16-byte `sub` fits the imm8 form, a
/// callee-saved register is saved by `push`, and zeroing a low register
/// needs no REX.W.
#[test]
#[ignore = "TODO: the x86-64 prologue and register zeroing take the long encodings"]
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
