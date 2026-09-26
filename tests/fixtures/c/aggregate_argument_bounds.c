// An aggregate passed or returned in registers moves with accesses that stay
// inside the object: placed against an inaccessible page, structs of 3, 5, 6,
// 7, 11 and 12 bytes cross calls as named and variadic arguments and as a
// returned value without reading past their last byte.
#include <stdarg.h>
#include <string.h>
#if defined(_WIN32)
#include <windows.h>
#else
#include <sys/mman.h>
#include <unistd.h>
#endif

struct s3 { char c[3]; };
struct s5 { char c[5]; };
struct s6 { short s[3]; };
struct s7 { char c[7]; };
struct s11 { char c[11]; };
struct f3 { float x, y, z; };

/* The first byte past `size` usable bytes that end at an inaccessible page. */
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

static int take3(struct s3 s) { return s.c[0] + s.c[2]; }
static int take5(struct s5 s) { return s.c[0] + s.c[4]; }
static int take6(struct s6 s) { return s.s[0] + s.s[2]; }
static int take7(struct s7 s) { return s.c[0] + s.c[6]; }
static int take11(struct s11 s) { return s.c[0] + s.c[10]; }
static float takef3(struct f3 s) { return s.x + s.z; }
static struct s7 back7(const struct s7 *p) { return *p; }
static struct f3 backf3(const struct f3 *p) { return *p; }

static int va(int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct s3 a = va_arg(ap, struct s3);
    struct s5 b = va_arg(ap, struct s5);
    struct s6 c = va_arg(ap, struct s6);
    struct s7 d = va_arg(ap, struct s7);
    struct s11 e = va_arg(ap, struct s11);
    va_end(ap);
    return n + a.c[2] + b.c[4] + c.s[2] + d.c[6] + e.c[10];
}

int main(void) {
    unsigned char *end = page_end();
    if (!end) return 1;
    unsigned char bytes[12] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
    struct s3 *a = (struct s3 *)(end - sizeof(struct s3));
    struct s5 *b = (struct s5 *)(end - sizeof(struct s5));
    struct s6 *c = (struct s6 *)(end - sizeof(struct s6));
    struct s7 *d = (struct s7 *)(end - sizeof(struct s7));
    struct s11 *e = (struct s11 *)(end - sizeof(struct s11));
    struct f3 *f = (struct f3 *)(end - sizeof(struct f3));
    memcpy(end - 12, bytes, 12);
    /* Each object's first byte, and its last, which is the page's. */
    if (take3(*a) != 10 + 12) return 2;
    if (take5(*b) != 8 + 12) return 3;
    if (take6(*c) != (7 | 8 << 8) + (11 | 12 << 8)) return 4;
    if (take7(*d) != 6 + 12) return 5;
    if (take11(*e) != 2 + 12) return 6;
    if (back7(d).c[6] != 12) return 7;
    if (va(1, *a, *b, *c, *d, *e) != 1 + 12 + 12 + (11 | 12 << 8) + 12 + 12) return 8;
    struct f3 g = { 1.5f, 2.5f, 3.5f };
    memcpy(f, &g, sizeof g);
    if (takef3(*f) != 5.0f) return 9;
    if (backf3(f).z != 3.5f) return 10;
    return 0;
}
