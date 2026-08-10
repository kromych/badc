/* GNU `__auto_type`: the declared variable takes its initializer's
   type. Sizes, signedness, floating arithmetic, and array-to-pointer
   decay pin the inference; the file-scope form uses the same path. */
int garr[3] = {1, 2, 3};
__auto_type gi = 40 + 2;

static int bump(int a) {
    __auto_type b = a + 1;
    return b;
}

int main(void) {
    __auto_type i = 7;
    __auto_type d = 1.5;
    __auto_type u = 3u;
    __auto_type p = garr;
    __auto_type c = (char)65;
    __auto_type ll = 1LL << 40;
    if (sizeof(i) != sizeof(int)) {
        return 1;
    }
    if (sizeof(d) != sizeof(double)) {
        return 2;
    }
    if (sizeof(c) != sizeof(char)) {
        return 3;
    }
    if (sizeof(ll) != sizeof(long long)) {
        return 4;
    }
    if ((int)(ll >> 40) != 1) {
        return 10;
    }
    if (p[1] != 2) {
        return 5;
    }
    d = d * 2;
    if (d != 3.0) {
        return 6;
    }
    if (u - 4u < 3u) {
        return 7;
    }
    if (bump(c == 'A') != 2) {
        return 8;
    }
    if (gi != 42) {
        return 9;
    }
    return i - 7;
}
