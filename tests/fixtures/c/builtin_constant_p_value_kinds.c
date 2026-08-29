/* `__builtin_constant_p` answers 1 for a constant value and 0 for an
 * object or a symbol-relative address. The rows are gcc 16's answers at
 * -O0 and -O2, which clang 21 shares except where noted. Every backend
 * and optimization mode must give the same answer; the exit code is the
 * number of the first row that disagrees. */

struct s { int x; };
union u { int i; float f; };
static const unsigned arr[] = { 1, 2, 3 };
static const struct s st = { 1 };
static const union u un = { 1 };
static int g;
static int fn(void) { return 1; }
enum e { E0 = 5 };

/* The answer is an integer constant expression in every context. */
_Static_assert(__builtin_constant_p(arr) == 0, "an array decays to an address");
_Static_assert(__builtin_constant_p(st) == 0, "a struct object");
_Static_assert(__builtin_constant_p(un) == 0, "a union object");
_Static_assert(__builtin_constant_p(&g) == 0, "an object address");
_Static_assert(__builtin_constant_p(fn) == 0, "a function designator");
_Static_assert(__builtin_constant_p(&arr[1]) == 0, "an element address");
_Static_assert(__builtin_constant_p((unsigned long)&g) == 0, "a cast address");
_Static_assert(__builtin_constant_p((void *)0) == 1, "a null pointer constant");
_Static_assert(__builtin_constant_p("abc") == 1, "a string literal");
_Static_assert(__builtin_constant_p(E0) == 1, "an enumeration constant");
_Static_assert(__builtin_constant_p(sizeof(arr)) == 1, "a sizeof expression");
_Static_assert(__builtin_constant_p(arr == 0) == 1, "a folded pointer comparison");
_Static_assert(__builtin_constant_p(&arr[2] - &arr[0]) == 1, "a folded pointer difference");

#define PICK(x) __builtin_choose_expr(__builtin_constant_p(x), 1, 2)

int main(void) {
    const int ci = 3;

    /* Objects and addresses: 0 in both gcc modes and in clang. */
    if (__builtin_constant_p(arr) != 0) return 1;
    if (__builtin_constant_p(st) != 0) return 2;
    if (__builtin_constant_p(un) != 0) return 3;
    if (__builtin_constant_p((struct s){ 1 }) != 0) return 4;
    if (__builtin_constant_p(&g) != 0) return 5;
    if (__builtin_constant_p(&arr[1]) != 0) return 6;
    if (__builtin_constant_p(arr + 1) != 0) return 7;
    if (__builtin_constant_p((const unsigned *)arr) != 0) return 8;
    if (__builtin_constant_p(&st) != 0) return 9;
    if (__builtin_constant_p(&st.x) != 0) return 10;
    if (__builtin_constant_p((unsigned long)&g) != 0) return 11;
    if (__builtin_constant_p(fn) != 0) return 12;
    if (__builtin_constant_p(&fn) != 0) return 13;

    /* Constant values: 1 in both gcc modes and in clang. */
    if (__builtin_constant_p((void *)0) != 1) return 14;
    if (__builtin_constant_p("abc") != 1) return 15;
    if (__builtin_constant_p((const char *)"abc") != 1) return 16;
    if (__builtin_constant_p(E0) != 1) return 17;
    if (__builtin_constant_p(sizeof(arr)) != 1) return 18;
    if (__builtin_constant_p(7) != 1) return 19;
    if (__builtin_constant_p(1.5) != 1) return 20;
    if (__builtin_constant_p(arr == 0) != 1) return 21;
    if (__builtin_constant_p(&arr[2] - &arr[0]) != 1) return 22;
    if (__builtin_constant_p(arr ? 1 : 2) != 1) return 23;

    /* A compound literal denotes an object (C99 6.5.2.5p4): gcc answers
     * 0 for the scalar form and for an element read through it, where
     * clang answers 1. `sizeof` of one is a constant in both. A comma
     * inside the braces stays inside the operand. */
    if (__builtin_constant_p((int){ 1 }) != 0) return 24;
    if (__builtin_constant_p(-(int){ 1 }) != 0) return 25;
    if (__builtin_constant_p(((int[]){ 1, 2 })[0]) != 0) return 26;
    if (__builtin_constant_p((int[]){ 1, 2 }) != 0) return 27;
    if (__builtin_constant_p(sizeof((int){ 1 })) != 1) return 28;

    /* A `static const` element, a `const` local and a non-const global
     * read a value gcc knows only after propagation: 0 at -O0 and 1 at
     * -O2. The parse-time answer is 0 or 1 and never anything else. */
    if ((unsigned)__builtin_constant_p(arr[1]) > 1) return 29;
    if ((unsigned)__builtin_constant_p(st.x) > 1) return 30;
    if ((unsigned)__builtin_constant_p(ci) > 1) return 31;
    if ((unsigned)__builtin_constant_p(g) > 1) return 32;

    /* Arm selection follows the answer. */
    if (PICK(arr) != 2) return 33;
    if (PICK(st) != 2) return 34;
    if (PICK(&g) != 2) return 35;
    if (PICK(7) != 1) return 36;
    if (PICK("abc") != 1) return 37;
    if (PICK((void *)0) != 1) return 38;
    return 0;
}
