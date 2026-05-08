#include <stdlib.h>

int main() {
    // Cells must be 8 bytes so a single slot can hold either a value
    // or a pointer-shaped next link. `long long` is 8 bytes on every
    // target; plain `long` would only be 4 on Windows LLP64 and the
    // next-pointer cast would truncate to 32 bits there.
    long long *head; long long *temp; long long *node;
    int sum; int i;

    head = 0;
    sum = 0;

    // Create a list of 5 nodes: [4, 3, 2, 1, 0]
    for (i = 0; i < 5; i++) {
        // One slot for value, one for the next pointer. Stored as a
        // flat long long[2]; the cast on the next-pointer write tells
        // the type-checker we know we're stuffing a pointer-shaped
        // value into a word-sized cell.
        node = malloc(sizeof(long long) + sizeof(long long *));
        node[0] = i;                // data
        node[1] = (long long)head;  // next
        head = node;
    }

    // Traverse and sum
    temp = head;
    while (temp != 0) {
        sum = sum + temp[0];
        temp = (long long *)temp[1];
    }

    return sum; // Expected: 4+3+2+1+0 = 10
}
