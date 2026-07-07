// vfork(2)'s child runs on the parent's stack. Values read only after
// the parent resumes are dead on the child path by ordinary liveness,
// so without a returns-twice guard the child's call-staging
// temporaries reuse their spill slots and the resumed parent reads
// the clobber. The twelve saved values must survive the child.
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int seed[64];

int child_exec(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
               int a7, int a8, int a9, int a10, int a11, int a12, int a13,
               int a14, int a15, int a16, int a17, int a18, int a19) {
    return (a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11 +
            a12 + a13 + a14 + a15 + a16 + a17 + a18 + a19) & 0x7f;
}

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
    int v8 = seed[8] * 3 + 8;
    int v9 = seed[9] * 3 + 9;
    int v10 = seed[10] * 3 + 10;
    int v11 = seed[11] * 3 + 11;
    int pid = vfork();
    if (pid < 0) {
        printf("vfork failed\n");
        return 2;
    }
    if (pid != 0) {
        int st = 0;
        waitpid(pid, &st, 0);
        int mask = 0;
        if (v0 != seed[0] * 3 + 0) mask |= 1 << 0;
        if (v1 != seed[1] * 3 + 1) mask |= 1 << 1;
        if (v2 != seed[2] * 3 + 2) mask |= 1 << 2;
        if (v3 != seed[3] * 3 + 3) mask |= 1 << 3;
        if (v4 != seed[4] * 3 + 4) mask |= 1 << 4;
        if (v5 != seed[5] * 3 + 5) mask |= 1 << 5;
        if (v6 != seed[6] * 3 + 6) mask |= 1 << 6;
        if (v7 != seed[7] * 3 + 7) mask |= 1 << 7;
        if (v8 != seed[8] * 3 + 8) mask |= 1 << 8;
        if (v9 != seed[9] * 3 + 9) mask |= 1 << 9;
        if (v10 != seed[10] * 3 + 10) mask |= 1 << 10;
        if (v11 != seed[11] * 3 + 11) mask |= 1 << 11;
        if (mask) {
            printf("CLOBBERED mask=%x\n", mask);
            return 1;
        }
        printf("ok\n");
        return 0;
    }
    // Child: many simultaneously-live temporaries feeding a wide call,
    // forcing spills into the frame the parent still owns.
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
    _exit(child_exec(t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12,
                     t13, t14, t15, t16, t17, t18, t19));
    return 3;
}
