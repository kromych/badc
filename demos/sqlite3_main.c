// Minimal sqlite3 driver. Append to sqlite3.c (the c5 preprocessor
// has no filesystem-relative `#include` support yet) before
// compiling:
//   cat demos/sqlite3/sqlite3.c demos/sqlite3_main.c > /tmp/combined.c
//   target/release/badc /tmp/combined.c
//
// Opens an in-memory database, prints a confirmation, closes it.
// The first end-to-end smoke test for the c5 compilation of the
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

    void *p = sqlite3_malloc(64);
    printf("[2.6] sqlite3_malloc(64)      -> %p\n", p);
    fflush(stdout);
    if (p == 0) return 1;
    sqlite3_free(p);
    printf("[2.7] sqlite3_free ok\n");
    fflush(stdout);

    int rc = sqlite3PCacheInitialize();
    printf("[2.8] sqlite3PCacheInitialize -> %d\n", rc);
    fflush(stdout);

    rc = sqlite3OsInit();
    printf("[2.9] sqlite3OsInit()         -> %d\n", rc);
    fflush(stdout);

    rc = sqlite3_initialize();
    printf("[2.10] sqlite3_initialize()   -> %d\n", rc);
    fflush(stdout);
    if (rc != 0) return 1;

    // Tier 3: open an in-memory db.
    sqlite3 *db;
    rc = sqlite3_open(":memory:", &db);
    printf("[3] sqlite3_open(\":memory:\") -> %d\n", rc);
    fflush(stdout);
    if (rc != 0) return 1;

    sqlite3_close(db);
    printf("[ok] sqlite3 closed\n");
    return 0;
}
