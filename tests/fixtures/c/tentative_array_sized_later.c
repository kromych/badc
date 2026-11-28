// C17 6.9.2p2, 6.7.6.2p4: a tentative definition of unknown size (`T x[];`)
// and a later one that states the size denote one object. With no
// initializer it is zero-filled storage of the stated size, the objects
// declared around it keep their bytes, and a reference made before the
// size was known names it.
struct gain {
    short left, right;
};

static struct gain gains[];
int counts[];

static long long neigh = 0x1111111111111111LL;

static struct gain *gain_at(int i) {
    return gains + i;
}

static int *count_slot = &counts[2];

static struct gain gains[72];
int counts[4];

// GNU: a declaration after the definition may raise the object's
// alignment; the object keeps the bytes its initializer wrote.
char lead = 1;
int raised = 5;
int raised __attribute__((aligned(64)));

int main(void) {
    if (sizeof gains != 72 * sizeof(struct gain) || sizeof counts != 4 * sizeof(int)) {
        return 1;
    }
    for (int i = 0; i < 72; i++) {
        if (gains[i].left != 0 || gains[i].right != 0) {
            return 2;
        }
    }
    gains[71].right = 7;
    if (gain_at(71) != &gains[71] || gain_at(71)->right != 7) {
        return 3;
    }
    counts[3] = 9;
    if (count_slot != &counts[2] || count_slot[1] != 9 || count_slot[0] != 0) {
        return 4;
    }
    if (neigh != 0x1111111111111111LL || lead != 1) {
        return 5;
    }
    return raised == 5 ? 0 : 6;
}
