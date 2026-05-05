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
    // The smallest sqlite call that touches no allocator / VFS
    // state -- it returns the static `sqlite3_version[]` array's
    // address. If this prints the right string, address-of-global,
    // string-pointer return, and printf("%s") all work end-to-end.
    const char *ver = sqlite3_libversion();
    printf("sqlite3_libversion() -> %s\n", ver);

    // The tiny extra step: get the source-id, also a const string.
    const char *sid = sqlite3_sourceid();
    printf("sqlite3_sourceid()   -> %s\n", sid);

    sqlite3 *db;
    int rc = sqlite3_open(":memory:", &db);
    if (rc) {
        printf("open failed: %d\n", rc);
        return 1;
    }
    printf("opened in-memory db\n");

    sqlite3_close(db);
    return 0;
}
