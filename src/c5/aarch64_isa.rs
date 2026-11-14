//! The AArch64 architecture extensions a unit targets, as `-march=` and
//! `-mcpu=` and their `+<ext>` / `+no<ext>` modifiers select them, and the
//! Arm C Language Extensions macros they predefine. The set decides the
//! macros only: the instructions badc emits stay its baseline whatever it
//! holds. The tables are transcribed from gcc 16's definitions, the Apple
//! parts from Apple clang 21's, and checked against both compilers'
//! predefined macros.

use alloc::vec::Vec;

/// A set of [`FEATURES`], by index.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct Aarch64Features(u128);

/// Whether badc predefines the macros a feature defines: it carries what
/// they promise (`C`), it withholds them because its headers lack the
/// intrinsics they name (`W`), or the feature defines none (`N`).
#[derive(Clone, Copy, PartialEq, Eq)]
enum Macros {
    C,
    W,
    N,
}
use Macros::{C, N, W};

struct Feature {
    name: &'static str,
    /// Enabled with the feature; disabling one disables it.
    requires: &'static [&'static str],
    /// Also enabled when a modifier names the feature.
    on: &'static [&'static str],
    /// Also disabled when a modifier names it off.
    off: &'static [&'static str],
    /// `__ARM_ARCH` of an architecture, 0 for an extension.
    arch: u8,
    macros: Macros,
}

const fn ext(
    name: &'static str,
    requires: &'static [&'static str],
    on: &'static [&'static str],
    off: &'static [&'static str],
    macros: Macros,
) -> Feature {
    Feature {
        name,
        requires,
        on,
        off,
        arch: 0,
        macros,
    }
}

