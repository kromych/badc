//! What each `<stdatomic.h>` form lowers to, per architecture.
//!
//! The header states which forms are atomic against concurrent access
//! and what ordering each carries. These tests read the emitted bytes of
//! one function per form, on x86-64 and on aarch64, so the statement is
//! checked against the code rather than asserted; a last test reads the
//! optimized SSA for the treatment the passes owe an atomic access.

use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::ir::MemOrder;
use crate::{
    CompileOptions, Compiler, NativeOptions, NativeSymSection, OutputKind, Target,
    emit_native_with_options, parse_native_elf,
};

/// What a form is: the operation, the object's width in bytes, and the
/// order it names after the narrowing the operation applies (C11
/// 7.17.7.1p2, 7.17.7.2p2).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Op {
    /// An atomic load: `ldar` on aarch64 above relaxed, a plain load
    /// otherwise; a plain load on x86-64 for every order.
    Load(u8, MemOrder),
    /// An atomic store: `stlr` on aarch64 above relaxed, a plain store
    /// otherwise; `xchg` against memory on x86-64 for seq_cst, a plain
    /// store otherwise.
    Store(u8, MemOrder),
    /// An atomic read-modify-write: on x86-64 a `LOCK`-prefixed `XADD`
    /// / `CMPXCHG` or an `XCHG` with a memory operand, on aarch64 an
    /// `LDAXR` / `STLXR` pair of that width.
    Rmw(u8),
    /// A thread fence: `dmb ish` on aarch64, `mfence` on x86-64.
    ThreadFence(MemOrder),
    /// No instruction: `kill_dependency`, and the `<stdatomic.h>`
    /// fences, which are compiler barriers.
    Nothing,
}

struct Form {
    /// Function name, and the source of its body.
    name: &'static str,
    decl: &'static str,
    op: Op,
}

use MemOrder::{Acquire, Relaxed, Release, SeqCst};

