/* A one-word struct carries a label address (GCC labels-as-values), is
   returned by value from an inlined helper, and its field is read back as the
   target of a computed goto. The return slot, its single store, and the disp-0
   load all sit in one block, so the slot is promoted out of memory; the
   computed-goto terminator's target value must be redirected to the stored
   register word, not left reading the neutralised slot. Two shapes: a single
   stored label, and a ternary whose two label addresses merge into the stored
   word (the store value is a phi). */
typedef struct {
    void *lbl;
} Target;

static inline Target pick(void *l) {
    Target t;
    t.lbl = l;
    return t;
}

static int simple(void) {
    int x = 0;
    Target g = pick(&&L1);
    goto *g.lbl;
L1:
    x = 7;
    return x == 7 ? 0 : 1;
}

static int ternary(int sel) {
    int x = 0;
    Target g = pick(sel ? &&A : &&B);
    goto *g.lbl;
A:
    x = 1;
    return 1;
B:
    x = 2;
    return x == 2 ? 0 : 1;
}

int main(void) {
    if (simple() != 0) return 2;
    if (ternary(0) != 0) return 3;
    return 0;
}
