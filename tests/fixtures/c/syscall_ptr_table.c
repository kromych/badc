#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
typedef int (*sys_ptr)();
static sys_ptr syscall_ptrs[] = {
    (sys_ptr)open,
    (sys_ptr)close,
    (sys_ptr)fcntl,
    (sys_ptr)stat,
    (sys_ptr)fstat,
    (sys_ptr)ftruncate,
};
int main(void) {
    int (*open_fn)(const char *, int, int) = (int(*)(const char*,int,int))syscall_ptrs[0];
    int (*close_fn)(int) = (int(*)(int))syscall_ptrs[1];
    int (*fcntl_fn)(int, int, ...) = (int(*)(int,int,...))syscall_ptrs[2];
    int (*stat_fn)(const char *, struct stat *) = (int(*)(const char*, struct stat*))syscall_ptrs[3];
    int (*fstat_fn)(int, struct stat *) = (int(*)(int, struct stat*))syscall_ptrs[4];
    int (*ftruncate_fn)(int, off_t) = (int(*)(int, off_t))syscall_ptrs[5];
    
    int fd = open_fn("/tmp/syscall_ptr_table.db", O_RDWR | O_CREAT, 0644);
    if (fd < 0) return 1;
    if (ftruncate_fn(fd, 1024) != 0) return 2;
    struct stat st;
    if (fstat_fn(fd, &st) != 0) return 3;
    if (fcntl_fn(fd, F_SETFD, 1) != 0) return 4;
    close_fn(fd);
    return 0;
}
