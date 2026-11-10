//! The x86 instruction-set extensions a unit targets, as gcc's `-m<ext>`,
//! `-mno-<ext>` and `-march=` options select them, and the macros they
//! predefine. The set holds the extensions whose intrinsics badc's headers
//! carry; gcc's implications between them and its CPU names were measured
//! against gcc 16, each CPU reduced to the extensions of this set.

/// A set of x86 extensions beyond the x86-64 baseline (SSE2).
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct X86Features(u64);

const SSE3: u64 = 1 << 0;
const SSSE3: u64 = 1 << 1;
const SSE4_1: u64 = 1 << 2;
const SSE4_2: u64 = 1 << 3;
const POPCNT: u64 = 1 << 4;
const CRC32: u64 = 1 << 5;
const AVX: u64 = 1 << 6;
const AVX2: u64 = 1 << 7;
const FMA: u64 = 1 << 8;
const F16C: u64 = 1 << 9;
const AES: u64 = 1 << 10;
const PCLMUL: u64 = 1 << 11;
const SHA: u64 = 1 << 12;
const VAES: u64 = 1 << 13;
const VPCLMULQDQ: u64 = 1 << 14;
const RDRND: u64 = 1 << 15;
const RDSEED: u64 = 1 << 16;
const BMI: u64 = 1 << 17;
const BMI2: u64 = 1 << 18;
const LZCNT: u64 = 1 << 19;
const ADX: u64 = 1 << 20;
const XSAVE: u64 = 1 << 21;
const CLFLUSHOPT: u64 = 1 << 22;
const CLWB: u64 = 1 << 23;
const PRFCHW: u64 = 1 << 24;
const SAHF: u64 = 1 << 25;
const AVX512F: u64 = 1 << 26;
const AVX512BW: u64 = 1 << 27;
const AVX512DQ: u64 = 1 << 28;
const AVX512VL: u64 = 1 << 29;
const AVX512CD: u64 = 1 << 30;
const AVX512VNNI: u64 = 1 << 31;

/// An extension: its option name, its bit, its macro, the extensions
/// enabling it enables, and those disabling it also disables beside its
/// dependents (gcc's `-mno-sse4.2` drops POPCNT and CRC32).
struct Ext {
    name: &'static str,
    bit: u64,
    mac: &'static str,
    implies: u64,
    unsets: u64,
}

const fn ext(name: &'static str, bit: u64, mac: &'static str, implies: u64) -> Ext {
    Ext {
        name,
        bit,
        mac,
        implies,
        unsets: 0,
    }
}

const EXTS: &[Ext] = &[
    ext("sse3", SSE3, "__SSE3__", 0),
    ext("ssse3", SSSE3, "__SSSE3__", SSE3),
    ext("sse4.1", SSE4_1, "__SSE4_1__", SSSE3),
    Ext {
        unsets: POPCNT | CRC32,
        ..ext("sse4.2", SSE4_2, "__SSE4_2__", SSE4_1 | POPCNT | CRC32)
    },
    ext("popcnt", POPCNT, "__POPCNT__", 0),
    ext("crc32", CRC32, "__CRC32__", 0),
    ext("avx", AVX, "__AVX__", SSE4_2 | XSAVE),
    ext("avx2", AVX2, "__AVX2__", AVX),
    ext("fma", FMA, "__FMA__", AVX),
    ext("f16c", F16C, "__F16C__", AVX),
    ext("aes", AES, "__AES__", 0),
    ext("pclmul", PCLMUL, "__PCLMUL__", 0),
    ext("sha", SHA, "__SHA__", 0),
    ext("vaes", VAES, "__VAES__", AVX),
    ext("vpclmulqdq", VPCLMULQDQ, "__VPCLMULQDQ__", AVX | PCLMUL),
    ext("rdrnd", RDRND, "__RDRND__", 0),
    ext("rdseed", RDSEED, "__RDSEED__", 0),
    ext("bmi", BMI, "__BMI__", 0),
    ext("bmi2", BMI2, "__BMI2__", 0),
    ext("lzcnt", LZCNT, "__LZCNT__", 0),
    ext("adx", ADX, "__ADX__", 0),
    ext("xsave", XSAVE, "__XSAVE__", 0),
    ext("clflushopt", CLFLUSHOPT, "__CLFLUSHOPT__", 0),
    ext("clwb", CLWB, "__CLWB__", 0),
    ext("prfchw", PRFCHW, "__PRFCHW__", 0),
    ext("sahf", SAHF, "__LAHF_SAHF__", 0),
    ext("avx512f", AVX512F, "__AVX512F__", AVX2),
    ext("avx512bw", AVX512BW, "__AVX512BW__", AVX512F),
    ext("avx512dq", AVX512DQ, "__AVX512DQ__", AVX512F),
    ext("avx512vl", AVX512VL, "__AVX512VL__", AVX512F),
    ext("avx512cd", AVX512CD, "__AVX512CD__", AVX512F),
    ext("avx512vnni", AVX512VNNI, "__AVX512VNNI__", AVX512F),
];

