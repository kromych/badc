// creat(path, mode) opens `path` for writing as
// open(path, O_WRONLY | O_CREAT | O_TRUNC, mode) does (POSIX): it creates
// the file, and truncates one that exists. Exits 0 when a file written
// through it reads back, and reads back empty once creat opens it again.

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static long length_of(const char *name) {
    FILE *f = fopen(name, "rb");
    long n;
    if (!f)
        return -1;
    fseek(f, 0, SEEK_END);
    n = ftell(f);
    fclose(f);
    return n;
}

int main(void) {
    char name[] = "creatXXXXXX";
    int fd;
    if (mktemp(name) != name)
        return 1;
    if ((fd = creat(name, 0600)) < 0)
        return 2;
    if (write(fd, "abc", 3) != 3 || close(fd))
        return 3;
    if (length_of(name) != 3)
        return 4;
    if ((fd = creat(name, 0600)) < 0 || close(fd))
        return 5;
    if (length_of(name) != 0)
        return 6;
    return remove(name) ? 7 : 0;
}
