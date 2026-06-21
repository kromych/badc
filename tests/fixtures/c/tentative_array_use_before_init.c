// C99 6.9.2: a tentative definition (`T x[N];`) and a later defining
// initializer (`T x[] = {...}`) denote one object. A function defined between
// the two must observe the initialized storage, not a separate zero copy of
// the tentative.
struct entry {
    const char *name;
    int value;
};

static struct entry table[8];
static int ints[8];

static int count_named(void) {
    int n = 0;
    for (int i = 0; table[i].name != 0; i++) {
        n++;
    }
    return n;
}

static int sum_first_four(void) {
    int s = 0;
    for (int i = 0; i < 4; i++) {
        s += ints[i];
    }
    return s;
}

static struct entry table[] = {
    {"a", 10},
    {"b", 20},
    {"c", 30},
    {0, 0},
};

static int ints[] = {1, 2, 3, 4};

int main(void) {
    if (count_named() != 3) {
        return 1;
    }
    if (table[0].value != 10 || table[2].value != 30) {
        return 2;
    }
    if (sum_first_four() != 10) {
        return 3;
    }
    return 0;
}
