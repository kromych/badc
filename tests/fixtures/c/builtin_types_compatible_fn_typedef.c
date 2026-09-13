// C99 6.7.5.1 / 6.2.7p1: `F *` over a function-type typedef `F` names the
// same pointer-to-function type as the function-pointer typedef and the
// spelled-out declarator, and `typeof` of an object declared through
// either spelling agrees with both. Every expectation matches clang.
// Returns 0 on success; distinct non-zero per failure.

struct T {
    int a;
};
typedef struct T *sel_t(int, int);     /* function type */
typedef struct T *(*selp_t)(int, int); /* pointer to function */
typedef sel_t *selpt_t;                /* pointer through the function type */

int probe(sel_t *v, selp_t w) {
    return __builtin_types_compatible_p(typeof(v), sel_t *)
         + 2 * __builtin_types_compatible_p(typeof(v), selp_t)
         + 4 * __builtin_types_compatible_p(sel_t *, selp_t)
         + 8 * __builtin_types_compatible_p(int *, int *)
         + 16 * __builtin_types_compatible_p(typeof(w), sel_t *)
         + 32 * __builtin_types_compatible_p(typeof(v), typeof(w));
}

_Static_assert(__builtin_types_compatible_p(sel_t *, struct T *(*)(int, int)) == 1, "spelled out");
_Static_assert(__builtin_types_compatible_p(sel_t *, selpt_t) == 1, "pointer typedef");
_Static_assert(__builtin_types_compatible_p(sel_t **, selp_t *) == 1, "two levels");
_Static_assert(__builtin_types_compatible_p(sel_t, selp_t) == 0, "function vs pointer");
_Static_assert(__builtin_types_compatible_p(sel_t *, selp_t *) == 0, "depth");
_Static_assert(__builtin_types_compatible_p(sel_t *, struct T *(*)(int)) == 0, "arity");

int main(void) {
    if (probe(0, 0) != 63) return 1;
    return 0;
}
