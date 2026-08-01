// C99 6.5.2.5 compound literals as file-scope initializers. Three cases
// that a single "drop the redundant cast" rule cannot serve:
//
//   struct pt g   = (struct pt){ ... };   the cast names the object's own
//                                         type and is redundant
//   int sc        = (int){ v };           the cast converts a value
//   const T *p    = (const T []){ ... };  the literal is an anonymous
//                                         array and decays to its address
//
// Dropping the cast unconditionally turns the last two into a brace list
// for the object itself, which a scalar cannot hold.

#include <stdio.h>

struct pt { int x; int y; };

// The cast names the object's own type.
static struct pt g = (struct pt){ 1, 2 };
static int arr[3] = (int[3]){ 4, 5, 6 };
static struct pt parr[2] = (struct pt[2]){ { 7, 8 }, { 9, 10 } };

// Scalar object: the cast converts a value.
static int sc = (int){ 42 };
static long lc = (long){ 43 };
static unsigned char uc = (unsigned char){ 300 };

// Pointer object: the literal is an anonymous array, and the object holds
// its address.
static const unsigned int *times = (const unsigned int []){ 125, 250, 1000, 4000 };
static const char *const *rows = (const char *const []){ "a", "b", "c" };
static const struct pt *pp = &(struct pt){ 11, 12 };

// A braced scalar initializer, which is not a compound literal at all.
static int braced = { 44 };

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(void) {
    if (g.x != 1 || g.y != 2) return 1;
    if (arr[0] != 4 || arr[1] != 5 || arr[2] != 6) return 2;
    if (parr[0].x != 7 || parr[0].y != 8) return 3;
    if (parr[1].x != 9 || parr[1].y != 10) return 4;

    if (sc != 42) return 10;
    if (lc != 43) return 11;
    if (uc != (unsigned char)300) return 12;

    if (times[0] != 125 || times[3] != 4000) return 20;
    if (!streq(rows[0], "a") || !streq(rows[2], "c")) return 21;
    if (pp->x != 11 || pp->y != 12) return 22;

    if (braced != 44) return 30;

    // The block-scope forms, which take a different path.
    {
        const int *p = (const int []){ 7, 8, 9 };
        struct pt l = (struct pt){ 13, 14 };
        int s = (int){ 45 };
        if (p[0] != 7 || p[2] != 9) return 40;
        if (l.x != 13 || l.y != 14) return 41;
        if (s != 45) return 42;
    }

    printf("ok\n");
    return 0;
}
