/* C99 6.7.8p7: a designator list may continue past the array index
 * into the element (`[N].field = v`), in block-scope static and
 * automatic struct arrays, including bitfield members and fully
 * indexed multi-dimensional chains (`[i][j].field = v`). */
enum k { K0, K1, K2, K3 };

struct S {
    unsigned flags : 8;
    unsigned other : 8;
    int x;
};

struct M {
    int v;
};

int main(void) {
    static struct S a[4] = {
        [K0].flags = 1,
        [K1].flags = 2,
        [K2].flags = 0,
        [K3].flags = 0,
    };
    struct S b[2] = {[K0].flags = 3, [K1].x = 4};
    static struct M g[2][2] = {[1][0].v = 7};
    struct M h[2][2] = {[0][1].v = 9};
    /* GNU range designators, plain and with a member chain. */
    static struct S r[4] = {[0 ... 3].flags = 9, [2].x = 5};
    struct M q[5] = {[1 ... 3].v = 6};

    if (a[0].flags != 1 || a[1].flags != 2 || a[2].flags != 0 || a[3].flags != 0)
        return 1;
    if (a[0].other != 0 || a[0].x != 0)
        return 2;
    if (b[0].flags != 3 || b[1].x != 4 || b[1].flags != 0)
        return 3;
    if (g[1][0].v != 7 || g[0][0].v != 0)
        return 4;
    if (h[0][1].v != 9 || h[1][1].v != 0)
        return 5;
    if (r[0].flags != 9 || r[3].flags != 9 || r[2].x != 5 || r[1].x != 0)
        return 6;
    if (q[0].v != 0 || q[1].v != 6 || q[3].v != 6 || q[4].v != 0)
        return 7;
    return 0;
}
