// sendmsg and recvmsg with the C library's struct msghdr and struct cmsghdr
// (POSIX <sys/socket.h>): a loopback datagram gathered from two iovecs is
// scattered into two, with the sender in msg_name and an IP_PKTINFO record
// naming 127.0.0.1; IPV6_RECVPKTINFO yields an in6_pktinfo naming ::1; a
// descriptor passes as SCM_RIGHTS; CMSG_NXTHDR steps over records laid out
// by CMSG_SPACE, and on Linux stops at a record shorter than its header or
// longer than the buffer; sockatmark reports no mark on an unconnected
// stream socket.
// A host without IPv6 loopback skips that part.
// snapshot-budget: exempt
#define _GNU_SOURCE 1
#define __APPLE_USE_RFC_3542 1
#include <errno.h>
#include <netinet/in.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>

#ifdef __APPLE__
#define MSGHDR_SIZE  48
#define CMSGHDR_SIZE 12
#define PKTINFO_SPACE 24
#define RECV_PKTINFO IP_RECVPKTINFO
#else
#define MSGHDR_SIZE  56
#define CMSGHDR_SIZE 16
#define PKTINFO_SPACE 32
#define RECV_PKTINFO IP_PKTINFO
#endif

union control {
    struct cmsghdr align;
    unsigned char buf[CMSG_SPACE(sizeof(struct in6_pktinfo)) + CMSG_SPACE(sizeof(int))];
};

static int ipv4_pktinfo(void) {
    struct sockaddr_in addr, from;
    socklen_t len = sizeof addr;
    char in1[4], in2[8];
    struct iovec iov[2];
    struct msghdr msg;
    union control control;
    struct cmsghdr *c;
    int one = 1, found = 0, s = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&addr, 0, sizeof addr);
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    if (s < 0 || bind(s, (struct sockaddr *)&addr, sizeof addr) != 0) return 10;
    if (getsockname(s, (struct sockaddr *)&addr, &len) != 0) return 11;
    if (setsockopt(s, IPPROTO_IP, RECV_PKTINFO, &one, sizeof one) != 0) return 12;
    iov[0].iov_base = "dat";
    iov[0].iov_len = 3;
    iov[1].iov_base = "agram";
    iov[1].iov_len = 5;
    memset(&msg, 0, sizeof msg);
    msg.msg_name = &addr;
    msg.msg_namelen = sizeof addr;
    msg.msg_iov = iov;
    msg.msg_iovlen = 2;
    if (sendmsg(s, &msg, 0) != 8) return 13;
    iov[0].iov_base = in1;
    iov[0].iov_len = sizeof in1;
    iov[1].iov_base = in2;
    iov[1].iov_len = sizeof in2;
    memset(&msg, 0, sizeof msg);
    memset(&from, 0, sizeof from);
    msg.msg_name = &from;
    msg.msg_namelen = sizeof from;
    msg.msg_iov = iov;
    msg.msg_iovlen = 2;
    msg.msg_control = control.buf;
    msg.msg_controllen = sizeof control.buf;
    if (recvmsg(s, &msg, 0) != 8) return 14;
    if (memcmp(in1, "data", 4) != 0 || memcmp(in2, "gram", 4) != 0) return 15;
    if (msg.msg_namelen != sizeof from || from.sin_port != addr.sin_port ||
        from.sin_addr.s_addr != htonl(INADDR_LOOPBACK))
        return 16;
    if (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC)) return 17;
    for (c = CMSG_FIRSTHDR(&msg); c; c = CMSG_NXTHDR(&msg, c)) {
        if (c->cmsg_level == IPPROTO_IP && c->cmsg_type == IP_PKTINFO) {
            struct in_pktinfo info;
            if (c->cmsg_len != CMSG_LEN(sizeof info)) return 18;
            memcpy(&info, CMSG_DATA(c), sizeof info);
            found = info.ipi_addr.s_addr == htonl(INADDR_LOOPBACK) && info.ipi_ifindex > 0;
        }
    }
    close(s);
    return found ? 0 : 19;
}

static int ipv6_pktinfo(void) {
    struct sockaddr_in6 addr;
    socklen_t len = sizeof addr;
    char byte = '6';
    struct iovec iov;
    struct msghdr msg;
    union control control;
    struct cmsghdr *c;
    int one = 1, found = 0, s = socket(AF_INET6, SOCK_DGRAM, 0);

    if (s < 0) return errno == EAFNOSUPPORT ? 0 : 20;
    memset(&addr, 0, sizeof addr);
    addr.sin6_family = AF_INET6;
    addr.sin6_addr.s6_addr[15] = 1;
    if (bind(s, (struct sockaddr *)&addr, sizeof addr) != 0) {
        close(s);
        return errno == EADDRNOTAVAIL ? 0 : 21;
    }
    if (getsockname(s, (struct sockaddr *)&addr, &len) != 0) return 22;
    if (setsockopt(s, IPPROTO_IPV6, IPV6_RECVPKTINFO, &one, sizeof one) != 0) return 23;
    if (sendto(s, &byte, 1, 0, (struct sockaddr *)&addr, sizeof addr) != 1) return 24;
    iov.iov_base = &byte;
    iov.iov_len = 1;
    memset(&msg, 0, sizeof msg);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;
    msg.msg_control = control.buf;
    msg.msg_controllen = sizeof control.buf;
    if (recvmsg(s, &msg, 0) != 1 || byte != '6') return 25;
    for (c = CMSG_FIRSTHDR(&msg); c; c = CMSG_NXTHDR(&msg, c)) {
        if (c->cmsg_level == IPPROTO_IPV6 && c->cmsg_type == IPV6_PKTINFO) {
            struct in6_pktinfo info;
            if (c->cmsg_len != CMSG_LEN(sizeof info)) return 26;
            memcpy(&info, CMSG_DATA(c), sizeof info);
            found = IN6_IS_ADDR_LOOPBACK(&info.ipi6_addr) && info.ipi6_ifindex > 0;
        }
    }
    close(s);
    return found ? 0 : 27;
}

