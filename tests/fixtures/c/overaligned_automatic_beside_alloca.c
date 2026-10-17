// An automatic object aligned above 16 shares its function with `alloca`
// and with a variable-length array (C11 6.7.5, C99 6.7.6.2): the prologue
// realigns the frame, sp then moves at each allocation, and the objects
// keep their alignment and their values. A function the program never calls
// holds the combination too. The exit code names the failing shape.

#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

static volatile int sink;

NOINLINE static void touch(char *p, int n)
{
    p[0] = (char)n;
    sink += p[0];
}

NOINLINE static int with_alloca(int n)
{
    _Alignas(64) char a[64];
    _Alignas(256) long b[4];
    memset(a, 1, sizeof a);
    for (int i = 0; i < 4; i++)
        b[i] = i + n;
    int bad = 0;
    for (int k = 1; k <= 3; k++) {
        char *p = __builtin_alloca(n * k);
        memset(p, k, n * k);
        touch(p, k);
        bad |= ((uintptr_t)a & 63) != 0 || ((uintptr_t)b & 255) != 0;
        bad |= a[17] != 1 || b[3] != 3 + n || p[n * k - 1] != k;
    }
    return bad;
}

NOINLINE static int with_vla(int n)
{
    _Alignas(128) int c[8];
    for (int i = 0; i < 8; i++)
        c[i] = i * n;
    int bad = 0;
    for (int k = 1; k <= 3; k++) {
        char v[n * k + 1];
        memset(v, k, sizeof v);
        touch(v, k);
        bad |= ((uintptr_t)c & 127) != 0 || c[7] != 7 * n || v[n * k] != k;
    }
    return bad;
}

static int never_called(int n)
{
    _Alignas(32) char d[32];
    char *p = __builtin_alloca(n);
    d[0] = p[0];
    return d[0];
}

int main(void)
{
    (void)never_called;
    if (with_alloca(5))
        return 1;
    if (with_vla(7))
        return 2;
    return 0;
}
