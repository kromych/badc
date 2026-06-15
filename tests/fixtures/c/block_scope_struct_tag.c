// C99 6.2.1: a struct / union / enum tag declared in a function body
// has block scope. Two functions may define the same tag independently,
// and a body-scope tag shadows a file-scope one of the same name; the
// file-scope tag stays visible outside those bodies.

struct Pair {
    int a;
    int b;
};

static int file_scope_sum(struct Pair *p) {
    return p->a + p->b;
}

static int f1(void) {
    struct Local {
        int x;
    } v;
    v.x = 10;
    return v.x;
}

static int f2(void) {
    // Same tag name as f1's, a distinct type -- no collision.
    struct Local {
        int y;
        int z;
    } v;
    v.y = 20;
    v.z = 3;
    return v.y + v.z;
}

static int f3(void) {
    // Shadows the file-scope `struct Pair` inside this body.
    struct Pair {
        int only;
    } v;
    v.only = 7;
    return v.only;
}

int main(void) {
    if (f1() != 10) {
        return 1;
    }
    if (f2() != 23) {
        return 2;
    }
    if (f3() != 7) {
        return 3;
    }
    // The file-scope `struct Pair` is unaffected by f3's shadow.
    struct Pair p;
    p.a = 4;
    p.b = 5;
    if (file_scope_sum(&p) != 9) {
        return 4;
    }
    return 0;
}
