//! Computed-goto functions at `-O`.
//!
//! Every `goto *` of a function goes through one dispatch block
//! (`passes::factor_gotos`), so the scalar and loop passes treat an
//! interpreter as a loop, and the emit repeats the dispatch branch at each
//! site. Each test states what a pass does to a small interpreter, on the
//! SSA or on both targets' machine code.

use super::perf_codegen::{Misses, X64Insn, a64_at, ssa_dump, x64_at};

/// Lines of `dump` that mention `op`.
fn count(dump: &str, op: &str) -> usize {
    dump.lines().filter(|l| l.contains(op)).count()
}

/// Whether `dump` holds none of the frame-slot operations.
fn slot_free(m: &mut Misses, dump: &str, name: &str) {
    for op in ["LoadLocal", "StoreLocal", "LocalAddr", "Mcpy", "Mzero"] {
        m.expect(count(dump, op) == 0, || format!("{name}: {op}:\n{dump}"));
    }
}

/// An AArch64 load or store based on x29 or sp.
fn a64_frame_access(w: u32) -> bool {
    let load_store = w & 0x0A00_0000 == 0x0800_0000;
    let literal = w & 0x3B00_0000 == 0x1800_0000;
    let rn = (w >> 5) & 31;
    load_store && !literal && (rn == 29 || rn == 31)
}

fn a64_is_br(w: u32) -> bool {
    w & 0xFFFF_FC1F == 0xD61F_0000
}

/// `jmp *%reg`.
fn x64_is_jmp_reg(i: &X64Insn) -> bool {
    i.op == 0xFF && i.reg_form() && i.modrm.is_some_and(|m| (m >> 3) & 7 == 4)
}

/// A memory operand based on %rsp or %rbp.
fn x64_frame_access(i: &X64Insn) -> bool {
    matches!(i.mem_base(), Some(4 | 5))
}

/// An interpreter keeping `pc` and `acc` across its dispatch, reading a
/// struct through an inlined by-value helper.
const INTERP: &str = "typedef struct { long v; long tag; } Value;\n\
    static inline Value dup_value(Value x) { if (x.tag < 0) x.v++; return x; }\n\
    long interp_small(const unsigned char *code, Value *vals) {\n\
        static const void *const tab[] = { &&op_dup, &&op_halt };\n\
        const unsigned char *pc = code; long acc = 0;\n\
        goto *tab[*pc++];\n\
    op_dup: acc += dup_value(vals[*pc++]).v; goto *tab[*pc++];\n\
    op_halt: return acc;\n\
    }\n";

/// The interpreter's state lives in registers, one block dispatches, and
/// each `goto *` of the source still ends in an indirect branch of its own.
#[test]
fn interpreter_state_stays_in_registers() {
    let mut m = Misses::default();
    let dump = ssa_dump(INTERP, "interp_small", true);
    slot_free(&mut m, &dump, "SSA");
    m.expect(count(&dump, "GotoIndirect") == 1, || {
        format!("SSA: dispatch blocks:\n{dump}")
    });
    let ws = a64_at(INTERP, "interp_small", true);
    m.expect(!ws.iter().any(|&w| a64_frame_access(w)), || {
        format!("aarch64: a frame access: {ws:08x?}")
    });
    m.expect(ws.iter().filter(|&&w| a64_is_br(w)).count() == 2, || {
        format!("aarch64: not one `br` per site: {ws:08x?}")
    });
    let insns = x64_at(INTERP, "interp_small", true);
    m.expect(!insns.iter().any(x64_frame_access), || {
        format!("x86-64: a frame access: {insns:x?}")
    });
    m.expect(
        insns.iter().filter(|i| x64_is_jmp_reg(i)).count() == 2,
        || format!("x86-64: not one `jmp *` per site: {insns:x?}"),
    );
    m.finish();
}

/// A struct local a handler assigns splits into one value per field.
#[test]
fn an_aggregate_local_splits_into_its_fields() {
    const SRC: &str = "typedef struct { long v; long tag; } Value;\n\
        long pairs(const unsigned char *pc, const Value *vals) {\n\
            static const void *const tab[] = { &&op_ld, &&op_end };\n\
            Value top = { 0, 0 };\n\
            goto *tab[*pc++];\n\
        op_ld: { Value x = vals[*pc++]; if (x.tag) top = x; } goto *tab[*pc++];\n\
        op_end: return top.v + top.tag;\n\
        }\n";
    let mut m = Misses::default();
    slot_free(&mut m, &ssa_dump(SRC, "pairs", true), "pairs");
    m.finish();
}

/// A vector a handler feeds to a SIMD operand stays in a vector register.
#[test]
fn a_vector_local_stays_in_a_vector_register() {
    const SRC: &str = "typedef float v4f __attribute__((vector_size(16)));\n\
        void vacc(const unsigned char *pc, const v4f *in, v4f *out) {\n\
            static const void *const tab[] = { &&op_add, &&op_end };\n\
            v4f acc = {0, 0, 0, 0};\n\
            goto *tab[*pc++];\n\
        op_add: { v4f x = in[*pc++]; __asm__(\"addps %1, %0\" : \"+x\"(acc) : \"x\"(x)); }\n\
            goto *tab[*pc++];\n\
        op_end: *out = acc;\n\
        }\n";
    let mut m = Misses::default();
    let dump = ssa_dump(SRC, "vacc", true);
    slot_free(&mut m, &dump, "vacc");
    m.expect(
        dump.lines()
            .any(|l| l.contains("Phi {") && l.contains("V128")),
        || format!("no vector phi:\n{dump}"),
    );
    m.finish();
}

/// `op_inc` is entered by the dispatch and by the fall-through from
/// `op_inc10` with another count, so it merges the count in a phi; the
/// label's address moves to a block of its own that runs the phi's moves.
#[test]
fn a_label_entered_directly_and_indirectly_merges_its_values() {
    const SRC: &str = "long steps(const unsigned char *pc) {\n\
            static const void *const tab[] = { &&op_inc, &&op_inc10, &&op_end };\n\
            long n = 0;\n\
            goto *tab[*pc++];\n\
        op_inc10: n += 10;\n\
        op_inc: n += 1; goto *tab[*pc++];\n\
        op_end: return n;\n\
        }\n";
    let mut m = Misses::default();
    let dump = ssa_dump(SRC, "steps", true);
    slot_free(&mut m, &dump, "steps");
    let label_phis = dump
        .split("\n  block ")
        .filter(|b| !b.contains("terminator GotoIndirect"))
        .map(|b| count(b, "Phi {"))
        .sum::<usize>();
    m.expect(label_phis == 1, || {
        format!("not one phi past the dispatch:\n{dump}")
    });
    let ws = a64_at(SRC, "steps", true);
    m.expect(!ws.iter().any(|&w| a64_frame_access(w)), || {
        format!("aarch64: a frame access: {ws:08x?}")
    });
    let insns = x64_at(SRC, "steps", true);
    m.expect(!insns.iter().any(x64_frame_access), || {
        format!("x86-64: a frame access: {insns:x?}")
    });
    m.finish();
}
