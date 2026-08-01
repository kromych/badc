// C99 6.5.6p9 in a static initializer: the difference of two pointers
// into one object folds to the element-subscript difference, and a
// pointer cast retypes the stride (a `char *` difference is the byte
// count). The cast must fold with the expression, not be discarded.

struct s { int a; int b; };
static struct s obj;

static int elems = (int)(&obj.b - &obj.a);
static int bytes = (int)((char *)&obj.b - (char *)&obj.a);
static long bytes2 = ((char *)&obj.b - (char *)&obj.a);
static int with_add = (int)(&obj.b - &obj.a) + 0;

int main(void) {
    if (elems != 1) return 1;
    if (bytes != (int)sizeof(int)) return 2;
    if (bytes2 != (long)sizeof(int)) return 3;
    if (with_add != 1) return 4;
    return 0;
}
