#include <stdlib.h>
#include <string.h>

int main() {
    char *p;
    p = malloc(8);
    memset(p, 0, 100); // overruns the 8-byte allocation by 92 bytes
    return 0;
}
