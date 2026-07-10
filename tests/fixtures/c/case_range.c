// GNU case ranges `case lo ... hi:` (GCC extension): a single label
// covering every value in [lo, hi]. Ubiquitous in character classifiers
// (QEMU util/readline.c uses `case '0' ... '9':`).

static int classify(int c) {
    switch (c) {
    case '0' ... '9':
        return 1;
    case 'a' ... 'z':
    case 'A' ... 'Z':
        return 2;
    case '+':
    case '-':
        return 3;
    default:
        return 0;
    }
}

// Fall-through out of a range into the following label.
static int count(int c) {
    int n = 0;
    switch (c) {
    case 1 ... 3:
        n += 10;
        /* fall through */
    case 4:
        n += 1;
        break;
    default:
        n = -1;
    }
    return n;
}

int main(void) {
    // Boundaries and interior of each range.
    if (classify('0') != 1 || classify('5') != 1 || classify('9') != 1) return 1;
    if (classify('a') != 2 || classify('m') != 2 || classify('z') != 2) return 2;
    if (classify('A') != 2 || classify('Z') != 2) return 3;
    if (classify('+') != 3 || classify('-') != 3) return 4;
    if (classify('$') != 0 || classify('/') != 0 || classify(':') != 0) return 5;

    // In-range values fall through into case 4; case 4 alone does not.
    if (count(1) != 11 || count(2) != 11 || count(3) != 11) return 6;
    if (count(4) != 1) return 7;
    if (count(9) != -1) return 8;

    return 0;
}
