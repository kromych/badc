// C99 6.7.7 + 6.2.1: a `typedef` is a declaration and may appear at
// the function-body top level (not only inside a nested block). The
// name has block scope, so it must not leak to file scope: a later
// file-scope use of the same identifier sees the outer binding, and a
// function-scope typedef of a name that also names a file-scope object
// shadows it only inside that function.

typedef int outer_t; // file-scope typedef

static int g(void) {
    typedef long outer_t;   // shadows the file-scope typedef inside g
    outer_t x = 7;          // long here
    return (int)x;
}

static int h = 100; // file-scope object; a function-scope typedef of
                    // the same name below must not turn this into a type

static int k(void) {
    typedef int h;          // function-scope typedef named like the global
    h y = 5;                // int here
    return y;
}

int main(void) {
    typedef enum { A, B, C } E; // typedef at the body top, before any stmt
    E e = C;
    int a = 1;
    typedef int T;              // typedef after a statement
    T b = 2;
    if (g() != 7) return 1;
    if (k() != 5) return 2;
    if (h != 100) return 3;     // file-scope `h` unaffected by k's typedef
    if (e != 2) return 4;       // C == 2
    return e + a + b - 5;       // 2 + 1 + 2 - 5 == 0
}