/// Every operation `<stdatomic.h>` defines, one function each, plus the
/// `__atomic_*` / `__sync_*` spellings that take an order. The widths
/// follow the pointee type: `atomic_int` is 4 bytes, the `atomic_flag`
/// cell 1.
const FORMS: &[Form] = &[
    Form {
        name: "f_load",
        decl: "int f_load(atomic_int *p){ return atomic_load(p); }",
        op: Op::Load(4, SeqCst),
    },
    Form {
        name: "f_load_explicit",
        decl: "int f_load_explicit(atomic_int *p){ \
               return atomic_load_explicit(p, memory_order_acquire); }",
        op: Op::Load(4, Acquire),
    },
    Form {
        name: "f_load_relaxed",
        decl: "int f_load_relaxed(atomic_int *p){ \
               return atomic_load_explicit(p, memory_order_relaxed); }",
        op: Op::Load(4, Relaxed),
    },
    Form {
        name: "f_load_consume",
        decl: "int f_load_consume(atomic_int *p){ \
               return atomic_load_explicit(p, memory_order_consume); }",
        op: Op::Load(4, Acquire),
    },
    // An order a load may not name (7.17.7.2p2) takes the strongest.
    Form {
        name: "f_load_release",
        decl: "int f_load_release(atomic_int *p){ \
               return atomic_load_explicit(p, memory_order_release); }",
        op: Op::Load(4, SeqCst),
    },
    Form {
        name: "f_load_uchar",
        decl: "unsigned f_load_uchar(atomic_uchar *p){ \
               return atomic_load_explicit(p, memory_order_acquire); }",
        op: Op::Load(1, Acquire),
    },
    Form {
        name: "f_load_llong",
        decl: "long long f_load_llong(atomic_llong *p){ return atomic_load(p); }",
        op: Op::Load(8, SeqCst),
    },
    Form {
        name: "f_load_ptr",
        decl: "int *f_load_ptr(_Atomic(int *) *p){ \
               return atomic_load_explicit(p, memory_order_acquire); }",
        op: Op::Load(8, Acquire),
    },
    Form {
        name: "f_load_double",
        decl: "double f_load_double(_Atomic double *p){ return atomic_load(p); }",
        op: Op::Load(8, SeqCst),
    },
    Form {
        name: "f_store",
        decl: "void f_store(atomic_int *p){ atomic_store(p, 3); }",
        op: Op::Store(4, SeqCst),
    },
    Form {
        name: "f_store_explicit",
        decl: "void f_store_explicit(atomic_int *p){ \
               atomic_store_explicit(p, 3, memory_order_release); }",
        op: Op::Store(4, Release),
    },
    Form {
        name: "f_store_relaxed",
        decl: "void f_store_relaxed(atomic_int *p){ \
               atomic_store_explicit(p, 3, memory_order_relaxed); }",
        op: Op::Store(4, Relaxed),
    },
    Form {
        name: "f_store_seq_cst",
        decl: "void f_store_seq_cst(atomic_int *p){ \
               atomic_store_explicit(p, 3, memory_order_seq_cst); }",
        op: Op::Store(4, SeqCst),
    },
    // An order a store may not name (7.17.7.1p2) takes the strongest.
    Form {
        name: "f_store_acquire",
        decl: "void f_store_acquire(atomic_int *p){ \
               atomic_store_explicit(p, 3, memory_order_acquire); }",
        op: Op::Store(4, SeqCst),
    },
    Form {
        name: "f_store_ushort",
        decl: "void f_store_ushort(atomic_ushort *p){ \
               atomic_store_explicit(p, 3, memory_order_release); }",
        op: Op::Store(2, Release),
    },
    Form {
        name: "f_store_llong",
        decl: "void f_store_llong(atomic_llong *p){ atomic_store(p, 3); }",
        op: Op::Store(8, SeqCst),
    },
    Form {
        name: "f_store_float",
        decl: "void f_store_float(_Atomic float *p, float v){ \
               atomic_store_explicit(p, v, memory_order_release); }",
        op: Op::Store(4, Release),
    },
    Form {
        name: "f_init",
        decl: "void f_init(atomic_int *p){ atomic_init(p, 3); }",
        op: Op::Store(4, Relaxed),
    },
    Form {
        name: "f_exchange",
        decl: "int f_exchange(atomic_int *p){ return atomic_exchange(p, 7); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_exchange_explicit",
        decl: "int f_exchange_explicit(atomic_int *p){ \
               return atomic_exchange_explicit(p, 7, memory_order_acq_rel); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_add",
        decl: "int f_fetch_add(atomic_int *p){ return atomic_fetch_add(p, 1); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_add_explicit",
        decl: "int f_fetch_add_explicit(atomic_int *p){ \
               return atomic_fetch_add_explicit(p, 1, memory_order_relaxed); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_sub",
        decl: "int f_fetch_sub(atomic_int *p){ return atomic_fetch_sub(p, 1); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_sub_explicit",
        decl: "int f_fetch_sub_explicit(atomic_int *p){ \
               return atomic_fetch_sub_explicit(p, 1, memory_order_seq_cst); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_and",
        decl: "int f_fetch_and(atomic_int *p){ return atomic_fetch_and(p, 5); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_and_explicit",
        decl: "int f_fetch_and_explicit(atomic_int *p){ \
               return atomic_fetch_and_explicit(p, 5, memory_order_seq_cst); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_or",
        decl: "int f_fetch_or(atomic_int *p){ return atomic_fetch_or(p, 5); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_or_explicit",
        decl: "int f_fetch_or_explicit(atomic_int *p){ \
               return atomic_fetch_or_explicit(p, 5, memory_order_seq_cst); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_xor",
        decl: "int f_fetch_xor(atomic_int *p){ return atomic_fetch_xor(p, 5); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_fetch_xor_explicit",
        decl: "int f_fetch_xor_explicit(atomic_int *p){ \
               return atomic_fetch_xor_explicit(p, 5, memory_order_seq_cst); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_cas_strong",
        decl: "int f_cas_strong(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong(p, e, 9); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_cas_strong_explicit",
        decl: "int f_cas_strong_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong_explicit( \
                   p, e, 9, memory_order_acq_rel, memory_order_acquire); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_cas_weak",
        decl: "int f_cas_weak(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak(p, e, 9); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_cas_weak_explicit",
        decl: "int f_cas_weak_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak_explicit( \
                   p, e, 9, memory_order_release, memory_order_relaxed); }",
        op: Op::Rmw(4),
    },
    Form {
        name: "f_flag_test_and_set",
        decl: "int f_flag_test_and_set(atomic_flag *f){ return atomic_flag_test_and_set(f); }",
        op: Op::Rmw(1),
    },
    Form {
        name: "f_flag_test_and_set_explicit",
        decl: "int f_flag_test_and_set_explicit(atomic_flag *f){ \
               return atomic_flag_test_and_set_explicit(f, memory_order_acquire); }",
        op: Op::Rmw(1),
    },
    Form {
        name: "f_flag_clear",
        decl: "void f_flag_clear(atomic_flag *f){ atomic_flag_clear(f); }",
        op: Op::Store(1, SeqCst),
    },
    Form {
        name: "f_flag_clear_explicit",
        decl: "void f_flag_clear_explicit(atomic_flag *f){ \
               atomic_flag_clear_explicit(f, memory_order_release); }",
        op: Op::Store(1, Release),
    },
    Form {
        name: "f_thread_fence",
        decl: "void f_thread_fence(void){ atomic_thread_fence(memory_order_seq_cst); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_thread_fence_acquire",
        decl: "void f_thread_fence_acquire(void){ atomic_thread_fence(memory_order_acquire); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_thread_fence_release",
        decl: "void f_thread_fence_release(void){ atomic_thread_fence(memory_order_release); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_thread_fence_acq_rel",
        decl: "void f_thread_fence_acq_rel(void){ atomic_thread_fence(memory_order_acq_rel); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_thread_fence_relaxed",
        decl: "void f_thread_fence_relaxed(void){ atomic_thread_fence(memory_order_relaxed); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_signal_fence",
        decl: "void f_signal_fence(void){ atomic_signal_fence(memory_order_seq_cst); }",
        op: Op::Nothing,
    },
    Form {
        name: "f_kill_dependency",
        decl: "int f_kill_dependency(int y){ return kill_dependency(y); }",
        op: Op::Nothing,
    },
    // The `__atomic_*` / `__sync_*` spellings.
    Form {
        name: "f_gcc_load_n",
        decl: "int f_gcc_load_n(int *p){ return __atomic_load_n(p, __ATOMIC_ACQUIRE); }",
        op: Op::Load(4, Acquire),
    },
    Form {
        name: "f_gcc_load",
        decl: "void f_gcc_load(int *p, int *r){ __atomic_load(p, r, __ATOMIC_SEQ_CST); }",
        op: Op::Load(4, SeqCst),
    },
    Form {
        name: "f_gcc_store_n",
        decl: "void f_gcc_store_n(int *p){ __atomic_store_n(p, 3, __ATOMIC_RELEASE); }",
        op: Op::Store(4, Release),
    },
    Form {
        name: "f_gcc_store",
        decl: "void f_gcc_store(int *p, int *v){ __atomic_store(p, v, __ATOMIC_SEQ_CST); }",
        op: Op::Store(4, SeqCst),
    },
    Form {
        name: "f_gcc_clear",
        decl: "void f_gcc_clear(unsigned char *p){ __atomic_clear(p, __ATOMIC_RELEASE); }",
        op: Op::Store(1, Release),
    },
    Form {
        name: "f_sync_lock_release",
        decl: "void f_sync_lock_release(int *p){ __sync_lock_release(p); }",
        op: Op::Store(4, Release),
    },
    Form {
        name: "f_sync_synchronize",
        decl: "void f_sync_synchronize(void){ __sync_synchronize(); }",
        op: Op::ThreadFence(SeqCst),
    },
    Form {
        name: "f_gcc_thread_fence",
        decl: "void f_gcc_thread_fence(void){ __atomic_thread_fence(__ATOMIC_ACQUIRE); }",
        op: Op::ThreadFence(SeqCst),
    },
    Form {
        name: "f_gcc_signal_fence",
        decl: "void f_gcc_signal_fence(void){ __atomic_signal_fence(__ATOMIC_SEQ_CST); }",
        op: Op::ThreadFence(SeqCst),
    },
];

