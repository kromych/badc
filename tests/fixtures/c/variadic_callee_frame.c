// A variadic callee's prologue does, after its register save area, what any
// callee's does: it keeps the x8 result pointer an AArch64 aggregate return
// over 16 bytes writes through (AAPCS64 6.9), and aligns the frame region an
// object aligned above 16 lives in (C11 6.7.5).
#include <stdarg.h>
#include <stdint.h>

typedef long long ll;
struct big { ll a, b, c; };

static volatile uintptr_t sink;

static struct big three(int n, ...) {
    va_list ap;
    va_start(ap, n);
    ll v = va_arg(ap, ll);
    ll w = va_arg(ap, ll);
    va_end(ap);
    struct big r = { n, v, w };
    return r;
}

static int aligned64(int n, ...) {
    _Alignas(64) char buf[64];
    va_list ap;
    va_start(ap, n);
    int v = va_arg(ap, int);
    va_end(ap);
    buf[0] = (char)v;
    sink = (uintptr_t)buf;
    return (int)((uintptr_t)buf & 63) + buf[0] - v + n - 4;
}

static struct big both(int n, ...) {
    _Alignas(32) ll arr[4];
    va_list ap;
    va_start(ap, n);
    for (int i = 0; i < 4; i++) arr[i] = va_arg(ap, ll);
    va_end(ap);
    sink = (uintptr_t)arr;
    struct big r = { arr[0] + arr[1], arr[2] + arr[3], (ll)((uintptr_t)arr & 31) + n };
    return r;
}

int main(void) {
    struct big r = three(1, 2LL, 3LL);
    if (r.a != 1 || r.b != 2 || r.c != 3) return 1;
    if (aligned64(4, 4) != 0) return 2;
    r = both(7, 1LL, 2LL, 3LL, 4LL);
    if (r.a != 3 || r.b != 7 || r.c != 7) return 3;
    return 0;
}
