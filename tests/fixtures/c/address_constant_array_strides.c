// Arithmetic on the address of an array steps over the whole array
// (C99 6.5.3.2p3, 6.5.6p8): `&y + 1` is one past `y`, `&m[1] + 1` one row
// on. The same holds for a string literal, a member array, a pointer cast
// to a pointer to an array, and a multi-dimensional member reached from a
// null base; `*` of an array designates its first element, a
// parenthesized pointer sum designates the element it points to, and a
// cast of a sum does not stride it.

struct T { int n; int a[4]; int b[2][3]; };

int y[4];
int m[3][4];
struct T g;

int (*after_y)[4] = &y + 1;
int (*row_after)[4] = &m[1] + 1;
int (*after_m)[3][4] = &m + 1;
int (*after_member)[4] = &g.a + 1;
int *member_2d = &g.b[1][2];
const char (*after_string)[4] = &"abc" + 1;
const char (*second_row)[4] = (const char (*)[4])"abcdefgh" + 1;
const char *first_of_string = &*"abc";
const char *first_after_sum = &*("abc" + 1);
int *element_of_sum = &(y + 1)[2];
char *row_bytes = (char *)(m + 1);
unsigned long offset_2d = (unsigned long)&((struct T *)0)->b[1][2];
unsigned long offset_past = (unsigned long)(&((struct T *)0)->a + 1);

int main(void)
{
    if ((char *)after_y != (char *)y + sizeof y) return 1;
    if ((char *)row_after != (char *)m[2]) return 2;
    if ((char *)after_m != (char *)m + sizeof m) return 3;
    if ((char *)after_member != (char *)g.a + sizeof g.a) return 4;
    if (member_2d != &g.b[1][2]) return 5;
    if (((const char *)after_string - 4)[1] != 'b') return 6;
    if ((*second_row)[0] != 'e' || (*second_row)[3] != 'h') return 7;
    if (first_of_string[0] != 'a' || first_after_sum[0] != 'b') return 8;
    if (element_of_sum != &y[3] || row_bytes != (char *)m[1]) return 9;
    if (offset_2d != __builtin_offsetof(struct T, b[1][2])) return 10;
    if (offset_past != __builtin_offsetof(struct T, a) + sizeof g.a) return 11;
    return 0;
}
