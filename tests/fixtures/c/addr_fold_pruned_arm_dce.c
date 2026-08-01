// A defined static function's address flows into an inlined helper
// whose guard null-checks it alongside a compile-time-null argument.
// The address fold decides the first test, the constant decides the
// second, and the arm consuming the address is pruned. The static DCE
// then drops the callee; the pruned call left in the instruction tape
// must not count as a use, or the emitter materializes a code address
// whose target is no longer in the image. -O only: the folds that
// prune the arm run there.

extern int absent_consume(int (*fn)(int), void *arg);

static int filter(int x) { return x + 1; }

static inline int request(int (*fn)(int), void *arg) {
    if (!fn || !arg)
        return 7;
    return absent_consume(fn, arg);
}

int main(void) {
    return request(filter, (void *)0) == 7 ? 0 : 1;
}
