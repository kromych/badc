//! A program database for a PE image: the MSF container and the PDB
//! info, TPI, IPI, DBI, module, global, public and symbol-record streams,
//! as `llvm/docs/PDB` and Microsoft's `microsoft-pdb` sources lay them
//! out. One DBI module describes each compilation unit of the debug model.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use super::Machine;
use super::codeview::{
    self, AddressMap, LF_ENUM, LF_STRUCTURE, LF_UNION, Names, Rec, S_LPROCREF, S_PROCREF, S_PUB32,
    Types,
};
use super::debug_model::DebugInfo;

const BLOCK_SIZE: usize = 4096;
const MSF_MAGIC: &[u8; 32] = b"Microsoft C/C++ MSF 7.00\r\n\x1aDS\0\0\0";

// Fixed stream numbers, then the ones this writer assigns.
const STREAM_PDB: usize = 1;
const STREAM_TPI: usize = 2;
const STREAM_DBI: usize = 3;
const STREAM_IPI: usize = 4;
const STREAM_NAMES: usize = 5;
const STREAM_TPI_HASH: usize = 6;
const STREAM_IPI_HASH: usize = 7;
const STREAM_GLOBALS: usize = 8;
const STREAM_PUBLICS: usize = 9;
const STREAM_SYMBOLS: usize = 10;
const STREAM_SECTION_HEADERS: usize = 11;
const FIRST_MODULE_STREAM: usize = 12;

const PDB_VERSION_VC70: u32 = 20000404;
const PDB_FEATURE_VC140: u32 = 20140508;
const TPI_VERSION_V80: u32 = 20040203;
const TPI_HEADER_SIZE: u32 = 56;
const TPI_HASH_BUCKETS: u32 = 0x3ffff;
const DBI_VERSION_V70: u32 = 19990903;
/// `(1 << 15)` marks the new format, then toolset 14.11.
const DBI_BUILD_NUMBER: u16 = 0x8e0b;
const SECTION_CONTRIB_V60: u32 = 0xeffe_0000 + 19970605;
const GSI_HASH_V70: u32 = 0xeffe_0000 + 19990810;
const GSI_BUCKETS: usize = 4096;
const NAMES_SIGNATURE: u32 = 0xeffe_effe;
const C13_SIGNATURE: u32 = 4;
/// `CV_PUBSYMFLAGS` `fFunction`.
const PUBLIC_FUNCTION: u32 = 2;

/// A public symbol at its virtual address.
pub(crate) struct Public {
    pub name: String,
    pub va: u64,
    pub function: bool,
}

/// What the image contributes: its section table (the 40-byte
/// `IMAGE_SECTION_HEADER`s) and its public symbols.
pub(crate) struct Image {
    pub machine: Machine,
    pub image_base: u64,
    pub sections: Vec<[u8; 40]>,
    pub publics: Vec<Public>,
}

pub(crate) struct Pdb {
    pub bytes: Vec<u8>,
    pub guid: [u8; 16],
    pub age: u32,
}

impl Image {
    fn section(&self, i: usize) -> (u32, u32, u32) {
        let h = &self.sections[i];
        let at = |o: usize| u32::from_le_bytes(h[o..o + 4].try_into().unwrap());
        (at(12), at(8), at(36))
    }
}

impl AddressMap for Image {
    fn locate(&self, va: u64) -> Option<(u16, u32)> {
        let rva = u32::try_from(va.checked_sub(self.image_base)?).ok()?;
        (0..self.sections.len()).find_map(|i| {
            let (start, size, _) = self.section(i);
            (rva >= start && rva - start < size.max(1)).then(|| ((i + 1) as u16, rva - start))
        })
    }
}

/// The 32-bit string hash of the PDB name tables and the GSI
/// (`hashStringV1`, `microsoft-pdb` `misc.h` `Hasher::lhashPbCb`).
pub(crate) fn hash_v1(s: &[u8]) -> u32 {
    let mut h: u32 = 0;
    let (words, rest) = s.as_chunks::<4>();
    for w in words {
        h ^= u32::from_le_bytes(*w);
    }
    let mut rest = rest;
    if rest.len() >= 2 {
        h ^= u32::from(u16::from_le_bytes([rest[0], rest[1]]));
        rest = &rest[2..];
    }
    if let Some(&b) = rest.first() {
        h ^= u32::from(b);
    }
    h |= 0x2020_2020;
    h ^= h >> 11;
    h ^ (h >> 16)
}

