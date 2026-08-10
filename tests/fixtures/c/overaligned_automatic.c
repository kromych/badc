/* An automatic object whose required alignment exceeds the 16-byte frame
   guarantee (C11 6.7.5 _Alignas / GNU aligned) is placed on its boundary by a
   prologue that realigns the stack pointer. Exercises the three access shapes:
   an array and a struct (addressed via their address) and a scalar (addressed
   by name), plus a request inherited from an over-aligned type. A call sits
   between the writes so the sp-relative addressing must survive the callee's
   argument scratch. Returns 0 when every object landed on its boundary and
   round-tripped its value. */
struct __attribute__((aligned(32))) cell { int v; };

static long sink(void *p) { return (long)p; }

int main(void) {
    _Alignas(64) char buf[64];
    _Alignas(32) int arr[4];
    _Alignas(64) long long scal;
    struct cell c;

    unsigned long misaligned =
        ((unsigned long)(void *)buf & 63u) | ((unsigned long)(void *)arr & 31u) |
        ((unsigned long)(void *)&scal & 63u) | ((unsigned long)(void *)&c & 31u);
    if (misaligned != 0)
        return 1;

    buf[0] = 11;
    arr[3] = 22;
    scal = 33;
    c.v = 44;
    sink(buf);
    sink(arr);
    sink(&scal);
    sink(&c);

    if (buf[0] != 11 || arr[3] != 22 || scal != 33 || c.v != 44)
        return 2;
    /* Re-check after the calls: the objects keep their boundary. */
    if (((unsigned long)(void *)buf & 63u) | ((unsigned long)(void *)&scal & 63u))
        return 3;
    return 0;
}