/// The x86-64 psABI levels 2 and 3 within the set.
const V2: u64 = SSE3 | SSSE3 | SSE4_1 | SSE4_2 | POPCNT | CRC32 | SAHF;
const V3: u64 = V2 | AVX | AVX2 | FMA | F16C | BMI | BMI2 | LZCNT | XSAVE;
/// The AVX-512 part of x86-64-v4 within the set.
const V4: u64 = AVX512F | AVX512BW | AVX512DQ | AVX512VL | AVX512CD;

/// gcc's `-march=` names and their extensions within the set.
#[rustfmt::skip]
const CPUS: &[(&[&str], u64)] = &[
    (&["x86-64", "k8", "opteron", "athlon64", "athlon-fx"], 0),
    (&["nocona", "k8-sse3", "opteron-sse3", "athlon64-sse3"], SSE3),
    (&["eden-x2"], SSE3 | SAHF),
    (&["core2", "bonnell", "atom", "nano", "nano-1000", "nano-2000"], SSE3 | SSSE3 | SAHF),
    (&["nano-3000", "nano-x2", "eden-x4", "nano-x4"], SSE3 | SSSE3 | SSE4_1 | SAHF),
    (&["amdfam10", "barcelona"], SSE3 | POPCNT | LZCNT | PRFCHW | SAHF),
    (&["btver1"], SSE3 | SSSE3 | POPCNT | LZCNT | XSAVE | PRFCHW | SAHF),
    (&["nehalem", "corei7", "x86-64-v2"], V2),
    (&["westmere"], V2 | PCLMUL),
    (&["silvermont", "slm"], V2 | PCLMUL | RDRND | PRFCHW),
    (&["goldmont", "goldmont-plus"],
     V2 | AES | PCLMUL | SHA | RDRND | RDSEED | XSAVE | CLFLUSHOPT | PRFCHW),
    (&["tremont"], V2 | AES | PCLMUL | SHA | RDRND | RDSEED | XSAVE | CLFLUSHOPT | CLWB | PRFCHW),
    (&["lujiazui"],
     V2 | AES | PCLMUL | RDRND | RDSEED | BMI | BMI2 | LZCNT | ADX | XSAVE | PRFCHW),
    (&["sandybridge", "corei7-avx"], V2 | AVX | PCLMUL | XSAVE),
    (&["ivybridge", "core-avx-i"], V2 | AVX | F16C | PCLMUL | RDRND | XSAVE),
    (&["bdver1"], V2 | AVX | AES | PCLMUL | LZCNT | XSAVE | PRFCHW),
    (&["bdver2", "bdver3"], V2 | AVX | FMA | F16C | AES | PCLMUL | BMI | LZCNT | XSAVE | PRFCHW),
    (&["btver2"], V2 | AVX | F16C | AES | PCLMUL | BMI | LZCNT | XSAVE | PRFCHW),
    (&["x86-64-v3"], V3),
    (&["x86-64-v4"], V3 | V4),
    (&["haswell", "core-avx2"], V3 | PCLMUL | RDRND),
    (&["bdver4"], V3 | AES | PCLMUL | RDRND | PRFCHW),
    (&["broadwell"], V3 | PCLMUL | RDRND | RDSEED | ADX | PRFCHW),
    (&["skylake"], V3 | AES | PCLMUL | RDRND | RDSEED | ADX | CLFLUSHOPT | PRFCHW),
    (&["skylake-avx512"],
     V3 | V4 | AES | PCLMUL | RDRND | RDSEED | ADX | CLFLUSHOPT | CLWB | PRFCHW),
    (&["cascadelake", "cooperlake"],
     V3 | V4 | AVX512VNNI | AES | PCLMUL | RDRND | RDSEED | ADX | CLFLUSHOPT | CLWB | PRFCHW),
    (&["yongfeng", "shijidadao"], V3 | AES | PCLMUL | SHA | RDRND | RDSEED | ADX | PRFCHW),
    (&["znver1", "c86-4g-m4", "c86-4g-m6"],
     V3 | AES | PCLMUL | SHA | RDRND | RDSEED | ADX | CLFLUSHOPT | PRFCHW),
    (&["cannonlake"],
     V3 | V4 | AES | PCLMUL | SHA | RDRND | RDSEED | ADX | CLFLUSHOPT | PRFCHW),
    (&["znver2"], V3 | AES | PCLMUL | SHA | RDRND | RDSEED | ADX | CLFLUSHOPT | CLWB | PRFCHW),
    (&["icelake-client", "rocketlake"],
     V3 | V4 | AVX512VNNI | AES | PCLMUL | SHA | VAES | VPCLMULQDQ | RDRND | RDSEED | ADX
        | CLFLUSHOPT | PRFCHW),
    (&["alderlake", "raptorlake", "meteorlake", "arrowlake", "arrowlake-s", "lunarlake",
       "pantherlake", "wildcatlake", "gracemont", "sierraforest", "grandridge",
       "clearwaterforest", "znver3"],
     V3 | AES | PCLMUL | SHA | VAES | VPCLMULQDQ | RDRND | RDSEED | ADX | CLFLUSHOPT | CLWB
        | PRFCHW),
    (&["icelake-server", "tigerlake", "sapphirerapids", "emeraldrapids", "graniterapids",
       "graniterapids-d", "diamondrapids", "novalake", "znver4", "znver5", "znver6",
       "c86-4g-m7", "c86-4g-m8"],
     V3 | V4 | AVX512VNNI | AES | PCLMUL | SHA | VAES | VPCLMULQDQ | RDRND | RDSEED | ADX
        | CLFLUSHOPT | CLWB | PRFCHW),
];

