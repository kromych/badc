// A call's aggregate result is an object aligned for its type (C11 6.2.4p8,
// 6.7.5), whichever way the ABI returns it: through the result pointer, which
// the callee may store through with instructions that need the alignment, or
// in registers the caller stores. Each probe holds a different count of 8-byte
// locals, so a result placed at a frame slot's alignment lands off its own in
// at least one of them. A 32-aligned result realigns the frame, also around a
// call passing arguments on the stack; the VLA probe keeps a static frame for
// the 16-aligned results.
#include <stdint.h>
#include <string.h>

struct m16 { _Alignas(16) char a[32]; };
struct r16 { _Alignas(16) char a[16]; };
struct m32 { _Alignas(32) char a[64]; };

static struct m16 make_m16(char c) { struct m16 r; memset(r.a, c, sizeof r.a); return r; }
static struct r16 make_r16(char c) { struct r16 r; memset(r.a, c, sizeof r.a); return r; }
static struct m32 make_m32(char c) { struct m32 r; memset(r.a, c, sizeof r.a); return r; }

static struct m32 make_m32_args(char c, long a, long b, long d, long e, long f, long g,
                                long h, long i) {
    struct m32 r;
    memset(r.a, (char)(c + a + b + d + e + f + g + h + i - 36), sizeof r.a);
    return r;
}

static int off(const char *p, uintptr_t align) { return (int)((uintptr_t)p & (align - 1)); }

static int results(char c) {
    int bad = off(make_m16(c).a, 16) + off(make_r16(c).a, 16) + off(make_m32(c).a, 32);
    return bad ? 1000 + bad : make_m16(c).a[31] + make_r16(c).a[15] + make_m32(c).a[63] - 3 * c;
}

static int probe1(char c) {
    volatile long x = c;
    return results(c) + (int)(x - c) + off(make_m16(c).a, 16) + off(make_r16(c).a, 16);
}

static int probe2(char c) {
    volatile long x = c, y = c;
    int bad = off(make_m32_args(c, 1, 2, 3, 4, 5, 6, 7, 8).a, 32);
    return results(c) + (int)(x - y) + off(make_m16(c).a, 16) + off(make_r16(c).a, 16)
        + off(make_m32(c).a, 32) + bad * 100 + make_m32_args(c, 1, 2, 3, 4, 5, 6, 7, 8).a[5]
        - c;
}

static int probe3(char c) {
    volatile long x = c, y = c, z = c;
    return (int)(x + y - 2 * z) + off(make_m16(c).a, 16) + off(make_r16(c).a, 16)
        + off(make_m32(c).a, 32);
}

static int probe_vla(int n, char c) {
    char buf[n];
    memset(buf, c, (size_t)n);
    return off(make_m16(c).a, 16) + off(make_r16(c).a, 16) + buf[n - 1] - c;
}

int main(void) {
    if (results(1) != 0) return 1;
    if (probe1(2) != 0) return 2;
    if (probe2(3) != 0) return 3;
    if (probe3(4) != 0) return 4;
    if (probe_vla(5, 5) != 0) return 5;
    if (probe_vla(6, 6) != 0) return 6;
    return 0;
}
