// Spill-slot reuse for disjoint live ranges. Two groups of values each
// cross a call; the first group is dead before the second is born, so
// the allocator may reuse the first group's spill slots for the second.
// Correctness requires that two values share a slot only when they are
// never simultaneously live. `opaque` has two blocks so the inliner
// leaves it out-of-line, keeping the calls (and the call-crossing live
// ranges) that force the spills. Returns 0 when the results match.

static long opaque(long v) {
    if (v < 0) return -v;
    return v * 2;
}

static long twogroups(long x) {
    long a = x + 1, b = x + 2, c = x + 3, d = x + 4;
    long e = x + 5, f = x + 6, g = x + 7, h = x + 8;
    long s1 = opaque(x) + a + b + c + d + e + f + g + h;
    long i = s1 + 1, j = s1 + 2, k = s1 + 3, l = s1 + 4;
    long m = s1 + 5, n = s1 + 6, o = s1 + 7, p = s1 + 8;
    long s2 = opaque(s1) + i + j + k + l + m + n + o + p;
    return s2;
}

int main(void) {
    if (twogroups(10) != 1396) return 1;
    if (twogroups(-3) != 186) return 2;
    return 0;
}
