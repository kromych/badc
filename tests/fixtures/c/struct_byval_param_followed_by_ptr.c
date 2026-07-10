// C99 6.5.2.2: every host-arg-register parameter value must remain
// readable once function execution reaches the body. Surfaced on
// Linux x86_64 for a signature with a struct-by-value parameter
// followed by a trailing pointer parameter: the c5 walker emitted
// the struct-by-value mcpy before the ParamRef capture stores, so
// the mcpy's dst-place propagation landed in the trailing
// pointer's host arg register and overwrote it before the walker
// captured the parameter into its cdecl cell. The body then read a
// stack address from the cell instead of the caller-supplied
// pointer.

#include <stdio.h>

struct Tok {
    const char *z;
    unsigned int n;
};

static int storage_value = 42;

static int verify(int *flag, struct Tok t, int *target) {
    if ((unsigned long)t.n != 7) return 10;
    if (target == 0) return 20;
    if (*target != 42) return 30;
    *flag = 1;
    return 0;
}

int main(void) {
    struct Tok t;
    t.z = "tok";
    t.n = 7;
    int flag = 0;
    int rc = verify(&flag, t, &storage_value);
    if (rc != 0) {
        printf("FAIL: rc=%d flag=%d storage=%d\n", rc, flag, storage_value);
        return rc;
    }
    if (flag != 1) {
        printf("FAIL: flag=%d expected 1\n", flag);
        return 1;
    }
    printf("OK\n");
    return 0;
}
