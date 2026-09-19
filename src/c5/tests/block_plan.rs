//! The blocks a function's machine code leaves out, and the ones it must
//! keep: decoded on both ELF targets. `tests/fixtures/c/block_plan_edges.c`
//! runs the same shapes.

use super::perf_codegen::{
    X64Insn, a64_at, a64_branch, a64_branches_land_on_code, x64_at, x64_branches_land_on_code,
};

/// The `if` arm only renames, so its block is empty and its edge to the
/// join swaps the two carried values; the skip edge moves nothing.
const SWAP_WALK: &str = "long swap_walk(long a, long b, int n) {\n\
    for (int i = 0; i < n; i++) { if (i & 1) { long t = a; a = b; b = t; } }\n\
    return a * 3 + b;\n}\n";

/// `mov xd, xm` (`orr xd, xzr, xm`).
fn a64_mov_rr(w: u32) -> Option<(u32, u32)> {
    (w & 0xFFE0_FFE0 == 0xAA00_03E0).then_some((w & 31, (w >> 16) & 31))
}

/// An empty block whose edge moves values keeps its place: the swap is in
/// the loop, the branch over it lands past it, and nothing lands on a
/// branch.
#[test]
fn edge_block_with_moves_keeps_them() {
    let ws = a64_at(SWAP_WALK, "swap_walk", true);
    assert!(a64_branches_land_on_code(&ws), "{ws:08x?}");
    // Three register copies in a row closing a cycle: d0 <- s0, s0 <- s1,
    // s1 <- d0.
    let cycle =
        ws.windows(3).position(
            |w| match (a64_mov_rr(w[0]), a64_mov_rr(w[1]), a64_mov_rr(w[2])) {
                (Some((t, a)), Some((a2, b)), Some((b2, t2))) => a == a2 && b == b2 && t == t2,
                _ => false,
            },
        );
    let at = cycle.unwrap_or_else(|| panic!("aarch64: no swap in the loop: {ws:08x?}"));
    let skips = ws.iter().enumerate().any(
        |(i, &w)| matches!(a64_branch(w, i), Some((t, false)) if i < at && t == at as i64 + 3),
    );
    assert!(
        skips,
        "aarch64: no conditional branch over the swap: {ws:08x?}"
    );

    let insns = x64_at(SWAP_WALK, "swap_walk", true);
    assert!(x64_branches_land_on_code(&insns), "{insns:x?}");
    let at = insns
        .iter()
        .position(|i| i.op == 0x87)
        .unwrap_or_else(|| panic!("x86-64: no xchg in the loop: {insns:x?}"));
    let after = insns[at].at + insns[at].len;
    assert!(
        insns[..at]
            .iter()
            .any(|i| i.is_jcc() && i.target() == after),
        "x86-64: no conditional branch over the swap: {insns:x?}"
    );
}

/// A loop of blocks without code has no block to land on past it: it keeps
/// one branch, to itself.
#[test]
fn empty_infinite_loop_keeps_its_branch() {
    let src = "void spin(void) { for (;;); }\n\
               void spin_while(int x) { while (1) { if (x) { } } }\n";
    for optimize in [false, true] {
        for name in ["spin", "spin_while"] {
            let ws = a64_at(src, name, optimize);
            let to_self = ws
                .iter()
                .enumerate()
                .any(|(i, &w)| matches!(a64_branch(w, i), Some((t, _)) if t <= i as i64));
            assert!(to_self, "aarch64 {name} (-O {optimize}): {ws:08x?}");
            let insns = x64_at(src, name, optimize);
            let to_self = insns
                .iter()
                .any(|i| (i.is_jmp() || i.is_jcc()) && i.target() <= i.at);
            assert!(to_self, "x86-64 {name} (-O {optimize}): {insns:x?}");
        }
    }
}

/// Where a direct branch of `insns` lands, an instruction starts.
fn x64_branches_land_on_boundaries(insns: &[X64Insn]) -> bool {
    insns
        .iter()
        .filter(|i| i.is_jmp() || i.is_jcc())
        .all(|b| insns.iter().any(|t| t.at == b.target()))
}

