// A cleanup handler is the function the attribute names where its variable
// is declared (GCC cleanup attribute): an exit taken where the handler's
// name is bound to an object -- a return, a break, the end of the
// function -- still calls the function.
static int cleaned;
__attribute__((noinline)) void cl(int *p) { cleaned += *p; }

__attribute__((noinline)) static int on_return(int k) {
    int x __attribute__((cleanup(cl))) = 7;
    {
        int cl = 5;
        if (k)
            return cl + x;
    }
    return 0;
}

__attribute__((noinline)) static int on_break(int n) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        int y __attribute__((cleanup(cl))) = i;
        {
            long cl[2] = {1, 2};
            total += (int)cl[1];
            if (i == 2)
                break;
        }
    }
    return total;
}

__attribute__((noinline)) static int at_function_end(void) {
    int z __attribute__((cleanup(cl))) = 100;
    double cl = 0.5;
    return (int)(cl * 4);
}

int main(void) {
    int bad = 0;
    cleaned = 0;
    bad |= (on_return(1) != 12 || cleaned != 7) << 0;
    cleaned = 0;
    bad |= (on_break(5) != 6 || cleaned != 3) << 1;
    cleaned = 0;
    bad |= (at_function_end() != 2 || cleaned != 100) << 2;
    return bad != 0;
}
