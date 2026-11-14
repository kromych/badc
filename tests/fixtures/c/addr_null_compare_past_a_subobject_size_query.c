// A frame object's address passed to an inlined function that asks its
// parameter's subobject size, then compared with a null pointer constant:
// once the size query is answered the parameter is the object's address,
// the comparison decides (C99 6.3.2.3p3) and the arm calling the
// never-defined helper drops. -O only: the parameter comparison is not a
// constant expression the front end may fold.

extern void absent_null_arm(void);

struct attr {
    unsigned long a, b, c;
};

static int fill(void *dst, unsigned long size) {
    unsigned char *p = dst;
    for (unsigned long i = 0; i < size; i++)
        p[i] = (unsigned char)i;
    return 0;
}

static inline __attribute__((always_inline)) int bounded(void *dst, unsigned long size) {
    if (__builtin_object_size(dst, 1) != (unsigned long)-1 && __builtin_object_size(dst, 1) < size)
        return -7;
    return fill(dst, size);
}

static inline __attribute__((always_inline)) int checked(void *const dst, unsigned long size) {
    if (!dst)
        absent_null_arm();
    return bounded(dst, size);
}

int main(void) {
    struct attr ra;
    if (checked(&ra, sizeof ra))
        return 1;
    return ra.b == 0x0f0e0d0c0b0a0908ul ? 0 : 2;
}
