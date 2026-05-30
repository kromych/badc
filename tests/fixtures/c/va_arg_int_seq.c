// VaArg's dst register can alias its `&ap` source register when
// the allocator picks the same physical register for both. The
// emit must hold `&ap` across the load that overwrites the
// shared register; otherwise the subsequent advance-and-store
// writes through the (stale) cursor instead of through &ap, and
// every va_arg call after the first reads the same memory.
//
// `show` collects three ints through a va_list and prints them.
// The expected output is `11 22 33`; a regression that loses
// `&ap` across the VaArg load prints the same address-shaped
// garbage three times.
#include <stdio.h>
#include <stdarg.h>

static void show(const char *label, int n, ...) {
    va_list ap;
    va_start(ap, n);
    printf("%s n=%d", label, n);
    for (int i = 0; i < n; i++) {
        int v = va_arg(ap, int);
        printf(" v[%d]=%d", i, v);
    }
    va_end(ap);
    printf("\n");
}

int main(void) {
    show("first", 3, 11, 22, 33);
    return 0;
}
