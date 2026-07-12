/* C99 6.4.8: a preprocessing number is one token. `2op` passed as a
 * macro argument must stay opaque -- the identifier-shaped tail is not
 * a candidate parameter name, so `op` inside it never substitutes. */
#define GLUE(a, b) a##b
#define ENTRY3(op, arg) {GLUE(T_, arg), GLUE(gen_, op)}
#define ENTRY1(op) ENTRY3(op, 2op)

enum { T_2op = 2, gen_FOO = 1 };
static int arr[2] = ENTRY1(FOO);

/* A pp-number tail must not expand as an object-like macro either. */
#define f 99
static double d = 1.f;
#undef f

int main(void) {
    if (arr[0] != 2 || arr[1] != 1)
        return 1;
    if (d != 1.0)
        return 2;
    return 0;
}
