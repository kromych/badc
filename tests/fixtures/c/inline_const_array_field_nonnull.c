/* A null comparison of a const-element array's relocated pointer member is
   provably false: a const array's members cannot be written (C99 6.7.3),
   so the initializer's stored address (a string literal, never null)
   holds. At -O the comparison folds and the guarded branch drops; at -O0
   the runtime check takes the same (false) path. Identical result at both.
   This is the shape of qemu's device_class_set_props last-element guard. */
typedef struct { const char *name; int v; } Prop;
static const Prop props[] = {
    { "alpha", 10 }, { "beta", 20 }, { "gamma", 30 }
};

static int sum_named(void) {
    int t = 0;
    if (props[0].name == 0) { return -1; }
    t += props[0].v; /* 10 */
    if (props[2].name == 0) { return -2; }
    t += props[2].v; /* 30 */
    return t;        /* 40 */
}

int main(void) { return sum_named(); }
