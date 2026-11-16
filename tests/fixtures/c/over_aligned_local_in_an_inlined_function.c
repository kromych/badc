// Functions holding automatic objects aligned above 16 are inlined at -O
// into a caller with an over-aligned object of its own: each object keeps
// its alignment in the caller's realigned frame. Exits 0 when every
// address is aligned and every value survives.

#include <stdint.h>

static inline int sum32(int k) {
    _Alignas(32) int buf[8];
    for (int i = 0; i < 8; i++)
        buf[i] = k + i;
    int s = (uintptr_t)buf & 31 ? 1000 : 0;
    for (int i = 0; i < 8; i++)
        s += buf[i];
    return s;
}

static inline int sum64(int k) {
    _Alignas(64) char c[3];
    c[0] = (char)k;
    c[1] = 1;
    c[2] = 2;
    return ((uintptr_t)c & 63 ? 1000 : 0) + c[0] + c[1] + c[2];
}

int main(void) {
    _Alignas(16) int own[4] = {1, 2, 3, 4};
    int t = 0;
    for (int k = 0; k < 3; k++)
        t += sum32(k) + sum64(k);
    int want = (28 + 36 + 44) + (3 + 4 + 5);
    return t == want && ((uintptr_t)own & 15) == 0 && own[3] == 4 ? 0 : 1;
}
