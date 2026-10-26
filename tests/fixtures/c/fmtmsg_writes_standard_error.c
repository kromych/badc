// <fmtmsg.h>: fmtmsg with MM_PRINT writes the label, severity and text and
// the action and tag line to standard error and returns MM_OK. glibc puts
// two blanks before the tag and leaves out a null action's line; libSystem
// puts one and prints the line empty. Standard error goes to a file for the
// two calls and comes back after.
// snapshot-budget: exempt
#include <fcntl.h>
#include <fmtmsg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifdef __APPLE__
#define TAG_LINE "TO FIX: the action badc:tag:1\n"
#define BARE "INFO: only text\nTO FIX: \n"
#else
#define TAG_LINE "TO FIX: the action  badc:tag:1\n"
#define BARE "INFO: only text\n"
#endif

int main(void) {
    char path[] = "/tmp/badc-fmtmsg-XXXXXX";
    const char *want = "badc:fmtmsg: ERROR: the text\n" TAG_LINE BARE;
    char got[256];
    int fd = mkstemp(path), saved, r1, r2;
    ssize_t n;

    if (fd < 0) return 1;
    unsetenv("MSGVERB");
    fflush(stderr);
    saved = dup(2);
    dup2(fd, 2);
    r1 = fmtmsg(MM_PRINT | MM_SOFT | MM_APPL | MM_RECOVER, "badc:fmtmsg", MM_ERROR, "the text",
                "the action", "badc:tag:1");
    r2 = fmtmsg(MM_PRINT, MM_NULLLBL, MM_INFO, "only text", MM_NULLACT, MM_NULLTAG);
    fflush(stderr);
    dup2(saved, 2);
    close(saved);
    n = pread(fd, got, sizeof got - 1, 0);
    close(fd);
    unlink(path);
    if (r1 != MM_OK || r2 != MM_OK) return 2;
    if (n < 0) return 3;
    got[n] = 0;
    return strcmp(got, want) != 0 ? 4 : 0;
}
