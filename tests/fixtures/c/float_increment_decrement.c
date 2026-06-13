// C99 6.5.3.1 (prefix) and 6.5.2.4 (postfix): `++` / `--` apply to any real
// floating type, adding or subtracting 1. Prefix yields the new value, postfix
// the prior value. Exercised across the lvalue forms (local, pointer target,
// struct member, global, array element) and both precisions. Asserted by
// return code.

struct S { float f; double d; };
double gd = 5.0;

int main(void) {
    // Postfix returns the old value; prefix the new.
    float f = 1.5f;
    float g = f++;
    if (g != 1.5f || f != 2.5f) return 1;
    float a = 1.5f;
    float b = ++a;
    if (b != 2.5f || a != 2.5f) return 2;

    // Double, decrement.
    double d = 3.25;
    double e = d--;
    if (e != 3.25 || d != 2.25) return 3;
    double p = 3.25;
    double q = --p;
    if (q != 2.25 || p != 2.25) return 4;

    // Pointer target, struct members, global, array element.
    float v = 1.0f;
    float *pf = &v;
    (*pf)++;
    ++(*pf);
    if (v != 3.0f) return 5;

    struct S s = { 1.5f, 2.5 };
    s.f++;
    s.d--;
    if (s.f != 2.5f || s.d != 1.5) return 6;

    gd++;
    ++gd;
    if (gd != 7.0) return 7;

    double arr[3] = { 0.0, 1.0, 2.0 };
    arr[1]++;
    --arr[2];
    if (arr[1] != 2.0 || arr[2] != 1.0) return 8;

    // Single precision round-to-even: 2^24 + 1 is not representable, so the
    // increment leaves the value unchanged, matching IEEE-754.
    float big = 16777216.0f;
    big++;
    if (big != 16777216.0f) return 9;

    return 0;
}
