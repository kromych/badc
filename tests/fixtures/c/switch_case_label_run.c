// A long run of consecutive `case` labels sharing one body parses
// iteratively (each label an empty-bodied fall-through sibling), so
// the run's length is not bounded by the parser's nesting limit.
// 1024 labels exceed the former recursion depth of 512.

#define C1(n) case (n):
#define C4(n) C1(n) C1((n) + 1) C1((n) + 2) C1((n) + 3)
#define C16(n) C4(n) C4((n) + 4) C4((n) + 8) C4((n) + 12)
#define C64(n) C16(n) C16((n) + 16) C16((n) + 32) C16((n) + 48)
#define C256(n) C64(n) C64((n) + 64) C64((n) + 128) C64((n) + 192)

static int classify(int v) {
    switch (v) {
    C256(0)
    C256(256)
    C256(512)
    C256(768)
        return 1;
    case 2000:
    default:
        return 2;
    }
}

int main(void) {
    if (classify(0) != 1) return 1;
    if (classify(511) != 1) return 2;
    if (classify(1023) != 1) return 3;
    if (classify(1024) != 2) return 4;
    if (classify(2000) != 2) return 5;
    return 0;
}