/// One translation unit holding every form.
fn unit_source() -> String {
    let mut src = String::from("#include <stdatomic.h>\n");
    for form in FORMS {
        src.push_str(form.decl);
        src.push('\n');
    }
    src
}

/// Emit the forms unit as a relocatable object for `target` and return
/// each function's `.text` bytes, keyed by name.
fn function_bytes(target: Target) -> Vec<(String, Vec<u8>)> {
    let out = function_bytes_of(&unit_source(), target, false);
    assert_eq!(
        out.len(),
        FORMS.len(),
        "{target:?}: expected one text symbol per form, got {:?}",
        out.iter().map(|(n, _)| n).collect::<Vec<_>>()
    );
    out
}

/// Emit `src` as a relocatable object for `target`, under `-O` when
/// `optimize`, and return the `.text` bytes of each `f_*` function,
/// keyed by name. A function runs from its symbol value to the next
/// function's, so inter-function padding is included; padding carries
/// no atomic or ordering encoding.
fn function_bytes_of(src: &str, target: Target, optimize: bool) -> Vec<(String, Vec<u8>)> {
    let opts = CompileOptions::default()
        .with_no_entry_point(true)
        .with_optimize(optimize);
    let program = Compiler::with_options(String::from(src), target, opts)
        .compile()
        .expect("compile the atomics unit");
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..if optimize {
            NativeOptions::new().with_optimize()
        } else {
            NativeOptions::default()
        }
    };
    let bytes = emit_native_with_options(&program, target, nopts).expect("emit a relocatable");
    let obj = parse_native_elf(&bytes).expect("parse the relocatable");

    let mut starts: Vec<(u64, String)> = obj
        .symbols
        .iter()
        .filter(|s| s.section == NativeSymSection::Text && s.name.starts_with("f_"))
        .map(|s| (s.value, s.name.clone()))
        .collect();
    starts.sort_by_key(|(v, _)| *v);

    let mut out = Vec::with_capacity(starts.len());
    for (i, (value, name)) in starts.iter().enumerate() {
        let end = starts
            .get(i + 1)
            .map(|(v, _)| *v as usize)
            .unwrap_or(obj.text.len());
        out.push((name.clone(), obj.text[*value as usize..end].to_vec()));
    }
    out
}

