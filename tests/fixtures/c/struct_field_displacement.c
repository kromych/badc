// Struct field access folds the constant field offset into the load /
// store displacement (x86-64 disp(%base), AArch64 ldr/str [base, #imm])
// rather than a separate pointer add. Mixed widths exercise the per-kind
// immediate-offset encoders; the byte field at an odd offset stays
// foldable because its width is 1.

struct S {
    int a;
    int b;
    long c;
    short e;
    char d;
};

static int get_b(struct S *p) { return p->b; }
static long get_c(struct S *p) { return p->c; }
static int get_e(struct S *p) { return p->e; }
static int get_d(struct S *p) { return p->d; }
static void set_b(struct S *p, int v) { p->b = v; }
static void set_c(struct S *p, long v) { p->c = v; }

int main() {
    struct S s;
    s.a = 1;
    s.b = 22;
    s.c = 333;
    s.e = 44;
    s.d = 5;
    set_b(&s, 99);
    set_c(&s, 777);
    if (get_b(&s) != 99) return 1;
    if (get_c(&s) != 777) return 2;
    if (get_e(&s) != 44) return 3;
    if (get_d(&s) != 5) return 4;
    return 0;
}
