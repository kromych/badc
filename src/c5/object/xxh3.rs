//! XXH3-64 with seed 0 and the default secret, the hash of lld's
//! `--build-id=fast`.

use alloc::vec::Vec;

const PRIME32_1: u64 = 0x9E37_79B1;
const PRIME32_2: u64 = 0x85EB_CA77;
const PRIME32_3: u64 = 0xC2B2_AE3D;
const PRIME64_1: u64 = 0x9E37_79B1_85EB_CA87;
const PRIME64_2: u64 = 0xC2B2_AE3D_27D4_EB4F;
const PRIME64_3: u64 = 0x1656_67B1_9E37_79F9;
const PRIME64_4: u64 = 0x85EB_CA77_C2B2_AE63;
const PRIME64_5: u64 = 0x27D4_EB2F_1656_67C5;

const SECRET: [u8; 192] = [
    0xb8, 0xfe, 0x6c, 0x39, 0x23, 0xa4, 0x4b, 0xbe, 0x7c, 0x01, 0x81, 0x2c, 0xf7, 0x21, 0xad, 0x1c,
    0xde, 0xd4, 0x6d, 0xe9, 0x83, 0x90, 0x97, 0xdb, 0x72, 0x40, 0xa4, 0xa4, 0xb7, 0xb3, 0x67, 0x1f,
    0xcb, 0x79, 0xe6, 0x4e, 0xcc, 0xc0, 0xe5, 0x78, 0x82, 0x5a, 0xd0, 0x7d, 0xcc, 0xff, 0x72, 0x21,
    0xb8, 0x08, 0x46, 0x74, 0xf7, 0x43, 0x24, 0x8e, 0xe0, 0x35, 0x90, 0xe6, 0x81, 0x3a, 0x26, 0x4c,
    0x3c, 0x28, 0x52, 0xbb, 0x91, 0xc3, 0x00, 0xcb, 0x88, 0xd0, 0x65, 0x8b, 0x1b, 0x53, 0x2e, 0xa3,
    0x71, 0x64, 0x48, 0x97, 0xa2, 0x0d, 0xf9, 0x4e, 0x38, 0x19, 0xef, 0x46, 0xa9, 0xde, 0xac, 0xd8,
    0xa8, 0xfa, 0x76, 0x3f, 0xe3, 0x9c, 0x34, 0x3f, 0xf9, 0xdc, 0xbb, 0xc7, 0xc7, 0x0b, 0x4f, 0x1d,
    0x8a, 0x51, 0xe0, 0x4b, 0xcd, 0xb4, 0x59, 0x31, 0xc8, 0x9f, 0x7e, 0xc9, 0xd9, 0x78, 0x73, 0x64,
    0xea, 0xc5, 0xac, 0x83, 0x34, 0xd3, 0xeb, 0xc3, 0xc5, 0x81, 0xa0, 0xff, 0xfa, 0x13, 0x63, 0xeb,
    0x17, 0x0d, 0xdd, 0x51, 0xb7, 0xf0, 0xda, 0x49, 0xd3, 0x16, 0x55, 0x26, 0x29, 0xd4, 0x68, 0x9e,
    0x2b, 0x16, 0xbe, 0x58, 0x7d, 0x47, 0xa1, 0xfc, 0x8f, 0xf8, 0xb8, 0xd1, 0x7a, 0xd0, 0x31, 0xce,
    0x45, 0xcb, 0x3a, 0x8f, 0x95, 0x16, 0x04, 0x28, 0xaf, 0xd7, 0xfb, 0xca, 0xbb, 0x4b, 0x40, 0x7e,
];

const STRIPE_LEN: usize = 64;
/// Stripes per block: each takes the secret 8 bytes further along.
const STRIPES_PER_BLOCK: usize = (SECRET.len() - STRIPE_LEN) / 8;
const BLOCK_LEN: usize = STRIPE_LEN * STRIPES_PER_BLOCK;

fn read32(b: &[u8], at: usize) -> u64 {
    u32::from_le_bytes(b[at..at + 4].try_into().unwrap()) as u64
}

fn read64(b: &[u8], at: usize) -> u64 {
    u64::from_le_bytes(b[at..at + 8].try_into().unwrap())
}

fn mul128_fold64(a: u64, b: u64) -> u64 {
    let p = a as u128 * b as u128;
    p as u64 ^ (p >> 64) as u64
}

fn avalanche(mut h: u64) -> u64 {
    h ^= h >> 37;
    h = h.wrapping_mul(0x1656_6791_9E37_79F9);
    h ^ (h >> 32)
}

fn xxh64_avalanche(mut h: u64) -> u64 {
    h ^= h >> 33;
    h = h.wrapping_mul(PRIME64_2);
    h ^= h >> 29;
    h = h.wrapping_mul(PRIME64_3);
    h ^ (h >> 32)
}

