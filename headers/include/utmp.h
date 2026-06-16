#pragma once

// utmp.h -- login-record field sizes. The full <utmp.h> also declares a
// `struct utmp` and the getutent/pututline family; only the field-size
// constants the bundled demos reach for are provided here.

#define UT_LINESIZE 32
#define UT_NAMESIZE 32
#define UT_HOSTSIZE 256