/// One form's emitted bytes, by function name.
fn lookup<'a>(code: &'a [(String, Vec<u8>)], name: &'a str) -> (&'a str, &'a [u8]) {
    code.iter()
        .find(|(n, _)| n == name)
        .map(|(n, b)| (n.as_str(), b.as_slice()))
        .unwrap_or_else(|| panic!("{name}: no text symbol in the emitted unit"))
}

/// Does `code` carry a `LOCK`-prefixed `XADD` (`0F C1`) or `CMPXCHG`
/// (`0F B1`)? The emitter puts at most one REX byte between the `F0`
/// prefix and the escape byte.
fn has_lock_rmw(code: &[u8]) -> bool {
    (0..code.len()).any(|i| {
        if code[i] != 0xF0 {
            return false;
        }
        let j = i + 1 + usize::from(code.get(i + 1).is_some_and(|b| (0x40..=0x4F).contains(b)));
        matches!(
            (code.get(j), code.get(j + 1)),
            (Some(0x0F), Some(0xC1)) | (Some(0x0F), Some(0xB1))
        )
    })
}

/// Does `code` carry an `XCHG r/m, r` (`86` byte-wide, `87` otherwise)
/// against memory? `XCHG` with a memory operand is atomic with no `LOCK`
/// prefix (Intel SDM Vol.2). The emitter always writes a REX byte before
/// the opcode and addresses the operand through a base register with no
/// displacement, so the modrm's mod field is 0.
fn has_xchg_mem(code: &[u8], width: u8) -> bool {
    let opcode = if width == 1 { 0x86 } else { 0x87 };
    code.windows(3)
        .any(|w| (0x40..=0x4F).contains(&w[0]) && w[1] == opcode && (w[2] >> 6) != 0b11)
}

