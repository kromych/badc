// A call through a function pointer yields the callee's return type,
// recovered from the pointer's type (one pointer level above the return
// type), so a following `->`, `[`, or member access sees the right
// shape. Covers a chained call and a fn-pointer returning a struct
// pointer and an int pointer.

struct S {
    int tag;
    int (*get)();
};

static struct S s = { 7, 0 };
static int arr[4] = { 10, 20, 30, 40 };

struct S *anon(void) {
    return &s;
}

int *vec(void) {
    return arr;
}

typedef struct S *(*sfty)(void);
typedef int *(*ifty)(void);

sfty go_s(void) {
    return &anon;
}

ifty go_i(void) {
    return &vec;
}

int main(void) {
    // Chained call: go_s() returns sfty, calling it returns struct S*.
    if (go_s()()->tag != 7) return 1;

    // Stored, then `->`.
    sfty f = go_s();
    if (f()->tag != 7) return 2;

    // Fn-pointer returning int*: index the result.
    if (go_i()()[2] != 30) return 3;
    ifty g = go_i();
    if (g()[0] != 10) return 4;

    return 0;
}
