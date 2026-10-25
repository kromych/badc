// ndbm.h -- the XSI database, bound to libSystem's calls. glibc ships no
// <ndbm.h>, so the header is served on macOS alone; the SDK's DBM is an
// opaque record of an int and eight pointers.

#pragma once

#include <stddef.h>
#include <sys/types.h>

#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#include <fcntl.h>
#define DBM_RDONLY O_RDONLY
#define DBM_SUFFIX ".db"
#define dbm_pagfno(a) DBM_PAGFNO_NOT_AVAILABLE
#endif

#define DBM_INSERT 0
#define DBM_REPLACE 1

typedef struct {
    void *dptr;
    size_t dsize;
} datum;

typedef struct {
    char __opaque[sizeof(int) + 8 * sizeof(void *)];
} DBM;

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::dbm_clearerr, "_dbm_clearerr")
#pragma binding(libc::dbm_close, "_dbm_close")
#pragma binding(libc::dbm_delete, "_dbm_delete")
#pragma binding(libc::dbm_dirfno, "_dbm_dirfno")
#pragma binding(libc::dbm_error, "_dbm_error")
#pragma binding(libc::dbm_fetch, "_dbm_fetch")
#pragma binding(libc::dbm_firstkey, "_dbm_firstkey")
#pragma binding(libc::dbm_nextkey, "_dbm_nextkey")
#pragma binding(libc::dbm_open, "_dbm_open")
#pragma binding(libc::dbm_store, "_dbm_store")

int dbm_clearerr(DBM *db);
void dbm_close(DBM *db);
int dbm_delete(DBM *db, datum key);
#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
int dbm_dirfno(DBM *db);
#endif
int dbm_error(DBM *db);
datum dbm_fetch(DBM *db, datum key);
datum dbm_firstkey(DBM *db);
datum dbm_nextkey(DBM *db);
DBM *dbm_open(const char *file, int open_flags, mode_t file_mode);
int dbm_store(DBM *db, datum key, datum content, int store_mode);
