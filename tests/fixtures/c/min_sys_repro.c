#include <stdlib.h>
#include <unistd.h>
typedef int (*sys_ptr)();
static sys_ptr calls[] = { (sys_ptr)open };
int main(void) {
    int (*opn)(char *, int, int) = (int(*)(char *, int, int))calls[0];
    int fd = opn("/etc/hosts", 0, 0);
    return fd < 0 ? 2 : 42;
}
