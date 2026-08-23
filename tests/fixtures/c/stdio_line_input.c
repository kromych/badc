// POSIX.1-2008 delimited line input (`getline` / `getdelim`) and
// descriptor-formatted output (`dprintf`). libSystem and the Linux C
// library export all three; on Windows `libc/lib/stdio_ext.c` supplies
// them. The cases below are the ones the two platform libraries agree
// on, so a target drifting from them fails here.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(void) {
    FILE *f = tmpfile();
    char *line = 0;
    size_t cap = 0;
    long n;
    char back[64];
    int fd;

    if (!f) {
        return 1;
    }
    // Three lines; the second holds an embedded NUL, so its length is
    // the return value and not `strlen`.
    if (fwrite("one\ntw", 1, 6, f) != 6) {
        return 2;
    }
    if (fputc(0, f) != 0) {
        return 3;
    }
    if (fwrite("o\nthree", 1, 7, f) != 7) {
        return 4;
    }
    rewind(f);

    // A null pointer with a zero capacity allocates.
    n = getline(&line, &cap, f);
    if (n != 4 || line == 0 || cap < 5) {
        return 5;
    }
    // The delimiter stays in the result and the result is terminated.
    if (memcmp(line, "one\n", 4) != 0 || line[4] != 0) {
        return 6;
    }

    n = getline(&line, &cap, f);
    if (n != 5) {
        return 7;
    }
    if (memcmp(line, "tw\0o\n", 5) != 0 || line[5] != 0) {
        return 8;
    }

    // The last line has no delimiter; the bytes still come back.
    n = getline(&line, &cap, f);
    if (n != 5 || memcmp(line, "three", 5) != 0) {
        return 9;
    }
    // End of input with nothing read returns -1.
    if (getline(&line, &cap, f) != -1) {
        return 10;
    }
    fclose(f);

    // getdelim on a delimiter other than newline, into a buffer too
    // small to hold the line: it is grown and both out-parameters are
    // updated.
    f = tmpfile();
    if (!f) {
        return 11;
    }
    if (fputs("alpha:beta", f) < 0) {
        return 12;
    }
    rewind(f);
    free(line);
    line = (char *)malloc(2);
    if (line == 0) {
        return 13;
    }
    cap = 2;
    n = getdelim(&line, &cap, ':', f);
    if (n != 6 || cap < 7) {
        return 14;
    }
    if (memcmp(line, "alpha:", 6) != 0 || line[6] != 0) {
        return 15;
    }
    n = getdelim(&line, &cap, ':', f);
    if (n != 4 || memcmp(line, "beta", 4) != 0) {
        return 16;
    }
    free(line);
    fclose(f);

    // dprintf writes through the descriptor, not the stream, so the
    // bytes are readable straight back from it.
    f = tmpfile();
    if (!f) {
        return 17;
    }
    fd = fileno(f);
    if (fd < 0) {
        return 18;
    }
    if (dprintf(fd, "%s=%d\n", "count", 42) != 9) {
        return 19;
    }
    if (lseek(fd, 0, SEEK_SET) != 0) {
        return 20;
    }
    if (read(fd, back, (int)sizeof back) != 9) {
        return 21;
    }
    if (memcmp(back, "count=42\n", 9) != 0) {
        return 22;
    }
    fclose(f);
    return 0;
}
