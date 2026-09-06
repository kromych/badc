// snapshot-flags: -fstack-protector-strong
// A protected frame orders its storage: every array, and every aggregate
// with an array member at any depth, sits above every other local, with the
// canary above all of them, so a linear overflow of an array reaches the
// canary before it reaches another object. Each function below declares its
// scalars first, so the parser's slot order is the reverse of the frame
// order the snapshots record. An address-taken scalar is ordinary storage
// here: what the order guards it against is the overflow, not the address.

static void fill(char *p, int n, char c) {
    for (int i = 0; i < n; i++) {
        p[i] = c;
    }
}

static int scalar_then_array(int seed) {
    int x;
    int *p;
    char b[16];
    x = seed;
    p = &x;
    fill(b, (int)sizeof b, (char)*p);
    return b[0] + b[15];
}

struct Pair {
    int a;
    int b;
};

struct Rec {
    int n;
    char tag[8];
};

static int aggregate_with_array_goes_up(int seed) {
    long v;
    struct Pair plain;
    struct Rec rec;
    v = seed;
    plain.a = seed;
    plain.b = seed + 1;
    rec.n = plain.a + plain.b;
    fill(rec.tag, (int)sizeof rec.tag, (char)v);
    return rec.n + rec.tag[7];
}

int main(void) {
    if (scalar_then_array(3) != 6) {
        return 1;
    }
    if (aggregate_with_array_goes_up(4) != 13) {
        return 2;
    }
    return 0;
}
