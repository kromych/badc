/* Multidimensional VLAs need runtime element strides, which c5's
   compile-time stride model cannot represent; rejected cleanly rather
   than miscompiled (C99 6.7.6.2). */
int f(int n, int m) {
    int a[n][m];
    return a[0][0];
}