/// The widths of the `XCHG` against memory in `code`: 1 for the
/// byte-wide opcode, 8 for the other (the 2- and 4-byte forms share it
/// and are told apart by prefixes the check does not read).
fn xchg_widths(code: &[u8]) -> Vec<u8> {
    [1u8, 8]
        .into_iter()
        .filter(|&w| has_xchg_mem(code, w))
        .collect()
}

/// x86-64 `MFENCE` (`0F AE F0`).
fn has_mfence(code: &[u8]) -> bool {
    code.windows(3).any(|w| w == [0x0F, 0xAE, 0xF0])
}

/// x86-64 `MFENCE` / `LFENCE` / `SFENCE` (`0F AE F0` / `E8` / `F8`).
fn has_x64_fence(code: &[u8]) -> bool {
    code.windows(3)
        .any(|w| w[0] == 0x0F && w[1] == 0xAE && matches!(w[2], 0xF0 | 0xE8 | 0xF8))
}

/// The 32-bit words of an aarch64 function.
fn a64_words(code: &[u8]) -> Vec<u32> {
    (0..code.len() / 4)
        .map(|i| {
            let w = &code[i * 4..i * 4 + 4];
            u32::from_le_bytes([w[0], w[1], w[2], w[3]])
        })
        .collect()
}

/// The `size` field (bits 31:30) an exclusive or ordered access of
/// `width` bytes carries: 1 -> `B`, 2 -> `H`, 4 -> word, 8 -> doubleword.
fn excl_size(width: u8) -> u32 {
    match width {
        1 => 0,
        2 => 1,
        4 => 2,
        _ => 3,
    }
}

/// `LDAXR{B,H}` / `STLXR{B,H}` of `width` bytes (ARM ARM C6.2) -- the
/// acquire / release exclusive pair, not the plain `LDXR` / `STXR`. The
/// masks clear the register fields and keep the size field.
fn has_ldaxr_stlxr(words: &[u32], width: u8) -> (bool, bool) {
    let size = excl_size(width) << 30;
    let ldaxr = words
        .iter()
        .any(|w| w & 0xFFFF_FC00 == (0x085F_FC00 | size));
    let stlxr = words
        .iter()
        .any(|w| w & 0xFFE0_FC00 == (0x0800_FC00 | size));
    (ldaxr, stlxr)
}

/// Every aarch64 instruction in a function that orders memory, by kind.
#[derive(Default, PartialEq, Eq, Debug)]
struct A64Ordering {
    /// Widths of the `LDAR{B,H}` instructions, in order.
    ldar: Vec<u8>,
    /// Widths of the `STLR{B,H}` instructions, in order.
    stlr: Vec<u8>,
    /// An exclusive access of any width, ordered or plain.
    exclusive: bool,
    /// The `CRm` option of each `DMB` / `DSB` / `ISB`: 0b1011 is `ISH`,
    /// 0b1001 `ISHLD`.
    barrier: Vec<u32>,
}

const DMB_ISH: u32 = 0b1011;
const DMB_ISHLD: u32 = 0b1001;

