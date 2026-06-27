/* C99 6.5.17: the left operand of a comma operator is evaluated for its
   side effects, then its value is discarded. A struct assignment (a
   memcpy-class side effect) as the discarded left operand, nested in an
   enclosing assignment whose target is a global, must still execute.
   The struct-assignment lvalue must not be left on the AST vstack, or
   the enclosing assignment consumes it as its own lvalue and drops
   itself together with the comma's side effect. */

struct s {
    unsigned char b;
    int c;
    signed char d;
};

static struct s g;
static struct s f;
static struct s n = {2, 15, 7};
static int gg;
static signed char buf;

static int via_global_scalar(int o) {
    gg = (g = n, o); /* g = n must run even though its value is discarded */
    return gg;
}

static int via_global_member(int o) {
    f.b = (f = n, o); /* whole-struct copy then member store of the comma value */
    return f.c;
}

static int via_deref(int o, signed char *p) {
    *p = (g = n, o);
    return *p;
}

int main(void) {
    g.c = 0;
    via_global_scalar(9);
    if (g.c != 15) {
        return 1;
    }
    f.c = 0;
    via_global_member(3);
    if (f.c != 15) {
        return 2;
    }
    g.c = 0;
    via_deref(1, &buf);
    if (g.c != 15) {
        return 3;
    }
    return 0;
}
