// A variable-length array aligned above 16, through an over-aligned element
// type and through `_Alignas` on its declaration (C11 6.7.5, C99 6.7.6.2),
// lands on its alignment at every allocation of a loop, beside arrays that
// leave sp at varied offsets, and keeps to its own bytes. A function the
// program never calls holds both forms too. The exit code names the
// failing shape.

#include <stddef.h>
#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

typedef struct {
    _Alignas(64) char c[64];
} B64;

typedef struct {
    _Alignas(32) int x;
} B32;

static volatile int sink;

NOINLINE static void touch(void *p, int n)
{
    ((char *)p)[0] = (char)n;
    sink += n;
}

static int intact(const char *p, size_t n, char c)
{
    for (size_t i = 0; i < n; i++)
        if (p[i] != c)
            return 0;
    return 1;
}

NOINLINE static int element_aligned(int n)
{
    int bad = 0;
    for (int k = 1; k <= 4; k++) {
        char pad[k * 3 + 1];
        memset(pad, 0x5a, sizeof pad);
        B64 v[n + k];
        memset(v, k, sizeof v);
        touch(v, k);
        B32 w[n];
        memset(w, k + 1, sizeof w);
        bad |= (uintptr_t)v % 64 != 0 || (uintptr_t)&v[1] % 64 != 0;
        bad |= (uintptr_t)w % 32 != 0 || sizeof v != (size_t)(n + k) * 64;
        bad |= v[n + k - 1].c[63] != k || !intact(pad, sizeof pad, 0x5a);
    }
    return bad;
}

NOINLINE static int declaration_aligned(int n)
{
    int bad = 0;
    for (int k = 1; k <= 4; k++) {
        char pad[k * 5 + 1];
        memset(pad, 0x5a, sizeof pad);
        _Alignas(128) char v[n + k];
        memset(v, k, sizeof v);
        touch(v, k);
        bad |= (uintptr_t)v % 128 != 0 || sizeof v != (size_t)(n + k);
        bad |= v[n + k - 1] != k || !intact(pad, sizeof pad, 0x5a);
    }
    return bad;
}

static int never_called(int n)
{
    B64 v[n];
    _Alignas(64) char w[n];
    v[0].c[0] = 1;
    w[0] = 2;
    return v[0].c[0] + w[0];
}

int main(void)
{
    (void)never_called;
    if (element_aligned(3))
        return 1;
    if (declaration_aligned(3))
        return 2;
    return 0;
}
