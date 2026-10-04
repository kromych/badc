// A GCC `enum __attribute__((packed))` uses the smallest integer type that
// holds its enumerators (per-enum -fshort-enums), which changes the layout of
// any struct that embeds it. A real-world shape interleaves several
// packed-enum fields with uint16/uint8, so honoring the size is required for a
// correct layout -- not just parsing the attribute. Sizes and offsets here
// match GCC/clang exactly. Returns 0 on success; distinct non-zero per fail.

typedef enum __attribute__((packed)) { U0 = 0, U7 = 7 } E8u;      // unsigned char
typedef enum __attribute__((packed)) { W0 = 0, W256 = 256 } E16u; // unsigned short
typedef enum __attribute__((packed)) { S_n = -1, S_p = 1 } E8s;   // signed char
typedef enum __attribute__((packed)) { X_n = -1, X_big = 70000 } E32s; // int
typedef enum { P0 = 0, P7 = 7 } EPlain;                           // int (unpacked)

// Tagged packed enum with the attribute after the closing brace -- the
// underlying width must be recorded on the tag so a later bare `enum Tag`
// reference (sizeof, a variable declaration) keeps the sub-int size.
enum tag8 { T0 = 0, T7 = 7 } __attribute__((packed));
_Static_assert(sizeof(enum tag8) == 1, "packed tag via bare reference is 1 byte");
_Static_assert(_Alignof(enum tag8) == 1, "packed tag alignment follows size");

// A plain tagged enum stays 4 bytes (zero drift).
enum tagp { Q0 = 0, Q7 = 7 };
_Static_assert(sizeof(enum tagp) == 4, "unpacked tagged enum stays int");

// A real-world shape: packed enums interleaved with narrower fields.
struct layout {
    unsigned short flags;
    E8u round_mode;
    E8u prec;
    unsigned char pattern;
    E16u wide;
};

int main(void) {
    if (sizeof(E8u) != 1 || sizeof(E16u) != 2 || sizeof(E8s) != 1) {
        return 1;
    }
    if (sizeof(E32s) != 4 || sizeof(EPlain) != 4) {
        return 2;
    }
    // Layout: flags@0(2), round_mode@2(1), prec@3(1), pattern@4(1), wide@6(2).
    if (sizeof(struct layout) != 8) {
        return 3;
    }
    struct layout l;
    l.flags = 0x1234;
    l.round_mode = U7;
    l.prec = U0;
    l.pattern = 0xAB;
    l.wide = W256;
    if (l.round_mode != 7 || l.wide != 256 || l.flags != 0x1234 || l.pattern != 0xAB) {
        return 4;
    }
    // A negative packed enumerator sign-extends on read.
    E8s s = S_n;
    if (s != -1) {
        return 5;
    }
    // A bare tag reference to the packed enum keeps the 1-byte size at
    // runtime too, and a struct embedding it packs accordingly.
    enum tag8 t = T7;
    struct { enum tag8 e; char c; } tp;
    tp.e = t;
    tp.c = 'z';
    if (sizeof(t) != 1 || sizeof(tp) != 2 || tp.e != 7 || tp.c != 'z') {
        return 6;
    }
    return 0;
}
