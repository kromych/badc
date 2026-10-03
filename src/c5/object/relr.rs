//! `SHT_RELR` packing of relative relocations (the generic ABI's
//! `DT_RELR`): each slot's value is its own link-time address, which the
//! loader rebases by the load bias.

use alloc::vec::Vec;

/// Pack sorted word-aligned addresses into SHT_RELR words: an even
/// entry relocates its own address and rebases the window at
/// `addr + word_size`; each following odd entry's bits `1..` relocate
/// `base + (bit-1)*word_size` and advance the base by the window.
pub(crate) fn encode_relr(addrs: &[u64], word_size: u64) -> Vec<u64> {
    let span = (word_size * 8 - 1) * word_size;
    let mut out: Vec<u64> = Vec::new();
    let mut i = 0usize;
    while i < addrs.len() {
        out.push(addrs[i]);
        let mut base = addrs[i] + word_size;
        i += 1;
        loop {
            let mut word: u64 = 0;
            while i < addrs.len() {
                let d = addrs[i].wrapping_sub(base);
                if d >= span || !d.is_multiple_of(word_size) {
                    break;
                }
                word |= 1u64 << (d / word_size);
                i += 1;
            }
            if word == 0 {
                break;
            }
            out.push((word << 1) | 1);
            base += span;
        }
    }
    out
}

/// The addresses 64-bit RELR words relocate, in order.
#[cfg(test)]
pub(crate) fn decode_relr(words: &[u64]) -> Vec<u64> {
    let mut got: Vec<u64> = Vec::new();
    let mut base = 0u64;
    for &w in words {
        if w & 1 == 0 {
            got.push(w);
            base = w + 8;
        } else {
            let mut r = w >> 1;
            let mut i = 0u64;
            while r != 0 {
                if r & 1 != 0 {
                    got.push(base + i * 8);
                }
                r >>= 1;
                i += 1;
            }
            base += 63 * 8;
        }
    }
    got
}

#[cfg(test)]
mod tests {
    use super::{decode_relr, encode_relr};

    #[test]
    fn relr_encoding_round_trips() {
        let addrs = [0x1000u64, 0x1008, 0x1010, 0x1400, 0x1408 + 63 * 8];
        assert_eq!(decode_relr(&encode_relr(&addrs, 8)), addrs);
    }
}
