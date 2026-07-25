// C99 6.6p9 / 6.9.2: two file-scope objects may hold each other's
// addresses; a reference recorded while the target was still an
// undeclared-storage extern must bind to the definition the same unit
// provides later. The static's initializer here uses the extern before
// its defining declaration (through a typeof cast, the read-side
// annotation shape); the definition then points back at the static.

struct queue;

struct sched {
    struct queue *dq;
    struct sched *self;
    int id;
    long priv[]; // flexible array member keeps the extern decl storage-less
};

struct queue {
    struct sched *sd;
    struct sched *sleeping;
};

extern struct sched s_main;

static struct queue q_main = {
    .sd = (typeof(*(&s_main)) *)(&s_main),
    .sleeping = &s_main,
};

struct sched s_main = {
    .dq = &q_main,
    .self = &s_main,
    .id = 42,
};

extern typeof(s_main) s_main;

int main(void) {
    if (q_main.sd != &s_main) return 1;
    if (q_main.sleeping != &s_main) return 2;
    if (s_main.dq != &q_main) return 3;
    if (s_main.self != &s_main) return 4;
    // The cycle closes: each side reaches itself through the other.
    if (s_main.dq->sd->dq != &q_main) return 5;
    if (q_main.sd->dq->sd->id != 42) return 6;
    return 0;
}
