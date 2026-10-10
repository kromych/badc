/* The result pointer of `__builtin_{add,sub,mul}_overflow` is an evaluated
 * operand like the other two: a function it calls, a function address it
 * stores and an object it addresses are used, and the definitions they
 * name -- reached from no other expression -- are emitted. */

static long sink;
static long *where(void) { return &sink; }

static int scaled(int x) { return x * 3 + 1; }
int (*volatile stored)(int);

static int decremented(int x) { return x - 1; }
struct holder {
    long val;
    int (*fn)(int);
};
static struct holder held = { 0, decremented };
static struct holder *volatile held_at;

static volatile long one = 1;

int main(void) {
    long r;
    if (__builtin_add_overflow(one, 41L, where()) || sink != 42)
        return 1;
    if (__builtin_sub_overflow(one, 1L, (stored = scaled, &r)) || r != 0)
        return 2;
    if (stored(7) != 22)
        return 3;
    if (__builtin_mul_overflow(one, 5L, (held_at = &held, &held.val)))
        return 4;
    if (held_at->val != 5 || held_at->fn(7) != 6)
        return 5;
    return 0;
}
