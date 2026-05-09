// DEFERRED (#52): width-related typedefs in the bundled headers
// were stuck at `typedef int <name>;` from before the M31
// integer-width work. Now that `int` is 4 bytes, they're 4-byte
// types -- but `size_t` / `ssize_t` / `off_t` / `time_t` should
// all be pointer-width on 64-bit hosts (= `long` on LP64,
// `long long` on LLP64).
//
// What's broken today:
//   stddef.h:    typedef int size_t;    // -> 4 bytes
//   sys/types.h: typedef int ssize_t;   // -> 4 bytes
//   time.h:      typedef int time_t;    // -> 4 bytes
//
// Programs that pass these to libc see byte-count truncation on
// any input larger than 2^31 (e.g. `read(fd, buf, big_size)`,
// `mmap` lengths, `time_t` past 2038, `lseek` offsets).
//
// The fixture asserts the expected post-fix layout: each width
// typedef equals the size of a pointer on 64-bit hosts. Today
// each returns 4 -- fixture flags the size that's wrong.
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <sys/types.h>
#include <time.h>

int main() {
    // Pointer width is the canonical "is this a 64-bit host"
    // gauge in the dialect (Ty::Ptr always lowers to 8 bytes).
    if (sizeof(void *) != 8) {
        // c5 is 64-bit only; this is a sanity check, not the
        // tested assertion.
        return 100;
    }

    // size_t should be pointer-wide.
    if (sizeof(size_t) != sizeof(void *)) return 1;

    // ssize_t mirrors size_t, but signed.
    if (sizeof(ssize_t) != sizeof(void *)) return 2;

    // time_t: seconds since epoch. Linux glibc + macOS make
    // this 8 bytes on 64-bit hosts; Windows is 64-bit time_t
    // on x64 by default since UCRT.
    if (sizeof(time_t) != 8) return 3;

    return 0;
}
