// Struct layout / `#pragma pack(N)` exhaustive coverage.
//
// Verifies field offsets and aggregate sizes against hand-computed
// expectations across the full range of layout-shaping features:
// scalars of every supported width, arrays, unions, structs of
// structs of structs, and `#pragma pack(N)` / `(push, N)` /
// `(pop)` / `()` interleaved with normal definitions. Every test
// returns a unique non-zero id on the FIRST mismatch so the
// failure surfaces precisely.
//
// Width invariants relied on:
//   char          1
//   short         2
//   int           4
//   long long     8
//   double        8
//   T *           8
// `long` is deliberately AVOIDED (4 on Windows LLP64 vs 8 on
// macOS/Linux LP64), as is `float` (c5 stores it 8-wide regardless
// of target). The rest match across all five supported triples,
// so the offsets here are a single ground truth for every CI lane.

#include <stdio.h>

// offsetof in c5: `&((T *)0)->m` reads as 0+offset. Cast to `int`
// for the equality check; `int` is 32-bit on every target so a
// few-thousand-byte struct still fits.
#define OFF(T, M)  ((int)((long long)&((T *)0)->M))

// =========================================================================
// 1. Natural alignment, single struct, all scalars

struct Mixed {
    char     a;     // @ 0
    int      b;     // @ 4 (padded 3)
    char     c;     // @ 8
    long long d;    // @ 16 (padded 7)
    short    e;     // @ 24
    char     f;     // @ 26
    double   g;     // @ 32 (padded 5)
};
// total = 40 (g spans 32..40, struct align 8)

// =========================================================================
// 2. Pure char struct -- no padding regardless of pack
struct Chars {
    char a;
    char b;
    char c;
    char d;
};
// total = 4, align 1 (matches standard C / GCC layout)

// =========================================================================
// 3. Nested structs (depth 3) with mixed pack

struct Inner {
    char  i_a;     // @ 0
    int   i_b;     // @ 4
    short i_c;     // @ 8
};
// natural: 8 + 2 = 10, padded to align 4 => 12

struct Middle {
    char         m_a;       // @ 0
    struct Inner m_inner;   // @ 4 (Inner aligns to 4)
    long long    m_b;       // @ 16 (padded to 8)
};
// natural: 16 + 8 = 24, struct align 8

struct Outer {
    int           o_pre;    // @ 0
    struct Middle o_mid;    // @ 8 (Middle aligns 8)
    int           o_post;   // @ 32 (Middle is 24 wide => 8+24=32)
};
// natural: 32 + 4 = 36, padded to 8 => 40

// =========================================================================
// 4. Arrays of structs

struct ArrSlot {
    char     a;     // @ 0
    int      b;     // @ 4
    char     c;     // @ 8 (padded to 12 total, align 4)
};
// per-slot: 12 bytes, align 4

struct ArrayHolder {
    struct ArrSlot slots[3];  // @ 0, 12, 24 -> 36 bytes
    int            count;     // @ 36 (4-aligned, fits)
};
// total: 40

// =========================================================================
// 5. Unions inside structs

union Mix {
    int     i;
    double  d;
    char    s[16];
};
// size = 16, align 8

struct WithUnion {
    char       prefix;    // @ 0
    union Mix  payload;   // @ 8
    int        suffix;    // @ 24
};
// total: 32 (padded to align 8)

// =========================================================================
// 6. #pragma pack(1) -- everything 1-byte aligned

#pragma pack(1)
struct Pack1 {
    char     a;     // @ 0
    int      b;     // @ 1
    char     c;     // @ 5
    long long d;    // @ 6
    short    e;     // @ 14
    char     f;     // @ 16
    double   g;     // @ 17
};
// total = 25

struct Pack1Nest {
    char         pre;    // @ 0
    struct Pack1 inner;  // @ 1 (inner align 1)
    int          post;   // @ 26
};
// total = 30
#pragma pack()

// =========================================================================
// 7. #pragma pack(2)

