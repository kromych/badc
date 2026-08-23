// Locks the counted loops that become a memory transfer: a byte or
// element fill, and a copy between two declared arrays. The transform
// has to keep the loop's own trip count -- a zero or negative count
// writes nothing -- and the value the loop leaves in an induction
// variable that outlives it.
//
// Each failure returns a distinct nonzero code.

#include <string.h>

static char ga[64];
static char gb[64];
static int gi[16];

static int all(const char *p, int n, char v) {
    for (int k = 0; k < n; k++) {
        if (p[k] != v) {
            return 0;
        }
    }
    return 1;
}

static void fill_bytes(char *p, int n, char v) {
    for (int i = 0; i < n; i++) {
        p[i] = v;
    }
}

static void fill_words(int *p, int n) {
    for (int i = 0; i < n; i++) {
        p[i] = 0;
    }
}

static void fill_const(char *p) {
    for (int i = 0; i < 12; i++) {
        p[i] = 3;
    }
}

static void fill_from(char *p) {
    for (int i = 4; i < 12; i++) {
        p[i] = 5;
    }
}

static void copy_arrays(int n) {
    for (int i = 0; i < n; i++) {
        ga[i] = gb[i];
    }
}

// The induction variable outlives the loop, so the rewrite has to leave
// the value the loop would have left in it.
static int fill_and_report(char *p, int n) {
    int i;
    for (i = 0; i < n; i++) {
        p[i] = 1;
    }
    return i;
}

int main(void) {
    char buf[64];

    memset(buf, 0x7f, sizeof buf);
    fill_bytes(buf, 16, 2);
    if (!all(buf, 16, 2) || buf[16] != 0x7f) {
        return 1;
    }

    // A zero count writes nothing.
    memset(buf, 0x7f, sizeof buf);
    fill_bytes(buf, 0, 2);
    if (!all(buf, 64, 0x7f)) {
        return 2;
    }

    // A negative count is a zero-trip loop, not a huge byte count.
    memset(buf, 0x7f, sizeof buf);
    fill_bytes(buf, -3, 2);
    if (!all(buf, 64, 0x7f)) {
        return 3;
    }

    memset(buf, 0x7f, sizeof buf);
    fill_const(buf);
    if (!all(buf, 12, 3) || buf[12] != 0x7f) {
        return 4;
    }

    // A constant start offsets the destination.
    memset(buf, 0x7f, sizeof buf);
    fill_from(buf);
    if (buf[3] != 0x7f || !all(buf + 4, 8, 5) || buf[12] != 0x7f) {
        return 5;
    }

    for (int k = 0; k < 16; k++) {
        gi[k] = -1;
    }
    fill_words(gi, 10);
    for (int k = 0; k < 16; k++) {
        if (gi[k] != (k < 10 ? 0 : -1)) {
            return 6;
        }
    }

    for (int k = 0; k < 64; k++) {
        gb[k] = (char)(k + 1);
        ga[k] = 0;
    }
    copy_arrays(40);
    for (int k = 0; k < 64; k++) {
        if (ga[k] != (k < 40 ? (char)(k + 1) : 0)) {
            return 7;
        }
    }

    memset(buf, 0, sizeof buf);
    if (fill_and_report(buf, 9) != 9) {
        return 8;
    }
    if (!all(buf, 9, 1) || buf[9] != 0) {
        return 9;
    }
    // Zero trips leave the induction variable at its initial value.
    if (fill_and_report(buf, -1) != 0) {
        return 10;
    }
    return 0;
}
