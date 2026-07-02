// C99 6.7.8p7/p14: a designator chain `.outer.inner = "str"` naming a
// char-array member copies the string's bytes (with zero fill), the
// same as naming the member directly; it must not store the literal's
// address. Checked for a static object (constant staging) and for an
// automatic object whose sibling values force the runtime store path.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

struct In { int x; char name[8]; };
struct Out { struct In in; int y; };

struct Out g = { .in.name = "abc", .y = 7, .in.x = 5 };

static int str_eq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(int argc, char **argv) {
    (void)argv;
    if (!str_eq(g.in.name, "abc")) return 1;
    if (g.in.name[3] != 0 || g.in.name[7] != 0) return 2;
    if (g.y != 7 || g.in.x != 5) return 3;

    struct Out l = { .in.name = "wxyz", .y = argc + 6, .in.x = argc + 4 };
    if (!str_eq(l.in.name, "wxyz")) return 4;
    if (l.in.name[4] != 0 || l.in.name[7] != 0) return 5;
    if (l.y != argc + 6 || l.in.x != argc + 4) return 6;
    return 0;
}
