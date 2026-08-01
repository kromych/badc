/* A call whose result is returned may only be lowered as a tail jump when
   the call is an instruction of the returning block. The inline splice can
   leave that block empty with a degenerate instruction range starting right
   after another block's trailing call; converting there emits the call and
   then jumps into the callee a second time, with whatever the post-call
   code left in the argument registers.

   The trigger is a five-argument wrapper whose result flows through inlined
   predicate layers before being returned. `make` recurses so it is not
   inlined away, and the wrapper is reached through a volatile pointer so it
   stays out of line. */

struct node;

static unsigned long block[8];
static int calls;

struct node *make(unsigned flags, unsigned order, void *policy,
                  unsigned long index, int slot) {
    calls++;
    if (slot > 1000) {
        return make(flags, order, policy, index, slot - 1);
    }
    if (flags != 0x40001u || order != 2u || policy != (void *)0 ||
        index != 7 || slot != 3) {
        return (struct node *)0;
    }
    return (struct node *)block;
}

static int deep(const volatile unsigned long *p) {
    if (p[1] & 1) {
        return 0;
    }
    return (p[0] & 64) != 0;
}

static int middle(const volatile unsigned long *p) {
    if (p[2] & 2) {
        return 1;
    }
    return deep(p);
}

static int outer(const struct node *n) {
    const volatile unsigned long *p = (const volatile unsigned long *)n;

    if (p[3] & 4) {
        return 0;
    }
    return middle(p);
}

static void mark(struct node *n) {
    (void)n;
}

static struct node *finish(struct node *n) {
    if (n && outer(n)) {
        mark(n);
    }
    return n;
}

struct node *wrap(unsigned flags, unsigned order, void *policy,
                  unsigned long index, int slot) {
    return finish(make(flags | 0x40000, order, policy, index, slot));
}

static struct node *(*volatile entry)(unsigned, unsigned, void *,
                                      unsigned long, int) = wrap;

int main(void) {
    struct node *n = entry(1, 2, (void *)0, 7, 3);

    /* One entry into `make`, and its result reaches the caller. A second
       entry re-runs it with stale registers and loses the result. */
    if (calls != 1) {
        return 1;
    }
    if (n != (struct node *)block) {
        return 2;
    }
    return 0;
}
