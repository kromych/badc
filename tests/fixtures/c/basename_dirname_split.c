// POSIX dirname and basename split a path at its last separator, ignoring
// trailing ones, with "." for a path that names no directory. On Windows,
// as mingw-w64's do, both take `\` as a separator too and keep a drive
// designator with the directory. Each check works on a copy, since either
// function may write into its argument; the exit code names the first
// check that fails.

#include <libgen.h>
#include <string.h>

static const struct {
    const char *path, *dir, *base;
} cases[] = {
    {"/usr/lib", "/usr", "lib"}, {"usr", ".", "usr"}, {"a/b/c", "a/b", "c"},
    {".", ".", "."},             {"..", ".", ".."},   {"a/b/c/", "a/b", "c"},
#ifndef _WIN32
    // mingw-w64 spells a root-only result `\`.
    {"/usr/", "/", "usr"},       {"/", "/", "/"},
#else
    {"C:\\a\\b", "C:\\a", "b"},  {"C:\\a", "C:\\", "a"}, {"C:", "C:.", "."},
    {"c:foo", "c:.", "foo"},     {"a\\b\\", "a", "b"},   {"a/b\\c", "a/b", "c"},
    {"C:\\", "C:\\", "\\"},
#endif
};

static int splits_to(const char *path, char *(*split)(char *), const char *want) {
    char copy[64];
    const char *got;
    strcpy(copy, path);
    got = split(copy);
    return got && !strcmp(got, want);
}

int main(void) {
    char empty[1] = "";
    unsigned i;
    for (i = 0; i < sizeof cases / sizeof cases[0]; i++) {
        if (!splits_to(cases[i].path, dirname, cases[i].dir))
            return 1 + 2 * (int)i;
#ifdef __linux__
        // TODO(#1676): the binding names glibc's GNU basename, which returns
        // "" after a trailing separator and takes no null path.
        if (cases[i].path[strlen(cases[i].path) - 1] == '/')
            continue;
#endif
        if (!splits_to(cases[i].path, basename, cases[i].base))
            return 2 + 2 * (int)i;
    }
    if (strcmp(dirname(empty), ".") || strcmp(dirname(0), "."))
        return 100;
#ifndef __linux__
    if (strcmp(basename(0), "."))
        return 101;
#endif
    return 0;
}