fn a64_ordering(words: &[u32]) -> A64Ordering {
    let mut o = A64Ordering::default();
    for &w in words {
        let width = 1u8 << (w >> 30);
        if w & 0x3FFF_FC00 == 0x08DF_FC00 {
            o.ldar.push(width);
        } else if w & 0x3FFF_FC00 == 0x089F_FC00 {
            o.stlr.push(width);
        } else if w & 0x3FFF_7C00 == 0x085F_7C00 || w & 0x3FE0_7C00 == 0x0800_7C00 {
            // LDAXR / LDXR and STLXR / STXR of any width: the masks drop
            // the `o0` bit, so both the ordered and the plain match.
            o.exclusive = true;
        } else if w & 0xFFFF_F01F == 0xD503_301F && matches!((w >> 5) & 7, 4..=6) {
            o.barrier.push((w >> 8) & 0xF);
        }
    }
    o
}

/// The x86-64 lowering of every form: `Op::Rmw` is a `LOCK`-prefixed
/// `XADD` / `CMPXCHG` or an `XCHG` against memory, which is locked
/// implicitly (Intel SDM Vol.2); a seq_cst `Op::Store` is the `XCHG`
/// alone; the seq_cst `Op::ThreadFence` is `MFENCE`; everything else --
/// a load of any order, a relaxed or release store, the weaker fences --
/// is a plain access or nothing, with no atomic or fence instruction.
#[test]
fn stdatomic_forms_lower_as_documented_x86_64() {
    let code = function_bytes(Target::LinuxX64);
    for form in FORMS {
        let (name, bytes) = lookup(&code, form.name);
        let lock = has_lock_rmw(bytes);
        let xchg = xchg_widths(bytes);
        let fence = has_x64_fence(bytes);
        match form.op {
            Op::Rmw(width) => assert!(
                lock || has_xchg_mem(bytes, width),
                "{name}: no LOCK XADD / LOCK CMPXCHG and no {width}-byte XCHG against memory \
                 in {bytes:02x?}"
            ),
            Op::Store(width, SeqCst) => assert!(
                !lock && !fence && xchg == [if width == 1 { 1 } else { 8 }],
                "{name}: a seq_cst store is one XCHG against memory; lock={lock} \
                 fence={fence} xchg={xchg:?} in {bytes:02x?}"
            ),
            Op::ThreadFence(SeqCst) => assert!(
                has_mfence(bytes) && !lock && xchg.is_empty(),
                "{name}: a seq_cst thread fence is MFENCE alone in {bytes:02x?}"
            ),
            Op::Load(..) | Op::Store(..) | Op::ThreadFence(_) | Op::Nothing => assert!(
                !lock && !fence && xchg.is_empty(),
                "{name}: an atomic read-modify-write, XCHG or fence in {bytes:02x?}"
            ),
        }
    }
}

/// The aarch64 lowering of every form: `Op::Rmw` is an `LDAXR` /
/// `STLXR` retry loop at the object's width; an `Op::Load` above relaxed
/// is one `LDAR` of the width and an `Op::Store` above relaxed one
/// `STLR`, with no other ordering instruction; the seq_cst, release and
/// acq_rel `Op::ThreadFence` are `DMB ISH` and the acquire one `DMB
/// ISHLD`; a relaxed access or fence, a signal fence and
/// `kill_dependency` carry no ordering instruction whatever.
#[test]
fn stdatomic_forms_lower_as_documented_aarch64() {
    let code = function_bytes(Target::LinuxAarch64);
    for form in FORMS {
        let (name, bytes) = lookup(&code, form.name);
        let words = a64_words(bytes);
        let ord = a64_ordering(&words);
        let expect = match form.op {
            Op::Rmw(width) => {
                let (ldaxr, stlxr) = has_ldaxr_stlxr(&words, width);
                assert!(
                    ldaxr && stlxr,
                    "{name}: no {width}-byte LDAXR / STLXR pair (ldaxr={ldaxr}, stlxr={stlxr}) \
                     in {words:08x?}"
                );
                continue;
            }
            Op::Load(width, order) if order != Relaxed => A64Ordering {
                ldar: alloc::vec![width],
                ..Default::default()
            },
            Op::Store(width, order) if order != Relaxed => A64Ordering {
                stlr: alloc::vec![width],
                ..Default::default()
            },
            Op::ThreadFence(Acquire) => A64Ordering {
                barrier: alloc::vec![DMB_ISHLD],
                ..Default::default()
            },
            Op::ThreadFence(_) => A64Ordering {
                barrier: alloc::vec![DMB_ISH],
                ..Default::default()
            },
            Op::Load(..) | Op::Store(..) | Op::Nothing => A64Ordering::default(),
        };
        assert_eq!(ord, expect, "{name}: ordering instructions in {words:08x?}");
    }
}

