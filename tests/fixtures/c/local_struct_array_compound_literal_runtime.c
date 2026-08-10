/* C99 6.5.2.5 + 6.7.8p13: a local struct-array initializer element written
   as a whole-element compound literal `(T){ ... }` naming the element's own
   type, with non-constant field values that force the per-element runtime
   store path. Covers the deferred-size (`[]`) and fixed-size (`[N]`) arrays,
   a brace-elided trailing `{}`, and a plain braced element. */

struct res {
    long start;
    long end;
    long flags;
};

static long opaque(long x) {
    return x * 10 + 1;
}

int main(void) {
    long a = opaque(2), b = opaque(5);

    struct res d[] = {
        (struct res){.start = a, .end = a + 0x1000 - 1, .flags = 0x200},
        (struct res){.start = b, .end = b + 0x1000 - 1},
        {},
    };
    if (d[0].start != 21 || d[0].end != 21 + 0x1000 - 1 || d[0].flags != 0x200)
        return 1;
    if (d[1].start != 51 || d[1].end != 51 + 0x1000 - 1 || d[1].flags != 0)
        return 2;
    if (d[2].start != 0 || d[2].end != 0 || d[2].flags != 0)
        return 3;

    struct res f[2] = {
        (struct res){.start = a, .flags = 7},
        {.end = b},
    };
    if (f[0].start != 21 || f[0].end != 0 || f[0].flags != 7)
        return 4;
    if (f[1].start != 0 || f[1].end != 51 || f[1].flags != 0)
        return 5;

    return 0;
}
