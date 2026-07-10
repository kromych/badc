/* fcntl(fd, F_SETLK, &fl) through a real-world dispatch table: the
   cast supplies the variadic prototype, so the struct-address tail
   must reach libc per the host variadic convention. Verified by the
   kernel's return codes. */
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

typedef void (*syscall_ptr)(void);
static syscall_ptr table[1] = { (syscall_ptr)fcntl };
#define fcntl_fn ((int (*)(int, int, ...))table[0])

int main(void) {
    char path[64];
    snprintf(path, sizeof path, "/tmp/badc_fcntl_%d", (int)getpid());
    int fd = open(path, O_RDWR | O_CREAT, 0644);
    if (fd < 0) {
        return 3;
    }
    struct flock fl;
    memset(&fl, 0, sizeof fl);
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_SET;
    int direct = fcntl(fd, F_SETLK, &fl);
    fl.l_type = F_UNLCK;
    int unlock = fcntl(fd, F_SETLK, &fl);
    fl.l_type = F_WRLCK;
    int viaptr = fcntl_fn(fd, F_SETLK, &fl);
    close(fd);
    unlink(path);
    if (direct != 0 || unlock != 0) {
        return 2;
    }
    return viaptr == 0 ? 0 : 1;
}
