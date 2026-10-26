// A prototype's parameter-list tags have prototype scope, a definition's the
// function's block (C99 6.2.1p4); a selection or iteration statement and each
// substatement is a block (6.8.4p3, 6.8.5p5). The exit status is the number
// of the first check that fails.
struct t { char c; };
struct u { char c; };
enum { A = 1 };

void proto(struct t { int a, b; } *);

static int def(struct u { int a, b; } *pu) {
    struct u w = { 1, 2 };
    return pu->a + w.b + (int)sizeof(struct u);
}

int main(void) {
    int arr[2] = { 5, 6 }, n = 0;
    struct s { char c; };
    if (sizeof(struct t) != 1)
        return 1;
    if (def((void *)arr) != 5 + 2 + 2 * (int)sizeof(int) || sizeof(struct u) != 1)
        return 2;
    for (struct s { int a, b; } q = { 1, 2 }; q.a < 2; q.a++)
        n += (int)sizeof(struct s) == 2 * (int)sizeof(int);
    if (n != 1 || sizeof(struct s) != 1)
        return 3;
    if (sizeof(struct w { int a[3]; }) == 3 * sizeof(int))
        n += (int)sizeof(struct w) == 3 * (int)sizeof(int);
    struct w { char c; };
    if (n != 2 || sizeof(struct w) != 1)
        return 4;
    switch (sizeof(struct x { long l; })) {
    default:
        n += sizeof(struct x) == sizeof(long);
    }
    while (sizeof(struct y { short h; }) != sizeof(short))
        return 5;
    do
        n += 1;
    while (sizeof(struct z { int i; }) != sizeof(int));
    struct x { char c; };
    struct y { char c; };
    struct z { char c; };
    if (n != 4 || sizeof(struct x) + sizeof(struct y) + sizeof(struct z) != 3)
        return 6;
    if (n)
        (void)sizeof(struct r { int a; });
    else
        (void)sizeof(struct r { char b[3]; });
    struct r { short s; };
    if (sizeof(struct r) != sizeof(short))
        return 7;
    if (sizeof(enum { A = 2, B }) == sizeof(int) && A == 2)
        n += 1;
    if (n != 5 || A != 1)
        return 8;
    return 0;
}
