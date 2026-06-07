// C99 6.5.2.5 block-scope compound literals. The unnamed object
// has automatic storage duration (lifetime = enclosing block,
// 6.5.2.5p5); an array literal decays to a pointer to its first
// element (6.3.2.1p3), a struct literal yields its address, and a
// scalar literal yields its value. Non-constant element values are
// evaluated and stored at the point the literal is reached.

struct point {
    int x;
    int y;
};

static int sum(struct point *p) {
    return p->x + p->y;
}

static int first4(int *v) {
    return v[0] == 1 && v[1] == 2 && v[2] == 3 && v[3] == 4;
}

static int two_strings(char *v[]) {
    return v[0][0] == 's' && v[0][1] == 'h' && v[0][2] == 0 && v[1][0] == '-';
}

int main(void) {
    // Array literal, constant elements, size from initializer.
    if (!first4((int[]){1, 2, 3, 4})) return 1;

    // Array literal with a non-constant element evaluated in place.
    int a = 69;
    int *p = (int[]){1, 2, 3, 4, a};
    if (p[4] != 69) return 2;

    // Array of pointers to string literals.
    if (!two_strings((char *[]){"sh", "-c"})) return 3;

    // Known-size array literal, zero-filled tail (6.7.9p21).
    int *q = (int[4]){7, 8};
    if (q[0] != 7 || q[1] != 8 || q[2] != 0 || q[3] != 0) return 4;

    // Struct literal addressed with `&`, constant fields.
    if (sum(&(struct point){3, 4}) != 7) return 5;

    // Struct literal with a runtime field.
    int n = 10;
    if (sum(&(struct point){n, 5}) != 15) return 6;

    // Scalar literal yields its value.
    if ((int){42} != 42) return 7;

    return 0;
}
