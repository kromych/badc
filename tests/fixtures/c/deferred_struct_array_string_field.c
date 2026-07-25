// A deferred-size struct array whose first element starts with a
// string literal: the staged storage must be reserved before the `{`
// is consumed, or the string's bytes (lexed with the first token, NUL
// added by the parser afterwards) alias element 0's slot or lose the
// terminator when their end lands on an 8-byte boundary. Lengths 1..8
// cover every end alignment, at file scope, block-static, and
// automatic storage.

struct named {
    const char *name;
    int v;
};

static struct named ftab[] = {{"a", 1}, {"bb", 2}};

int check(const struct named *t, const char *s0, const char *s1) {
    if (t[0].name[0] != s0[0] || t[1].name[0] != s1[0]) return 1;
    for (int i = 0; s0[i] || t[0].name[i]; i++)
        if (t[0].name[i] != s0[i]) return 1;
    for (int i = 0; s1[i] || t[1].name[i]; i++)
        if (t[1].name[i] != s1[i]) return 1;
    return 0;
}

int main(void) {
    if (sizeof(ftab) / sizeof(ftab[0]) != 2) return 1;
    if (check(ftab, "a", "bb") || ftab[0].v != 1 || ftab[1].v != 2) return 2;

    static struct named stab[] = {{"ccc", 3}, {"dddd", 4}};
    if (check(stab, "ccc", "dddd") || stab[1].v != 4) return 3;

    struct named atab[] = {{"eeeee", 5}, {"ffffff", 6}};
    if (check(atab, "eeeee", "ffffff") || atab[0].v != 5) return 4;

    // Flat entries (no per-element braces) with leading strings; the
    // lengths walk the data cursor through every end alignment.
    struct named a1[] = {"g", 7, "hhhhhhh", 8};
    struct named a2[] = {"iiiiiiii", 9};
    static struct named s1[] = {"jj", 10, "kkk", 11};
    if (check(a1, "g", "hhhhhhh") || a1[1].v != 8) return 5;
    if (a2[0].name[7] != 'i' || a2[0].name[8] != 0 || a2[0].v != 9) return 6;
    if (check(s1, "jj", "kkk") || s1[0].v != 10) return 7;

    return 0;
}
