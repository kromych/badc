// C99 6.7.8p14: a character-string-literal initializer for a
// bounded `char` array stores successive bytes of the literal,
// including the terminating null character if there is room.
// When the literal's length is exactly the array's bound, the
// trailing NUL is omitted and the array holds the characters
// alone.
//
// A real-world surface shape:
//
//     static const u8 sigma[16] = "expand 32-byte k";
//
// "expand 32-byte k" is 16 characters; the NUL is dropped.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

typedef unsigned char u8;

static const u8 sigma[16] = "expand 32-byte k";
static const u8 with_room[20] = "hello";
static const u8 deferred[] = "world";

int main(void) {
    if (sigma[0]  != 'e') return 1;
    if (sigma[15] != 'k') return 2;

    if (with_room[0] != 'h') return 3;
    if (with_room[4] != 'o') return 4;
    if (with_room[5] != 0)   return 5;
    if (with_room[19] != 0)  return 6;

    if (deferred[0] != 'w') return 7;
    if (deferred[4] != 'd') return 8;
    if (deferred[5] != 0)   return 9;

    return 0;
}
