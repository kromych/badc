/* A static function whose address only a `_Thread_local` slot holds escapes:
 * a call through the slot passes its own argument, so the parameter is not
 * the constant the one direct call passes. Returns 0. */
static int __attribute__((noinline)) twice(int x) { return x * 2; }

static _Thread_local int (*tp)(int) = twice;

int main(void) {
    int a = twice(5);
    int b = tp(7);
    return a == 10 && b == 14 ? 0 : 1;
}
