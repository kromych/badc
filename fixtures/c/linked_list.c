int main() {
    int *head; int *temp; int *node;
    int sum; int i;

    head = 0;
    sum = 0;

    // Create a list of 5 nodes: [4, 3, 2, 1, 0]
    for (i = 0; i < 5; i++) {
        node = malloc(16); // 8 bytes for value, 8 bytes for next pointer
        node[0] = i;       // data
        node[1] = head;    // next
        head = node;
    }

    // Traverse and sum
    temp = head;
    while (temp != 0) {
        sum = sum + temp[0];
        temp = temp[1];
    }

    return sum; // Expected: 4+3+2+1+0 = 10
}
