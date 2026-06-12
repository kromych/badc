// The POSIX OS surface interactive programs reach for: gettimeofday
// (<sys/time.h>), poll (<poll.h>), and the terminal-attribute /
// window-size queries (<termios.h>, <sys/ioctl.h>). gettimeofday and a
// poll over a primed pipe are deterministic; tcgetattr / ioctl run
// against stdin, which need not be a terminal, so their result is not
// asserted -- the call exercises the binding and the struct layout.
// Windows has none of these (its console API lives in <windows.h>).

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <poll.h>
#include <sys/time.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

int main(void) {
    struct timeval tv;
    if (gettimeofday(&tv, 0)) return 1;
    if (tv.tv_sec < 1700000000L) return 2; // sanity: after 2023-11-14

    int fds[2];
    if (pipe(fds)) return 3;
    if (write(fds[1], "x", 1) != 1) return 4;
    struct pollfd pf;
    pf.fd = fds[0];
    pf.events = POLLIN;
    pf.revents = 0;
    int r = poll(&pf, 1, 1000);
    if (r != 1) return 5;
    if (!(pf.revents & POLLIN)) return 6;
    close(fds[0]);
    close(fds[1]);

    // Link + struct-layout check; stdin may not be a terminal.
    struct termios t;
    tcgetattr(0, &t);
    struct winsize ws;
    ioctl(0, TIOCGWINSZ, &ws);
    return 0;
}
#endif
