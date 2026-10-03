//! `__TEXT,__unwind_info`: the compact unwind table libunwind searches for
//! the encoding that unwinds a function, in the version 1 layout ld64
//! writes.

use alloc::vec::Vec;

/// arm64 modes: a frame record at x29 and no saved pair; no frame and no
/// stack; the DWARF FDE at the `__eh_frame` offset in the low 24 bits.
pub(crate) const UNWIND_ARM64_MODE_FRAME: u32 = 0x0400_0000;
pub(crate) const UNWIND_ARM64_MODE_FRAMELESS: u32 = 0x0200_0000;
pub(crate) const UNWIND_ARM64_MODE_DWARF: u32 = 0x0300_0000;
pub(crate) const UNWIND_ARM64_MODE_MASK: u32 = 0x0F00_0000;
pub(crate) const UNWIND_ARM64_DWARF_SECTION_OFFSET: u32 = 0x00FF_FFFF;
/// Bits every mode shares: an LSDA index entry exists for the function,
/// and the 1-based index of its personality routine's slot.
pub(crate) const UNWIND_HAS_LSDA: u32 = 0x4000_0000;
pub(crate) const UNWIND_PERSONALITY_MASK: u32 = 0x3000_0000;
/// The personality index field holds 1 to 3.
pub(crate) const MAX_PERSONALITIES: usize = 3;

const UNWIND_SECTION_VERSION: u32 = 1;
const UNWIND_SECOND_LEVEL_REGULAR: u32 = 2;
const HEADER_SIZE: usize = 28;
const INDEX_ENTRY_SIZE: usize = 12;
const LSDA_ENTRY_SIZE: usize = 8;
const PAGE_HEADER_SIZE: usize = 8;
const PAGE_ENTRY_SIZE: usize = 8;
/// The entries one regular page holds within ld64's 4 KiB pages.
const PAGE_ENTRIES: usize = (4096 - PAGE_HEADER_SIZE) / PAGE_ENTRY_SIZE;

/// A function's encoding and LSDA, at offsets from the image's Mach
/// header. An encoding of 0 states that the function has no unwind
/// information.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct UnwindEntry {
    pub offset: u32,
    pub encoding: u32,
    pub lsda: Option<u32>,
}

/// The section's size for `n` entries, `personalities` slots and `lsdas`
/// entries with an LSDA.
pub(crate) fn size(n: usize, personalities: usize, lsdas: usize) -> usize {
    let pages = n.div_ceil(PAGE_ENTRIES);
    HEADER_SIZE
        + 4 * personalities
        + INDEX_ENTRY_SIZE * (pages + 1)
        + LSDA_ENTRY_SIZE * lsdas
        + pages * PAGE_HEADER_SIZE
        + n * PAGE_ENTRY_SIZE
}

/// The section for `entries`, sorted by offset and ending at `end`, and the
/// personality slots their encodings index: no common encodings, the slots,
/// a first-level index of the regular pages and the sentinel, the LSDA
/// index, then the pages.
pub(crate) fn build(entries: &[UnwindEntry], personalities: &[u32], end: u32) -> Vec<u8> {
    let pages: Vec<&[UnwindEntry]> = entries.chunks(PAGE_ENTRIES).collect();
    let personality_off = HEADER_SIZE;
    let index_off = personality_off + 4 * personalities.len();
    let lsda_off = index_off + INDEX_ENTRY_SIZE * (pages.len() + 1);
    let lsdas = entries.iter().filter(|e| e.lsda.is_some()).count();
    let pages_off = lsda_off + LSDA_ENTRY_SIZE * lsdas;
    let mut out = Vec::with_capacity(size(entries.len(), personalities.len(), lsdas));
    let put = |out: &mut Vec<u8>, v: u32| out.extend_from_slice(&v.to_le_bytes());
    for v in [
        UNWIND_SECTION_VERSION,
        HEADER_SIZE as u32,
        0,
        personality_off as u32,
        personalities.len() as u32,
        index_off as u32,
        pages.len() as u32 + 1,
    ] {
        put(&mut out, v);
    }
    for &p in personalities {
        put(&mut out, p);
    }
    let (mut page_off, mut lsda_at) = (pages_off, lsda_off);
    for page in &pages {
        put(&mut out, page[0].offset);
        put(&mut out, page_off as u32);
        put(&mut out, lsda_at as u32);
        page_off += PAGE_HEADER_SIZE + page.len() * PAGE_ENTRY_SIZE;
        lsda_at += LSDA_ENTRY_SIZE * page.iter().filter(|e| e.lsda.is_some()).count();
    }
    put(&mut out, end);
    put(&mut out, 0);
    put(&mut out, lsda_at as u32);
    for e in entries {
        if let Some(lsda) = e.lsda {
            put(&mut out, e.offset);
            put(&mut out, lsda);
        }
    }
    for page in &pages {
        put(&mut out, UNWIND_SECOND_LEVEL_REGULAR);
        out.extend_from_slice(&(PAGE_HEADER_SIZE as u16).to_le_bytes());
        out.extend_from_slice(&(page.len() as u16).to_le_bytes());
        for e in *page {
            put(&mut out, e.offset);
            put(&mut out, e.encoding);
        }
    }
    out
}

