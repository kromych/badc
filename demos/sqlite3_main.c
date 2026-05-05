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
    sqlite3 *db;
    int rc;

    rc = sqlite3_open(":memory:", &db);
    if (rc) {
        printf("open failed: %d\n", rc);
        return 1;
    }
    printf("opened in-memory db\n");

    sqlite3_close(db);
    return 0;
}
