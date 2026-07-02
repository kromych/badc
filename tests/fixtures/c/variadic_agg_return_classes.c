/* A variadic callee returning a <=16-byte aggregate uses the same
   eightbyte classification as a non-variadic one (System V AMD64
   3.2.3): SSE eightbytes in xmm0/xmm1, INTEGER in rax/rdx. */
struct P { double x, y; };
struct M { double d; long l; };

static struct P mkp(int n, ...) {
    struct P p;
    p.x = 1.5 * n;
    p.y = 2.25;
    return p;
}

static struct M mkm(int n, ...) {
    struct M m;
    m.d = 0.5;
    m.l = n + 41;
    return m;
}

int main(void) {
    struct P p = mkp(2);
    if (p.x != 3.0 || p.y != 2.25) return 1;
    struct M m = mkm(1);
    if (m.d != 0.5 || m.l != 42) return 2;
    return 0;
}
