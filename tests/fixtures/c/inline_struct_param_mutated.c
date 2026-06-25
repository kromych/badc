/* A helper that writes through its by-value struct parameter must NOT be
   inlined: redirecting the parameter slot to the caller's argument
   address would mutate the caller's variable in place (there is no
   private copy for a fixed struct argument). The candidate filter keeps
   it out of line via the Store reject; this fixture locks that the
   caller's copy is unaffected. */
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
