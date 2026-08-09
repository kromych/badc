//! Dynamic-linking metadata for the script-driven link: `.dynsym`,
//! `.dynstr`, `.hash`, `.gnu.hash`, `.gnu.version`, `.gnu.version_d`
//! and `.dynamic`.
//!
//! An ET_DYN image carries these whether or not a loader will search
//! them; bfd builds them for every `-shared` link and the kernel's own
//! scripts discard the ones it does not want. Table shapes follow
//! bfd's: the bucket counts, the Bloom filter geometry and the
//! symbol order are what a consumer reading `DT_GNU_HASH` expects.

#![cfg(feature = "std")]

use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashMap;

pub const SHT_HASH: u32 = 5;
pub const SHT_DYNAMIC: u32 = 6;
pub const SHT_DYNSYM: u32 = 11;
pub const SHT_GNU_VERDEF: u32 = 0x6fff_fffd;
pub const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;
pub const SHT_GNU_HASH: u32 = 0x6fff_fff6;

pub const DT_NULL: u64 = 0;
pub const DT_HASH: u64 = 4;
pub const DT_STRTAB: u64 = 5;
pub const DT_SYMTAB: u64 = 6;
pub const DT_RELA: u64 = 7;
pub const DT_RELASZ: u64 = 8;
pub const DT_RELAENT: u64 = 9;
pub const DT_STRSZ: u64 = 10;
pub const DT_SYMENT: u64 = 11;
pub const DT_SONAME: u64 = 14;
pub const DT_SYMBOLIC: u64 = 16;
pub const DT_INIT_ARRAY: u64 = 25;
pub const DT_FINI_ARRAY: u64 = 26;
pub const DT_INIT_ARRAYSZ: u64 = 27;
pub const DT_FINI_ARRAYSZ: u64 = 28;
pub const DT_PREINIT_ARRAY: u64 = 32;
pub const DT_PREINIT_ARRAYSZ: u64 = 33;
pub const DT_TEXTREL: u64 = 22;
pub const DT_FLAGS: u64 = 30;
pub const DT_RELRSZ: u64 = 35;
pub const DT_RELR: u64 = 36;
pub const DT_RELRENT: u64 = 37;
pub const DT_GNU_HASH: u64 = 0x6fff_fef5;
pub const DT_VERSYM: u64 = 0x6fff_fff0;
pub const DT_VERDEF: u64 = 0x6fff_fffc;
pub const DT_VERDEFNUM: u64 = 0x6fff_fffd;

pub const DF_SYMBOLIC: u64 = 0x02;
pub const DF_TEXTREL: u64 = 0x04;

/// `VER_FLG_BASE`: the node naming the object itself.
const VER_FLG_BASE: u16 = 1;
/// Version index of a symbol with no version, and of the base node.
pub const VER_NDX_LOCAL: u16 = 0;
pub const VER_NDX_GLOBAL: u16 = 1;

/// `--hash-style`. bfd's configured default on the reference boxes is
/// `gnu`, which is what a link that names no style gets.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum HashStyle {
    Sysv,
    #[default]
    Gnu,
    Both,
}

impl HashStyle {
    pub fn parse(s: &str) -> Option<HashStyle> {
        match s {
            "sysv" => Some(HashStyle::Sysv),
            "gnu" => Some(HashStyle::Gnu),
            "both" => Some(HashStyle::Both),
            _ => None,
        }
    }
    pub fn sysv(self) -> bool {
        matches!(self, HashStyle::Sysv | HashStyle::Both)
    }
    pub fn gnu(self) -> bool {
        matches!(self, HashStyle::Gnu | HashStyle::Both)
    }
}

/// One symbol destined for `.dynsym`.
#[derive(Debug, Clone)]
pub struct DynSym {
    pub name: String,
    pub info: u8,
    pub other: u8,
    pub shndx: u16,
    pub value: u64,
    pub size: u64,
    /// Index into the version definitions, or `VER_NDX_GLOBAL` when the
    /// link defines no versions.
    pub version: u16,
}

/// A `VERSION` node that reached the output, in definition order. Index
/// 1 is the base node (the soname or output name); user versions start
/// at 2.
#[derive(Debug, Clone)]
pub struct VerDef {
    pub name: String,
    pub base: bool,
}

/// SysV `.hash` name hash.
pub fn elf_hash(name: &str) -> u32 {
    let mut h: u32 = 0;
    for &c in name.as_bytes() {
        h = (h << 4).wrapping_add(c as u32);
        let g = h & 0xf000_0000;
        if g != 0 {
            h ^= g >> 24;
        }
        h &= !g;
    }
    h
}

