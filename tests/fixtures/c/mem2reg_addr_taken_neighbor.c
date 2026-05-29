// One local's address is taken (kept, modified through the pointer)
// while a sibling scalar (step) has its address untaken and is read
// across the loop. mem2reg promotes step and leaves kept in memory;
// taking one local's address no longer disables promotion for the
// whole function. The result is identical at -O and without it.
int g(int n) {
    int kept = 0;
    int step = n * 2;
    int *p = &kept;
    int i = 0;
    while (i < 3) {
        *p = *p + step;
        i = i + 1;
    }
    return kept;
}
int main(void) {
    return g(7);
}