/// Blocks whose address a label holds stay in the code even when they hold
/// none of their own; a table slot names where its case lands. Every direct
/// branch around them still lands on an instruction of the function.
#[test]
fn addressed_blocks_stay_in_the_code() {
    let src = "int classify(int x) {\n\
               int r = 0;\n\
               switch (x) {\n\
               case 0: break; case 1: case 2: r = 10; break; case 3: break;\n\
               case 4: r = 40; break; case 5: case 6: case 7: break;\n\
               case 8: r = 80; break; case 9: break; default: r = -1; break;\n\
               }\n\
               return r + x;\n}\n\
               int dispatch(int op, int v) {\n\
               static const void *const table[] = { &&inc, &&nop, &&dbl, &&nop2 };\n\
               goto *table[op & 3];\n\
               inc: v += 1; goto out;\n\
               nop: goto out;\n\
               dbl: v *= 2; goto out;\n\
               nop2: goto out;\n\
               out: return v;\n}\n";
    for optimize in [false, true] {
        for name in ["classify", "dispatch"] {
            let ws = a64_at(src, name, optimize);
            let inside = ws.iter().enumerate().all(|(i, &w)| {
                a64_branch(w, i).is_none_or(|(t, _)| t >= 0 && (t as usize) < ws.len())
            });
            assert!(inside, "aarch64 {name} (-O {optimize}): {ws:08x?}");
            let insns = x64_at(src, name, optimize);
            assert!(
                x64_branches_land_on_boundaries(&insns),
                "x86-64 {name} (-O {optimize}): {insns:x?}"
            );
        }
        // `nop` and `nop2` hold no code of their own and share no address:
        // each label keeps a branch to `out`.
        let ws = a64_at(src, "dispatch", optimize);
        let jumps = ws
            .iter()
            .enumerate()
            .filter(|&(i, &w)| matches!(a64_branch(w, i), Some((_, true))))
            .count();
        assert!(jumps >= 2, "aarch64 dispatch (-O {optimize}): {ws:08x?}");
    }
}

/// `(conditional, unconditional)` direct branches ahead of the first
/// backward branch, the loop's bottom test: what it takes to enter the loop.
fn a64_entry_branches(ws: &[u32]) -> (usize, usize) {
    let bottom = ws
        .iter()
        .enumerate()
        .position(|(i, &w)| matches!(a64_branch(w, i), Some((t, _)) if t <= i as i64))
        .unwrap_or(ws.len());
    let ahead = |uncond: bool| {
        ws[..bottom]
            .iter()
            .enumerate()
            .filter(|&(i, &w)| matches!(a64_branch(w, i), Some((_, u)) if u == uncond))
            .count()
    };
    (ahead(false), ahead(true))
}

fn x64_entry_branches(insns: &[X64Insn]) -> (usize, usize) {
    let bottom = insns
        .iter()
        .position(|i| (i.is_jmp() || i.is_jcc()) && i.target() <= i.at)
        .unwrap_or(insns.len());
    (
        insns[..bottom].iter().filter(|i| i.is_jcc()).count(),
        insns[..bottom].iter().filter(|i| i.is_jmp()).count(),
    )
}

const SUM: &str = "long sum(const int *a, int n) {\n\
    long s = 0;\n\
    for (int i = 0; i < n; i++) s += a[i];\n\
    return s;\n}\n";

/// A rotated loop is entered through a copy of its bottom test: one
/// conditional branch and no jump ahead of the body. The test may load.
#[test]
fn small_bottom_test_is_repeated_ahead_of_the_loop() {
    let run_len = "long run_len(const char *p) { long n = 0; while (p[n]) n++; return n; }\n";
    for (src, name) in [(SUM, "sum"), (run_len, "run_len")] {
        let ws = a64_at(src, name, true);
        assert_eq!(a64_entry_branches(&ws), (1, 0), "aarch64 {name}: {ws:08x?}");
        assert!(a64_branches_land_on_code(&ws), "aarch64 {name}: {ws:08x?}");
        let insns = x64_at(src, name, true);
        assert_eq!(
            x64_entry_branches(&insns),
            (1, 0),
            "x86-64 {name}: {insns:x?}"
        );
        assert!(
            x64_branches_land_on_code(&insns),
            "x86-64 {name}: {insns:x?}"
        );
    }
}