/// CRC-32 (the reflected 0xEDB88320 polynomial) from a zero register with
/// no final inversion, which hashes TPI records (`hashBufferV8`).
pub(crate) fn crc32_v8(data: &[u8]) -> u32 {
    let mut crc: u32 = 0;
    for &b in data {
        crc ^= u32::from(b);
        for _ in 0..8 {
            crc = (crc >> 1) ^ (0xedb8_8320 & 0u32.wrapping_sub(crc & 1));
        }
    }
    crc
}

/// The `/names` string table: each string once, from offset 1.
pub(crate) struct StringTable {
    bytes: Vec<u8>,
    offsets: BTreeMap<String, u32>,
}

impl StringTable {
    pub(crate) fn new() -> Self {
        StringTable {
            bytes: vec![0],
            offsets: BTreeMap::new(),
        }
    }

    /// The PDB string table stream: header, strings, the hash table the
    /// reference implementation grows by 3/2 at 3/4 load, the count.
    pub(crate) fn serialize(&self) -> Vec<u8> {
        let mut buckets = 1usize;
        for count in 1..=self.offsets.len() {
            if buckets * 3 / 4 < count {
                buckets = buckets * 3 / 2 + 1;
            }
        }
        let mut table = vec![0u32; buckets];
        for (s, &off) in &self.offsets {
            let h = hash_v1(s.as_bytes()) as usize;
            if let Some(slot) = (0..buckets)
                .map(|i| (h + i) % buckets)
                .find(|&k| table[k] == 0)
            {
                table[slot] = off;
            }
        }
        let mut r = Rec::default();
        r.u32(NAMES_SIGNATURE).u32(1).u32(self.bytes.len() as u32);
        r.0.extend_from_slice(&self.bytes);
        r.u32(buckets as u32);
        for b in table {
            r.u32(b);
        }
        r.u32(self.offsets.len() as u32);
        r.0
    }
}

impl Names for StringTable {
    fn intern(&mut self, s: &str) -> u32 {
        if let Some(&o) = self.offsets.get(s) {
            return o;
        }
        let o = self.bytes.len() as u32;
        self.bytes.extend_from_slice(s.as_bytes());
        self.bytes.push(0);
        self.offsets.insert(String::from(s), o);
        o
    }
}