#pragma pack(2)
struct Pack2 {
    char     a;     // @ 0
    int      b;     // @ 2 (b aligns to min(4, 2)=2; 1->2 pad)
    char     c;     // @ 6
    long long d;    // @ 8 (d aligns to min(8, 2)=2; 7->8 pad)
    short    e;     // @ 16
    char     f;     // @ 18
    double   g;     // @ 20 (align 2; 19->20 pad)
};
// total = 28 (padded to 2)
#pragma pack()

// =========================================================================
// 8. #pragma pack(4)

#pragma pack(4)
struct Pack4 {
    char     a;     // @ 0
    int      b;     // @ 4
    char     c;     // @ 8
    long long d;    // @ 12 (align min(8,4)=4)
    short    e;     // @ 20
    char     f;     // @ 22
    double   g;     // @ 24 (align 4; 23->24 pad)
};
// total = 32
#pragma pack()

// =========================================================================
// 9. Push / pop interleaving

#pragma pack(push, 1)
struct PushedOne {
    char  a;    // @ 0
    int   b;    // @ 1
};
// total = 5

#pragma pack(push, 4)
struct PushedFour {
    char  a;    // @ 0
    int   b;    // @ 4
};
// total = 8

#pragma pack(pop)  // back to 1
struct PoppedToOne {
    char  a;    // @ 0
    int   b;    // @ 1
};
// total = 5

#pragma pack(pop)  // back to default (8)
struct PoppedToDefault {
    char  a;    // @ 0
    int   b;    // @ 4
    long long c;// @ 8
};
// total = 16

// =========================================================================
// 10. Pack on outer, default on inner -- pack only clamps the
// CURRENT struct's field alignment; nested struct fields keep
// the alignment they had at definition time.

struct DefaultInner {
    char a;     // @ 0
    int  b;     // @ 4 (natural alignment)
};
// total = 8

#pragma pack(1)
struct OuterPackedOnly {
    char                 pre;    // @ 0
    struct DefaultInner  inner;  // @ 1 (inner is 8 wide,
                                 //      align min(4, 1)=1)
    char                 post;   // @ 9
};
// total = 10
#pragma pack()

// =========================================================================
// 11. Pointer fields under pack

#pragma pack(2)
struct PackedPtr {
    char  a;    // @ 0
    void *p;    // @ 2 (ptr aligns to min(8, 2)=2)
    char  b;    // @ 10
    void *q;    // @ 12
};
// total = 20
#pragma pack()

// =========================================================================
// Test runner