/// What a second copy would change stays single: a volatile read (C99
/// 6.7.3p6), a call, and a test longer than the bound. Each loop keeps the
/// jump to its bottom test.
#[test]
fn bottom_test_that_may_not_run_twice_keeps_the_jump() {
    let srcs = [
        (
            "until_set",
            "extern volatile int stop;\n\
             long until_set(long n) { long c = 0; while (!stop) c += n; return c; }\n",
        ),
        (
            "drain",
            "extern int more(void);\n\
             long drain(void) { long c = 0; while (more()) c++; return c; }\n",
        ),
        (
            "long_test",
            "long long_test(const int *a, const int *b, const int *c, const int *d, int m) {\n\
             long i = 0;\n\
             while (((a[i] ^ b[i]) + (c[i] ^ d[i])) & m) i++;\n\
             return i;\n}\n",
        ),
    ];
    for (name, src) in srcs {
        let ws = a64_at(src, name, true);
        assert_eq!(a64_entry_branches(&ws), (0, 1), "aarch64 {name}: {ws:08x?}");
        let insns = x64_at(src, name, true);
        assert_eq!(
            x64_entry_branches(&insns),
            (0, 1),
            "x86-64 {name}: {insns:x?}"
        );
    }
}

/// `cmp`, `cmn` or `tst`: a flag-setting add, subtract or and into the
/// zero register.
fn a64_sets_flags(w: u32) -> bool {
    let to_zr = w & 0x1F == 0x1F;
    let add_sub = w & 0x3F80_0000 == 0x3100_0000
        || w & 0x3F20_0000 == 0x2B00_0000
        || w & 0x3FE0_0000 == 0x2B20_0000;
    let and = w & 0x7F80_0000 == 0x7200_0000 || w & 0x7F00_0000 == 0x6A00_0000;
    to_zr && (add_sub || and)
}

/// `cmp` or `test` in any operand form.
fn x64_sets_flags(i: &X64Insn) -> bool {
    let reg = i.modrm.map(|m| (m >> 3) & 7);
    matches!(i.op, 0x38..=0x3D | 0x84 | 0x85 | 0xA8 | 0xA9)
        || (matches!(i.op, 0x80 | 0x81 | 0x83) && reg == Some(7))
        || (matches!(i.op, 0xF6 | 0xF7) && reg == Some(0))
}

/// The words ahead of the loop: up to the target of its backward branch.
fn a64_ahead_of_loop(ws: &[u32]) -> &[u32] {
    let head = ws.iter().enumerate().find_map(|(i, &w)| {
        a64_branch(w, i).and_then(|(t, _)| (t <= i as i64).then_some(t as usize))
    });
    &ws[..head.unwrap_or_else(|| panic!("no loop: {ws:08x?}"))]
}

fn x64_ahead_of_loop(insns: &[X64Insn]) -> &[X64Insn] {
    let head = insns
        .iter()
        .find(|i| (i.is_jmp() || i.is_jcc()) && i.target() <= i.at)
        .unwrap_or_else(|| panic!("no loop: {insns:x?}"))
        .target();
    let n = insns.iter().take_while(|i| i.at < head).count();
    &insns[..n]
}

/// A test whose phis are constants at the jump into the loop is decided
/// there: nothing is compared or branched on ahead of the body. The first
/// loop has more trips than unrolling takes, the second a body of more than
/// one block.
#[test]
fn constant_guard_is_decided_ahead_of_the_loop() {
    let src = "long scaled(const int *a) {\n\
               long s = 0;\n\
               for (int i = 0; i < 1000; i++) s += a[i] * i;\n\
               return s;\n}\n\
               long split(const int *a) {\n\
               long s = 0;\n\
               for (unsigned i = 0; i < 16; i++) { if (a[i] & 1) s += a[i]; else s -= i; }\n\
               return s;\n}\n";
    for name in ["scaled", "split"] {
        let ws = a64_at(src, name, true);
        let ahead = a64_ahead_of_loop(&ws);
        let tested = ahead
            .iter()
            .enumerate()
            .any(|(i, &w)| a64_branch(w, i).is_some() || a64_sets_flags(w));
        assert!(!tested, "aarch64 {name}: {ws:08x?}");
        assert!(a64_branches_land_on_code(&ws), "aarch64 {name}: {ws:08x?}");
        let insns = x64_at(src, name, true);
        let ahead = x64_ahead_of_loop(&insns);
        let tested = ahead
            .iter()
            .any(|i| i.is_jmp() || i.is_jcc() || x64_sets_flags(i));
        assert!(!tested, "x86-64 {name}: {insns:x?}");
        assert!(
            x64_branches_land_on_code(&insns),
            "x86-64 {name}: {insns:x?}"
        );
    }
}

