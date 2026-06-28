//! Relocatable-object byte+reloc equality gate.
//!
//! Each fixture is emitted as a single-translation-unit
//! `OutputKind::Relocatable` object for every codegen target; the exact byte
//! stream (machine code + relocations + object layout) is pinned by a digest.
//! Any change to emitted bytes or relocations on any target trips the golden.
//!
//! With `debug_info` off the relocatable output is byte-stable across runs --
//! the DWARF blob is the only path-dependent output -- so the digest is a
//! deterministic equality gate, not a normalized-disassembly approximation
//! (the latter strips the raw bytes that encode relocation targets). This is
//! the gate that holds the emitter refactor to byte-for-byte parity.

use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};

const TARGETS: &[(&str, Target)] = &[
    ("linux-x64", Target::LinuxX64),
    ("linux-arm64", Target::LinuxAarch64),
    ("macos-arm64", Target::MacOSAarch64),
    ("win-x64", Target::WindowsX64),
    ("win-arm64", Target::WindowsAarch64),
];

struct Fixture {
    name: &'static str,
    src: &'static str,
}

const FIXTURES: &[Fixture] = &[
    Fixture {
        name: "ret42",
        src: "int f(void){return 42;}",
    },
    Fixture {
        name: "intarith",
        src: "long g(long x,long y){long a=x*y; long b=x+y; long c=x&y; long d=x^y; \
              long e=x|y; return a-b+c-d+e;} \
              long h(long x,long y){return (x/y)+(x%y)+(x<<3)+(x>>y);}",
    },
    Fixture {
        name: "fparith",
        src: "double g(double p,double q){return p*q+p/q-(p-q);} \
              float f(float a,float b){return a*b-a/b+(a+b);}",
    },
    Fixture {
        name: "fpunary",
        src: "double n(double x){return -x;} int lt(double a,double b){return a<b;} \
              float nf(float x){return -x;}",
    },
    Fixture {
        name: "mem",
        src: "int sum(int*p,int n){int s=0;for(int i=0;i<n;i++)s+=p[i];return s;}",
    },
    Fixture {
        name: "data_calls",
        src: "int cb(int); int G[4]={5,6,7,8}; int top(int i){return cb(i)+G[i&3];}",
    },
    // Aggregate parameter that spills to the stack once the integer
    // argument registers are exhausted (StructStack placement).
    Fixture {
        name: "struct_param_spill",
        src: "struct S { int a; int b; }; \
              long f(long a,long b,long c,long d,long e,long g,long h,long i,struct S s){ \
              return a+b+c+d+e+g+h+i+s.a+s.b; }",
    },
    // A floating-point value live across a struct-returning call: exercises
    // callee-saved FP save/restore around the call and struct-return handling.
    Fixture {
        name: "fp_across_struct_call",
        src: "struct P { double x; double y; }; struct P mk(double a, double b); \
              double compute(double a, double b){ double s=a*b; struct P p=mk(a,b); \
              return s+p.x+p.y; }",
    },
];

/// FNV-1a 64-bit. No dependency; a change detector, not a cryptographic hash.
fn fnv1a(bytes: &[u8]) -> u64 {
    let mut h: u64 = 0xcbf2_9ce4_8422_2325;
    for &b in bytes {
        h ^= b as u64;
        h = h.wrapping_mul(0x0000_0100_0000_01b3);
    }
    h
}

/// Compile per target (the data model -- `long`/pointer width, struct layout --
/// is fixed at compile time, so a single Program cannot serve targets with
/// different models) and emit a relocatable object. `no_entry_point` is the
/// `-c` mode: no `main` required, every non-static function is an external
/// symbol. The explicit target keeps the bytes host-independent.
fn reloc_bytes(src: &str, target: Target) -> alloc::vec::Vec<u8> {
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.into(), target, copts)
        .compile()
        .unwrap_or_else(|e| panic!("compile for {target:?}: {e}"));
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    crate::c5::object::emit_native_with_options(&program, target, nopts)
        .unwrap_or_else(|e| panic!("emit relocatable for {target:?}: {e}"))
}

