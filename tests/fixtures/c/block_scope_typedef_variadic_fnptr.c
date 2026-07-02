/* A block-scope `typedef RET (*NAME)(args, ...)` must carry the pointee
   prototype onto variables declared through it, so an indirect call
   routes the variadic tail per the host ABI. */
#include <stdio.h>
#include <string.h>

int main(void) {
    char buf[64];
    typedef int (*psn)(char *, unsigned long, const char *, ...);
    static psn sn = snprintf;
    buf[0] = 0;
    sn(buf, sizeof buf, "%d %s", 7, "tail");
    if (strcmp(buf, "7 tail") != 0) {
        return 1;
    }
    return 0;
}
