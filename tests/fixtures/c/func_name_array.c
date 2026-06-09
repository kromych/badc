// `__func__` is a `static const char[]` of length strlen + 1 (C99
// 6.4.2.2), so `sizeof(__func__)` is the array size, not the size of a
// decayed pointer.

int main(void) {
    const char *p = __func__;
    int i;

    if (sizeof(__func__) != 5) return 1; // "main" + NUL
    for (i = 0; i < (int) sizeof(__func__); i++) {
        if (p[i] != "main"[i]) return 2;
    }
    return 0;
}
