// A statement expression's value is that of the last expression-statement
// its block writes. The parser appends the block's scope exits after that
// statement -- `__attribute__((cleanup))` destructor calls and the VLA stack
// restore -- and those are not the value. They still run, and they run after
// the value has been taken, which is the order C gives a block exit and what
// the scope-guard idiom depends on.
// Each check returns a distinct non-zero code on failure.

static int freed;
static int freed_saw;

static void note(const int *p)
{
    freed++;
    freed_saw = *p;
}

struct box {
    int fd;
    long long wide;
};

static void note_box(const struct box *b)
{
    freed++;
    freed_saw = b->fd;
}

// The load-then-clear idiom a scope guard uses to disown its resource: the
// value is read, the object is reset, and the read value is the result.
#define take(p, empty)              \
    ({                              \
        __typeof__(&(p)) tp = &(p); \
        __typeof__(p) tv = *tp;     \
        *tp = (empty);              \
        tv;                         \
    })

static int publish(int n)
{
    // A guarded object, then a nested statement expression supplying the
    // value: the shape a resource-publishing helper compiles to.
    return ({
        struct box b __attribute__((cleanup(note_box))) = { n, 0 };
        int ret = 0;
        if (!ret)
            ret = ({
                struct box *p = &b;
                take(p->fd, -1);
            });
        ret;
    });
}

static long long wide_value(void)
{
    return ({
        struct box b __attribute__((cleanup(note_box))) = { 0, 0 };
        b.wide = 0x1234567800000009LL;
        b.wide;
    });
}

static int vla_value(int n)
{
    return ({
        int a[n];
        a[0] = 41;
        a[n - 1] = 1;
        a[0] + a[n - 1];
    });
}

static int vla_and_guard(int n)
{
    return ({
        int guard __attribute__((cleanup(note))) = 5;
        int a[n];
        a[0] = guard;
        a[0] + 2;
    });
}

int main(void)
{
    freed = 0;
    if (publish(7) != 7)
        return 1;
    // The destructor ran, and saw the object after `take` cleared it.
    if (freed != 1)
        return 2;
    if (freed_saw != -1)
        return 3;

    if (wide_value() != 0x1234567800000009LL)
        return 4;

    if (vla_value(4) != 42)
        return 5;
    if (vla_and_guard(3) != 7)
        return 6;

    // Two guards: both run, the value is unaffected.
    freed = 0;
    int two = ({
        int g1 __attribute__((cleanup(note))) = 1;
        int g2 __attribute__((cleanup(note))) = 2;
        g1 + g2 + 6;
    });
    if (two != 9)
        return 7;
    if (freed != 2)
        return 8;

    // The value expression may read the guarded object itself; it is read
    // before the destructor runs.
    freed = 0;
    int own = ({
        int g __attribute__((cleanup(note))) = 11;
        g;
    });
    if (own != 11)
        return 9;
    if (freed != 1 || freed_saw != 11)
        return 10;

    // A guarded block whose value comes through a label, reached by goto:
    // the labeled statement still carries the value.
    freed = 0;
    int viagoto = ({
        int g __attribute__((cleanup(note))) = 0;
        if (g == 0)
            goto tail;
        g = 99;
    tail:
        g + 3;
    });
    if (viagoto != 3)
        return 11;
    if (freed != 1)
        return 12;

    // A guarded statement expression in a comma and as a call argument.
    freed = 0;
    int nested = ({
        int outer __attribute__((cleanup(note))) = 0;
        outer + ({
            int inner __attribute__((cleanup(note))) = 4;
            inner * 5;
        });
    });
    if (nested != 20)
        return 13;
    if (freed != 2)
        return 14;

    return 0;
}
