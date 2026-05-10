#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdio.h>

// `struct stat` is a write-target for libc's `stat` family.
// c5 stores `int` as 4 bytes, so the original 18-int
// declaration was 72 bytes -- libc's actual `struct stat`
// (96-144 bytes depending on platform) walked off the end
// and stomped the saved frame pointer / link register on
// the stack. The function would dutifully `return 42` and
// then SIGBUS on the way out when `ret` jumped to a
// garbage LR.
//
// The fixture proves the buffer-overflow regression has not
// returned: call `stat()` on `/tmp` (always writable, always
// exists, layout-compatible across macOS / Linux), check
// the return code, then return 42 from main. If `struct stat`
// is too small for the platform's actual layout the saved
// frame pointer gets clobbered and the post-`return 42`
// epilogue crashes with SIGBUS.

int main(void) {
    struct stat buf;
    int rc = stat("/tmp", (char *)&buf);
    if (rc != 0) { printf("stat /tmp failed: rc=%d\n", rc); return 1; }
    return 42;
}
