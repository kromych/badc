/* A lane of an 8-byte GNU vector read and written by subscript, at 8-,
 * 16- and 32-bit lanes, after and before whole-vector arithmetic: each lane
 * holds what the scalar operation gives, and a write leaves the other lanes.
 * Each failing group returns its own code. */
typedef signed char v8b __attribute__((vector_size(8)));
typedef short v4h __attribute__((vector_size(8)));
typedef unsigned v2s __attribute__((vector_size(8)));

__attribute__((noinline)) static int read_b(v8b a, v8b b, int i) { v8b v = a + b; return v[i & 7] + v[7]; }
__attribute__((noinline)) static v4h write_h(v4h a, v4h b, short x) { v4h v = a - b; v[2] = x; return v; }
__attribute__((noinline)) static unsigned read_s(v2s a) { v2s v = a ^ (v2s){1, 2}; return v[1]; }

int main(void) {
    v8b a = {1, 2, 3, 4, 5, 6, 7, 120}, b = {10, 20, 30, 40, 50, 60, 70, 7};
    if (read_b(a, b, 3) != 44 + (signed char)127) return 1;
    if (read_b(a, b, 0) != 11 + 127) return 2;
    v4h c = {100, 200, 300, -400}, d = {1, 2, 3, 4};
    v4h r = write_h(c, d, -7);
    if (r[0] != 99 || r[1] != 198 || r[2] != -7 || r[3] != -404) return 3;
    if (read_s((v2s){0xffffffffu, 0x80000000u}) != 0x80000002u) return 4;
    v4h e = r;
    e[0] = e[3];
    if (e[0] != -404 || e[1] != 198) return 5;
    return 0;
}
