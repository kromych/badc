// C99 6.6p9: an address constant may name the object being initialized,
// so a file-scope object's initializer can point back into its own
// storage. The object must stay a defined symbol when the initializer
// self-references and when an `extern` redeclaration follows the
// definition (C99 6.2.2p4 -- the definition stands), including for a
// struct whose last member is a flexible array (C99 6.7.2.1p18).

struct link {
    struct link *next;
    struct link *prev;
};

struct head {
    struct link l;
    int qlen;
    int *lock;
};

struct sched {
    int (*dispatch)(int);
    unsigned flags;
    struct head gso;
    struct head bad;
    int busy;
    int owner;
    long priv[]; // flexible array member: sizeof covers the fixed part
};

static int drop(int x) { return -x; }

extern struct sched sched_none;

struct sched sched_none = {
    .dispatch = drop,
    .flags = 1u,
    .gso = {
        .l = { .next = &sched_none.gso.l, .prev = &sched_none.gso.l },
        .qlen = 0,
        .lock = &sched_none.busy,
    },
    // Cast form: an address constant cast to another pointer type.
    .bad.l.next = (struct link *)&sched_none.bad,
    .bad.l.prev = (struct link *)&sched_none.bad,
    .bad.lock = &sched_none.busy,
    .busy = 7,
    .owner = -1,
};

// The export-declaration shape: an extern redeclaration after the
// definition; the definition and its storage stand.
extern typeof(sched_none) sched_none;

int main(void) {
    // Self-references resolve to the object's own storage.
    if (sched_none.gso.l.next != &sched_none.gso.l) return 1;
    if (sched_none.gso.l.prev != &sched_none.gso.l) return 2;
    if ((struct head *)sched_none.bad.l.next != &sched_none.bad) return 3;
    if (sched_none.gso.lock != &sched_none.busy) return 4;
    if (sched_none.bad.lock != &sched_none.busy) return 5;
    // Address arithmetic through a self-pointer lands on the member.
    char *base = (char *)&sched_none;
    char *lockp = (char *)sched_none.gso.lock;
    if (*(int *)(base + (lockp - base)) != 7) return 6;
    if (sched_none.dispatch(3) != -3) return 7;
    if (sched_none.owner != -1 || sched_none.flags != 1u) return 8;
    return 0;
}
