// A bit-field placed contiguously under `#pragma pack` can span more
// bytes than its base type: `unsigned b : 30` at bit 29 occupies bytes 3
// to 7. An aggregate of such fields crossing a call by value moves whole
// registers; a copy that took the base type's width carried four bytes
// of an eight-byte object and left the rest of the destination as it
// was. The fuzzer's shape returned a global of that type and stored the
// result through a pointer. The MS layout, which the PE targets take,
// keeps each bit-field in a unit of its declared type under the pragma,
// so there `struct w` is 17 bytes (MSVC, and clang for the windows-msvc
// triples). Returns 0 when every check passes.

#include <stdint.h>

#pragma pack(1)
struct a {
    unsigned : 29;
    unsigned b : 30;
};
struct s {
    signed f0 : 29;
    signed f1 : 30;
};
struct w {
    uint32_t f0 : 20;
    uint64_t f1 : 44;
    uint32_t f2 : 20;
    uint8_t f3;
};
#pragma pack()

static struct a e;
static struct a *f = &e;
static struct a h;
static struct s g_52;
static struct s g_54;
static struct w gw;

static struct a ret_a(void)
{
    for (;;)
        return h;
}

static int8_t take_a(struct a k)
{
    uint8_t l = 5;
    *f = k;
    return l;
}

static struct s ret_s(void)
{
    return g_52;
}

static struct w ret_w(struct w v)
{
    v.f3 += 1;
    return v;
}

int main(void)
{
#if defined(_WIN32)
    if (sizeof(struct a) != 8 || sizeof(struct s) != 8 || sizeof(struct w) != 17) return 1;
#else
    if (sizeof(struct a) != 8 || sizeof(struct s) != 8 || sizeof(struct w) != 12) return 1;
#endif
    h.b = 0x2AAAAAAA;
    {
        struct a j = ret_a();
        if (take_a(j) != 5) return 2;
    }
    if (e.b != 0x2AAAAAAA) return 3;
    g_52.f0 = -5;
    g_52.f1 = 77;
    struct s *l_53 = &g_54;
    *l_53 = ret_s();
    if (g_54.f0 != -5 || g_54.f1 != 77) return 4;
    gw.f0 = 0xFFFFF;
    gw.f1 = 0x7FFFFFFFFFFull;
    gw.f2 = 0xABCDE;
    gw.f3 = 9;
    struct w r = ret_w(gw);
    if (r.f0 != 0xFFFFF || r.f1 != 0x7FFFFFFFFFFull || r.f2 != 0xABCDE || r.f3 != 10) return 5;
    return 0;
}
