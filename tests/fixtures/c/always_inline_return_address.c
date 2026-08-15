// gcc specifies the result of an inlined `__builtin_return_address(0)` as
// the return address of the function it was inlined into. An always_inline
// helper holding it is therefore spliced, and the spliced read of the
// caller's frame yields that function's own return address -- the value a
// direct `__builtin_return_address(0)` there yields. The inliner runs
// under `-O`, so the equality is asserted there.

static __attribute__((always_inline)) inline void *helper_ra(void) {
    return __builtin_return_address(0);
}

static int spliced_matches_direct(void) {
    void *via_helper = helper_ra();
    void *direct = __builtin_return_address(0);
    return via_helper == direct;
}

int main(void) {
    int matched = spliced_matches_direct();
#ifdef __OPTIMIZE__
    if (!matched)
        return 1;
#else
    (void)matched;
#endif
    if (helper_ra() == 0)
        return 2;
    return 0;
}
