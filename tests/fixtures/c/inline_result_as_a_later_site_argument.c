// snapshot-flags: -O
// C17 6.5.2.2p4: an argument is evaluated before the call, here a call's
// own result. `share` takes `clone` whole, whose body ends up after the
// blocks `share` began with, and takes `set` in place; `get`, which returns
// its parameter, then goes into both at once, so the site from `set` reads
// as its argument the result of a site that lies in a later block.
struct cookie {
    int refs;
};
struct task {
    int lock;
    unsigned long cookie;
};

void lock(int *l);
void unlock(int *l);
unsigned long update(struct task *p, unsigned long cookie);
void put(unsigned long cookie);

static unsigned long get(unsigned long cookie) {
    struct cookie *c = (struct cookie *)cookie;
    if (c) {
        c->refs++;
    }
    return cookie;
}

static unsigned long clone(struct task *p) {
    unsigned long cookie;
    lock(&p->lock);
    cookie = get(p->cookie);
    unlock(&p->lock);
    return cookie;
}

static void set(struct task *p, unsigned long cookie) {
    cookie = get(cookie);
    cookie = update(p, cookie);
    put(cookie);
}

int share(unsigned cmd, struct task *task, struct task *self) {
    unsigned long cookie = 0;
    switch (cmd) {
    case 1:
        cookie = clone(self);
        break;
    case 3:
        cookie = clone(task);
        set(self, cookie);
        return 0;
    default:
        return -1;
    }
    set(task, cookie);
    put(cookie);
    return 0;
}

static unsigned long seen;

__attribute__((noinline)) void lock(int *l) {
    *l += 1;
}

__attribute__((noinline)) void unlock(int *l) {
    *l -= 1;
}

__attribute__((noinline)) unsigned long update(struct task *p, unsigned long cookie) {
    unsigned long old = p->cookie;
    p->cookie = cookie;
    seen = cookie;
    return old;
}

__attribute__((noinline)) void put(unsigned long cookie) {
    (void)cookie;
}

int main(void) {
    struct cookie c = {1};
    struct task a = {0, (unsigned long)&c}, b = {0, 0};
    if (share(3, &a, &b) != 0) {
        return 1;
    }
    if (seen != (unsigned long)&c || b.cookie != (unsigned long)&c) {
        return 2;
    }
    return c.refs == 3 && a.lock == 0 ? 0 : 3;
}
