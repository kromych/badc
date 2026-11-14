//! What each `<stdatomic.h>` form lowers to, per architecture.
//!
//! The header states which forms are atomic against concurrent access
//! and what ordering each carries. These tests read the emitted bytes of
//! one function per form, on x86-64 and on aarch64, so the statement is
//! checked against the code rather than asserted; a last test reads the
//! optimized SSA for the treatment the passes owe an atomic access.

use alloc::string::String;
use alloc::vec::Vec;

use super::perf_codegen::x64_insns;
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
    /// An atomic load: on aarch64 `ldapr` for acquire, `ldar` for
    /// seq_cst, a plain load for relaxed; a plain load on x86-64 for
    /// every order.
    Load(u8, MemOrder),
    /// An atomic store: `stlr` on aarch64 above relaxed, a plain store
    /// otherwise; `xchg` against memory on x86-64 for seq_cst, a plain
    /// store otherwise.
    Store(u8, MemOrder),
    /// An atomic read-modify-write or compare-exchange carrying an order:
    /// on x86-64 a `LOCK`-prefixed `XADD` / `CMPXCHG` / `AND` / `OR` /
    /// `XOR` or an `XCHG` with a memory operand, on aarch64 one LSE
    /// instruction of that width with the order's acquire and release
    /// bits.
    Rmw(u8, MemOrder),
    /// A thread fence: `dmb ish` on aarch64 (`dmb ishld` for acquire);
    /// `mfence` on x86-64 for seq_cst and nothing for the rest.
    ThreadFence(MemOrder),
    /// No instruction: a signal fence, a relaxed fence, or
    /// `kill_dependency`.
    Nothing,
}

struct Form {
    /// Function name, and the source of its body.
    name: &'static str,
    decl: &'static str,
    op: Op,
}

