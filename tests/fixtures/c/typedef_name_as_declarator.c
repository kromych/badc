// C99 6.7.2p2 + 6.7p3: a typedef name may be redeclared as an
// ordinary identifier once a complete type specifier precedes it.
// `unsigned short bit;` after `typedef unsigned int bit;` declares
// a member/object named `bit` of type `unsigned short` -- the
// typedef cannot combine with `unsigned`/`short`/`long`/`signed`,
// so the parser must treat the following name as the declarator.
//
// The c5 parser previously consumed the typedef name as a second
// type specifier, leaving no declarator ("identifier expected").
// Covered positions: struct field, block-scope object, and a
// function parameter, each of the int-modifier-only forms.
//
// Returns 0 only when every declaration parses and lays out as the
// int-modifier type; distinct nonzero codes flag each failure.

typedef unsigned int bit;

struct S {
    unsigned short bit;   // member named after the typedef
    long           byte;
};

static int take(long bit) {   // parameter named after the typedef
    return (int)bit;
}

int main(void) {
    struct S s;
    s.bit = 40000;            // fits u16, would truncate if it were `bit`(u32)
    s.byte = 5;

    unsigned short bit = 3;   // block-scope object named after the typedef

    if (sizeof(s.bit) != sizeof(unsigned short)) return 11;
    if (sizeof(bit) != sizeof(unsigned short)) return 12;
    if (s.bit != 40000) return 13;
    if (bit != 3) return 14;
    if (take(7) != 7) return 15;
    return 0;
}
