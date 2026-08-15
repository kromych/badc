// Regression: pthread_key_t / pthread_once_t must match the platform
// width, not an over-wide catch-all.
//
// These types appear inside structs whose layout a program reads back
// (a separately-compiled module computes field offsets against the host
// struct). An over-wide slot shifts every later field. macOS uses an
// 8-byte key and a 16-byte once control; Linux uses 4 bytes for both.

#include <pthread.h>

struct tss {
    int initialized;
    pthread_key_t key;
};

int main(void) {
#if defined(__APPLE__)
    // Darwin once control is the 16-byte signature-carrying struct.
    if (sizeof(pthread_key_t) != 8 || sizeof(pthread_once_t) != 16) {
        return 1;
    }
    // 4-byte int, 8-byte key 8-aligned: padding to offset 8, size 16.
    if (sizeof(struct tss) != 16) {
        return 2;
    }
    // Darwin opaque sizes (<sys/_pthread/_pthread_types.h>): 8-byte
    // signature word plus the per-type body.
    if (sizeof(pthread_cond_t) != 48 || sizeof(pthread_mutex_t) != 64) {
        return 3;
    }
    if (sizeof(pthread_mutexattr_t) != 16 || sizeof(pthread_condattr_t) != 16 ||
        sizeof(pthread_attr_t) != 64) {
        return 4;
    }
    // The signature word also sets the alignment every type carries.
    if (_Alignof(pthread_cond_t) != 8 || _Alignof(pthread_mutex_t) != 8 ||
        _Alignof(pthread_mutexattr_t) != 8 || _Alignof(pthread_condattr_t) != 8 ||
        _Alignof(pthread_attr_t) != 8 || _Alignof(pthread_once_t) != 8) {
        return 5;
    }
#elif defined(__linux__)
    if (sizeof(pthread_key_t) != 4 || sizeof(pthread_once_t) != 4) {
        return 1;
    }
    // 4-byte int + 4-byte key, no padding: size 8.
    if (sizeof(struct tss) != 8) {
        return 2;
    }
    // glibc opaque sizes (bits/pthreadtypes-arch.h). cond / rwlock are
    // the same on both 64-bit ISAs; mutex and the attr types differ.
    if (sizeof(pthread_cond_t) != 48) {
        return 3;
    }
#if defined(__aarch64__)
    if (sizeof(pthread_mutex_t) != 48 || sizeof(pthread_mutexattr_t) != 8 ||
        sizeof(pthread_condattr_t) != 8 || sizeof(pthread_attr_t) != 64) {
        return 4;
    }
#else
    if (sizeof(pthread_mutex_t) != 40 || sizeof(pthread_mutexattr_t) != 4 ||
        sizeof(pthread_condattr_t) != 4 || sizeof(pthread_attr_t) != 56) {
        return 4;
    }
#endif
#endif
    return 0;
}
