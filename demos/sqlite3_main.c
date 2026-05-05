// Minimal sqlite3 driver. Append to sqlite3.c (the c5 preprocessor
// has no filesystem-relative `#include` support yet) before
// compiling:
//   cat demos/sqlite3/sqlite3.c demos/sqlite3_main.c > /tmp/combined.c
//   target/release/badc /tmp/combined.c
//
// Opens an in-memory database, runs a simple CREATE / INSERT /
// SELECT round-trip, and prints the values back. The first
// end-to-end smoke test for the c5 compilation of the
// amalgamation.

int main() {
    // Smoke test driver. Walks progressively deeper sqlite3 entry
    // points and reports the first runtime failure. Each tier is
    // followed by `fflush(stdout)` so a SIGBUS / SIGSEGV between
    // printf and the abort doesn't lose the diagnostics that
    // came before it.

    // Tier 1: leaf functions returning const strings / integers.
    printf("[1.1] sqlite3_libversion()      -> %s\n", sqlite3_libversion());
    printf("[1.2] sqlite3_sourceid()        -> %s\n", sqlite3_sourceid());
    printf("[1.3] sqlite3_libversion_number -> %d\n", sqlite3_libversion_number());
    printf("[1.4] sqlite3_threadsafe()      -> %d\n", sqlite3_threadsafe());
    fflush(stdout);

    // Tier 2: library init -- bisect by calling each step of
    // sqlite3_initialize directly. Each call tells us how far we
    // get before the SIGBUS lands.
    printf("[2.0] sqlite3Config.isInit = %d\n", sqlite3Config.isInit);
    fflush(stdout);
    int mrc = sqlite3MutexInit();
    printf("[2.1] sqlite3MutexInit()      -> %d\n", mrc);
    fflush(stdout);
    if (mrc != 0) return 1;
    sqlite3_mutex *m = sqlite3MutexAlloc(2);
    printf("[2.2] sqlite3MutexAlloc(2)    -> %p\n", m);
    fflush(stdout);
    if (m == 0) return 1;
    sqlite3_mutex_enter(m);
    printf("[2.3] mutex_enter ok\n");
    fflush(stdout);
    sqlite3_mutex_leave(m);
    printf("[2.4] mutex_leave ok\n");
    fflush(stdout);

    sqlite3MemSetDefault();
    printf("[2.4a] sqlite3MemSetDefault ok\n");
    fflush(stdout);
    printf("[2.4b] sqlite3Config.m.xMalloc=%p\n", sqlite3Config.m.xMalloc);
    fflush(stdout);

    int mrc2 = sqlite3MallocInit();
    printf("[2.5] sqlite3MallocInit()     -> %d\n", mrc2);
    fflush(stdout);
    if (mrc2 != 0) return 1;

    // Tier 2.6: replicate the rest of sqlite3_initialize step-by-step
    // so any SIGBUS / SIGSEGV is bracketed. Mirrors the amalgamation's
    // body verbatim (SQLite 3.53.0 -- see sqlite3.c around line 189046).
    sqlite3Config.isMallocInit = 1;
    printf("[2.6a] isMallocInit=1\n"); fflush(stdout);

    // Bisect each step that sqlite3MutexAlloc(1) takes.
    // sqlite3MallocZero -> sqlite3Malloc (no recursion through
    // sqlite3_initialize unlike the public sqlite3_malloc).
    void *zz = sqlite3MallocZero(64);
    printf("[2.6a0b] sqlite3MallocZero(64) = %p\n", zz); fflush(stdout);

    char attr_buf[256];
    int ar = pthread_mutexattr_init((char *)attr_buf);
    printf("[2.6a0c] pthread_mutexattr_init -> %d\n", ar); fflush(stdout);
    ar = pthread_mutexattr_settype((char *)attr_buf, 2);
    printf("[2.6a0d] pthread_mutexattr_settype -> %d\n", ar); fflush(stdout);
    char mutex_buf[256];
    ar = pthread_mutex_init((char *)mutex_buf, (char *)attr_buf);
    printf("[2.6a0e] pthread_mutex_init -> %d\n", ar); fflush(stdout);
    ar = pthread_mutexattr_destroy((char *)attr_buf);
    printf("[2.6a0f] pthread_mutexattr_destroy -> %d\n", ar); fflush(stdout);

    // Replicate pthreadMutexAlloc(1) inline to find which step
    // of "MallocZero + pthread mutex init" trips up.
    printf("[2.6m1] inline replication: malloc\n"); fflush(stdout);
    sqlite3_mutex *p = (sqlite3_mutex *)sqlite3MallocZero(64);
    printf("[2.6m2] p=%p\n", p); fflush(stdout);
    if (p) {
        pthread_mutexattr_t recursiveAttr;
        printf("[2.6m3] attr_init\n"); fflush(stdout);
        pthread_mutexattr_init(&recursiveAttr);
        printf("[2.6m4] attr_settype\n"); fflush(stdout);
        pthread_mutexattr_settype(&recursiveAttr, 2);
        printf("[2.6m5] mutex_init &p->mutex=%p &recursiveAttr=%p\n",
               &p->mutex, &recursiveAttr); fflush(stdout);
        pthread_mutex_init(&p->mutex, &recursiveAttr);
        printf("[2.6m6] attr_destroy\n"); fflush(stdout);
        pthread_mutexattr_destroy(&recursiveAttr);
        printf("[2.6m7] inline replication done, p=%p\n", p); fflush(stdout);
    }
    sqlite3Config.pInitMutex = p;
    printf("[2.6a1] pInitMutex (read) = %p\n", sqlite3Config.pInitMutex); fflush(stdout);
    printf("[2.6b] pInitMutex=%p\n", sqlite3Config.pInitMutex); fflush(stdout);
    sqlite3_mutex_enter(sqlite3Config.pInitMutex);
    printf("[2.6c] entered pInitMutex\n"); fflush(stdout);

    sqlite3Config.inProgress = 1;
    printf("[2.7a] inProgress=1, sizeof(sqlite3BuiltinFunctions)=%d\n",
           (int)sizeof(sqlite3BuiltinFunctions)); fflush(stdout);
    memset(&sqlite3BuiltinFunctions, 0, sizeof(sqlite3BuiltinFunctions));
    printf("[2.7b] memset ok\n"); fflush(stdout);

    sqlite3RegisterBuiltinFunctions();
    printf("[2.8] RegisterBuiltinFunctions ok\n"); fflush(stdout);

    int rc = sqlite3PcacheInitialize();
    printf("[2.9] sqlite3PcacheInitialize -> %d\n", rc); fflush(stdout);
    if (rc) return 1;
    sqlite3Config.isPCacheInit = 1;

    rc = sqlite3OsInit();
    printf("[2.10] sqlite3OsInit          -> %d\n", rc); fflush(stdout);
    if (rc) return 1;

    rc = sqlite3MemdbInit();
    printf("[2.11] sqlite3MemdbInit       -> %d\n", rc); fflush(stdout);
    if (rc) return 1;

    sqlite3Config.isInit = 1;
    sqlite3Config.inProgress = 0;
    sqlite3_mutex_leave(sqlite3Config.pInitMutex);
    printf("[2.12] init complete\n"); fflush(stdout);

    // Tier 3: open an in-memory db.
    sqlite3 *db;
    rc = sqlite3_open(":memory:", &db);
    printf("[3] sqlite3_open(\":memory:\") -> %d\n", rc);
    fflush(stdout);
    if (rc != 0) return 1;

    // Tier 4: actually run some SQL.
    char *errmsg = 0;
    printf("[3a] db->aLimit[1] (LENGTH) = %d\n", db->aLimit[1]);
    printf("[3b] db->aLimit[0] = %d\n", db->aLimit[0]);
    printf("[3c] sqlite3_limit(db, 0, -1) = %d\n", sqlite3_limit(db, 0, -1));
    printf("[3d] sqlite3_limit(db, 1, -1) = %d\n", sqlite3_limit(db, 1, -1));
    fflush(stdout);

    printf("[3e] sizeof(Parse)=%d\n", (int)sizeof(Parse));
    fflush(stdout);
    sqlite3_stmt *st = 0;
    const char *tail = 0;
    printf("[4a] calling sqlite3_prepare_v2\n"); fflush(stdout);
    rc = sqlite3_prepare_v2(db, "SELECT 1", 8, &st, &tail);
    printf("[4b] prepare(SELECT 1, 8) -> %d, tail=%p, st=%p\n", rc, tail, st);
    fflush(stdout);
    if (st) sqlite3_finalize(st);

    rc = sqlite3_exec(db, "SELECT 1;", 0, 0, &errmsg);
    printf("[4] SELECT 1 -> %d (errmsg=%s)\n", rc, errmsg ? errmsg : "<null>");
    if (errmsg) sqlite3_free(errmsg);
    fflush(stdout);
    fflush(stdout);
    if (rc != 0) return 1;

    // Tier 5: prepare + step a SELECT.
    sqlite3_stmt *stmt = 0;
    rc = sqlite3_prepare_v2(db, "SELECT k, v FROM t ORDER BY k;", -1, &stmt, 0);
    printf("[5] sqlite3_prepare_v2 -> %d\n", rc);
    fflush(stdout);
    if (rc != 0) return 1;

    while ((rc = sqlite3_step(stmt)) == 100) {  // SQLITE_ROW
        int k = sqlite3_column_int(stmt, 0);
        const unsigned char *v = sqlite3_column_text(stmt, 1);
        printf("    row: k=%d v=%s\n", k, v);
        fflush(stdout);
    }
    printf("[6] step done -> %d\n", rc);
    fflush(stdout);
    sqlite3_finalize(stmt);

    sqlite3_close(db);
    printf("[ok] sqlite3 closed\n");
    return 0;
}
