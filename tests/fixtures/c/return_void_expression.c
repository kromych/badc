// `return <void-expr>;` in a void function: the expression is evaluated
// for its side effects, no value returned (gcc/clang accept this form).

static int hits;

static void bump(void) {
    hits++;
}

static void wrap(void) {
    return bump();
}

int main(void) {
    wrap();
    wrap();
    return hits == 2 ? 0 : 1;
}
