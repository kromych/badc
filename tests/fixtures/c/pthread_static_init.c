// Darwin's libpthread checks a signature word at offset 0 of a mutex
// and condition variable. A statically initialised object must carry
// the magic the system headers seed (PTHREAD_MUTEX_INITIALIZER /
// PTHREAD_COND_INITIALIZER); an all-zero object is rejected by
// pthread_mutex_lock / pthread_cond_wait with EINVAL. glibc takes an
// all-zero object, as does Windows, whose zero lock and condition variable
// are SRWLOCK_INIT and CONDITION_VARIABLE_INIT. A wrong initializer silently
// breaks every static lock.
#include <pthread.h>

static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t cv = PTHREAD_COND_INITIALIZER;

int main(void) {
    if (pthread_mutex_lock(&mtx) != 0) {
        return 1;
    }
    if (pthread_mutex_unlock(&mtx) != 0) {
        return 2;
    }
    // signal on a condition with no waiter is a defined no-op; it still
    // validates the static signature is accepted.
    if (pthread_cond_signal(&cv) != 0) {
        return 3;
    }
    return 0;
}
