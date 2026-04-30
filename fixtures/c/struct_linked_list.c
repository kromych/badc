#include <stdlib.h>

struct Node {
    int value;
    struct Node *next;
};

int main() {
    struct Node *head;
    struct Node *n;
    int sum;
    int i;

    head = 0;
    // Build [4, 3, 2, 1, 0] (newest at head).
    for (i = 0; i < 5; i++) {
        n = (struct Node *)malloc(sizeof(struct Node));
        n->value = i;
        n->next = head;
        head = n;
    }

    sum = 0;
    n = head;
    while (n != 0) {
        sum = sum + n->value;
        n = n->next;
    }
    return sum; // 0+1+2+3+4 = 10
}