/// The PDB of `info` for `image`. Its GUID is the leading 16 bytes of the
/// SHA-1 of the streams, so the same inputs give the same file.
pub(crate) fn write(info: &DebugInfo, image: &Image) -> Pdb {
    let mut names = StringTable::new();
    let mut types = Types::new(info, 8);
    let mut modules = Vec::new();
    for unit in &info.units {
        let syms = codeview::module_symbols(unit, &mut types, image, image.machine);
        let (c13, files) = codeview::line_subsections(unit, image, &mut names);
        modules.push((unit, syms, c13, files));
    }

    // The globals stream's records, then the publics', in one record
    // stream; a typedef several units declare is stored once.
    let mut records = Vec::new();
    let mut globals = Vec::new();
    let mut seen: BTreeSet<Vec<u8>> = BTreeSet::new();
    let push_record = |records: &mut Vec<u8>, rec: &[u8]| -> u32 {
        records.extend_from_slice(rec);
        (records.len() - rec.len()) as u32
    };
    for (k, (_, syms, _, _)) in modules.iter().enumerate() {
        for (name, at, external) in &syms.procs {
            let mut r = Rec::default();
            r.u32(0).u32(*at).u16((k + 1) as u16).name(name);
            let kind = if *external { S_PROCREF } else { S_LPROCREF };
            let off = push_record(&mut records, &codeview::symbol_record(kind, &r.0));
            globals.push((name.clone(), off));
        }
        for rec in &syms.globals {
            if seen.insert(rec.clone()) {
                let off = push_record(&mut records, rec);
                globals.push((record_name(rec), off));
            }
        }
    }
    let mut publics: Vec<(String, u32, u16, u32)> = Vec::new();
    let mut sorted: Vec<&Public> = image.publics.iter().collect();
    sorted.sort_by(|a, b| a.name.cmp(&b.name));
    for p in sorted {
        let Some((seg, off)) = image.locate(p.va) else {
            continue;
        };
        let mut r = Rec::default();
        let flags = if p.function { PUBLIC_FUNCTION } else { 0 };
        r.u32(flags).u32(off).u16(seg).name(&p.name);
        let at = push_record(&mut records, &codeview::symbol_record(S_PUB32, &r.0));
        publics.push((p.name.clone(), at, seg, off));
    }

    let mut streams: Vec<Vec<u8>> = vec![Vec::new(); FIRST_MODULE_STREAM + modules.len()];
    let (tpi, tpi_hash) = type_stream(&types.tpi.records, STREAM_TPI_HASH as u16);
    let (ipi, ipi_hash) = type_stream(&types.ipi.records, STREAM_IPI_HASH as u16);
    streams[STREAM_TPI] = tpi;
    streams[STREAM_TPI_HASH] = tpi_hash;
    streams[STREAM_IPI] = ipi;
    streams[STREAM_IPI_HASH] = ipi_hash;
    streams[STREAM_GLOBALS] = gsi_hash(&globals);
    streams[STREAM_PUBLICS] = publics_stream(&publics);
    streams[STREAM_SYMBOLS] = records;
    streams[STREAM_SECTION_HEADERS] = image.sections.concat();
    let mut dbi = DbiInputs::default();
    for (k, (unit, syms, c13, files)) in modules.iter().enumerate() {
        let mut s = Rec::default();
        s.u32(C13_SIGNATURE);
        s.0.extend_from_slice(&syms.symbols);
        let sym_bytes = s.0.len() as u32;
        s.0.extend_from_slice(c13);
        s.u32(0); // global references
        streams[FIRST_MODULE_STREAM + k] = s.0;
        dbi.modules.push(DbiModule {
            name: unit.name.clone(),
            stream: (FIRST_MODULE_STREAM + k) as u16,
            sym_bytes,
            c13_bytes: c13.len() as u32,
            files: files.clone(),
            contributions: coalesce(&syms.contributions),
        });
    }
    streams[STREAM_DBI] = dbi_stream(&dbi, image);
    streams[STREAM_NAMES] = names.serialize();

    let age = 1;
    streams[STREAM_PDB] = info_stream([0; 16], 0, age);
    let digest = super::sha1::sha1(&streams.concat());
    let mut guid = [0u8; 16];
    guid.copy_from_slice(&digest[..16]);
    let signature = u32::from_le_bytes(digest[16..20].try_into().unwrap());
    streams[STREAM_PDB] = info_stream(guid, signature, age);
    Pdb {
        bytes: msf(&streams),
        guid,
        age,
    }
}

/// A record's name: the string after its fixed fields.
fn record_name(rec: &[u8]) -> String {
    let kind = u16::from_le_bytes([rec[2], rec[3]]);
    // S_UDT: type; S_[LG]DATA32: type, offset, segment.
    let at = if kind == codeview::S_UDT { 8 } else { 14 };
    let tail = rec.get(at..).unwrap_or_default();
    let n = tail.iter().position(|&c| c == 0).unwrap_or(tail.len());
    String::from_utf8_lossy(&tail[..n]).into_owned()
}

/// Adjacent code ranges of one module as one contribution.
fn coalesce(ranges: &[(u16, u32, u32)]) -> Vec<(u16, u32, u32)> {
    let mut sorted = ranges.to_vec();
    sorted.sort_unstable();
    let mut out: Vec<(u16, u32, u32)> = Vec::new();
    for (seg, off, size) in sorted {
        match out.last_mut() {
            Some(last) if last.0 == seg && last.1 + last.2 == off => last.2 += size,
            _ => out.push((seg, off, size)),
        }
    }
    out
}

fn info_stream(guid: [u8; 16], signature: u32, age: u32) -> Vec<u8> {
    let mut r = Rec::default();
    r.u32(PDB_VERSION_VC70).u32(signature).u32(age);
    r.0.extend_from_slice(&guid);
    // The named stream map: its string data, then a hash table of
    // capacity 8 keyed by the 16-bit name hash, holding `/names`.
    let name = b"/names\0";
    r.u32(name.len() as u32);
    r.0.extend_from_slice(name);
    let capacity = 8u32;
    let bucket = u32::from(hash_v1(b"/names") as u16) % capacity;
    r.u32(1).u32(capacity);
    r.u32(1).u32(1 << bucket); // present buckets
    r.u32(0); // deleted buckets
    r.u32(0).u32(STREAM_NAMES as u32);
    r.u32(0);
    r.u32(PDB_FEATURE_VC140);
    r.0
}

