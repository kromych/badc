// <ndbm.h>, where the C library ships it: a database dbm_open creates
// stores two records, dbm_fetch returns each value, DBM_INSERT refuses an
// existing key with 1, dbm_firstkey and dbm_nextkey visit both keys,
// dbm_delete removes one and dbm_close returns. glibc ships no <ndbm.h>, and
// there __has_include is 0 and the fixture returns 0.
#if __has_include(<ndbm.h>)
#include <fcntl.h>
#include <ndbm.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static datum text(const char *s) {
    datum d;
    d.dptr = (void *)s;
    d.dsize = strlen(s);
    return d;
}

int main(void) {
    char dir[] = "/tmp/badc-ndbm-XXXXXX";
    char base[64], file[72];
    DBM *db;
    datum v, k;
    int keys = 0, rc = 0;

    if (!mkdtemp(dir)) return 1;
    snprintf(base, sizeof base, "%s/db", dir);
    snprintf(file, sizeof file, "%s%s", base, DBM_SUFFIX);
    if (!(db = dbm_open(base, O_RDWR | O_CREAT, 0600))) return 2;
    if (dbm_store(db, text("alpha"), text("one"), DBM_INSERT) != 0) rc = 3;
    if (!rc && dbm_store(db, text("beta"), text("two"), DBM_REPLACE) != 0) rc = 4;
    if (!rc && dbm_store(db, text("alpha"), text("uno"), DBM_INSERT) != 1) rc = 5;
    v = dbm_fetch(db, text("beta"));
    if (!rc && (v.dsize != 3 || memcmp(v.dptr, "two", 3) != 0)) rc = 6;
    for (k = dbm_firstkey(db); !rc && k.dptr; k = dbm_nextkey(db))
        keys++;
    if (!rc && keys != 2) rc = 7;
    if (!rc && dbm_delete(db, text("alpha")) != 0) rc = 8;
    v = dbm_fetch(db, text("alpha"));
    if (!rc && v.dptr) rc = 9;
    if (!rc && dbm_error(db) != 0) rc = 10;
    dbm_close(db);
    unlink(file);
    rmdir(dir);
    return rc;
}
#else
int main(void) {
    return 0;
}
#endif
