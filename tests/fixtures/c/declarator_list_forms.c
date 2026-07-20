/* C99 6.7p1: the declarators of one declaration are comma-separated and
 * the list ends at `;`. The shapes that legitimately appear in such a
 * list must keep parsing and produce the right values. */

typedef int mi;
typedef int A, B;
typedef int (*binop)(int, int);

struct P {
    int x, y;
};

enum E { E_ZERO, E_ONE, E_TWO };

int g_a, g_b = 4;
int *g_p, g_q = 3;
int g_arr[3] = {1, 2, 3}, g_scalar = 4;
int g_matrix[2][2] = {[0][1] = 3, [1][0] = 4};
struct P g_ps[2] = {{1, 2}, {3, 4}}, g_one = {5, 6};
char *g_s = "ab", *g_t = "cd";
mi g_mi = 7;
enum E g_e = E_TWO;
int g_attr __attribute__((unused));

int add(int, int);
int sub(int, int);

int add(int a, int b) { return a + b; }

/* Old-style definition: each parameter declaration ends at its own `;`. */
int sub(a, b)
int a;
int b;
{
    return a - b;
}

int main(void) {
    int l_a = 1, *l_p = &l_a, l_c[2] = {1, 2};
    A l_x = 1;
    B l_y = 2;
    binop f = add, h = sub;
    static int l_static = 5;

    g_p = &g_a;
    g_a = 2;

    if (g_b != 4 || g_q != 3 || *g_p != 2)
        return 1;
    if (g_arr[0] + g_arr[2] + g_scalar != 8)
        return 2;
    if (g_matrix[0][1] != 3 || g_matrix[1][0] != 4)
        return 3;
    if (g_ps[0].x + g_ps[1].y + g_one.x != 1 + 4 + 5)
        return 4;
    if (g_s[0] != 'a' || g_t[1] != 'd')
        return 5;
    if (g_mi != 7 || g_e != E_TWO || g_attr != 0)
        return 6;
    if (l_a + *l_p + l_c[0] + l_c[1] != 5)
        return 7;
    if (l_x + l_y + l_static != 8)
        return 8;
    if (f(20, 3) != 23 || h(20, 3) != 17)
        return 9;
    return 42;
}