int main() {
    if (sizeof(struct Mixed) != 40) return 1;
    if (OFF(struct Mixed, a) != 0) return 2;
    if (OFF(struct Mixed, b) != 4) return 3;
    if (OFF(struct Mixed, c) != 8) return 4;
    if (OFF(struct Mixed, d) != 16) return 5;
    if (OFF(struct Mixed, e) != 24) return 6;
    if (OFF(struct Mixed, f) != 26) return 7;
    if (OFF(struct Mixed, g) != 32) return 8;

    // Pure char struct: 4 bytes, align 1 (matches GCC/MSVC).
    if (sizeof(struct Chars) != 4) return 10;
    if (OFF(struct Chars, a) != 0) return 11;
    if (OFF(struct Chars, b) != 1) return 12;
    if (OFF(struct Chars, c) != 2) return 13;
    if (OFF(struct Chars, d) != 3) return 14;

    if (sizeof(struct Inner) != 12) return 20;
    if (OFF(struct Inner, i_a) != 0) return 21;
    if (OFF(struct Inner, i_b) != 4) return 22;
    if (OFF(struct Inner, i_c) != 8) return 23;

    if (sizeof(struct Middle) != 24) return 30;
    if (OFF(struct Middle, m_a) != 0) return 31;
    if (OFF(struct Middle, m_inner) != 4) return 32;
    if (OFF(struct Middle, m_b) != 16) return 33;

    if (sizeof(struct Outer) != 40) return 40;
    if (OFF(struct Outer, o_pre) != 0) return 41;
    if (OFF(struct Outer, o_mid) != 8) return 42;
    if (OFF(struct Outer, o_post) != 32) return 43;

    if (sizeof(struct ArrSlot) != 12) return 50;
    if (sizeof(struct ArrayHolder) != 40) return 51;
    if (OFF(struct ArrayHolder, slots) != 0) return 52;
    if (OFF(struct ArrayHolder, count) != 36) return 53;

    if (sizeof(union Mix) != 16) return 60;
    if (sizeof(struct WithUnion) != 32) return 61;
    if (OFF(struct WithUnion, prefix) != 0) return 62;
    if (OFF(struct WithUnion, payload) != 8) return 63;
    if (OFF(struct WithUnion, suffix) != 24) return 64;

    // pack(1)
    if (sizeof(struct Pack1) != 25) return 70;
    if (OFF(struct Pack1, a) != 0) return 71;
    if (OFF(struct Pack1, b) != 1) return 72;
    if (OFF(struct Pack1, c) != 5) return 73;
    if (OFF(struct Pack1, d) != 6) return 74;
    if (OFF(struct Pack1, e) != 14) return 75;
    if (OFF(struct Pack1, f) != 16) return 76;
    if (OFF(struct Pack1, g) != 17) return 77;

    if (sizeof(struct Pack1Nest) != 30) return 80;
    if (OFF(struct Pack1Nest, pre) != 0) return 81;
    if (OFF(struct Pack1Nest, inner) != 1) return 82;
    if (OFF(struct Pack1Nest, post) != 26) return 83;

    // pack(2)
    if (sizeof(struct Pack2) != 28) return 90;
    if (OFF(struct Pack2, a) != 0) return 91;
    if (OFF(struct Pack2, b) != 2) return 92;
    if (OFF(struct Pack2, c) != 6) return 93;
    if (OFF(struct Pack2, d) != 8) return 94;
    if (OFF(struct Pack2, e) != 16) return 95;
    if (OFF(struct Pack2, f) != 18) return 96;
    if (OFF(struct Pack2, g) != 20) return 97;

    // pack(4)
    if (sizeof(struct Pack4) != 32) return 100;
    if (OFF(struct Pack4, a) != 0) return 101;
    if (OFF(struct Pack4, b) != 4) return 102;
    if (OFF(struct Pack4, c) != 8) return 103;
    if (OFF(struct Pack4, d) != 12) return 104;
    if (OFF(struct Pack4, e) != 20) return 105;
    if (OFF(struct Pack4, f) != 22) return 106;
    if (OFF(struct Pack4, g) != 24) return 107;

    // push / pop
    if (sizeof(struct PushedOne) != 5) return 110;
    if (OFF(struct PushedOne, b) != 1) return 111;

    if (sizeof(struct PushedFour) != 8) return 120;
    if (OFF(struct PushedFour, b) != 4) return 121;

    if (sizeof(struct PoppedToOne) != 5) return 130;
    if (OFF(struct PoppedToOne, b) != 1) return 131;

    if (sizeof(struct PoppedToDefault) != 16) return 140;
    if (OFF(struct PoppedToDefault, a) != 0) return 141;
    if (OFF(struct PoppedToDefault, b) != 4) return 142;
    if (OFF(struct PoppedToDefault, c) != 8) return 143;

    // Outer-packed-only / nested DefaultInner
    if (sizeof(struct DefaultInner) != 8) return 150;
    if (sizeof(struct OuterPackedOnly) != 10) return 151;
    if (OFF(struct OuterPackedOnly, pre) != 0) return 152;
    if (OFF(struct OuterPackedOnly, inner) != 1) return 153;
    if (OFF(struct OuterPackedOnly, post) != 9) return 154;

    // Pointers under pack
    if (sizeof(struct PackedPtr) != 20) return 160;
    if (OFF(struct PackedPtr, a) != 0) return 161;
    if (OFF(struct PackedPtr, p) != 2) return 162;
    if (OFF(struct PackedPtr, b) != 10) return 163;
    if (OFF(struct PackedPtr, q) != 12) return 164;

    return 0;
}
