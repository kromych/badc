/* C99 6.7.5.1p1: in `volatile T *p` the qualifier belongs to the
   pointee, so `p` is an ordinary object -- its cell is not a volatile
   lvalue -- while every access *through* it is a volatile access.
   Both halves are asserted: the pointee reads may not be coalesced
   (the writes between them make a collapsed read observable), and the
   pointer may be freely re-read. `const` on the pointee changes
   neither. */
static volatile unsigned long cell;

static unsigned long sum_three_reads(const volatile unsigned long *p) {
    unsigned long s = *p;
    cell = 2;
    s += *p;
    cell = 3;
    s += *p;
    return s;
}

static unsigned long sum_via_plain_volatile(volatile unsigned long *p) {
    unsigned long s = *p;
    *p = 20;
    s += *p;
    *p = 30;
    s += *p;
    return s;
}

/* A second pointer level: the qualifier still sits below the outermost
   derivation, so `pp` is an ordinary object too. */
static unsigned long deref_twice(volatile unsigned long **pp) {
    return **pp + **pp;
}

int main(void) {
    cell = 1;
    if (sum_three_reads(&cell) != 6) {
        return 1;
    }
    cell = 10;
    if (sum_via_plain_volatile(&cell) != 60) {
        return 2;
    }
    cell = 7;
    volatile unsigned long *p = &cell;
    if (deref_twice(&p) != 14) {
        return 3;
    }
    return 0;
}
