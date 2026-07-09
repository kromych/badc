/* Minimal `hexdump -C` for hosts without one (native Windows). NASM's
 * nasm-t.py shells out to `hexdump -C <file>` to render a byte diff when a
 * golden test fails; it is display-only and not part of the pass/fail verdict.
 * Built with badc so the demo needs no external tool. Reads the last argument
 * as the path (nasm-t.py invokes it as `hexdump -C <file>`). */
#include <stdio.h>

int main(int argc, char **argv) {
    if (argc < 2)
        return 1;
    FILE *f = fopen(argv[argc - 1], "rb");
    if (!f)
        return 1;
    unsigned char buf[16];
    unsigned long off = 0;
    size_t n;
    while ((n = fread(buf, 1, sizeof buf, f)) > 0) {
        printf("%08lx  ", off);
        for (size_t i = 0; i < 16; i++) {
            if (i < n)
                printf("%02x ", buf[i]);
            else
                printf("   ");
            if (i == 7)
                printf(" ");
        }
        printf(" |");
        for (size_t i = 0; i < n; i++) {
            unsigned char c = buf[i];
            putchar((c >= 32 && c < 127) ? c : '.');
        }
        printf("|\n");
        off += (unsigned long)n;
    }
    printf("%08lx\n", off);
    fclose(f);
    return 0;
}
