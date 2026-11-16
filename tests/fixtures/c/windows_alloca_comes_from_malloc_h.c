// On Windows an undeclared `alloca` or `_alloca` takes the declaration of
// <malloc.h>, where the C runtime declares both; the targets ship no
// <alloca.h>.
#ifdef _WIN32
int main(void) {
    char *p = alloca(16);
    char *q = _alloca(8);
    p[15] = 1;
    q[7] = 2;
    return p[15] + q[7] - 3;
}
#else
int main(void) { return 0; }
#endif