/// (fixture, target, digest, len). Host-independent: the bytes are a function
/// of (source, target, options) only. Regenerate by running
/// `reloc_object_bytes_match_golden` -- it panics with the current table.
const GOLDEN: &[(&str, &str, u64, usize)] = &[
    ("ret42", "linux-x64", 0x19e783356189ee32, 1472),
    ("ret42", "linux-arm64", 0x07fc9f07b272d045, 1472),
    ("ret42", "macos-arm64", 0x07fc9f07b272d045, 1472),
    ("ret42", "win-x64", 0x19e783356189ee32, 1472),
    ("ret42", "win-arm64", 0x07fc9f07b272d045, 1472),
    ("intarith", "linux-x64", 0x32e7f9a8a23d2879, 1776),
    ("intarith", "linux-arm64", 0x3680fddfc8f85338, 1744),
    ("intarith", "macos-arm64", 0x3680fddfc8f85338, 1744),
    ("intarith", "win-x64", 0xf005b58ff0e2f9d2, 1800),
    ("intarith", "win-arm64", 0x862165d8b7d20f14, 1784),
    ("fparith", "linux-x64", 0x6dd6a94a4ceb8f5e, 1752),
    ("fparith", "linux-arm64", 0x4bc00602138d1458, 1688),
    ("fparith", "macos-arm64", 0x4bc00602138d1458, 1688),
    ("fparith", "win-x64", 0x0daf626ffa7c9b1a, 1840),
    ("fparith", "win-arm64", 0x4bc00602138d1458, 1688),
    ("fpunary", "linux-x64", 0xd6da793aba57f99a, 1848),
    ("fpunary", "linux-arm64", 0xf4b5b3f74419f790, 1752),
    ("fpunary", "macos-arm64", 0xf4b5b3f74419f790, 1752),
    ("fpunary", "win-x64", 0x4c3544b7d7598186, 1984),
    ("fpunary", "win-arm64", 0xf4b5b3f74419f790, 1752),
    ("mem", "linux-x64", 0xa0f7e9b7194eaa86, 1600),
    ("mem", "linux-arm64", 0x44394734000af3f7, 1608),
    ("mem", "macos-arm64", 0x44394734000af3f7, 1608),
    ("mem", "win-x64", 0x9d9c12dbe29b0a26, 1600),
    ("mem", "win-arm64", 0x44394734000af3f7, 1608),
    ("data_calls", "linux-x64", 0x021bff3d4de3acec, 1664),
    ("data_calls", "linux-arm64", 0x2eaa6b7fcabb0b37, 1688),
    ("data_calls", "macos-arm64", 0x2eaa6b7fcabb0b37, 1688),
    ("data_calls", "win-x64", 0x8701619c09b78c22, 1680),
    ("data_calls", "win-arm64", 0x2eaa6b7fcabb0b37, 1688),
    ("struct_param_spill", "linux-x64", 0x4c486c8df4456e10, 1680),
    (
        "struct_param_spill",
        "linux-arm64",
        0x57d897a30a6971ba,
        1664,
    ),
    (
        "struct_param_spill",
        "macos-arm64",
        0x57d897a30a6971ba,
        1664,
    ),
    ("struct_param_spill", "win-x64", 0xc8b021ee3b3b7577, 1720),
    ("struct_param_spill", "win-arm64", 0x0bcb20a73947ed86, 1696),
    (
        "fp_across_struct_call",
        "linux-x64",
        0x9e3edfe0dc19dbdb,
        1744,
    ),
    (
        "fp_across_struct_call",
        "linux-arm64",
        0x728818c3ad0a7bc6,
        1688,
    ),
    (
        "fp_across_struct_call",
        "macos-arm64",
        0x728818c3ad0a7bc6,
        1688,
    ),
    ("fp_across_struct_call", "win-x64", 0xefdbefe433ac8e18, 1816),
    (
        "fp_across_struct_call",
        "win-arm64",
        0x728818c3ad0a7bc6,
        1688,
    ),
];

#[test]
fn reloc_object_bytes_are_byte_stable_across_runs() {
    for fx in FIXTURES {
        for (tname, t) in TARGETS {
            let a = reloc_bytes(fx.src, *t);
            let b = reloc_bytes(fx.src, *t);
            assert_eq!(
                a, b,
                "nondeterministic relocatable bytes: {} {}",
                fx.name, tname
            );
        }
    }
}

#[test]
fn reloc_object_bytes_match_golden() {
    // The table is pinned at the default register file. The `codegen_test`
    // pressure knobs (BADC_MAX_GPR / BADC_MAX_FPR) force extra spills and
    // legitimately change the emitted bytes; under a forced-pressure run the
    // functional suite and demos are the gate, not this byte table.
    if std::env::var_os("BADC_MAX_GPR").is_some() || std::env::var_os("BADC_MAX_FPR").is_some() {
        return;
    }
    let mut actual = alloc::string::String::new();
    let mut mismatch = GOLDEN.is_empty();
    for fx in FIXTURES {
        for (tname, t) in TARGETS {
            let bytes = reloc_bytes(fx.src, *t);
            let d = fnv1a(&bytes);
            actual.push_str(&alloc::format!(
                "    (\"{}\", \"{}\", 0x{:016x}, {}),\n",
                fx.name,
                tname,
                d,
                bytes.len()
            ));
            match GOLDEN
                .iter()
                .find(|(f, g, _, _)| *f == fx.name && *g == *tname)
            {
                Some((_, _, wd, wl)) => {
                    if *wd != d || *wl != bytes.len() {
                        mismatch = true;
                    }
                }
                None => mismatch = true,
            }
        }
    }
    assert!(
        !mismatch,
        "relocatable byte+reloc golden mismatch. Current table:\n{actual}"
    );
}

#[test]
fn reloc_golden_detects_a_one_byte_source_change() {
    let t = Target::LinuxX64;
    let base = fnv1a(&reloc_bytes("int f(void){return 42;}", t));
    let perturbed = fnv1a(&reloc_bytes("int f(void){return 43;}", t));
    assert_ne!(
        base, perturbed,
        "golden digest is insensitive to a return-value change"
    );
}