/// A TPI or IPI stream and its hash stream.
fn type_stream(records: &[Vec<u8>], hash_stream: u16) -> (Vec<u8>, Vec<u8>) {
    let bytes: usize = records.iter().map(Vec::len).sum();
    let mut hashes = Rec::default();
    let mut offsets = Rec::default();
    let mut at = 0usize;
    for (k, rec) in records.iter().enumerate() {
        if k == 0 || (at + rec.len()) / 8192 > at / 8192 {
            offsets
                .u32(codeview::FIRST_TYPE_INDEX + k as u32)
                .u32(at as u32);
        }
        hashes.u32(type_hash(rec) % TPI_HASH_BUCKETS);
        at += rec.len();
    }
    let mut r = Rec::default();
    r.u32(TPI_VERSION_V80).u32(TPI_HEADER_SIZE);
    r.u32(codeview::FIRST_TYPE_INDEX);
    r.u32(codeview::FIRST_TYPE_INDEX + records.len() as u32);
    r.u32(bytes as u32).u16(hash_stream).u16(0xffff);
    r.u32(4).u32(TPI_HASH_BUCKETS);
    let hash_len = hashes.0.len() as u32;
    let offsets_len = offsets.0.len() as u32;
    r.u32(0).u32(hash_len);
    r.u32(hash_len).u32(offsets_len);
    r.u32(hash_len + offsets_len).u32(0);
    for rec in records {
        r.0.extend_from_slice(rec);
    }
    hashes.0.extend_from_slice(&offsets.0);
    (r.0, hashes.0)
}

/// A type record's hash: a defined structure, union or enum hashes its
/// name, so a forward reference resolves by name; any other record hashes
/// its bytes.
fn type_hash(rec: &[u8]) -> u32 {
    let kind = u16::from_le_bytes([rec[2], rec[3]]);
    let prop = rec
        .get(6..8)
        .map_or(0, |p| u16::from_le_bytes([p[0], p[1]]));
    let name_at = match kind {
        LF_STRUCTURE => skip_numeric(rec, 20),
        LF_UNION => skip_numeric(rec, 12),
        LF_ENUM => Some(16),
        _ => None,
    };
    if let Some(at) = name_at
        && prop & 0x0180 == 0
    {
        let tail = &rec[at.min(rec.len())..];
        let n = tail.iter().position(|&c| c == 0).unwrap_or(tail.len());
        return hash_v1(&tail[..n]);
    }
    crc32_v8(rec)
}

/// The offset past the numeric leaf at `at`.
fn skip_numeric(rec: &[u8], at: usize) -> Option<usize> {
    let v = u16::from_le_bytes(rec.get(at..at + 2)?.try_into().ok()?);
    Some(
        at + 2
            + match v {
                0..0x8000 => 0,
                0x8000 => 1,
                0x8001 | 0x8002 => 2,
                0x8003 | 0x8004 => 4,
                0x8009 | 0x800a => 8,
                _ => return None,
            },
    )
}

/// The GSI ordering of names within a hash bucket: shorter first, then
/// ASCII case-insensitively, else bytewise.
fn gsi_name_cmp(a: &str, b: &str) -> core::cmp::Ordering {
    a.len().cmp(&b.len()).then_with(|| {
        if a.is_ascii() && b.is_ascii() {
            let lower = |s: &str| {
                s.bytes()
                    .map(|c| c.to_ascii_lowercase())
                    .collect::<Vec<_>>()
            };
            lower(a).cmp(&lower(b))
        } else {
            a.as_bytes().cmp(b.as_bytes())
        }
    })
}