const fn arch(name: &'static str, major: u8, includes: &'static [&'static str]) -> Feature {
    Feature {
        name,
        requires: includes,
        on: &[],
        off: &[],
        arch: major,
        macros: C,
    }
}

/// The extensions, then the architectures, each with what it includes.
#[rustfmt::skip]
const FEATURES: &[Feature] = &[
    ext("rng", &[], &[], &[], C),
    ext("flagm", &[], &[], &[], N),
    ext("flagm2", &["flagm"], &[], &[], N),
    ext("lse", &[], &[], &[], C),
    ext("fp", &[], &[], &[], C),
    ext("simd", &["fp"], &[], &[], W),
    ext("dotprod", &["simd"], &[], &[], C),
    ext("sm4", &["simd"], &[], &[], C),
    ext("rdma", &[], &["simd"], &[], C),
    ext("crc", &[], &[], &[], C),
    ext("sha2", &["simd"], &[], &[], C),
    ext("sha3", &["sha2"], &[], &[], C),
    ext("aes", &["simd"], &[], &[], C),
    ext("crypto", &["aes", "sha2"], &[], &["aes", "sha2", "sm4"], C),
    ext("fp16", &["fp"], &[], &["fp16fml"], W),
    ext("fp16fml", &[], &["fp16"], &[], W),
    ext("jscvt", &["fp"], &[], &[], C),
    ext("fcma", &["simd"], &[], &[], W),
    ext("rcpc", &[], &[], &[], C),
    ext("rcpc2", &["rcpc"], &[], &[], N),
    ext("rcpc3", &["rcpc2"], &[], &[], N),
    ext("frintts", &["fp"], &[], &[], C),
    ext("i8mm", &["simd"], &[], &[], C),
    ext("bf16", &["fp"], &["simd"], &[], W),
    ext("sve", &["simd", "fp16", "fcma"], &[], &[], W),
    ext("sve-b16b16", &[], &[], &[], W),
    ext("f32mm", &["sve"], &[], &[], W),
    ext("f64mm", &["sve"], &[], &[], W),
    ext("sve2", &["sve"], &[], &[], W),
    ext("sve-aes", &["aes"], &[], &[], W),
    ext("sve2-aes", &["sve2", "sve-aes"], &[], &["sve-aes"], W),
    ext("sve-bitperm", &[], &[], &[], W),
    ext("sve2-bitperm", &["sve2", "sve-bitperm"], &[], &["sve-bitperm"], W),
    ext("sve-sha3", &["sha3"], &[], &[], W),
    ext("sve2-sha3", &["sve2", "sve-sha3"], &[], &["sve-sha3"], W),
    ext("sve-sm4", &["sm4"], &[], &[], W),
    ext("sve2-sm4", &["sve2", "sve-sm4"], &[], &["sve-sm4"], W),
    ext("sve2p1", &["sve2"], &[], &[], W),
    ext("sme", &["bf16", "fcma", "fp16", "fp16fml"], &[], &[], W),
    ext("memtag", &[], &[], &[], W),
    ext("sb", &[], &[], &[], N),
    ext("predres", &[], &[], &[], N),
    ext("ssbs", &[], &[], &[], N),
    ext("profile", &[], &[], &[], N),
    ext("tme", &[], &[], &[], W),
    ext("pauth", &[], &[], &[], C),
    ext("ls64", &[], &[], &[], W),
    ext("wfxt", &[], &[], &[], N),
    ext("xs", &[], &[], &[], N),
    ext("sme-f64f64", &["sme"], &[], &[], W),
    ext("sme-i16i64", &["sme"], &[], &[], W),
    ext("sme2", &["sme"], &[], &[], W),
    ext("sme2p1", &["sme2"], &[], &[], W),
    ext("sme-b16b16", &["sme2", "sve-b16b16"], &[], &[], W),
    ext("sme-f16f16", &["sme2"], &[], &[], W),
    ext("mops", &[], &[], &[], N),
    ext("cssc", &[], &[], &[], N),
    ext("cmpbr", &[], &[], &[], N),
    ext("lse128", &["lse"], &[], &[], N),
    ext("d128", &["lse128"], &[], &[], W),
    ext("the", &[], &[], &[], N),
    ext("gcs", &[], &[], &[], W),
    ext("fp8", &["simd"], &[], &[], W),
    ext("fp8fma", &["fp8"], &[], &[], W),
    ext("ssve-fp8fma", &["sme2", "fp8"], &[], &[], N),
    ext("faminmax", &["simd"], &[], &[], W),
    ext("fp8dot4", &["fp8"], &[], &[], W),
    ext("ssve-fp8dot4", &["sme2", "fp8"], &[], &[], N),
    ext("fp8dot2", &["fp8"], &[], &[], W),
    ext("ssve-fp8dot2", &["sme2", "fp8"], &[], &[], N),
    ext("lut", &["simd"], &[], &[], W),
    ext("sme-lutv2", &["sme2"], &[], &[], W),
    ext("sme-f8f16", &["sme2", "fp8"], &[], &[], W),
    ext("sme-f8f32", &["sme2", "fp8"], &[], &[], W),
    ext("cpa", &[], &[], &[], N),
    ext("fprcvt", &["fp"], &[], &[], N),
    ext("lsfe", &["fp"], &[], &[], N),
    ext("f8f32mm", &["simd", "fp8"], &[], &[], W),
    ext("f8f16mm", &["simd", "fp8"], &[], &[], W),
    ext("sme2p2", &["sme2p1"], &[], &[], N),
    ext("sve2p2", &["sve2p1"], &[], &[], N),
    ext("sve-aes2", &[], &[], &[], N),
    ext("sve-f16f32mm", &["sve"], &[], &[], W),
    ext("sve-bfscale", &[], &[], &[], W),
    ext("ssve-aes", &["sme2", "sve-aes"], &[], &[], N),
    ext("ssve-bitperm", &["sme2", "sve-bitperm"], &[], &[], N),
    ext("ssve-fexpa", &["sme2"], &[], &[], N),
    ext("sme-mop4", &["sme2"], &[], &[], N),
    ext("sme-tmop", &["sme2"], &[], &[], N),
    ext("lsui", &[], &[], &[], N),
    ext("occmo", &[], &[], &[], N),
    ext("pcdphint", &[], &[], &[], W),
    ext("pops", &[], &[], &[], N),
    ext("poe2", &[], &[], &[], N),
    ext("tev", &[], &[], &[], N),
    ext("tlbid", &[], &[], &[], N),
    ext("gcie", &[], &[], &[], N),
    ext("lscp", &[], &[], &[], N),
    ext("mops-go", &["mops", "memtag"], &[], &[], N),
    ext("sve2p3", &["sve2p2"], &[], &[], N),
    ext("sme2p3", &["sme2p2"], &[], &[], N),
    ext("f16f32dot", &["simd", "fp16"], &[], &[], N),
    ext("sve-b16mm", &["sve"], &[], &[], N),
    ext("mtetc", &["memtag"], &[], &[], N),
    ext("f16f32mm", &["simd", "fp16"], &[], &[], N),
    ext("f16mm", &["simd", "fp16"], &[], &[], N),
    arch("armv8-a", 8, &["simd"]),
    arch("armv8.1-a", 8, &["armv8-a", "lse", "crc", "rdma"]),
    arch("armv8.2-a", 8, &["armv8.1-a"]),
    arch("armv8.3-a", 8, &["armv8.2-a", "pauth", "rcpc", "fcma", "jscvt"]),
    arch("armv8.4-a", 8, &["armv8.3-a", "fp16fml", "dotprod", "flagm", "rcpc2"]),
    arch("armv8.5-a", 8, &["armv8.4-a", "sb", "ssbs", "predres", "frintts", "flagm2"]),
    arch("armv8.6-a", 8, &["armv8.5-a", "i8mm", "bf16"]),
    arch("armv8.7-a", 8, &["armv8.6-a", "wfxt", "xs"]),
    arch("armv8.8-a", 8, &["armv8.7-a", "mops"]),
    arch("armv8.9-a", 8, &["armv8.8-a", "cssc"]),
    arch("armv8-r", 8, &["armv8.4-a"]),
    arch("armv9-a", 9, &["armv8.5-a", "sve2"]),
    arch("armv9.1-a", 9, &["armv8.6-a", "armv9-a"]),
    arch("armv9.2-a", 9, &["armv8.7-a", "armv9.1-a"]),
    arch("armv9.3-a", 9, &["armv8.8-a", "armv9.2-a"]),
    arch("armv9.4-a", 9, &["armv8.9-a", "armv9.3-a", "sve2p1"]),
    arch("armv9.5-a", 9, &["armv9.4-a", "cpa", "faminmax", "lut"]),
    arch("armv9.6-a", 9, &["armv9.5-a", "cmpbr", "lsui", "occmo"]),
];

const _: () = assert!(FEATURES.len() <= 128);

/// The CPUs `-mcpu=` names: the architecture and the extensions beyond it.
#[rustfmt::skip]
const CPUS: &[(&str, &str, &[&str])] = &[
    ("a64fx", "armv8.2-a", &["fp16", "sve"]),
    ("ampere1", "armv8.6-a", &["fp16", "rng", "aes", "sha3"]),
    ("ampere1a", "armv8.6-a", &["fp16", "rng", "aes", "sha3", "sm4", "memtag"]),
    ("ampere1b", "armv8.7-a", &["fp16", "rng", "aes", "sha3", "sm4", "memtag", "cssc"]),
    ("ampere1c", "armv9.2-a", &["cssc", "crypto", "fp8fma", "faminmax", "lut", "sve-b16b16", "sve2-aes", "sve2-sha3", "sve2-sm4"]),
    ("apple-a10", "armv8-a", &["aes", "crc", "rdma", "sha2"]),
    ("apple-a11", "armv8.2-a", &["aes", "fp16", "sha2"]),
    ("apple-a12", "armv8.3-a", &["aes", "fp16", "sha2"]),
    ("apple-a13", "armv8.4-a", &["aes", "fp16", "sha3"]),
    ("apple-a14", "armv8.5-a", &["aes", "fp16", "sha3"]),
    ("apple-a15", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-a16", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-a17", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-a18", "armv8.7-a", &["aes", "sha3", "sme-f64f64", "sme-i16i64", "sme2"]),
    ("apple-a19", "armv8.7-a", &["aes", "cssc", "memtag", "sha3", "sme-b16b16", "sme-f16f16", "sme-f64f64", "sme-i16i64", "sme2p1"]),
    ("apple-a20", "armv8.7-a", &["aes", "cpa", "cssc", "faminmax", "lut", "memtag", "sha3", "sme-b16b16", "sme-f16f16", "sme-f64f64", "sme-f8f16", "sme-f8f32", "sme-i16i64", "sme-lutv2", "sme2p1"]),
    ("apple-a7", "armv8-a", &["aes", "sha2"]),
    ("apple-a8", "armv8-a", &["aes", "sha2"]),
    ("apple-a9", "armv8-a", &["aes", "sha2"]),
    ("apple-m1", "armv8.5-a", &["aes", "fp16", "sha3"]),
    ("apple-m2", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-m3", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-m4", "armv8.7-a", &["aes", "sha3", "sme-f64f64", "sme-i16i64", "sme2"]),
    ("apple-m5", "armv8.7-a", &["aes", "cssc", "memtag", "sha3", "sme-b16b16", "sme-f16f16", "sme-f64f64", "sme-i16i64", "sme2p1"]),
    ("apple-m6", "armv8.7-a", &["aes", "cpa", "cssc", "faminmax", "lut", "memtag", "sha3", "sme-b16b16", "sme-f16f16", "sme-f64f64", "sme-f8f16", "sme-f8f32", "sme-i16i64", "sme-lutv2", "sme2p1"]),
    ("apple-s10", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("apple-s11", "armv8.7-a", &["aes", "cpa", "cssc", "faminmax", "lut", "memtag", "sha3", "sme-b16b16", "sme-f16f16", "sme-f64f64", "sme-f8f16", "sme-f8f32", "sme-i16i64", "sme-lutv2", "sme2p1"]),
    ("apple-s4", "armv8.3-a", &["aes", "fp16", "sha2"]),
    ("apple-s5", "armv8.3-a", &["aes", "fp16", "sha2"]),
    ("apple-s6", "armv8.4-a", &["aes", "fp16", "sha3"]),
    ("apple-s7", "armv8.4-a", &["aes", "fp16", "sha3"]),
    ("apple-s8", "armv8.4-a", &["aes", "fp16", "sha3"]),
    ("apple-s9", "armv8.6-a", &["aes", "fp16", "sha3"]),
    ("ares", "armv8.2-a", &["fp16", "rcpc", "dotprod", "profile"]),
    ("armagicpu", "armv9.2-a", &["sve2-bitperm", "rng", "ls64", "memtag", "profile"]),
    ("c1-nano", "armv9.3-a", &["memtag", "sve2-bitperm", "fp16fml", "sme2", "rcpc3"]),
    ("c1-premium", "armv9.3-a", &["memtag", "sve2-bitperm", "fp16fml", "profile", "sme2", "rcpc3"]),
    ("c1-pro", "armv9.3-a", &["memtag", "sve2-bitperm", "fp16fml", "profile", "sme2", "rcpc3"]),
    ("c1-ultra", "armv9.3-a", &["memtag", "sve2-bitperm", "fp16fml", "profile", "sme2", "rcpc3"]),
    ("carmel", "armv8.2-a", &["aes", "fp16", "sha2"]),
    ("cobalt-100", "armv9-a", &["i8mm", "bf16", "sve2-bitperm", "rng", "memtag", "profile"]),
    ("cortex-a320", "armv9.2-a", &["sve2-bitperm", "memtag"]),
    ("cortex-a34", "armv8-a", &["crc"]),
    ("cortex-a35", "armv8-a", &["crc"]),
    ("cortex-a510", "armv9-a", &["sve2-bitperm", "memtag", "i8mm", "bf16"]),
    ("cortex-a520", "armv9.2-a", &["sve2-bitperm", "memtag"]),
    ("cortex-a520ae", "armv9.2-a", &["sve2-bitperm", "memtag"]),
    ("cortex-a53", "armv8-a", &["crc"]),
    ("cortex-a55", "armv8.2-a", &["fp16", "rcpc", "dotprod"]),
    ("cortex-a57", "armv8-a", &["crc"]),
    ("cortex-a57.cortex-a53", "armv8-a", &["crc"]),
    ("cortex-a65", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs"]),
    ("cortex-a65ae", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs"]),
    ("cortex-a710", "armv9-a", &["sve2-bitperm", "memtag", "i8mm", "bf16"]),
    ("cortex-a715", "armv9-a", &["sve2-bitperm", "memtag", "i8mm", "bf16"]),
    ("cortex-a72", "armv8-a", &["crc"]),
    ("cortex-a72.cortex-a53", "armv8-a", &["crc"]),
    ("cortex-a720", "armv9.2-a", &["sve2-bitperm", "memtag", "profile"]),
    ("cortex-a720ae", "armv9.2-a", &["sve2-bitperm", "memtag", "profile"]),
    ("cortex-a725", "armv9.2-a", &["sve2-bitperm", "memtag", "profile"]),
    ("cortex-a73", "armv8-a", &["crc"]),
    ("cortex-a73.cortex-a35", "armv8-a", &["crc"]),
    ("cortex-a73.cortex-a53", "armv8-a", &["crc"]),
    ("cortex-a75", "armv8.2-a", &["fp16", "rcpc", "dotprod"]),
    ("cortex-a75.cortex-a55", "armv8.2-a", &["fp16", "rcpc", "dotprod"]),
    ("cortex-a76", "armv8.2-a", &["fp16", "rcpc", "dotprod"]),
    ("cortex-a76.cortex-a55", "armv8.2-a", &["fp16", "rcpc", "dotprod"]),
    ("cortex-a76ae", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs"]),
    ("cortex-a77", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs"]),
    ("cortex-a78", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs", "profile"]),
    ("cortex-a78ae", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs", "profile"]),
    ("cortex-a78c", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs", "profile", "flagm", "pauth"]),
    ("cortex-r82", "armv8-r", &[]),
    ("cortex-r82ae", "armv8-r", &[]),
    ("cortex-x1", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs", "profile"]),
    ("cortex-x1c", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs", "profile", "pauth"]),
    ("cortex-x2", "armv9-a", &["sve2-bitperm", "memtag", "i8mm", "bf16"]),
    ("cortex-x3", "armv9-a", &["sve2-bitperm", "memtag", "i8mm", "bf16"]),
    ("cortex-x4", "armv9.2-a", &["sve2-bitperm", "memtag", "profile"]),
    ("cortex-x925", "armv9.2-a", &["sve2-bitperm", "memtag", "profile"]),
    ("cyclone", "armv8-a", &["aes", "sha2"]),
    ("demeter", "armv9-a", &["i8mm", "bf16", "sve2-bitperm", "rng", "memtag", "profile"]),
    ("emag", "armv8-a", &["crc", "crypto"]),
    ("exynos-m1", "armv8-a", &["crc", "crypto"]),
    ("exynos-m3", "armv8-a", &["aes", "crc", "sha2"]),
    ("exynos-m4", "armv8.2-a", &["aes", "dotprod", "fp16", "sha2"]),
    ("exynos-m5", "armv8.2-a", &["aes", "dotprod", "fp16", "sha2"]),
    ("falkor", "armv8-a", &["crc", "crypto", "rdma"]),
    ("fujitsu-monaka", "armv9.3-a", &["fp16", "faminmax", "fp8fma", "fp8dot2", "fp8dot4", "ls64", "lut", "rng", "crypto", "sve2-aes", "sve2-bitperm", "sve2-sha3", "sve2-sm4"]),
    ("gb10", "armv9.2-a", &["sve2-bitperm", "sve2-aes", "sve2-sha3", "sve2-sm4", "memtag", "profile"]),
    ("generic", "armv8-a", &[]),
    ("generic-armv8-a", "armv8-a", &[]),
    ("generic-armv9-a", "armv9-a", &[]),
    ("grace", "armv9-a", &["i8mm", "bf16", "sve2-bitperm", "sve2-aes", "sve2-sha3", "sve2-sm4", "profile"]),
    ("hip12", "armv8.7-a", &["fp16", "profile", "rng", "sve2-bitperm", "sve2-aes", "sve2-sm4", "sve2-sha3", "ls64", "rcpc3"]),
    ("kryo", "armv8-a", &["aes", "crc", "sha2"]),
    ("neoverse-512tvb", "armv8.4-a", &["sve", "i8mm", "bf16", "profile", "ssbs", "rng"]),
    ("neoverse-e1", "armv8.2-a", &["fp16", "rcpc", "dotprod", "ssbs"]),
    ("neoverse-n1", "armv8.2-a", &["fp16", "rcpc", "dotprod", "profile"]),
    ("neoverse-n2", "armv9-a", &["i8mm", "bf16", "sve2-bitperm", "rng", "memtag", "profile"]),
    ("neoverse-n3", "armv9.2-a", &["sve2-bitperm", "rng", "memtag", "profile"]),
    ("neoverse-v1", "armv8.4-a", &["sve", "i8mm", "bf16", "profile", "ssbs", "rng"]),
    ("neoverse-v2", "armv9-a", &["i8mm", "bf16", "sve2-bitperm", "rng", "memtag", "profile"]),
    ("neoverse-v3", "armv9.2-a", &["sve2-bitperm", "rng", "ls64", "memtag", "profile"]),
    ("neoverse-v3ae", "armv9.2-a", &["sve2-bitperm", "rng", "ls64", "memtag", "profile"]),
    ("octeontx", "armv8-a", &["crc", "crypto"]),
    ("octeontx2", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2f95", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2f95mm", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2f95n", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2t93", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2t96", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx2t98", "armv8.2-a", &["crypto", "profile"]),
    ("octeontx81", "armv8-a", &["crc", "crypto"]),
    ("octeontx83", "armv8-a", &["crc", "crypto"]),
    ("olympus", "armv9.2-a", &["sve2-bitperm", "rng", "ls64", "memtag", "profile", "faminmax", "fp8fma", "fp8dot2", "fp8dot4", "lut", "sve2-aes", "sve2-sha3", "sve2-sm4"]),
    ("oryon-1", "armv8.6-a", &["crypto", "sm4", "sha3", "fp16"]),
    ("phecda", "armv8-a", &["crc", "crypto"]),
    ("qdf24xx", "armv8-a", &["crc", "crypto", "rdma"]),
    ("rigel", "armv9.2-a", &["sve2-bitperm", "rng", "ls64", "memtag", "profile", "faminmax", "fp8fma", "fp8dot2", "fp8dot4", "lut", "sve2-aes", "sve2-sha3", "sve2-sm4"]),
    ("saphira", "armv8.4-a", &["crypto"]),
    ("thunderx", "armv8-a", &["crc", "crypto"]),
    ("thunderx2t99", "armv8.1-a", &["crypto"]),
    ("thunderx2t99p1", "armv8.1-a", &["crypto"]),
    ("thunderx3t110", "armv8.3-a", &["crypto", "sm4", "sha3", "fp16fml"]),
    ("thunderxt81", "armv8-a", &["crc", "crypto"]),
    ("thunderxt83", "armv8-a", &["crc", "crypto"]),
    ("thunderxt88", "armv8-a", &["crc", "crypto"]),
    ("thunderxt88p1", "armv8-a", &["crc", "crypto"]),
    ("tsv110", "armv8.2-a", &["crypto", "fp16"]),
    ("vulcan", "armv8.1-a", &["crypto"]),
    ("xgene1", "armv8-a", &[]),
    ("zeus", "armv8.4-a", &["sve", "i8mm", "bf16", "profile", "ssbs", "rng"]),
];

/// The macros a feature set defines beyond the unconditional ones, where
/// badc carries what each promises: the name, the value, and the features
/// it requires. `__ARM_NEON` and the macros of the features marked `W` are
/// withheld, and so are `__ARM_FP16_FORMAT_IEEE` and `__ARM_FP16_ARGS`, as
/// badc has no `__fp16`. TODO(#2029): `__ARM_NEON` with the Advanced SIMD
/// intrinsic set.
const FEATURE_MACROS: &[(&str, &str, &[&str])] = &[
    ("__ARM_FP", "14", &["fp"]),
    ("__ARM_FEATURE_FMA", "1", &["fp"]),
    ("__ARM_FEATURE_CRC32", "1", &["crc"]),
    ("__ARM_FEATURE_JCVT", "1", &["jscvt"]),
    ("__ARM_FEATURE_CRYPTO", "1", &["aes", "sha2"]),
    ("__ARM_FEATURE_ATOMICS", "1", &["lse"]),
    ("__ARM_FEATURE_AES", "1", &["aes"]),
    ("__ARM_FEATURE_SHA2", "1", &["sha2"]),
    ("__ARM_FEATURE_SHA3", "1", &["sha3"]),
    ("__ARM_FEATURE_SHA512", "1", &["sha3"]),
    ("__ARM_FEATURE_SM3", "1", &["sm4"]),
    ("__ARM_FEATURE_SM4", "1", &["sm4"]),
    ("__ARM_FEATURE_RNG", "1", &["rng"]),
    ("__ARM_FEATURE_PAUTH", "1", &["pauth"]),
    ("__ARM_FEATURE_BTI", "1", &["armv8.5-a"]),
    ("__ARM_FEATURE_RCPC", "1", &["rcpc"]),
    ("__ARM_FEATURE_NUMERIC_MAXMIN", "1", &["simd"]),
    ("__ARM_FEATURE_QRDMX", "1", &["rdma"]),
    ("__ARM_FEATURE_DOTPROD", "1", &["dotprod"]),
    ("__ARM_FEATURE_FRINT", "1", &["frintts"]),
    ("__ARM_FEATURE_MATMUL_INT8", "1", &["i8mm"]),
];

/// What a `+` modifier can be refused for.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Aarch64ExtError {
    /// No extension has the name.
    Unknown,
    /// It enables the feature named, whose intrinsics badc does not
    /// implement.
    Unimplemented(&'static str),
}

fn index(name: &str) -> Option<usize> {
    FEATURES.iter().position(|f| f.name == name)
}

fn bits(names: &[&str]) -> u128 {
    names
        .iter()
        .map(|n| 1u128 << index(n).expect("a feature the tables name"))
        .fold(0, |a, b| a | b)
}

/// `(major, minor)` of an architecture name: `armv8.5-a` is (8, 5).
fn version(name: &str) -> (u8, u8) {
    let v = name.trim_start_matches("armv").trim_end_matches("-a");
    let (major, minor) = v.split_once('.').unwrap_or((v, "0"));
    (major.parse().unwrap_or(0), minor.parse().unwrap_or(0))
}

impl Aarch64Features {
    pub const NONE: Self = Self(0);

    fn has(self, name: &str) -> bool {
        self.0 & bits(&[name]) != 0
    }

    /// `set` with every feature its members require.
    fn closure(mut set: u128) -> u128 {
        loop {
            let mut next = set;
            for (i, f) in FEATURES.iter().enumerate() {
                if set >> i & 1 != 0 {
                    next |= bits(f.requires);
                }
            }
            if next == set {
                return set;
            }
            set = next;
        }
    }

    /// `set` with every feature that requires one of its members.
    fn dependents(set: u128) -> u128 {
        (0..FEATURES.len())
            .filter(|&i| Self::closure(1 << i) & set != 0)
            .fold(set, |a, i| a | 1 << i)
    }

    /// The architecture `name` (`armv8.2-a`) and what it includes.
    pub fn for_arch(name: &str) -> Option<Self> {
        let i = FEATURES
            .iter()
            .position(|f| f.arch != 0 && f.name == name)?;
        Some(Self(Self::closure(1 << i)))
    }

    /// The CPU `name`'s architecture and extensions.
    pub fn for_cpu(name: &str) -> Option<Self> {
        let &(_, arch, exts) = CPUS.iter().find(|c| c.0 == name)?;
        Some(Self(Self::closure(bits(&[arch]) | bits(exts))))
    }

    /// The set a unit targets when no option selects one: the Apple M1's
    /// on macOS, ARMv8-A's elsewhere.
    pub fn default_for(macos: bool) -> Self {
        if macos {
            Self::for_cpu("apple-m1")
        } else {
            Self::for_arch("armv8-a")
        }
        .expect("a CPU and an architecture the tables name")
    }

    /// Apply one modifier: `<ext>` enables the extension, what it requires
    /// and what it names on; `no<ext>` disables it, what it names off, and
    /// what requires either. Enabling a feature badc withholds the macros
    /// of is refused.
    pub fn apply(&mut self, modifier: &str) -> Result<(), Aarch64ExtError> {
        let ext = |name: &str| index(name).filter(|&i| FEATURES[i].arch == 0);
        if let Some(i) = ext(modifier) {
            let added = Self::closure(1 << i | bits(FEATURES[i].on)) & !self.0;
            // The extension itself first, then what it brings.
            let withheld = |j: usize| added >> j & 1 != 0 && FEATURES[j].macros == W;
            if let Some(j) = core::iter::once(i)
                .chain(0..FEATURES.len())
                .find(|&j| withheld(j))
            {
                return Err(Aarch64ExtError::Unimplemented(FEATURES[j].name));
            }
            self.0 |= added;
            return Ok(());
        }
        let i = modifier
            .strip_prefix("no")
            .and_then(ext)
            .ok_or(Aarch64ExtError::Unknown)?;
        self.0 &= !Self::dependents(1 << i | bits(FEATURES[i].off));
        Ok(())
    }

    /// The set without the floating-point and SIMD registers
    /// (`-mgeneral-regs-only`): what requires `fp` goes with it.
    pub fn without_fp(self) -> Self {
        Self(self.0 & !Self::dependents(bits(&["fp"])))
    }

    /// The host's set (`native`), `has` answering for an extension name or
    /// `bti`: the features it reports and the highest architecture they
    /// cover. A part reporting BTI, which armv8.5-a brings, covers that
    /// architecture without reporting the features no macro names.
    pub fn for_host(has: impl Fn(&str) -> bool) -> Self {
        let have = Self::closure(
            (0..FEATURES.len())
                .filter(|&i| FEATURES[i].arch == 0 && has(FEATURES[i].name))
                .fold(0, |a, i| a | 1 << i),
        );
        let exempt = if has("bti") {
            bits(&["ssbs", "sb", "predres", "flagm", "flagm2"])
        } else {
            0
        };
        let archs = (0..FEATURES.len())
            .filter(|&i| FEATURES[i].arch != 0)
            .fold(0, |a, i| a | 1u128 << i);
        let best = (0..FEATURES.len())
            .filter(|&i| FEATURES[i].arch != 0 && FEATURES[i].name != "armv8-r")
            .filter(|&i| Self::closure(1 << i) & !archs & !have & !exempt == 0)
            .max_by_key(|&i| version(FEATURES[i].name))
            .map_or(0, |i| Self::closure(1 << i));
        Self(best | have)
    }

    /// Whether `name` names a CPU `-mcpu=` takes.
    pub fn is_cpu(name: &str) -> bool {
        CPUS.iter().any(|c| c.0 == name)
    }

    /// Whether `name` names an architecture `-march=` takes.
    pub fn is_arch(name: &str) -> bool {
        FEATURES.iter().any(|f| f.arch != 0 && f.name == name)
    }

    /// The macros the set predefines with the target's: `wchar2` for a
    /// 2-byte `wchar_t`, `pe` for the Windows targets, whose calling
    /// convention is not AAPCS64's. badc aligns an object at most to 2^16
    /// bytes, static or automatic.
    pub fn macros(self, wchar2: bool, pe: bool) -> Vec<(&'static str, &'static str)> {
        let mut out = alloc::vec![
            ("__ARM_64BIT_STATE", "1"),
            ("__ARM_ARCH_ISA_A64", "1"),
            ("__ARM_ALIGN_MAX_PWR", "16"),
            ("__ARM_ALIGN_MAX_STACK_PWR", "16"),
            ("__ARM_ARCH_8A", "1"),
            ("__ARM_ARCH", if self.has("armv9-a") { "9" } else { "8" }),
            (
                "__ARM_ARCH_PROFILE",
                if self.has("armv8-r") { "82" } else { "65" },
            ),
            ("__ARM_FEATURE_CLZ", "1"),
            ("__ARM_FEATURE_IDIV", "1"),
            ("__ARM_FEATURE_UNALIGNED", "1"),
            ("__ARM_SIZEOF_MINIMAL_ENUM", "4"),
            ("__ARM_SIZEOF_WCHAR_T", if wchar2 { "2" } else { "4" }),
        ];
        if !pe {
            out.push(("__ARM_PCS_AAPCS64", "1"));
        }
        for &(name, value, needs) in FEATURE_MACROS {
            if needs.iter().all(|n| self.has(n)) {
                out.push((name, value));
            }
        }
        out
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The feature macros, without the unconditional ones.
    fn features(f: Aarch64Features) -> Vec<&'static str> {
        let mut m: Vec<_> = f
            .macros(false, false)
            .into_iter()
            .map(|(n, _)| n)
            .filter(|n| n.starts_with("__ARM_FEATURE_") || *n == "__ARM_FP")
            .filter(|n| {
                !matches!(
                    *n,
                    "__ARM_FEATURE_CLZ" | "__ARM_FEATURE_IDIV" | "__ARM_FEATURE_UNALIGNED"
                )
            })
            .collect();
        m.sort_unstable();
        m
    }

    fn arch(name: &str) -> Aarch64Features {
        Aarch64Features::for_arch(name).unwrap()
    }

    #[test]
    fn every_name_the_tables_use_resolves() {
        for f in FEATURES {
            for n in f.requires.iter().chain(f.on).chain(f.off) {
                assert!(index(n).is_some(), "{}: {n}", f.name);
            }
        }
        for (cpu, a, exts) in CPUS {
            assert!(Aarch64Features::is_arch(a), "{cpu}: {a}");
            assert!(exts.iter().all(|e| index(e).is_some()), "{cpu}");
        }
    }

    /// The macros of the architecture levels, less the withheld ones.
    #[test]
    fn architectures_predefine_as_gccs() {
        assert_eq!(
            features(arch("armv8-a")),
            [
                "__ARM_FEATURE_FMA",
                "__ARM_FEATURE_NUMERIC_MAXMIN",
                "__ARM_FP"
            ]
        );
        assert_eq!(
            features(arch("armv8.1-a")),
            [
                "__ARM_FEATURE_ATOMICS",
                "__ARM_FEATURE_CRC32",
                "__ARM_FEATURE_FMA",
                "__ARM_FEATURE_NUMERIC_MAXMIN",
                "__ARM_FEATURE_QRDMX",
                "__ARM_FP"
            ]
        );
        assert!(features(arch("armv8.4-a")).contains(&"__ARM_FEATURE_DOTPROD"));
        assert!(!features(arch("armv8.4-a")).contains(&"__ARM_FEATURE_FRINT"));
        assert!(features(arch("armv8.5-a")).contains(&"__ARM_FEATURE_FRINT"));
        assert!(!features(arch("armv8.5-a")).contains(&"__ARM_FEATURE_MATMUL_INT8"));
        assert!(features(arch("armv8.6-a")).contains(&"__ARM_FEATURE_MATMUL_INT8"));
        let v85 = features(arch("armv8.5-a"));
        for m in [
            "__ARM_FEATURE_BTI",
            "__ARM_FEATURE_JCVT",
            "__ARM_FEATURE_PAUTH",
            "__ARM_FEATURE_RCPC",
        ] {
            assert!(v85.contains(&m), "{m}: {v85:?}");
        }
        assert!(!features(arch("armv8.4-a")).contains(&"__ARM_FEATURE_BTI"));
        let arch9 = |f: Aarch64Features| f.macros(false, false).contains(&("__ARM_ARCH", "9"));
        assert!(arch9(arch("armv9.2-a")) && !arch9(arch("armv8.9-a")));
        let r = arch("armv8-r").macros(false, false);
        assert!(r.contains(&("__ARM_ARCH_PROFILE", "82")));
    }

    /// The CPUs carry their extensions, the Apple parts the crypto ones.
    #[test]
    fn cpus_carry_their_extensions() {
        let m1 = features(Aarch64Features::for_cpu("apple-m1").unwrap());
        for m in [
            "__ARM_FEATURE_AES",
            "__ARM_FEATURE_SHA3",
            "__ARM_FEATURE_SHA512",
            "__ARM_FEATURE_BTI",
        ] {
            assert!(m1.contains(&m), "{m}: {m1:?}");
        }
        assert_eq!(
            features(Aarch64Features::for_cpu("cortex-a53").unwrap()),
            [
                "__ARM_FEATURE_CRC32",
                "__ARM_FEATURE_FMA",
                "__ARM_FEATURE_NUMERIC_MAXMIN",
                "__ARM_FP"
            ]
        );
        let n1 = features(Aarch64Features::for_cpu("neoverse-n1").unwrap());
        assert!(n1.contains(&"__ARM_FEATURE_RCPC") && !n1.contains(&"__ARM_FEATURE_JCVT"));
        assert!(Aarch64Features::for_cpu("pentium4").is_none());
    }

    #[test]
    fn modifiers_enable_and_disable_with_dependencies() {
        let mut f = arch("armv8-a");
        f.apply("crypto").unwrap();
        assert!(features(f).contains(&"__ARM_FEATURE_CRYPTO"));
        f.apply("sha3").unwrap();
        assert!(features(f).contains(&"__ARM_FEATURE_SHA512"));
        // Disabling SHA-2 takes SHA3, which requires it.
        f.apply("nosha2").unwrap();
        let m = features(f);
        assert!(m.contains(&"__ARM_FEATURE_AES") && !m.contains(&"__ARM_FEATURE_SHA3"));
        // The crypto extensions require SIMD, which requires FP.
        f.apply("nofp").unwrap();
        assert!(features(f).is_empty());
        let mut f = arch("armv8.1-a");
        f.apply("nolse").unwrap();
        assert!(!features(f).contains(&"__ARM_FEATURE_ATOMICS"));
        assert_eq!(arch("armv8.2-a").without_fp(), {
            let mut g = arch("armv8.2-a");
            g.apply("nofp").unwrap();
            g
        });
    }

    /// A modifier that brings a feature whose intrinsics badc lacks is
    /// refused, naming the extension first; one already present is not.
    #[test]
    fn enabling_a_withheld_feature_is_refused() {
        let mut f = arch("armv8-a");
        assert_eq!(f.apply("sve"), Err(Aarch64ExtError::Unimplemented("sve")));
        assert_eq!(f.apply("bf16"), Err(Aarch64ExtError::Unimplemented("bf16")));
        assert_eq!(f.apply("simd"), Ok(()));
        assert_eq!(f.apply("lse128"), Ok(()));
        assert_eq!(f.apply("dotprod"), Ok(()));
        assert!(features(f).contains(&"__ARM_FEATURE_DOTPROD"));
        assert_eq!(f.apply("frob"), Err(Aarch64ExtError::Unknown));
        assert_eq!(f.apply("nofrob"), Err(Aarch64ExtError::Unknown));
        assert_eq!(f.apply("armv8.1-a"), Err(Aarch64ExtError::Unknown));
        f.apply("nosimd").unwrap();
        assert_eq!(f.apply("aes"), Err(Aarch64ExtError::Unimplemented("simd")));
        // An architecture that brings a withheld feature only withholds its
        // macros.
        assert!(!features(arch("armv8.6-a")).contains(&"__ARM_FEATURE_BF16"));
    }

    /// A host reporting what an Apple M2 does, without the features no
    /// probe reports, resolves to its architecture.
    #[test]
    fn a_host_resolves_to_the_architecture_its_features_cover() {
        let m2 = Aarch64Features::for_cpu("apple-m2").unwrap();
        let host = Aarch64Features::for_host(|e| {
            e == "bti" || (m2.has(e) && !matches!(e, "predres" | "flagm2" | "wfxt" | "xs"))
        });
        assert_eq!(host.macros(false, false), m2.macros(false, false));
        assert!(host.has("armv8.6-a") && !host.has("armv8.7-a"));
    }

    #[test]
    fn the_platform_sets_wchar_and_the_calling_convention() {
        let pe = arch("armv8-a").macros(true, true);
        assert!(pe.contains(&("__ARM_SIZEOF_WCHAR_T", "2")));
        assert!(!pe.iter().any(|m| m.0 == "__ARM_PCS_AAPCS64"));
        let elf = arch("armv8-a").macros(false, false);
        assert!(elf.contains(&("__ARM_SIZEOF_WCHAR_T", "4")));
        assert!(elf.contains(&("__ARM_PCS_AAPCS64", "1")));
    }
}
