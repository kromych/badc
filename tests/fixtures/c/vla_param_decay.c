/* C99 6.7.6.3p7: a variable-length array parameter is adjusted to a
   pointer to the element type; the dimension expression documents the
   intent but the parameter is passed as a plain pointer. */
static int dot(int n, int a[n], int b[n]) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += a[i] * b[i];
    }
    return s;
}

int main(void) {
    int x[4] = {1, 2, 3, 4};
    int y[4] = {5, 6, 7, 8};
    /* 5 + 12 + 21 + 32 = 70 */
    return dot(4, x, y) == 70 ? 0 : 1;
}