/// A GSI hash table over `(name, record offset)` pairs: the header, the
/// records by bucket, the bucket bitmap and each bucket's start as the
/// reference implementation's 12-byte-record offset.
fn gsi_hash(entries: &[(String, u32)]) -> Vec<u8> {
    let mut buckets: Vec<Vec<(&str, u32)>> = vec![Vec::new(); GSI_BUCKETS];
    for (name, off) in entries {
        buckets[hash_v1(name.as_bytes()) as usize % GSI_BUCKETS].push((name, *off));
    }
    let mut records = Rec::default();
    let mut bitmap = vec![0u32; (GSI_BUCKETS + 32) / 32];
    let mut starts = Rec::default();
    let mut count = 0u32;
    for (i, b) in buckets.iter_mut().enumerate() {
        if b.is_empty() {
            continue;
        }
        b.sort_by(|x, y| gsi_name_cmp(x.0, y.0).then(x.1.cmp(&y.1)));
        bitmap[i / 32] |= 1 << (i % 32);
        starts.u32(count * 12);
        for &(_, off) in b.iter() {
            records.u32(off + 1).u32(1);
            count += 1;
        }
    }
    let mut r = Rec::default();
    r.u32(0xffff_ffff)
        .u32(GSI_HASH_V70)
        .u32(records.0.len() as u32);
    r.u32((bitmap.len() * 4 + starts.0.len()) as u32);
    r.0.extend_from_slice(&records.0);
    for w in bitmap {
        r.u32(w);
    }
    r.0.extend_from_slice(&starts.0);
    r.0
}

/// The publics stream: its header, the GSI hash and the address map of
/// record offsets by section and offset.
fn publics_stream(publics: &[(String, u32, u16, u32)]) -> Vec<u8> {
    let hash = gsi_hash(
        &(publics.iter())
            .map(|p| (p.0.clone(), p.1))
            .collect::<Vec<_>>(),
    );
    let mut by_addr: Vec<&(String, u32, u16, u32)> = publics.iter().collect();
    by_addr.sort_by(|a, b| (a.2, a.3, &a.0).cmp(&(b.2, b.3, &b.0)));
    let mut r = Rec::default();
    r.u32(hash.len() as u32).u32(4 * publics.len() as u32);
    r.u32(0).u32(0).u16(0).u16(0).u32(0).u32(0);
    r.0.extend_from_slice(&hash);
    for p in by_addr {
        r.u32(p.1);
    }
    r.0
}

#[derive(Default)]
struct DbiInputs {
    modules: Vec<DbiModule>,
}

struct DbiModule {
    name: String,
    stream: u16,
    sym_bytes: u32,
    c13_bytes: u32,
    files: Vec<String>,
    contributions: Vec<(u16, u32, u32)>,
}

/// A 28-byte `SectionContrib`.
fn section_contrib(r: &mut Rec, image: &Image, c: Option<(u16, u32, u32)>, module: u16) {
    let Some((seg, off, size)) = c else {
        r.0.extend_from_slice(&[0; 28]);
        return;
    };
    let (_, _, characteristics) = image.section(usize::from(seg) - 1);
    r.u16(seg).u16(0).u32(off).u32(size).u32(characteristics);
    r.u16(module).u16(0).u32(0).u32(0);
}

