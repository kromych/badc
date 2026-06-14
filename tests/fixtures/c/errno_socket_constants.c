// The socket and system errno numbers diverge between Linux and macOS,
// and several were absent from <errno.h>. A missing constant fails to
// compile; a duplicated value is a transcription error. Every errno is a
// positive integer and the named constants must be distinct. The exact
// per-host values are exercised by the Tcl socket suite.
#include <errno.h>

int main(void) {
    int v[] = {
        EADDRNOTAVAIL, EADDRINUSE,   ECONNREFUSED, ETIMEDOUT,
        EINPROGRESS,   EHOSTUNREACH, ENETUNREACH,  EAGAIN,
        ECONNRESET,    ENOTCONN,     ENOBUFS,      ECONNABORTED,
        EISCONN,       ENETDOWN,     EALREADY,     EAFNOSUPPORT,
    };
    int n = (int)(sizeof(v) / sizeof(v[0]));
    for (int i = 0; i < n; i++) {
        if (v[i] <= 0) {
            return 1;
        }
        for (int j = i + 1; j < n; j++) {
            if (v[i] == v[j]) {
                return 2;
            }
        }
    }
    return 0;
}
