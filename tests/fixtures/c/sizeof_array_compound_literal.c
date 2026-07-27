// C99 6.3.2.1p3: an array is converted to a pointer to its first element
// EXCEPT when it is the operand of `sizeof`. A compound literal designates
// an object of the named type (6.5.2.5p4), so `sizeof (T[]){ ... }` is the
// object's size, not the size of the pointer the value decays to.
//
// Several element counts and at least two element widths are pinned at
// each width: a count whose byte total happens to equal the pointer size
// (four 2-byte elements, two 4-byte elements) reads as correct under the
// decayed-pointer answer as well, so it cannot discriminate on its own.
// Returns 0 on success.

typedef unsigned short u16;

struct pair {
    int a;
    int b;
};

int main(void) {
    // 1-byte elements: totals below, at, and above the pointer width.
    if (sizeof((char []){ 1, 2, 3 }) != 3) return 1;
    if (sizeof((char []){ 1, 2, 3, 4, 5, 6, 7, 8 }) != 8) return 2;
    if (sizeof((char []){ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }) != 10) return 3;

    // 2-byte elements. The 4-element case totals 8 and so agrees with the
    // decayed-pointer answer; the 3- and 6-element cases do not.
    if (sizeof((u16 []){ 1, 2, 3 }) != 6) return 4;
    if (sizeof((u16 []){ 1, 2, 3, 4 }) != 8) return 5;
    if (sizeof((u16 []){ 1, 2, 3, 4, 5, 6 }) != 12) return 6;

    // 4-byte elements.
    if (sizeof((int []){ 1 }) != 4) return 7;
    if (sizeof((int []){ 1, 2, 3, 4, 5 }) != 20) return 8;

    // 8-byte elements: one element also totals 8.
    if (sizeof((long long []){ 1 }) != 8) return 9;
    if (sizeof((long long []){ 1, 2, 3, 4, 5, 6, 7 }) != 56) return 10;
    if (sizeof((double []){ 1, 2, 3 }) != 24) return 11;

    // A qualifier on the literal's type does not change its size.
    if (sizeof((const u16 []){ 1, 2, 3, 4, 5, 6 }) != 12) return 12;
    if (sizeof((volatile int []){ 1, 2, 3 }) != 12) return 13;

    // An explicit dimension sizes the object, not the initializer count.
    if (sizeof((int [8]){ 1, 2 }) != 32) return 14;
    if (sizeof((char [16]){ 0 }) != 16) return 15;

    // Struct elements.
    if (sizeof((struct pair []){ { 1, 2 }, { 3, 4 }, { 5, 6 } }) != 3 * sizeof(struct pair))
        return 16;

    // A struct literal does not decay, so it was already correct; pin it
    // so the decay hint is not published for the non-array shapes.
    if (sizeof((struct pair){ 1, 2 }) != sizeof(struct pair)) return 17;
    if (sizeof((int){ 5 }) != sizeof(int)) return 18;

    // Grouping parentheses are transparent (C99 6.5.1p5).
    if (sizeof(((int []){ 1, 2, 3, 4 })) != 16) return 19;

    // The `sizeof(x) / sizeof(x[0])` element-count idiom over a literal.
    if (sizeof((u16 []){ 1, 2, 3, 4, 5, 6 }) / sizeof(u16) != 6) return 20;
    if (sizeof((int []){ 1, 2, 3, 4, 5 }) / sizeof(int) != 5) return 21;
    if (sizeof((char []){ 1, 2, 3 }) / sizeof(char) != 3) return 22;

    // `typeof` reads the same undecayed extent.
    if (sizeof(__typeof__((int []){ 1, 2, 3 })) != 12) return 23;

    // The value still decays for ordinary use (6.3.2.1p3), so element
    // access through the literal keeps working.
    if (((const u16 []){ 10, 20, 30 })[2] != 30) return 24;
    if (((int []){ 7, 8, 9 })[1] != 8) return 25;

    // A constant expression built on the count: the shape a compile-time
    // assertion uses, where a wrong count would make the width negative.
    {
        struct guard {
            int w : (int)(sizeof((u16 []){ 1, 2, 3, 4, 5, 6 }) / sizeof(u16));
        };
        if (sizeof(struct guard) == 0) return 26;
    }
    return 0;
}
