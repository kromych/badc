// <nl_types.h>: a catalog gencat builds from a message source opens by
// path, catgets returns each message of a set and the default string for an
// absent one, and catclose returns 0. Without gencat on the host there is
// no catalog to read and the fixture returns 0.
// snapshot-budget: exempt
#include <nl_types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(void) {
    char dir[] = "/tmp/badc-nlcat-XXXXXX";
    char src[64], cat[64], cmd[192];
    const char *s;
    FILE *f;
    nl_catd catd;
    int rc = 0;

    if (NL_SETD != 1 || NL_CAT_LOCALE != 1) return 1;
    if (system("command -v gencat >/dev/null 2>&1") != 0) return 0;
    if (!mkdtemp(dir)) return 2;
    snprintf(src, sizeof src, "%s/in.msg", dir);
    snprintf(cat, sizeof cat, "%s/out.cat", dir);
    if (!(f = fopen(src, "w"))) return 3;
    fputs("$set 1\n1 first message\n2 second message\n$set 7\n3 seventh set\n", f);
    fclose(f);
    snprintf(cmd, sizeof cmd, "gencat %s %s", cat, src);
    if (system(cmd) != 0) rc = 4;
    if (!rc && (catd = catopen(cat, NL_CAT_LOCALE)) == (nl_catd)-1) rc = 5;
    if (!rc) {
        s = catgets(catd, 1, 2, "absent");
        if (strcmp(s, "second message") != 0) rc = 6;
        s = catgets(catd, 7, 3, "absent");
        if (!rc && strcmp(s, "seventh set") != 0) rc = 7;
        s = catgets(catd, 1, 9, "absent");
        if (!rc && strcmp(s, "absent") != 0) rc = 8;
        if (catclose(catd) != 0 && !rc) rc = 9;
    }
    unlink(cat);
    unlink(src);
    rmdir(dir);
    return rc;
}
