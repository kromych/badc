#include <stdlib.h>

int main() {
    int *p;
    p = malloc(2 * sizeof(int));
    *p = 1;
    *(p + 1) = 2;
    return *p + *(p + 1);
}
