// `#pragma pack(push)` with no value saves the value in effect, so the
// `pack(1)` that follows it ends at the `pack(pop)`; a labelled push is
// popped by name; `pack(pop, N)` restores and then sets N. The sizes are
// what gcc and clang give. The fuzzer's shape was a union whose struct
// member was declared after such a sequence: the member's 64-bit field
// was laid out at offset 2 instead of 8, over the bit-field it shares
// storage with. Returns 0 when every check passes.

#include <stddef.h>
#include <stdint.h>
#include <string.h>

#pragma pack(push)
#pragma pack(1)
struct A { char c; int i; };
#pragma pack(pop)
struct B { char c; int i; };

#pragma pack(push, 1)
struct C { char c; int i; };
#pragma pack(pop)
struct D { char c; int i; };

#pragma pack(push, outer, 2)
#pragma pack(push, inner, 1)
struct E { char c; int i; };
#pragma pack(pop, outer)
struct F { char c; int i; };

#pragma pack(push)
#pragma pack(2)
#pragma pack(1)
struct G { char c; int i; };
#pragma pack(pop, 4)
struct H { char c; long long l; };
#pragma pack()
struct I { char c; long long l; };

#pragma pack(pop)
struct J { char c; int i; };

#pragma pack(push)
#pragma pack(1)
struct S1 { volatile int32_t f0; };
#pragma pack(pop)
struct S2 { uint16_t f0; uint64_t f1; int16_t f2; };
union U4 { volatile signed f0 : 21; int16_t f1; int32_t f2; struct S2 f3; };

static union U4 g_75;

static void write_member(void)
{
    for (g_75.f3.f1 = 29; g_75.f3.f1 < 56; ++g_75.f3.f1)
        ;
}

int main(void)
{
    if (sizeof(struct A) != 5 || sizeof(struct B) != 8) return 1;
    if (sizeof(struct C) != 5 || sizeof(struct D) != 8) return 2;
    if (sizeof(struct E) != 5 || sizeof(struct F) != 8) return 3;
    if (sizeof(struct G) != 5 || sizeof(struct H) != 12) return 4;
    if (sizeof(struct I) != 16 || sizeof(struct J) != 8) return 5;
    if (sizeof(struct S1) != 4 || sizeof(struct S2) != 24 || sizeof(union U4) != 24) return 6;
    if (offsetof(struct S2, f1) != 8 || offsetof(struct S2, f2) != 16) return 7;
    write_member();
    if (g_75.f0 != 0 || g_75.f1 != 0 || g_75.f2 != 0 || g_75.f3.f1 != 56) return 8;
    unsigned char image[24];
    memset(image, 0, sizeof image);
    image[8] = 56;
    if (memcmp(&g_75, image, sizeof image) != 0) return 9;
    return 0;
}
