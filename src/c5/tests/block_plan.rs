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

/// Blocks whose address a table or a label holds stay in the code even
/// when they hold none of their own, and every direct branch around them
/// still lands on an instruction of the function.
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
