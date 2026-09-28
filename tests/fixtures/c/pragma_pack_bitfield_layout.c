// Bit-fields under `#pragma pack(N)` are placed contiguously at the bit
// level, straddling storage units, for every N: a pack pragma in effect
// removes the unit-boundary rule the natural layout applies, while the
// pack value still clamps member and aggregate alignment (gcc, clang).
// The sizes, byte images and read-back values below are what gcc and
// clang give on x86-64 and AArch64; a 30-bit field holding 0x2AAAAAAA
// reads back as -357913942. A static or automatic object of
// such a type is initialized through an access window that stays
// inside the object. Returns 0 when every check passes; each failure
// returns a distinct code.
//
// The PE targets take the MS layout instead, where a bit-field keeps a
// unit of its declared type and the pack value only lowers the boundary
// that unit may start on. Their sizes and images are the ones MSVC and
// clang for the windows-msvc triples give.

#include <stdint.h>
#include <string.h>

#pragma pack(push, 1)
struct A1 { int a:30; int b:30; };
struct B1 { char c; int a:15; short s; };
struct C1 { char c; long long a:60; char d; };
struct D1 { unsigned a:22; int b:23; unsigned c:26; int d:5; int e:20; unsigned f:20; };
struct S3 { signed f0:15; };
struct T3 { int f:22; };
union U1 { int f:15; char c; };
#pragma pack(pop)
#pragma pack(push, 2)
struct A2 { char c; int a:30; int b:30; };
struct B2 { char c; int a:15; char d; };
union U2 { int f:15; char c; };
#pragma pack(pop)
#pragma pack(push, 4)
struct A4 { char c; long long a:60; char d; };
struct P4 { char c; int a:30; int b:30; };
#pragma pack(pop)
#pragma pack(push, 16)
struct P16 { char c; int a:30; int b:30; };
#pragma pack(pop)
struct N { char c; int a:30; int b:30; };

static struct D1 g_d1 = {1946, -1905, 5086, 4, 362, 321};
static struct S3 g_s3 = {106};
static struct S3 g_s3_arr[2] = {{-1}, {5}};
static struct T3 g_t3 = {-1000000};
static union U1 g_u1 = {-3};
static struct A2 g_a2 = {1, -1, 0x2AAAAAAA};

static int image_is(const void *p, const unsigned char *want, size_t n)
{
    return memcmp(p, want, n) == 0;
}

