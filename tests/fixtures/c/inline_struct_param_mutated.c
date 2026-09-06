/* A helper that writes through its by-value struct parameter inlines: the
   write makes the splice reproduce the prologue's copy, so the parameter
   cell is relocated into the caller's frame and filled from the argument
   and the store lands in the callee's own copy. This fixture locks that
   the caller's object keeps the value it had at the call. */
typedef struct { long a; } S;

static long bump(S s) {
    s.a = s.a + 100;
    return s.a;
}

int main(void) {
    S v;
    v.a = 5;
    long r = bump(v);            /* 105 */
    /* v.a stays 5 (by-value copy); 105*1000 + 5 = 105005 */
    return (r * 1000 + v.a) == 105005 ? 0 : 1;
}
