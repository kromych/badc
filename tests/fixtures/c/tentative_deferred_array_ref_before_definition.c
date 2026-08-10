// C99 6.9.2: a deferred-size tentative definition (`T x[];`) and the later
// defining declaration denote one object. The tentative completes to one
// element, so a larger initializer needs fresh storage; every reference
// emitted before the definition -- code addressing the array and pointer
// initializers already in the data segment -- must still observe the
// initialized object, not the abandoned one-element slot.
struct step {
    const char *name;
    union {
        int (*single)(unsigned int);
        int (*multi)(unsigned int, void *);
    } startup;
    int value;
};

enum idx { IDX_FIRST = 0, IDX_MID = 3, IDX_LAST = 9 };

static struct step steps[];

static long neigh = 0x1111111111111111LL;

static struct step *step_at(int i) {
    return steps + i;
}

static struct step *base_slot = steps;
static struct step *mid_slot = &steps[IDX_MID];

static struct step steps[] = {
    [IDX_FIRST] = {.name = "first", .startup.single = 0, .value = 11},
    [IDX_MID] = {.name = "mid", .startup.single = 0, .value = 13},
    [IDX_LAST] = {.name = "last", .startup.single = 0, .value = 19},
};

int main(void) {
    if (sizeof steps / sizeof steps[0] != 10) {
        return 1;
    }
    // A function defined between the tentative and the definition.
    if (step_at(IDX_FIRST)->value != 11 || step_at(IDX_LAST)->value != 19) {
        return 2;
    }
    if (step_at(IDX_MID)->name == 0 || step_at(IDX_MID)->name[0] != 'm') {
        return 3;
    }
    // Pointer initializers parsed before the definition.
    if (base_slot != steps || base_slot->value != 11) {
        return 4;
    }
    if (mid_slot != steps + IDX_MID || mid_slot->value != 13) {
        return 5;
    }
    // The fresh storage must not have overrun the neighbour placed after
    // the one-element tentative.
    if (neigh != 0x1111111111111111LL) {
        return 6;
    }
    return 0;
}
