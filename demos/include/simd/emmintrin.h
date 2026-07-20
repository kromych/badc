/* SSE2 integer intrinsics for badc, expressed as always_inline inline-asm.
 *
 * badc has no native SIMD-intrinsic lowering but does encode inline-asm SSE2.
 * Each intrinsic loads its __m128i operands from memory (movdqu), runs one
 * SSE2 instruction over the %xmm0/%xmm1 scratch pair, and stores the result.
 * The per-op memory round-trip is the cost of not having xmm-register ("x")
 * asm operands; it does not affect correctness.
 *
 * Constraints this places on the code:
 *   - loads and stores use movdqu (unaligned): an automatic __m128i is only
 *     8-byte aligned here, so an aligned movdqa/movaps would #GP.
 *   - scratch registers are fixed (%xmm0/%xmm1) and clobber-listed, since the
 *     "x" operand constraint is not yet available.
 *
 * Scope: the SSE2 integer subset stb_image.h (STBI_SSE2) uses. The __m128
 * float vectors that other libraries reach for are not covered.
 */
#ifndef BADC_EMMINTRIN_H
#define BADC_EMMINTRIN_H

typedef long long __m128i __attribute__((vector_size(16)));

/* Plain `static inline`: badc does not inline a function containing inline asm,
 * so the wrappers are emitted out-of-line. `always_inline` would only warn. */
#define MM_ALWAYS static inline

/* Two-operand op: a -> xmm0, b -> xmm1, INSN (xmm1 -> xmm0), xmm0 -> result. */
#define MM_BINOP(fn, insn)                                              \
    MM_ALWAYS __m128i fn(__m128i a, __m128i b) {                        \
        __m128i r;                                                      \
        __asm__("movdqu %1, %%xmm0\n\t"                                 \
                "movdqu %2, %%xmm1\n\t" insn "\n\t"                     \
                "movdqu %%xmm0, %0"                                     \
                : "=m"(r) : "m"(a), "m"(b) : "xmm0", "xmm1", "memory"); \
        return r;                                                       \
    }

MM_BINOP(_mm_add_epi16,      "paddw %%xmm1, %%xmm0")
MM_BINOP(_mm_add_epi32,      "paddd %%xmm1, %%xmm0")
MM_BINOP(_mm_sub_epi16,      "psubw %%xmm1, %%xmm0")
MM_BINOP(_mm_sub_epi32,      "psubd %%xmm1, %%xmm0")
MM_BINOP(_mm_xor_si128,      "pxor %%xmm1, %%xmm0")
MM_BINOP(_mm_and_si128,      "pand %%xmm1, %%xmm0")
MM_BINOP(_mm_or_si128,       "por %%xmm1, %%xmm0")
MM_BINOP(_mm_mullo_epi16,    "pmullw %%xmm1, %%xmm0")
MM_BINOP(_mm_mulhi_epi16,    "pmulhw %%xmm1, %%xmm0")
MM_BINOP(_mm_madd_epi16,     "pmaddwd %%xmm1, %%xmm0")
MM_BINOP(_mm_unpacklo_epi8,  "punpcklbw %%xmm1, %%xmm0")
MM_BINOP(_mm_unpacklo_epi16, "punpcklwd %%xmm1, %%xmm0")
MM_BINOP(_mm_unpacklo_epi32, "punpckldq %%xmm1, %%xmm0")
MM_BINOP(_mm_unpackhi_epi8,  "punpckhbw %%xmm1, %%xmm0")
MM_BINOP(_mm_unpackhi_epi16, "punpckhwd %%xmm1, %%xmm0")
MM_BINOP(_mm_unpackhi_epi32, "punpckhdq %%xmm1, %%xmm0")
MM_BINOP(_mm_packs_epi16,    "packsswb %%xmm1, %%xmm0")
MM_BINOP(_mm_packs_epi32,    "packssdw %%xmm1, %%xmm0")
MM_BINOP(_mm_packus_epi16,   "packuswb %%xmm1, %%xmm0")

/* Immediate-count shifts. The count must be a template literal, so token-paste
 * it. The argument is bound to a local first: an rvalue argument (a call or
 * cast result) is not directly addressable for the "m" operand. */
#define MM_SHIFT(a, imm, insn) __extension__({                         \
    __m128i _a = (a), _r;                                              \
    __asm__("movdqu %1, %%xmm0\n\t" insn " $" #imm ", %%xmm0\n\t"      \
            "movdqu %%xmm0, %0"                                        \
            : "=m"(_r) : "m"(_a) : "xmm0", "memory");                 \
    _r; })
#define _mm_slli_epi16(a, imm) MM_SHIFT(a, imm, "psllw")
#define _mm_srli_epi16(a, imm) MM_SHIFT(a, imm, "psrlw")
#define _mm_srai_epi16(a, imm) MM_SHIFT(a, imm, "psraw")
#define _mm_slli_epi32(a, imm) MM_SHIFT(a, imm, "pslld")
#define _mm_srli_epi32(a, imm) MM_SHIFT(a, imm, "psrld")
#define _mm_srai_epi32(a, imm) MM_SHIFT(a, imm, "psrad")
#define _mm_slli_si128(a, imm) MM_SHIFT(a, imm, "pslldq")
#define _mm_srli_si128(a, imm) MM_SHIFT(a, imm, "psrldq")

