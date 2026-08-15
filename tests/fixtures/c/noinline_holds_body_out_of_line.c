// gcc's `noinline` holds a body out of line whatever the inliner would
// otherwise do, and it is the escape hatch its `__builtin_return_address`
// wording names for a caller that needs the callee's own frame rather than
// the frame it was inlined into. Out of line the callee's return address is
// the call site above it; spliced, it is the enclosing function's own. The
// snapshots carry the other half: a `<held_ra>` body survives on both
// targets rather than being folded into its caller.

static __attribute__((noinline)) void *held_ra(void) {
    return __builtin_return_address(0);
}

static __attribute__((always_inline)) inline void *spliced_ra(void) {
    return __builtin_return_address(0);
}

// Holds at every optimization level: the request is not a size decision.
static int hatch_holds(void) {
    void *callee = held_ra();
    void *mine = __builtin_return_address(0);
    return callee != mine;
}

static int splice_matches(void) {
    return spliced_ra() == __builtin_return_address(0);
}

// A small `noinline` body the size-driven inliner would otherwise take.
static __attribute__((noinline)) int add(int a, int b) {
    return a + b;
}

int main(void) {
    if (!hatch_holds())
        return 1;
    if (add(2, 3) != 5)
        return 2;
    int matched = splice_matches();
#ifdef __OPTIMIZE__
    if (!matched)
        return 3;
#else
    (void)matched;
#endif
    return 0;
}
