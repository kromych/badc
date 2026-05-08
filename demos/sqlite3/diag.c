/*
** Minimal sqlite3 driver with stderr tracing -- a "shell shim" we
** can compile alongside sqlite3.c (just like shell.c is) to bisect
** runtime issues on platforms where shell.c emits empty output.
**
** Reads SQL from stdin (one statement per "split-by-semicolon"
** chunk -- not a full parser, just enough for the smoke commands),
** sqlite3_exec()s each, prints rows to stdout, and emits a
** stderr checkpoint for every step. The smoke driver pipes
** identical commands to shell.c and to this program; if diag.c
** prints rows but shell.c does not, the issue is shell.c-specific
** (stdio binding, isatty, line buffering, ...). If diag.c also
** prints nothing, the issue is below shell.c -- prepare / step /
** stdout.
**
** Compiled by `setup.sh` / `smoke.sh` only when the
** BADC_BUILD_DIAG env var is set so the regular smoke flow stays
** unaffected.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "sqlite3.h"

/* Bypass stdio so a raw kernel-write checkpoint fires even if the
** lazy `__c5_lazy_stream` resolver hasn't run / has the wrong
** address. write(2, ..., n) hits msvcrt's `_write` directly via
** the c5 IAT trampoline -- no FILE * indirection, no setvbuf
** state. If the binary loads at all, this prints. */
#define BLAM(MSG)                                          \
    do {                                                    \
        const char *__m = (MSG);                            \
        int __n = 0;                                        \
        while (__m[__n]) __n++;                             \
        write(2, (char *)__m, __n);                         \
    } while (0)

/* Single-row callback: emit `col0|col1|...` to stdout exactly the
** way `sqlite3` shell's default "list" mode does, so the smoke
** diff bytes line up with shell.c output. */
static int diag_row_cb(void *unused, int n, char **vals, char **cols) {
    int i;
    for (i = 0; i < n; i++) {
        if (i) fputc('|', stdout);
        fputs(vals[i] ? vals[i] : "", stdout);
    }
    fputc('\n', stdout);
    return 0;
}

int main(int argc, char **argv) {
    int rc;
    int n;
    int c;
    char *sql;
    char *out;
    char *p;
    sqlite3 *db;
    char *errmsg;

    /* Raw write(2) checkpoint -- runs even if stdio isn't set up.
    ** If this prints but `[diag] enter` doesn't, fprintf / stderr
    ** is broken on this platform. If neither prints, main never
    ** ran (loader / pre-main-stub problem). */
    BLAM("BLAM: write(2) reached main\n");

    fprintf(stderr, "[diag] enter argc=%d\n", argc); fflush(stderr);

    rc = sqlite3_initialize();
    fprintf(stderr, "[diag] sqlite3_initialize rc=%d\n", rc); fflush(stderr);
    if (rc) return 11;

    db = 0;
    rc = sqlite3_open(":memory:", &db);
    fprintf(stderr, "[diag] sqlite3_open rc=%d db=%p\n", rc, (void *)db); fflush(stderr);
    if (rc) return 12;

    /* Read all of stdin into a heap buffer. The smoke commands are
    ** small (a few KB at most); we don't bother streaming. */
    sql = (char *)malloc(65536);
    if (!sql) return 13;
    n = 0;
    while ((c = fgetc(stdin)) != EOF && n < 65535) {
        sql[n++] = (char)c;
    }
    sql[n] = 0;
    fprintf(stderr, "[diag] read %d bytes from stdin\n", n); fflush(stderr);

    /* Strip lines that begin with `.` (dot-commands aren't sqlite
    ** SQL; the shell parses them out). The smoke runs always end
    ** with `.quit`, so we drop the trailing line(s) below. */
    out = sql;
    p = sql;
    while (*p) {
        char *line_start = p;
        char saved;
        while (*p && *p != '\n') p++;
        saved = *p;
        if (saved == '\n') *p = 0;
        if (line_start[0] != '.') {
            int len = (int)(p - line_start);
            memmove(out, line_start, len);
            out += len;
            *out++ = '\n';
        }
        if (saved == '\n') *p++ = '\n';
    }
    *out = 0;
    fprintf(stderr, "[diag] post-strip %d bytes\n", (int)(out - sql)); fflush(stderr);

    errmsg = 0;
    rc = sqlite3_exec(db, sql, diag_row_cb, 0, &errmsg);
    fprintf(stderr, "[diag] sqlite3_exec rc=%d errmsg=%s\n",
            rc, errmsg ? errmsg : "(null)"); fflush(stderr);

    sqlite3_free(errmsg);
    free(sql);
    sqlite3_close(db);
    fprintf(stderr, "[diag] done\n"); fflush(stderr);
    return rc ? 14 : 0;
}