int main(void)
{
#if defined(_WIN32)
    if (sizeof(struct A1) != 8 || sizeof(struct B1) != 7 || sizeof(struct C1) != 10) return 1;
    if (sizeof(struct D1) != 20 || sizeof(struct S3) != 4 || sizeof(struct T3) != 4) return 2;
    if (sizeof(union U1) != 4 || sizeof(struct A2) != 10 || sizeof(struct B2) != 8) return 3;
    if (sizeof(union U2) != 4 || _Alignof(union U2) != 1 || _Alignof(struct A2) != 2) return 4;
    if (sizeof(struct A4) != 16 || sizeof(struct P4) != 12 || _Alignof(struct P4) != 4) return 5;
#else
    if (sizeof(struct A1) != 8 || sizeof(struct B1) != 5 || sizeof(struct C1) != 10) return 1;
    if (sizeof(struct D1) != 15 || sizeof(struct S3) != 2 || sizeof(struct T3) != 3) return 2;
    if (sizeof(union U1) != 2 || sizeof(struct A2) != 10 || sizeof(struct B2) != 4) return 3;
    if (sizeof(union U2) != 2 || _Alignof(union U2) != 2 || _Alignof(struct A2) != 2) return 4;
    if (sizeof(struct A4) != 12 || sizeof(struct P4) != 12 || _Alignof(struct P4) != 4) return 5;
#endif
    if (sizeof(struct P16) != 12 || sizeof(struct N) != 12) return 6;

    struct A1 a1;
    memset(&a1, 0, sizeof a1);
    a1.a = -1;
    a1.b = 0x2AAAAAAA;
#if defined(_WIN32)
    static const unsigned char a1_img[8] = {0xff, 0xff, 0xff, 0x3f, 0xaa, 0xaa, 0xaa, 0x2a};
#else
    static const unsigned char a1_img[8] = {0xff, 0xff, 0xff, 0xbf, 0xaa, 0xaa, 0xaa, 0x0a};
#endif
    if (!image_is(&a1, a1_img, 8) || a1.a != -1 || a1.b != -357913942) return 7;

    struct B1 b1;
    memset(&b1, 0, sizeof b1);
    b1.c = 1;
    b1.a = -2;
    b1.s = 0x1234;
#if defined(_WIN32)
    static const unsigned char b1_img[7] = {0x01, 0xfe, 0x7f, 0x00, 0x00, 0x34, 0x12};
#else
    static const unsigned char b1_img[5] = {0x01, 0xfe, 0x7f, 0x34, 0x12};
#endif
    if (!image_is(&b1, b1_img, sizeof b1_img) || b1.c != 1 || b1.a != -2 || b1.s != 0x1234) return 8;

    struct C1 c1;
    memset(&c1, 0, sizeof c1);
    c1.c = 1;
    c1.a = 0x00FFFFFFFFFFFFFFLL;
    c1.d = 2;
    static const unsigned char c1_img[10] = {0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x02};
    if (!image_is(&c1, c1_img, 10) || c1.a != 0x00FFFFFFFFFFFFFFLL || c1.d != 2) return 9;

#if defined(_WIN32)
    static const unsigned char d1_img[20] = {0x9a, 0x07, 0x00, 0x00, 0x8f, 0xf8, 0x7f, 0x00, 0xde, 0x13,
                                             0x00, 0x10, 0x6a, 0x01, 0x00, 0x00, 0x41, 0x01, 0x00, 0x00};
#else
    static const unsigned char d1_img[15] = {0x9a, 0x07, 0xc0, 0x23, 0xfe, 0xdf, 0x7b, 0x02,
                                             0x00, 0xa2, 0x16, 0x00, 0x41, 0x01, 0x00};
#endif
    if (!image_is(&g_d1, d1_img, sizeof d1_img)) return 10;
    if (g_d1.a != 1946 || g_d1.b != -1905 || g_d1.c != 5086 || g_d1.d != 4 || g_d1.e != 362 || g_d1.f != 321) return 11;
    struct D1 d1;
    memset(&d1, 0, sizeof d1);
    d1.a = 1946;
    d1.b = -1905;
    d1.c = 5086;
    d1.d = 4;
    d1.e = 362;
    d1.f = 321;
    if (!image_is(&d1, d1_img, sizeof d1_img)) return 12;

    struct A2 a2;
    memset(&a2, 0, sizeof a2);
    a2.c = 1;
    a2.a = -1;
    a2.b = 0x2AAAAAAA;
#if defined(_WIN32)
    static const unsigned char a2_img[10] = {0x01, 0x00, 0xff, 0xff, 0xff, 0x3f, 0xaa, 0xaa, 0xaa, 0x2a};
#else
    static const unsigned char a2_img[10] = {0x01, 0xff, 0xff, 0xff, 0xbf, 0xaa, 0xaa, 0xaa, 0x0a, 0x00};
#endif
    if (!image_is(&a2, a2_img, 10) || !image_is(&g_a2, a2_img, 10) || a2.a != -1 || g_a2.b != -357913942) return 13;

    struct B2 b2;
    memset(&b2, 0, sizeof b2);
    b2.c = 1;
    b2.a = -2;
    b2.d = 3;
#if defined(_WIN32)
    static const unsigned char b2_img[8] = {0x01, 0x00, 0xfe, 0x7f, 0x00, 0x00, 0x03, 0x00};
#else
    static const unsigned char b2_img[4] = {0x01, 0xfe, 0x7f, 0x03};
#endif
    if (!image_is(&b2, b2_img, sizeof b2_img) || b2.a != -2 || b2.d != 3) return 14;

    struct A4 a4;
    memset(&a4, 0, sizeof a4);
    a4.c = 1;
    a4.a = 0x00FFFFFFFFFFFFFFLL;
    a4.d = 2;
#if defined(_WIN32)
    static const unsigned char a4_img[16] = {0x01, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
                                             0xff, 0xff, 0xff, 0x00, 0x02, 0x00, 0x00, 0x00};
#else
    static const unsigned char a4_img[12] = {0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x02, 0x00, 0x00};
#endif
    if (!image_is(&a4, a4_img, sizeof a4_img) || a4.a != 0x00FFFFFFFFFFFFFFLL || a4.d != 2) return 15;

    // pack(4) and pack(16) leave the int's own alignment in force yet
    // still place the fields contiguously; the natural layout bumps
    // `a` to the next unit, as the MS layout does under both.
    struct P4 p4;
    struct P16 p16;
    struct N n;
    memset(&p4, 0, sizeof p4);
    memset(&p16, 0, sizeof p16);
    memset(&n, 0, sizeof n);
    p4.c = p16.c = n.c = 1;
    p4.a = p16.a = n.a = -1;
    p4.b = p16.b = n.b = 0x2AAAAAAA;
#if defined(_WIN32)
    static const unsigned char p4_img[12] = {0x01, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x3f, 0xaa, 0xaa, 0xaa, 0x2a};
#else
    static const unsigned char p4_img[12] = {0x01, 0xff, 0xff, 0xff, 0xbf, 0xaa, 0xaa, 0xaa, 0x0a, 0x00, 0x00, 0x00};
#endif
    static const unsigned char n_img[12] = {0x01, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x3f, 0xaa, 0xaa, 0xaa, 0x2a};
    if (!image_is(&p4, p4_img, 12) || !image_is(&p16, p4_img, 12) || !image_is(&n, n_img, 12)) return 16;
    if (p4.a != -1 || p16.b != -357913942 || n.a != -1 || n.b != -357913942) return 17;

    // The fuzzer's shape: a packed struct holding one bit-field, as a
    // static, an array of statics, an automatic and a block-scope
    // static. Each window must stay inside its 2- or 3-byte object.
    if (g_s3.f0 != 106 || g_s3_arr[0].f0 != -1 || g_s3_arr[1].f0 != 5) return 18;
    if (g_t3.f != -1000000) return 19;
    struct S3 l_s3 = {106};
    struct T3 l_t3 = {-1000000};
    static struct S3 s_s3 = {-3};
    if (l_s3.f0 != 106 || l_t3.f != -1000000 || s_s3.f0 != -3) return 20;
    l_s3.f0 = -7;
    l_t3.f = 1000000;
    if (l_s3.f0 != -7 || l_t3.f != 1000000) return 21;

    static const unsigned char u1_img[2] = {0xfd, 0x7f};
    if (!image_is(&g_u1, u1_img, 2) || g_u1.f != -3) return 22;
    union U2 u2;
    memset(&u2, 0, sizeof u2);
    u2.f = -3;
    if (!image_is(&u2, u1_img, 2) || u2.f != -3 || u2.c != (char)0xfd) return 23;
    return 0;
}
