// C99 6.2.5: `float` is an IEEE 754 single-precision type with
// `sizeof(float) == 4`. The c5 storage model now matches: a
// `float` variable / struct field / array element occupies four
// bytes and round-trips through the narrow load + store ops
// (`Op::Lf` / `Op::Sf`) which widen to / narrow from f64 at the
// memory boundary while the accumulator and arithmetic ops stay
// f64-shaped.

#include <stdio.h>
#include <string.h>

struct S {
    float f;
    int   g;
};

static float globals[4] = { 1.5f, 2.5f, 3.5f, 4.5f };

static float passthrough(float x) {
    return x;
}

static float add3(float a, float b, float c) {
    return a + b + c;
}

int main(void) {
    int rc = 0;

    // sizeof on the type form.
    if (sizeof(float) != 4) {
        printf("FAIL sizeof(float)=%zu\n", sizeof(float));
        rc = 1;
    }
    if (sizeof(double) != 8) {
        printf("FAIL sizeof(double)=%zu\n", sizeof(double));
        rc = 2;
    }

    // sizeof on an lvalue of float type.
    float fv = 0.0f;
    if (sizeof(fv) != 4) {
        printf("FAIL sizeof(fv)=%zu\n", sizeof(fv));
        rc = 3;
    }

    // Struct field offset: `g` lives at offset 4, right after `f`,
    // not at offset 8 (which is what the f64-shaped storage gave).
    struct S s;
    s.f = 1.5f;
    s.g = 0x12345678;
    int *p = (int *)&s;
    if (p[1] != 0x12345678) {
        printf("FAIL struct field offset: p[1]=0x%x\n", p[1]);
        rc = 4;
    }
    // Round-trip the float field too.
    if (s.f != 1.5f) {
        printf("FAIL struct.f round-trip\n");
        rc = 5;
    }

    // Array element stride: `globals[i+1] - globals[i]` corresponds
    // to four bytes of stride.
    char *gp = (char *)globals;
    if ((char *)&globals[1] - gp != 4) {
        printf("FAIL array stride %td\n", (char *)&globals[1] - gp);
        rc = 6;
    }
    // Re-read all four initialised slots, confirming the narrowing
    // applied at static-init time produced the correct f32 bit
    // patterns (NOT a truncation of the f64 mantissa to its low 4
    // bytes, which would zero every entry).
    if (globals[0] != 1.5f) {
        printf("FAIL globals[0]=%f\n", (double)globals[0]);
        rc = 7;
    }
    if (globals[1] != 2.5f) {
        printf("FAIL globals[1]=%f\n", (double)globals[1]);
        rc = 8;
    }
    if (globals[2] != 3.5f) {
        printf("FAIL globals[2]=%f\n", (double)globals[2]);
        rc = 9;
    }
    if (globals[3] != 4.5f) {
        printf("FAIL globals[3]=%f\n", (double)globals[3]);
        rc = 10;
    }

    // Function-parameter rebinding: `passthrough(1.5f)` must return
    // exactly 1.5f. Before the param-rebind step at function entry,
    // the callee's `Op::Lf` would read the low 4 bytes of the
    // caller-pushed `f64::to_bits(1.5f)` slot (= 0x00000000 = +0.0f)
    // and downstream float math collapsed to a constant.
    if (passthrough(1.5f) != 1.5f) {
        printf("FAIL passthrough(1.5)\n");
        rc = 11;
    }
    if (passthrough(2.5f) != 2.5f) {
        printf("FAIL passthrough(2.5)\n");
        rc = 12;
    }
    // Distinct float args -> distinct results -- the regression
    // that motivated the param-rebind.
    if (passthrough(1.5f) == passthrough(2.5f)) {
        printf("FAIL passthrough collapsed distinct args\n");
        rc = 13;
    }
    if (add3(1.0f, 2.0f, 3.5f) != 6.5f) {
        printf("FAIL add3 = %f\n", (double)add3(1.0f, 2.0f, 3.5f));
        rc = 14;
    }

    // Local round-trip with arithmetic.
    float a = 1.5f;
    float b = 2.0f;
    float c = a * b + 0.25f;        // 3.25
    if (c != 3.25f) {
        printf("FAIL local arith %f\n", (double)c);
        rc = 15;
    }

    // Bit pattern: 1.0f is 0x3f800000 in IEEE-754 single.
    float one = 1.0f;
    unsigned int bits;
    memcpy(&bits, &one, 4);
    if (bits != 0x3f800000) {
        printf("FAIL bit pattern of 1.0f: 0x%x\n", bits);
        rc = 16;
    }

    return rc;
}
