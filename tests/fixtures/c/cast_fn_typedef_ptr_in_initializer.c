// A cast to a function-type-typedef pointer inside an initializer
// (`(BinOp *)add`) must not leave the function-type marker set for the
// following declaration. The marker is scoped to the cast; if it leaks, the
// next pointer object absorbs its `*` and is mis-parsed as a struct value
// (C99 6.7.6 / 6.5.4). Asserted by return code.

typedef int BinOp(int, int); // function-type typedef
typedef struct {
    BinOp *op;
    int tag;
} Entry;

static int add(int a, int b) { return a + b; }

static const Entry table = { (BinOp *)add, 7 };
static const Entry *ptr = &table; // the `*` here was wrongly absorbed

int main(void) {
    if (ptr->op(2, 3) != 5) return 1;
    if (ptr->tag != 7) return 2;
    return 0;
}
