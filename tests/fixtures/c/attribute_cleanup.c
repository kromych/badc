// __attribute__((cleanup(fn))) (GCC/Clang extension; C99 has no such
// feature). At every exit from the declaring scope -- fall-through,
// return, break, continue -- fn(&var) runs, in reverse declaration
// order within a scope and innermost scope first. A returned value is
// evaluated before the cleanups run, so it observes the pre-cleanup
// state (the guarantee scope-guard and auto-cleanup idioms rely on).

static int events[64];
static int ne;
static void rec(int e) { events[ne++] = e; }
static void rc(int *p) { rec(*p); }

// Reverse declaration order within one scope.
static void order3(void) {
    int a __attribute__((cleanup(rc))) = 1;
    int b __attribute__((cleanup(rc))) = 2;
    int c __attribute__((cleanup(rc))) = 3;
    (void)a; (void)b; (void)c;
}

// A returned value is evaluated before the cleanup runs: the guard is
// still "held" when the value is read.
static int held;
static void release(int *g) { (void)g; held = 0; rec(700); }
static int guarded(void) {
    int g __attribute__((cleanup(release))) = (held = 1, 0);
    (void)g;
    return held;   // must read 1, before release() sets it to 0
}

// break runs the body scope's cleanups up to (not including) the loop's
// outer scope; continue runs them per iteration.
static void loopy(void) {
    int outer __attribute__((cleanup(rc))) = 50;
    (void)outer;
    for (int i = 0; i < 3; i++) {
        int body __attribute__((cleanup(rc))) = i;
        (void)body;
        if (i == 1) continue;   // body cleanup for i==1
        if (i == 2) break;      // body cleanup for i==2, not outer
    }
    // outer cleaned at function end
}

// An early return cleans every enclosing scope, innermost first.
static int nested(int q) {
    int f __attribute__((cleanup(rc))) = 10;
    (void)f;
    {
        int g __attribute__((cleanup(rc))) = 11;
        (void)g;
        {
            int h __attribute__((cleanup(rc))) = 12;
            (void)h;
            if (q) return 999;   // clean h, g, f
        }
    }
    return 0;
}

int main(void) {
    ne = 0;
    order3();
    if (ne != 3 || events[0] != 3 || events[1] != 2 || events[2] != 1) return 1;

    ne = 0;
    if (guarded() != 1) return 2;
    if (ne != 1 || events[0] != 700) return 3;

    ne = 0;
    loopy();
    if (ne != 4) return 4;
    if (events[0] != 0 || events[1] != 1 || events[2] != 2 || events[3] != 50) return 5;

    ne = 0;
    if (nested(1) != 999) return 6;
    if (ne != 3 || events[0] != 12 || events[1] != 11 || events[2] != 10) return 7;

    ne = 0;
    if (nested(0) != 0) return 8;
    if (ne != 3 || events[0] != 12 || events[1] != 11 || events[2] != 10) return 9;

    return 0;
}