/// The `--dump-ssa` text of function `name` of `src` after the `-O`
/// passes, split into instructions and terminators. A pass that reuses
/// an earlier value redirects the uses and leaves the superseded
/// instruction in place, so what a result depends on is what the passes
/// kept; the dump is read through operand edges for that reason.
struct Dump {
    /// Each instruction's id, block and text, the text cut before the
    /// allocated place.
    insts: Vec<(u32, usize, String)>,
    /// Each block's terminator text, in block order.
    terms: Vec<String>,
}

fn optimized_dump(src: &str, name: &str) -> Dump {
    let opts = CompileOptions::default()
        .with_no_entry_point(true)
        .with_optimize(true);
    let src = alloc::format!("#include <stdatomic.h>\n{src}");
    let program = Compiler::with_options(src, Target::LinuxX64, opts)
        .compile()
        .expect("compile");
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::new().with_optimize().with_dump_ssa()
    };
    let text = crate::c5::codegen::lower_for(&program, Target::LinuxX64, nopts)
        .expect("lower")
        .ssa_dump;
    let head = alloc::format!("; name={name}\n");
    let start = text
        .find(&head)
        .unwrap_or_else(|| panic!("no `{name}` in the dump:\n{text}"));
    let body = &text[start + head.len()..];
    let body = body.split("\n; ").next().unwrap_or(body);
    let mut dump = Dump {
        insts: Vec::new(),
        terms: Vec::new(),
    };
    let mut block = 0usize;
    for line in body.lines().map(str::trim_start) {
        if let Some(rest) = line.strip_prefix("block ") {
            block = rest
                .split_whitespace()
                .next()
                .and_then(|n| n.parse().ok())
                .expect("a block number");
        } else if let Some(rest) = line.strip_prefix("terminator ") {
            dump.terms.push(String::from(rest));
        } else if let Some(rest) = line.strip_prefix('v')
            && let Some((id, inst)) = rest.split_once(char::is_whitespace)
            && let Ok(id) = id.parse::<u32>()
        {
            let inst = inst.split("->").next().unwrap_or(inst).trim();
            dump.insts.push((id, block, String::from(inst)));
        }
    }
    dump
}

/// The `vN` values named in an instruction's or terminator's text.
fn operands(text: &str) -> impl Iterator<Item = u32> + '_ {
    text.split(|c: char| !c.is_ascii_alphanumeric())
        .filter_map(|t| t.strip_prefix('v').and_then(|n| n.parse().ok()))
}

impl Dump {
    /// The instructions `from` depends on whose text starts with `inst`.
    fn reaching(&self, from: u32, inst: &str) -> Vec<u32> {
        let mut seen: Vec<u32> = Vec::new();
        let mut work = alloc::vec![from];
        let mut hits = Vec::new();
        while let Some(v) = work.pop() {
            if seen.contains(&v) {
                continue;
            }
            seen.push(v);
            let Some((_, _, text)) = self.insts.iter().find(|(id, ..)| *id == v) else {
                continue;
            };
            if text.starts_with(inst) {
                hits.push(v);
            }
            work.extend(operands(text));
        }
        hits
    }

    fn returned(&self) -> u32 {
        self.terms
            .iter()
            .find_map(|t| t.strip_prefix("Return(v"))
            .and_then(|r| r.split(')').next()?.parse().ok())
            .expect("a return")
    }

