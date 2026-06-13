// C99 6.9.1 / 6.7.5.3: an identifier declared with a function type named by a
// typedef, with no pointer, is a function declaration -- not a
// function-pointer object. A later definition of the same name is a
// redeclaration of that function, not a conflicting object. A pointer to the
// typedef (`F *p`) and a function-pointer typedef stay pointers. Asserted by
// return code.

typedef int BinOp(int, int);        // function-type typedef
typedef int (*BinOpP)(int, int);    // function-pointer typedef

static BinOp add;                   // forward declaration of a function
static int add(int a, int b) { return a + b; }

BinOp sub;                          // external-linkage function via the typedef
int sub(int a, int b) { return a - b; }

static int apply(BinOpP f, int a, int b) { return f(a, b); }

int main(void) {
    if (add(3, 4) != 7) return 1;
    if (sub(10, 4) != 6) return 2;
    BinOpP p = add;                 // a function name decays to a pointer
    if (p(2, 5) != 7) return 3;
    if (apply(sub, 9, 2) != 7) return 4;
    BinOp *q = sub;                 // pointer to the function type
    if (q(8, 3) != 5) return 5;
    return 0;
}
