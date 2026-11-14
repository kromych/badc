// __builtin_shufflevector takes each result lane from its lane of the
// first operand followed by the second: an interleave of two byte
// vectors, a reversal, a concatenation into a wider vector, two lanes into
// a narrower one, and float lanes moved as their bits, a signaling NaN
// included, with an undefined lane left out of the check. The hash is
// clang's; returns 0 when it matches.
#include <string.h>
typedef unsigned char v16 __attribute__((vector_size(16)));
typedef int v4 __attribute__((vector_size(16)));
typedef float f4 __attribute__((vector_size(16)));
typedef int v8 __attribute__((vector_size(32)));
typedef int v2 __attribute__((vector_size(8)));
__attribute__((noinline)) v16 zip(v16 a, v16 b) { return __builtin_shufflevector(a, b, 0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23); }
__attribute__((noinline)) v4 rev(v4 a) { return __builtin_shufflevector(a, a, 3, 2, 1, 0); }
__attribute__((noinline)) v8 cat(v4 a, v4 b) { return __builtin_shufflevector(a, b, 0, 1, 2, 3, 4, 5, 6, 7); }
__attribute__((noinline)) v2 lo(v4 a, v4 b) { return __builtin_shufflevector(a, b, 7, 0); }
__attribute__((noinline)) f4 fsh(f4 a, f4 b) { return __builtin_shufflevector(a, b, 4, -1, 2, 5); }
int main(void) {
    v16 a, b; for (int i = 0; i < 16; i++) { a[i] = (unsigned char)i; b[i] = (unsigned char)(100 + i); }
    v16 z = zip(a, b); unsigned h = 0; for (int i = 0; i < 16; i++) h = h * 31 + z[i];
    v4 x = {1, 2, 3, 4}, y = {5, 6, 7, 8};
    v4 r = rev(x); v8 c = cat(x, y); v2 l = lo(x, y);
    for (int i = 0; i < 4; i++) h = h * 31 + (unsigned)r[i];
    for (int i = 0; i < 8; i++) h = h * 31 + (unsigned)c[i];
    h = h * 31 + (unsigned)l[0]; h = h * 31 + (unsigned)l[1];
    union { unsigned u; float f; } sn = {0x7fa00001u};
    f4 fa = {1.5f, sn.f, 3.5f, 4.5f}, fb = {sn.f, -2.0f, 0.0f, 9.0f};
    f4 fr = fsh(fa, fb); unsigned w[4]; memcpy(w, &fr, 16);
    h = h * 31 + w[0]; h = h * 31 + w[2]; h = h * 31 + w[3];
    return h == 0xcd89f746u ? 0 : 1;
}
