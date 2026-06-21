// Regression: a dynamic import must bind its library's default symbol
// version, not the first (oldest) definition of the name.
//
// glibc exports two pthread_cond_init definitions: the current
// @@GLIBC_2.3.2 default and an old @GLIBC_2.2.5 compatibility stub.
// The old stub returns EINVAL when the condition-variable attribute
// selects a non-default clock (CLOCK_MONOTONIC); the default accepts
// it. An import emitted without a `.gnu.version_r` requirement binds
// the old stub, so this sequence -- the one CPython runs to create its
// GIL -- fails with EINVAL. Exit 0 only when the default version bound.

#include <pthread.h>
#include <time.h>

int main(void) {
    pthread_condattr_t attr;
    if (pthread_condattr_init(&attr) != 0) {
        return 1;
    }
    if (pthread_condattr_setclock(&attr, CLOCK_MONOTONIC) != 0) {
        return 2;
    }
    pthread_cond_t cond;
    if (pthread_cond_init((char *)&cond, (char *)&attr) != 0) {
        return 3;
    }
    pthread_cond_destroy((char *)&cond);
    pthread_condattr_destroy(&attr);
    return 0;
}
