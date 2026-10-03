//! SHA-1 (FIPS 180-4), the digest of `--build-id=sha1`.

/// The SHA-1 digest of `data`.
pub(crate) fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let process = |h: &mut [u32; 5], chunk: &[u8; 64]| {
        let mut w = [0u32; 80];
        for (i, word) in chunk.as_chunks::<4>().0.iter().enumerate() {
            w[i] = u32::from_be_bytes(*word);
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let (mut a, mut b, mut c, mut d, mut e) = (h[0], h[1], h[2], h[3], h[4]);
        for (i, &wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | ((!b) & d), 0x5A827999u32),
                20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
                40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
                _ => (b ^ c ^ d, 0xCA62C1D6),
            };
            let tmp = a
                .rotate_left(5)
                .wrapping_add(f)
                .wrapping_add(e)
                .wrapping_add(k)
                .wrapping_add(wi);
            e = d;
            d = c;
            c = b.rotate_left(30);
            b = a;
            a = tmp;
        }
        for (hv, v) in h.iter_mut().zip([a, b, c, d, e]) {
            *hv = hv.wrapping_add(v);
        }
    };
    let (blocks, rest) = data.as_chunks::<64>();
    for block in blocks {
        process(&mut h, block);
    }
    let mut tail = [0u8; 128];
    tail[..rest.len()].copy_from_slice(rest);
    tail[rest.len()] = 0x80;
    let len = if rest.len() < 56 { 64 } else { 128 };
    tail[len - 8..len].copy_from_slice(&(data.len() as u64).wrapping_mul(8).to_be_bytes());
    for block in tail[..len].as_chunks::<64>().0 {
        process(&mut h, block);
    }
    let mut out = [0u8; 20];
    for (k, hv) in h.iter().enumerate() {
        out[k * 4..k * 4 + 4].copy_from_slice(&hv.to_be_bytes());
    }
    out
}

#[cfg(test)]
mod tests {
    use super::sha1;

    #[test]
    fn sha1_matches_known_vectors() {
        let hex = |d: [u8; 20]| {
            d.iter()
                .map(|b| alloc::format!("{b:02x}"))
                .collect::<alloc::string::String>()
        };
        assert_eq!(
            hex(sha1(b"abc")),
            "a9993e364706816aba3e25717850c26c9cd0d89d"
        );
        assert_eq!(hex(sha1(b"")), "da39a3ee5e6b4b0d3255bfef95601890afd80709");
        // 56 and 64 bytes put the length in a second padding block.
        assert_eq!(
            hex(sha1(&[b'a'; 56])),
            "c2db330f6083854c99d4b5bfb6e8f29f201be699"
        );
        assert_eq!(
            hex(sha1(&[b'a'; 64])),
            "0098ba824b5c16427bd7a1122a5a442a25ec644d"
        );
    }
}