fn dbi_stream(dbi: &DbiInputs, image: &Image) -> Vec<u8> {
    // Module info: a `ModuleInfoHeader` per module, its module and object
    // names, 4-byte aligned.
    let mut modi = Rec::default();
    for (k, m) in dbi.modules.iter().enumerate() {
        modi.u32(k as u32);
        section_contrib(&mut modi, image, m.contributions.first().copied(), k as u16);
        modi.u16(0)
            .u16(m.stream)
            .u32(m.sym_bytes)
            .u32(0)
            .u32(m.c13_bytes);
        modi.u16(m.files.len() as u16).u16(0).u32(0).u32(0).u32(0);
        modi.name(&m.name).name(&m.name);
        modi.0.resize(modi.0.len().next_multiple_of(4), 0);
    }
    let mut contribs: Vec<(u16, u32, u32, u16)> = Vec::new();
    for (k, m) in dbi.modules.iter().enumerate() {
        contribs.extend(m.contributions.iter().map(|&(s, o, n)| (s, o, n, k as u16)));
    }
    contribs.sort_unstable();
    let mut sc = Rec::default();
    sc.u32(SECTION_CONTRIB_V60);
    for (s, o, n, k) in contribs {
        section_contrib(&mut sc, image, Some((s, o, n)), k);
    }
    // The section map: one entry per section, then the absolute pseudo
    // section (`OMFSegDesc`: read, write, execute, 32-bit, selector).
    let count = image.sections.len() as u16 + 1;
    let mut map = Rec::default();
    map.u16(count).u16(count);
    for i in 0..image.sections.len() {
        let (_, size, ch) = image.section(i);
        let mut flags = 0x0108u16;
        flags |= u16::from(ch & 0x4000_0000 != 0);
        flags |= u16::from(ch & 0x8000_0000 != 0) << 1;
        flags |= u16::from(ch & 0x2000_0000 != 0) << 2;
        map.u16(flags)
            .u16(0)
            .u16(0)
            .u16((i + 1) as u16)
            .u16(0xffff)
            .u16(0xffff);
        map.u32(0).u32(size);
    }
    map.u16(0x0208)
        .u16(0)
        .u16(0)
        .u16(count)
        .u16(0xffff)
        .u16(0xffff);
    map.u32(0).u32(u32::MAX);
    // File info: the module count, the file count, each module's first
    // file and file count, the name offsets and the names.
    let mut names: Vec<u8> = Vec::new();
    let mut name_at: BTreeMap<&str, u32> = BTreeMap::new();
    let mut fi = Rec::default();
    let total: usize = dbi.modules.iter().map(|m| m.files.len()).sum();
    fi.u16(dbi.modules.len() as u16).u16(total as u16);
    let mut first = 0u16;
    for m in &dbi.modules {
        fi.u16(first);
        first = first.wrapping_add(m.files.len() as u16);
    }
    for m in &dbi.modules {
        fi.u16(m.files.len() as u16);
    }
    for m in &dbi.modules {
        for f in &m.files {
            let at = *name_at.entry(f).or_insert_with(|| {
                let at = names.len() as u32;
                names.extend_from_slice(f.as_bytes());
                names.push(0);
                at
            });
            fi.u32(at);
        }
    }
    fi.0.extend_from_slice(&names);
    fi.0.resize(fi.0.len().next_multiple_of(4), 0);
    let ec = StringTable::new().serialize();
    let mut dbg = Rec::default();
    for k in 0..11 {
        dbg.u16(if k == 5 {
            STREAM_SECTION_HEADERS as u16
        } else {
            0xffff
        });
    }

    let mut r = Rec::default();
    r.u32(0xffff_ffff).u32(DBI_VERSION_V70).u32(1);
    r.u16(STREAM_GLOBALS as u16).u16(DBI_BUILD_NUMBER);
    r.u16(STREAM_PUBLICS as u16).u16(0);
    r.u16(STREAM_SYMBOLS as u16).u16(0);
    r.u32(modi.0.len() as u32).u32(sc.0.len() as u32);
    r.u32(map.0.len() as u32).u32(fi.0.len() as u32);
    r.u32(0).u32(0); // type server map, MFC type server
    r.u32(dbg.0.len() as u32).u32(ec.len() as u32);
    r.u16(0).u16(match image.machine {
        Machine::X86_64 => 0x8664,
        Machine::Aarch64 => 0xaa64,
    });
    r.u32(0);
    for part in [&modi.0, &sc.0, &map.0, &fi.0, &ec, &dbg.0] {
        r.0.extend_from_slice(part);
    }
    r.0
}

