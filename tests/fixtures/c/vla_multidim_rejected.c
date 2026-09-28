/* A non-constant inner dimension needs a run-time row stride, which c5's
   stride model cannot represent; rejected cleanly rather than miscompiled
   (C99 6.7.6.2). A constant inner dimension is supported. */
int f(int n, int m) {
    int a[n][m];
    return a[0][0];
}