/* Immediate-selector shuffles (single source: pshuf $imm, src, dst). */
#define MM_SHUF(a, imm, insn) __extension__({                            \
    __m128i _a = (a), _r;                                                \
    __asm__("movdqu %1, %%xmm0\n\t" insn " $" #imm ", %%xmm0, %%xmm0\n\t"\
            "movdqu %%xmm0, %0"                                          \
            : "=m"(_r) : "m"(_a) : "xmm0", "memory");                    \
    _r; })
#define _mm_shuffle_epi32(a, imm)   MM_SHUF(a, imm, "pshufd")
#define _mm_shufflelo_epi16(a, imm) MM_SHUF(a, imm, "pshuflw")
#define _mm_shufflehi_epi16(a, imm) MM_SHUF(a, imm, "pshufhw")

MM_ALWAYS __m128i _mm_setzero_si128(void) {
    __m128i r;
    __asm__("pxor %%xmm0, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : : "xmm0", "memory");
    return r;
}
MM_ALWAYS __m128i _mm_set1_epi32(int x) {
    __m128i r;
    __asm__("movd %1, %%xmm0\n\t"
            "pshufd $0, %%xmm0, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "r"(x) : "xmm0", "memory");
    return r;
}
MM_ALWAYS __m128i _mm_set1_epi16(short x) {
    __m128i r; int xi = (unsigned short) x;
    __asm__("movd %1, %%xmm0\n\t"
            "pshuflw $0, %%xmm0, %%xmm0\n\t"
            "pshufd $0, %%xmm0, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "r"(xi) : "xmm0", "memory");
    return r;
}
MM_ALWAYS __m128i _mm_set1_epi8(char x) {
    __m128i r; int xi = (unsigned char) x;
    __asm__("movd %1, %%xmm0\n\t"
            "punpcklbw %%xmm0, %%xmm0\n\t"
            "pshuflw $0, %%xmm0, %%xmm0\n\t"
            "pshufd $0, %%xmm0, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "r"(xi) : "xmm0", "memory");
    return r;
}

/* set / setr: build the lane array in C, then load it. */
MM_ALWAYS __m128i _mm_set_epi32(int e3, int e2, int e1, int e0) {
    int t[4]; __m128i r;
    t[0] = e0; t[1] = e1; t[2] = e2; t[3] = e3;
    __asm__("movdqu %1, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "m"(t[0]) : "xmm0", "memory");
    return r;
}
MM_ALWAYS __m128i _mm_setr_epi16(short e0, short e1, short e2, short e3,
                                 short e4, short e5, short e6, short e7) {
    short t[8]; __m128i r;
    t[0]=e0; t[1]=e1; t[2]=e2; t[3]=e3; t[4]=e4; t[5]=e5; t[6]=e6; t[7]=e7;
    __asm__("movdqu %1, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "m"(t[0]) : "xmm0", "memory");
    return r;
}

MM_ALWAYS __m128i _mm_load_si128(const __m128i *p) {
    __m128i r;
    __asm__("movdqu %1, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(r) : "m"(*p) : "xmm0", "memory");
    return r;
}
MM_ALWAYS __m128i _mm_loadu_si128(const __m128i *p) { return _mm_load_si128(p); }
MM_ALWAYS __m128i _mm_loadl_epi64(const __m128i *p) {
    /* movq reads exactly 8 bytes; type the operand as 8 bytes so no spurious
     * 16-byte read of *p is modelled. */
    __m128i r;
    __asm__("movq %1, %%xmm0\n\t"
            "movdqu %%xmm0, %0"
            : "=m"(r) : "m"(*(const long long *) p) : "xmm0", "memory");
    return r;
}
MM_ALWAYS void _mm_store_si128(__m128i *p, __m128i a) {
    __asm__("movdqu %1, %%xmm0\n\t"
            "movdqu %%xmm0, %0" : "=m"(*p) : "m"(a) : "xmm0", "memory");
}
MM_ALWAYS void _mm_storeu_si128(__m128i *p, __m128i a) { _mm_store_si128(p, a); }
MM_ALWAYS void _mm_storel_epi64(__m128i *p, __m128i a) {
    /* movq writes exactly 8 bytes; typing "=m"(*p) as 16 bytes would let an
     * optimizer treat the upper 8 as clobbered and drop a live store to them. */
    __asm__("movdqu %1, %%xmm0\n\t"
            "movq %%xmm0, %0"
            : "=m"(*(long long *) p) : "m"(a) : "xmm0", "memory");
}

/* insert / extract by constant lane, via a union -- pinsrw/pextrw both need
 * the lane as an immediate and are not in badc's encoder. */
#define _mm_insert_epi16(a, val, idx) __extension__({                  \
    union { __m128i v; short w[8]; } _u; _u.v = (a);                   \
    _u.w[(idx)] = (short)(val); _u.v; })
#define _mm_extract_epi16(a, idx) __extension__({                      \
    union { __m128i v; unsigned short w[8]; } _u; _u.v = (a);          \
    (int) _u.w[(idx)]; })

#endif /* BADC_EMMINTRIN_H */
