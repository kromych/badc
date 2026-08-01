// An element of a file-scope const struct array reached through an
// always_inline accessor with two range checks and a null default.
// With a constant index the range branches fold, the surviving return
// value is the element's address behind a collapsed merge, and the
// member load reads the initializer image (C99 6.7.3: a const object's
// stored value cannot change), so the guard on it decides and the arm
// calling the never-defined helper drops. -O only: const-object loads
// are an optimizer capability.

extern void absent_field_arm(void);

struct mode {
    int total;
    short lines;
};

static const struct mode modes_lo[3] = {{100, 10}, {100, 11}, {130, 12}};
static const struct mode modes_hi[2] = {{700, 20}, {725, 21}};

static inline __attribute__((always_inline)) const struct mode *mode_for(unsigned idx) {
    if (idx >= 1 && idx < 1 + 3)
        return &modes_lo[idx - 1];
    if (idx >= 8 && idx < 8 + 2)
        return &modes_hi[idx - 8];
    return (const struct mode *)0;
}

int main(void) {
    if (mode_for(2)->total != 100 || mode_for(9)->total != 725)
        absent_field_arm();
    unsigned i = 2;
    const struct mode *m = mode_for(i);
    if (!m)
        return 1;
    return m->lines == 11 ? 0 : 2;
}
