// A function name used as a call argument decays to a function pointer
// (C99 6.3.2.1p4) and seeds intra-expression function-pointer-decay state.
// That state must not leak across the statement boundary into a later
// deref-assignment (`(*p) = v`), where the unary `*` must emit a load, not
// the decay no-op. Exit 0 only when the store lands with the right value.

static int cell;
static int *cell_addr(void) { return &cell; }
typedef void (*action)(int);
static void take_action(int n, action a) { (void)n; (void)a; }

static void run(int n) {
    int saved = (*cell_addr());    // deref read
    take_action(n, run);           // function name passed as an argument
    (*cell_addr()) = saved + 1;    // deref-assignment in the next statement
}

int main(void) {
    cell = 41;
    run(0);
    return (*cell_addr()) == 42 ? 0 : 1;
}
