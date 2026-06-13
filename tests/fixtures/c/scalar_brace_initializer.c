// C99 6.7.8p11: the initializer for a scalar is a single expression,
// optionally enclosed in braces, and may carry a trailing comma. This
// holds at block scope (function-body top level and nested blocks) and
// for `static` locals, not only at file scope. The brace-enclosed
// expression may be a non-constant runtime value.
static int s = { 41 }; // file scope, for contrast

int main(void) {
    int a = { 5 };           // braced integer
    char *p = { "xy" };      // braced pointer to a string literal
    int b = { a + 1 };       // braced non-constant expression
    int c = { 7, };          // trailing comma allowed
    static long t = { 100 }; // braced static local
    {
        int d = { a + b };   // nested block
        if (d != 11) return 5; // 5 + 6
    }
    if (s != 41) return 1;
    if (a != 5) return 2;
    if (p[0] != 'x' || p[1] != 'y' || p[2] != 0) return 3;
    if (b != 6) return 4;
    if (c != 7) return 6;
    if (t != 100) return 7;
    return 0;
}
