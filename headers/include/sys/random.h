#pragma once

// getrandom(2) -- fill a buffer with kernel-generated random bytes
// (Linux 3.17+).

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getrandom, "getrandom")
#endif

// Draw from the blocking /dev/random pool instead of /dev/urandom.
#define GRND_RANDOM   0x0002
// Return EAGAIN rather than block when the requested pool isn't ready.
#define GRND_NONBLOCK 0x0001

long getrandom(char *buf, unsigned long buflen, unsigned int flags);
