//! Static initializers, byte for byte. Each case defines an object `x`;
//! the test compiles the unit for linux-x64 and linux-aarch64, reads `x`
//! from the relocatable object, and compares its bytes and the
//! relocations inside it with what clang 21 emits for the same source
//! (`clang --target=<triple> -std=gnu11 -O0 -c`, read with
//! `llvm-objdump -s -r`). Every relocation here is the absolute 64-bit one
//! (`R_X86_64_64`, `R_AARCH64_ABS64`), and a case names where each points.
//! Rejected initializers are checked by their diagnostic. The cases where
//! badc and clang disagree are pinned in their own table with the reason.

use crate::c5::linker::relocatable::{EtRel, EtSymRef, parse_et_rel};
use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};

/// Where a relocation inside `x` points.
#[derive(Clone, Copy, Debug)]
enum To {
    /// An object or function the unit defines, plus a byte offset.
    Sym(&'static str, i64),
    /// A name another unit defines, plus the addend.
    Ext(&'static str, i64),
    /// Unnamed data, such as a literal, starting with these bytes (hex).
    Data(&'static str),
    /// One past unnamed data ending with these bytes (hex).
    After(&'static str),
}
use To::{After, Data, Ext, Sym};

/// An accepted initializer: the bytes of `x` (hex) on linux-x64 and
/// linux-aarch64, and each relocation's offset in `x` and target.
struct Case {
    name: &'static str,
    src: &'static str,
    bytes: [&'static str; 2],
    relocs: &'static [(u64, To)],
}

/// A rejected initializer and a fragment of its diagnostic.
struct Reject {
    name: &'static str,
    src: &'static str,
    needle: &'static str,
}

macro_rules! case {
    ($name:literal, $src:literal, [$x64:literal, $a64:literal] $(, $off:literal => $to:expr)*) => {
        Case { name: $name, src: $src, bytes: [$x64, $a64], relocs: &[$(($off, $to)),*] }
    };
    ($name:literal, $src:literal, $bytes:literal $(, $off:literal => $to:expr)*) => {
        Case { name: $name, src: $src, bytes: [$bytes, $bytes], relocs: &[$(($off, $to)),*] }
    };
}

macro_rules! reject {
    ($name:literal, $src:literal, $needle:literal) => {
        Reject {
            name: $name,
            src: $src,
            needle: $needle,
        }
    };
}

/// The targets, with the type of an absolute 64-bit relocation on each.
const TARGETS: [(Target, u32); 2] = [(Target::LinuxX64, 1), (Target::LinuxAarch64, 257)];

fn object(src: &str, target: Target) -> Result<EtRel, String> {
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), target, copts)
        .compile()
        .map_err(|e| e.to_string())?;
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes =
        crate::c5::emit_native_with_options(&program, target, nopts).map_err(|e| e.to_string())?;
    parse_et_rel(&bytes, "x.o").map_err(|e| e.to_string())
}

/// Whether symbol `name` is the object the source calls `want`; a
/// block-scope static is emitted as `want.N`.
fn names(name: &str, want: &str) -> bool {
    name == want
        || name
            .strip_prefix(want)
            .and_then(|rest| rest.strip_prefix('.'))
            .is_some_and(|n| !n.is_empty() && n.bytes().all(|b| b.is_ascii_digit()))
}

/// Where a relocation resolves: a section of the unit and an offset in it,
/// or a name and an addend.
#[derive(Debug, PartialEq)]
enum Place {
    Local(usize, i64),
    External(String, i64),
}

/// The bytes of `x` and its relocations, as (offset in `x`, type, place).
fn read_x(obj: &EtRel) -> (Vec<u8>, Vec<(u64, u32, Place)>) {
    let x = obj
        .symbols
        .iter()
        .find(|s| names(&s.name, "x") && matches!(s.sec, EtSymRef::Section(_)))
        .expect("no object `x`");
    let EtSymRef::Section(si) = x.sec else {
        unreachable!()
    };
    let sec = &obj.sections[si];
    let range = x.value..x.value + x.size;
    let bytes = if sec.bytes.is_empty() {
        alloc::vec![0; x.size as usize]
    } else {
        sec.bytes[range.start as usize..range.end as usize].to_vec()
    };
    let mut relocs: Vec<_> = sec
        .relocs
        .iter()
        .filter(|r| range.contains(&r.offset))
        .map(|r| {
            let s = &obj.symbols[r.sym as usize];
            let place = match s.sec {
                EtSymRef::Section(t) => Place::Local(t, s.value as i64 + r.addend),
                _ => Place::External(s.name.clone(), r.addend),
            };
            (r.offset - x.value, r.rtype, place)
        })
        .collect();
    relocs.sort_by_key(|r| r.0);
    (bytes, relocs)
}

fn hex(bytes: &[u8]) -> String {
    bytes.iter().map(|b| alloc::format!("{b:02x}")).collect()
}

/// Whether `place` is where `to` points.
fn points_at(obj: &EtRel, place: &Place, to: To) -> bool {
    match (to, place) {
        (Sym(name, off), Place::Local(sec, at)) => obj.symbols.iter().any(|s| {
            names(&s.name, name) && s.sec == EtSymRef::Section(*sec) && s.value as i64 + off == *at
        }),
        (Ext(name, add), Place::External(n, a)) => name == n && add == *a,
        (Data(want), Place::Local(sec, at)) => {
            let bytes = &obj.sections[*sec].bytes;
            let at = *at as usize;
            at <= bytes.len() && hex(&bytes[at..]).starts_with(want)
        }
        (After(want), Place::Local(sec, at)) => {
            let bytes = &obj.sections[*sec].bytes;
            let (at, n) = (*at as usize, want.len() / 2);
            at >= n && at <= bytes.len() && hex(&bytes[at - n..at]) == want
        }
        _ => false,
    }
}

/// Check one accepted case on one target.
fn check(case: &Case, which: usize) {
    let (target, rtype) = TARGETS[which];
    let at = alloc::format!("{} [{target:?}]: {}", case.name, case.src);
    let obj = object(case.src, target).unwrap_or_else(|e| panic!("{at}\n{e}"));
    let (bytes, relocs) = read_x(&obj);
    assert_eq!(hex(&bytes), case.bytes[which], "{at}\nbytes of `x`");
    assert_eq!(
        relocs.len(),
        case.relocs.len(),
        "{at}\nrelocations: {relocs:?}"
    );
    for ((off, ty, place), &(want_off, to)) in relocs.iter().zip(case.relocs) {
        assert_eq!((*off, *ty), (want_off, rtype), "{at}\nrelocation {place:?}");
        assert!(
            points_at(&obj, place, to),
            "{at}\nrelocation at {off}: {place:?}, expected {to:?}"
        );
    }
}

fn check_table(cases: &[Case]) {
    for case in cases {
        for which in 0..TARGETS.len() {
            check(case, which);
        }
    }
}

fn check_rejections(cases: &[Reject]) {
    for case in cases {
        for (target, _) in TARGETS {
            match object(case.src, target) {
                Ok(_) => panic!("{} [{target:?}]: {} compiled", case.name, case.src),
                Err(e) => assert!(
                    e.contains(case.needle),
                    "{} [{target:?}]: {}\nexpected {:?} in\n{e}",
                    case.name,
                    case.src,
                    case.needle
                ),
            }
        }
    }
}

/// Address constants (C99 6.6p9): objects, elements, members, functions,
/// compound literals and external names, through casts and pointer
/// arithmetic, at file and block scope, and an address converted to `_Bool`.
#[rustfmt::skip]
const ADDRESSES: &[Case] = &[
    case!("object", "int y; int *x = &y;", "0000000000000000", 0 => Sym("y", 0)),
    case!("element", "int y[4]; int *x = &y[2];", "0000000000000000", 0 => Sym("y", 8)),
    case!("decay_plus", "int y[4]; int *x = y + 3;", "0000000000000000", 0 => Sym("y", 12)),
    case!("one_past", "int y[4]; int z; int *x = &y[4];", "0000000000000000", 0 => Sym("y", 16)),
    case!("element_minus", "int y[4]; int *x = &y[3] - 2;", "0000000000000000", 0 => Sym("y", 4)),
    case!("member", "struct S { char c; int f; long g; } s; int *x = &s.f;", "0000000000000000", 0 => Sym("s", 4)),
    case!("member_long", "struct S { char c; int f; long g; } s; long *x = &s.g;", "0000000000000000", 0 => Sym("s", 8)),
    case!("char_cast_plus", "int y; char *x = (char *)&y + 3;", "0000000000000000", 0 => Sym("y", 3)),
    case!("element_2d", "int y[2][3]; int *x = &y[1][2];", "0000000000000000", 0 => Sym("y", 20)),
    case!("row_2d", "int y[2][3]; int (*x)[3] = &y[1];", "0000000000000000", 0 => Sym("y", 12)),
    case!("element_member", "struct S { int a; int b; } v[3]; int *x = &v[2].b;", "0000000000000000", 0 => Sym("v", 20)),
    case!("static_object", "static int y; void *x = &y;", "0000000000000000", 0 => Sym("y", 0)),
    case!("function_declared", "int f(void); int (*x)(void) = f;", "0000000000000000", 0 => Ext("f", 0)),
    case!("function_defined", "int f(void) { return 0; } int (*x)(void) = &f;", "0000000000000000", 0 => Sym("f", 0)),
    case!("compound_literal", "int *x = (int[]){7, 8, 9};", "0000000000000000", 0 => Data("070000000800000009000000")),
    case!("compound_literal_element", "int *x = &(int[]){7, 8, 9}[1];", "0000000000000000", 0 => Data("0800000009000000")),
    case!("extern_element", "extern int e[]; int *x = &e[3];", "0000000000000000", 0 => Ext("e", 12)),
    case!("extern_object_plus", "extern int e; int *x = &e + 1;", "0000000000000000", 0 => Ext("e", 4)),
    case!("pointer_array", "int a, b; int *x[3] = {&a, 0, &b};", "000000000000000000000000000000000000000000000000", 0 => Sym("a", 0), 16 => Sym("b", 0)),
    case!("struct_member_pointer", "int a; struct T { int n; int *p; } x = {5, &a};", "05000000000000000000000000000000", 8 => Sym("a", 0)),
    case!("integer_cast", "int y; unsigned long x = (unsigned long)&y;", "0000000000000000", 0 => Sym("y", 0)),
    case!("integer_cast_plus", "int g; struct { int a; unsigned long p; } x = {1, (unsigned long)&g + 4};", "01000000000000000000000000000000", 8 => Sym("g", 4)),
    case!("null", "int *x = 0;", "0000000000000000"),
    case!("integer_to_pointer", "int *x = (int *)16;", "1000000000000000"),
    case!("block_static", "int g(void) { static int y; static int *x = &y; return *x; }", "0000000000000000", 0 => Sym("y", 0)),
    case!("block_static_to_file", "int gv[4]; int g(void) { static int *x = &gv[1]; return *x; }", "0000000000000000", 0 => Sym("gv", 4)),
    case!("const_pointer", "int y[4]; int *const x = &y[1];", "0000000000000000", 0 => Sym("y", 4)),
    case!("array_address_plus", "int y[4]; int (*x)[4] = &y + 1;", "0000000000000000", 0 => Sym("y", 16)),
    case!("row_address_plus", "int y[3][4]; int (*x)[4] = &y[1] + 1;", "0000000000000000", 0 => Sym("y", 32)),
    case!("array_2d_address_plus", "int y[3][4]; int (*x)[3][4] = &y + 1;", "0000000000000000", 0 => Sym("y", 48)),
    case!("member_array_address_plus", "struct T { int n; int a[4]; } g; int (*x)[4] = &g.a + 1;", "0000000000000000", 0 => Sym("g", 20)),
    case!("member_array_decay_plus", "struct T { int n; int a[4]; } g; int *x = g.a + 3;", "0000000000000000", 0 => Sym("g", 16)),
    case!("row_decay_plus", "int y[3][4]; int (*x)[4] = y + 2;", "0000000000000000", 0 => Sym("y", 32)),
    case!("cast_row_decay_plus", "int m[3][4]; char *x = (char *)(m + 1);", "0000000000000000", 0 => Sym("m", 16)),
    case!("member_through_cast", "struct A { int pad; int b; } a; struct B { long q; int b; }; int *x = &((struct B *)&a)->b;", "0000000000000000", 0 => Sym("a", 8)),
    case!("element_through_cast", "long g[4]; int *x = &((int *)g)[3];", "0000000000000000", 0 => Sym("g", 12)),
    case!("outer_cast_sets_stride", "long g[4]; char *x = (char *)(long *)&g[1] + 2;", "0000000000000000", 0 => Sym("g", 10)),
    case!("cast_then_element", "long g[4]; int *x = (int *)&g[1] + 1;", "0000000000000000", 0 => Sym("g", 12)),
    case!("cast_of_cast_plus", "long g[4]; int *x = (int *)(char *)&g[1] + 1;", "0000000000000000", 0 => Sym("g", 12)),
    case!("array_member_through_arrow", "struct slot { int tag; unsigned char buf[4]; } table[2]; unsigned char *x = (&table[1])->buf;", "0000000000000000", 0 => Sym("table", 12)),
    case!("array_member_through_arrow_plus", "struct slot { int tag; unsigned char buf[4]; } table[2]; unsigned char *x = (&table[1])->buf + 2;", "0000000000000000", 0 => Sym("table", 14)),
    case!("parenthesized_sum_element", "int y[4]; int *x = &(y + 1)[2];", "0000000000000000", 0 => Sym("y", 12)),
    case!("self_address", "void *x = &x;", "0000000000000000", 0 => Sym("x", 0)),
    case!("conditional_address", "int a, b; int *x = 1 ? &a : &b;", "0000000000000000", 0 => Sym("a", 0)),
    case!("address_through_integer", "int y; int *x = (int *)(unsigned long)&y;", "0000000000000000", 0 => Sym("y", 0)),
    case!("nested_compound_literal", "struct CL { int *p; } x = {(int[]){1, 2}};", "0000000000000000", 0 => Data("0100000002000000")),
    case!("pointer_difference_one_object", "int y[10]; long x = &y[7] - &y[2];", "0500000000000000"),
    case!("offsetof_member", "struct O { char c; int i; }; unsigned long x = (unsigned long)&((struct O *)0)->i;", "0400000000000000"),
    case!("offsetof_2d_member", "struct S { int n; int m[2][3]; }; unsigned long x = (unsigned long)&((struct S *)0)->m[1][2];", "1800000000000000"),
    case!("offsetof_past_member_array", "struct S { int n; int m[4]; }; unsigned long x = (unsigned long)(&((struct S *)0)->m + 1);", "1400000000000000"),
    case!("offsetof_difference", "struct T { char c; int i; }; long x = (char *)&((struct T *)0)->i - (char *)0;", "0400000000000000"),
    case!("function_pointer_array", "int f(void); int g(void); int (*x[3])(void) = {f, 0, g};", "000000000000000000000000000000000000000000000000", 0 => Ext("f", 0), 16 => Ext("g", 0)),
    case!("address_to_bool", "int g; _Bool x = &g;", "01"),
    case!("string_to_bool", "_Bool x = \"abc\";", "01"),
    case!("function_to_bool", "int f(void); _Bool x = f;", "01"),
    case!("bool_elements", "int g; _Bool x[2] = {&g, 0};", "0100"),
    case!("bool_member", "int g; struct { int a; _Bool b; } x = {1, &g};", "0100000001000000"),
    case!("bool_cast_in_int", "int g; int x = (_Bool)&g;", "01000000"),
];

/// String literals (C99 6.4.5p5): the address of the unnamed array, by
/// prefix, through casts and arithmetic, and reads of its elements.
#[rustfmt::skip]
const STRINGS: &[Case] = &[
    case!("pointer", "const char *x = \"hello\";", "0000000000000000", 0 => Data("68656c6c6f00")),
    case!("plus", "const char *x = \"hello\" + 1;", "0000000000000000", 0 => Data("656c6c6f00")),
    case!("plus_reversed", "const char *x = 1 + \"hello\";", "0000000000000000", 0 => Data("656c6c6f00")),
    case!("one_past", "const char *x = \"hello\" + 5;", "0000000000000000", 0 => Data("00")),
    case!("cast_plus", "const char *x = (const char *)\"hello\" + 1;", "0000000000000000", 0 => Data("656c6c6f00")),
    case!("minus_zero", "const char *x = \"hello\" - 0;", "0000000000000000", 0 => Data("68656c6c6f00")),
    case!("element_address", "const char *x = &\"hello\"[1];", "0000000000000000", 0 => Data("656c6c6f00")),
    case!("element_address_swapped", "const char *x = &1[\"hello\"];", "0000000000000000", 0 => Data("656c6c6f00")),
    case!("array_address", "const char (*x)[6] = &\"hello\";", "0000000000000000", 0 => Data("68656c6c6f00")),
    case!("array_address_plus", "const char (*x)[4] = &\"abc\" + 1;", "0000000000000000", 0 => After("61626300")),
    case!("pointer_to_array_cast_plus", "const char (*x)[4] = (const char (*)[4])\"abcdefgh\" + 1;", "0000000000000000", 0 => Data("6566676800")),
    case!("cast_to_int_pointer_plus", "const int *x = (const int *)\"abcdefgh\" + 1;", "0000000000000000", 0 => Data("6566676800")),
    case!("deref_address", "const char *x = &*\"abc\";", "0000000000000000", 0 => Data("61626300")),
    case!("deref_sum_address", "const char *x = &*(\"abc\" + 1);", "0000000000000000", 0 => Data("626300")),
    case!("in_struct", "struct { int n; const char *s; } x = {3, \"hello\" + 2};", "03000000000000000000000000000000", 8 => Data("6c6c6f00")),
    case!("in_array", "const char *x[] = {\"ab\" + 1, \"cd\"};", "00000000000000000000000000000000", 0 => Data("6200"), 8 => Data("636400")),
    case!("in_array_with_null", "const char *x[3] = {\"ab\" + 1, 0, \"cd\" + 2};", "000000000000000000000000000000000000000000000000", 0 => Data("6200"), 16 => Data("00")),
    case!("conditional", "const char *x = 1 ? \"a\" + 1 : 0;", "0000000000000000", 0 => Data("00")),
    case!("concatenated_in_array", "const char *x[2] = {\"a\" \"b\", \"c\" + 1};", "00000000000000000000000000000000", 0 => Data("616200"), 8 => Data("00")),
    case!("paren", "const char *x = (\"abc\");", "0000000000000000", 0 => Data("61626300")),
    case!("paren_plus", "const char *x = ((\"abc\") + 1);", "0000000000000000", 0 => Data("626300")),
    case!("u8_plus", "const char *x = u8\"abc\" + 2;", "0000000000000000", 0 => Data("6300")),
    case!("wide_pointer", "typedef __WCHAR_TYPE__ wchar_t; const wchar_t *x = L\"ab\";", "0000000000000000", 0 => Data("610000006200000000000000")),
    case!("wide_plus", "typedef __WCHAR_TYPE__ wchar_t; const wchar_t *x = L\"ab\" + 1;", "0000000000000000", 0 => Data("6200000000000000")),
    case!("wide_element_address", "typedef __WCHAR_TYPE__ wchar_t; const wchar_t *x = &L\"abc\"[2];", "0000000000000000", 0 => Data("6300000000000000")),
    case!("u16_plus", "const unsigned short *x = u\"abc\" + 2;", "0000000000000000", 0 => Data("63000000")),
    case!("u32_plus", "const unsigned int *x = U\"abc\" + 2;", "0000000000000000", 0 => Data("6300000000000000")),
    case!("block_static_plus", "const char *f(void) { static const char *x = \"abc\" + 1; return x; }", "0000000000000000", 0 => Data("626300")),
    case!("block_static_element_address", "const char *f(void) { static const char *x = &\"abc\"[1]; return x; }", "0000000000000000", 0 => Data("626300")),
    case!("block_static_wide_plus", "typedef __WCHAR_TYPE__ wchar_t; const wchar_t *f(void) { static const wchar_t *x = L\"ab\" + 1; return x; }", "0000000000000000", 0 => Data("6200000000000000")),
    case!("element", "int x = \"\\xff\"[0];", ["ffffffff", "ff000000"]),
    case!("element_expression", "int x = \"abcdef\"[1 + 2] * 2;", "c8000000"),
    case!("element_paren", "int x = (\"abc\")[1];", "62000000"),
    case!("element_swapped", "int x = 1[\"abc\"];", "62000000"),
    case!("element_deref", "int x = *\"abc\";", "61000000"),
    case!("element_deref_sum", "int x = *(\"abc\" + 1);", "62000000"),
    case!("element_of_sum", "int x = (\"abc\" + 1)[1];", "63000000"),
    case!("element_through_same_type_cast", "int x = ((const char *)\"abc\")[1];", "62000000"),
    case!("elements_in_array", "int x[2] = {\"ab\"[0], \"ab\"[1]};", "6100000062000000"),
    case!("wide_element", "int x = L\"ab\"[1];", "62000000"),
    case!("u16_element", "int x = u\"\\x8000\"[0];", "00800000"),
    case!("u32_element", "int x = U\"\\xffffffff\"[0];", "ffffffff"),
    case!("wide_element_high", "int x = L\"\\x80\"[0];", "80000000"),
    case!("char_array", "char x[] = \"abc\";", "61626300"),
    case!("char_array_paren", "char x[] = (\"abc\");", "61626300"),
    case!("char_array_braced", "char x[] = {\"abc\"};", "61626300"),
    case!("char_array_2d", "char x[2][4] = {\"ab\", \"cd\"};", "6162000063640000"),
    case!("wide_array", "typedef __WCHAR_TYPE__ wchar_t; wchar_t x[4] = L\"ab\";", "61000000620000000000000000000000"),
    case!("u16_array", "unsigned short x[3] = u\"ab\";", "610062000000"),
    case!("u32_array", "unsigned int x[3] = U\"ab\";", "610000006200000000000000"),
    case!("u8_array", "char x[] = u8\"\\u00e9\";", "c3a900"),
    case!("signed_char_array", "signed char x[] = \"\\x80\\x7f\";", "807f00"),
];

/// Values read from `const` objects at file and block scope, at every
/// width and signedness, floating, converted, through pointers and
/// bit-fields, and converted constants.
#[rustfmt::skip]
const VALUES: &[Case] = &[
    case!("char_element", "static const char a[] = {100, -2}; char x = a[1];", "fe"),
    case!("char_member", "static const struct { char p; char q; } s = {100, -2}; char x = s.q;", "fe"),
    case!("char_block_scope", "int g(void) { static const char a[] = {100, -2}; static char x = a[1]; return (int)x; }", "fe"),
    case!("signed_char_element", "static const signed char a[] = {100, -2}; signed char x = a[1];", "fe"),
    case!("signed_char_member", "static const struct { signed char p; signed char q; } s = {100, -2}; signed char x = s.q;", "fe"),
    case!("signed_char_block_scope", "int g(void) { static const signed char a[] = {100, -2}; static signed char x = a[1]; return (int)x; }", "fe"),
    case!("unsigned_char_element", "static const unsigned char a[] = {7, 200}; unsigned char x = a[1];", "c8"),
    case!("unsigned_char_member", "static const struct { unsigned char p; unsigned char q; } s = {7, 200}; unsigned char x = s.q;", "c8"),
    case!("unsigned_char_block_scope", "int g(void) { static const unsigned char a[] = {7, 200}; static unsigned char x = a[1]; return (int)x; }", "c8"),
    case!("short_element", "static const short a[] = {300, -3}; short x = a[1];", "fdff"),
    case!("short_member", "static const struct { short p; short q; } s = {300, -3}; short x = s.q;", "fdff"),
    case!("short_block_scope", "int g(void) { static const short a[] = {300, -3}; static short x = a[1]; return (int)x; }", "fdff"),
    case!("unsigned_short_element", "static const unsigned short a[] = {5, 60000}; unsigned short x = a[1];", "60ea"),
    case!("unsigned_short_member", "static const struct { unsigned short p; unsigned short q; } s = {5, 60000}; unsigned short x = s.q;", "60ea"),
    case!("unsigned_short_block_scope", "int g(void) { static const unsigned short a[] = {5, 60000}; static unsigned short x = a[1]; return (int)x; }", "60ea"),
    case!("int_element", "static const int a[] = {70000, -4}; int x = a[1];", "fcffffff"),
    case!("int_member", "static const struct { int p; int q; } s = {70000, -4}; int x = s.q;", "fcffffff"),
    case!("int_block_scope", "int g(void) { static const int a[] = {70000, -4}; static int x = a[1]; return (int)x; }", "fcffffff"),
    case!("unsigned_element", "static const unsigned a[] = {9, 4000000000u}; unsigned x = a[1];", "00286bee"),
    case!("unsigned_member", "static const struct { unsigned p; unsigned q; } s = {9, 4000000000u}; unsigned x = s.q;", "00286bee"),
    case!("unsigned_block_scope", "int g(void) { static const unsigned a[] = {9, 4000000000u}; static unsigned x = a[1]; return (int)x; }", "00286bee"),
    case!("long_element", "static const long a[] = {0x123456789a, -5}; long x = a[1];", "fbffffffffffffff"),
    case!("long_member", "static const struct { long p; long q; } s = {0x123456789a, -5}; long x = s.q;", "fbffffffffffffff"),
    case!("long_block_scope", "int g(void) { static const long a[] = {0x123456789a, -5}; static long x = a[1]; return (int)x; }", "fbffffffffffffff"),
    case!("unsigned_long_element", "static const unsigned long a[] = {11, 0xfedcba9876543210ul}; unsigned long x = a[1];", "1032547698badcfe"),
    case!("unsigned_long_member", "static const struct { unsigned long p; unsigned long q; } s = {11, 0xfedcba9876543210ul}; unsigned long x = s.q;", "1032547698badcfe"),
    case!("unsigned_long_block_scope", "int g(void) { static const unsigned long a[] = {11, 0xfedcba9876543210ul}; static unsigned long x = a[1]; return (int)x; }", "1032547698badcfe"),
    case!("long_long_element", "static const long long a[] = {0x7fffffffffffffffll, -6}; long long x = a[1];", "faffffffffffffff"),
    case!("long_long_member", "static const struct { long long p; long long q; } s = {0x7fffffffffffffffll, -6}; long long x = s.q;", "faffffffffffffff"),
    case!("long_long_block_scope", "int g(void) { static const long long a[] = {0x7fffffffffffffffll, -6}; static long long x = a[1]; return (int)x; }", "faffffffffffffff"),
    case!("unsigned_long_long_element", "static const unsigned long long a[] = {12, 0xffffffffffffffffull}; unsigned long long x = a[1];", "ffffffffffffffff"),
    case!("unsigned_long_long_member", "static const struct { unsigned long long p; unsigned long long q; } s = {12, 0xffffffffffffffffull}; unsigned long long x = s.q;", "ffffffffffffffff"),
    case!("unsigned_long_long_block_scope", "int g(void) { static const unsigned long long a[] = {12, 0xffffffffffffffffull}; static unsigned long long x = a[1]; return (int)x; }", "ffffffffffffffff"),
    case!("Bool_element", "static const _Bool a[] = {0, 1}; _Bool x = a[1];", "01"),
    case!("Bool_member", "static const struct { _Bool p; _Bool q; } s = {0, 1}; _Bool x = s.q;", "01"),
    case!("Bool_block_scope", "int g(void) { static const _Bool a[] = {0, 1}; static _Bool x = a[1]; return (int)x; }", "01"),
    case!("float_element", "static const float a[] = {3.25f, -1.5f}; float x = a[1];", "0000c0bf"),
    case!("float_member", "static const struct { float p; float q; } s = {3.25f, -1.5f}; float x = s.q;", "0000c0bf"),
    case!("float_block_scope", "int g(void) { static const float a[] = {3.25f, -1.5f}; static float x = a[1]; return (int)x; }", "0000c0bf"),
    case!("double_element", "static const double a[] = {1e300, -2.5}; double x = a[1];", "00000000000004c0"),
    case!("double_member", "static const struct { double p; double q; } s = {1e300, -2.5}; double x = s.q;", "00000000000004c0"),
    case!("double_block_scope", "int g(void) { static const double a[] = {1e300, -2.5}; static double x = a[1]; return (int)x; }", "00000000000004c0"),
    case!("char_to_int", "static const char a[] = {-1}; int x = a[0];", ["ffffffff", "ff000000"]),
    case!("signed_char_to_unsigned", "static const signed char a[] = {-1}; unsigned x = a[0];", "ffffffff"),
    case!("unsigned_char_to_int", "static const unsigned char a[] = {0xff}; int x = a[0];", "ff000000"),
    case!("unsigned_short_to_long", "static const unsigned short a[] = {0xffff}; long x = a[0];", "ffff000000000000"),
    case!("int_to_signed_char", "static const int a[] = {0x1ff}; signed char x = a[0];", "ff"),
    case!("double_to_int", "static const double a[] = {-7.75}; int x = a[0];", "f9ffffff"),
    case!("int_to_double", "static const int a[] = {-3}; double x = a[0];", "00000000000008c0"),
    case!("double_to_float", "static const double a[] = {0.1}; float x = a[0];", "cdcccc3d"),
    case!("float_to_double", "static const float a[] = {0.1f}; double x = a[0];", "000000a09999b93f"),
    case!("unsigned_long_long_to_float", "static const unsigned long long a[] = {0xffffffffffffffffull}; float x = a[0];", "0000805f"),
    case!("unsigned_long_long_to_double", "static const unsigned long long a[] = {0x8000000000000001ull}; double x = a[0];", "000000000000e043"),
    case!("double_to_bool", "static const double a[] = {0.5}; _Bool x = a[0];", "01"),
    case!("element_2d", "static const int a[2][3] = {{1, 2, 3}, {4, 5, 6}}; int x = a[1][2];", "06000000"),
    case!("nested_member", "static const struct { int k; struct { short p; short q[3]; } in; } s = {1, {2, {3, 4, 5}}}; short x = s.in.q[2];", "0500"),
    case!("string_array_element", "static const char a[] = \"hello\"; char x = a[4];", "6f"),
    case!("scalar", "static const int a = 42; int x = a;", "2a000000"),
    case!("in_array_initializer", "static const int a[] = {5, 6}; int x[3] = {a[1], a[0], a[1] + a[0]};", "06000000050000000b000000"),
    case!("in_expression", "static const int a[] = {5, 6}; int x = a[0] * 10 + a[1];", "38000000"),
    case!("literal_unsigned_long_long_to_float", "float x = 0xffffffffffffffffull;", "0000805f"),
    case!("literal_unsigned_long_long_to_double", "double x = 0x8000000000000001ull;", "000000000000e043"),
    case!("cast_unsigned_long_long_to_float", "float x = (float)0xfffffffffffffff0ull;", "0000805f"),
    case!("unsigned_to_double", "double x = 4294967295u;", "0000e0ffffffef41"),
    case!("floats_from_integers", "float x[3] = {1, -2, 16777217};", "0000803f000000c00000804b"),
    case!("integers_from_floats", "int x[3] = {1.9, -1.9, 1e3};", "01000000ffffffffe8030000"),
    case!("unsigned_char_wrap", "unsigned char x[2] = {-1, 256 + 7};", "ff07"),
    case!("bool_array", "_Bool x[4] = {0, 1, 2, -1};", "00010101"),
    case!("enum_array", "enum E { A = -1, B = 300 } x[2] = {A, B};", "ffffffff2c010000"),
    case!("sizeof", "struct O { char c; double d; }; unsigned long x = sizeof(struct O);", "1000000000000000"),
    case!("long_double", "long double x = 1.5L;", ["00000000000000c0ff3f000000000000", "0000000000000000000000000080ff3f"]),
    case!("long_double_array", "long double x[2] = {-2.0L, 0.25L};", ["000000000000008000c00000000000000000000000000080fd3f000000000000", "000000000000000000000000000000c00000000000000000000000000000fd3f"]),
    case!("pointer_member", "static int g; static const struct { int *p; } s = {&g}; int *x = s.p;", "0000000000000000", 0 => Sym("g", 0)),
    case!("relocated_integer_member", "static int g; static const struct { long v; } s = {(long)&g}; long x = s.v;", "0000000000000000", 0 => Sym("g", 0)),
    case!("pointer_object", "static int g; static int *const p = &g; int *x = p;", "0000000000000000", 0 => Sym("g", 0)),
    case!("pointer_object_as_integer", "static int g; static int *const p = &g; long x = (long)p;", "0000000000000000", 0 => Sym("g", 0)),
    case!("relocated_integer_object", "static int g; static const long v = (long)&g; long x = v;", "0000000000000000", 0 => Sym("g", 0)),
    case!("function_pointer_object", "int f(void); static int (*const p)(void) = f; int (*x)(void) = p;", "0000000000000000", 0 => Ext("f", 0)),
    case!("bit_field_member", "static const struct { int a : 3; } s = {2}; int x = s.a;", "02000000"),
    case!("bit_field_signed", "static const struct { unsigned u : 7; int s : 5; } b = {100, -3}; int x = b.s;", "fdffffff"),
    case!("bit_field_bool", "static const struct { _Bool f : 1; } b = {1}; int x = b.f;", "01000000"),
    case!("bit_field_wide", "static const struct { unsigned long long w : 40; } b = {0xabcdef0123ull}; unsigned long long x = b.w;", "2301efcdab000000"),
    case!("thread_local_value", "_Thread_local int x = 5;", "05000000"),
    case!("thread_local_address", "int g; _Thread_local int *x = &g;", "0000000000000000", 0 => Sym("g", 0)),
];

/// Aggregate shapes: designators, nesting, partial and elided braces,
/// unions, a flexible array member, strings in arrays and padding.
#[rustfmt::skip]
const AGGREGATES: &[Case] = &[
    case!("designated_array", "int x[5] = {[3] = 7, [1] = 2};", "0000000002000000000000000700000000000000"),
    case!("designated_struct", "struct P { int a; char b; short c; } x = {.c = 3, .a = 1};", "0100000000000300"),
    case!("designator_override", "int x[3] = {1, 2, 3, [0] = 9};", "090000000200000003000000"),
    case!("range_designator", "int x[6] = {[1 ... 3] = 5, [5] = 1};", "000000000500000005000000050000000000000001000000"),
    case!("size_from_designator", "int x[] = {[5] = 1};", "000000000000000000000000000000000000000001000000"),
    case!("nested", "struct Q { int a[2]; struct { char c; int d; } in; } x = {{1}, {2, 3}};", "01000000000000000200000003000000"),
    case!("nested_designators", "struct M { struct { int a, b; } in[2]; } x = {.in[1].b = 6, .in[0].a = 5};", "05000000000000000000000006000000"),
    case!("array_of_struct_designated", "struct D { int a; short b; } x[3] = {[2] = {.b = 7}, [0].a = 1};", "010000000000000000000000000000000000000007000000"),
    case!("partial", "int x[4] = {1, 2};", "01000000020000000000000000000000"),
    case!("brace_elision", "int x[2][2] = {1, 2, 3};", "01000000020000000300000000000000"),
    case!("struct_array", "struct R { char c; short s; } x[2] = {{1, 2}, {3, 4}};", "0100020003000400"),
    case!("union_member", "union U { char c; int i; double d; } x = {.i = 0x01020304};", "0403020100000000"),
    case!("union_first", "union U { char c; int i; double d; } x = {5};", "0500000000000000"),
    case!("union_double", "union U { char c; int i; double d; } x = {.d = 2.0};", "0000000000000040"),
    case!("union_in_struct", "struct W { int k; union { short s; int i; } u; char t; } x = {1, {.i = -1}, 2};", "01000000ffffffff02000000"),
    case!("flexible_array_member", "struct F { int n; int d[]; } x = {2, {7, 8}};", "020000000700000008000000"),
    case!("string_exact_fit", "char x[5] = \"hello\";", "68656c6c6f"),
    case!("string_short", "char x[8] = \"hi\";", "6869000000000000"),
    case!("string_unsized", "char x[] = \"abc\";", "61626300"),
    case!("string_in_struct", "struct N { char s[4]; int v; } x = {\"ab\", 9};", "6162000009000000"),
    case!("padding", "struct Pd { char c; double d; short s; } x = {1, 2.0, 3};", "010000000000000000000000000000400300000000000000"),
    case!("compound_literal_value", "struct V { int a, b; } x = (struct V){4, 5};", "0400000005000000"),
    case!("zero", "struct Z { int a; char b[3]; } x = {0};", "0000000000000000"),
    case!("empty_braces", "int x[3] = {};", "000000000000000000000000"),
    case!("aligned_member", "struct Al { char c; _Alignas(16) int i; } x = {1, 2};", "0100000000000000000000000000000002000000000000000000000000000000"),
];

/// Packed layouts and bit-fields.
#[rustfmt::skip]
const PACKED_AND_BITS: &[Case] = &[
    case!("packed_attribute", "struct __attribute__((packed)) Pk { char c; int i; short s; } x = {1, 0x02030405, 6};", "01050403020600"),
    case!("pragma_pack_1", "#pragma pack(1)\nstruct Pk { char c; long l; } x = {1, 0x0102030405060708};\n#pragma pack()", "010807060504030201"),
    case!("pragma_pack_2", "#pragma pack(2)\nstruct Pk { char c; int i; char d; } x = {1, 0x0a0b0c0d, 2};\n#pragma pack()", "01000d0c0b0a0200"),
    case!("aligned_attribute_member", "struct Am { char c; int i __attribute__((aligned(8))); } x = {1, 2};", "01000000000000000200000000000000"),
    case!("bits_basic", "struct B { unsigned a:3; unsigned b:5; unsigned c:9; int d:4; } x = {5, 17, 300, -3};", "8d2c1b00"),
    case!("bits_crossing_unit", "struct B { unsigned a:30; unsigned b:4; } x = {0x3fffffff, 0xa};", "ffffff3f0a000000"),
    case!("bits_zero_width", "struct B { unsigned a:3; unsigned :0; unsigned b:2; } x = {7, 3};", "0700000003000000"),
    case!("bits_signed_negative", "struct B { int a:5; int b:7; } x = {-1, -64};", "1f080000"),
    case!("bits_bool", "struct B { _Bool a:1; _Bool b:1; unsigned c:2; } x = {1, 0, 3};", "0d000000"),
    case!("bits_char", "struct B { unsigned char a:4; unsigned char b:4; char c; } x = {0xa, 0x5, 'z'};", "5a7a"),
    case!("bits_long", "struct B { unsigned long a:40; unsigned long b:24; } x = {0xabcdef0123ul, 0x456789ul};", "2301efcdab896745"),
    case!("bits_packed", "struct __attribute__((packed)) B { char c; unsigned a:12; unsigned b:4; } x = {1, 0xabc, 0xd};", "01bcda"),
    case!("bits_designated", "struct B { unsigned a:4; unsigned b:4; unsigned c:8; } x = {.c = 0x5a, .a = 3};", "035a0000"),
    case!("bits_unnamed_padding", "struct B { unsigned a:2; unsigned :3; unsigned b:3; } x = {1, 5};", "a1000000"),
    case!("bits_bool_from_address", "int g; struct { _Bool bit : 1; unsigned rest : 7; } x = {&g, 5};", "0b000000"),
    case!("bits_from_float", "struct B { int a : 5; _Bool b : 1; } x = {3.75, 0.5};", "23000000"),
];

/// Initializers that are not constant, each with its diagnostic; clang
/// rejects each of them too.
#[rustfmt::skip]
const REJECTED: &[Reject] = &[
    reject!("writable_element", "static int a[] = {1, 2}; int x = a[1];", "constant integer expected (got identifier `a`)"),
    reject!("index_outside", "static const int a[2] = {1, 2}; int x = a[2];", "constant integer expected (got identifier `a`)"),
    reject!("initializer_not_seen", "extern const int a[]; int x = a[1]; const int a[] = {1, 2};", "constant integer expected (got identifier `a`)"),
    reject!("writable_scalar", "int g = 1; int x = g;", "constant integer expected (got identifier `g`)"),
    reject!("function_call", "int f(void); int x = f();", "constant integer expected (got identifier `f`)"),
    reject!("address_in_int", "int g; int x = (int)(long)&g;", "an address constant does not fit an object of type `int`"),
    reject!("address_in_int_member", "int g; struct { int a, b, c; } x = {1, &g, 3};", "an address constant does not fit an object of type `int`"),
    reject!("address_in_short_element", "int g; short x[2] = {1, (short)(long)&g};", "an address constant does not fit an object of type `short`"),
    reject!("address_in_char", "char x = (char)(long)\"abc\";", "an address constant does not fit an object of type"),
    reject!("address_in_double", "int g; double x = (double)(long)&g;", "an address constant does not fit an object of type `double`"),
    reject!("address_in_bit_field", "int g; struct { unsigned long w : 40; } x = {(unsigned long)&g};", "an address constant does not fit a bit-field"),
    reject!("difference_of_objects", "int a, b; long x = (char *)&a - (char *)&b;", "addresses in distinct objects have no constant difference or order"),
    reject!("difference_of_literals", "long x = (\"abc\" + 3) - (\"abc\" + 1);", "addresses in distinct objects have no constant difference or order"),
    reject!("order_of_objects", "int a, b; int x = &a < &b;", "addresses in distinct objects have no constant difference or order"),
    reject!("value_through_address", "struct S { int a; void *p; } g; void *x = (&g)->p;", "a member read through an address is not a constant expression"),
    reject!("value_through_cast_address", "struct S { int a; long b; } g; long x = ((struct S *)&g)->b;", "a member read through an address is not a constant expression"),
    reject!("read_through_other_type", "int x = ((const int *)\"abcd\")[0];", "a read through this pointer is not a constant expression"),
    reject!("read_past_literal", "int x = \"abc\"[4];", "a read through this pointer is not a constant expression"),
    reject!("hex_escape_out_of_range", "char x[] = \"\\x80a\";", "hex escape sequence out of range"),
    reject!("octal_escape_out_of_range", "char x[] = \"\\777\";", "octal escape sequence out of range"),
    reject!("char_constant_escape_out_of_range", "int x = '\\x100';", "hex escape sequence out of range"),
    reject!("u16_escape_out_of_range", "unsigned short x[] = u\"\\x10000\";", "hex escape sequence out of range"),
    reject!("wide_escape_out_of_range", "typedef __WCHAR_TYPE__ wchar_t; wchar_t x[] = L\"\\x100000000\";", "hex escape sequence out of range"),
    reject!("address_of_thread_local", "_Thread_local int t; int *x = &t;", "address of thread-local `t` is not a constant expression"),
    reject!("automatic_compound_literal", "int *f(void) { static int *x = (int[]){1}; return x; }", "address of a compound literal with automatic storage duration is not a constant expression"),
    reject!("part_of_relocated_slot", "static int g; static const union { long v; int half[2]; } u = {(long)&g}; int x = u.half[0];", "constant integer expected (got identifier `u`)"),
];

/// Initializers badc accepts where clang rejects them, pinned to what badc
/// emits; a case that starts to agree with clang fails here.
#[rustfmt::skip]
const ACCEPTED_ONLY_BY_BADC: &[Case] = &[
    // badc reads the element of an array compound literal; gcc and clang
    // reject both forms, a compound literal being an object (C99 6.5.2.5p4).
    case!("compound_literal_element_read", "int x = (int[]){1, 2}[1];", "02000000"),
    case!("compound_literal_paren_element_read", "int x = ((int[]){1, 2})[1];", "02000000"),
    // gcc folds the difference to the address, as badc does; clang rejects
    // both forms.
    case!("string_minus_null", "long x = (char *)\"abc\" - (char *)0;", "0000000000000000", 0 => Data("61626300")),
    case!("address_minus_null", "int g; long x = (char *)&g - (char *)0;", "0000000000000000", 0 => Sym("g", 0)),
    // TODO: the conversion goes undiagnosed; gcc and clang reject it
    // (-Wint-conversion), and an assignment reports B3001.
    case!("pointer_to_integer_without_cast", "int g; long x = &g;", "0000000000000000", 0 => Sym("g", 0)),
];

/// Initializers badc rejects where clang accepts them.
#[rustfmt::skip]
const REJECTED_ONLY_BY_BADC: &[Reject] = &[
    // C99 6.7.8p2 makes the excess a constraint violation; gcc and clang
    // warn and drop it.
    reject!("string_too_long", "char x[3] = \"abcdef\";", "too many initializers for array `x` (6 > 3)"),
    reject!("excess_elements", "int x[2] = {1, 2, 3};", "too many initializers for array `x` (3 > 2)"),
    reject!("excess_scalar_braces", "int x = {1, 2};", "must hold a single value"),
    // TODO: the constant folder carries floating values as `f64`, so a
    // `long double` element does not fold; gcc and clang fold it.
    reject!("long_double_element_read", "static const long double a[] = {1.5L}; long double x = a[0];", "constant integer expected (got identifier `a`)"),
];

#[test]
fn address_constants() {
    check_table(ADDRESSES);
}

#[test]
fn string_literals() {
    check_table(STRINGS);
}

#[test]
fn values_read_from_const_objects() {
    check_table(VALUES);
}

#[test]
fn aggregate_shapes() {
    check_table(AGGREGATES);
}

#[test]
fn packed_layouts_and_bit_fields() {
    check_table(PACKED_AND_BITS);
}

#[test]
fn rejected_initializers() {
    check_rejections(REJECTED);
}

#[test]
fn where_badc_and_clang_disagree() {
    check_table(ACCEPTED_ONLY_BY_BADC);
    check_rejections(REJECTED_ONLY_BY_BADC);
    // TODO: on linux-aarch64 plain `char` and `unsigned char` are one type,
    // so the read has the literal's element type there and folds; clang
    // rejects it on both targets.
    let src = "int x = ((const unsigned char *)\"\\xff\")[0];";
    let e = object(src, Target::LinuxX64).expect_err("folded on linux-x64");
    assert!(
        e.contains("a read through this pointer is not a constant expression"),
        "{e}"
    );
    let obj = object(src, Target::LinuxAarch64).expect("rejected on linux-aarch64");
    assert_eq!(hex(&read_x(&obj).0), "ff000000");
}
