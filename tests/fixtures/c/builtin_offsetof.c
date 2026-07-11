// GCC / C11 `__builtin_offsetof(type, member-designator)` yields the byte
// offset of the member as an integer constant expression. The member
// designator is an identifier followed by `.field` and `[index]` steps
// (C11 7.19). The standard `offsetof` macro may expand to it.

struct Inner {
    int x;
    long long y;
};

struct S {
    char a;
    int b;
    long long c;
    struct Inner in;
    int arr[4];
    struct Inner ins[3];
    int grid[2][3];
};

typedef struct S ST;

// A member with an anonymous nested struct.
struct P {
    int a;
    struct {
        int u, v;
    } n;
};

// It works in a constant context (a negative-size array if it were wrong).
static int ck[__builtin_offsetof(struct S, c) == 8 ? 1 : -1];

int main(void) {
    (void) ck;
    if (__builtin_offsetof(struct S, a) != 0) return 1;
    if (__builtin_offsetof(ST, b) != 4) return 2;      // typedef spelling
    if (__builtin_offsetof(struct S, c) != 8) return 3;
    if (__builtin_offsetof(struct S, in.y) != 24) return 4;   // .field chain
    if (__builtin_offsetof(struct S, arr[2]) != 40) return 5; // 1D subscript
    if (__builtin_offsetof(struct S, ins[1].y) != 72) return 6; // array of struct
    if (__builtin_offsetof(struct S, grid[1][2]) != 116) return 7; // multi-dim
    if (__builtin_offsetof(struct P, n.v) != 8) return 8; // anonymous struct

    // Usable as an array bound.
    char buf[__builtin_offsetof(struct S, c)];
    if (sizeof(buf) != 8) return 9;
    return 0;
}
