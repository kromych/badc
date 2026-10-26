// fmtmsg.h -- formatted diagnostics on standard error and the console,
// bound to the C library: glibc's calls in libc.so.6 and libSystem's. The
// classification bits and the return values differ: glibc enumerates them
// (MM_NOTOK is -1 there) and adds addseverity, the SDK defines macros.

#pragma once

#ifdef __linux__
enum {
    MM_HARD = 0x001,
#define MM_HARD MM_HARD
    MM_SOFT = 0x002,
#define MM_SOFT MM_SOFT
    MM_FIRM = 0x004,
#define MM_FIRM MM_FIRM
    MM_APPL = 0x008,
#define MM_APPL MM_APPL
    MM_UTIL = 0x010,
#define MM_UTIL MM_UTIL
    MM_OPSYS = 0x020,
#define MM_OPSYS MM_OPSYS
    MM_RECOVER = 0x040,
#define MM_RECOVER MM_RECOVER
    MM_NRECOV = 0x080,
#define MM_NRECOV MM_NRECOV
    MM_PRINT = 0x100,
#define MM_PRINT MM_PRINT
    MM_CONSOLE = 0x200
#define MM_CONSOLE MM_CONSOLE
};

enum {
    MM_NOSEV = 0,
#define MM_NOSEV MM_NOSEV
    MM_HALT,
#define MM_HALT MM_HALT
    MM_ERROR,
#define MM_ERROR MM_ERROR
    MM_WARNING,
#define MM_WARNING MM_WARNING
    MM_INFO
#define MM_INFO MM_INFO
};

enum {
    MM_NOTOK = -1,
#define MM_NOTOK MM_NOTOK
    MM_OK = 0,
#define MM_OK MM_OK
    MM_NOMSG = 1,
#define MM_NOMSG MM_NOMSG
    MM_NOCON = 4
#define MM_NOCON MM_NOCON
};

#define MM_NULLLBL ((char *)0)
#define MM_NULLSEV 0
#define MM_NULLMC ((long int)0)
#define MM_NULLTXT ((char *)0)
#define MM_NULLACT ((char *)0)
#define MM_NULLTAG ((char *)0)

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fmtmsg, "fmtmsg")
#pragma binding(libc::addseverity, "addseverity")

int addseverity(int severity, const char *string);
#elif defined(__APPLE__)
#define MM_HARD 0x0001
#define MM_SOFT 0x0002
#define MM_FIRM 0x0004
#define MM_APPL 0x0010
#define MM_UTIL 0x0020
#define MM_OPSYS 0x0040
#define MM_PRINT 0x0100
#define MM_CONSOLE 0x0200
#define MM_RECOVER 0x1000
#define MM_NRECOV 0x2000

#define MM_NOSEV 0
#define MM_HALT 1
#define MM_ERROR 2
#define MM_WARNING 3
#define MM_INFO 4

#define MM_NULLLBL (char *)0
#define MM_NULLSEV 0
#define MM_NULLMC 0L
#define MM_NULLTXT (char *)0
#define MM_NULLACT (char *)0
#define MM_NULLTAG (char *)0

#define MM_OK 0
#define MM_NOMSG 1
#define MM_NOCON 2
#define MM_NOTOK 3

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fmtmsg, "_fmtmsg")
#endif

int fmtmsg(long classification, const char *label, int severity, const char *text,
           const char *action, const char *tag);