use MemOrder::{AcqRel, Acquire, Relaxed, Release, SeqCst};

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
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_exchange_explicit",
        decl: "int f_exchange_explicit(atomic_int *p){ \
               return atomic_exchange_explicit(p, 7, memory_order_acq_rel); }",
        op: Op::Rmw(4, AcqRel),
    },
    Form {
        name: "f_fetch_add",
        decl: "int f_fetch_add(atomic_int *p){ return atomic_fetch_add(p, 1); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_fetch_add_explicit",
        decl: "int f_fetch_add_explicit(atomic_int *p){ \
               return atomic_fetch_add_explicit(p, 1, memory_order_relaxed); }",
        op: Op::Rmw(4, Relaxed),
    },
    Form {
        name: "f_fetch_sub",
        decl: "int f_fetch_sub(atomic_int *p){ return atomic_fetch_sub(p, 1); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_fetch_sub_explicit",
        decl: "int f_fetch_sub_explicit(atomic_int *p){ \
               return atomic_fetch_sub_explicit(p, 1, memory_order_release); }",
        op: Op::Rmw(4, Release),
    },
    Form {
        name: "f_fetch_and",
        decl: "int f_fetch_and(atomic_int *p){ return atomic_fetch_and(p, 5); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_fetch_and_explicit",
        decl: "int f_fetch_and_explicit(atomic_int *p){ \
               return atomic_fetch_and_explicit(p, 5, memory_order_acquire); }",
        op: Op::Rmw(4, Acquire),
    },
    Form {
        name: "f_fetch_or",
        decl: "int f_fetch_or(atomic_int *p){ return atomic_fetch_or(p, 5); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_fetch_or_explicit",
        decl: "int f_fetch_or_explicit(atomic_int *p){ \
               return atomic_fetch_or_explicit(p, 5, memory_order_acq_rel); }",
        op: Op::Rmw(4, AcqRel),
    },
    Form {
        name: "f_fetch_xor",
        decl: "int f_fetch_xor(atomic_int *p){ return atomic_fetch_xor(p, 5); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_fetch_xor_explicit",
        decl: "int f_fetch_xor_explicit(atomic_int *p){ \
               return atomic_fetch_xor_explicit(p, 5, memory_order_consume); }",
        op: Op::Rmw(4, Acquire),
    },
    Form {
        name: "f_cas_strong",
        decl: "int f_cas_strong(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong(p, e, 9); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_cas_strong_explicit",
        decl: "int f_cas_strong_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong_explicit( \
                   p, e, 9, memory_order_acq_rel, memory_order_acquire); }",
        op: Op::Rmw(4, AcqRel),
    },
    Form {
        name: "f_cas_weak",
        decl: "int f_cas_weak(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak(p, e, 9); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_cas_weak_explicit",
        decl: "int f_cas_weak_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak_explicit( \
                   p, e, 9, memory_order_release, memory_order_relaxed); }",
        op: Op::Rmw(4, Release),
    },
    Form {
        name: "f_flag_test_and_set",
        decl: "int f_flag_test_and_set(atomic_flag *f){ return atomic_flag_test_and_set(f); }",
        op: Op::Rmw(1, SeqCst),
    },
    Form {
        name: "f_flag_test_and_set_explicit",
        decl: "int f_flag_test_and_set_explicit(atomic_flag *f){ \
               return atomic_flag_test_and_set_explicit(f, memory_order_acquire); }",
        op: Op::Rmw(1, Acquire),
    },
    Form {
        name: "f_builtin_fetch_add_release",
        decl: "int f_builtin_fetch_add_release(int *p){ \
               return __atomic_fetch_add(p, 1, __ATOMIC_RELEASE); }",
        op: Op::Rmw(4, Release),
    },
    Form {
        name: "f_builtin_add_fetch_llong",
        decl: "long long f_builtin_add_fetch_llong(long long *p){ \
               return __atomic_add_fetch(p, 2, __ATOMIC_ACQUIRE); }",
        op: Op::Rmw(8, Acquire),
    },
    Form {
        name: "f_builtin_exchange_short",
        decl: "short f_builtin_exchange_short(short *p){ \
               return __atomic_exchange_n(p, 3, __ATOMIC_RELAXED); }",
        op: Op::Rmw(2, Relaxed),
    },
    Form {
        name: "f_builtin_fetch_or_unused",
        decl: "void f_builtin_fetch_or_unused(int *p){ \
               __atomic_fetch_or(p, 4, __ATOMIC_SEQ_CST); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_builtin_cas_ptr",
        decl: "int f_builtin_cas_ptr(int **p, int **e, int *d){ \
               return __atomic_compare_exchange_n( \
                   p, e, d, 0, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED); }",
        op: Op::Rmw(8, Acquire),
    },
    Form {
        name: "f_builtin_cas_char",
        decl: "int f_builtin_cas_char(char *p, char e, char d){ \
               return __atomic_compare_exchange_n( \
                   p, &e, d, 1, __ATOMIC_RELAXED, __ATOMIC_RELAXED); }",
        op: Op::Rmw(1, Relaxed),
    },
    // A failure order that acquires where the success order does not
    // makes the one instruction acquire as well as release.
    Form {
        name: "f_builtin_cas_release_acquire",
        decl: "int f_builtin_cas_release_acquire(int *p, int *e){ \
               return __atomic_compare_exchange_n( \
                   p, e, 9, 0, __ATOMIC_RELEASE, __ATOMIC_ACQUIRE); }",
        op: Op::Rmw(4, AcqRel),
    },
    Form {
        name: "f_builtin_test_and_set",
        decl: "int f_builtin_test_and_set(unsigned char *p){ \
               return __atomic_test_and_set(p, __ATOMIC_RELEASE); }",
        op: Op::Rmw(1, Release),
    },
    Form {
        name: "f_sync_fetch_and_add",
        decl: "int f_sync_fetch_and_add(int *p){ return __sync_fetch_and_add(p, 1); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_sync_lock_test_and_set",
        decl: "int f_sync_lock_test_and_set(int *p){ return __sync_lock_test_and_set(p, 1); }",
        op: Op::Rmw(4, Acquire),
    },
    Form {
        name: "f_sync_val_cas",
        decl: "int f_sync_val_cas(int *p){ return __sync_val_compare_and_swap(p, 1, 2); }",
        op: Op::Rmw(4, SeqCst),
    },
    Form {
        name: "f_sync_bool_cas",
        decl: "int f_sync_bool_cas(long long *p){ \
               return __sync_bool_compare_and_swap(p, 1, 2); }",
        op: Op::Rmw(8, SeqCst),
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
        op: Op::ThreadFence(SeqCst),
    },
    Form {
        name: "f_thread_fence_acquire",
        decl: "void f_thread_fence_acquire(void){ atomic_thread_fence(memory_order_acquire); }",
        op: Op::ThreadFence(Acquire),
    },
    Form {
        name: "f_thread_fence_release",
        decl: "void f_thread_fence_release(void){ atomic_thread_fence(memory_order_release); }",
        op: Op::ThreadFence(Release),
    },
    Form {
        name: "f_thread_fence_acq_rel",
        decl: "void f_thread_fence_acq_rel(void){ atomic_thread_fence(memory_order_acq_rel); }",
        op: Op::ThreadFence(AcqRel),
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
        name: "f_builtin_load_n",
        decl: "int f_builtin_load_n(int *p){ return __atomic_load_n(p, __ATOMIC_ACQUIRE); }",
        op: Op::Load(4, Acquire),
    },
    Form {
        name: "f_builtin_load",
        decl: "void f_builtin_load(int *p, int *r){ __atomic_load(p, r, __ATOMIC_SEQ_CST); }",
        op: Op::Load(4, SeqCst),
    },
    Form {
        name: "f_builtin_store_n",
        decl: "void f_builtin_store_n(int *p){ __atomic_store_n(p, 3, __ATOMIC_RELEASE); }",
        op: Op::Store(4, Release),
    },
    Form {
        name: "f_builtin_store",
        decl: "void f_builtin_store(int *p, int *v){ __atomic_store(p, v, __ATOMIC_SEQ_CST); }",
        op: Op::Store(4, SeqCst),
    },
    Form {
        name: "f_builtin_clear",
        decl: "void f_builtin_clear(unsigned char *p){ __atomic_clear(p, __ATOMIC_RELEASE); }",
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
        name: "f_builtin_thread_fence",
        decl: "void f_builtin_thread_fence(void){ __atomic_thread_fence(__ATOMIC_ACQUIRE); }",
        op: Op::ThreadFence(Acquire),
    },
    Form {
        name: "f_builtin_signal_fence",
        decl: "void f_builtin_signal_fence(void){ __atomic_signal_fence(__ATOMIC_SEQ_CST); }",
        op: Op::Nothing,
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

/// Does `code` carry a `LOCK`-prefixed read-modify-write against memory:
/// `XADD` (`0F C0` / `C1`), `CMPXCHG` (`0F B0` / `B1`), or `ADD` / `SUB`
/// / `AND` / `OR` / `XOR`, of a register (`00` / `01`, `28` / `29`, `20` /
/// `21`, `08` / `09`, `30` / `31`) or an immediate (`80`, `81`, `83`)?
fn has_lock_rmw(code: &[u8]) -> bool {
    x64_insns(code).iter().any(|i| {
        let locked = code[i.at..]
            .iter()
            .take_while(|b| matches!(b, 0x66 | 0xF0 | 0xF2 | 0xF3))
            .any(|&b| b == 0xF0);
        locked
            && !i.reg_form()
            && matches!(
                i.op,
                0x0FB0
                    | 0x0FB1
                    | 0x0FC0
                    | 0x0FC1
                    | 0x00
                    | 0x01
                    | 0x28
                    | 0x29
                    | 0x20
                    | 0x21
                    | 0x08
                    | 0x09
                    | 0x30
                    | 0x31
                    | 0x80
                    | 0x81
                    | 0x83
            )
    })
}

/// Does `code` carry an `XCHG r/m, r` (`86` byte-wide, `87` otherwise)
/// against memory? `XCHG` with a memory operand is atomic with no `LOCK`
/// prefix (Intel SDM Vol.2).
fn has_xchg_mem(code: &[u8], width: u8) -> bool {
    let opcode = if width == 1 { 0x86 } else { 0x87 };
    x64_insns(code)
        .iter()
        .any(|i| i.op == opcode && !i.reg_form())
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
    x64_insns(code)
        .iter()
        .any(|i| i.op == 0x0FAE && i.modrm == Some(0xF0))
}

/// x86-64 `MFENCE` / `LFENCE` / `SFENCE` (`0F AE F0` / `E8` / `F8`).
fn has_x64_fence(code: &[u8]) -> bool {
    x64_insns(code)
        .iter()
        .any(|i| i.op == 0x0FAE && matches!(i.modrm, Some(0xF0 | 0xE8 | 0xF8)))
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

/// Every aarch64 instruction in a function that orders memory, by kind.
#[derive(Default, PartialEq, Eq, Debug)]
struct A64Ordering {
    /// Widths of the `LDAR{B,H}` instructions, in order.
    ldar: Vec<u8>,
    /// Widths of the RCpc `LDAPR{B,H}` instructions, in order.
    ldapr: Vec<u8>,
    /// Widths of the `STLR{B,H}` instructions, in order.
    stlr: Vec<u8>,
    /// Each LSE read-modify-write or compare-exchange: its width and its
    /// acquire and release bits.
    lse: Vec<(u8, bool, bool)>,
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
        } else if w & 0x3FFF_FC00 == 0x38BF_C000 {
            o.ldapr.push(width);
        } else if w & 0x3F20_0C00 == 0x3820_0000 {
            // LD<op> / SWP: A is bit 23, R bit 22. `LDAPR` shares the
            // class and is told apart above.
            o.lse.push((width, w >> 23 & 1 != 0, w >> 22 & 1 != 0));
        } else if w & 0x3FA0_7C00 == 0x08A0_7C00 {
            // CAS: L, the acquire, is bit 22 and o0, the release, bit 15.
            o.lse.push((width, w >> 22 & 1 != 0, w >> 15 & 1 != 0));
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
            Op::Rmw(width, _) => assert!(
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

/// The aarch64 lowering of every form (ARM's C/C++11 mappings):
/// `Op::Rmw` is one LSE instruction of the object's width whose acquire
/// and release bits are the order's, seq_cst setting both, with no
/// exclusive access; an acquire `Op::Load` is one `LDAPR` of the width, a
/// seq_cst one one `LDAR`, and an `Op::Store` above relaxed one `STLR`,
/// with no other ordering instruction; the seq_cst, release and acq_rel
/// `Op::ThreadFence` are `DMB ISH` and the acquire one `DMB ISHLD`; a
/// relaxed access or fence, a signal fence and `kill_dependency` carry no
/// ordering instruction whatever.
#[test]
fn stdatomic_forms_lower_as_documented_aarch64() {
    let code = function_bytes(Target::LinuxAarch64);
    for form in FORMS {
        let (name, bytes) = lookup(&code, form.name);
        let words = a64_words(bytes);
        let ord = a64_ordering(&words);
        let expect = match form.op {
            Op::Rmw(width, order) => A64Ordering {
                lse: alloc::vec![(width, order.acquires(), order.releases())],
                ..Default::default()
            },
            Op::Load(width, Acquire) => A64Ordering {
                ldapr: alloc::vec![width],
                ..Default::default()
            },
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
    // one, so the `ldapr` is in the code.
    let code = function_bytes_of(
        "#include <stdatomic.h>\n\
         void f_unused(atomic_int *p){ atomic_load_explicit(p, memory_order_acquire); }\n",
        Target::LinuxAarch64,
        true,
    );
    let (_, bytes) = lookup(&code, "f_unused");
    assert_eq!(
        a64_ordering(&a64_words(bytes)).ldapr,
        [4],
        "an unused acquire load is performed: {:08x?}",
        a64_words(bytes)
    );
}

/// What an operator on an `_Atomic` object owes, seq_cst (C11 6.2.6.1p9,
/// 6.5.2.4p2, 6.5.16.2p3): an in-place read-modify-write instruction, or a
/// compare-exchange retried after a load.
#[derive(Clone, Copy, Debug)]
enum OperatorOp {
    Load(u8),
    Store(u8),
    Fetch(u8),
    Retry(u8),
}

const OPERATOR_DECLS: &str = "_Atomic int ai; _Atomic char ac; _Atomic short as; \
    _Atomic long al; _Atomic(int *) ap; _Atomic double ad; _Atomic float af; \
    _Atomic _Bool ab;\n";

const OPERATOR_FORMS: &[(&str, &str, OperatorOp)] = &[
    (
        "f_read",
        "int f_read(void) { return ai; }",
        OperatorOp::Load(4),
    ),
    (
        "f_read_char",
        "int f_read_char(void) { return ac; }",
        OperatorOp::Load(1),
    ),
    (
        "f_assign",
        "void f_assign(int v) { ai = v; }",
        OperatorOp::Store(4),
    ),
    (
        "f_assign_ptr",
        "void f_assign_ptr(int *v) { ap = v; }",
        OperatorOp::Store(8),
    ),
    (
        "f_post_inc",
        "int f_post_inc(void) { return ai++; }",
        OperatorOp::Fetch(4),
    ),
    (
        "f_pre_dec_char",
        "void f_pre_dec_char(void) { --ac; }",
        OperatorOp::Fetch(1),
    ),
    (
        "f_add_short",
        "void f_add_short(short v) { as += v; }",
        OperatorOp::Fetch(2),
    ),
    (
        "f_sub",
        "void f_sub(int v) { ai -= v; }",
        OperatorOp::Fetch(4),
    ),
    (
        "f_or_long",
        "void f_or_long(long v) { al |= v; }",
        OperatorOp::Fetch(8),
    ),
    (
        "f_and",
        "void f_and(int v) { ai &= v; }",
        OperatorOp::Fetch(4),
    ),
    (
        "f_xor",
        "void f_xor(int v) { ai ^= v; }",
        OperatorOp::Fetch(4),
    ),
    (
        "f_ptr_inc",
        "void f_ptr_inc(void) { ap++; }",
        OperatorOp::Fetch(8),
    ),
    (
        "f_mul",
        "void f_mul(void) { ai *= 3; }",
        OperatorOp::Retry(4),
    ),
    (
        "f_div",
        "void f_div(int v) { ai /= v; }",
        OperatorOp::Retry(4),
    ),
    (
        "f_shl",
        "void f_shl(void) { al <<= 1; }",
        OperatorOp::Retry(8),
    ),
    (
        "f_double_add",
        "void f_double_add(void) { ad += 1.5; }",
        OperatorOp::Retry(8),
    ),
    (
        "f_float_sub",
        "void f_float_sub(void) { af -= 1.0f; }",
        OperatorOp::Retry(4),
    ),
    (
        "f_float_inc",
        "void f_float_inc(void) { af++; }",
        OperatorOp::Retry(4),
    ),
    (
        "f_bool_inc",
        "void f_bool_inc(void) { ab++; }",
        OperatorOp::Retry(1),
    ),
    (
        "f_int_add_double",
        "void f_int_add_double(void) { ai += 0.5; }",
        OperatorOp::Retry(4),
    ),
];

fn operator_unit() -> String {
    let mut src = String::from(OPERATOR_DECLS);
    for (_, decl, _) in OPERATOR_FORMS {
        src.push_str(decl);
        src.push('\n');
    }
    src
}

/// x86-64: a load is a plain `MOV`, a store an `XCHG` against memory, and a
/// read-modify-write a `LOCK`-prefixed `XADD` / `AND` / `OR` / `XOR` /
/// `CMPXCHG`, at -O0 and -O.
#[test]
fn atomic_operators_lower_to_atomic_instructions_x86_64() {
    for optimize in [false, true] {
        let code = function_bytes_of(&operator_unit(), Target::LinuxX64, optimize);
        for &(name, _, op) in OPERATOR_FORMS {
            let (name, bytes) = lookup(&code, name);
            let lock = has_lock_rmw(bytes);
            let xchg = xchg_widths(bytes);
            let ok = match op {
                OperatorOp::Load(_) => !lock && xchg.is_empty(),
                OperatorOp::Store(w) => !lock && xchg == [if w == 1 { 1 } else { 8 }],
                OperatorOp::Fetch(_) | OperatorOp::Retry(_) => lock,
            };
            assert!(
                ok,
                "{name} (-O {optimize}): {op:?}, lock={lock} xchg={xchg:?} in {bytes:02x?}"
            );
        }
    }
}

/// aarch64: a load is one `LDAR` and a store one `STLR` of the object's
/// width; an in-place update one LSE instruction with both acquire and
/// release set, and a retried one an `LDAR` and the `CASAL`.
#[test]
fn atomic_operators_lower_to_atomic_instructions_aarch64() {
    for optimize in [false, true] {
        let code = function_bytes_of(&operator_unit(), Target::LinuxAarch64, optimize);
        for &(name, _, op) in OPERATOR_FORMS {
            let (name, bytes) = lookup(&code, name);
            let words = a64_words(bytes);
            let expect = match op {
                OperatorOp::Load(w) => A64Ordering {
                    ldar: alloc::vec![w],
                    ..Default::default()
                },
                OperatorOp::Store(w) => A64Ordering {
                    stlr: alloc::vec![w],
                    ..Default::default()
                },
                OperatorOp::Fetch(w) => A64Ordering {
                    lse: alloc::vec![(w, true, true)],
                    ..Default::default()
                },
                OperatorOp::Retry(w) => A64Ordering {
                    ldar: alloc::vec![w],
                    lse: alloc::vec![(w, true, true)],
                    ..Default::default()
                },
            };
            assert_eq!(
                a64_ordering(&words),
                expect,
                "{name} (-O {optimize}): {words:08x?}"
            );
        }
    }
}

/// A 16-byte integer and a 16-byte structure take the paired
/// compare-exchange for every operator: `LOCK CMPXCHG16B` on x86-64,
/// `CASP` on aarch64.
#[test]
fn atomic_operators_on_sixteen_bytes_take_the_paired_compare_exchange() {
    let src = "struct pair { long a, b; };\n\
               _Atomic __int128 q; _Atomic struct pair s;\n\
               void f_inc(void) { q++; }\n\
               void f_mul(void) { q *= 3; }\n\
               __int128 f_read(void) { return q; }\n\
               void f_assign(__int128 v) { q = v; }\n\
               long f_read_pair(void) { struct pair p = s; return p.b; }\n\
               void f_assign_pair(struct pair p) { s = p; }\n";
    let x64 = function_bytes_of(src, Target::LinuxX64, false);
    let a64 = function_bytes_of(src, Target::LinuxAarch64, false);
    for name in [
        "f_inc",
        "f_mul",
        "f_read",
        "f_assign",
        "f_read_pair",
        "f_assign_pair",
    ] {
        let (_, bytes) = lookup(&x64, name);
        assert!(
            bytes.windows(5).any(|w| w[0] == 0xF0
                && w[1] & 0xF8 == 0x48
                && w[2..4] == [0x0F, 0xC7]
                && (w[4] >> 3) & 7 == 1),
            "{name}: no CMPXCHG16B in {bytes:02x?}"
        );
        let (_, bytes) = lookup(&a64, name);
        assert!(
            a64_words(bytes)
                .iter()
                .any(|w| w & 0xFFA0_7C00 == 0x4820_7C00),
            "{name}: no CASP in {:08x?}",
            a64_words(bytes)
        );
    }
}

/// The layout of an `_Atomic` object of `n` bytes and alignment 1, each row
/// measured with `sizeof` and `_Alignof` under gcc 16 (Linux), Apple clang
/// (macOS) and MSVC 19.4x `/experimental:c11atomics` (Windows, and every
/// freestanding unit).
#[test]
fn atomic_layout_follows_the_system_compiler() {
    use crate::c5::compiler::types::{AtomicAccess, atomic_layout};
    let inline = |n: u8| (n as usize, n as usize, AtomicAccess::Inline(n));
    let lock = |size: usize, at: usize| (size, 4, AtomicAccess::LockWord(at));
    let gcc = [
        (3, (3, 1, AtomicAccess::Library)),
        (5, (5, 1, AtomicAccess::Library)),
        (8, inline(8)),
        (12, (12, 1, AtomicAccess::Library)),
        (16, inline(16)),
        (24, (24, 1, AtomicAccess::Library)),
    ];
    let clang = [
        (3, inline(4)),
        (5, inline(8)),
        (8, inline(8)),
        (12, inline(16)),
        (16, inline(16)),
        (24, (24, 1, AtomicAccess::Library)),
    ];
    let msvc = [
        (1, inline(1)),
        (2, inline(2)),
        (3, lock(8, 4)),
        (4, inline(4)),
        (5, lock(12, 8)),
        (7, lock(12, 8)),
        (8, inline(8)),
        (9, lock(16, 12)),
        (12, lock(16, 12)),
        (15, lock(20, 16)),
        (16, lock(20, 16)),
        (17, lock(24, 20)),
        (24, lock(28, 24)),
    ];
    let check =
        |target: Target, freestanding: bool, rows: &[(usize, (usize, usize, AtomicAccess))]| {
            for &(n, want) in rows {
                let got = atomic_layout(n, 1, target, freestanding);
                assert_eq!(
                    (got.size, got.align, got.access),
                    want,
                    "{target:?} freestanding={freestanding}: {n} bytes"
                );
            }
        };
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check(target, false, &gcc);
    }
    check(Target::MacOSAarch64, false, &clang);
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        check(target, false, &msvc);
    }
    for target in Target::ALL {
        check(target, true, &msvc);
    }
}

/// A freestanding unit spins on its objects' lock words in its own code,
/// so an image needs no runtime function for a large `_Atomic` object;
/// hosted on Linux the same unit calls the generic functions.
#[test]
fn a_freestanding_large_atomic_needs_no_runtime_function() {
    let src = "struct triple { long a, b, c; };\n\
               _Atomic struct triple t;\n\
               struct triple f_get(void) { return t; }\n\
               void f_put(struct triple v) { t = v; }\n";
    let atomic_refs = |target: Target, freestanding: bool| -> Vec<String> {
        let opts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_freestanding(freestanding);
        let program = Compiler::with_options(String::from(src), target, opts)
            .compile()
            .expect("compile");
        let nopts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::default()
        };
        let bytes = emit_native_with_options(&program, target, nopts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse");
        (obj.symbols.iter())
            .filter(|s| s.section == NativeSymSection::Undef && s.name.contains("__atomic_"))
            .map(|s| s.name.clone())
            .collect()
    };
    for target in Target::ALL {
        let refs = atomic_refs(target, true);
        assert!(refs.is_empty(), "{target:?} freestanding: {refs:?}");
    }
    let hosted = atomic_refs(Target::LinuxX64, false);
    assert!(
        hosted.iter().any(|n| n == "__atomic_load") && hosted.iter().any(|n| n == "__atomic_store"),
        "hosted Linux: {hosted:?}"
    );
}

/// Function `name`'s instructions in an `--dump-ssa` text.
fn ssa_body(text: &str, name: &str) -> String {
    let head = alloc::format!("; name={name}\n");
    let start = text.find(&head).expect(name) + head.len();
    let body = &text[start..];
    String::from(body.split("\n; name=").next().unwrap_or(body))
}

/// `atomic_init` (C17 7.17.2.2) copies the value and clears the lock word
/// with plain stores, taking no lock, wherever the object has one:
/// freestanding on every target and hosted on Windows. A compound literal
/// and a parameter start with theirs clear too.
#[test]
fn atomic_init_and_fresh_objects_take_no_lock() {
    let src = "#include <stdatomic.h>\n\
               struct s3 { char c[3]; };\n\
               void f_init(_Atomic struct s3 *p, struct s3 v) { atomic_init(p, v); }\n\
               int f_param(_Atomic struct s3 p) { struct s3 r = p; return r.c[0]; }\n\
               int f_literal(void) { _Atomic struct s3 *p = &(_Atomic struct s3){{1, 2, 3}}; \
                 struct s3 r = *p; return r.c[0]; }\n";
    let cases = (Target::ALL.iter().map(|&t| (t, true)))
        .chain([(Target::WindowsX64, false), (Target::WindowsAarch64, false)]);
    for (target, freestanding) in cases {
        let opts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_freestanding(freestanding);
        let program = Compiler::with_options(String::from(src), target, opts)
            .compile()
            .expect("compile");
        let nopts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::default().with_dump_ssa()
        };
        let text = crate::c5::codegen::lower_for(&program, target, nopts)
            .expect("lower")
            .ssa_dump;
        let body = |name: &str| ssa_body(&text, name);
        let init = body("f_init");
        assert!(
            !init.contains("Atomic") && init.contains("Mcpy") && init.contains("kind=I32"),
            "{target:?} freestanding={freestanding}: {init}"
        );
        for name in ["f_param", "f_literal"] {
            let f = body(name);
            let clear = f.find("kind=I32").expect("a lock word store");
            let acquire = f.find("AtomicRmw").expect("the lock acquired");
            assert!(clear < acquire, "{target:?} {name}: {f}");
        }
    }
}

/// An automatic object with a lock word, alone or in an array, starts with
/// its lock clear: the 4-byte store at offset 4 of a 3-byte structure, and
/// a zero fill over the array.
#[test]
fn automatic_lock_words_start_clear() {
    let src = "struct s3 { char c[3]; };\n\
               int f_one(void) { _Atomic struct s3 a; struct s3 v = {{1, 2, 3}}; a = v; \
                 struct s3 r = a; return r.c[2]; }\n\
               int f_many(void) { _Atomic struct s3 a[3]; struct s3 v = {{1, 2, 3}}; a[2] = v; \
                 struct s3 r = a[2]; return r.c[2]; }\n";
    let opts = CompileOptions::default().with_no_entry_point(true);
    let program = Compiler::with_options(String::from(src), Target::WindowsX64, opts)
        .compile()
        .expect("compile");
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default().with_dump_ssa()
    };
    let text = crate::c5::codegen::lower_for(&program, Target::WindowsX64, nopts)
        .expect("lower")
        .ssa_dump;
    let body = |name: &str| ssa_body(&text, name);
    assert!(
        body("f_one").contains("disp=0, value=") && body("f_one").contains("kind=I32"),
        "{}",
        body("f_one")
    );
    assert!(
        body("f_many").contains("Mzero {") && body("f_many").contains("size=24"),
        "{}",
        body("f_many")
    );
}

/// C11 6.2.7, 6.7.2.1p5, 6.7.3p3, and 6.5.2.3p5, whose undefined member
/// access is refused.
#[test]
fn atomic_constraints_are_diagnosed() {
    let member = "accessing a member of an atomic structure or union";
    for (src, msg) in [
        (
            "_Atomic int ai; int *p = &ai;",
            "incompatible pointer types",
        ),
        ("int i; _Atomic int *p = &i;", "incompatible pointer types"),
        (
            "struct b { _Atomic int f : 3; };",
            "bit-field has atomic type",
        ),
        (
            "typedef int a4[4]; _Atomic a4 x;",
            "`_Atomic` qualifies an array type",
        ),
        (
            "typedef int a4[4]; int f(void) { _Atomic a4 x; return 0; }",
            "`_Atomic` qualifies an array type",
        ),
        (
            "struct t { int x; }; _Atomic struct t v; int f(void) { return v.x; }",
            member,
        ),
        (
            "struct t { int x; }; _Atomic struct t *p; int f(void) { return p->x; }",
            member,
        ),
    ] {
        let opts = CompileOptions::default().with_no_entry_point(true);
        let err = Compiler::with_options(String::from(src), Target::LinuxX64, opts)
            .compile()
            .expect_err(src);
        assert!(err.to_string().contains(msg), "{src}: {err}");
    }
}

/// The operators' values under the interpreter, single-threaded: the
/// prior value of a postfix form, the new one of a prefix form and of a
/// compound assignment, each converted to the object's type.
#[test]
fn atomic_operators_yield_their_values_under_the_interpreter() {
    let src = "struct rgb { unsigned char r, g, b, a; };\n\
               _Atomic int ai = 5; _Atomic unsigned char uc = 250; _Atomic double d = 1.5;\n\
               _Atomic _Bool b; _Atomic struct rgb c;\n\
               int main(void) {\n\
                 if (ai++ != 5 || ++ai != 7 || (ai *= 3) != 21 || (ai -= 1) != 20) return 1;\n\
                 if ((uc += 10) != 4 || uc-- != 4 || uc != 3) return 2;\n\
                 if ((d += 0.25) != 1.75 || d-- != 1.75 || d != 0.75) return 3;\n\
                 if (b++ != 0 || b != 1 || --b != 0 || (b += 2) != 1) return 4;\n\
                 struct rgb w = {1, 2, 3, 4}; c = w; struct rgb r = c;\n\
                 if (r.r != 1 || r.a != 4) return 5;\n\
                 return 0;\n\
               }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    assert_eq!(crate::c5::Vm::new(program).run().expect("run"), 0);
}

/// gcc's generic `__atomic_load` and `__atomic_store` on an object of a
/// size no instruction covers call the runtime's generic functions with
/// the size and the order; Windows, whose runtime has none, refuses them.
#[test]
fn generic_load_and_store_of_an_odd_size_call_the_runtime() {
    use crate::c5::ir::Inst;
    let src = "struct s3 { char c[3]; } x, y;\n\
        void f(void) { __atomic_load(&x, &y, 2); __atomic_store(&x, &y, 3); }\n\
        int main(void) { f(); return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        let program = Compiler::with_target(src.into(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
                .expect("ssa");
        let f = funcs.iter().find(|f| f.name == "f").expect("f");
        let imm = |v: u32| match f.insts[v as usize] {
            Inst::Imm(n) => Some(n),
            _ => None,
        };
        let calls: Vec<(Option<i64>, Option<i64>)> = (f.insts.iter())
            .filter_map(|i| match i {
                Inst::Call { args, .. } if args.len() == 4 => Some((imm(args[0]), imm(args[3]))),
                _ => None,
            })
            .collect();
        assert_eq!(
            calls,
            [(Some(3), Some(2)), (Some(3), Some(3))],
            "{target:?}"
        );
    }
    let err = Compiler::with_target(src.into(), Target::WindowsX64)
        .compile()
        .and_then(|p| {
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&p, Target::WindowsX64, false, true)
                .map(|_| ())
                .map_err(|e| crate::c5::C5Error::Runtime(alloc::format!("{e:?}")))
        });
    assert!(err.is_err(), "Windows has no generic atomic runtime");
}
