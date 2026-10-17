// snapshot-flags: -c
// A relocatable object reaches a weak `_Thread_local` definition through
// its symbol, which the link binds to a strong definition elsewhere; alone,
// the weak definition is the object. Returns 0.

__attribute__((weak)) _Thread_local long tw = 3;

long *addr_t(void) { return &tw; }

int main(void) {
    tw += 4;
    return tw == 7 && addr_t() == &tw ? 0 : 1;
}
