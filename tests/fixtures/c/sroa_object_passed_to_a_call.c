// An automatic aggregate whose address reaches a call that stays out of
// line. The callee's parameter footprint decides what leaves the
// object: a field it can neither read nor write moves to a register,
// and a field it reads moves too where the reads outnumber the writes
// that pay for it, keeping its memory write beside the register's so
// the bytes the call reads stay current. -O only; the inlined helper
// arms the pass's per-function gate.

struct box {
    long tag, lo, hi;
};

struct hot {
    long id, n;
};

__attribute__((noinline)) static long peek_lo(const struct box *b) { return b->lo; }

__attribute__((noinline)) static long peek_n(const struct hot *h) { return h->n; }

static inline long twice(long v) { return v + v; }

int main(void) {
    // tag and hi are outside the callee's footprint and leave the
    // object; lo is read by it and read once here, so it stays.
    struct box b;
    b.tag = 3;
    b.lo = 4;
    b.hi = 5;
    long s = peek_lo(&b) + twice(b.tag) + b.hi;

    // n is read by the callee and re-read here more often than it is
    // written, so it moves and its store writes both.
    struct hot h;
    h.id = 7;
    h.n = 2;
    long t = peek_n(&h) + h.n + h.n + h.n + h.id;

    return (s == 15 && t == 15) ? 0 : 1;
}
