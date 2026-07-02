// POSIX (XSH) declares ioctl variadic and both target libcs read the
// argument via va_arg -- on Darwin arm64 from the stack, so a caller
// compiled against a fixed-arity prototype passes the pointer where
// the callee does not look and FIONREAD faults with EFAULT. A pipe
// holding 5 unread bytes must report 5.

#include <sys/ioctl.h>
#include <unistd.h>

int main(void) {
    int fds[2];
    int n = 0;
    if (pipe(fds) != 0) {
        return 1;
    }
    if (write(fds[1], "hello", 5) != 5) {
        return 2;
    }
    if (ioctl(fds[0], FIONREAD, &n) != 0) {
        return 3;
    }
    if (n != 5) {
        return 4;
    }
    close(fds[0]);
    close(fds[1]);
    return 0;
}
