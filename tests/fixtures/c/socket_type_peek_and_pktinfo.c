// POSIX socket options and flags with the platform's values: SO_TYPE reads
// back the socket's type, MSG_PEEK leaves the data queued, EPROTO is the
// C library's number. On Linux an IP_PKTINFO datagram over loopback carries
// a struct in_pktinfo naming 127.0.0.1, and IPV6_RECVPKTINFO is accepted.
#define _GNU_SOURCE 1
#include <errno.h>
#include <netinet/in.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>

#ifdef __linux__
#define WANT_EPROTO 71
#else
#define WANT_EPROTO 100
#endif

#ifdef __linux__
// A control buffer sized by the larger packet-information record.
#define PKTINFO_SPACE CMSG_SPACE(sizeof(struct in6_pktinfo))
static unsigned char control[2][PKTINFO_SPACE];

static int pktinfo_round_trip(void) {
    struct sockaddr_in addr;
    socklen_t len = sizeof addr;
    struct iovec iov;
    struct msghdr msg;
    struct cmsghdr *c;
    char byte = 'p';
    int one = 1, s = socket(AF_INET, SOCK_DGRAM, 0), s6, found = 0;

    if (sizeof(struct in_pktinfo) != 12 || sizeof(struct in6_pktinfo) != 20) return 20;
    memset(&addr, 0, sizeof addr);
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    if (s < 0 || bind(s, (struct sockaddr *)&addr, sizeof addr) != 0) return 21;
    if (getsockname(s, (struct sockaddr *)&addr, &len) != 0) return 22;
    if (setsockopt(s, IPPROTO_IP, IP_PKTINFO, &one, sizeof one) != 0) return 23;
    if (sendto(s, &byte, 1, 0, (struct sockaddr *)&addr, sizeof addr) != 1) return 24;
    iov.iov_base = &byte;
    iov.iov_len = 1;
    memset(&msg, 0, sizeof msg);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;
    msg.msg_control = control[0];
    msg.msg_controllen = sizeof control[0];
    if (recvmsg(s, &msg, 0) != 1) return 25;
    for (c = CMSG_FIRSTHDR(&msg); c; c = CMSG_NXTHDR(&msg, c)) {
        if (c->cmsg_level == IPPROTO_IP && c->cmsg_type == IP_PKTINFO) {
            struct in_pktinfo info;
            memcpy(&info, CMSG_DATA(c), sizeof info);
            found = info.ipi_addr.s_addr == htonl(INADDR_LOOPBACK) && info.ipi_ifindex > 0;
        }
    }
    close(s);
    if (!found) return 26;
    s6 = socket(AF_INET6, SOCK_DGRAM, 0);
    if (s6 >= 0) {
        if (setsockopt(s6, IPPROTO_IPV6, IPV6_RECVPKTINFO, &one, sizeof one) != 0) return 27;
        close(s6);
    }
    return 0;
}
#endif

int main(void) {
    int sv[2], type = 0, r;
    socklen_t len = sizeof type;
    char got[2];

    if (EPROTO != WANT_EPROTO) return 1;
    if (socketpair(AF_UNIX, SOCK_DGRAM, 0, sv) != 0) return 2;
    if (getsockopt(sv[0], SOL_SOCKET, SO_TYPE, &type, &len) != 0 || type != SOCK_DGRAM)
        return 3;
    close(sv[0]);
    close(sv[1]);
    if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) != 0) return 4;
    if (getsockopt(sv[1], SOL_SOCKET, SO_TYPE, &type, &len) != 0 || type != SOCK_STREAM)
        return 5;
    if (send(sv[0], "ab", 2, 0) != 2) return 6;
    if (recv(sv[1], got, 1, MSG_PEEK) != 1 || got[0] != 'a') return 7;
    if (recv(sv[1], got, 2, MSG_WAITALL) != 2 || memcmp(got, "ab", 2) != 0) return 8;
    close(sv[0]);
    close(sv[1]);
#ifdef __linux__
    if ((r = pktinfo_round_trip()) != 0) return r;
#else
    r = 0;
#endif
    return r;
}
