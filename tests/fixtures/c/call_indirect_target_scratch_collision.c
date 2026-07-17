// CallIndirect emit must pick a target-stage scratch register
// that does not hold an argument source value. The x86_64 emit
// previously hardcoded R11 for the target pointer; under
// allocator placements where R11 also holds an argument (the
// shape exposed by relaxing the calls_after_def upper bound)
// the target staging overwrites the arg before the marshal
// reads it. This fixture mirrors a real-world open() dispatch: forward five
// parameters into an indirect call, with one argument computed
// as `flags & mask` so the BinopI result is the natural target
// for whatever scratch register the call also uses.

#include <stdio.h>

typedef int (*op_fn)(void *vfs, const char *path, void *file, int flags, int *out);

struct vtab {
    op_fn op;
};

static int sink_op(void *vfs, const char *path, void *file, int flags, int *out) {
    (void)vfs;
    (void)file;
    *out = flags + (int)path[0];
    return 0;
}

static int forward(struct vtab *t, const char *path, void *file, int flags, int *out) {
    return t->op(t, path, file, flags & 0xFFFF, out);
}

int main(void) {
    struct vtab t;
    t.op = sink_op;
    int out = 0;
    int rc = forward(&t, "A", (void *)0, 0x1FFFF, &out);
    // flags & 0xFFFF = 0xFFFF = 65535
    // out = 65535 + 'A' (65) = 65600
    printf("rc=%d out=%d\n", rc, out);
    return (rc == 0 && out == 65600) ? 0 : 1;
}
