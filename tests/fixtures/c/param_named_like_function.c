/* C99 6.2.1p4: a parameter named like its function hides the function in
   the body, while the declarator still describes the function: its return
   type converts each `return`, and its prototype reaches the calls after
   the definition. Each function returns a type other than its parameter's. */

static double g(int g) { return g + 0.5; }
static long long h(char h) { return h * 1000000000LL; }
static int k(int k) { return k + 1; }
static char *cp(int cp) {
    static char buf[4] = "abc";
    return buf + cp;
}
struct S { int a; long b; };
static struct S sr(double sr) {
    struct S s = { (int)sr, (long)(sr * 10) };
    return s;
}
static _Bool bo(int bo) { return bo; }
static long long ll(unsigned char ll) { return ll * 100000000000LL; }
static float fl(double fl) { return (float)(fl / 2); }
double gp(float gp);
double gp(float x) { return x * 2; }
static int tfi(int x) { return x * 3; }
static int (*rf(int rf))(int) { return rf ? tfi : 0; }
static int vr(int vr, ...) { return vr; }

int main(void) {
    if (g(2) != 2.5) return 1;
    if (h(3) != 3000000000LL) return 2;
    if (k(4) != 5) return 3;
    if (*cp(1) != 'b') return 4;
    if (sr(2.5).a != 2 || sr(2.5).b != 25) return 5;
    if (bo(7) != 1) return 6;
    if (ll(200) != 20000000000000LL) return 7;
    if (fl(3.0) != 1.5f) return 8;
    if (gp(2) != 4.0) return 9;
    if (rf(1)(6) != 18) return 10;
    if (vr(7, 1.5) != 7) return 11;
    return 0;
}
