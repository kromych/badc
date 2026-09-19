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
fn reloc_bytes_raw(src: &str, target: Target) -> alloc::vec::Vec<u8> {
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

/// Zero the build-provenance marker (`OUTPUT_MARKER`) wherever the emitter
/// placed it in the object. The marker carries `CARGO_PKG_VERSION`, so it
/// changes on every release bump although the generated code is identical, and
/// it is non-executed metadata rather than codegen output. Zeroing is
/// length-preserving, so the digest and the pinned length stay independent of
/// the version string while still catching any real change to code,
/// relocations, or layout. A bump that changes the marker's byte length (a
/// wider version string) shifts container offsets and still needs a refresh.
fn mask_build_marker(bytes: &mut [u8]) {
    let marker = crate::OUTPUT_MARKER.as_bytes();
    let mut i = 0;
    while i + marker.len() <= bytes.len() {
        if &bytes[i..i + marker.len()] == marker {
            bytes[i..i + marker.len()].fill(0);
            i += marker.len();
        } else {
            i += 1;
        }
    }
}

/// Emit a relocatable object with the version-bearing marker masked; this is
/// the form the digest is taken over.
fn reloc_bytes(src: &str, target: Target) -> alloc::vec::Vec<u8> {
    let mut bytes = reloc_bytes_raw(src, target);
    mask_build_marker(&mut bytes);
    bytes
}

/// (fixture, target, digest, len). Host-independent: the bytes are a function
/// of (source, target, options) only. Regenerate by running
/// `reloc_object_bytes_match_golden` -- it panics with the current table.
const GOLDEN: &[(&str, &str, u64, usize)] = &[
    ("ret42", "linux-x64", 0x0fdab3b6ce83b678, 880),
    ("ret42", "linux-arm64", 0xb743a5eb3a559a5c, 1008),
    ("ret42", "macos-arm64", 0xb743a5eb3a559a5c, 1008),
    ("ret42", "win-x64", 0x0fdab3b6ce83b678, 880),
    ("ret42", "win-arm64", 0xb743a5eb3a559a5c, 1008),
    ("intarith", "linux-x64", 0xc0d3b891cd63b8c9, 1088),
    ("intarith", "linux-arm64", 0x9f434b80dd79be14, 1232),
    ("intarith", "macos-arm64", 0x9f434b80dd79be14, 1232),
    ("intarith", "win-x64", 0xc0b9ce552a8813bc, 1080),
    ("intarith", "win-arm64", 0x55dd6e76872ed922, 1240),
    ("fparith", "linux-x64", 0xb7c912dfc96dcde9, 1080),
    ("fparith", "linux-arm64", 0xd0a30bf0e45d9378, 1160),
    ("fparith", "macos-arm64", 0xd0a30bf0e45d9378, 1160),
    ("fparith", "win-x64", 0x823b620de34593da, 1152),
    ("fparith", "win-arm64", 0xd0a30bf0e45d9378, 1160),
    ("fpunary", "linux-x64", 0xbca6c4306d378afd, 1128),
    ("fpunary", "linux-arm64", 0x58422c240e7e63f9, 1208),
    ("fpunary", "macos-arm64", 0x58422c240e7e63f9, 1208),
    ("fpunary", "win-x64", 0x7df82b559b637847, 1232),
    ("fpunary", "win-arm64", 0x58422c240e7e63f9, 1208),
    ("mem", "linux-x64", 0x43da1bddcfe8cfe7, 968),
    ("mem", "linux-arm64", 0x41531b685ed7db90, 1128),
    ("mem", "macos-arm64", 0x41531b685ed7db90, 1128),
    ("mem", "win-x64", 0x2a3883974fc4fcf7, 968),
    ("mem", "win-arm64", 0x41531b685ed7db90, 1128),
    ("data_calls", "linux-x64", 0xdbc5e7a08eedc405, 1136),
    ("data_calls", "linux-arm64", 0x0420c2c9890e8a59, 1280),
    ("data_calls", "macos-arm64", 0x0420c2c9890e8a59, 1280),
    ("data_calls", "win-x64", 0xc276042a0aad288e, 1144),
    ("data_calls", "win-arm64", 0x0420c2c9890e8a59, 1280),
    ("struct_param_spill", "linux-x64", 0x1928fc6cdf25d4ad, 992),
    (
        "struct_param_spill",
        "linux-arm64",
        0x6a669d5d41edbc19,
        1160,
    ),
    (
        "struct_param_spill",
        "macos-arm64",
        0x6a669d5d41edbc19,
        1160,
    ),
    ("struct_param_spill", "win-x64", 0xb316d122c9ffd7c6, 984),
    ("struct_param_spill", "win-arm64", 0xdcf2fa70b02abe8c, 1160),
    (
        "fp_across_struct_call",
        "linux-x64",
        0xdab8506b421221c8,
        1160,
    ),
    (
        "fp_across_struct_call",
        "linux-arm64",
        0x7f71832e246161d2,
        1248,
    ),
    (
        "fp_across_struct_call",
        "macos-arm64",
        0x7f71832e246161d2,
        1248,
    ),
    ("fp_across_struct_call", "win-x64", 0xec31c454b378c741, 1224),
    (
        "fp_across_struct_call",
        "win-arm64",
        0x7f71832e246161d2,
        1248,
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

#[test]
fn build_marker_is_masked_out_of_hashed_bytes() {
    // The raw object embeds the version-bearing marker; the hashed form must
    // not, so a release bump cannot move the golden. Masking is length-
    // preserving, keeping the pinned length a real-size check.
    let marker = crate::OUTPUT_MARKER.as_bytes();
    let src = "int f(void){return 42;}";
    let raw = reloc_bytes_raw(src, Target::LinuxX64);
    assert!(
        raw.windows(marker.len()).any(|w| w == marker),
        "raw relocatable object does not carry the build marker"
    );
    let hashed = reloc_bytes(src, Target::LinuxX64);
    assert_eq!(raw.len(), hashed.len(), "masking changed the object length");
    assert!(
        !hashed.windows(marker.len()).any(|w| w == marker),
        "build marker survived into the hashed bytes"
    );
}
