// snapshot-flags: -c
// A relocatable object names a weak definition by its symbol in every
// reference, which the link binds to a strong definition elsewhere; alone,
// the weak definition is the object. Returns 0.

struct pair {
    long a, b;
};

__attribute__((weak)) long wobj = 5;
__attribute__((weak)) struct pair ws = {1, 2};
__attribute__((weak)) long wf(void) { return 7; }

long *pw = &wobj;
long *const pend = &ws.b + 1;
long (*pf)(void) = wf;

long (*get_f(void))(void) { return wf; }

int main(void) {
    if (wobj + *pw != 10) {
        return 1;
    }
    if (pend != &ws.b + 1 || ws.b != 2) {
        return 2;
    }
    if (pf() + get_f()() != 14) {
        return 3;
    }
    return 0;
}
