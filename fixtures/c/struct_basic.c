#include <stdlib.h>

struct Point {
    int x;
    int y;
};

int main() {
    struct Point *p;
    p = malloc(sizeof(struct Point));
    p->x = 3;
    p->y = 4;
    return p->x * p->x + p->y * p->y; // 9 + 16 = 25
}
