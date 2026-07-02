/* C99 6.7.6.2 variable-length array: a runtime-sized local array, read
   and written elementwise. Returns 0 on success. */
static int compute(int n) {
    int a[n];
    for (int i = 0; i < n; i++) {
        a[i] = i * 2;
    }
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += a[i];
    }
    return s;
}

int main(void) {
    /* 0 + 2 + 4 + 6 + 8 = 20 */
    if (compute(5) != 20) {
        return 1;
    }
    if (compute(1) != 0) {
        return 2;
    }
    return 0;
}
