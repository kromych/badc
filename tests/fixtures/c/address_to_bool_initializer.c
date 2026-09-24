// An address constant converts to `_Bool` as 1 (C99 6.3.1.2): a static
// `_Bool` initialized with an object's, a string literal's or a
// function's address holds 1 and carries no relocation, as a scalar, an
// array element, a structure member and a bit-field, and a cast to
// `_Bool` folds to 1 in an integer initializer.

int g;
int f(void) { return 0; }

_Bool from_object = &g;
_Bool from_string = "abc";
_Bool from_function = f;
_Bool elements[3] = {&g, 0, "x"};
struct { int n; _Bool b; } member = {7, &g};
struct { _Bool bit : 1; unsigned rest : 7; } bits = {&g, 5};
int through_cast = (_Bool)&g;

int main(void)
{
    if (from_object != 1 || from_string != 1 || from_function != 1) return 1;
    if (elements[0] != 1 || elements[1] != 0 || elements[2] != 1) return 2;
    if (member.n != 7 || member.b != 1) return 3;
    if (bits.bit != 1 || bits.rest != 5) return 4;
    if (through_cast != 1) return 5;
    return 0;
}