fn rrmxmx(mut h: u64, len: u64) -> u64 {
    h ^= h.rotate_left(49) ^ h.rotate_left(24);
    h = h.wrapping_mul(0x9FB2_1C65_1E98_DF25);
    h ^= (h >> 35).wrapping_add(len);
    h = h.wrapping_mul(0x9FB2_1C65_1E98_DF25);
    h ^ (h >> 28)
}

fn mix16(data: &[u8], at: usize, secret_at: usize) -> u64 {
    mul128_fold64(
        read64(data, at) ^ read64(&SECRET, secret_at),
        read64(data, at + 8) ^ read64(&SECRET, secret_at + 8),
    )
}

/// One stripe into the eight lanes.
fn accumulate_stripe(acc: &mut [u64; 8], data: &[u8], at: usize, secret_at: usize) {
    for i in 0..8 {
        let value = read64(data, at + 8 * i);
        let key = value ^ read64(&SECRET, secret_at + 8 * i);
        acc[i ^ 1] = acc[i ^ 1].wrapping_add(value);
        acc[i] = acc[i].wrapping_add((key & 0xffff_ffff).wrapping_mul(key >> 32));
    }
}

fn scramble(acc: &mut [u64; 8]) {
    let secret_at = SECRET.len() - STRIPE_LEN;
    for (i, lane) in acc.iter_mut().enumerate() {
        let mut v = *lane ^ (*lane >> 47);
        v ^= read64(&SECRET, secret_at + 8 * i);
        *lane = v.wrapping_mul(PRIME32_1);
    }
}

fn hash_long(data: &[u8]) -> u64 {
    let len = data.len();
    let mut acc = [
        PRIME32_3, PRIME64_1, PRIME64_2, PRIME64_3, PRIME64_4, PRIME32_2, PRIME64_5, PRIME32_1,
    ];
    let blocks = (len - 1) / BLOCK_LEN;
    for b in 0..blocks {
        for s in 0..STRIPES_PER_BLOCK {
            accumulate_stripe(&mut acc, data, b * BLOCK_LEN + s * STRIPE_LEN, s * 8);
        }
        scramble(&mut acc);
    }
    let stripes = ((len - 1) - BLOCK_LEN * blocks) / STRIPE_LEN;
    for s in 0..stripes {
        accumulate_stripe(&mut acc, data, blocks * BLOCK_LEN + s * STRIPE_LEN, s * 8);
    }
    accumulate_stripe(
        &mut acc,
        data,
        len - STRIPE_LEN,
        SECRET.len() - STRIPE_LEN - 7,
    );
    let mut h = (len as u64).wrapping_mul(PRIME64_1);
    for i in 0..4 {
        let at = 11 + 16 * i;
        h = h.wrapping_add(mul128_fold64(
            acc[2 * i] ^ read64(&SECRET, at),
            acc[2 * i + 1] ^ read64(&SECRET, at + 8),
        ));
    }
    avalanche(h)
}

/// XXH3-64 of `data`.
pub(crate) fn xxh3_64(data: &[u8]) -> u64 {
    let len = data.len();
    let n = len as u64;
    match len {
        0 => xxh64_avalanche(read64(&SECRET, 56) ^ read64(&SECRET, 64)),
        1..=3 => {
            let combined = (data[0] as u64) << 16
                | (data[len >> 1] as u64) << 24
                | data[len - 1] as u64
                | n << 8;
            xxh64_avalanche(combined ^ (read32(&SECRET, 0) ^ read32(&SECRET, 4)))
        }
        4..=8 => {
            let input = read32(data, len - 4).wrapping_add(read32(data, 0) << 32);
            rrmxmx(input ^ (read64(&SECRET, 8) ^ read64(&SECRET, 16)), n)
        }
        9..=16 => {
            let lo = read64(data, 0) ^ (read64(&SECRET, 24) ^ read64(&SECRET, 32));
            let hi = read64(data, len - 8) ^ (read64(&SECRET, 40) ^ read64(&SECRET, 48));
            let acc = n
                .wrapping_add(lo.swap_bytes())
                .wrapping_add(hi)
                .wrapping_add(mul128_fold64(lo, hi));
            avalanche(acc)
        }
        17..=128 => {
            let mut acc = n.wrapping_mul(PRIME64_1);
            let rounds = (len - 1) / 32;
            for i in (0..=rounds).rev() {
                acc = acc.wrapping_add(mix16(data, 16 * i, 32 * i));
                acc = acc.wrapping_add(mix16(data, len - 16 * (i + 1), 32 * i + 16));
            }
            avalanche(acc)
        }
        129..=240 => {
            let mut acc = n.wrapping_mul(PRIME64_1);
            for i in 0..8 {
                acc = acc.wrapping_add(mix16(data, 16 * i, 16 * i));
            }
            acc = avalanche(acc);
            for i in 8..len / 16 {
                acc = acc.wrapping_add(mix16(data, 16 * i, 16 * (i - 8) + 3));
            }
            acc = acc.wrapping_add(mix16(data, len - 16, 136 - 17));
            avalanche(acc)
        }
        _ => hash_long(data),
    }
}

