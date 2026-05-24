#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
typedef int (*sys_ptr)();
static sys_ptr aSyscall[] = { (sys_ptr)fcntl };
int main(void) {
    int (*osFcntl)(int, int, ...) = (int(*)(int,int,...))aSyscall[0];
    int fd = open("/tmp/fcntl_lock.tmp", O_RDWR | O_CREAT, 0644);
    if (fd < 0) return 1;
    struct flock fl;
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_SET;
    fl.l_start = 0;
    fl.l_len = 0;
    if (osFcntl(fd, F_SETLK, &fl) != 0) return 2;
    close(fd);
    return 0;
}
