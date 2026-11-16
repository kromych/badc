// A conditional of struct type builds each arm in its own object and reads
// the one chosen; the read is the value that arm stored, on a straight path
// and around a loop. Returns 0 when every result matches.

typedef struct {
    unsigned long bits;
} Ref;

static inline Ref borrow(void *p) {
    Ref r = {(unsigned long)p | 1};
    return r;
}

static inline Ref steal(void *p) {
    Ref r = {(unsigned long)p};
    return r;
}

__attribute__((noinline)) static unsigned long pick(void *p, int c) {
    Ref r = c ? borrow(p) : steal(p);
    return r.bits;
}

__attribute__((noinline)) static unsigned long sum(const unsigned long *v, int n) {
    unsigned long s = 0;
    for (int i = 0; i < n; i++) {
        Ref r = (i & 1) ? borrow((void *)v[i]) : steal((void *)v[i]);
        s += r.bits;
    }
    return s;
}

int main(void) {
    unsigned long v[4] = {16, 32, 48, 64};
    if (pick((void *)8, 1) != 9)
        return 1;
    if (pick((void *)8, 0) != 8)
        return 2;
    if (sum(v, 4) != 16 + 33 + 48 + 65)
        return 3;
    return 0;
}
