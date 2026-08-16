// gcc specifies the result of an inlined `__builtin_frame_address` as the
// caller's: level 0 names the frame of the function inlined into, and a
// level above 0 counts from there. gcc 16 answers that way on linux-x86_64
// and linux-aarch64 alike, at -O0 and -O2. An always_inline helper holding
// the builtin is therefore spliced, and the spliced read matches the direct
// read in the function it lands in. The inliner runs under `-O`, so the
// equalities are asserted there.
//
// `noinline` keeps inner's frame distinct from outer's and the volatile
// store after each call keeps the call out of tail position: a collapsed
// frame would shift every level, which is why gcc documents a level above 0
// as dependent on the callers keeping their frames.

static __attribute__((always_inline)) inline void *helper_fa0(void) {
    return __builtin_frame_address(0);
}

static __attribute__((always_inline)) inline void *helper_fa1(void) {
    return __builtin_frame_address(1);
}

volatile int sink;
void *outer_own, *via0, *direct0, *via1, *direct1;

__attribute__((noinline)) static void inner(void) {
    via0 = helper_fa0();
    direct0 = __builtin_frame_address(0);
    via1 = helper_fa1();
    direct1 = __builtin_frame_address(1);
    sink = 1;
}

__attribute__((noinline)) static void outer(void) {
    outer_own = __builtin_frame_address(0);
    inner();
    sink = 2;
}

int main(void) {
    outer();
    if (via0 == 0 || via1 == 0)
        return 1;
#ifdef __OPTIMIZE__
    if (via0 != direct0)
        return 2;
    if (via1 != direct1)
        return 3;
    if (via1 != outer_own)
        return 4;
    // The spliced level-0 and level-1 reads name distinct frames.
    if (via0 == via1)
        return 5;
#else
    (void)direct0;
    (void)direct1;
    (void)outer_own;
#endif
    return 0;
}
