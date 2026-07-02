// Darwin declares shm_open variadic and fetches the mode via va_arg
// (from the stack on arm64); a caller compiled against a fixed-arity
// prototype leaves that slot unwritten and the object is created with
// garbage permission bits. Create with 0600 and read the mode back.

#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main(void) {
    char name[64];
    struct stat st;
    int fd;
    int rc = 0;
    sprintf(name, "/badc_shm_%d", getpid());
    shm_unlink(name);
    fd = shm_open(name, O_CREAT | O_EXCL | O_RDWR, 0600);
    if (fd < 0) {
        return 1;
    }
    if (fstat(fd, (char *)&st) != 0) {
        rc = 2;
    } else if ((st.st_mode & 0777) != 0600) {
        rc = 3;
    }
    close(fd);
    shm_unlink(name);
    return rc;
}
