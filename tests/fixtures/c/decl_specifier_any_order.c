/* C99 6.7.2p2: type specifiers may appear in any order, so the
   modifier may follow the base keyword: `int long` is `long int`,
   `int unsigned` is `unsigned int`, `char unsigned` is `unsigned
   char`, `int long long` is `long long int`. */
struct pair {
    long a;
    int long b; /* same layout as `long b` */
};

int main(void) {
    if (sizeof(int long) != sizeof(long)) {
        return 1;
    }
    if (sizeof(int long long) != sizeof(long long)) {
        return 2;
    }
    int long long big = 0x100000000LL;
    if (big >> 32 != 1) {
        return 3;
    }
    int unsigned u = -1;
    if (!(u > 0)) {
        return 4;
    }
    char unsigned c = -1;
    if (c != 255) {
        return 5;
    }
    long int long llv = -1; /* `long int long` is long long */
    if (sizeof(llv) != 8) {
        return 6;
    }
    if (sizeof(struct pair) != 2 * sizeof(long)) {
        return 7;
    }
    struct pair p;
    p.b = -5;
    if (p.b >= 0) {
        return 8;
    }
    return 0;
}
