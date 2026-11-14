#pragma once

// utmp.h -- login-record field sizes. The full <utmp.h> also declares a
// `struct utmp` and the getutent/pututline family; only the field-size
// constants the bundled demos reach for are provided here.

#ifdef __APPLE__
#define UT_LINESIZE 8
#define UT_NAMESIZE 8
#define UT_HOSTSIZE 16
#else
#define UT_LINESIZE 32
#define UT_NAMESIZE 32
#define UT_HOSTSIZE 256
#endif