/// libunwind's search, for tests: the entry covering `pc`, with its LSDA;
/// `None` outside the table.
#[cfg(test)]
pub(crate) fn lookup(section: &[u8], pc: u32) -> Option<UnwindEntry> {
    let u32_at = |at: usize| u32::from_le_bytes(section[at..at + 4].try_into().unwrap());
    assert_eq!(u32_at(0), UNWIND_SECTION_VERSION);
    let (index, count) = (u32_at(20) as usize, u32_at(24) as usize);
    let entry = |i: usize| index + i * INDEX_ENTRY_SIZE;
    let first = (0..count - 1)
        .rev()
        .find(|&i| u32_at(entry(i)) <= pc && pc < u32_at(entry(i + 1)))?;
    let page = u32_at(entry(first) + 4) as usize;
    assert_eq!(u32_at(page), UNWIND_SECOND_LEVEL_REGULAR);
    let n = u16::from_le_bytes(section[page + 6..page + 8].try_into().unwrap()) as usize;
    let at = |k: usize| page + PAGE_HEADER_SIZE + k * PAGE_ENTRY_SIZE;
    let k = (0..n).rev().find(|&k| u32_at(at(k)) <= pc)?;
    let (offset, encoding) = (u32_at(at(k)), u32_at(at(k) + 4));
    let lsda = (encoding & UNWIND_HAS_LSDA != 0).then(|| {
        let (from, to) = (u32_at(entry(first) + 8), u32_at(entry(first + 1) + 8));
        let hit = (from..to)
            .step_by(LSDA_ENTRY_SIZE)
            .find(|&e| u32_at(e as usize) == offset)
            .expect("an LSDA index entry for the function");
        u32_at(hit as usize + 4)
    });
    Some(UnwindEntry {
        offset,
        encoding,
        lsda,
    })
}

/// The personality slot offset an encoding names, for tests.
#[cfg(test)]
pub(crate) fn personality(section: &[u8], encoding: u32) -> Option<u32> {
    let index = (encoding & UNWIND_PERSONALITY_MASK) >> 28;
    let u32_at = |at: usize| u32::from_le_bytes(section[at..at + 4].try_into().unwrap());
    (index != 0).then(|| {
        assert!(index <= u32_at(16), "personality {index} past the array");
        u32_at(u32_at(12) as usize + 4 * (index as usize - 1))
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    fn u32_at(b: &[u8], at: usize) -> u32 {
        u32::from_le_bytes(b[at..at + 4].try_into().unwrap())
    }

    fn entry(offset: u32, encoding: u32) -> UnwindEntry {
        UnwindEntry {
            offset,
            encoding,
            lsda: None,
        }
    }

    #[test]
    fn each_function_reads_its_own_encoding() {
        let entries = [
            entry(0x1000, UNWIND_ARM64_MODE_FRAME),
            entry(0x1040, UNWIND_ARM64_MODE_FRAMELESS),
            entry(0x1080, 0),
        ];
        let s = build(&entries, &[], 0x10c0);
        assert_eq!(s.len(), size(entries.len(), 0, 0));
        let encoding = |pc| lookup(&s, pc).map(|e| e.encoding);
        assert_eq!(encoding(0x0fff), None);
        assert_eq!(encoding(0x1000), Some(UNWIND_ARM64_MODE_FRAME));
        assert_eq!(encoding(0x103c), Some(UNWIND_ARM64_MODE_FRAME));
        assert_eq!(encoding(0x1040), Some(UNWIND_ARM64_MODE_FRAMELESS));
        assert_eq!(encoding(0x10bc), Some(0));
        assert_eq!(encoding(0x10c0), None, "the sentinel ends the table");
    }

    /// Functions past a page's capacity take a second page, which the
    /// first-level index finds with its own LSDA range.
    #[test]
    fn functions_past_a_page_take_the_next() {
        let entries: Vec<UnwindEntry> = (0..PAGE_ENTRIES as u32 + 10)
            .map(|i| UnwindEntry {
                offset: 0x4000 + 16 * i,
                encoding: UNWIND_ARM64_MODE_FRAME
                    | i
                    | if i % 7 == 0 { UNWIND_HAS_LSDA } else { 0 },
                lsda: (i % 7 == 0).then_some(0x9000 + i),
            })
            .collect();
        let end = 0x4000 + 16 * entries.len() as u32;
        let lsdas = entries.iter().filter(|e| e.lsda.is_some()).count();
        let s = build(&entries, &[], end);
        assert_eq!(s.len(), size(entries.len(), 0, lsdas));
        assert_eq!(u32_at(&s, 24), 3, "two pages and the sentinel");
        for (i, e) in entries.iter().enumerate() {
            assert_eq!(lookup(&s, e.offset + 4), Some(*e), "function {i}");
        }
        assert_eq!(lookup(&s, end), None);
    }

    /// An encoding's personality index names its slot in the array.
    #[test]
    fn personality_index_names_the_slot() {
        let entries = [
            entry(0x1000, UNWIND_ARM64_MODE_FRAME | (2 << 28)),
            entry(0x1040, UNWIND_ARM64_MODE_FRAME | (1 << 28)),
            entry(0x1080, UNWIND_ARM64_MODE_FRAME),
        ];
        let s = build(&entries, &[0x8000, 0x8010], 0x10c0);
        assert_eq!(s.len(), size(entries.len(), 2, 0));
        let slot = |pc| personality(&s, lookup(&s, pc).unwrap().encoding);
        assert_eq!(slot(0x1000), Some(0x8010));
        assert_eq!(slot(0x1040), Some(0x8000));
        assert_eq!(slot(0x1080), None);
    }
}
