// A struct with an anonymous union whose selected member is an aggregate
// (array or struct) may be brace-initialized with an explicit sub-brace for
// the union: `{ { { bytes } } }` = struct -> anon union -> array. A
// real-world UUID shape (`struct { union { unsigned char data[16];
// struct {...} fields; } }`) is initialized this way in test tables. Covers
// a const global, an array of such structs, a runtime-local, a designator
// selecting a non-first union member, and -- as a regression -- a named
// (non-anonymous) union. Returns 0.

typedef struct {
    union {
        unsigned char data[16];
        struct {
            unsigned int a;
            unsigned int b;
        } fields;
    };
} UUID;

// Const global: anon union, array member, explicit union sub-brace.
static const UUID g = { { {
    0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
    0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42,
} } };

// Array of struct with the anon-union member.
static const struct {
    const char *name;
    UUID u;
    int v;
} table[] = {
    { "one", { { { 1, 2, 3, 4 } } }, 10 },
    { "two", { }, 20 },                       // empty -> all zero
    { "three", { { .fields = { 7, 8 } } }, 30 }, // designate the struct member
};

static int check_const(void) {
    if (g.data[0] != 0x58 || g.data[15] != 0x42) return 1;
    if (table[0].u.data[0] != 1 || table[0].u.data[3] != 4 || table[0].v != 10) return 2;
    if (table[1].u.data[0] != 0 || table[1].v != 20) return 3;      // zeroed
    if (table[2].u.fields.a != 7 || table[2].u.fields.b != 8 || table[2].v != 30) return 4;
    if (table[0].name[0] != 'o' || table[2].name[0] != 't') return 5;
    return 0;
}

// Regression: a NAMED union still initializes correctly.
struct Named { union { unsigned char d[4]; int x; } un; int tag; };

static int check_runtime(int p, int q) {
    // Runtime-local: anon union array member filled with runtime values.
    UUID u = { { { p, q, p + q, p * q } } };
    if (u.data[0] != (unsigned char)p || u.data[3] != (unsigned char)(p * q)) return 10;

    struct Named n = { { { 9, 8, 7, 6 } }, p };
    if (n.un.d[0] != 9 || n.un.d[3] != 6 || n.tag != p) return 11;
    return 0;
}

int main(void) {
    int rc = check_const();
    if (rc) return rc;
    return check_runtime(3, 5);
}
