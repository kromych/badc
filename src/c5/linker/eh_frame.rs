//! `.eh_frame_hdr`: the binary-search table an unwinder uses to find
//! the FDE covering a program counter, built from the linked
//! `.eh_frame`. `--eh-frame-hdr` asks for it and `PT_GNU_EH_FRAME`
//! points at it.

#![cfg(feature = "std")]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

// DWARF pointer encodings, as they appear in a CIE's `R` augmentation.
const DW_EH_PE_OMIT: u8 = 0xff;
const DW_EH_PE_ABSPTR: u8 = 0x00;
const DW_EH_PE_UDATA2: u8 = 0x02;
const DW_EH_PE_UDATA4: u8 = 0x03;
const DW_EH_PE_UDATA8: u8 = 0x04;
const DW_EH_PE_SDATA2: u8 = 0x0a;
const DW_EH_PE_SDATA4: u8 = 0x0b;
const DW_EH_PE_SDATA8: u8 = 0x0c;
const DW_EH_PE_PCREL: u8 = 0x10;
const DW_EH_PE_DATAREL: u8 = 0x30;

/// One FDE: the address it describes and where it sits.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct FdeEntry {
    pub pc: u64,
    pub fde: u64,
}

fn u32_at(b: &[u8], i: usize) -> Option<u32> {
    Some(u32::from_le_bytes(b.get(i..i + 4)?.try_into().ok()?))
}

fn uleb(b: &[u8], i: &mut usize) -> Option<u64> {
    let (mut v, mut shift) = (0u64, 0u32);
    loop {
        let byte = *b.get(*i)?;
        *i += 1;
        if shift < 64 {
            v |= ((byte & 0x7f) as u64) << shift;
        } else if byte & 0x7f != 0 {
            return None; // more than 64 bits of value
        }
        if byte & 0x80 == 0 {
            return Some(v);
        }
        shift += 7;
    }
}

fn skip_sleb(b: &[u8], i: &mut usize) -> Option<()> {
    loop {
        let byte = *b.get(*i)?;
        *i += 1;
        if byte & 0x80 == 0 {
            return Some(());
        }
    }
}

/// Size in bytes of a pointer under `enc`, for the fixed-width forms.
fn enc_size(enc: u8) -> Option<usize> {
    match enc & 0x0f {
        DW_EH_PE_ABSPTR | DW_EH_PE_UDATA8 | DW_EH_PE_SDATA8 => Some(8),
        DW_EH_PE_UDATA2 | DW_EH_PE_SDATA2 => Some(2),
        DW_EH_PE_UDATA4 | DW_EH_PE_SDATA4 => Some(4),
        _ => None,
    }
}

/// Read a pointer encoded per `enc` at `off` within a section based at
/// `sec_addr`, returning the address it denotes.
fn read_ptr(data: &[u8], off: usize, enc: u8, sec_addr: u64) -> Option<u64> {
    let size = enc_size(enc)?;
    let raw = match (enc & 0x0f, size) {
        (DW_EH_PE_SDATA2, _) => i16::from_le_bytes(data.get(off..off + 2)?.try_into().ok()?) as i64,
        (DW_EH_PE_SDATA4, _) => i32::from_le_bytes(data.get(off..off + 4)?.try_into().ok()?) as i64,
        (_, 2) => u16::from_le_bytes(data.get(off..off + 2)?.try_into().ok()?) as i64,
        (_, 4) => u32::from_le_bytes(data.get(off..off + 4)?.try_into().ok()?) as i64,
        (_, 8) => u64::from_le_bytes(data.get(off..off + 8)?.try_into().ok()?) as i64,
        _ => return None,
    };
    match enc & 0x70 {
        DW_EH_PE_PCREL => Some((sec_addr + off as u64).wrapping_add(raw as u64)),
        DW_EH_PE_DATAREL => Some(sec_addr.wrapping_add(raw as u64)),
        0 => Some(raw as u64),
        _ => None,
    }
}

