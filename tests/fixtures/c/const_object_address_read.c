// A read of a `const` object whose bytes hold an address constant yields
// that address with its relocation, as gcc and clang fold it: a pointer
// object, a pointer member, a pointer-wide integer holding a cast address
// and a function pointer, at file and block scope.

typedef __INTPTR_TYPE__ iptr;

static int g;
int f(void) { return 7; }

static int *const p = &g;
static const struct { int n; int *q; } s = {1, &g};
static const iptr v = (iptr)&g;
static int (*const fp)(void) = f;

int *from_pointer = p;
int *from_member = s.q;
iptr from_integer = v;
int (*from_function)(void) = fp;

int main(void)
{
    static int *block = p;
    static iptr block_integer = v;
    if (from_pointer != &g || from_member != &g || block != &g) return 1;
    if (from_integer != (iptr)&g || block_integer != (iptr)&g) return 2;
    if (from_function != f || from_function() != 7) return 3;
    return 0;
}
