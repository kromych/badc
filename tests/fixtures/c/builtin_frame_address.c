// __builtin_frame_address(0) returns the current frame pointer as a
// void *. The exact value is target-dependent, so the checks are
// direction- and inlining-independent: the address is non-null, stable
// within one frame, and within a frame's distance of a local (so it is
// the real frame pointer, not a constant). The interpreter has no native
// frame pointer and returns a synthetic per-frame base with the same
// properties.

int main(void) {
    char local;
    void *a = __builtin_frame_address(0);
    void *b = __builtin_frame_address(0);
    if (a == 0) return 1;
    if (a != b) return 2;
    long d = (char *) a - &local;
    if (d < 0) d = -d;
    if (d > (1L << 20)) return 3;
    return 0;
}
