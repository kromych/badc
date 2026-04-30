#include <stdlib.h>
#include <string.h>

int main() {
    char *s; s = malloc(5);
    memset(s, 65, 4); // 'AAAA'
    s[4] = 0;
    if (s[0] == 65) return 42;
    return 0;
}
