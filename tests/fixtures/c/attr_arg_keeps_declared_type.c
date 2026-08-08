// An attribute argument parses with the expression and type-name
// machinery, which resets the declared-type side channels on entry.
// The attribute must leave the declarator's type untouched:
// `typeof("") _desc __attribute__((aligned(sizeof(Word))))` is an
// array of char whose initializer stores the literal in place, not a
// pointer to a pooled copy. Covers the ELF-note member shape and the
// adjacent forms: an array-typedef member, a function-pointer typedef
// member, `_Alignas(sizeof expr)`, and file-scope / local objects.

typedef unsigned int Word;
struct hdr { Word a, b, c; };

static const struct note {
    struct hdr _hdr;
    unsigned char _name[sizeof("Linux")] __attribute__((aligned(4)));
    typeof("") _desc __attribute__((aligned(sizeof(Word))));
} n __attribute__((__used__, aligned(4))) = {
    { sizeof("Linux"), sizeof(""), 0x100, }, "Linux", ""
};

// Little-endian image of `n`: header, "Linux" NUL-padded to the next
// 4-boundary, the one-byte "" and tail padding.
static const unsigned char expected[24] = {
    6, 0, 0, 0,  1, 0, 0, 0,  0, 1, 0, 0,
    'L', 'i', 'n', 'u', 'x', 0, 0, 0,  0, 0, 0, 0,
};

typedef long pair[2];
typedef int (*cb_t)(int, int);
typedef void (*other_t)(void);

struct A { char c; pair p __attribute__((aligned(sizeof(long)))); };
struct B { char c; _Alignas(sizeof(long)) char d; };
struct C { cb_t f __attribute__((aligned(sizeof(other_t)))); };

typeof("hello") g_desc __attribute__((aligned(sizeof(Word)))) = "hello";

static int add(int a, int b) { return a + b; }

int main(void) {
    if (sizeof(struct note) != 24) return 1;
    if (sizeof(n._desc) != 1) return 2;
    const unsigned char *raw = (const unsigned char *)&n;
    for (unsigned i = 0; i < sizeof(struct note); i++)
        if (raw[i] != expected[i]) return 3;

    struct A a;
    if (sizeof(a.p) != 2 * sizeof(long)) return 4;
    if (sizeof(struct A) != 24) return 5;

    struct B b;
    if ((unsigned long)((char *)&b.d - (char *)&b) != sizeof(long)) return 6;

    struct C c;
    c.f = add;
    if (c.f(2, 3) != 5) return 7;

    if (sizeof(g_desc) != 6) return 8;
    if (g_desc[4] != 'o' || g_desc[5] != 0) return 9;

    typeof("ab") l_desc __attribute__((aligned(sizeof(Word)))) = "ab";
    if (sizeof(l_desc) != 3 || l_desc[1] != 'b') return 10;
    return 0;
}
