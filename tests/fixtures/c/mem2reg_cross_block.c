// `base` is assigned once and read in the loop body (a different
// block), with its address never taken -- mem2reg promotes it to a
// register under -O. `sum` and `i` are reassigned across the back
// edge and stay in memory until phi insertion lands. The result is
// identical at -O and without it.
int main(void) {
    int base = 14;
    int sum = 0;
    int i = 0;
    while (i < 3) {
        sum = sum + base;
        i = i + 1;
    }
    return sum;
}
