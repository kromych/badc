// An always_inline function returning a one-word struct from somewhere other
// than a local of its own -- its by-value parameter, a global, the target
// of a pointer, a member reached through one -- is inlined, as gcc inlines
// every always_inline call, and the caller receives the object's value
// (C99 6.8.6.4p3: the value of the expression is returned). The result is
// also stored through a pointer. Returns 0 when every value matches.

#define AI static inline __attribute__((always_inline))

typedef struct {
    unsigned long v;
} word_t;

struct holder {
    int pad;
    word_t p;
};

word_t global_word = {7};

AI word_t same(word_t p) { return p; }
AI word_t global(void) { return global_word; }
AI word_t through(const word_t *q) { return *q; }
AI word_t member(struct holder *q) { return q->p; }

__attribute__((noinline)) static unsigned long via_param(word_t p) { return same(p).v; }
__attribute__((noinline)) static unsigned long via_global(void) { return global().v; }
__attribute__((noinline)) static unsigned long via_pointer(const word_t *q) {
    return through(q).v;
}
__attribute__((noinline)) static unsigned long via_member(struct holder *q) {
    return member(q).v;
}
__attribute__((noinline)) static void store_through(word_t *d, word_t p) { *d = same(p); }

int main(void) {
    word_t a = {3}, b = {0};
    struct holder h = {1, {9}};
    store_through(&b, a);
    if (via_param(a) != 3)
        return 1;
    if (via_global() != 7)
        return 2;
    if (via_pointer(&a) != 3)
        return 3;
    if (via_member(&h) != 9)
        return 4;
    if (b.v != 3)
        return 5;
    global_word.v = 11;
    if (via_global() != 11)
        return 6;
    return 0;
}
