/* C99 7.13.2.1p3: after longjmp, a volatile-qualified auto object
   modified between setjmp and longjmp keeps its last stored value.
   The slot must stay memory-resident (no mem2reg promotion) so the
   post-longjmp read observes the store. */
#include <setjmp.h>

static jmp_buf env;

int main(void) {
    volatile int x = 1;
    if (setjmp(env) == 0) {
        x = 2;
        longjmp(env, 1);
    }
    return x == 2 ? 0 : 1;
}
