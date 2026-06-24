// Indirect call through a struct function-pointer field with six
// arguments, two of which are dereferenced inside the callee. Under
// register pressure the target pointer cannot stay in a register across
// argument marshalling and is spilled to a stack slot, and the argument
// sources are spilled too. The marshaller reloads a spilled source
// relative to the adjusted stack pointer; that shift must include the
// target slot, or a reloaded pointer argument reads the wrong stack
// offset and the callee dereferences a corrupt pointer.
typedef long (*cmp)(void *, int *, long *, long, long *, long);

struct task {
    cmp fn;
};

static long do_cmp(void *t, int *cached, long *k1, long n1, long *k2, long n2) {
    (void)t;
    *cached = 1;
    return *k1 * 1000 + *k2 * 10 + n1 + n2;
}

static long run(struct task *pt, long *p1, long n1, long *p2, long n2) {
    int cached = 0;
    long r = pt->fn(pt, &cached, p1 + 2, n1, p2 + 2, n2);
    return r + cached;
}

int main(void) {
    struct task t;
    t.fn = do_cmp;
    long a[4];
    long b[4];
    a[2] = 3;
    b[2] = 7;
    long r = run(&t, a, 5, b, 9);
    // do_cmp: *cached=1, return 3*1000 + 7*10 + 5 + 9 = 3084; +cached = 3085.
    return r == 3085 ? 0 : 1;
}
