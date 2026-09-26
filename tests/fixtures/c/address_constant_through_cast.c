// An address constant designated through a cast keeps its relocation and
// takes the cast's type: `&((struct B *)&a)->b` is the member at struct
// B's offset from `a`, and `&((int *)g)[3]` strides by `int`. The
// outermost of two casts sets the stride of the arithmetic after it, and
// `(&s[1])->buf` is `s[1].buf`, an array that decays to its address.

struct A { int pad; int b; } a;
struct B { long q; int b; };
long g[4];
struct S { int n; char buf[4]; } s[2];

int *member_through_cast = &((struct B *)&a)->b;
int *element_through_cast = &((int *)g)[3];
const char *string_through_cast = &((const char *)"abcd")[2];
char *array_member_through_amp = (&s[1])->buf;
char *outer_cast = (char *)(long *)&g[1] + 2;

int main(void)
{
    char *member = (char *)&a + __builtin_offsetof(struct B, b);
    if ((char *)member_through_cast != member) return 1;
    if (element_through_cast != (int *)g + 3) return 2;
    if (string_through_cast[0] != 'c' || string_through_cast[1] != 'd') return 3;
    if (array_member_through_amp != s[1].buf) return 4;
    if (outer_cast != (char *)&g[1] + 2) return 5;
    return 0;
}
