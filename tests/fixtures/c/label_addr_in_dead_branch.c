/* A label whose address only a dead branch takes goes with that branch,
   together with the values the branch computes before reaching it. The
   shape is the instruction-pointer idiom passed as an argument
   (`f(x, ({ l: &&l; }))`) under a condition that folds to false. */
struct rec { int err; void *ip; };
static struct rec last;
int armed;

static void note(int e, void *ip) {
    last.err = e;
    last.ip = ip;
}

#define HERE ({ __label__ h; h: __asm__ __volatile__("" ::: "memory"); &&h; })

static void report(int st) {
    if (st)
        note(-st, HERE);
    else if (armed && 0)
        note(-5, HERE);
}

int main(void) {
    report(0);
    if (last.err != 0 || last.ip) return 1;
    report(3);
    if (last.err != -3 || !last.ip) return 2;
    return 0;
}
