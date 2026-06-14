// C99 6.7.9p14: an array of character type may be initialized by a
// string literal, optionally enclosed in braces. Inside a struct
// initializer the brace-wrapped form (`{ {"abc"} }`) must copy the
// string bytes into the char-array member, not write the literal's
// pointer into the member's first bytes. The bare form and the
// standalone-array brace form already worked; this pins the
// struct-member brace-wrapped form (static and automatic storage).

struct Ver {
    const void *stubs;
    char version[256];
};

static const struct Ver s = { (void *)0, {"8.6.14"} };

struct Small {
    int tag;
    char name[16];
};

static const struct Small t = { 7, {"hello"} };

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

int main(void) {
    if (!streq(s.version, "8.6.14")) {
        return 1;
    }
    if (t.tag != 7 || !streq(t.name, "hello")) {
        return 2;
    }

    // Automatic storage, leading pointer member then brace-wrapped string.
    struct Ver a = { (void *)0, {"1.2.3"} };
    if (!streq(a.version, "1.2.3")) {
        return 3;
    }

    // Bare (unbraced) string member still works.
    struct Small b = { 9, "world" };
    if (b.tag != 9 || !streq(b.name, "world")) {
        return 4;
    }

    return 0;
}
