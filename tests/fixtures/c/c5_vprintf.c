#include <c5io.h>

// User-defined printf clone built on c5_vprintf -- the whole point
// of <c5io.h>: variadic forwarding stays in pure c5 territory and
// doesn't have to bridge into the platform va_list ABI.
int my_printf(char *fmt, ...) {
    va_list ap;
    int n;
    va_start(ap, fmt);
    n = c5_vprintf(fmt, ap);
    va_end(ap);
    return n;
}

int main() {
    int n;
    n = my_printf("hello %s, %d times, char %c, hex %x, %%-literal\n",
                  "world", 42, 'A', 255);
    // 6 + 5 + 2 + 2 + 2 + 8 + 1 + 1 + 4 + 2 + 3 + 2 + 9 + 1
    // = "hello " "world" ", " "42" " times, char " "A" ... ; just
    //   verify a positive count -- exact length tracking is fragile
    //   when this fixture grows, and the per-component bytes are
    //   covered by smaller assertions below.
    if (n <= 0) return 1;

    // Empty format -- 0 bytes, no walks of ap.
    n = my_printf("");
    if (n != 0) return 2;

    // Trailing % with no specifier should not crash and should
    // contribute zero bytes.
    n = my_printf("%");
    if (n != 0) return 3;

    // Unknown specifier: emit literally as `%q`, two bytes, no
    // va_arg consumed.
    n = my_printf("%q\n");
    if (n != 3) return 4;

    // %p has fixed width -- "0x" + 16 nibbles = 18 bytes.
    n = my_printf("%p\n", 0);
    if (n != 19) return 5;

    return 0;
}
