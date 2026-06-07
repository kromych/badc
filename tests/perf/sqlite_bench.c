// A multi-phase in-memory SQLite workload for the perf harness: bulk
// insert, aggregation, sorting, index creation and lookup, joins,
// subqueries, update / delete, and a second populated table. The hot
// path is the bytecode engine (VDBE), the B-tree, the sorter, and the
// page cache, all serviced from the in-memory pager so the wall-clock
// reflects compiled code rather than disk I/O. Self-times via
// clock_gettime and prints "in N ms".
//
// The statements come from a published compiler-comparison benchmark
// driven through the sqlite3 CLI shell. The shell-only directives
// (`.timer on`, `.quit`) and the leading comments are dropped here: the
// fixture drives the SQL through sqlite3_exec and times the whole batch
// itself. Phases that depend on randomblob feed only output that the
// fixture does not check, so the row-count guards below stay
// deterministic.
//
// The SQLite amalgamation is included directly so the fixture is a
// single translation unit. The harness puts demos/sqlite3 on the
// include search path and passes the feature knobs the amalgamation
// needs to parse without the headers badc does not ship.
#include <stdint.h>
#include <stdio.h>
#include <time.h>

#include "sqlite3.c"

// The full benchmark batch. sqlite3_exec runs the semicolon-separated
// statements in order; the `--` section markers are SQL line comments.
static const char *BENCH_SQL =
    "CREATE TABLE test1(a INTEGER PRIMARY KEY, b TEXT, c REAL, d INTEGER);\n"
    "BEGIN;\n"
    "WITH RECURSIVE cnt(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM cnt WHERE x<100000)\n"
    "INSERT INTO test1 SELECT x, 'text_value_' || x, x * 1.5, x % 1000 FROM cnt;\n"
    "COMMIT;\n"

    "SELECT COUNT(*), SUM(c), AVG(c), MIN(c), MAX(c) FROM test1;\n"
    "SELECT d, COUNT(*), AVG(c) FROM test1 GROUP BY d ORDER BY COUNT(*) DESC LIMIT 20;\n"
    "SELECT d, SUM(c), AVG(a) FROM test1 GROUP BY d HAVING SUM(c) > 10000;\n"

    "SELECT a, b, c FROM test1 ORDER BY c DESC LIMIT 100;\n"
    "SELECT a, b, c FROM test1 ORDER BY b LIMIT 100;\n"
    "SELECT a, b FROM test1 ORDER BY c ASC, a DESC LIMIT 100;\n"

    "CREATE INDEX idx_test1_b ON test1(b);\n"
    "CREATE INDEX idx_test1_c ON test1(c);\n"
    "CREATE INDEX idx_test1_d ON test1(d);\n"
    "SELECT COUNT(*) FROM test1 WHERE b LIKE 'text_value_5%';\n"
    "SELECT * FROM test1 WHERE c BETWEEN 1000.0 AND 2000.0 LIMIT 10;\n"
    "SELECT * FROM test1 WHERE d = 500;\n"

    "CREATE TABLE test2 AS SELECT a, 'copy_' || b as b2, c * 2 as c2 FROM test1 WHERE a % 10 = 0;\n"
    "SELECT COUNT(*) FROM test1 INNER JOIN test2 ON test1.a = test2.a;\n"
    "SELECT t1.a, t1.b, t2.b2 FROM test1 t1 JOIN test2 t2 ON t1.a = t2.a WHERE t1.c > 50000 LIMIT 20;\n"

    "SELECT COUNT(*) FROM test1 WHERE a IN (SELECT a FROM test2);\n"
    "SELECT * FROM test1 WHERE c > (SELECT AVG(c2) FROM test2) LIMIT 10;\n"
    "SELECT a, b, c FROM test1 WHERE a NOT IN (SELECT a FROM test2) AND d < 100 LIMIT 10;\n"

    "BEGIN;\n"
    "UPDATE test1 SET c = c * 2 WHERE a % 3 = 0;\n"
    "COMMIT;\n"
    "BEGIN;\n"
    "UPDATE test1 SET b = 'updated_' || b WHERE d < 50;\n"
    "COMMIT;\n"
    "BEGIN;\n"
    "DELETE FROM test1 WHERE a % 7 = 0;\n"
    "COMMIT;\n"

    "SELECT d % 100 as bucket, COUNT(*), SUM(c), AVG(c), MIN(a), MAX(a)\n"
    "FROM test1 GROUP BY d % 100 ORDER BY SUM(c) DESC LIMIT 20;\n"

    "CREATE TABLE test3(id INTEGER PRIMARY KEY, val TEXT, num REAL);\n"
    "BEGIN;\n"
    "WITH RECURSIVE cnt(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM cnt WHERE x<50000)\n"
    "INSERT INTO test3 SELECT x, hex(randomblob(8)), (x * 7 % 1000) * 0.01 FROM cnt;\n"
    "COMMIT;\n"
    "SELECT t1.a, t3.val FROM test1 t1 JOIN test3 t3 ON (t1.a % 50000 + 1) = t3.id LIMIT 100;\n"
    "SELECT num, COUNT(*) FROM test3 GROUP BY CAST(num * 10 AS INTEGER) ORDER BY COUNT(*) DESC LIMIT 20;\n";

// A single scalar query, returning the first column of the first row.
static long long scalar(sqlite3 *db, const char *sql, int *ok) {
    sqlite3_stmt *q;
    if (sqlite3_prepare_v2(db, sql, -1, &q, NULL) != SQLITE_OK) {
        *ok = 0;
        return 0;
    }
    long long v = 0;
    if (sqlite3_step(q) == SQLITE_ROW) {
        v = sqlite3_column_int64(q, 0);
    } else {
        *ok = 0;
    }
    sqlite3_finalize(q);
    return v;
}

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

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);

    char *err = NULL;
    if (sqlite3_exec(db, BENCH_SQL, NULL, NULL, &err) != SQLITE_OK) {
        fprintf(stderr, "sqlite_bench: exec failed: %s\n", err ? err : "?");
        return 2;
    }

    // Deterministic correctness guards. The bulk insert loads rows
    // 1..100000; the delete removes every seventh, leaving
    // 100000 - floor(100000/7) = 85715. A wrong count means the B-tree
    // or the row-update loop miscompiled, so fail rather than report a
    // fast time for work that did not happen.
    int ok = 1;
    long long after_delete = scalar(db, "SELECT COUNT(*) FROM test1;", &ok);
    long long test2_rows = scalar(db, "SELECT COUNT(*) FROM test2;", &ok);
    long long test3_rows = scalar(db, "SELECT COUNT(*) FROM test3;", &ok);

    clock_gettime(CLOCK_MONOTONIC, &t1);
    sqlite3_close(db);

    if (!ok || after_delete != 85715 || test2_rows != 10000 || test3_rows != 50000) {
        fprintf(stderr,
                "sqlite_bench: result check failed: test1=%lld (want 85715), "
                "test2=%lld (want 10000), test3=%lld (want 50000)\n",
                after_delete, test2_rows, test3_rows);
        return 7;
    }

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("sqlite_bench test1=%lld test2=%lld test3=%lld in %.2f ms\n",
           after_delete, test2_rows, test3_rows, ms);
    return 0;
}
