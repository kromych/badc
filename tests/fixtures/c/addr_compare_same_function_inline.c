// A parameter compared with the function the call site passed: after
// inlining, one operand is the caller's function address and the other
// the callee's own reference to the same function, so the comparison
// is between identical addresses and decides (C99 6.5.9p6). The arm
// calling the never-defined helper drops. A scalar parameter compared
// with itself decides the same way. -O only: both shapes need the
// inliner's argument substitution.

extern void absent_mismatch_arm(void);
extern void absent_scalar_arm(void);

static int calls;

static void sender(void) { calls++; }

static inline int subscribe(void (*fn)(void)) {
    if (fn != sender)
        absent_mismatch_arm();
    return 0;
}

static inline int check(int x) {
    if (x != x)
        absent_scalar_arm();
    return x;
}

int main(void) {
    if (subscribe(sender) != 0)
        return 1;
    sender();
    if (check(calls) != 1)
        return 2;
    return calls == 1 ? 0 : 3;
}