/// gcc's x86 extension names outside the set: `-mno-<name>` asks for
/// nothing badc emits, `-m<name>` for intrinsics it lacks.
const ABSENT: &[&str] = &[
    "sse4a",
    "fma4",
    "xop",
    "tbm",
    "3dnow",
    "3dnowa",
    "abm",
    "gfni",
    "movbe",
    "fsgsbase",
    "xsaveopt",
    "xsavec",
    "xsaves",
    "cx16",
    "sgx",
    "pku",
    "rdpid",
    "clzero",
    "mwaitx",
    "waitpkg",
    "wbnoinvd",
    "ptwrite",
    "serialize",
    "tsxldtrk",
    "uintr",
    "hreset",
    "kl",
    "widekl",
    "shstk",
    "rtm",
    "hle",
    "lwp",
    "rdpru",
    "movdiri",
    "movdir64b",
    "enqcmd",
    "cldemote",
    "pconfig",
    "prefetchi",
    "cmpccxadd",
    "raoint",
    "sha512",
    "sm3",
    "sm4",
    "avxvnni",
    "avxifma",
    "avxvnniint8",
    "avxvnniint16",
    "avxneconvert",
    "avx10.1",
    "avx10.2",
    "amx-tile",
    "amx-int8",
    "amx-bf16",
    "apxf",
    "usermsr",
];

