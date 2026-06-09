// A flexible array member (`T v[];` as the last struct member, C99
// 6.7.2.1p16) contributes no storage to the struct size but its name
// decays to a pointer-to-element addressed at the field offset, so
// `p->v[i]` indexes the trailing storage. The member's element type
// still raises the struct's alignment.

#include <stddef.h>

struct bytes {
    int a;
    char v[];
};

struct words {
    int a;
    double v[];
};

int main(void) {
    if (sizeof(struct bytes) != 4) return 1;
    if (sizeof(struct words) != 8) return 2;

    int store[20];
    struct bytes *p = (struct bytes *) store;
    p->a = 2;
    p->v[0] = 1;
    p->v[3] = 9;
    if (p->a != 2) return 3;
    if (p->v[0] != 1) return 4;
    if (p->v[3] != 9) return 5;
    // The member offset is past the leading int.
    if ((char *) p->v - (char *) p != 4) return 6;

    return 0;
}
