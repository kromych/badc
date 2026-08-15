// C99 6.6 address constants in static initializers: the address of a
// global, optionally cast, and offset by an integer constant. The cast
// sets the arithmetic stride -- a pointer target strides by its pointee
// (6.5.6p8), so `(uint8_t*)&g + offsetof(T, f)` is a byte offset; an
// integer target strides by bytes (6.3.2.3p6), so `(unsigned long)&arr
// + sizeof(arr)` is the end of the array, not `sizeof(arr)` elements
// past it. mimalloc's per-heap tables use the first shape; the Linux
// x86 `TOP_OF_INIT_STACK` uses the second.

#include <stddef.h>

typedef struct { long a; int b; char c; } T;

static T g = { 100, 200, 'z' };

static unsigned long words[8];
static int ints[4];
static T structs[3];

static void *tbl[] = {
    &g,                                  // plain address
    (char *)&g,                          // cast address
    ((char *)&g),                        // parenthesized cast address
    (char *)&g + offsetof(T, b),         // byte arithmetic via char cast
    (int *)((char *)&g + offsetof(T, b)),// nested cast + arithmetic
    (char *)&g + 4,                      // explicit byte offset
    (char *)&g - 0,                      // subtraction
    (T *)&structs[0] + 2,                // pointer cast strides by the struct
};

// Negative offsets: the addend keeps its sign through every relocation
// consumer (C99 6.6 address constant minus an integer constant). `words`
// is wholly zero and lands in the zero-fill region, `g` is file-backed,
// so both region attributions are exercised.
static unsigned long before_words1  = (unsigned long)&words - 1;
static unsigned long before_words16 = (unsigned long)&words - 16;
static unsigned long before_ints4   = (unsigned long)&ints - 4;
static unsigned long before_g8      = (unsigned long)&g - 8;
static unsigned long mid_back       = (unsigned long)&words[4] - 8;
static T *two_back = (T *)&structs[2] - 2;

// Integer-typed casts: the sum is a byte count past the address.
static unsigned long end_words  = (unsigned long)&words + sizeof(words);
static unsigned long end_words2 = (unsigned long)words + sizeof(words);
static unsigned long end_words3 = (unsigned long)&words[0] + sizeof(words);
static unsigned long end_ints   = (unsigned long)&ints + sizeof(ints);
static unsigned long end_structs = (unsigned long)&structs + sizeof(structs);
static unsigned long one_past    = (unsigned long)&words + 1;
static unsigned long commuted    = 1 + (unsigned long)&words;
static unsigned long signed_cast = (long)&words + 1;
static unsigned long via_char    = (unsigned long)(char *)&words + 1;

int main(void) {
    if (tbl[0] != &g) return 1;
    if (tbl[1] != (char *)&g) return 2;
    if (tbl[2] != (char *)&g) return 3;
    if (*(int *)tbl[3] != 200) return 4;
    if (*(int *)tbl[4] != 200) return 5;
    if ((char *)tbl[5] != (char *)&g + 4) return 6;
    if (tbl[6] != &g) return 7;
    if (tbl[7] != (void *)(structs + 2)) return 8;

    if (end_words != (unsigned long)&words + sizeof(words)) return 9;
    if (end_words - (unsigned long)&words != sizeof(words)) return 10;
    if (end_words2 != end_words || end_words3 != end_words) return 11;
    if (end_ints - (unsigned long)&ints != sizeof(ints)) return 12;
    if (end_structs - (unsigned long)&structs != sizeof(structs)) return 13;
    if (one_past - (unsigned long)&words != 1) return 14;
    if (commuted != one_past) return 15;
    if (signed_cast != one_past) return 16;
    if (via_char != one_past) return 17;

    if ((unsigned long)&words - before_words1 != 1) return 18;
    if ((unsigned long)&words - before_words16 != 16) return 19;
    if ((unsigned long)&ints - before_ints4 != 4) return 20;
    if ((unsigned long)&g - before_g8 != 8) return 21;
    // Byte-computed expectation: `long` is four bytes on the Windows
    // targets, so an element-computed one would bake in LP64.
    if (mid_back != (unsigned long)((char *)&words[4] - 8)) return 22;
    if (two_back != &structs[0]) return 23;
    return 0;
}
