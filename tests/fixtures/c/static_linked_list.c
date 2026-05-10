// Static linked list -- the user's stated motivation for
// global initializers. Each node lives in `.data` and the
// `head` pointer is initialized at file scope to `&node_a`.
// `node_a.next` and `node_b.next` are wired up at runtime
// (struct-field initializer syntax isn't supported yet, but
// the head pointer is the part that needs static
// pointer-to-global init).

#include <stdlib.h>

struct Node {
    int val;
    struct Node *next;
};

struct Node node_a;
struct Node node_b;
struct Node node_c;
struct Node *head = &node_a;

int main() {
    int sum;
    struct Node *p;

    // Wire up the list fields at runtime; the static
    // initializer for `head` is what makes the list
    // discoverable without a runtime "head = ..." store.
    node_a.val = 1;
    node_a.next = &node_b;
    node_b.val = 2;
    node_b.next = &node_c;
    node_c.val = 3;
    node_c.next = 0;

    // Walk the list, sum the values: 1 + 2 + 3 = 6.
    sum = 0;
    p = head;
    while (p != 0) {
        sum = sum + p->val;
        p = p->next;
    }
    if (sum != 6) return 1;
    return 0;
}
