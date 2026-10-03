// A bit-field of a packed aggregate is read and written with accesses that
// stay inside the object: placed against an inaccessible page, fields spanning
// most of 3-, 5-, 6- and 7-byte aggregates, under `#pragma pack` and
// `__attribute__((packed))`, at the first byte and past it, are stored,
// updated in place and read back, and the bits beside each field keep their
// values. The MS layout of the Windows targets gives each field a whole unit
// of its type, so the aggregates are larger there and the last byte lies
// outside the field.
#include <string.h>
#if defined(_WIN32)
#include <windows.h>
#define GNU_LAYOUT 0
#else
#include <sys/mman.h>
#include <unistd.h>
#define GNU_LAYOUT 1
#endif

/* The aggregate's last byte, where the GNU layout puts the field's top bits. */
#define LAST_IS(v) (!GNU_LAYOUT || end[-1] == (v))

#pragma pack(push, 1)
struct t3 { int f : 22; };
struct t5 { long long f : 36; };
struct t6 { long long f : 44; };
struct t7 { long long f : 52; };
struct u3 { unsigned char c : 4; int f : 20; };
#pragma pack(pop)
struct __attribute__((packed)) p3 { unsigned f : 23; };
struct __attribute__((packed)) p7 { unsigned char c; unsigned long long f : 48; };

/* The first byte past the usable bytes that end at an inaccessible page. */
static unsigned char *page_end(void) {
#if defined(_WIN32)
    SYSTEM_INFO si;
    GetSystemInfo(&si);
    size_t page = si.dwPageSize;
    unsigned char *p = VirtualAlloc(NULL, 2 * page, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
    DWORD old;
    if (!p || !VirtualProtect(p + page, page, PAGE_NOACCESS, &old)) return 0;
#else
    size_t page = (size_t)sysconf(_SC_PAGESIZE);
    unsigned char *p =
        mmap(NULL, 2 * page, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (p == MAP_FAILED || mprotect(p + page, page, PROT_NONE) != 0) return 0;
#endif
    return p + page;
}

int main(void) {
    unsigned char *end = page_end();
    if (!end) return 1;
    struct t3 *a = (struct t3 *)(end - sizeof(struct t3));
    struct t5 *b = (struct t5 *)(end - sizeof(struct t5));
    struct t6 *c = (struct t6 *)(end - sizeof(struct t6));
    struct t7 *d = (struct t7 *)(end - sizeof(struct t7));
    struct u3 *e = (struct u3 *)(end - sizeof(struct u3));
    struct p3 *f = (struct p3 *)(end - sizeof(struct p3));
    struct p7 *g = (struct p7 *)(end - sizeof(struct p7));
    static const unsigned sizes[2][7] = { { 4, 8, 8, 8, 5, 4, 9 }, { 3, 5, 6, 7, 3, 3, 7 } };
    const unsigned *size = sizes[GNU_LAYOUT];
    if (sizeof(struct t3) != size[0] || sizeof(struct t5) != size[1]
        || sizeof(struct t6) != size[2] || sizeof(struct t7) != size[3]
        || sizeof(struct u3) != size[4] || sizeof(struct p3) != size[5]
        || sizeof(struct p7) != size[6])
        return 2;

    /* Each store keeps the bits above the field: the last byte's top bits. */
    memset(end - 16, 0xff, 16);
    a->f = -5;
    a->f += 7;
    if (a->f != 2 || !LAST_IS(0xc0)) return 3;

    memset(end - 16, 0xff, 16);
    b->f = -0x123456789LL;
    if (b->f != -0x123456789LL || !LAST_IS(0xfe)) return 4;
    b->f = 5;
    if (b->f != 5 || !LAST_IS(0xf0)) return 5;

    memset(end - 16, 0xff, 16);
    c->f = 0x7ffffffffffLL;
    c->f -= 1;
    if (c->f != 0x7fffffffffeLL || !LAST_IS(0xf7)) return 6;

    memset(end - 16, 0xff, 16);
    d->f = -1;
    d->f ^= 0x5;
    if (d->f != -6 || !LAST_IS(0xff)) return 7;
    d->f = 0;
    if (d->f != 0 || !LAST_IS(0xf0)) return 8;

    /* A field past the first bits: the bits below it stay. */
    memset(end - 16, 0, 16);
    e->c = 9;
    e->f = -0x12345;
    if (e->f != -0x12345 || e->c != 9) return 9;
    e->f++;
    if (e->f != -0x12344 || e->c != 9) return 10;

    memset(end - 16, 0xff, 16);
    f->f = 0x2aaaaa;
    if (f->f != 0x2aaaaa || !LAST_IS(0xaa)) return 11;

    /* A field at the second byte, the unit's pieces off their alignment. */
    memset(end - 16, 0, 16);
    g->c = 0x5a;
    g->f = 0xfedcba987654ULL;
    if (g->f != 0xfedcba987654ULL || g->c != 0x5a || !LAST_IS(0xfe)) return 12;
    g->f >>= 4;
    if (g->f != 0x0fedcba98765ULL || g->c != 0x5a) return 13;
    return 0;
}
