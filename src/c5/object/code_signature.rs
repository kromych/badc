//! The ad-hoc code signature ld64 writes into an arm64 Mach-O image, and lld
//! with `-adhoc_codesign`: a SuperBlob holding one CodeDirectory of SHA-256
//! hashes of the image's 4 KiB pages up to the signature, with no
//! requirements and no CMS signature. Every field is big-endian.

use super::sha256::sha256;
use alloc::vec::Vec;

const CSMAGIC_EMBEDDED_SIGNATURE: u32 = 0xfade_0cc0;
const CSMAGIC_CODEDIRECTORY: u32 = 0xfade_0c02;
const CSSLOT_CODEDIRECTORY: u32 = 0;
/// `CS_ADHOC | CS_LINKER_SIGNED`.
const FLAGS: u32 = 0x2 | 0x2_0000;
/// The CodeDirectory version carrying the executable segment fields.
const VERSION: u32 = 0x2_0400;
const CS_HASHTYPE_SHA256: u8 = 2;
const HASH_SIZE: u64 = 32;
const PAGE_SHIFT: u8 = 12;
/// The SuperBlob header and its one index entry.
const BLOB_HEADERS: u64 = 12 + 8;
/// The version 0x20400 CodeDirectory header.
const CODE_DIRECTORY: u64 = 88;
/// `CS_EXECSEG_MAIN_BINARY`.
const EXECSEG_MAIN_BINARY: u64 = 0x1;

/// The headers and the identifier, padded to 16 bytes, ahead of the hashes.
fn headers(ident: &str) -> u64 {
    (BLOB_HEADERS + CODE_DIRECTORY + ident.len() as u64 + 1).next_multiple_of(16)
}

/// The size of the signature of an image whose first `code_limit` bytes it
/// covers.
pub(crate) fn size(code_limit: u64, ident: &str) -> u64 {
    headers(ident) + code_limit.div_ceil(1 << PAGE_SHIFT) * HASH_SIZE
}

/// The signature of `image`, every byte ahead of the signature, named
/// `ident`. `exec_segment` is `__TEXT`'s file offset and size, and `main`
/// marks an executable.
pub(crate) fn write(image: &[u8], ident: &str, exec_segment: (u64, u64), main: bool) -> Vec<u8> {
    let total = size(image.len() as u64, ident);
    let pages = image.len().div_ceil(1 << PAGE_SHIFT) as u32;
    let mut out = Vec::with_capacity(total as usize);
    let u32s = |out: &mut Vec<u8>, vs: &[u32]| {
        for v in vs {
            out.extend_from_slice(&v.to_be_bytes());
        }
    };
    u32s(&mut out, &[CSMAGIC_EMBEDDED_SIGNATURE, total as u32, 1]);
    u32s(&mut out, &[CSSLOT_CODEDIRECTORY, BLOB_HEADERS as u32]);
    let hash_offset = (headers(ident) - BLOB_HEADERS) as u32;
    u32s(
        &mut out,
        &[
            CSMAGIC_CODEDIRECTORY,
            (total - BLOB_HEADERS) as u32,
            VERSION,
            FLAGS,
            hash_offset,
            CODE_DIRECTORY as u32,
            0, // special slots
            pages,
            image.len() as u32,
        ],
    );
    out.extend_from_slice(&[HASH_SIZE as u8, CS_HASHTYPE_SHA256, 0, PAGE_SHIFT]);
    u32s(&mut out, &[0, 0, 0, 0]); // spare2, scatter, team, spare3
    let (base, limit) = exec_segment;
    let flags = if main { EXECSEG_MAIN_BINARY } else { 0 };
    for v in [0, base, limit, flags] {
        out.extend_from_slice(&v.to_be_bytes()); // codeLimit64, then the segment
    }
    out.extend_from_slice(ident.as_bytes());
    out.resize(headers(ident) as usize, 0);
    for page in image.chunks(1 << PAGE_SHIFT) {
        out.extend_from_slice(&sha256(page));
    }
    debug_assert_eq!(out.len() as u64, total);
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The layout `codesign -d -vvv` reads back from ld64's output: the
    /// CodeDirectory at the index's offset, the identifier and hashes where
    /// it says, one hash per page with a short last page.
    #[test]
    fn the_signature_hashes_each_page_where_the_code_directory_says() {
        let image: Vec<u8> = (0..9000u32).map(|i| i as u8).collect();
        let sig = write(&image, "a.out", (0, 8192), true);
        let be = |at: usize| u32::from_be_bytes(sig[at..at + 4].try_into().unwrap());
        assert_eq!(sig.len() as u64, size(image.len() as u64, "a.out"));
        assert_eq!((be(0), be(4) as usize, be(8)), (0xfade0cc0, sig.len(), 1));
        let cd = be(16) as usize;
        assert_eq!(
            (be(cd), be(cd + 8), be(cd + 12)),
            (0xfade0c02, 0x20400, 0x20002)
        );
        let (hashes, ident, pages, limit) = (be(cd + 16), be(cd + 20), be(cd + 28), be(cd + 32));
        assert_eq!((pages, limit), (3, 9000));
        assert_eq!(&sig[cd + ident as usize..][..6], b"a.out\0");
        assert_eq!(&sig[cd + 36..cd + 40], &[32, 2, 0, 12]);
        for (k, page) in image.chunks(4096).enumerate() {
            let at = cd + hashes as usize + 32 * k;
            assert_eq!(sig[at..at + 32], sha256(page), "page {k}");
        }
        assert_eq!(cd + hashes as usize + 96, sig.len());
    }
}