/// `.gnu.hash` name hash (djb2).
pub fn gnu_hash(name: &str) -> u32 {
    let mut h: u32 = 5381;
    for &c in name.as_bytes() {
        h = h.wrapping_mul(33).wrapping_add(c as u32);
    }
    h
}

/// bfd's non-optimizing bucket count: the largest table entry the
/// symbol count does not overrun.
pub fn bucket_count(nsyms: usize) -> usize {
    const BUCKETS: &[usize] = &[
        1, 3, 17, 37, 67, 97, 131, 197, 263, 521, 1031, 2053, 4099, 8209, 16411, 32771,
    ];
    let mut best = BUCKETS[0];
    for (i, &b) in BUCKETS.iter().enumerate() {
        best = b;
        match BUCKETS.get(i + 1) {
            Some(&next) if nsyms >= next => continue,
            _ => break,
        }
    }
    best
}

/// bfd's `.gnu.hash` Bloom-filter geometry for a 64-bit target:
/// `(maskwords, shift2)`.
pub fn bloom_params(nsyms: usize) -> (usize, u32) {
    let mut bits: u32 = 1;
    let mut x = nsyms;
    while {
        x >>= 1;
        x != 0
    } {
        bits += 1;
    }
    if bits < 3 {
        bits = 5;
    } else if (1u64 << (bits - 2)) & nsyms as u64 != 0 {
        bits += 3;
    } else {
        bits += 2;
    }
    let shift1 = if bits == 5 { 5 } else { 6 };
    (1usize << (bits - shift1), bits)
}

/// A string table in which a string that is a suffix of another shares
/// the longer one's bytes, as bfd's `.dynstr` does. Sorting on the
/// reversed strings makes every such pair adjacent, so the sharing
/// costs one comparison per entry rather than a scan of the table.
#[derive(Default)]
pub struct StrTab {
    bytes: Vec<u8>,
    offsets: HashMap<String, u32>,
}

impl StrTab {
    pub fn build(names: &[&str]) -> StrTab {
        let mut order: Vec<&str> = names.iter().copied().filter(|s| !s.is_empty()).collect();
        order.sort_unstable_by(|a, b| a.bytes().rev().cmp(b.bytes().rev()).then(a.cmp(b)));
        order.dedup();
        let mut bytes = alloc::vec![0u8];
        let mut offsets: HashMap<String, u32> = HashMap::with_capacity(order.len());
        // Right to left: a string is shared only when the string after
        // it in this order ends with it.
        for (i, &s) in order.iter().enumerate().rev() {
            let next = order.get(i + 1).copied();
            match next.filter(|n| n.len() > s.len() && n.ends_with(s)) {
                Some(n) => {
                    let base = offsets[n];
                    offsets.insert(String::from(s), base + (n.len() - s.len()) as u32);
                }
                None => {
                    let off = bytes.len() as u32;
                    bytes.extend_from_slice(s.as_bytes());
                    bytes.push(0);
                    offsets.insert(String::from(s), off);
                }
            }
        }
        StrTab { bytes, offsets }
    }
    pub fn offset_of(&self, name: &str) -> u32 {
        if name.is_empty() {
            0
        } else {
            self.offsets.get(name).copied().unwrap_or(0)
        }
    }
    pub fn bytes(&self) -> &[u8] {
        &self.bytes
    }
}

/// The built tables. Sizes are final; addresses are the caller's.
pub struct DynTables {
    pub dynsym: Vec<u8>,
    pub strtab: StrTab,
    pub hash: Vec<u8>,
    pub gnu_hash: Vec<u8>,
    pub versym: Vec<u8>,
    pub verdef: Vec<u8>,
    pub verdef_count: u16,
    /// `sh_info` for `.dynsym`: one past the last local entry.
    pub first_global: u32,
}

impl DynTables {
    pub fn dynstr(&self) -> &[u8] {
        self.strtab.bytes()
    }
    pub fn str_offset(&self, name: &str) -> u32 {
        self.strtab.offset_of(name)
    }
}

const SYM_SIZE: usize = 24;

