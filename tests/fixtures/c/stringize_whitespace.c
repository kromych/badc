// `#` stringizing deletes leading and trailing white space and
// collapses each internal white-space run between tokens to a single
// space (C99 6.10.3.2). White space inside a character or string
// literal is preserved, and `"` / `\` within such a literal are
// escaped; a `\` outside any literal is copied verbatim.

#define str(x) # x

static int eq(const char *a, const char *b) {
    while (*a && *b && *a == *b) { ++a; ++b; }
    return *a == 0 && *b == 0;
}

int main(void) {
    if (!eq(str(3), "3")) return 1;
    if (!eq(str( 3 ), "3")) return 2;
    if (!eq(str( 3  2 ), "3 2")) return 3;
    if (!eq(str("3 2  1\n"), "\"3 2  1\\n\"")) return 4;
    if (!eq(str('\n'), "'\\n'")) return 5;
    if (!eq(str('"'), "'\"'")) return 6;
    if (!eq(str(: @\n), ": @\n")) return 7;
    return 0;
}
