// BMI1, BMI2, LZCNT and ADX through <immintrin.h>, at the values the
// instructions give: zero operands, counts at and past the width, and the
// carries in and out. Each group sets its bit on a mismatch; off x86-64 the
// unit checks nothing.

#ifdef __x86_64__
#include <immintrin.h>

static volatile unsigned int u32s[] = {0, 1, 0x80000000u, 0x00f0f0f0u, 0xffffffffu};
static volatile unsigned long long u64s[] = {0, 1, 0x8000000000000000ull, 0x0123456789abcdefull,
                                            0xffffffffffffffffull};

int main(void) {
    int r = 0;
    unsigned int a = u32s[3], z = u32s[0], m = u32s[4];
    unsigned long long q = u64s[3], qz = u64s[0], qm = u64s[4];
    if (_lzcnt_u32(z) != 32 || _lzcnt_u32(u32s[1]) != 31 || _lzcnt_u32(u32s[2]) != 0 ||
        _lzcnt_u64(qz) != 64 || _lzcnt_u64(q) != 7 || __tzcnt_u16(0) != 16 || _tzcnt_u32(a) != 4)
        r |= 1;
    if (_andn_u32(a, m) != 0xff0f0f0fu || _andn_u64(q, qm) != ~q || _blsi_u32(a) != 0x10 ||
        _blsmsk_u32(a) != 0x1f || _blsr_u32(a) != 0x00f0f0e0u || _blsi_u32(z) != 0 ||
        _blsmsk_u32(z) != 0xffffffffu || _blsr_u64(q) != 0x0123456789abcdeeull ||
        _blsmsk_u64(u64s[2]) != 0xffffffffffffffffull)
        r |= 2;
    if (_bextr_u32(a, 4, 8) != 0x0f || _bextr_u32(a, 32, 4) != 0 || _bextr_u32(a, 4, 0) != 0 ||
        _bextr_u32(a, 20, 40) != 0x0f || __bextr_u32(a, 0x0804) != 0x0f ||
        _bextr_u64(q, 60, 8) != 0 || _bextr_u64(q, 8, 16) != 0xabcd || _bextr_u64(q, 0, 255) != q)
        r |= 4;
    if (_bzhi_u32(m, 0) != 0 || _bzhi_u32(m, 31) != 0x7fffffffu || _bzhi_u32(a, 32) != a ||
        _bzhi_u32(a, 0x108) != 0xf0 || _bzhi_u64(qm, 63) != 0x7fffffffffffffffull ||
        _bzhi_u64(q, 64) != q)
        r |= 8;
    if (_pdep_u32(0x2d, 0x00f0f0f0u) != 0x000020d0u || _pdep_u32(m, z) != 0 ||
        _pext_u32(a, 0x00ff00ffu) != 0xf0f0u || _pext_u32(m, 0x80000001u) != 3 ||
        _pdep_u64(q, 0xff00000000000000ull) != 0xef00000000000000ull ||
        _pext_u64(q, 0xf0000000000000f0ull) != 0x0e)
        r |= 16;
    unsigned long long hi64;
    if (_mulx_u64(qm, q, &hi64) != 0xfedcba9876543211ull || hi64 != 0x0123456789abcdeeull ||
        _mulx_u64(qz, q, &hi64) != 0 || hi64 != 0)
        r |= 32;
    unsigned int o32;
    unsigned long long o64;
    unsigned char c = _addcarry_u32(1, m, 0, &o32);
    if (c != 1 || o32 != 0 || _addcarry_u32(0, m, 0, &o32) != 0 || o32 != m ||
        _addcarry_u32(2, a, 1, &o32) != 0 || o32 != a + 2 || _addcarryx_u32(1, m, m, &o32) != 1 ||
        o32 != m)
        r |= 64;
    if (_subborrow_u32(1, z, 0, &o32) != 1 || o32 != m || _subborrow_u32(0, a, a, &o32) != 0 ||
        o32 != 0 || _addcarry_u64(1, qm, qz, &o64) != 1 || o64 != 0 ||
        _subborrow_u64(0, qz, 1, &o64) != 1 || o64 != qm || _subborrow_u64(1, q, 1, &o64) != 0 ||
        o64 != q - 2 || _addcarryx_u64(0, q, q, &o64) != 0 || o64 != 2 * q)
        r |= 128;
#ifdef _WIN32
    // MSVC's forms: the count masked to the width.
    unsigned int hi32;
    if (_rorx_u32(a, 36) != 0x000f0f0fu || _rorx_u64(q, 0) != q || _sarx_i32(-64, 33) != -32 ||
        _sarx_i64(-1, 63) != -1 || _shlx_u32(1, 35) != 8 || _shrx_u64(qm, 68) != qm >> 4 ||
        _mulx_u32(m, m, &hi32) != 1 || hi32 != 0xfffffffeu)
        r |= 128;
#endif
    return r;
}
#else
int main(void) { return 0; }
#endif
