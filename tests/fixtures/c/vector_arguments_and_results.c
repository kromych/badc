// GNU vectors as arguments and results: 16-byte integer and float vectors,
// an 8-byte vector, a record of two vectors (an AAPCS64 homogeneous vector
// aggregate), and a vector carried through a loop of calls. Returns 0 when
// every check passes; each failure returns a distinct code.

typedef int v4i __attribute__((vector_size(16)));
typedef float v4f __attribute__((vector_size(16)));
typedef short v4s __attribute__((vector_size(8)));
typedef struct {
    v4f lo, hi;
} v8f;

__attribute__((noinline)) v4i add(v4i a, v4i b) { return a + b; }
__attribute__((noinline)) v4f fma4(v4f a, v4f x, v4f y) { return a * x + y; }
__attribute__((noinline)) v4s neg(v4s a) { return -a; }
__attribute__((noinline)) v8f swap(v8f v) {
    v8f r = {v.hi, v.lo};
    return r;
}
__attribute__((noinline)) v4i spin(v4i a, v4i step, int n) {
    for (int i = 0; i < n; i++) a = add(a, step);
    return a;
}

int main(void) {
    v4i s = add((v4i){1, 2, 3, 4}, (v4i){10, 20, 30, -40});
    if (s[0] != 11 || s[1] != 22 || s[2] != 33 || s[3] != -36) return 1;
    v4f f = fma4((v4f){1, 2, 3, 4}, (v4f){2, 2, 2, 2}, (v4f){0.5f, 0.5f, 0.5f, 0.5f});
    if (f[0] != 2.5f || f[3] != 8.5f) return 2;
    v4s n = neg((v4s){1, -2, 3, -4});
    if (n[0] != -1 || n[1] != 2 || n[3] != 4) return 3;
    v8f w = swap((v8f){{1, 2, 3, 4}, {5, 6, 7, 8}});
    if (w.lo[0] != 5 || w.hi[3] != 4) return 4;
    v4i z = spin((v4i){0, 1, 2, 3}, (v4i){1, 1, 1, 1}, 5);
    if (z[0] != 5 || z[3] != 8) return 5;
    return 0;
}
