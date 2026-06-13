// ftw (POSIX file-tree walk) recurses a directory and calls a program
// callback for each entry. Create a unique temp directory with three
// files, walk it, and count the callback invocations. Exercises a libc
// routine calling back into a program function pointer with the entry
// path. Windows uses a different directory API.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>

static int seen = 0;

static int visit(const char *path, const struct stat *sb, int typeflag) {
    (void)sb;
    (void)typeflag;
    if (path) {
        seen++;
    }
    return 0;
}

int main(void) {
    char dir[] = "/tmp/badc_ftwXXXXXX";
    if (!mkdtemp(dir)) {
        return 1;
    }
    char path[256];
    for (int i = 0; i < 3; i++) {
        snprintf(path, sizeof path, "%s/f%d", dir, i);
        FILE *f = fopen(path, "w");
        if (!f) {
            return 2;
        }
        fclose(f);
    }
    int r = ftw(dir, visit, 16);
    // The directory itself plus its three files: at least four entries.
    return (r == 0 && seen >= 4) ? 0 : 3;
}
#endif
