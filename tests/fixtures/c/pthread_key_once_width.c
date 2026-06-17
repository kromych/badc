// Regression: pthread_key_t / pthread_once_t must match the platform
// width, not an over-wide catch-all.
//
// These types appear inside structs whose layout a program reads back
// (CPython wraps pthread_key_t in Py_tss_t inside _PyRuntime, and a
// dlopen'd extension computes field offsets against the host struct).
// An over-wide slot shifts every later field. macOS uses 8-byte
// (unsigned long / long); Linux uses 4-byte (unsigned int / int).

#include <pthread.h>

struct tss {
    int initialized;
    pthread_key_t key;
};

int main(void) {
#if defined(__APPLE__)
    if (sizeof(pthread_key_t) != 8 || sizeof(pthread_once_t) != 8) {
        return 1;
    }
    // 4-byte int, 8-byte key 8-aligned: padding to offset 8, size 16.
    if (sizeof(struct tss) != 16) {
        return 2;
    }
#elif defined(__linux__)
    if (sizeof(pthread_key_t) != 4 || sizeof(pthread_once_t) != 4) {
        return 1;
    }
    // 4-byte int + 4-byte key, no padding: size 8.
    if (sizeof(struct tss) != 8) {
        return 2;
    }
#endif
    return 0;
}
