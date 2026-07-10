// C99 6.7.8p7 compound designator `[N].field = value` on a deferred-size
// struct-array element in a file-scope initializer -- the dispatch-table
// shape `static const struct { fn } table[] = { [STATE].handler = fn }`.
// C99 6.7.8p22: the array size is the highest designated index + 1, so a
// gap (index 5 with no entry between) still sizes the array to 6.

enum { S_IDLE, S_RUN, S_STOP, S_LAST = 5 };

static int idle(void) { return 10; }
static int run(void) { return 20; }
static int stop(void) { return 30; }
static int last(void) { return 60; }

static const struct {
    int (*handler)(void);
} table[] = {
    [S_IDLE].handler = idle,
    [S_RUN].handler = run,
    [S_STOP].handler = stop,
    [S_LAST].handler = last,
};

int main(void) {
    if (sizeof(table) / sizeof(table[0]) != 6) return 1; /* max index 5 + 1 */
    if (table[S_IDLE].handler() != 10) return 2;
    if (table[S_RUN].handler() != 20) return 3;
    if (table[S_STOP].handler() != 30) return 4;
    if (table[S_LAST].handler() != 60) return 5;
    if (table[3].handler != 0 || table[4].handler != 0) return 6; /* gap zeroed */
    return 0;
}
