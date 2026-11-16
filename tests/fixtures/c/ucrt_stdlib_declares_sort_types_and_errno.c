// The UCRT's <stdlib.h> declares the comparison function types, the
// context-taking qsort_s and bsearch_s, intptr_t and uintptr_t (through
// vcruntime.h), and errno, so a unit that includes it alone uses them.
#ifdef _WIN32
#include <stdlib.h>

static int __cdecl by_value(void *context, const void *a, const void *b) {
    ++*(int *)context;
    return *(const int *)a - *(const int *)b;
}

static int __cdecl plain(const void *a, const void *b) {
    return *(const int *)a - *(const int *)b;
}

int main(void) {
    static const _CoreCrtSecureSearchSortCompareFunction secure[] = {by_value};
    _CoreCrtNonSecureSearchSortCompareFunction nonsecure = plain;
    int calls = 0;
    int v[4] = {3, 1, 4, 2};
    qsort_s(v, 4, sizeof v[0], secure[0], &calls);
    if (v[0] != 1 || v[3] != 4 || calls == 0)
        return 1;
    int key = 3;
    int *hit = bsearch_s(&key, v, 4, sizeof v[0], by_value, &calls);
    if (hit != &v[2])
        return 2;
    qsort(v, 4, sizeof v[0], nonsecure);
    intptr_t p = (intptr_t)&key;
    uintptr_t u = (uintptr_t)p;
    errno = 0;
    return (int)(u & 0) + errno;
}
#else
int main(void) { return 0; }
#endif
