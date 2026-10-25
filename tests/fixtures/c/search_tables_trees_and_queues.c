// <search.h>: tsearch inserts once and returns the node, a pointer to the
// key pointer; tfind finds it, twalk visits the nodes in order at their
// depth, tdelete removes one, and lsearch appends a missing key that lfind
// then finds. On the POSIX targets hsearch enters and finds in a table and
// insque / remque link and unlink queue elements; mingw-w64 declares
// neither and counts the linear searches in unsigned int.
// snapshot-budget: exempt
#include <search.h>
#include <stdlib.h>
#include <string.h>

static int cmp(const void *a, const void *b) {
    return *(const int *)a - *(const int *)b;
}

static int order[8], visits;

static void collect(const void *node, VISIT which, int depth) {
    (void)depth;
    if ((which == postorder || which == leaf) && visits < 8)
        order[visits++] = **(int *const *)node;
}

#ifndef _WIN32
struct link {
    struct link *next, *prev;
    int value;
};
#endif

int main(void) {
    static int keys[] = {50, 20, 70, 10, 30, 60};
    void *root = 0;
    int i, probe = 30, absent = 40;
    int arr[8] = {4, 8, 15};
#ifdef _WIN32
    unsigned int n = 3;
#else
    size_t n = 3;
#endif

    for (i = 0; i < 6; i++)
        if (*(int **)tsearch(&keys[i], &root, cmp) != &keys[i]) return 1;
    if (*(int **)tsearch(&keys[4], &root, cmp) != &keys[4]) return 2;
    if (!tfind(&probe, &root, cmp) || tfind(&absent, &root, cmp)) return 3;
    twalk(root, collect);
    if (visits != 6 || order[0] != 10 || order[2] != 30 || order[5] != 70) return 4;
    if (!tdelete(&keys[1], &root, cmp) || tfind(&keys[1], &root, cmp)) return 5;
    visits = 0;
    twalk(root, collect);
    if (visits != 5 || order[1] != 30) return 6;
    for (i = 0; i < 6; i++)
        tdelete(&keys[i], &root, cmp);
    if (root) return 7;

    if (*(int *)lsearch(&absent, arr, &n, sizeof(int), cmp) != 40 || n != 4) return 8;
    if (lsearch(&arr[1], arr, &n, sizeof(int), cmp) != &arr[1] || n != 4) return 9;
    if (lfind(&absent, arr, &n, sizeof(int), cmp) != &arr[3]) return 10;

#ifndef _WIN32
    {
        ENTRY e, *found;
        struct link a = {0, 0, 1}, b = {0, 0, 2}, c = {0, 0, 3};
        // libSystem's hdestroy frees every key, glibc's none.
        char *k1 = strdup("alpha"), *k2 = strdup("beta");

        if (!hcreate(16)) return 11;
        e.key = k1;
        e.data = &keys[0];
        if (!hsearch(e, ENTER)) return 12;
        e.key = k2;
        e.data = &keys[1];
        if (!hsearch(e, ENTER)) return 13;
        e.key = "alpha";
        found = hsearch(e, FIND);
        if (!found || found->data != &keys[0]) return 14;
        e.key = "gamma";
        if (hsearch(e, FIND)) return 15;
        hdestroy();
#ifndef __APPLE__
        free(k1);
        free(k2);
#endif

        insque(&a, 0);
        insque(&c, &a);
        insque(&b, &a);
        if (a.next != &b || b.next != &c || c.prev != &b || b.prev != &a) return 16;
        remque(&b);
        if (a.next != &c || c.prev != &a) return 17;
    }
#endif
    return 0;
}
