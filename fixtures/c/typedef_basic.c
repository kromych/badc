// typedef. The fixture exercises the typedef shapes sqlite
// uses heavily: primitive aliases, pointer aliases, forward struct
// + typedef of the same name, and struct definition + typedef in a
// single declaration.
//
// Function-pointer typedefs (`typedef int (*fn)(int)`) are punted to
// a future milestone -- the parser doesn't yet handle the
// `(*name)(...)` declarator shape.

// Primitive aliases. Under  the underlying widths matter:
// `int` is 32-bit (so `u32` lands in a 4-byte slot), `long long`
// is 64-bit (so `u64` keeps its full range), and `char` is 1 byte.
// The test pins that each alias name is accepted at every type
// position and that the storage class follows the underlying type.
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
    if (sizeof(u32) != 4) return 8;        // u32 = 4 bytes
    // Pair = {u32 first; u32 second;} -> 4+4 = 8 bytes (struct
    // floor of 8 also lands at exactly 8, so no padding visible).
    if (sizeof(Pair) != 8) return 9;

    return 0;
}
