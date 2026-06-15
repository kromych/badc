// `struct timeval` layout must match the host so gettimeofday's fields
// land where the C code reads them. Darwin's tv_usec is a 4-byte
// __darwin_suseconds_t; reading it as a 64-bit field pulls 4 bytes of
// adjacent storage into the high half and yields a microsecond count
// far outside [0, 1000000). Linux and Windows use a 64-bit-wide field.
// A garbage tv_usec corrupts any select / pthread_cond timeout computed
// from gettimeofday, which manifested as a 100% busy-loop in the Tcl
// event loop on macOS.
#include <sys/time.h>

int main(void) {
    struct timeval tv;
    for (int i = 0; i < 100; i++) {
        if (gettimeofday(&tv, 0) != 0) {
            return 1;
        }
        if (tv.tv_usec < 0 || tv.tv_usec >= 1000000) {
            return 2;
        }
        if (tv.tv_sec <= 0) {
            return 3;
        }
    }
    return 0;
}
