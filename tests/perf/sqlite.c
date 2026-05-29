// In-memory database workload for the perf harness: a batch of INSERTs
// into an in-memory SQLite table inside one transaction, followed by an
// aggregate query. The hot path is the bytecode engine (VDBE), the
// B-tree, and the page cache, all serviced from the in-memory pager so
// the wall-clock reflects compiled code rather than disk I/O. Self-
// times via clock_gettime and prints "in N ms".
//
// The SQLite amalgamation is included directly so the fixture is a
// single translation unit. The harness puts demos/sqlite3 on the
// include search path and passes the feature knobs the amalgamation
// needs to parse without the headers badc does not ship.
#include <stdint.h>
#include <stdio.h>
#include <time.h>

#include "sqlite3.c"

#define ROWS 30000

int main(void) {
    // The harness builds with SQLITE_OMIT_AUTOINIT, so the library must
    // be initialized explicitly before the first sqlite3_open.
    if (sqlite3_initialize() != SQLITE_OK) {
        return 6;
    }
    sqlite3 *db;
    if (sqlite3_open(":memory:", &db) != SQLITE_OK) {
        return 1;
    }
    char *err = NULL;
    if (sqlite3_exec(db, "CREATE TABLE t(k INTEGER PRIMARY KEY, v INTEGER);",
                     NULL, NULL, &err) != SQLITE_OK) {
        return 2;
    }

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);

    sqlite3_exec(db, "BEGIN;", NULL, NULL, &err);
    sqlite3_stmt *ins;
    if (sqlite3_prepare_v2(db, "INSERT INTO t(k, v) VALUES(?, ?);", -1, &ins,
                           NULL) != SQLITE_OK) {
        return 3;
    }
    for (int i = 0; i < ROWS; i++) {
        sqlite3_bind_int(ins, 1, i);
        sqlite3_bind_int(ins, 2, (int)((unsigned)(i * 2654435761u) >> 16));
        sqlite3_step(ins);
        sqlite3_reset(ins);
    }
    sqlite3_finalize(ins);
    sqlite3_exec(db, "COMMIT;", NULL, NULL, &err);

    sqlite3_stmt *q;
    if (sqlite3_prepare_v2(db, "SELECT count(*), sum(v) FROM t WHERE v > 20000;",
                           -1, &q, NULL) != SQLITE_OK) {
        return 4;
    }
    long long cnt = 0, sum = 0;
    if (sqlite3_step(q) == SQLITE_ROW) {
        cnt = sqlite3_column_int64(q, 0);
        sum = sqlite3_column_int64(q, 1);
    }
    sqlite3_finalize(q);

    clock_gettime(CLOCK_MONOTONIC, &t1);
    sqlite3_close(db);

    // The hash distributes v across [0, 65535], so a sizable fraction
    // clears the predicate. A zero count means the rows never persisted
    // (a miscompiled pager or B-tree), so fail rather than report a
    // misleadingly fast time for work that did not happen.
    if (cnt <= 0 || sum <= 0) {
        return 7;
    }

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("sqlite rows=%d cnt=%lld sum=%lld in %.2f ms\n", ROWS, cnt, sum, ms);
    return 0;
}
