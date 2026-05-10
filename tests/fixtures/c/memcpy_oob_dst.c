#include <stdlib.h>
#include <string.h>

int main() {
    char *src;
    char *dst;
    src = malloc(100);
    dst = malloc(8);
    memcpy(dst, src, 100); // writes 92 bytes past dst
    return 0;
}
