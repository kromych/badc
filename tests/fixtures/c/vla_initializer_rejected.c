/* C99 6.7.8p3: a variable-length array may not have an initializer. */
int f(int n) {
    int a[n] = {1, 2, 3};
    return a[0];
}
