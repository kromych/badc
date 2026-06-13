// Struct field access folds the constant field offset into the load /
// store displacement (x86-64 disp(%base), AArch64 ldr/str [base, #imm])
// rather than a separate pointer add. Mixed widths exercise the per-kind
// immediate-offset encoders; the byte field at an odd offset stays
// foldable because its width is 1. A read-modify-write of a field
// (`p->b += v`) shares one `base + offset` address between the load and
// the store; folding the offset into both accesses drops the shared
// pointer add.

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
// Read-modify-write: the field address feeds both the load and the store.
static void rmw_b(struct S *p, int v) { p->b = p->b + v; }
static void rmw_c(struct S *p, long v) { p->c += v; }
static void rmw_d(struct S *p) { p->d++; }

int main() {
    struct S s;
    s.a = 1;
    s.b = 22;
    s.c = 333;
    s.e = 44;
    s.d = 5;
    set_b(&s, 99);
    set_c(&s, 777);
    rmw_b(&s, 1);   // 99 -> 100
    rmw_c(&s, 10);  // 777 -> 787
    rmw_d(&s);      // 5 -> 6
    if (get_b(&s) != 100) return 1;
    if (get_c(&s) != 787) return 2;
    if (get_e(&s) != 44) return 3;
    if (get_d(&s) != 6) return 4;
    return 0;
}
