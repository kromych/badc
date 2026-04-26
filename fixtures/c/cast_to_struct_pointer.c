// Cast `malloc`'s `char*` result to `struct Node*` -- the cast form must
// accept the `struct <Tag> *` type expression, not just `int`/`char [*]`.
struct Node {
    int value;
    struct Node *next;
};

int main() {
    struct Node *n;
    n = (struct Node *)malloc(sizeof(struct Node));
    n->value = 42;
    n->next = 0;
    return n->value;
}
