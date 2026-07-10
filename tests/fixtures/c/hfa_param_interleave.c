// AAPCS64 register/stack interleave with by-value aggregate parameters.
// Four 2-float homogeneous aggregates exhaust the eight FP argument
// registers (NSRN = 8); the trailing scalar float then overflows to the
// stack while the final integer-class aggregate still takes an integer
// register. The placement interleaves register and stack arguments by
// parameter position, which the contiguous-prefix c5 cdecl cell layout
// cannot express, so the callee prologue spills each parameter into its
// own position's cell. The scalar all-integer fallback does not apply:
// an aggregate cannot be re-routed through the integer bank by clearing
// the FP mask. This is a real-world drawing-API parameter shape.

typedef struct {
    float x, y;
} V2;
typedef struct {
    unsigned char r, g, b, a;
} Col;

static float sum(V2 a, V2 b, V2 c, V2 d, float thick, Col col) {
    return a.x + a.y + b.x + b.y + c.x + c.y + d.x + d.y + thick +
           (float)(col.r + col.g + col.b + col.a);
}

int main(void) {
    V2 a = {1, 2}, b = {3, 4}, c = {5, 6}, d = {7, 8};
    Col col = {1, 2, 3, 4};
    // 1+2+...+8 = 36; + 9.5 = 45.5; col 1+2+3+4 = 10; total 55.5.
    if (sum(a, b, c, d, 9.5f, col) != 55.5f) return 1;
    // A second call whose stacked float carries a fractional value the
    // overflow slot must preserve across the interleave.
    V2 z = {0, 0};
    if (sum(z, z, z, z, 0.25f, col) != 10.25f) return 2;
    return 0;
}