static int pass_descriptor(void) {
    int sv[2], p[2], got = -1;
    char byte = 'r', back = 0;
    struct iovec iov;
    struct msghdr msg;
    union control control;
    struct cmsghdr *c;

    if (socketpair(AF_UNIX, SOCK_DGRAM, 0, sv) != 0 || pipe(p) != 0) return 30;
    iov.iov_base = &byte;
    iov.iov_len = 1;
    memset(&msg, 0, sizeof msg);
    memset(&control, 0, sizeof control);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;
    msg.msg_control = control.buf;
    msg.msg_controllen = CMSG_SPACE(sizeof(int));
    c = CMSG_FIRSTHDR(&msg);
    c->cmsg_level = SOL_SOCKET;
    c->cmsg_type = SCM_RIGHTS;
    c->cmsg_len = CMSG_LEN(sizeof(int));
    memcpy(CMSG_DATA(c), &p[1], sizeof(int));
    if (sendmsg(sv[0], &msg, 0) != 1) return 31;
    memset(&control, 0, sizeof control);
    msg.msg_controllen = sizeof control.buf;
    byte = 0;
    if (recvmsg(sv[1], &msg, 0) != 1 || byte != 'r') return 32;
    c = CMSG_FIRSTHDR(&msg);
    if (!c || c->cmsg_level != SOL_SOCKET || c->cmsg_type != SCM_RIGHTS ||
        c->cmsg_len != CMSG_LEN(sizeof(int)))
        return 33;
    memcpy(&got, CMSG_DATA(c), sizeof got);
    if (got == p[1] || write(got, "x", 1) != 1 || read(p[0], &back, 1) != 1 || back != 'x')
        return 34;
    close(got);
    close(p[0]);
    close(p[1]);
    close(sv[0]);
    close(sv[1]);
    return 0;
}

static int walk_records(void) {
    union control control;
    struct msghdr msg;
    struct cmsghdr *first, *second;

    memset(&control, 0, sizeof control);
    memset(&msg, 0, sizeof msg);
    msg.msg_control = control.buf;
    msg.msg_controllen = CMSG_SPACE(sizeof(int)) + CMSG_SPACE(3);
    first = CMSG_FIRSTHDR(&msg);
    if (first != &control.align) return 40;
    first->cmsg_len = CMSG_LEN(sizeof(int));
    second = CMSG_NXTHDR(&msg, first);
    if ((unsigned char *)second != control.buf + CMSG_SPACE(sizeof(int))) return 41;
    second->cmsg_len = CMSG_LEN(3);
    if (CMSG_NXTHDR(&msg, second) != 0) return 42;
    if (CMSG_DATA(first) != control.buf + CMSG_LEN(0)) return 43;
#ifdef __linux__
    // glibc's CMSG_NXTHDR ends the walk at a malformed record.
    first->cmsg_len = 0;
    if (CMSG_NXTHDR(&msg, first) != 0) return 45;
    first->cmsg_len = (size_t)-1;
    if (CMSG_NXTHDR(&msg, first) != 0) return 46;
#endif
    msg.msg_controllen = sizeof(struct cmsghdr) - 1;
    if (CMSG_FIRSTHDR(&msg) != 0) return 44;
    return 0;
}

int main(void) {
    int r, s = socket(AF_INET, SOCK_STREAM, 0);

    if (sizeof(struct msghdr) != MSGHDR_SIZE || sizeof(struct cmsghdr) != CMSGHDR_SIZE) return 1;
    if (CMSG_LEN(0) != CMSGHDR_SIZE || CMSG_SPACE(sizeof(struct in_pktinfo)) != PKTINFO_SPACE)
        return 2;
    if (sizeof(struct in_pktinfo) != 12 || sizeof(struct in6_pktinfo) != 20) return 3;
    if (s < 0 || sockatmark(s) != 0) return 4;
    close(s);
    if ((r = ipv4_pktinfo()) != 0) return r;
    if ((r = ipv6_pktinfo()) != 0) return r;
    if ((r = pass_descriptor()) != 0) return r;
    return walk_records();
}