/// Build every dynamic table from the exported symbols. `exports` need
/// not be ordered; the `.gnu.hash` bucket order is imposed here.
pub fn build_tables(
    exports: &[DynSym],
    soname: Option<&str>,
    versions: &[VerDef],
    style: HashStyle,
) -> DynTables {
    // Symbols a loader can find go in bucket order after the ones it
    // cannot (the null entry and any undefined). bfd records the first
    // hashed index as `symndx` and hashes nothing below it.
    let nbuckets = bucket_count(exports.len());
    let mut hashed: Vec<(usize, u32)> = exports
        .iter()
        .enumerate()
        .map(|(i, s)| (i, gnu_hash(&s.name)))
        .collect();
    hashed.sort_by_key(|&(i, h)| (h as usize % nbuckets, i));

    let mut symbols: Vec<DynSym> = Vec::with_capacity(exports.len() + 1);
    symbols.push(DynSym {
        name: String::new(),
        info: 0,
        other: 0,
        shndx: 0,
        value: 0,
        size: 0,
        version: VER_NDX_LOCAL,
    });
    for &(i, _) in &hashed {
        symbols.push(exports[i].clone());
    }

    let mut str_names: Vec<&str> = symbols.iter().map(|s| s.name.as_str()).collect();
    if let Some(s) = soname {
        str_names.push(s);
    }
    for v in versions {
        str_names.push(v.name.as_str());
    }
    let strtab = StrTab::build(&str_names);

    let mut dynsym = Vec::with_capacity(symbols.len() * SYM_SIZE);
    for s in &symbols {
        dynsym.extend_from_slice(&strtab.offset_of(&s.name).to_le_bytes());
        dynsym.push(s.info);
        dynsym.push(s.other);
        dynsym.extend_from_slice(&s.shndx.to_le_bytes());
        dynsym.extend_from_slice(&s.value.to_le_bytes());
        dynsym.extend_from_slice(&s.size.to_le_bytes());
    }

    let hash = if style.sysv() {
        build_sysv_hash(&symbols)
    } else {
        Vec::new()
    };
    let gnu = if style.gnu() {
        build_gnu_hash(&hashed, nbuckets)
    } else {
        Vec::new()
    };

    // Versions exist only where the script defined them; without a
    // VERSION command bfd emits neither table.
    let (versym, verdef) = if versions.is_empty() {
        (Vec::new(), Vec::new())
    } else {
        (build_versym(&symbols), build_verdef(versions, &strtab))
    };

    DynTables {
        dynsym,
        strtab,
        hash,
        gnu_hash: gnu,
        versym,
        verdef,
        verdef_count: versions.len() as u16,
        // Only the null entry is local; bfd emits every dynamic symbol
        // it keeps as global or weak.
        first_global: 1,
    }
}

fn build_sysv_hash(symbols: &[DynSym]) -> Vec<u8> {
    let nchain = symbols.len();
    let nbucket = bucket_count(nchain - 1);
    let mut buckets = alloc::vec![0u32; nbucket];
    let mut chain = alloc::vec![0u32; nchain];
    for (i, s) in symbols.iter().enumerate().skip(1) {
        let b = elf_hash(&s.name) as usize % nbucket;
        chain[i] = buckets[b];
        buckets[b] = i as u32;
    }
    let mut out = Vec::with_capacity((2 + nbucket + nchain) * 4);
    out.extend_from_slice(&(nbucket as u32).to_le_bytes());
    out.extend_from_slice(&(nchain as u32).to_le_bytes());
    for b in buckets {
        out.extend_from_slice(&b.to_le_bytes());
    }
    for c in chain {
        out.extend_from_slice(&c.to_le_bytes());
    }
    out
}

fn build_gnu_hash(hashed: &[(usize, u32)], nbuckets: usize) -> Vec<u8> {
    // The null entry at index 0 is never hashed, so hashing starts at
    // index 1 and the chain array runs one per hashed symbol.
    let symndx: u32 = 1;
    let (maskwords, shift2) = bloom_params(hashed.len());
    let mut bloom = alloc::vec![0u64; maskwords];
    let mut buckets = alloc::vec![0u32; nbuckets];
    let mut chain: Vec<u32> = Vec::with_capacity(hashed.len());
    for (k, &(_, h)) in hashed.iter().enumerate() {
        let idx = symndx as usize + k;
        let b = h as usize % nbuckets;
        bloom[(h as usize / 64) % maskwords] |= (1u64 << (h % 64)) | (1u64 << ((h >> shift2) % 64));
        if buckets[b] == 0 {
            buckets[b] = idx as u32;
        }
        // The low bit ends a bucket's chain.
        let last = hashed
            .get(k + 1)
            .is_none_or(|&(_, nh)| nh as usize % nbuckets != b);
        chain.push((h & !1) | u32::from(last));
    }
    let mut out = Vec::with_capacity(16 + maskwords * 8 + nbuckets * 4 + chain.len() * 4);
    out.extend_from_slice(&(nbuckets as u32).to_le_bytes());
    out.extend_from_slice(&symndx.to_le_bytes());
    out.extend_from_slice(&(maskwords as u32).to_le_bytes());
    out.extend_from_slice(&shift2.to_le_bytes());
    for w in bloom {
        out.extend_from_slice(&w.to_le_bytes());
    }
    for b in buckets {
        out.extend_from_slice(&b.to_le_bytes());
    }
    for c in chain {
        out.extend_from_slice(&c.to_le_bytes());
    }
    out
}

