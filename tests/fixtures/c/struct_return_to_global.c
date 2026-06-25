/* A by-value struct returned from a call or passed by value is assigned to
   a global / static object. The data segment holds writable objects, so the
   copy must succeed under the SSA interpreter as it does in native code. */
typedef struct {
    long a;
    long b;
} P;

static P mk(long x) {
    P p;
    p.a = x;
    p.b = 1;
    return p;
}
static void store_global(P v);

P g;
P arr[4];

static void store_global(P v) {
    g = v;
}

int main(void) {
    long acc = 0;
    g = mk(6); /* struct return -> global scalar */
    acc += g.a + g.b;
    for (int i = 0; i < 4; i++) {
        arr[i] = mk(i * 10); /* struct return -> global array element */
    }
    for (int i = 0; i < 4; i++) {
        acc += arr[i].a + arr[i].b;
    }
    P local;
    local.a = 3;
    local.b = 4;
    store_global(local); /* struct param -> global */
    acc += g.a + g.b;
    /* 7 + (60+4) + 7 = 78 */
    return acc == 78 ? 0 : 1;
}
