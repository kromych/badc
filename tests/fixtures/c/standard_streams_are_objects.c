// The standard streams are expressions of type `FILE *` (C17 7.21.1). glibc
// and Apple's libc define them as objects: `&stdout` forms, and assigning
// another stream to `stdout` redirects the functions that write to it
// implicitly. msvcrt's are elements of its `_iob` array. Returns 0 when every
// check passes; each failure returns a distinct code.

#include <stdio.h>
#include <string.h>

int main(void) {
#ifdef _WIN32
    if (stdout != &__iob_func()[1] || stderr != &__iob_func()[2]) return 1;
    return 0;
#else
    FILE **out = &stdout;
    if (*out != stdout) return 2;
    FILE *f = tmpfile();
    if (!f) return 3;
    FILE *saved = stdout;
    stdout = f;
    if (printf("x=%d", 42) != 4) return 4;
    if (putchar('!') != '!') return 5;
    if (puts("") < 0) return 6;
    stdout = saved;
    if (fflush(f) != 0) return 7;
    rewind(f);
    char buf[16] = {0};
    if (!fgets(buf, sizeof buf, f)) return 8;
    if (strcmp(buf, "x=42!\n") != 0) return 9;
    fclose(f);
    return *out == saved ? 0 : 10;
#endif
}
