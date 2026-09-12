/* 16-byte vector values through a RAID-6 style syndrome loop: loop-carried
 * vectors, a vector live across a call, a statement-expression shift, a
 * read-write operand and a lane read. P and Q are checked against the scalar
 * computation. NEON on AArch64, SSE2 inline asm on x86_64; the scalar path
 * alone runs elsewhere. */

#if defined(__aarch64__)
#include <arm_neon.h>
typedef uint8x16_t vec;
static inline vec v_load(const unsigned char *p) { return vld1q_u8(p); }
static inline void v_store(unsigned char *p, vec v) { vst1q_u8(p, v); }
static inline vec v_xor(vec a, vec b) { return veorq_u8(a, b); }
static inline vec v_and(vec a, vec b) { return vandq_u8(a, b); }
static inline vec v_shl1(vec a) { return vshlq_n_u8(a, 1); }
static inline vec v_mask(vec a) { return (vec)vshrq_n_s8((int8x16_t)a, 7); }
static inline vec v_dup(unsigned char x) { return vdupq_n_u8(x); }
static inline unsigned long long v_lane0(vec a) {
    return vgetq_lane_u64((uint64x2_t)a, 0);
}
#elif defined(__x86_64__)
typedef unsigned char vec __attribute__((vector_size(16)));
static inline vec v_load(const unsigned char *p) {
    vec r;
    __asm__("movdqu %1, %0" : "=x"(r) : "m"(p[0]));
    return r;
}
static inline void v_store(unsigned char *p, vec v) {
    __asm__("movdqu %1, %0" : "=m"(p[0]) : "x"(v));
}
static inline vec v_xor(vec a, vec b) {
    vec r;
    __asm__("movdqa %1, %0\n\tpxor %2, %0" : "=x"(r) : "x"(a), "x"(b));
    return r;
}
static inline vec v_and(vec a, vec b) {
    vec r;
    __asm__("movdqa %1, %0\n\tpand %2, %0" : "=x"(r) : "x"(a), "x"(b));
    return r;
}
static inline vec v_shl1(vec a) {
    vec r = a;
    __asm__("paddb %0, %0" : "+x"(r));
    return r;
}
static inline vec v_mask(vec a) {
    vec r;
    __asm__("pxor %0, %0\n\tpcmpgtb %1, %0" : "=x"(r) : "x"(a));
    return r;
}
static inline vec v_dup(unsigned char x) {
    unsigned char t[16];
    int i;
    for (i = 0; i < 16; i++)
        t[i] = x;
    return v_load(t);
}
static inline unsigned long long v_lane0(vec a) {
    unsigned long long r;
    __asm__("movq %1, %0" : "=r"(r) : "x"(a));
    return r;
}
#endif

#define DISKS 4
#define LEN 48

static unsigned char data[DISKS][LEN];
static unsigned char P[LEN], Q[LEN];

static unsigned char gf_double(unsigned char x) {
    return (unsigned char)((x << 1) ^ ((x & 0x80) ? 0x1d : 0));
}

__attribute__((noinline)) static unsigned block_sum(const unsigned char *p) {
    unsigned s = 0;
    int i;
    for (i = 0; i < 16; i++)
        s += p[i];
    return s;
}

#if defined(__aarch64__) || defined(__x86_64__)
static unsigned syndrome(int disks, int len, unsigned char **dptr,
                         unsigned char *p, unsigned char *q) {
    vec x1d = v_dup(0x1d);
    unsigned acc = 0;
    int d, z, z0 = disks - 1;
    for (d = 0; d < len; d += 16) {
        vec wp, wq, wd, w1, w2;
        wq = wp = v_load(&dptr[z0][d]);
        for (z = z0 - 1; z >= 0; z--) {
            wd = v_load(&dptr[z][d]);
            wp = v_xor(wp, wd);
            w2 = v_mask(wq);
            w1 = v_shl1(wq);
            w2 = v_and(w2, x1d);
            w1 = v_xor(w1, w2);
            wq = v_xor(w1, wd);
        }
        /* wp and wq stay live across the call. */
        acc += block_sum(&dptr[z0][d]);
        v_store(&p[d], wp);
        v_store(&q[d], wq);
        acc += (unsigned)(v_lane0(wq) & 0xff);
    }
    return acc;
}
#endif

int main(void) {
    unsigned char *dptr[DISKS];
    unsigned char rp[LEN], rq[LEN];
    unsigned expect = 0, got;
    int i, z;
    for (z = 0; z < DISKS; z++) {
        dptr[z] = data[z];
        for (i = 0; i < LEN; i++)
            data[z][i] = (unsigned char)(i * (z + 3) * 37 + z * 11 + 5);
    }
    for (i = 0; i < LEN; i++) {
        unsigned char wp = data[DISKS - 1][i], wq = wp;
        for (z = DISKS - 2; z >= 0; z--) {
            wp ^= data[z][i];
            wq = (unsigned char)(gf_double(wq) ^ data[z][i]);
        }
        rp[i] = wp;
        rq[i] = wq;
    }
    for (i = 0; i < LEN; i += 16)
        expect += block_sum(data[DISKS - 1] + i) + rq[i];
#if defined(__aarch64__) || defined(__x86_64__)
    got = syndrome(DISKS, LEN, dptr, P, Q);
#else
    for (i = 0; i < LEN; i++) {
        P[i] = rp[i];
        Q[i] = rq[i];
    }
    got = expect;
#endif
    for (i = 0; i < LEN; i++) {
        if (P[i] != rp[i])
            return 1;
        if (Q[i] != rq[i])
            return 2;
    }
    if (got != expect)
        return 3;
#if defined(__aarch64__)
    {
        /* A read-write operand: out-of-range indices keep the destination. */
        unsigned char t[16], idx[16], dst[16], out[16];
        for (i = 0; i < 16; i++) {
            t[i] = (unsigned char)(i * 7 + 1);
            idx[i] = (unsigned char)(i % 3 == 0 ? 200 : 15 - i);
            dst[i] = (unsigned char)(0xa0 + i);
        }
        vst1q_u8(out, vqtbx1q_u8(vld1q_u8(dst), vld1q_u8(t), vld1q_u8(idx)));
        for (i = 0; i < 16; i++)
            if (out[i] != (idx[i] < 16 ? t[idx[i]] : dst[i]))
                return 4;
    }
#endif
    return 42;
}