    fn block_of(&self, id: u32) -> usize {
        self.insts
            .iter()
            .find(|(i, ..)| *i == id)
            .map(|(_, b, _)| *b)
            .expect("a known value")
    }

    /// Whether some block at or after `from` branches to a block at or
    /// before `to`.
    fn has_back_edge(&self, from: usize, to: usize) -> bool {
        self.terms.iter().skip(from).any(|t| {
            t.split(|c: char| !c.is_ascii_alphanumeric())
                .filter_map(|tok| tok.strip_prefix('b').and_then(|n| n.parse::<usize>().ok()))
                .any(|target| target <= to)
        })
    }
}

/// The passes keep every atomic access and move no memory access across
/// an ordering point (C11 5.1.2.4, 7.17.3p16): two relaxed loads of one
/// object stay two loads, a load after an acquire load or a fence does
/// not take the value the store before them wrote, the load a spin loop
/// repeats stays in the loop, and an unused acquire load is emitted.
#[test]
fn optimizer_keeps_atomic_accesses_and_their_ordering() {
    let two_loads = optimized_dump(
        "int f(atomic_int *p){ \
           int a = atomic_load_explicit(p, memory_order_relaxed); \
           int b = atomic_load_explicit(p, memory_order_relaxed); \
           return a - b; }",
        "f",
    );
    assert_eq!(
        two_loads.reaching(two_loads.returned(), "AtomicLoad").len(),
        2,
        "two relaxed loads of one object are two accesses: {:?}",
        two_loads.insts
    );

    // The control: a load after a store of the same object takes the
    // stored value. An acquire load or a fence between them keeps it a
    // load.
    let merged = optimized_dump("int f(int *q){ *q = 1; return *q; }", "f");
    assert!(
        merged.reaching(merged.returned(), "Load").is_empty(),
        "{:?}",
        merged.insts
    );
    let across_acquire = optimized_dump(
        "int f(int *q, atomic_int *p){ *q = 1; \
           atomic_load_explicit(p, memory_order_acquire); return *q; }",
        "f",
    );
    assert_eq!(
        across_acquire
            .reaching(across_acquire.returned(), "Load")
            .len(),
        1,
        "{:?}",
        across_acquire.insts
    );
    let across_fence = optimized_dump(
        "int f(int *q){ *q = 1; atomic_thread_fence(memory_order_acquire); return *q; }",
        "f",
    );
    assert_eq!(
        across_fence.reaching(across_fence.returned(), "Load").len(),
        1,
        "{:?}",
        across_fence.insts
    );

    let spin = optimized_dump(
        "void f(atomic_int *p){ while (!atomic_load_explicit(p, memory_order_relaxed)) ; }",
        "f",
    );
    let (branch_block, load) = spin
        .terms
        .iter()
        .enumerate()
        .find_map(|(b, t)| {
            let cond = t
                .strip_prefix("Bz { cond=v")
                .or(t.strip_prefix("Bnz { cond=v"))?;
            let cond: u32 = cond.split(',').next()?.parse().ok()?;
            spin.reaching(cond, "AtomicLoad").first().map(|&v| (b, v))
        })
        .expect("a branch on the spin loop's load");
    let load_block = spin.block_of(load);
    assert!(
        spin.has_back_edge(branch_block, load_block),
        "the load (block {load_block}) stays in the loop: {:?}",
        spin.terms
    );

    // The emit skips a pure value nothing uses; an atomic load is not
    // one, so the `ldar` is in the code.
    let code = function_bytes_of(
        "#include <stdatomic.h>\n\
         void f_unused(atomic_int *p){ atomic_load_explicit(p, memory_order_acquire); }\n",
        Target::LinuxAarch64,
        true,
    );
    let (_, bytes) = lookup(&code, "f_unused");
    assert_eq!(
        a64_ordering(&a64_words(bytes)).ldar,
        [4],
        "an unused acquire load is performed: {:08x?}",
        a64_words(bytes)
    );
}
