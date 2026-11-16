/* SVE rows whose result takes the register of their second operand: a
 * function of the SVE PCS returns in z0 the operation of z1 with z0. The
 * zeroing product of a vector with itself, a commutative product and a
 * conjunction with the operands the other way round, a subtraction
 * reversed, the merging and the floating forms, each checked against the
 * same computation in scalar C. The exit status is the vector length in
 * 128-bit granules. */
#include <arm_sve.h>

#define N 45

svint32_t square_z(svbool_t pg, svint32_t a) { return svmul_z(pg, a, a); }
svint32_t square_x(svbool_t pg, svint32_t a) { return svmul_x(pg, a, a); }
svint32_t mul_x(svbool_t pg, svint32_t a, svint32_t b) { return svmul_x(pg, b, a); }
svint32_t and_z(svbool_t pg, svint32_t a, svint32_t b) { return svand_z(pg, b, a); }
svint32_t sub_z(svbool_t pg, svint32_t a, svint32_t b) { return svsub_z(pg, b, a); }
svint32_t sub_x(svbool_t pg, svint32_t a, svint32_t b) { return svsub_x(pg, b, a); }
svint32_t sub_m(svbool_t pg, svint32_t a, svint32_t b) { return svsub_m(pg, b, a); }
svfloat32_t fsub_z(svbool_t pg, svfloat32_t a, svfloat32_t b) { return svsub_z(pg, b, a); }
svfloat32_t fadd_z(svbool_t pg, svfloat32_t a, svfloat32_t b) { return svadd_z(pg, b, a); }

static int32_t x[N], y[N], r[N];
static float fx[N], fy[N], fr[N];

int main(void) {
    for (int i = 0; i < N; i++) {
        x[i] = i * 7 - 100;
        y[i] = 60 - i * 3;
        fx[i] = (float)i * 0.75f - 9.0f;
        fy[i] = 4.5f - (float)i * 0.5f;
    }
    for (int op = 0; op < 9; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &x[i]), b = svld1(pg, &y[i]);
            svbool_t pos = svcmpgt_n_s32(pg, b, 0);
            svfloat32_t fa = svld1(pg, &fx[i]), fb = svld1(pg, &fy[i]);
            switch (op) {
            case 0: svst1(pg, &r[i], square_z(pos, a)); break;
            case 1: svst1(pg, &r[i], square_x(pg, a)); break;
            case 2: svst1(pg, &r[i], mul_x(pg, a, b)); break;
            case 3: svst1(pg, &r[i], and_z(pos, a, b)); break;
            case 4: svst1(pg, &r[i], sub_z(pos, a, b)); break;
            case 5: svst1(pg, &r[i], sub_x(pg, a, b)); break;
            case 6: svst1(pg, &r[i], sub_m(pos, a, b)); break;
            case 7: svst1(pg, &fr[i], fsub_z(pos, fa, fb)); break;
            default: svst1(pg, &fr[i], fadd_z(pos, fa, fb)); break;
            }
        }
        for (int i = 0; i < N; i++) {
            int32_t a = x[i], b = y[i], want = 0;
            float fwant = 0.0f;
            int on = b > 0;
            switch (op) {
            case 0: want = on ? a * a : 0; break;
            case 1: want = a * a; break;
            case 2: want = b * a; break;
            case 3: want = on ? b & a : 0; break;
            case 4: want = on ? b - a : 0; break;
            case 5: want = b - a; break;
            case 6: want = on ? b - a : b; break;
            case 7: fwant = on ? fy[i] - fx[i] : 0.0f; break;
            default: fwant = on ? fy[i] + fx[i] : 0.0f; break;
            }
            if (op < 7 ? r[i] != want : fr[i] != fwant)
                return 10 + op;
        }
    }
    return (int)(svcntb() / 16);
}
