// C99 6.7.8p17: a union's subobjects in order are its first member alone,
// so a designator naming a union member completes the union once that
// member is, and the next positional initializer takes the member after
// the union -- in a static, an automatic and a compound literal object.
// Inside an anonymous structure member of the union the run goes on to
// that structure's next member first. Returns 0.
typedef union { int i; double d; long l; } U;
typedef struct { U u; long tag; } V;
typedef union { struct { int a, b; }; long l; } AU;
typedef struct { AU au; int z; } AW;
typedef struct { V v[2]; int k; } A;

V gv = { .u.d = 2.5, 4 };
AW gaw = { .au.a = 1, 2, 3 };
A ga = { .v[0].u.l = 6, 7, { { 8 }, 9 }, 10 };

static int check(const V *v, const AW *aw, const A *a) {
    if (v->u.d != 2.5 || v->tag != 4)
        return 1;
    if (aw->au.a != 1 || aw->au.b != 2 || aw->z != 3)
        return 2;
    if (a->v[0].u.l != 6 || a->v[0].tag != 7 || a->v[1].u.i != 8 || a->v[1].tag != 9 || a->k != 10)
        return 3;
    return 0;
}

int main(void) {
    V lv = { .u.d = 2.5, 4 };
    AW law = { .au.a = 1, 2, 3 };
    A la = { .v[0].u.l = 6, 7, { { 8 }, 9 }, 10 };
    int r = check(&gv, &gaw, &ga);
    if (r)
        return r;
    if ((r = check(&lv, &law, &la)))
        return 10 + r;
    return check(&(V){ .u.d = 2.5, 4 }, &(AW){ .au.a = 1, 2, 3 },
                 &(A){ .v[0].u.l = 6, 7, { { 8 }, 9 }, 10 }) * 20;
}
