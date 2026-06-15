// Darwin's libpthread checks a signature word at offset 0 of a mutex
// and condition variable. A statically initialised object must carry
// the magic the system headers seed (PTHREAD_MUTEX_INITIALIZER /
// PTHREAD_COND_INITIALIZER); an all-zero object is rejected by
// pthread_mutex_lock / pthread_cond_wait with EINVAL. glibc and the
// Windows shim take an all-zero object. A wrong initializer silently
// breaks every static lock, including the threaded event-loop notifier.
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
