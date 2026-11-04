// _timeval.h -- `struct timeval` and the BSD timer macros on Windows, as
// mingw-w64's _timeval.h defines them for <sys/time.h> and <winsock2.h>.
// Winsock's select() reads the struct as two 32-bit `long` fields (LLP64):
// a 64-bit field would place tv_usec where select expects tv_sec's high half.

#ifndef _TIMEVAL_DEFINED
#define _TIMEVAL_DEFINED
struct timeval {
    long tv_sec;
    long tv_usec;
};
#define timerisset(tvp) ((tvp)->tv_sec || (tvp)->tv_usec)
#define timercmp(tvp, uvp, cmp)                                                   \
    ((tvp)->tv_sec cmp (uvp)->tv_sec ||                                            \
     ((tvp)->tv_sec == (uvp)->tv_sec && (tvp)->tv_usec cmp (uvp)->tv_usec))
#define timerclear(tvp) (tvp)->tv_sec = (tvp)->tv_usec = 0
#endif
