// unions. Layout: every member at offset 0, total size =
// max(member size). Member access reuses the struct field path
// (each field's `offset` is just 0 for a union).
//
// Tagged unions -- a discriminator field beside a union payload --
// are a common shape; this fixture covers it.

union Value {
    int i;
    char *s;
    double d;
};

typedef struct Tagged {
    int tag;
    union Value u;
} Tagged;

int main() {
    union Value v;
    Tagged t;

    // Writing one member overwrites the others -- they share storage.
    v.i = 42;
    if (v.i != 42) return 1;

    v.i = 0;
    v.s = "hi";
    if (v.s[0] != 'h') return 2;
    if (v.s[1] != 'i') return 3;

    // Floating-point member round-trips.
    v.d = 3.5;
    if (v.d < 3.4) return 4;
    if (v.d > 3.6) return 5;

    // sizeof(union Value) = max(int=8, char*=8, double=8) = 8.
    if (sizeof(union Value) != 8) return 6;

    // Embed a union in a struct (the tagged-union pattern). The tagged
    // struct's first field is the discriminator; the second is
    // the union payload.
    t.tag = 1;
    t.u.i = 100;
    if (t.tag != 1) return 7;
    if (t.u.i != 100) return 8;

    t.tag = 2;
    t.u.s = "yo";
    if (t.tag != 2) return 9;
    if (t.u.s[0] != 'y') return 10;

    // sizeof(Tagged) = 8 (tag) + 8 (union, max member) = 16.
    if (sizeof(Tagged) != 16) return 11;

    return 0;
}
