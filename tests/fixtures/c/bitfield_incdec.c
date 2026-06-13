// C99 6.7.2.1 + 6.5.2.4 / 6.5.3.1: ++ and -- on a bitfield member read
// the field, store the field +/- 1 (wrapping within the field width),
// and preserve the other bits in the storage unit. Postfix yields the
// old value, prefix the new.

struct S {
    unsigned len : 31;
    unsigned flag : 1;
};

struct W {
    unsigned a : 4;
    int b : 5;
    unsigned c : 20;
};

int main(void) {
    struct S s = {0, 1};

    int old = s.len++; // postfix yields the old value
    if (old != 0 || s.len != 1) return 1;
    s.len++;
    s.len++;
    if (s.len != 3) return 2;
    s.len--;
    if (s.len != 2) return 3;
    if (s.flag != 1) return 4; // adjacent bit preserved

    int neu = ++s.len; // prefix yields the new value
    if (neu != 3 || s.len != 3) return 5;
    --s.len;
    if (s.len != 2) return 6;
    if (s.flag != 1) return 7;

    struct W w = {0, 0, 0};
    w.b++; // signed bitfield
    if (w.b != 1) return 8;
    int idx = w.c++; // postfix as a value
    if (idx != 0 || w.c != 1) return 9;

    w.a = 15;
    w.a++; // wraps within the 4-bit field: 15 -> 0
    if (w.a != 0) return 10;
    if (w.b != 1 || w.c != 1) return 11; // neighbours intact
    return 0;
}
