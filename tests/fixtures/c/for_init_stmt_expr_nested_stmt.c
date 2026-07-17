/* A for-init that is a GNU statement-expression containing a nested
   statement (a while whose condition is false at init). The nested
   statement's body must run only under its own control flow, not as a
   sibling of the for-init. Regression: the for-init wrapped its
   statement-expression's sub-statements into a Compound as siblings, so
   the walker ran a nested while's body unconditionally (which, for a
   qatomic_read build-assert, emitted an undefined-symbol canary call).
   Identical result at -O and -O0. */

int main(void) {
    int ran = 0;
    int sum = 0;
    for (int i = ({
             while (sum != 0) { /* false at init: body must not run */
                 ran = 1;
                 break;
             }
             3;
         });
         i > 0; i--) {
        sum += i;
    }
    if (ran) {
        return 1; /* the nested while body ran as a sibling -- the bug */
    }
    return sum; /* 3 + 2 + 1 = 6 */
}