/// The `R` (FDE pointer) encoding a CIE declares, or `DW_EH_PE_ABSPTR`
/// when it declares none.
fn cie_fde_encoding(data: &[u8], cie_at: usize, end: usize) -> Result<u8, String> {
    let bad = |what: &str| Err(format!(".eh_frame: {what}"));
    let mut i = cie_at + 8; // length, CIE id
    let version = *data
        .get(i)
        .ok_or_else(|| bad("truncated CIE").unwrap_err())?;
    i += 1;
    if version != 1 && version != 3 {
        return bad(&format!("CIE version {version} is not supported"));
    }
    let aug_start = i;
    while *data.get(i).unwrap_or(&0) != 0 {
        i += 1;
    }
    let aug = &data[aug_start..i];
    i += 1;
    if !aug.starts_with(b"z") {
        // No augmentation data: the FDE pointer is an absolute address.
        return Ok(DW_EH_PE_ABSPTR);
    }
    let mut j = i;
    uleb(data, &mut j).ok_or_else(|| bad("truncated code alignment").unwrap_err())?;
    skip_sleb(data, &mut j).ok_or_else(|| bad("truncated data alignment").unwrap_err())?;
    if version == 1 {
        j += 1;
    } else {
        uleb(data, &mut j).ok_or_else(|| bad("truncated return column").unwrap_err())?;
    }
    let aug_len = uleb(data, &mut j).ok_or_else(|| bad("truncated augmentation").unwrap_err())?;
    let aug_end = j + aug_len as usize;
    if aug_end > end {
        return bad("augmentation data runs past the CIE");
    }
    for &c in &aug[1..] {
        match c {
            b'R' => return Ok(*data.get(j).unwrap_or(&DW_EH_PE_ABSPTR)),
            b'L' => j += 1,
            b'P' => {
                let enc = *data
                    .get(j)
                    .ok_or_else(|| bad("truncated `P`").unwrap_err())?;
                j += 1 + enc_size(enc)
                    .ok_or_else(|| bad("personality encoding is not supported").unwrap_err())?;
            }
            b'S' | b'B' | b'G' => {}
            _ => return bad(&format!("augmentation `{}` is not supported", c as char)),
        }
    }
    Ok(DW_EH_PE_ABSPTR)
}

/// Walk `.eh_frame`, returning one entry per FDE. `sec_addr` is the
/// section's final address; entries come back in address order, which
/// is the order an unwinder binary-searches.
pub fn scan(data: &[u8], sec_addr: u64) -> Result<Vec<FdeEntry>, String> {
    let mut out: Vec<FdeEntry> = Vec::new();
    let mut pos = 0usize;
    while pos + 4 <= data.len() {
        let len = u32_at(data, pos).ok_or("`.eh_frame`: truncated length")? as usize;
        if len == 0 {
            break; // terminator
        }
        if len == 0xffff_ffff {
            return Err(String::from(
                "`.eh_frame`: 64-bit entries are not supported",
            ));
        }
        let end = pos + 4 + len;
        if end > data.len() {
            return Err(String::from("`.eh_frame`: entry runs past the section"));
        }
        let id = u32_at(data, pos + 4).ok_or("`.eh_frame`: truncated CIE id")?;
        if id != 0 {
            // An FDE: its CIE sits `id` bytes back from the id field.
            let cie_at = (pos + 4)
                .checked_sub(id as usize)
                .ok_or("`.eh_frame`: FDE names a CIE outside the section")?;
            let enc = cie_fde_encoding(data, cie_at, end)?;
            if enc == DW_EH_PE_OMIT {
                return Err(String::from("`.eh_frame`: FDE without an initial location"));
            }
            let at = pos + 8;
            let pc = read_ptr(data, at, enc, sec_addr).ok_or_else(|| {
                format!("`.eh_frame`: pointer encoding {enc:#04x} is not supported")
            })?;
            out.push(FdeEntry {
                pc,
                fde: sec_addr + pos as u64,
            });
        }
        pos = end;
    }
    out.sort_by_key(|e| e.pc);
    Ok(out)
}

/// Number of FDEs in `data`, without needing final addresses. Used to
/// size `.eh_frame_hdr` before layout settles.
pub fn count_fdes(data: &[u8]) -> usize {
    let mut n = 0usize;
    let mut pos = 0usize;
    while pos + 8 <= data.len() {
        let Some(len) = u32_at(data, pos) else { break };
        if len == 0 || len == 0xffff_ffff {
            break;
        }
        if u32_at(data, pos + 4).is_some_and(|id| id != 0) {
            n += 1;
        }
        pos += 4 + len as usize;
    }
    n
}

pub const HEADER_SIZE: u64 = 12;
pub const ENTRY_SIZE: u64 = 8;