/// The MSF container of `streams`: the superblock, the free block maps
/// at blocks 1 and 2 of every 4096-block interval, each stream's blocks,
/// the stream directory and the block holding the directory's block list.
fn msf(streams: &[Vec<u8>]) -> Vec<u8> {
    let mut next = 3usize;
    let mut alloc = |n: usize| -> Vec<u32> {
        (0..n)
            .map(|_| {
                while matches!(next % BLOCK_SIZE, 1 | 2) {
                    next += 1;
                }
                next += 1;
                (next - 1) as u32
            })
            .collect()
    };
    let blocks_of = |len: usize| len.div_ceil(BLOCK_SIZE);
    let stream_blocks: Vec<Vec<u32>> = streams.iter().map(|s| alloc(blocks_of(s.len()))).collect();
    let mut dir = Rec::default();
    dir.u32(streams.len() as u32);
    for s in streams {
        dir.u32(s.len() as u32);
    }
    for b in stream_blocks.iter().flatten() {
        dir.u32(*b);
    }
    let dir_blocks = alloc(blocks_of(dir.0.len()));
    let map_block = alloc(1)[0];
    let num_blocks = next;
    let mut out = vec![0u8; num_blocks * BLOCK_SIZE];
    let mut put = |blocks: &[u32], data: &[u8]| {
        for (b, chunk) in blocks.iter().zip(data.chunks(BLOCK_SIZE)) {
            let at = *b as usize * BLOCK_SIZE;
            out[at..at + chunk.len()].copy_from_slice(chunk);
        }
    };
    for (blocks, s) in stream_blocks.iter().zip(streams) {
        put(blocks, s);
    }
    put(&dir_blocks, &dir.0);
    let list: Vec<u8> = dir_blocks.iter().flat_map(|b| b.to_le_bytes()).collect();
    put(&[map_block], &list);
    let mut sb = Rec::default();
    sb.0.extend_from_slice(MSF_MAGIC);
    sb.u32(BLOCK_SIZE as u32).u32(1).u32(num_blocks as u32);
    sb.u32(dir.0.len() as u32).u32(0).u32(map_block);
    put(&[0], &sb.0);
    // Every block is in use. The map's k-th block holds the bits of blocks
    // k * 32768 onwards; a bit past the last block marks it free.
    let bits = BLOCK_SIZE * 8;
    for k in 0..num_blocks.div_ceil(BLOCK_SIZE) {
        let mut fpm = vec![0xffu8; BLOCK_SIZE];
        for b in k * bits..num_blocks.min((k + 1) * bits) {
            fpm[(b / 8) % BLOCK_SIZE] &= !(1 << (b % 8));
        }
        for at in [k * BLOCK_SIZE + 1, k * BLOCK_SIZE + 2] {
            if at < num_blocks {
                out[at * BLOCK_SIZE..(at + 1) * BLOCK_SIZE].copy_from_slice(&fpm);
            }
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn hash_v1_folds_words_then_the_tail() {
        // A word and a 2-byte tail; a 2-byte tail alone; a word alone.
        assert_eq!(hash_v1(b"/names"), 0x6d6c_fc21);
        assert_eq!(hash_v1(b"ab"), 0x2024_4649);
        assert_eq!(hash_v1(b"main"), 0x6e64_c225);
    }

    #[test]
    fn crc32_v8_is_the_unreflected_register() {
        // The zlib CRC-32 of "123456789" is 0xCBF43926; from a zero
        // register with no final inversion the same bytes give 0x2DFD2D88.
        assert_eq!(crc32_v8(b"123456789"), 0x2dfd_2d88);
    }

    #[test]
    fn a_record_shorter_than_a_tag_record_hashes_its_bytes() {
        // The field list of a structure without members is its prefix alone.
        let empty = codeview::type_record(codeview::LF_FIELDLIST, &[]);
        assert_eq!(empty.len(), 4);
        assert_eq!(type_hash(&empty), crc32_v8(&empty));
    }

    #[test]
    fn the_string_table_hashes_each_name_to_its_bucket() {
        let mut t = StringTable::new();
        let a = t.intern("a.c");
        assert_eq!(a, 1);
        assert_eq!(t.intern("a.c"), 1);
        let bytes = t.serialize();
        assert_eq!(&bytes[0..4], &NAMES_SIGNATURE.to_le_bytes());
        // Header 12, strings "\0a.c\0" 5, two buckets, the count.
        assert_eq!(bytes.len(), 12 + 5 + 4 + 8 + 4);
        let bucket = hash_v1(b"a.c") as usize % 2;
        let slot = 12 + 5 + 4 + 4 * bucket;
        assert_eq!(&bytes[slot..slot + 4], &1u32.to_le_bytes());
    }

    #[test]
    fn the_container_reserves_the_free_block_maps() {
        let streams = vec![Vec::new(), vec![7u8; 5000]];
        let file = msf(&streams);
        assert_eq!(&file[..32], MSF_MAGIC);
        let word = |at: usize| u32::from_le_bytes(file[at..at + 4].try_into().unwrap());
        assert_eq!(word(32), BLOCK_SIZE as u32);
        let num_blocks = word(40) as usize;
        assert_eq!(file.len(), num_blocks * BLOCK_SIZE);
        // The stream's two blocks follow the free block maps.
        let map = word(52) as usize * BLOCK_SIZE;
        let dir = word(map) as usize * BLOCK_SIZE;
        assert_eq!((word(dir), word(dir + 4), word(dir + 8)), (2, 0, 5000));
        assert_eq!((word(dir + 12), word(dir + 16)), (3, 4));
        assert_eq!(file[3 * BLOCK_SIZE], 7);
        // Block 0 to the last are in use, the rest of the map free.
        assert_eq!(file[BLOCK_SIZE] & 1, 0);
        assert_eq!(
            file[BLOCK_SIZE + num_blocks / 8] >> (num_blocks % 8),
            0xff >> (num_blocks % 8)
        );
    }
}
