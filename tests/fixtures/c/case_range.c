// GNU case ranges `case lo ... hi:` (GCC extension): a single label
// covering every value in [lo, hi]. Ubiquitous in character classifiers
// such as `case '0' ... '9':`.

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

/* Opaque call targets: a volatile pointer load keeps each call real, so
   the range's bounds comparison is emitted rather than inlined and folded
   to the arm the constant argument selects. */
static int (*volatile classify_p)(int) = classify;
static int (*volatile count_p)(int) = count;

int main(void) {
    // Boundaries and interior of each range.
    if (classify_p('0') != 1 || classify_p('5') != 1 || classify_p('9') != 1) return 1;
    if (classify_p('a') != 2 || classify_p('m') != 2 || classify_p('z') != 2) return 2;
    if (classify_p('A') != 2 || classify_p('Z') != 2) return 3;
    if (classify_p('+') != 3 || classify_p('-') != 3) return 4;
    if (classify_p('$') != 0 || classify_p('/') != 0 || classify_p(':') != 0) return 5;

    // In-range values fall through into case 4; case 4 alone does not.
    if (count_p(1) != 11 || count_p(2) != 11 || count_p(3) != 11) return 6;
    if (count_p(4) != 1) return 7;
    if (count_p(9) != -1) return 8;

    return 0;
}
