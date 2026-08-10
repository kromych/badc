// The address of a defined function arriving through an inlined
// parameter, compared with a null pointer constant: after argument
// substitution the operand is the function's address, the comparison
// decides (C99 6.3.2.3p3), and the arm calling the never-defined
// helper drops. A frame-slot address forwarded through a pointer
// decides the same way. -O only: the parameter comparison is not a
// constant expression the front end may fold.

extern void absent_param_arm(void);
extern void absent_slot_arm(void);

static int hits;

static void handler(void) { hits += 1; }

static inline void install(void (*fn)(void)) {
    if ((fn) == ((void *)0))
        absent_param_arm();
    fn();
}

int main(void) {
    install(handler);
    int slot = 5;
    int *p = &slot;
    if (p == (int *)0)
        absent_slot_arm();
    hits += *p;
    return hits == 6 ? 0 : 1;
}
