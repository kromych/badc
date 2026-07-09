/* nasm launcher that feeds the assembler forward-slash paths (native Windows).
 *
 * nasm-t.py joins the source and output paths with `os.sep`, which is `\` on
 * Windows; nasm echoes that path verbatim into every artifact it produces --
 * the `%line` directives on stdout, the `file:line:` prefix on stderr, and the
 * source-name records inside object output (OMF THEADR, ELF STT_FILE, ...). The
 * golden suite was recorded on a POSIX host, so those paths carry `/`. Rewrite
 * the separator in the command-line arguments before invoking nasm so its
 * output matches the goldens on all targets; Windows accepts `/` in paths, and
 * on POSIX there is nothing to rewrite. The real nasm is named by $NASM_REAL.
 *
 * This keeps the vendored harness and its goldens byte-for-byte upstream: the
 * separator is corrected at the one boundary the demo owns, the nasm it runs. */
#include <process.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    const char *real = getenv("NASM_REAL");
    if (!real) {
        fprintf(stderr, "nasmw: NASM_REAL is not set\n");
        return 127;
    }
    for (int i = 1; i < argc; i++)
        for (char *p = argv[i]; *p; p++)
            if (*p == '\\')
                *p = '/';
    argv[0] = (char *)real;
    int rc = _spawnv(_P_WAIT, (char *)real, argv);
    if (rc < 0) {
        perror("nasmw: spawn");
        return 126;
    }
    return rc;
}
