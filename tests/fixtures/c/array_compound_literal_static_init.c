// C99 6.5.2.5: an array-typed compound literal `(T[]){...}` in a static
// initializer creates an anonymous array; its name decays to a pointer
// to the first element. Used by pegen-style keyword tables
// (`static KT *table[] = { (KT[]){{...}}, ... };`). Struct elements with
// string-literal fields append to the data segment as they are filled,
// so the element offsets must come from the array base, not the live
// data length.

typedef struct { const char *s; int v; } KT;

static KT *table[] = {
    (KT[]){{"a", 1}},
    (KT[]){{"if", 682}, {"in", 651}, {0, -1}},
    (KT[3]){{"x", 7}},   // fixed size, trailing positions zero-filled
};

int main(void) {
    if (table[0][0].v != 1) return 1;
    if (table[0][0].s[0] != 'a') return 2;

    if (table[1][0].v != 682) return 3;
    if (table[1][0].s[0] != 'i' || table[1][0].s[1] != 'f') return 4;
    if (table[1][1].v != 651) return 5;
    if (table[1][1].s[1] != 'n') return 6;
    if (table[1][2].v != -1) return 7;
    if (table[1][2].s != 0) return 8;

    if (table[2][0].v != 7) return 9;
    if (table[2][1].v != 0 || table[2][1].s != 0) return 10;
    if (table[2][2].v != 0) return 11;

    return 0;
}
