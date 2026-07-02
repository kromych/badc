/* A variable-length array whose dimension is a function argument. */
static int fill_and_sum(int n) {
    char buf[n];
    for (int i = 0; i < n; i++) {
        buf[i] = (char)(i + 1);
    }
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += buf[i];
    }
    return s;
}

int main(void) {
    if (fill_and_sum(10) != 55) {
        return 1;
    }
    if (fill_and_sum(4) != 10) {
        return 2;
    }
    return 0;
}
