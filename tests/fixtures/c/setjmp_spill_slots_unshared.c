// C99 7.13.2.1p3: automatic objects not modified between setjmp and
// longjmp keep their values at the second return. longjmp restores
// registers but not the frame, so first-return-path temporaries must
// not reuse the spill slots of values read only after the second
// return. The eight saved values must survive the longjmp.
#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>

jmp_buf env;
int seed[64];
int acc;

int main(void) {
    for (int i = 0; i < 64; i++) {
        seed[i] = i + 1;
    }
    int v0 = seed[0] * 3 + 0;
    int v1 = seed[1] * 3 + 1;
    int v2 = seed[2] * 3 + 2;
    int v3 = seed[3] * 3 + 3;
    int v4 = seed[4] * 3 + 4;
    int v5 = seed[5] * 3 + 5;
    int v6 = seed[6] * 3 + 6;
    int v7 = seed[7] * 3 + 7;
    if (setjmp(env) != 0) {
        int mask = 0;
        if (v0 != seed[0] * 3 + 0) mask |= 1 << 0;
        if (v1 != seed[1] * 3 + 1) mask |= 1 << 1;
        if (v2 != seed[2] * 3 + 2) mask |= 1 << 2;
        if (v3 != seed[3] * 3 + 3) mask |= 1 << 3;
        if (v4 != seed[4] * 3 + 4) mask |= 1 << 4;
        if (v5 != seed[5] * 3 + 5) mask |= 1 << 5;
        if (v6 != seed[6] * 3 + 6) mask |= 1 << 6;
        if (v7 != seed[7] * 3 + 7) mask |= 1 << 7;
        if (mask) {
            printf("CLOBBERED mask=%x\n", mask);
            return 1;
        }
        printf("ok\n");
        return 0;
    }
    // First-return path: many simultaneously-live temporaries feeding
    // a wide sum, forcing spills, then jump back.
    int t0 = seed[16] * 5 + 1;
    int t1 = seed[17] * 5 + 2;
    int t2 = seed[18] * 5 + 3;
    int t3 = seed[19] * 5 + 4;
    int t4 = seed[20] * 5 + 5;
    int t5 = seed[21] * 5 + 6;
    int t6 = seed[22] * 5 + 7;
    int t7 = seed[23] * 5 + 8;
    int t8 = seed[24] * 5 + 9;
    int t9 = seed[25] * 5 + 10;
    int t10 = seed[26] * 5 + 11;
    int t11 = seed[27] * 5 + 12;
    int t12 = seed[28] * 5 + 13;
    int t13 = seed[29] * 5 + 14;
    int t14 = seed[30] * 5 + 15;
    int t15 = seed[31] * 5 + 16;
    int t16 = seed[32] * 5 + 17;
    int t17 = seed[33] * 5 + 18;
    int t18 = seed[34] * 5 + 19;
    int t19 = seed[35] * 5 + 20;
    acc = t0 + t1 + t2 + t3 + t4 + t5 + t6 + t7 + t8 + t9 + t10 + t11 +
          t12 + t13 + t14 + t15 + t16 + t17 + t18 + t19;
    longjmp(env, 1);
    return 2;
}
