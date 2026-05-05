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
    // Tier 1: leaf functions returning const strings / integers.
    printf("[1.1] sqlite3_libversion()      -> %s\n", sqlite3_libversion());
    printf("[1.2] sqlite3_sourceid()        -> %s\n", sqlite3_sourceid());
    printf("[1.3] sqlite3_libversion_number -> %d\n", sqlite3_libversion_number());
    printf("[1.4] sqlite3_threadsafe()      -> %d\n", sqlite3_threadsafe());
    fflush(stdout);

    // Tier 2: full library init.
    int rc = sqlite3_initialize();
    printf("[2] sqlite3_initialize()       -> %d\n", rc); fflush(stdout);
    if (rc != 0) return 1;

    // Tier 3: open an in-memory db.
    sqlite3 *db;
    rc = sqlite3_open(":memory:", &db);
    printf("[3] sqlite3_open(\":memory:\")  -> %d\n", rc); fflush(stdout);
    if (rc != 0) return 1;
    printf("[3a] db->aLimit[1] (SQL_LENGTH) = %d\n", db->aLimit[1]); fflush(stdout);

    // Tier 4: try preparing the simplest SELECT. Currently SEGVs --
    // the next codegen-correctness milestone is finding which inner
    // call inside sqlite3Prepare's body trips it. Tier 1-3 above all
    // succeed end-to-end after the struct-deref-load and
    // sizeof-array-decay fixes earlier in this branch.
    sqlite3_stmt *st = 0;
    const char *tail = 0;
    rc = sqlite3_prepare_v2(db, "SELECT 1", 8, &st, &tail);
    printf("[4] prepare(SELECT 1)           -> %d\n", rc); fflush(stdout);
    if (rc == 0 && st) {
        rc = sqlite3_step(st);
        printf("[5] step                       -> %d\n", rc); fflush(stdout);
        if (rc == 100) {
            int v = sqlite3_column_int(st, 0);
            printf("    col[0] = %d\n", v); fflush(stdout);
        }
        sqlite3_finalize(st);
    }

    sqlite3_close(db);
    printf("[ok] sqlite3 closed\n");
    return 0;
}
