#include <stdlib.h>
#include <unistd.h>

// Exercises sizeof in three positions at once:
//   - as the malloc argument (allocation size)
//   - as the write count argument (buffer length)
//   - as the function's return value
// All three flow through the same compile-time constant, so the test
// pins that sizeof of a struct survives travel through arithmetic.

struct Packet {
    int   code;
    int   payload;
    char *label;
};

int main() {
    struct Packet *p;
    p = (struct Packet *)malloc(sizeof(struct Packet));
    p->code    = 1;
    p->payload = 2;
    p->label   = "x";

    // Spit the struct's raw bytes at stdout. Test only checks the exit
    // code, but the call exercises the syscall path with a sizeof-derived
    // count.
    write(STDOUT_FILENO, (char *)p, sizeof(struct Packet));

    // sizeof(struct Packet) -- code(4) + payload(4) + label(8) ->
    // 16 bytes ( packs ints at 4 with no padding before the
    // 8-byte pointer because 4+4=8 is already aligned).
    return sizeof(struct Packet);
}
