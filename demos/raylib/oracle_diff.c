// Headless differential check for raylib's pure math (raymath.h).
//
// raymath is header-only (`static inline`), so this links no library and
// needs no platform headers. The harness evaluates a fixed set of vector,
// matrix and quaternion operations and prints every result component. The
// smoke builds it with badc and with the reference compiler and compares the
// output, exercising badc's float and by-value aggregate-return code on paths
// the 2D game does not reach (Matrix is a 16-float return, Quaternion/Vector3
// are HFA returns). System libraylib, when installed, is an additional oracle
// for the same API; absent it, the reference C compiler stands in.

#include <math.h>
#include <stdio.h>

// Force `static inline` for every raymath function: this is a single
// translation unit with no RAYMATH_IMPLEMENTATION, so the default inline-only
// linkage would leave the larger functions (e.g. MatrixInvert) without an
// out-of-line definition under a strict C99 compiler.
#define RAYMATH_STATIC_INLINE
#include "raymath.h"

static void p1(const char *tag, float v) { printf("%s %.5f\n", tag, (double)v); }

static void p2(const char *tag, Vector2 v) {
    printf("%s %.5f %.5f\n", tag, (double)v.x, (double)v.y);
}

static void p3(const char *tag, Vector3 v) {
    printf("%s %.5f %.5f %.5f\n", tag, (double)v.x, (double)v.y, (double)v.z);
}

static void p4(const char *tag, Vector4 v) {
    printf("%s %.5f %.5f %.5f %.5f\n", tag, (double)v.x, (double)v.y, (double)v.z,
           (double)v.w);
}

static void pm(const char *tag, Matrix m) {
    float f[16];
    f[0] = m.m0;  f[1] = m.m1;   f[2] = m.m2;   f[3] = m.m3;
    f[4] = m.m4;  f[5] = m.m5;   f[6] = m.m6;   f[7] = m.m7;
    f[8] = m.m8;  f[9] = m.m9;   f[10] = m.m10; f[11] = m.m11;
    f[12] = m.m12; f[13] = m.m13; f[14] = m.m14; f[15] = m.m15;
    printf("%s", tag);
    for (int i = 0; i < 16; i++) printf(" %.5f", (double)f[i]);
    printf("\n");
}

int main(void) {
    // Scalars.
    p1("clamp", Clamp(7.5f, -1.0f, 3.0f));
    p1("lerpf", Lerp(2.0f, 10.0f, 0.3f));
    p1("normf", Normalize(6.0f, 2.0f, 8.0f));
    p1("remap", Remap(5.0f, 0.0f, 10.0f, 100.0f, 200.0f));
    p1("wrap", Wrap(13.5f, 0.0f, 10.0f));
    p1("fequal", (float)FloatEquals(0.1f + 0.2f, 0.3f));

    // Vector2.
    Vector2 a2 = {3.0f, 4.0f}, b2 = {-1.5f, 2.0f};
    p2("v2add", Vector2Add(a2, b2));
    p2("v2sub", Vector2Subtract(a2, b2));
    p2("v2scale", Vector2Scale(a2, 2.5f));
    p1("v2len", Vector2Length(a2));
    p1("v2dist", Vector2Distance(a2, b2));
    p1("v2dot", Vector2DotProduct(a2, b2));
    p1("v2angle", Vector2Angle(a2, b2));
    p2("v2norm", Vector2Normalize(a2));
    p2("v2lerp", Vector2Lerp(a2, b2, 0.25f));
    p2("v2rot", Vector2Rotate(a2, 0.7853981633974483f));
    p2("v2refl", Vector2Reflect(a2, Vector2Normalize(b2)));

    // Vector3.
    Vector3 a3 = {1.0f, 2.0f, 3.0f}, b3 = {-2.0f, 0.5f, 1.0f};
    p3("v3add", Vector3Add(a3, b3));
    p3("v3cross", Vector3CrossProduct(a3, b3));
    p1("v3dot", Vector3DotProduct(a3, b3));
    p1("v3len", Vector3Length(a3));
    p3("v3norm", Vector3Normalize(a3));
    p1("v3dist", Vector3Distance(a3, b3));
    p3("v3lerp", Vector3Lerp(a3, b3, 0.4f));
    p3("v3perp", Vector3Perpendicular(a3));
    p3("v3refl", Vector3Reflect(a3, Vector3Normalize(b3)));

    // Matrix.
    Matrix t = MatrixTranslate(2.0f, -1.0f, 0.5f);
    Matrix r = MatrixRotateXYZ((Vector3){0.3f, 0.6f, -0.2f});
    Matrix s = MatrixScale(1.5f, 2.0f, 0.5f);
    Matrix trs = MatrixMultiply(MatrixMultiply(s, r), t);
    pm("mtrans", t);
    pm("mrot", r);
    pm("mtrs", trs);
    p1("mdet", MatrixDeterminant(trs));
    pm("minv", MatrixInvert(trs));
    pm("mpersp", MatrixPerspective(1.0471975512f, 1.7777778f, 0.1f, 100.0f));
    pm("mlook", MatrixLookAt((Vector3){4, 3, 4}, (Vector3){0, 0, 0}, (Vector3){0, 1, 0}));

    // Vector transform through a matrix.
    p3("v3xform", Vector3Transform(a3, trs));

    // Quaternion.
    Quaternion q1 = QuaternionFromEuler(0.3f, 0.6f, -0.2f);
    Quaternion q2 = QuaternionFromAxisAngle((Vector3){0, 1, 0}, 1.0471975512f);
    p4("qeuler", q1);
    p4("qaxis", q2);
    p4("qmul", QuaternionMultiply(q1, q2));
    p4("qnorm", QuaternionNormalize((Quaternion){1.0f, 2.0f, 3.0f, 4.0f}));
    p4("qslerp", QuaternionSlerp(q1, q2, 0.35f));
    pm("qtomat", QuaternionToMatrix(q1));
    p3("v3rotq", Vector3RotateByQuaternion(a3, q1));

    printf("done\n");
    return 0;
}
