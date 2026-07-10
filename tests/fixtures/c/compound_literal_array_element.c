// C99 6.5.2.5: an array-of-struct element may be written as a compound
// literal `(T){ ... }` naming the element type, a shape a macro commonly
// expands to. The redundant cast is dropped and the brace list fills the
// element, for both deferred and fixed size, and with designated or
// positional fields. Plain brace elements are unaffected. Returns 0 on
// success.

typedef struct {
    int bit;
    const char *desc;
} M;

#define ENTRY(n, d) (M){ .bit = n, .desc = d }

// Deferred size, compound-literal elements with designators.
static const M deferred[] = {
    ENTRY(1, "one"),
    ENTRY(2, "two"),
    ENTRY(4, "four"),
};

// Fixed size, compound-literal elements.
static const M fixed[3] = {
    ENTRY(10, "ten"),
    (M){ 20, "twenty" },   // positional compound literal
};

// Regression: plain brace elements (no compound literal) still fill.
static const M plain[] = {
    { 1, "a" },
    { .bit = 2, .desc = "b" },
};

int main(void) {
    if (sizeof(deferred) / sizeof(deferred[0]) != 3) return 1;
    if (deferred[0].bit != 1 || deferred[0].desc[0] != 'o') return 2;
    if (deferred[2].bit != 4 || deferred[2].desc[0] != 'f') return 3;
    if (fixed[0].bit != 10 || fixed[0].desc[0] != 't') return 4;
    if (fixed[1].bit != 20 || fixed[1].desc[0] != 't') return 5;
    if (fixed[2].bit != 0 || fixed[2].desc != 0) return 6;  // trailing zero
    if (plain[0].bit != 1 || plain[1].bit != 2 || plain[1].desc[0] != 'b') return 7;
    return 0;
}
