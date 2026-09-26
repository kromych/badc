// An inlinable function called with fewer arguments than it has
// parameters (an argument-count mismatch) must not be inlined: doing so
// would leave the unmatched parameter unbound and corrupt the optimized
// IR. An old-style definition has no prototype (C99 6.9.1p7), so such a
// call compiles with a warning; its result is unspecified and discarded.
// The point is that the compiler emits valid code at -O rather than
// failing on a dangling value reference.

int add(a, b) int a, b; {
    return a + b;
}

int main(void) {
    int ok = add(2, 3);    // proper call: 5
    int junk = add(7);     // one argument short -- must compile cleanly
    (void) junk;
    return ok == 5 ? 0 : 1;
}
