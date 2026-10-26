// nl_types.h -- message catalogs, bound to the C library: glibc's calls in
// libc.so.6 and libSystem's. glibc's catalog handle is an opaque pointer,
// the SDK's points at a record of the mapped catalog and its size.

#pragma once

#define NL_SETD 1
#define NL_CAT_LOCALE 1

typedef int nl_item;

#ifdef __linux__
typedef void *nl_catd;

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::catopen, "catopen")
#pragma binding(libc::catgets, "catgets")
#pragma binding(libc::catclose, "catclose")
#elif defined(__APPLE__)
typedef struct __nl_cat_d {
    void *__data;
    int __size;
} *nl_catd;

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::catopen, "_catopen")
#pragma binding(libc::catgets, "_catgets")
#pragma binding(libc::catclose, "_catclose")
#endif

nl_catd catopen(const char *name, int oflag);
char *catgets(nl_catd catd, int set_id, int msg_id, const char *s);
int catclose(nl_catd catd);
