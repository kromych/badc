// search.h -- hash tables, binary search trees, linear search and queue
// links, bound to the C library: glibc's calls in libc.so.6 and
// libSystem's. glibc adds the reentrant hash tables, twalk_r, tdestroy and
// struct qelem for _GNU_SOURCE. mingw-w64's has the trees and the linear
// searches alone: msvcrt's _lfind and _lsearch, counting in unsigned int,
// and the trees of libmingwex, which libc/lib/search_ext.c defines.

#pragma once

#include <stddef.h>

typedef struct entry {
    char *key;
    void *data;
} ENTRY;

typedef enum { FIND, ENTER } ACTION;

typedef enum { preorder, postorder, endorder, leaf } VISIT;

#ifdef __linux__
#ifndef __COMPAR_FN_T
#define __COMPAR_FN_T
typedef int (*__compar_fn_t)(const void *, const void *);
#ifdef _GNU_SOURCE
typedef __compar_fn_t comparison_fn_t;
#endif
#endif

#ifdef _GNU_SOURCE
struct qelem {
    struct qelem *q_forw;
    struct qelem *q_back;
    char q_data[1];
};

struct _ENTRY;
struct hsearch_data {
    struct _ENTRY *table;
    unsigned int size;
    unsigned int filled;
};

int hsearch_r(ENTRY item, ACTION action, ENTRY **retval, struct hsearch_data *htab);
int hcreate_r(size_t nel, struct hsearch_data *htab);
void hdestroy_r(struct hsearch_data *htab);
void twalk_r(const void *root, void (*action)(const void *nodep, VISIT which, void *closure),
             void *closure);
#endif

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::hcreate, "hcreate")
#pragma binding(libc::hdestroy, "hdestroy")
#pragma binding(libc::hsearch, "hsearch")
#pragma binding(libc::hcreate_r, "hcreate_r")
#pragma binding(libc::hdestroy_r, "hdestroy_r")
#pragma binding(libc::hsearch_r, "hsearch_r")
#pragma binding(libc::tsearch, "tsearch")
#pragma binding(libc::tfind, "tfind")
#pragma binding(libc::tdelete, "tdelete")
#pragma binding(libc::twalk, "twalk")
#pragma binding(libc::twalk_r, "twalk_r")
#pragma binding(libc::tdestroy, "tdestroy")
#pragma binding(libc::lfind, "lfind")
#pragma binding(libc::lsearch, "lsearch")
#pragma binding(libc::insque, "insque")
#pragma binding(libc::remque, "remque")
#elif defined(__APPLE__)
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::hcreate, "_hcreate")
#pragma binding(libc::hdestroy, "_hdestroy")
#pragma binding(libc::hsearch, "_hsearch")
#pragma binding(libc::tsearch, "_tsearch")
#pragma binding(libc::tfind, "_tfind")
#pragma binding(libc::tdelete, "_tdelete")
#pragma binding(libc::twalk, "_twalk")
#pragma binding(libc::lfind, "_lfind")
#pragma binding(libc::lsearch, "_lsearch")
#pragma binding(libc::insque, "_insque")
#pragma binding(libc::remque, "_remque")
#endif

void *tsearch(const void *key, void **rootp, int (*compar)(const void *, const void *));
void *tfind(const void *key, void *const *rootp, int (*compar)(const void *, const void *));
void *tdelete(const void *restrict key, void **restrict rootp,
              int (*compar)(const void *, const void *));
void twalk(const void *root, void (*action)(const void *nodep, VISIT which, int depth));

#if defined(_GNU_SOURCE) && (defined(__linux__) || defined(_WIN32))
void tdestroy(void *root, void (*free_node)(void *nodep));
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_lfind, "_lfind")
#pragma binding(msvcrt::_lsearch, "_lsearch")
#pragma binding(msvcrt::lfind, "_lfind")
#pragma binding(msvcrt::lsearch, "_lsearch")
#pragma binding(msvcrt::bsearch, "bsearch")
#pragma binding(msvcrt::qsort, "qsort")

void *bsearch(const void *key, const void *base, size_t n, size_t size,
              int (*cmp)(const void *, const void *));
void qsort(void *base, size_t n, size_t size, int (*cmp)(const void *, const void *));
void *_lfind(const void *key, const void *base, unsigned int *num, unsigned int width,
             int (*compar)(const void *, const void *));
void *_lsearch(const void *key, void *base, unsigned int *num, unsigned int width,
               int (*compar)(const void *, const void *));
void *lfind(const void *key, const void *base, unsigned int *num, unsigned int width,
            int (*compar)(const void *, const void *));
void *lsearch(const void *key, void *base, unsigned int *num, unsigned int width,
              int (*compar)(const void *, const void *));
#else
int hcreate(size_t nel);
void hdestroy(void);
ENTRY *hsearch(ENTRY item, ACTION action);
void *lfind(const void *key, const void *base, size_t *nelp, size_t width,
            int (*compar)(const void *, const void *));
void *lsearch(const void *key, void *base, size_t *nelp, size_t width,
              int (*compar)(const void *, const void *));
void insque(void *element, void *pred);
void remque(void *element);
#endif