/// A loop whose first test fails on its constants is jumped over: the
/// function's first branch is unconditional and lands past the bottom
/// test. The test reads the low word of a value whose high word is set.
#[test]
fn loop_whose_first_test_fails_is_jumped_over() {
    let src = "long skip(long x) {\n\
               long n = 0;\n\
               for (long k = 1L << 32; (int)k; k += x) { if (k & 1) n += 3; else n += 5; }\n\
               return n;\n}\n";
    let ws = a64_at(src, "skip", true);
    let branches: Vec<(usize, i64, bool)> = ws
        .iter()
        .enumerate()
        .filter_map(|(i, &w)| a64_branch(w, i).map(|(t, u)| (i, t, u)))
        .collect();
    let bottom = branches.iter().rfind(|b| b.1 <= b.0 as i64);
    let (Some(&(_, over, true)), Some(&(bottom, _, false))) = (branches.first(), bottom) else {
        panic!("aarch64: no jump over a loop: {ws:08x?}");
    };
    assert!(over > bottom as i64, "aarch64: {ws:08x?}");
    assert!(!ws[..branches[0].0].iter().any(|&w| a64_sets_flags(w)));
    let insns = x64_at(src, "skip", true);
    let first = insns.iter().find(|i| i.is_jmp() || i.is_jcc());
    let bottom = insns
        .iter()
        .rfind(|i| i.is_jcc() && i.target() <= i.at)
        .unwrap_or_else(|| panic!("x86-64: no loop: {insns:x?}"));
    assert!(
        first.is_some_and(|j| j.is_jmp() && j.target() > bottom.at),
        "x86-64: {insns:x?}"
    );
}

/// Without `-O` no test is repeated: the loop holds one conditional branch.
#[test]
fn no_test_is_repeated_without_optimization() {
    let ws = a64_at(SUM, "sum", false);
    let conds = |ws: &[u32]| {
        ws.iter()
            .enumerate()
            .filter(|&(i, &w)| matches!(a64_branch(w, i), Some((_, false))))
            .count()
    };
    assert_eq!(conds(&ws), 1, "aarch64: {ws:08x?}");
    let insns = x64_at(SUM, "sum", false);
    assert_eq!(
        insns.iter().filter(|i| i.is_jcc()).count(),
        1,
        "x86-64: {insns:x?}"
    );
    // At `-O` the repeat is the second one.
    assert_eq!(conds(&a64_at(SUM, "sum", true)), 2);
}

/// The repeat is covered by a line row, and that row names the line the
/// bottom test's row names: both hold the same instructions.
#[test]
fn repeated_test_keeps_its_source_line() {
    use crate::c5::codegen::{LowerMode, ResolvedImports, aarch64};
    use crate::{CompileOptions, Compiler, NativeOptions, Target};
    let src = "long sum(const int *a, int n) {\n\
               long s = 0;\n\
               int i = 0;\n\
               while (i < n) {\n\
               s += a[i];\n\
               i++;\n\
               }\n\
               return s;\n}\n";
    let target = Target::LinuxAarch64;
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(true),
    )
    .compile()
    .expect("compile");
    let imports = ResolvedImports::resolve(&program).expect("imports");
    let opts = NativeOptions::new().with_optimize();
    let build =
        aarch64::lower(&program, target, opts, &imports, None, LowerMode::Full).expect("lower");
    let rows = &build.ssa_line_rows;
    assert!(rows.windows(2).all(|w| w[0].0 <= w[1].0), "{rows:?}");
    let ws: Vec<u32> = build
        .text
        .as_chunks::<4>()
        .0
        .iter()
        .map(|w| u32::from_le_bytes(*w))
        .collect();
    let conds: Vec<usize> = (0..ws.len())
        .filter(|&i| matches!(a64_branch(ws[i], i), Some((_, false))))
        .collect();
    let &[guard, bottom] = conds.as_slice() else {
        panic!("a guard and a bottom test expected: {ws:08x?}");
    };
    // The row covering a pc is the last one at or below it.
    let line_at = |word: usize| {
        rows.iter()
            .rev()
            .find(|r| r.0 <= word * 4)
            .map(|r| r.1)
            .unwrap_or(0)
    };
    assert_ne!(line_at(bottom), 0, "{rows:?}");
    assert_eq!(line_at(guard), line_at(bottom), "{rows:?}");
}