/// lld's `--build-id=fast` over an image whose id bytes are zero: the
/// hash of the 1 MiB chunks' hashes, little-endian.
pub(crate) fn build_id_fast(image: &[u8]) -> [u8; 8] {
    let hashes: Vec<u8> = (image.chunks(1 << 20))
        .flat_map(|c| xxh3_64(c).to_le_bytes())
        .collect();
    xxh3_64(&hashes).to_le_bytes()
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The xorshift stream the vectors were computed over.
    fn stream(n: usize) -> Vec<u8> {
        let mut s: u64 = 0x9E37_79B9_7F4A_7C15;
        (0..n)
            .map(|_| {
                s ^= s << 13;
                s ^= s >> 7;
                s ^= s << 17;
                (s >> 32) as u8
            })
            .collect()
    }

    /// LLVM's `xxh3_64bits`, the hash lld takes, over prefixes of the
    /// stream: every length class and block boundary of the algorithm.
    #[test]
    fn xxh3_matches_llvm_on_every_length_class() {
        let data = stream(3 * 1024 * 1024 + 12345);
        for &(len, want) in VECTORS {
            assert_eq!(xxh3_64(&data[..len]), want, "length {len}");
        }
    }

    /// lld's chunked id, for an image under one chunk and one over three.
    #[test]
    fn the_fast_id_hashes_the_chunk_hashes() {
        let data = stream(3 * 1024 * 1024 + 12345);
        assert_eq!(
            build_id_fast(&data[..300]),
            0x7495_5338_41f6_709au64.to_le_bytes()
        );
        assert_eq!(build_id_fast(&data), 0x1da6_4a5f_120f_97abu64.to_le_bytes());
    }

    const VECTORS: &[(usize, u64)] = &[
        (0, 0x2d06_8005_38d3_94c2),
        (1, 0xc23e_93d4_4ddb_645b),
        (2, 0x15ca_95e8_009f_e89a),
        (3, 0xe9de_8a5d_1784_eeae),
        (4, 0xd0a4_3dba_428f_0d00),
        (5, 0x135b_87b8_cda2_6ab5),
        (7, 0xcf56_18d6_3c43_0919),
        (8, 0x4bfb_f095_60d4_6f05),
        (9, 0x8ea5_0504_7d8a_ac8f),
        (15, 0x9d15_2bca_2c58_4797),
        (16, 0xc745_3bc6_6331_ef51),
        (17, 0x1bdb_903f_570c_33e9),
        (31, 0x2e53_997f_b28d_b1b5),
        (32, 0x1f11_d92f_a913_0fff),
        (33, 0x4c84_093d_1f15_6c5e),
        (63, 0x5e87_1f9c_0960_d8ef),
        (64, 0xcff5_3a20_7dcb_d45d),
        (65, 0x847c_625e_51b8_d1d5),
        (95, 0x3cd8_76b4_06a0_342e),
        (96, 0x1a7a_7e34_e51e_517c),
        (97, 0x3489_6398_5dc6_4db7),
        (127, 0xc95f_4b6a_e54a_849c),
        (128, 0x8537_0ded_487b_be3f),
        (129, 0x6afb_efda_c66b_a4cf),
        (130, 0x801b_5a7b_9242_84d2),
        (200, 0x0d03_4ee1_160a_82fa),
        (239, 0x7961_3c57_754c_88ae),
        (240, 0xa7d8_d115_65d2_82f3),
        (241, 0xabf7_0558_97ed_0639),
        (255, 0xbc2a_a815_8987_a403),
        (256, 0xe31e_7d70_741f_bff5),
        (511, 0x6266_f58c_28b3_56dc),
        (1023, 0x72bb_b48b_d5cb_025b),
        (1024, 0x6d53_f978_d2dc_29ed),
        (1025, 0x8c86_58e8_c574_01d5),
        (1088, 0xf558_1a60_c38b_52dc),
        (2047, 0x15ab_6256_74d0_0f2c),
        (2048, 0xb39c_e098_d6c7_6dd3),
        (4096, 0x8566_923d_069f_a2d7),
        (65536, 0x02d3_6cd8_ed98_8114),
        (1048576, 0x4da1_fe6f_bc97_b501),
        (3158073, 0x0439_2099_39fc_0be5),
    ];
}
