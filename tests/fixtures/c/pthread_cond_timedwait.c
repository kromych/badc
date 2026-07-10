// A common pthread surface: a thread-attribute lifecycle
// (init / setdetachstate / destroy) and a timed condition wait. A
// pthread_cond_timedwait whose absolute deadline has already passed returns
// ETIMEDOUT per POSIX, so the call is deterministic and needs no second
// thread. Windows has no pthreads (the primitives come from <windows.h>), so
// the body is POSIX-only.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <pthread.h>
#include <time.h>

int main(void) {
    pthread_attr_t attr;
    if (pthread_attr_init(&attr)) return 1;
    if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE)) return 2;
    if (pthread_attr_destroy(&attr)) return 3;

    pthread_mutex_t m;
    pthread_cond_t c;
    pthread_mutex_init(&m, 0);
    pthread_cond_init(&c, 0);

    pthread_mutex_lock(&m);
    struct timespec ts;
    ts.tv_sec = 1; // 1970-01-01 00:00:01 UTC, far in the past
    ts.tv_nsec = 0;
    int r = pthread_cond_timedwait(&c, &m, &ts);
    pthread_mutex_unlock(&m);

    pthread_cond_destroy(&c);
    pthread_mutex_destroy(&m);

    // A passed deadline yields ETIMEDOUT (non-zero); a zero return would
    // mean the wait reported a signal that never came.
    return (r != 0) ? 0 : 4;
}
#endif
