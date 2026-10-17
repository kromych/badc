/* GNU C: a cast to a union in a constant initializer is the union with the
 * member of the operand's type initialized, as an object, a member, an
 * array element and a compound literal's member, from an integer, a
 * floating constant, an address and a narrower-spelled operand. Returns 0. */
union U {
    int i;
    double d;
    char *p;
};
union X {
    unsigned char c;
    long l;
};
union A {
    int a[2];
    int b : 3;
    int i;
};
struct S {
    int k;
    union U w;
};

char g = 'g';
static union U u1 = (union U)3;
static union U u2 = (union U)2.5;
static union U u3 = (union U)&g;
static union X x1 = (union X)(unsigned char)7;
static union A a1 = (union A)8;
static struct S s1 = {1, (union U)7};
static struct S s2 = {.w = (union U)8, .k = 2};
static union U arr[] = {(union U)1, (union U)1.5, (union U)&g};
static struct S *ps = &(struct S){4, (union U)9};

static int local(void) {
    static union U u = (union U)11;
    return u.i;
}

int main(void) {
    if (u1.i != 3 || u2.d != 2.5 || u3.p != &g || x1.c != 7 || x1.l != 7 || a1.i != 8) {
        return 1;
    }
    if (s1.k != 1 || s1.w.i != 7 || s2.w.i != 8 || s2.k != 2 || sizeof arr != 3 * sizeof(union U)) {
        return 2;
    }
    if (arr[0].i != 1 || arr[1].d != 1.5 || *arr[2].p != 'g' || ps->w.i != 9) {
        return 3;
    }
    return local() == 11 ? 0 : 4;
}
