// C99 6.2.4 block-scope object lifetimes + 6.2.2 internal linkage.
// Exercises the unused-variable / unused-parameter / unused-function
// diagnostics. Symbols prefixed with `_` are silenced by convention,
// matching gcc / clang `-Wunused`.

static int dead_static(int x) { return x + 1; }

static int live_static(int x, int unused_arg) {
    int unused_local;
    int used_local = x * 2;
    int _silenced_local;
    return used_local;
}

int main(void) {
    int main_unused;
    int main_unused_init = 7;
    int _silenced = 99;
    int used = 5;
    {
        int inner_unused;
        int inner_used = used + 1;
        used = inner_used;
    }
    return live_static(used, 0);
}
