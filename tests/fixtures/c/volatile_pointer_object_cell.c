/* C99 6.7.5.1p1: in `T *volatile p` the qualifier belongs to the
   pointer object, so each use of `p` reads the pointer cell as a
   volatile lvalue. Reassigning `p` between uses makes a dropped
   re-read observable -- a cached pointer would keep returning the
   first target. `const volatile` on the pointer object reads the same
   way; only the assignment is forbidden. */
static unsigned long a0 = 10;
static unsigned long a1 = 20;
static unsigned long a2 = 30;

static unsigned long walk_reassigned(unsigned long *volatile p) {
    unsigned long s = *p;
    p = &a1;
    s += *p;
    p = &a2;
    s += *p;
    return s;
}

static unsigned long read_thrice(unsigned long *const volatile p) {
    return *p + *p + *p;
}

/* Both levels qualified: the pointer cell and the pointee are each
   volatile lvalues. */
static unsigned long both_qualified(volatile unsigned long *volatile p) {
    unsigned long s = *p;
    *p = 5;
    s += *p;
    return s;
}

int main(void) {
    if (walk_reassigned(&a0) != 60) {
        return 1;
    }
    if (read_thrice(&a1) != 60) {
        return 2;
    }
    static volatile unsigned long cell;
    cell = 3;
    if (both_qualified(&cell) != 8) {
        return 3;
    }
    return 0;
}
