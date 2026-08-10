// A state machine whose state lives in an address-taken automatic
// struct, advanced by an always_inline callee at the loop latch. The
// loop condition excludes one state, so the callee's arm for that state
// is unreachable -- the shape include/linux/seqlock.h's
// __scoped_seqlock_next has, whose dead arm calls a symbol the kernel
// declares and never defines as a check on the compiler.
//
// Two capabilities are needed together. The object's initializer writes
// it a cell at a time, spanning the 4-byte state member, so the split
// into per-field slots happens only if that write decomposes; without
// the split the state stays in memory and the body's call clears every
// fact about it. Once it is a register value, the loop-carried merge
// bounds it and the dominating condition settles the arm's test.
//
// `scoped_state_bug` is declared and never defined, so linking is the
// assertion. gcc links this at -O1 and above and fails to at -O0.

extern void scoped_state_bug(void);
extern void work(unsigned long);

enum ss_state { ss_done = 0, ss_lock, ss_lock_irqsave, ss_lockless };

struct ss_tmp {
    enum ss_state state;
    unsigned long data;
    void *lock;
    void *lock_irqsave;
};

static unsigned long seq_source = 3;

static unsigned long read_begin(void) { return seq_source; }

static int read_retry(unsigned long seq) { return seq != seq_source; }

static __attribute__((always_inline)) inline void
next(struct ss_tmp *sst, enum ss_state target)
{
    switch (sst->state) {
    case ss_done:
        scoped_state_bug();
        return;
    case ss_lock:
    case ss_lock_irqsave:
        sst->state = ss_done;
        return;
    case ss_lockless:
        if (!read_retry(sst->data)) {
            sst->state = ss_done;
            return;
        }
        break;
    }
    switch (target) {
    case ss_done:
        return;
    case ss_lock:
        sst->lock = &seq_source;
        sst->state = ss_lock;
        return;
    case ss_lock_irqsave:
        sst->state = ss_lock_irqsave;
        return;
    case ss_lockless:
        sst->data = read_begin();
        return;
    }
}

static unsigned long reader(void)
{
    unsigned long rounds = 0;
    for (struct ss_tmp s = { .state = ss_lockless, .data = read_begin() };
         s.state != ss_done;
         next(&s, ss_lock)) {
        work(s.data);
        rounds++;
    }
    return rounds;
}

static unsigned long sink;

void work(unsigned long v) { sink += v; }

int main(void)
{
    // The sequence never moves, so the lockless pass validates and the
    // loop ends after one round.
    if (reader() != 1)
        return 1;
    if (sink != 3)
        return 2;
    return 0;
}
