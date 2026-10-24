// IPV6_V6ONLY is the platform's IPPROTO_IPV6 option number (RFC 3493
// section 5.3): an IPv6 socket accepts it, clear and set, and reads each
// back. A host without IPv6 sockets has nothing to check.
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#ifdef __linux__
#define WANT_V6ONLY 26
#else
#define WANT_V6ONLY 27
#endif

int main(void) {
    int off = 0, on = 1, got = -1, s;
    socklen_t len = sizeof got;

    if (IPV6_V6ONLY != WANT_V6ONLY) return 1;
    s = socket(AF_INET6, SOCK_STREAM, 0);
    if (s < 0) return 0;
    if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &off, sizeof off) != 0) return 2;
    if (getsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &got, &len) != 0 || got != 0) return 3;
    if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &on, sizeof on) != 0) return 4;
    len = sizeof got;
    if (getsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &got, &len) != 0 || got == 0) return 5;
    close(s);
    return 0;
}
