// A brace initializer that names some members zero-fills the rest, and
// the fill is one constant store per frame cell. `state` is narrower
// than a cell and shares one with nothing, so the store covering it is
// wider than every access to it: an object split that admits a member
// only when the access widths partition the object refuses this one and
// leaves it in the frame.
//
// The loop condition excludes `ss_done`, so the arm the switch keeps for
// it is unreachable; proving that needs `state` in SSA form. This is the
// shape of the kernel's `scoped_seqlock_read` (include/linux/seqlock.h),
// whose `__scoped_seqlock_bug` is declared and never defined precisely
// so that a compiler which cannot prove the state impossible fails the
// link rather than silently emitting the arm. `scoped_seqlock_bug` here
// serves the same purpose, so linking is the assertion. gcc 16 links
// this at -O2 and fails to at -O0.
//
// Two properties this fixture needs, which a reduction of this shape
// tends to lose:
//
//   * the loop body has to call something that clobbers what is known
//     about memory. Without it a frame-resident member still forwards
//     to its load and the arm folds anyway, so the fixture passes on a
//     compiler that cannot split the object and tests nothing.
//   * `main` checks the values, not just that the link succeeded. A
//     link-only fixture accepts one that folds the arm and computes the
//     wrong answer.

enum ss_state {
    ss_done = 0,
    ss_lock,
    ss_lockless,
};

struct ss_tmp {
    enum ss_state state;
    unsigned long data;
    void *lock;
};

extern void scoped_seqlock_bug(void);

// The sequence counter and the data it protects. Both volatile: the
// reader must not be able to fold the retry away, or the loop would
// collapse and the arm would never be reached at any level.
volatile unsigned int seq;
volatile int payload;

static int lock_obj;
static int body_runs;

static unsigned int seqbegin(void) {
    return seq;
}

static int seqretry(unsigned long started) {
    return (seq & 1u) != 0u || seq != (unsigned int)started;
}

static inline void ss_next(struct ss_tmp *s) {
    switch (s->state) {
    case ss_done:
        scoped_seqlock_bug();
        return;
    case ss_lock:
        s->state = ss_done;
        return;
    case ss_lockless:
        if (!seqretry(s->data)) {
            s->state = ss_done;
            return;
        }
        break;
    }
    // The lockless pass lost the race; retake it holding the lock.
    s->lock = &lock_obj;
    s->state = ss_lock;
}

static int reader(void) {
    int v = 0;
    for (struct ss_tmp s = {.state = ss_lockless, .data = seqbegin()};
         s.state != ss_done; ss_next(&s)) {
        body_runs++;
        v = payload;
    }
    return v;
}

int main(void) {
    // Even, stable counter: the lockless pass succeeds and the loop runs
    // its body once.
    seq = 2;
    payload = 7;
    body_runs = 0;
    if (reader() != 7)
        return 1;
    if (body_runs != 1)
        return 2;

    // Odd counter: a writer holds the lock, so the lockless pass retries
    // and the body runs a second time under the lock arm.
    seq = 3;
    payload = 9;
    body_runs = 0;
    if (reader() != 9)
        return 3;
    if (body_runs != 2)
        return 4;
    if (lock_obj != 0)
        return 5;
    return 0;
}
