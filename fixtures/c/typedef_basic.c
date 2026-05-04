// M23 -- typedef. The fixture exercises the typedef shapes sqlite
// uses heavily: primitive aliases, pointer aliases, forward struct
// + typedef of the same name, and struct definition + typedef in a
// single declaration.
//
// Function-pointer typedefs (`typedef int (*fn)(int)`) are punted to
// a future milestone -- the parser doesn't yet handle the
// `(*name)(...)` declarator shape.

// Primitive aliases. c5 collapses every integer to 64-bit, so all of
// these are the same underlying type today; the test pins that the
// alias name is accepted at every type position.
typedef int u32;
typedef unsigned char u8;
typedef unsigned long long u64;

// Pointer alias.
typedef char *str;

// Forward struct + typedef of the same name -- sqlite's
// `typedef struct sqlite3 sqlite3;` shape. The struct body shows up
// later.
typedef struct Node Node;

// Now define the struct after the typedef.
struct Node {
    int value;
    struct Node *next;
};

// Single-declaration struct + typedef alias.
typedef struct Pair {
    u32 first;
    u32 second;
} Pair;

// Typedef-name in a parameter type and a return type.
static u32 add_u32(u32 a, u32 b) {
    return a + b;
}

// Typedef-name in a struct field.
struct Triple {
    u32 a;
    u32 b;
    u32 c;
};

int main() {
    u32 x;
    u8 c;
    u64 big;
    str s;
    Node n;
    Pair p;
    struct Triple t;

    x = 100;
    c = 65;          // 'A'
    big = 1234567890;
    s = "hi";
    n.value = 7;
    n.next = 0;
    p.first = 11;
    p.second = 22;
    t.a = 1;
    t.b = 2;
    t.c = 3;

    if (add_u32(x, c) != 165) return 1;
    if (s[0] != 'h') return 2;
    if (n.value != 7) return 3;
    if (p.first + p.second != 33) return 4;
    if (t.a + t.b + t.c != 6) return 5;
    if (big != 1234567890) return 6;

    // Cast through a typedef-name.
    if ((u32)c != 65) return 7;
    if (sizeof(u32) != 8) return 8;
    if (sizeof(Pair) != 16) return 9;

    return 0;
}
