/* The ChaCha20 block function (RFC 7539 2.3) over a local array whose
   elements each round updates twice, the second write overwriting the
   first, and rotates by constant counts: the block of the RFC's 2.3.2 test
   vector. Returns 0 when all sixteen words match, else the first
   mismatching word's index plus one. */

#include <stdint.h>
#include <string.h>

typedef uint32_t u32;

#define ROTL(a, b) (((a) << (b)) | ((a) >> (32 - (b))))
#define QR(a, b, c, d)                                                                   \
    (a += b, d ^= a, d = ROTL(d, 16), c += d, b ^= c, b = ROTL(b, 12), a += b, d ^= a,  \
     d = ROTL(d, 8), c += d, b ^= c, b = ROTL(b, 7))

static void chacha_block(u32 *out, const u32 *in) {
    u32 x[16];
    memcpy(x, in, 64);
    for (int i = 0; i < 10; i++) {
        QR(x[0], x[4], x[8], x[12]);
        QR(x[1], x[5], x[9], x[13]);
        QR(x[2], x[6], x[10], x[14]);
        QR(x[3], x[7], x[11], x[15]);
        QR(x[0], x[5], x[10], x[15]);
        QR(x[1], x[6], x[11], x[12]);
        QR(x[2], x[7], x[8], x[13]);
        QR(x[3], x[4], x[9], x[14]);
    }
    for (int i = 0; i < 16; i++)
        out[i] = x[i] + in[i];
}

int main(void) {
    static const u32 in[16] = {
        0x61707865, 0x3320646e, 0x79622d32, 0x6b206574, 0x03020100, 0x07060504,
        0x0b0a0908, 0x0f0e0d0c, 0x13121110, 0x17161514, 0x1b1a1918, 0x1f1e1d1c,
        0x00000001, 0x09000000, 0x4a000000, 0x00000000,
    };
    static const u32 want[16] = {
        0xe4e7f110, 0x15593bd1, 0x1fdd0f50, 0xc47120a3, 0xc7f4d1c7, 0x0368c033,
        0x9aaa2204, 0x4e6cd4c3, 0x466482d2, 0x09aa9f07, 0x05d7c214, 0xa2028bd9,
        0xd19c12b5, 0xb94e16de, 0xe883d0cb, 0x4e3c50a2,
    };
    u32 out[16];
    chacha_block(out, in);
    for (int i = 0; i < 16; i++)
        if (out[i] != want[i])
            return i + 1;
    return 0;
}