fn build_versym(symbols: &[DynSym]) -> Vec<u8> {
    let mut out = Vec::with_capacity(symbols.len() * 2);
    for s in symbols {
        out.extend_from_slice(&s.version.to_le_bytes());
    }
    out
}

/// `Elf64_Verdef` + one `Elf64_Verdaux` per node.
fn build_verdef(versions: &[VerDef], strtab: &StrTab) -> Vec<u8> {
    const VERDEF_SIZE: u32 = 20;
    const VERDAUX_SIZE: u32 = 8;
    let mut out = Vec::with_capacity(versions.len() * (VERDEF_SIZE + VERDAUX_SIZE) as usize);
    for (i, v) in versions.iter().enumerate() {
        let last = i + 1 == versions.len();
        out.extend_from_slice(&1u16.to_le_bytes()); // vd_version
        out.extend_from_slice(&if v.base { VER_FLG_BASE } else { 0 }.to_le_bytes());
        out.extend_from_slice(&((i + 1) as u16).to_le_bytes()); // vd_ndx
        out.extend_from_slice(&1u16.to_le_bytes()); // vd_cnt
        out.extend_from_slice(&elf_hash(&v.name).to_le_bytes());
        out.extend_from_slice(&VERDEF_SIZE.to_le_bytes()); // vd_aux
        out.extend_from_slice(&if last { 0 } else { VERDEF_SIZE + VERDAUX_SIZE }.to_le_bytes()); // vd_next
        out.extend_from_slice(&strtab.offset_of(&v.name).to_le_bytes());
        out.extend_from_slice(&0u32.to_le_bytes()); // vda_next
    }
    out
}

/// Where each dynamic table landed, for the `.dynamic` tag values.
#[derive(Default)]
pub struct DynAddrs {
    pub hash: Option<u64>,
    pub gnu_hash: Option<u64>,
    pub strtab: Option<u64>,
    pub strsz: u64,
    pub symtab: Option<u64>,
    pub rela: Option<(u64, u64)>,
    pub relr: Option<(u64, u64)>,
    pub verdef: Option<(u64, u16)>,
    pub versym: Option<u64>,
    pub soname: Option<u32>,
    pub symbolic: bool,
    pub textrel: bool,
    /// `(address, size)` of `.preinit_array`, `.init_array` and
    /// `.fini_array`, so a loader runs what they hold.
    pub preinit_array: Option<(u64, u64)>,
    pub init_array: Option<(u64, u64)>,
    pub fini_array: Option<(u64, u64)>,
}

