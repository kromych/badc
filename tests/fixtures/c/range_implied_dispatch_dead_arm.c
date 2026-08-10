// Comparisons a dominating condition settles, where no operand is ever
// an immediate.
//
//   * `state_loop` -- the loop condition excludes the last enumerator,
//     so the dispatch arm for it is unreachable. The condition reaches
//     the compared value through the 4-byte enum's width mask and an
//     exclusive-or against the excluded value, and the value itself
//     merges around the loop, so deciding the arm needs the merged
//     bounds and the rewriting of the condition back onto the value.
//   * `masked_switch` -- the operand is masked, so its value set is
//     {0, 1}; both are labelled and the default is unreachable.
//   * `repeated_condition` -- the guarded body recomputes the guard's
//     own comparison, which the guard already answered.
//
// The `*_bug` symbols are declared and never defined, so linking is the
// assertion. gcc links this at -O1 and above and fails to at -O0.

extern void dispatch_bug(void);
extern void switch_bug(void);
extern void repeat_bug(void);

enum st { s_lockless, s_lock, s_done };
struct t { enum st state; unsigned long data; };

static unsigned long ticks;

static __attribute__((always_inline)) inline void next(struct t *s) {
    switch (s->state) {
    case s_done:     dispatch_bug(); return;
    case s_lock:     s->state = s_done; return;
    case s_lockless: s->state = s_lock; return;
    }
}

static unsigned long state_loop(void) {
    unsigned long n = 0;
    for (struct t s = {s_lockless, 0}; s.state != s_done; next(&s)) {
        ticks += s.state;
        n++;
    }
    return n;
}

static int masked_switch(unsigned int flags) {
    switch (flags & 1u) {
    case 0:  return 10;
    case 1:  return 20;
    default: switch_bug(); return 0;
    }
}

// The guard's answer decides the recomputation of it, whatever the
// operand's bounds are: `v` here has none the analysis can name.
static int repeated_condition(long v) {
    int r = 0;
    if (v == 4242) {
        r = 1;
        if (v != 4242)
            repeat_bug();
    }
    return r;
}

// Read through a volatile cell, so no pass forwards a constant into the
// switch operand or the guard.
static volatile unsigned int in_flags;
static volatile long in_value;

int main(void) {
    if (state_loop() != 2)
        return 1;
    if (ticks != (unsigned long)s_lockless + (unsigned long)s_lock)
        return 2;
    in_flags = 1u;
    if (masked_switch(in_flags) != 20)
        return 3;
    in_flags = 2u;
    if (masked_switch(in_flags) != 10)
        return 4;
    in_value = 1;
    if (repeated_condition(in_value) != 0)
        return 5;
    in_value = 4242;
    if (repeated_condition(in_value) != 1)
        return 6;
    return 0;
}