/// What `-m<name>` or `-mno-<name>` names.
pub enum X86ExtOption {
    /// An extension of the set.
    Known,
    /// A gcc extension badc has no intrinsics for.
    Absent,
    /// No x86 extension.
    Unknown,
}

impl X86Features {
    pub const NONE: Self = Self(0);

    /// What `name`, the part after `-m` or `-mno-`, names.
    pub fn classify(name: &str) -> X86ExtOption {
        if name == "sse4" || EXTS.iter().any(|e| e.name == name) {
            X86ExtOption::Known
        } else if name.starts_with("avx512") || ABSENT.contains(&name) {
            X86ExtOption::Absent
        } else {
            X86ExtOption::Unknown
        }
    }

    /// `-m<name>`: the extension and those it implies. `sse4` is `sse4.2`.
    pub fn enable(&mut self, name: &str) {
        let name = if name == "sse4" { "sse4.2" } else { name };
        let mut add = EXTS.iter().find(|e| e.name == name).map_or(0, |e| e.bit);
        loop {
            let more = EXTS
                .iter()
                .filter(|e| add & e.bit != 0)
                .fold(add, |m, e| m | e.implies);
            if more == add {
                break;
            }
            add = more;
        }
        self.0 |= add;
    }

    /// `-mno-<name>`: the extension and every one that implies it. `sse4`
    /// is `sse4.1`. A name outside the set removes nothing.
    pub fn disable(&mut self, name: &str) {
        let name = if name == "sse4" { "sse4.1" } else { name };
        let Some(e) = EXTS.iter().find(|e| e.name == name) else {
            return;
        };
        let mut gone = e.bit;
        loop {
            let more = EXTS
                .iter()
                .filter(|d| d.implies & gone != 0)
                .fold(gone, |m, d| m | d.bit);
            if more == gone {
                break;
            }
            gone = more;
        }
        let also = EXTS
            .iter()
            .filter(|d| gone & d.bit != 0)
            .fold(0, |m, d| m | d.unsets);
        self.0 &= !(gone | also);
    }

    /// `-march=<name>`'s extensions, or `None` for a name gcc lacks.
    pub fn for_cpu(name: &str) -> Option<Self> {
        CPUS.iter()
            .find(|(names, _)| names.contains(&name))
            .map(|&(_, bits)| Self(bits))
    }

    /// Whether `name` is a `-march=` / `-mtune=` CPU name.
    pub fn is_cpu(name: &str) -> bool {
        CPUS.iter().any(|(names, _)| names.contains(&name))
    }

    /// The extensions `-march=native` takes from the host: `has` answers
    /// whether the host CPU has the extension of that option name.
    pub fn for_host(has: impl Fn(&str) -> bool) -> Self {
        let mut f = Self::NONE;
        for e in EXTS.iter().filter(|e| has(e.name)) {
            f.0 |= e.bit;
        }
        f
    }