/// `.dynamic` contents in bfd's tag order. `DT_NULL` terminates.
pub fn build_dynamic(a: &DynAddrs) -> Vec<u8> {
    let mut tags: Vec<(u64, u64)> = Vec::new();
    let mut flags: u64 = 0;
    if let Some(off) = a.soname {
        tags.push((DT_SONAME, off as u64));
    }
    if a.symbolic {
        tags.push((DT_SYMBOLIC, 0));
        flags |= DF_SYMBOLIC;
    }
    if let Some(v) = a.hash {
        tags.push((DT_HASH, v));
    }
    if let Some(v) = a.gnu_hash {
        tags.push((DT_GNU_HASH, v));
    }
    if let Some(v) = a.strtab {
        tags.push((DT_STRTAB, v));
    }
    if let Some(v) = a.symtab {
        tags.push((DT_SYMTAB, v));
    }
    tags.push((DT_STRSZ, a.strsz));
    tags.push((DT_SYMENT, SYM_SIZE as u64));
    for (arr, tag, sz) in [
        (a.preinit_array, DT_PREINIT_ARRAY, DT_PREINIT_ARRAYSZ),
        (a.init_array, DT_INIT_ARRAY, DT_INIT_ARRAYSZ),
        (a.fini_array, DT_FINI_ARRAY, DT_FINI_ARRAYSZ),
    ] {
        if let Some((addr, size)) = arr.filter(|&(_, s)| s > 0) {
            tags.push((tag, addr));
            tags.push((sz, size));
        }
    }
    if let Some((addr, size)) = a.rela {
        tags.push((DT_RELA, addr));
        tags.push((DT_RELASZ, size));
        tags.push((DT_RELAENT, 24));
    }
    if let Some((addr, count)) = a.verdef {
        tags.push((DT_VERDEF, addr));
        tags.push((DT_VERDEFNUM, count as u64));
    }
    if a.textrel {
        tags.push((DT_TEXTREL, 0));
        flags |= DF_TEXTREL;
    }
    if flags != 0 {
        tags.push((DT_FLAGS, flags));
    }
    if let Some(v) = a.versym {
        tags.push((DT_VERSYM, v));
    }
    if let Some((addr, size)) = a.relr {
        tags.push((DT_RELR, addr));
        tags.push((DT_RELRSZ, size));
        tags.push((DT_RELRENT, 8));
    }
    tags.push((DT_NULL, 0));
    let mut out = Vec::with_capacity(tags.len() * 16);
    for (t, v) in tags {
        out.extend_from_slice(&t.to_le_bytes());
        out.extend_from_slice(&v.to_le_bytes());
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn bucket_count_matches_bfd_table() {
        assert_eq!(bucket_count(0), 1);
        assert_eq!(bucket_count(2), 1);
        assert_eq!(bucket_count(3), 3);
        // The x86-64 vDSO: 13 hashed symbols, three buckets.
        assert_eq!(bucket_count(13), 3);
        assert_eq!(bucket_count(17), 17);
        assert_eq!(bucket_count(36), 17);
        assert_eq!(bucket_count(37), 37);
    }

    #[test]
    fn bloom_params_match_the_measured_vdso() {
        // ld's x86-64 vDSO: 13 hashed symbols -> two mask words, shift 7.
        assert_eq!(bloom_params(13), (2, 7));
        assert_eq!(bloom_params(1), (1, 5));
    }

    #[test]
    fn gnu_hash_is_djb2() {
        assert_eq!(gnu_hash(""), 5381);
        assert_eq!(
            gnu_hash("a"),
            5381u32.wrapping_mul(33).wrapping_add(b'a' as u32)
        );
    }

    #[test]
    fn elf_hash_matches_the_spec_example() {
        // The System V ABI's worked example.
        assert_eq!(elf_hash("printf"), 0x0779_05a6);
        assert_eq!(elf_hash(""), 0);
    }

    #[test]
    fn sysv_buckets_match_the_measured_vdso_chains() {
        // Bucket membership taken from ld's `.hash` for the x86-64
        // vDSO. Order within a bucket is bfd's traversal order and is
        // not a lookup property, so only membership is asserted.
        let names = [
            "clock_gettime",
            "__vdso_gettimeofday",
            "clock_getres",
            "__vdso_clock_getres",
            "gettimeofday",
            "__vdso_time",
            "__vdso_getrandom",
            "time",
            "__vdso_clock_gettime",
            "LINUX_2.6",
            "__vdso_getcpu",
            "getcpu",
            "getrandom",
        ];
        let expect: [&[usize]; 3] = [&[2, 3, 4, 6, 10, 11, 12], &[5, 7], &[1, 8, 9, 13]];
        for (b, want) in expect.iter().enumerate() {
            let got: Vec<usize> = (1..=names.len())
                .filter(|&i| elf_hash(names[i - 1]) as usize % 3 == b)
                .collect();
            assert_eq!(&got[..], *want, "bucket {b}");
        }
    }

    #[test]
    fn dynstr_shares_a_suffix_with_a_longer_string() {
        // ld stores `clock_gettime` inside `__vdso_clock_gettime`.
        let t = StrTab::build(&["__vdso_clock_gettime", "clock_gettime"]);
        let long = t.offset_of("__vdso_clock_gettime");
        let short = t.offset_of("clock_gettime");
        assert_eq!(short, long + "__vdso_".len() as u32);
        assert_eq!(t.bytes().len(), 1 + "__vdso_clock_gettime".len() + 1);
    }
}
