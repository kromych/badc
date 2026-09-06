//! What each `<stdatomic.h>` form lowers to, per architecture.
//!
//! The header states which forms are atomic against concurrent access
//! and what ordering each carries. These tests read the emitted bytes of
//! one function per form, on x86-64 and on aarch64, so the statement is
//! checked against the code rather than asserted.

use alloc::string::String;
use alloc::vec::Vec;

use crate::{
    CompileOptions, Compiler, NativeOptions, NativeSymSection, OutputKind, Target,
    emit_native_with_options, parse_native_elf,
};

/// What the emitted function for one form must contain.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Expect {
    /// An atomic read-modify-write of `width` bytes: on x86-64 a
    /// `LOCK`-prefixed `XADD` / `CMPXCHG` or an `XCHG` with a memory
    /// operand, on aarch64 an `LDAXR` / `STLXR` pair of that width.
    Rmw(u8),
    /// A plain access, or no memory access at all: neither an atomic
    /// read-modify-write nor any ordering instruction.
    Plain,
}

struct Form {
    /// Function name, and the source of its body.
    name: &'static str,
    decl: &'static str,
    x64: Expect,
    a64: Expect,
}

/// Every operation `<stdatomic.h>` defines, one function each. The
/// widths follow the pointee type: `atomic_int` is 4 bytes, the
/// `atomic_flag` cell 1.
const FORMS: &[Form] = &[
    Form {
        name: "f_load",
        decl: "int f_load(atomic_int *p){ return atomic_load(p); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_load_explicit",
        decl: "int f_load_explicit(atomic_int *p){ \
               return atomic_load_explicit(p, memory_order_acquire); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_store",
        decl: "void f_store(atomic_int *p){ atomic_store(p, 3); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_store_explicit",
        decl: "void f_store_explicit(atomic_int *p){ \
               atomic_store_explicit(p, 3, memory_order_release); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_init",
        decl: "void f_init(atomic_int *p){ atomic_init(p, 3); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_exchange",
        decl: "int f_exchange(atomic_int *p){ return atomic_exchange(p, 7); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_exchange_explicit",
        decl: "int f_exchange_explicit(atomic_int *p){ \
               return atomic_exchange_explicit(p, 7, memory_order_acq_rel); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_add",
        decl: "int f_fetch_add(atomic_int *p){ return atomic_fetch_add(p, 1); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_add_explicit",
        decl: "int f_fetch_add_explicit(atomic_int *p){ \
               return atomic_fetch_add_explicit(p, 1, memory_order_seq_cst); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_sub",
        decl: "int f_fetch_sub(atomic_int *p){ return atomic_fetch_sub(p, 1); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_sub_explicit",
        decl: "int f_fetch_sub_explicit(atomic_int *p){ \
               return atomic_fetch_sub_explicit(p, 1, memory_order_seq_cst); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_and",
        decl: "int f_fetch_and(atomic_int *p){ return atomic_fetch_and(p, 5); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_and_explicit",
        decl: "int f_fetch_and_explicit(atomic_int *p){ \
               return atomic_fetch_and_explicit(p, 5, memory_order_seq_cst); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_or",
        decl: "int f_fetch_or(atomic_int *p){ return atomic_fetch_or(p, 5); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_or_explicit",
        decl: "int f_fetch_or_explicit(atomic_int *p){ \
               return atomic_fetch_or_explicit(p, 5, memory_order_seq_cst); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_xor",
        decl: "int f_fetch_xor(atomic_int *p){ return atomic_fetch_xor(p, 5); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_fetch_xor_explicit",
        decl: "int f_fetch_xor_explicit(atomic_int *p){ \
               return atomic_fetch_xor_explicit(p, 5, memory_order_seq_cst); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_cas_strong",
        decl: "int f_cas_strong(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong(p, e, 9); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_cas_strong_explicit",
        decl: "int f_cas_strong_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_strong_explicit( \
                   p, e, 9, memory_order_seq_cst, memory_order_relaxed); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_cas_weak",
        decl: "int f_cas_weak(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak(p, e, 9); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_cas_weak_explicit",
        decl: "int f_cas_weak_explicit(atomic_int *p, int *e){ \
               return atomic_compare_exchange_weak_explicit( \
                   p, e, 9, memory_order_seq_cst, memory_order_relaxed); }",
        x64: Expect::Rmw(4),
        a64: Expect::Rmw(4),
    },
    Form {
        name: "f_flag_test_and_set",
        decl: "int f_flag_test_and_set(atomic_flag *f){ return atomic_flag_test_and_set(f); }",
        x64: Expect::Rmw(1),
        a64: Expect::Rmw(1),
    },
    Form {
        name: "f_flag_test_and_set_explicit",
        decl: "int f_flag_test_and_set_explicit(atomic_flag *f){ \
               return atomic_flag_test_and_set_explicit(f, memory_order_acquire); }",
        x64: Expect::Rmw(1),
        a64: Expect::Rmw(1),
    },
    Form {
        name: "f_flag_clear",
        decl: "void f_flag_clear(atomic_flag *f){ atomic_flag_clear(f); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_flag_clear_explicit",
        decl: "void f_flag_clear_explicit(atomic_flag *f){ \
               atomic_flag_clear_explicit(f, memory_order_release); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_thread_fence",
        decl: "void f_thread_fence(void){ atomic_thread_fence(memory_order_seq_cst); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_signal_fence",
        decl: "void f_signal_fence(void){ atomic_signal_fence(memory_order_seq_cst); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
    },
    Form {
        name: "f_kill_dependency",
        decl: "int f_kill_dependency(int y){ return kill_dependency(y); }",
        x64: Expect::Plain,
        a64: Expect::Plain,
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

/// Emit the unit as a relocatable object for `target` and return each
/// function's `.text` bytes, keyed by name. A function runs from its
/// symbol value to the next function's, so inter-function padding is
/// included; padding carries no atomic or ordering encoding.
fn function_bytes(target: Target) -> Vec<(String, Vec<u8>)> {
    let opts = CompileOptions::default().with_no_entry_point(true);
    let program = Compiler::with_options(unit_source(), target, opts)
        .compile()
        .expect("compile the atomics unit");
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
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
    assert_eq!(
        starts.len(),
        FORMS.len(),
        "{target:?}: expected one text symbol per form, got {starts:?}"
    );

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

/// The `size` field (bits 31:30) an exclusive access of `width` bytes
/// carries: 1 -> `B`, 2 -> `H`, 4 -> word, 8 -> doubleword.
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

/// Any aarch64 instruction that orders memory: an exclusive pair of any
/// width, a load-acquire / store-release, or a barrier.
fn has_a64_ordering(words: &[u32]) -> bool {
    words.iter().any(|w| {
        // LDAXR / LDXR and STLXR / STXR of any width: the masks drop the
        // `o0` bit, so both the ordered and the plain exclusive match.
        w & 0x3FFF_7C00 == 0x085F_7C00
            || w & 0x3FE0_7C00 == 0x0800_7C00
            // LDAR / STLR of any width.
            || w & 0x3FFF_FC00 == 0x08DF_FC00
            || w & 0x3FFF_FC00 == 0x089F_FC00
            // DMB / DSB / ISB, any barrier option.
            || w & 0xFFFF_F0FF == 0xD503_30BF
            || w & 0xFFFF_F0FF == 0xD503_309F
            || w & 0xFFFF_F0FF == 0xD503_30DF
    })
}

/// The x86-64 lowering of every `<stdatomic.h>` form. The
/// read-modify-write, compare-exchange and `atomic_flag_test_and_set`
/// forms are atomic against concurrent access -- a `LOCK`-prefixed
/// `XADD` / `CMPXCHG`, or an `XCHG` against memory, which is locked
/// implicitly (Intel SDM Vol.2). `atomic_load`, `atomic_store`,
/// `atomic_init` and `atomic_flag_clear` are a single plain access,
/// indivisible at these widths but carrying no ordering instruction; so
/// are both fences.
#[test]
fn stdatomic_forms_lower_as_documented_x86_64() {
    let code = function_bytes(Target::LinuxX64);
    for form in FORMS {
        let (name, bytes) = lookup(&code, form.name);
        let atomic = has_lock_rmw(bytes)
            || has_xchg_mem(bytes, 1)
            || has_xchg_mem(bytes, 2)
            || has_xchg_mem(bytes, 4)
            || has_xchg_mem(bytes, 8);
        match form.x64 {
            Expect::Rmw(width) => assert!(
                has_lock_rmw(bytes) || has_xchg_mem(bytes, width),
                "{name}: no LOCK XADD / LOCK CMPXCHG and no {width}-byte XCHG against memory \
                 in {bytes:02x?}"
            ),
            Expect::Plain => {
                assert!(
                    !atomic,
                    "{name}: an atomic read-modify-write in {bytes:02x?}"
                );
                assert!(
                    !has_x64_fence(bytes),
                    "{name}: a fence instruction in {bytes:02x?}"
                );
            }
        }
    }
}

/// The aarch64 lowering of every `<stdatomic.h>` form. The
/// read-modify-write, compare-exchange and `atomic_flag_test_and_set`
/// forms are an `LDAXR` / `STLXR` retry loop at the object's width --
/// the acquire / release exclusive pair, which is the seq_cst lowering.
/// `atomic_load`, `atomic_store`, `atomic_init` and `atomic_flag_clear`
/// are a plain `LDR` / `STR`: indivisible at these widths, and with no
/// ordering instruction whatever order the call names. Both fences
/// likewise emit none.
#[test]
fn stdatomic_forms_lower_as_documented_aarch64() {
    let code = function_bytes(Target::LinuxAarch64);
    for form in FORMS {
        let (name, bytes) = lookup(&code, form.name);
        let words = a64_words(bytes);
        match form.a64 {
            Expect::Rmw(width) => {
                let (ldaxr, stlxr) = has_ldaxr_stlxr(&words, width);
                assert!(
                    ldaxr && stlxr,
                    "{name}: no {width}-byte LDAXR / STLXR pair (ldaxr={ldaxr}, stlxr={stlxr}) \
                     in {words:08x?}"
                );
            }
            Expect::Plain => assert!(
                !has_a64_ordering(&words),
                "{name}: an exclusive, acquire / release or barrier instruction in {words:08x?}"
            ),
        }
    }
}