/// The table's entries are signed 32-bit displacements, so a target
/// further than 2 GiB from the header cannot be named.
fn delta32(from: u64, to: u64) -> Result<i32, String> {
    i32::try_from(to.wrapping_sub(from) as i64)
        .map_err(|_| format!("`.eh_frame_hdr`: {to:#x} is out of range of {from:#x}"))
}

/// `.eh_frame_hdr` contents: the header, then the FDE table encoded
/// relative to the section's own address.
pub fn build(hdr_addr: u64, eh_frame_addr: u64, entries: &[FdeEntry]) -> Result<Vec<u8>, String> {
    let mut out = Vec::with_capacity(HEADER_SIZE as usize + entries.len() * ENTRY_SIZE as usize);
    out.push(1); // version
    out.push(DW_EH_PE_PCREL | DW_EH_PE_SDATA4); // eh_frame_ptr
    out.push(DW_EH_PE_UDATA4); // fde_count
    out.push(DW_EH_PE_DATAREL | DW_EH_PE_SDATA4); // table
    out.extend_from_slice(&delta32(hdr_addr + 4, eh_frame_addr)?.to_le_bytes());
    out.extend_from_slice(&(entries.len() as u32).to_le_bytes());
    for e in entries {
        out.extend_from_slice(&delta32(hdr_addr, e.pc)?.to_le_bytes());
        out.extend_from_slice(&delta32(hdr_addr, e.fde)?.to_le_bytes());
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// A CIE with `zR`/sdata4-pcrel FDE pointers and two FDEs, the
    /// shape gcc emits.
    fn sample() -> Vec<u8> {
        let mut d: Vec<u8> = Vec::new();
        // CIE: length 0x14, id 0, version 1, "zR", aligns, aug len 1,
        // encoding pcrel|sdata4, padding.
        d.extend_from_slice(&0x14u32.to_le_bytes());
        d.extend_from_slice(&0u32.to_le_bytes());
        d.push(1);
        d.extend_from_slice(b"zR\0");
        d.push(1); // code alignment
        d.push(0x78); // data alignment (sleb -8)
        d.push(16); // return address column
        d.push(1); // augmentation length
        d.push(DW_EH_PE_PCREL | DW_EH_PE_SDATA4);
        while d.len() < 0x18 {
            d.push(0);
        }
        for (k, delta) in [(0usize, 0x100i32), (1, 0x80)] {
            let at = d.len();
            d.extend_from_slice(&0x14u32.to_le_bytes());
            // CIE pointer: distance back to the CIE from this field.
            d.extend_from_slice(&((at + 4) as u32).to_le_bytes());
            d.extend_from_slice(&delta.to_le_bytes());
            d.extend_from_slice(&0x10u32.to_le_bytes()); // range
            while d.len() < at + 0x18 {
                d.push(0);
            }
            let _ = k;
        }
        d
    }

    #[test]
    fn scan_finds_every_fde_in_address_order() {
        let d = sample();
        assert_eq!(count_fdes(&d), 2);
        let e = scan(&d, 0x1000).expect("scans");
        assert_eq!(e.len(), 2);
        // FDE at 0x18 covers 0x1018 + 0x100; FDE at 0x30 covers
        // 0x1030 + 0x80. Sorted by the address described.
        assert_eq!(
            e[0],
            FdeEntry {
                pc: 0x10b8,
                fde: 0x1030
            }
        );
        assert_eq!(
            e[1],
            FdeEntry {
                pc: 0x1120,
                fde: 0x1018
            }
        );
    }

    #[test]
    fn header_encodes_the_table_the_way_ld_does() {
        let e = [FdeEntry {
            pc: 0x7e0,
            fde: 0x698,
        }];
        let b = build(0x63c, 0x680, &e).expect("in range");
        assert_eq!(b[0..4], [1, 0x1b, 0x03, 0x3b]);
        // eh_frame_ptr is pc-relative to its own field at hdr+4.
        assert_eq!(i32::from_le_bytes(b[4..8].try_into().unwrap()), 0x40);
        assert_eq!(u32::from_le_bytes(b[8..12].try_into().unwrap()), 1);
        // Table entries are relative to the header's address.
        assert_eq!(i32::from_le_bytes(b[12..16].try_into().unwrap()), 0x1a4);
        assert_eq!(i32::from_le_bytes(b[16..20].try_into().unwrap()), 0x5c);
        assert_eq!(b.len() as u64, HEADER_SIZE + ENTRY_SIZE);
    }
}
