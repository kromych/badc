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

    // Tier 2: library init -- touches mutex / config / malloc.
    int rc = sqlite3_initialize();
    printf("[2] sqlite3_initialize()      -> %d\n", rc);
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