    /// The feature macros gcc predefines for the set; AVX512VL's
    /// `__EVEX256__` too.
    pub fn macros(self) -> impl Iterator<Item = &'static str> {
        let evex256 = (self.0 & AVX512VL != 0).then_some("__EVEX256__");
        EXTS.iter()
            .filter(move |e| self.0 & e.bit != 0)
            .map(|e| e.mac)
            .chain(evex256)
    }

    /// `__BIGGEST_ALIGNMENT__`, the widest register's: 16 bytes, 32 under
    /// AVX, 64 under AVX-512F.
    pub fn biggest_alignment(self) -> u8 {
        if self.0 & AVX512F != 0 {
            64
        } else if self.0 & AVX != 0 {
            32
        } else {
            16
        }
    }

    /// AVX-512F: the 512-bit registers and the EVEX encodings.
    pub fn avx512f(self) -> bool {
        self.0 & AVX512F != 0
    }

    /// AVX-512BW: the byte and word elements at 512 bits.
    pub fn avx512bw(self) -> bool {
        self.0 & AVX512BW != 0
    }

    /// Whether the set holds x86-64-v3, which the code generator assumes.
    pub fn covers_baseline(self) -> bool {
        self.0 & V3 == V3
    }

    /// For an extension of x86-64-v3, which the code generator emits on its
    /// own, whether it is a vector one, which `-mno-sse` keeps the code
    /// off; `None` for any other.
    pub fn baseline_ext(name: &str) -> Option<bool> {
        let name = if name == "sse4" { "sse4.1" } else { name };
        let e = EXTS.iter().find(|e| e.name == name && e.bit & V3 != 0)?;
        Some(e.bit & (SSE3 | SSSE3 | SSE4_1 | SSE4_2 | AVX | AVX2 | FMA | F16C) != 0)
    }

    /// AVX: the 256-bit registers and the VEX encodings.
    pub fn avx(self) -> bool {
        self.0 & AVX != 0
    }

    /// AVX2: the 256-bit integer instructions.
    pub fn avx2(self) -> bool {
        self.0 & AVX2 != 0
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn macros(f: X86Features) -> alloc::vec::Vec<&'static str> {
        f.macros().collect()
    }

    #[test]
    fn an_extension_brings_what_it_implies() {
        let mut f = X86Features::NONE;
        f.enable("avx2");
        assert_eq!(
            macros(f),
            [
                "__SSE3__",
                "__SSSE3__",
                "__SSE4_1__",
                "__SSE4_2__",
                "__POPCNT__",
                "__CRC32__",
                "__AVX__",
                "__AVX2__",
                "__XSAVE__"
            ]
        );
    }

    #[test]
    fn disabling_an_extension_drops_its_dependents() {
        let mut f = X86Features::for_cpu("haswell").unwrap();
        f.disable("avx");
        assert!(!f.avx() && !f.avx2());
        assert!(!macros(f).contains(&"__FMA__"));
        assert!(macros(f).contains(&"__SSE4_2__") && macros(f).contains(&"__BMI2__"));
        f.disable("sse4.2");
        assert!(!macros(f).contains(&"__POPCNT__"));
        assert!(macros(f).contains(&"__SSE4_1__"));
    }

    /// gcc 16's AVX-512 model: AVX512F implies AVX2, the others AVX512F,
    /// AVX512VL adds `__EVEX256__`, and the alignment is 64.
    #[test]
    fn avx512_extensions_imply_and_predefine_as_gccs() {
        let mut f = X86Features::NONE;
        f.enable("avx512vl");
        let m = macros(f);
        for name in ["__AVX2__", "__AVX512F__", "__AVX512VL__", "__EVEX256__"] {
            assert!(m.contains(&name), "{name}: {m:?}");
        }
        assert_eq!(f.biggest_alignment(), 64);
        f.disable("avx512f");
        assert!(!f.avx512f() && f.avx2() && f.biggest_alignment() == 32);
        assert!(X86Features::for_cpu("x86-64-v4").unwrap().avx512bw());
        assert!(!X86Features::for_cpu("alderlake").unwrap().avx512f());
    }

    #[test]
    fn cpu_names_resolve_to_their_extensions() {
        assert_eq!(X86Features::for_cpu("x86-64"), Some(X86Features::NONE));
        assert!(X86Features::for_cpu("x86-64-v3").unwrap().avx2());
        assert!(!X86Features::for_cpu("sandybridge").unwrap().avx2());
        assert_eq!(X86Features::for_cpu("pentium9"), None);
    }
}
