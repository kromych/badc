// C99 6.6 address constants in static initializers: the address of a
// global, optionally cast, and offset by an integer constant. The cast
// sets the arithmetic stride -- a pointer target strides by its pointee
// (6.5.6p8), so `(uint8_t*)&g + offsetof(T, f)` is a byte offset; an
// integer target strides by bytes (6.3.2.3p6), so `(uptr)&arr +
// sizeof(arr)` is the end of the array, not `sizeof(arr)` elements past
// it. mimalloc's per-heap tables use the first shape; the Linux x86
// `TOP_OF_INIT_STACK` uses the second. The integer holding an address is
// pointer-wide, which `long` is not on the Windows targets.

#include <stddef.h>

typedef __UINTPTR_TYPE__ uptr;
typedef __INTPTR_TYPE__ iptr;

typedef struct { long a; int b; char c; } T;

static T g = { 100, 200, 'z' };

static uptr words[8];
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
static uptr before_words1  = (uptr)&words - 1;
static uptr before_words16 = (uptr)&words - 16;
static uptr before_ints4   = (uptr)&ints - 4;
static uptr before_g8      = (uptr)&g - 8;
static uptr mid_back       = (uptr)&words[4] - 8;
static T *two_back = (T *)&structs[2] - 2;

// Integer-typed casts: the sum is a byte count past the address.
static uptr end_words  = (uptr)&words + sizeof(words);
static uptr end_words2 = (uptr)words + sizeof(words);
static uptr end_words3 = (uptr)&words[0] + sizeof(words);
static uptr end_ints   = (uptr)&ints + sizeof(ints);
static uptr end_structs = (uptr)&structs + sizeof(structs);
static uptr one_past    = (uptr)&words + 1;
static uptr commuted    = 1 + (uptr)&words;
static uptr signed_cast = (iptr)&words + 1;
static uptr via_char    = (uptr)(char *)&words + 1;

int main(void) {
    if (tbl[0] != &g) return 1;
    if (tbl[1] != (char *)&g) return 2;
    if (tbl[2] != (char *)&g) return 3;
    if (*(int *)tbl[3] != 200) return 4;
    if (*(int *)tbl[4] != 200) return 5;
    if ((char *)tbl[5] != (char *)&g + 4) return 6;
    if (tbl[6] != &g) return 7;
    if (tbl[7] != (void *)(structs + 2)) return 8;

    if (end_words != (uptr)&words + sizeof(words)) return 9;
    if (end_words - (uptr)&words != sizeof(words)) return 10;
    if (end_words2 != end_words || end_words3 != end_words) return 11;
    if (end_ints - (uptr)&ints != sizeof(ints)) return 12;
    if (end_structs - (uptr)&structs != sizeof(structs)) return 13;
    if (one_past - (uptr)&words != 1) return 14;
    if (commuted != one_past) return 15;
    if (signed_cast != one_past) return 16;
    if (via_char != one_past) return 17;

    if ((uptr)&words - before_words1 != 1) return 18;
    if ((uptr)&words - before_words16 != 16) return 19;
    if ((uptr)&ints - before_ints4 != 4) return 20;
    if ((uptr)&g - before_g8 != 8) return 21;
    // Byte-computed expectation: an element-computed one would bake in
    // the width of `uptr`.
    if (mid_back != (uptr)((char *)&words[4] - 8)) return 22;
    if (two_back != &structs[0]) return 23;
    return 0;
}
