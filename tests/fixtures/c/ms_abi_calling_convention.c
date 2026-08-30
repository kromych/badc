// `__attribute__((ms_abi))` selects the Microsoft x64 calling
// convention for a definition, and for the function a pointer points
// to, on an x86_64 target whose own convention is System V: arguments
// in rcx/rdx/r8/r9 by position with 32 bytes of caller-reserved shadow
// space, the rest on the stack. The Linux kernel spells it `__efiapi`
// and UEFI firmware enters the kernel's EFI stub through it, calling
// back into it through the boot- and runtime-services tables.
//
// The attribute is x86-only: gcc ignores it elsewhere, and it names the
// target's own convention on Windows. So every result below is the same
// on every target, and a mismatched argument window on any one of them
// fails the run.

#define MS __attribute__((ms_abi))

// A definition on the foreign convention, with more integer parameters
// than that convention has argument registers.
static MS long sum6(long a, long b, long c, long d, long e, long f) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
}

// A definition on the foreign convention that calls back out on the
// target's: both windows appear in one frame.
static long plain_add(long a, long b) { return a * 10 + b; }

static MS long mixed(long a, long b, long c, long d) {
    return plain_add(a, b) + plain_add(c, d);
}

// Floating-point parameters: the Microsoft convention places by
// argument position, so `b` rides xmm1 and `c` rides r8, where System V
// would put them in xmm0 and rsi.
static MS double fp_mix(long a, double b, long c, double d) {
    return (double)a + b * 2.0 + (double)c * 3.0 + d * 4.0;
}

// The boot-services shape: a function-pointer member whose declarator
// carries the attribute.
struct services {
    long (MS *op)(long, long, long, long);
    long pad;
};

// The runtime-services shape: a function-type typedef, with the
// attribute at the member.
typedef long op_t(long, long);
struct table {
    op_t MS *op;
};

// The attribute on the typedef itself, so a declarator through the
// alias inherits it.
typedef MS long alias_t(long, long);
struct aliased {
    alias_t *op;
};

static MS long four(long a, long b, long c, long d) {
    return a * 1000 + b * 100 + c * 10 + d;
}

static MS long two(long a, long b) { return a * 100 + b; }

// A pointer parameter on the foreign convention: the callback shape.
static long through_param(long (MS *fn)(long, long), long x) {
    return fn(x, x + 1);
}

// Aggregates by value: the two conventions classify them differently
// (System V splits into eightbytes, the Microsoft x64 convention passes
// exactly 1/2/4/8-byte aggregates in one register and everything else by
// reference), so the argument marshalling and the return placement have
// to be decided by the callee's convention at both ends of the call.
struct pair {
    int lo;
    int hi;
};

struct wide {
    int a;
    int b;
    int c;
};

static MS struct wide spread(long v) {
    struct wide w;
    w.a = (int)v;
    w.b = (int)v * 2;
    w.c = (int)v * 3;
    return w;
}

static MS long gather(struct pair p, struct wide w, long tail) {
    return p.lo + p.hi * 10 + w.a * 100 + w.b * 1000 + w.c * 10000 + tail * 100000;
}

// `volatile` keeps the arguments runtime values, so the calls survive
// constant folding and the argument marshalling really runs.
static long rt(long v) {
    volatile long t = v;
    return t;
}

static double rtd(double v) {
    volatile double t = v;
    return t;
}

int main(void) {
    if (sum6(rt(1), rt(2), rt(3), rt(4), rt(5), rt(6)) != 91) {
        return 1;
    }
    if (mixed(rt(1), rt(2), rt(3), rt(4)) != 46) {
        return 2;
    }
    if (fp_mix(rt(1), rtd(2.0), rt(3), rtd(4.0)) != 30.0) {
        return 3;
    }
    struct services s;
    s.op = four;
    s.pad = 0;
    if (s.op(rt(1), rt(2), rt(3), rt(4)) != 1234) {
        return 4;
    }
    struct table t;
    t.op = two;
    if (t.op(rt(5), rt(6)) != 506) {
        return 5;
    }
    struct aliased a;
    a.op = two;
    if (a.op(rt(7), rt(8)) != 708) {
        return 6;
    }
    if (through_param(two, rt(9)) != 910) {
        return 7;
    }
    // Direct call to a definition on the foreign convention.
    if (four(rt(9), rt(8), rt(7), rt(6)) != 9876) {
        return 8;
    }
    struct wide w = spread(rt(2));
    if (w.a != 2 || w.b != 4 || w.c != 6) {
        return 9;
    }
    struct pair p;
    p.lo = (int)rt(3);
    p.hi = (int)rt(4);
    if (gather(p, w, rt(5)) != 564243) {
        return 10;
    }
    return 0;
}
