// C99 6.7.9p14 + 6.5.1: a character array may be initialized by a string
// literal, and a parenthesized string literal has the same value, so
// `char a[N] = ("str")` copies the bytes -- it must not store the
// literal's pointer. Surfaced by CPython, whose `_PyASCIIObject_INIT`
// macro expands the static string singletons' data array as
// `._data = (LITERAL)`.

struct Entry {
    long len;
    unsigned char data[12];
};

// Parenthesized string in a designated struct-member initializer.
static struct Entry e = { .len = 8, .data = ("n_fields") };
// Parenthesized (and doubly parenthesized) string for a plain array.
static char top[8] = ("hello");
static char top2[8] = (("world"));
// The bare form must keep working unchanged.
static char bare[8] = "plain";

int main(void) {
    if (e.data[0] != 'n' || e.data[1] != '_' || e.data[7] != 's') return 1;
    if (e.data[8] != 0) return 2;
    for (int i = 0; "n_fields"[i]; i++) {
        if (e.data[i] != (unsigned char) "n_fields"[i]) return 3;
    }
    if (top[0] != 'h' || top[4] != 'o' || top[5] != 0) return 4;
    if (top2[0] != 'w' || top2[4] != 'd') return 5;
    if (bare[0] != 'p' || bare[4] != 'n') return 6;
    return 0;
}
