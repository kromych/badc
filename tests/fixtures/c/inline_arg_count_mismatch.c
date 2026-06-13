// An inlinable function called with fewer arguments than it has
// parameters (an argument-count mismatch) must not be inlined: doing so
// would leave the unmatched parameter unbound and corrupt the optimized
// IR. The mismatched call's result is unspecified, so it is discarded;
// the point is that the compiler emits valid code at -O rather than
// failing on a dangling value reference.

int add(int a, int b) {
    return a + b;
}

int main(void) {
    int ok = add(2, 3);    // proper call: 5
    int junk = add(7);     // one argument short -- must compile cleanly
    (void) junk;
    return ok == 5 ? 0 : 1;
}
