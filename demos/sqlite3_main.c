// Minimal sqlite3 driver. Append to sqlite3.c (the c5 preprocessor
// has no filesystem-relative `#include` support yet) before
// compiling:
//   cat demos/sqlite3/sqlite3.c demos/sqlite3_main.c > /tmp/combined.c
//   target/release/badc /tmp/combined.c
//
// Opens an in-memory database, runs a CREATE / INSERT / SELECT
// round-trip, prints the values back, then exercises ORDER BY,
// aggregates, and a WHERE-with-index lookup. End-to-end smoke
// test for the c5 compilation of the sqlite3 amalgamation.

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

    // Tier 4: trivial SELECT (no FROM clause).
    sqlite3_stmt *st = 0;
    const char *tail = 0;
    rc = sqlite3_prepare_v2(db, "SELECT 1", -1, &st, &tail);
    printf("[4] prepare(SELECT 1)           -> %d\n", rc); fflush(stdout);
    if (rc == 0 && st) {
        rc = sqlite3_step(st);
        if (rc == 100) printf("[5] col[0] = %d\n", sqlite3_column_int(st, 0));
        fflush(stdout);
        sqlite3_finalize(st);
    }

    // Tier 5: CREATE / INSERT / SELECT round-trip.
    char *err = 0;
    rc = sqlite3_exec(db, "CREATE TABLE t(a INTEGER, b TEXT)", 0, 0, &err);
    printf("[6] CREATE TABLE                -> %d\n", rc); fflush(stdout);
    if (rc != 0) { printf("    err: %s\n", err); sqlite3_free(err); }

    rc = sqlite3_exec(db,
        "INSERT INTO t VALUES (-7, 'world'), (42, 'hello'), (1234567, 'big')",
        0, 0, &err);
    printf("[7] INSERT 3 rows               -> %d\n", rc); fflush(stdout);
    if (rc != 0) { printf("    err: %s\n", err); sqlite3_free(err); }

    rc = sqlite3_prepare_v2(db, "SELECT a, b FROM t ORDER BY a", -1, &st, &tail);
    printf("[8] prepare ORDER BY            -> %d\n", rc); fflush(stdout);
    if (rc == 0 && st) {
        int row = 0;
        while ((rc = sqlite3_step(st)) == 100) {
            int a = sqlite3_column_int(st, 0);
            const unsigned char *b = sqlite3_column_text(st, 1);
            printf("    row %d: a=%d b=%s\n", row++, a, b);
        }
        fflush(stdout);
        sqlite3_finalize(st);
    }

    // Tier 6: aggregates, indexes, WHERE.
    rc = sqlite3_prepare_v2(db,
        "SELECT COUNT(*), MIN(a), MAX(a), SUM(a) FROM t WHERE a > 0",
        -1, &st, &tail);
    printf("[9] prepare aggregates          -> %d\n", rc); fflush(stdout);
    if (rc == 0 && st) {
        if (sqlite3_step(st) == 100) {
            printf("    count=%d min=%d max=%d sum=%d\n",
                sqlite3_column_int(st, 0), sqlite3_column_int(st, 1),
                sqlite3_column_int(st, 2), sqlite3_column_int(st, 3));
            fflush(stdout);
        }
        sqlite3_finalize(st);
    }

    rc = sqlite3_exec(db, "CREATE INDEX ix ON t(b)", 0, 0, &err);
    printf("[10] CREATE INDEX               -> %d\n", rc); fflush(stdout);
    if (rc != 0) { printf("    err: %s\n", err); sqlite3_free(err); }

    rc = sqlite3_prepare_v2(db, "SELECT a FROM t WHERE b = 'hello'", -1, &st, &tail);
    printf("[11] prepare WHERE b='hello'    -> %d\n", rc); fflush(stdout);
    if (rc == 0 && st) {
        if (sqlite3_step(st) == 100) {
            printf("    a=%d\n", sqlite3_column_int(st, 0)); fflush(stdout);
        }
        sqlite3_finalize(st);
    }

    sqlite3_close(db);
    printf("[ok] sqlite3 closed\n");
    return 0;
}
