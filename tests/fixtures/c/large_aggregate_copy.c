// A large aggregate initializer / copy must keep every load/store offset
// within the aarch64 scaled-immediate range by advancing the base pointer;
// the byte tail of a copy past ~4KB would otherwise encode out of range.
// A big local array, a >4KB string initializer, and a struct copy exercise
// the windowed path.

struct big { char data[9000]; int tag; };

static int check(void) {
    char a[9000] = "";           /* zero-filled via a large copy */
    char b[8193] = "hello";      /* string init past the byte-offset range */
    struct big s;
    struct big t;
    for (int i = 0; i < 9000; i++) s.data[i] = (char) (i & 0x7f);
    s.tag = 1234;
    t = s;                       /* whole-struct copy, > 4KB */
    if (a[0] != 0 || a[4096] != 0 || a[8192] != 0) return 1;
    if (b[0] != 'h' || b[4] != 'o' || b[5] != 0 || b[8192] != 0) return 2;
    if (t.data[0] != 0 || t.data[8192] != (char) (8192 & 0x7f)) return 3;
    if (t.tag != 1234) return 4;
    return 0;
}

int main(void) { return check(); }
