// C99 7.20.5: qsort and bsearch call the program's comparison function.
// The order qsort leaves equal elements in and which of several equal
// elements bsearch finds are the C library's: glibc merge-sorts, keeping
// equal elements in order, and Apple's libc quicksorts.

// snapshot-budget: exempt
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct rec {
    int key, id;
};

static int calls;

static int by_key(const void *a, const void *b) {
    const struct rec *x = a, *y = b;
    calls++;
    return (x->key > y->key) - (x->key < y->key);
}

static int ints(const void *a, const void *b) {
    return *(const int *)a - *(const int *)b;
}

static int names(const void *a, const void *b) {
    return strcmp(*(char *const *)a, *(char *const *)b);
}

int main(void) {
    int v[] = {5, -3, 9, 0, 7, 7, 1, -8, 2, 6, 4, 3};
    qsort(v, 12, sizeof v[0], ints);
    for (int i = 0; i < 12; i++)
        printf("%d ", v[i]);
    const char *words[] = {"pear", "apple", "fig", "kiwi", "banana"};
    qsort(words, 5, sizeof words[0], names);
    printf("| %s %s %s %s %s\n", words[0], words[1], words[2], words[3], words[4]);
    struct rec r[40];
    unsigned seed = 7;
    for (int i = 0; i < 40; i++) {
        seed = seed * 1103515245u + 12345u;
        r[i].key = (seed >> 16) % 4;
        r[i].id = i;
    }
    qsort(r, 40, sizeof r[0], by_key);
    int sorted = 1;
    for (int i = 1; i < 40; i++)
        sorted &= r[i - 1].key <= r[i].key;
    printf("%d", sorted);
#ifndef _WIN32
    printf(" %d:", calls);
    for (int i = 0; i < 40; i++)
        printf(" %d", r[i].id);
#endif
    printf("\n");
    int keys[] = {1, 2, 2, 2, 3, 5, 8, 8, 8, 8, 9};
    for (int k = 0; k <= 9; k++) {
        int *p = bsearch(&k, keys, 11, sizeof keys[0], ints);
        printf("%d:%d ", k, p ? (int)(p - keys) : -1);
    }
    const char *key = "kiwi", **w = bsearch(&key, words, 5, sizeof words[0], names);
    int same[] = {7, 7, 7, 7, 7, 7}, seven = 7;
    int *s = bsearch(&seven, same, 6, sizeof same[0], ints);
    printf("%s %d\n", w ? *w : "none", (int)(s - same));
    return 0;
}
