// A counted loop with a compile-time-constant trip count passes its
// induction variable to an always_inline helper that asserts the index
// is in range. The assert is a block-scope declaration of an undefined
// function called when the condition holds, so it resolves only once
// each iteration's index is a literal -- which requires the loop to be
// fully unrolled before the helper's guard is folded. The loop body is
// wide enough (five member stores through an array-of-struct subscript,
// plus the call) that a gate on the rolled body size rather than on the
// expansion rejects it. Linking is the assertion; main checks the
// values the copies compute.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

#define NR_GP 8
#define NR_FIXED 3
#define FIXED_BASE_IDX 32

struct counter {
    unsigned int kind;
    unsigned int idx;
    unsigned long long count;
    unsigned long long eventsel;
    void *event;
    void *owner;
    unsigned long long config;
};

struct counter_bank {
    struct counter gp[NR_GP];
    struct counter fixed[NR_FIXED];
};

static const int event_ids[NR_FIXED] = {11, 22, 33};

static __attribute__((always_inline)) unsigned long long eventsel_of(unsigned int index) {
    BUILD_BUG_ON(index >= NR_FIXED, 670);
    return (unsigned long long)event_ids[index] << 8;
}

// A second helper reached from the same loop, guarding the derived
// slot number rather than the index itself.
static __attribute__((always_inline)) unsigned int slot_of(unsigned int index) {
    BUILD_BUG_ON(FIXED_BASE_IDX + index >= 64u, 671);
    return index + FIXED_BASE_IDX;
}

static struct counter_bank the_bank;

void bank_init(struct counter_bank *bank, void *owner);

void bank_init(struct counter_bank *bank, void *owner) {
    int i;

    for (i = 0; i < NR_GP; i++) {
        bank->gp[i].kind = 1;
        bank->gp[i].owner = owner;
        bank->gp[i].idx = (unsigned int)i;
        bank->gp[i].config = 0;
    }

    for (i = 0; i < NR_FIXED; i++) {
        bank->fixed[i].kind = 2;
        bank->fixed[i].owner = owner;
        bank->fixed[i].idx = slot_of((unsigned int)i);
        bank->fixed[i].config = 0;
        bank->fixed[i].eventsel = eventsel_of((unsigned int)i);
    }
}

// A loop whose bound is not a constant keeps the same helper rolled;
// the guard holds for every index it is reached with, and the values
// must match the unrolled ones.
static int runtime_bound = NR_FIXED;

static unsigned long long sum_rolled(void) {
    unsigned long long acc = 0;
    int i;

    for (i = 0; i < runtime_bound; i++)
        acc += (unsigned long long)event_ids[i] << 8;
    return acc;
}

int main(void) {
    int i;
    unsigned long long acc = 0;
    static char token;

    bank_init(&the_bank, &token);

    for (i = 0; i < NR_GP; i++) {
        if (the_bank.gp[i].kind != 1 || the_bank.gp[i].owner != &token)
            return 1;
        if (the_bank.gp[i].idx != (unsigned int)i || the_bank.gp[i].config != 0)
            return 2;
    }

    for (i = 0; i < NR_FIXED; i++) {
        if (the_bank.fixed[i].kind != 2 || the_bank.fixed[i].owner != &token)
            return 3;
        if (the_bank.fixed[i].idx != (unsigned int)(i + FIXED_BASE_IDX))
            return 4;
        if (the_bank.fixed[i].config != 0)
            return 5;
        if (the_bank.fixed[i].eventsel != ((unsigned long long)event_ids[i] << 8))
            return 6;
        acc += the_bank.fixed[i].eventsel;
    }

    if (acc != ((11ull + 22ull + 33ull) << 8))
        return 7;
    if (sum_rolled() != acc)
        return 8;
    return 0;
}
