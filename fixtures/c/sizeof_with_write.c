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
    p = malloc(sizeof(struct Packet));
    p->code    = 1;
    p->payload = 2;
    p->label   = "x";

    // Spit the struct's raw bytes at stdout. Test only checks the exit
    // code, but the call exercises the syscall path with a sizeof-derived
    // count.
    write(STDOUT_FILENO, (char *)p, sizeof(struct Packet));

    // sizeof(struct Packet) -- three 8-byte fields -> 24.
    return sizeof(struct Packet);
}
