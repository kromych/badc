// C99 6.7.5.2p4: a type name at block scope may name a variable-length
// array, or a type derived from one. `sizeof` of such an array type is
// computed at run time, its bound evaluated (6.5.3.4p2); a cast to a
// pointer to one strides by the size the cast computes. Each check exits
// with its own code; success returns 0.

#include <stddef.h>

static int bump(int *k) { return ++*k; }

int main(int argc, char **argv) {
    (void)argv;
    int n = argc + 2;
    int m = 4;
    int buf[3][4] = {{0}};
    if (sizeof(int[n]) != n * sizeof(int)) return 1;
    if (sizeof(int[n][3]) != n * 3 * sizeof(int)) return 2;
    if (sizeof(double[n]) != n * sizeof(double)) return 3;
    ((int (*)[m])buf)[1][2] = 7;
    if (buf[1][2] != 7) return 4;
    if (sizeof(*(int (*)[m])buf) != m * sizeof(int)) return 5;
    if ((char *)((int (*)[m])buf + 1) - (char *)buf != m * sizeof(int)) return 6;
    int k = 0;
    size_t s = sizeof(int[bump(&k)]);
    if (k != 1 || s != sizeof(int)) return 7;
    if (_Alignof(int[n]) != _Alignof(int)) return 8;
    if (sizeof(int (*)[n]) != sizeof(void *)) return 9;
    for (int w = 1; w <= 3; w++) {
        if (sizeof(char[w][2]) != (size_t)(2 * w)) return 10;
    }
    return 0;
}
