// A function name decays to a function pointer, and unary `*` on a
// function (or function pointer) yields the function again (C99
// 6.3.2.1p4), so any number of `*` is a no-op: `(****g)(...)` calls
// `g`. A pointer to an incomplete array (`int (*p)[]`) dereferences
// address-preservingly, so `(*p)[j]` indexes the pointed-to array.

int add(int a, int b) {
    return a + b;
}

int main(void) {
    // Bare function, repeated deref.
    if ((****add)(2, 3) != 5) return 1;

    // Function-pointer variable, from `&f` and from a bare name.
    int (*f1)(int, int) = &add;
    int (*f2)(int, int) = add;
    if ((****f1)(4, 5) != 9) return 2;
    if ((***f2)(6, 7) != 13) return 3;

    // Pointer to an incomplete array.
    int v[3];
    int (*p)[] = &v;
    v[0] = 10;
    v[2] = 30;
    if ((*p)[0] != 10) return 4;
    if ((*p)[2] != 30) return 5;

    return 0;
}
