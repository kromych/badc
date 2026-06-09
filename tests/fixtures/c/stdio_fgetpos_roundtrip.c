// C99 7.19.1 / 7.19.9.1-2: `fpos_t` plus `fgetpos` / `fsetpos`.
// Record a stream position, advance past it, restore, and confirm
// the stream is back where `fgetpos` captured it. `fpos_t` is opaque,
// so the test exercises the libc round-trip rather than the bytes.
#include <stdio.h>

int main(void) {
    FILE *f = tmpfile();
    if (!f) return 1;
    if (fputs("hello world", f) < 0) return 2; // 11 bytes written
    fpos_t pos;
    if (fgetpos(f, &pos) != 0) return 3; // position is 11
    if (fputs("XYZ", f) < 0) return 4;   // position is 14
    if (fsetpos(f, &pos) != 0) return 5; // back to 11
    if (ftell(f) != 11) return 6;
    fclose(f);
    return 0;
}
