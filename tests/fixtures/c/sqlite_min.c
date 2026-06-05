#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
typedef int (*sys_ptr)();
static sys_ptr aSyscall[] = {
    (sys_ptr)open,
    (sys_ptr)close,
    (sys_ptr)fcntl,
    (sys_ptr)stat,
    (sys_ptr)fstat,
    (sys_ptr)ftruncate,
};
int main(void) {
    int (*osOpen)(const char *, int, int) = (int(*)(const char*,int,int))aSyscall[0];
    int (*osClose)(int) = (int(*)(int))aSyscall[1];
    int (*osFcntl)(int, int, ...) = (int(*)(int,int,...))aSyscall[2];
    int (*osStat)(const char *, struct stat *) = (int(*)(const char*, struct stat*))aSyscall[3];
    int (*osFstat)(int, struct stat *) = (int(*)(int, struct stat*))aSyscall[4];
    int (*osFtruncate)(int, off_t) = (int(*)(int, off_t))aSyscall[5];
    
    int fd = osOpen("/tmp/sqlite_min.db", O_RDWR | O_CREAT, 0644);
    if (fd < 0) return 1;
    if (osFtruncate(fd, 1024) != 0) return 2;
    struct stat st;
    if (osFstat(fd, &st) != 0) return 3;
    if (osFcntl(fd, F_SETFD, 1) != 0) return 4;
    osClose(fd);
    return 0;
}
