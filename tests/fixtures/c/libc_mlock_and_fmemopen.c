// POSIX mlock / munlock of one page, and POSIX.1-2008 fmemopen: a "w+"
// stream writes into the caller's buffer and reads it back, a flush
// writes the terminating null byte, and SEEK_END on an "r" stream is the
// buffer's size rather than the length of the string it holds.
#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void) {
    static char page[65536];
    char buf[16], word[8];
    FILE *f;

    page[0] = 1;
    if (mlock(page, (size_t)sysconf(_SC_PAGESIZE)) != 0) return 1;
    if (munlock(page, (size_t)sysconf(_SC_PAGESIZE)) != 0) return 2;

    memset(buf, 'x', sizeof buf);
    f = fmemopen(buf, sizeof buf, "w+");
    if (!f) return 3;
    if (fputs("hello", f) == EOF || fflush(f) != 0) return 4;
    if (memcmp(buf, "hello", 6) != 0) return 5;
    rewind(f);
    if (fscanf(f, "%7s", word) != 1 || strcmp(word, "hello") != 0) return 6;
    fclose(f);

    strcpy(buf, "abc");
    f = fmemopen(buf, sizeof buf, "r");
    if (!f || fgetc(f) != 'a') return 7;
    if (fseek(f, 0, SEEK_END) != 0 || ftell(f) != (long)sizeof buf) return 8;
    fclose(f);
    return 0;
}
