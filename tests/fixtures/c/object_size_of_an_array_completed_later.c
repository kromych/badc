// A file-scope `T x[];` is a tentative definition whose bound a later
// declaration may supply (C17 6.9.2). Before that declaration,
// __builtin_object_size answers for the object the unit ends with, or
// reports it unknown, never the one element an uncompleted bound would
// take. Exits 0 when no answer is smaller than the completed object.

#include <stddef.h>

struct S {
    int a[10];
};

static struct S table[];

static int check(void) {
    size_t whole = __builtin_object_size(table, 0);
    size_t field = __builtin_object_size(table, 1);
    size_t rest = __builtin_object_size(&table[1], 1);
    if (whole != (size_t)-1 && whole < 2 * sizeof(struct S))
        return 1;
    if (field != (size_t)-1 && field < 2 * sizeof(struct S))
        return 2;
    if (rest != (size_t)-1 && rest < sizeof(struct S))
        return 3;
    return 0;
}

static struct S table[] = {{{1}}, {{2}}};

int main(void) {
    if (table[1].a[0] != 2)
        return 4;
    return check();
}
