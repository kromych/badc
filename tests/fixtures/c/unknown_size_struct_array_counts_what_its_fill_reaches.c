/* An array of structures of unknown size takes as many elements as its
 * brace-elided initializer reaches (C99 6.7.8p20, p22): a string fills a
 * character array member whole (p14), a value of a member's structure type
 * that member (p13), a designator moves the position (p17). At file scope,
 * as a block-scope static and automatic, beside a non-constant value, in
 * compound literals, whose type has those elements, and in rows. Returns 0. */
#include <string.h>

struct S {
    char m[3];
    int n;
};
struct T {
    struct S s;
    long k;
};
struct U {
    int a;
    char t[4];
    char *p;
};
union V {
    char c[4];
    int i;
};
struct W {
    union V v;
    int z;
};

struct S fa[] = {"ab", 1, "de", 2};
struct S fp[] = {"ab", 1, "de"};
struct S fc[] = {'a', 'b', 'c', 1, 'd', 'e', 'f', 2};
struct S fm[] = {"ab", 1, {"de", 2}, 'x', 'y', 'z', 3};
struct S fd[] = {"ab", 1, [3] = "de", 2};
struct S ff[] = {"ab", 1, [2].n = 5, "xy"};
struct T ft[] = {"ab", 1, 10, "de", 2, 20};
struct U fu[] = {1, "abc", "p", 2, "def", "q"};
struct W fw[] = {"abc", 1, "def", 2};
struct S fr[][2] = {"ab", 1, "cd", 2, "ef", 3};
struct S *fl = (struct S[]){"ab", 1, "de", 2};

static int is(const struct S *e, const char *m, int n) {
    return memcmp(e->m, m, 3) == 0 && e->n == n;
}

static int file_scope(void) {
    if (sizeof fa / sizeof *fa != 2 || !is(&fa[1], "de", 2) || sizeof fp / sizeof *fp != 2) {
        return 1;
    }
    if (!is(&fp[1], "de", 0) || sizeof fc / sizeof *fc != 2 || !is(&fc[1], "def", 2)) {
        return 2;
    }
    if (sizeof fm / sizeof *fm != 3 || !is(&fm[1], "de", 2) || !is(&fm[2], "xyz", 3)) {
        return 3;
    }
    if (sizeof fd / sizeof *fd != 4 || !is(&fd[3], "de", 2) || sizeof ff / sizeof *ff != 4) {
        return 4;
    }
    if (ff[2].n != 5 || !is(&ff[3], "xy", 0) || sizeof ft / sizeof *ft != 2 || ft[1].k != 20) {
        return 5;
    }
    if (sizeof fu / sizeof *fu != 2 || memcmp(fu[1].t, "def", 4) || fu[1].p[0] != 'q') {
        return 6;
    }
    if (sizeof fw / sizeof *fw != 2 || fw[1].z != 2 || memcmp(fw[1].v.c, "def", 4)) {
        return 7;
    }
    if (sizeof fr / sizeof *fr != 2 || !is(&fr[1][0], "ef", 3) || fr[1][1].n != 0) {
        return 8;
    }
    return is(&fl[0], "ab", 1) && is(&fl[1], "de", 2) ? 0 : 9;
}

static int block_scope(int x) {
    static struct S s1[] = {"ab", 1, "de", 2};
    static struct T s2[] = {"ab", 1, 10, "de", 2, 20};
    static struct S s3[][2] = {"ab", 1, "cd", 2, "ef", 3};
    struct S a1[] = {"ab", 1, "de", 2};
    struct S a2[] = {"ab", x, "de", 2};
    struct S a3[][2] = {"ab", 1, "cd", 2, "ef", 3};
    struct S *l1 = (struct S[]){"ab", 1, "de", x};
    struct S(*l2)[2] = &(struct S[]){"ab", x, "de", 2};
    int l3 = sizeof((struct S[]){1, 2, 3, x, 5, 6, 7, 8});
    if (sizeof s1 / sizeof *s1 != 2 || !is(&s1[1], "de", 2) || sizeof s2 / sizeof *s2 != 2) {
        return 10;
    }
    if (s2[1].k != 20 || sizeof s3 / sizeof *s3 != 2 || !is(&s3[1][0], "ef", 3)) {
        return 11;
    }
    if (sizeof a1 / sizeof *a1 != 2 || !is(&a1[1], "de", 2) || sizeof a2 / sizeof *a2 != 2) {
        return 12;
    }
    if (!is(&a2[0], "ab", x) || sizeof a3 / sizeof *a3 != 2 || a3[1][1].n != 0) {
        return 13;
    }
    if (!is(&l1[0], "ab", 1) || !is(&l1[1], "de", x) || !is(&(*l2)[1], "de", 2)) {
        return 14;
    }
    return l3 == 2 * sizeof(struct S) ? 0 : 15;
}

int main(void) {
    int r = file_scope();
    return r ? r : block_scope(7);
}
