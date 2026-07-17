// sys/socket.h -- BSD/Berkeley sockets surface.
//
// Per-target gating wires the c5-side names (`socket`, `bind`, ...)
// to the matching platform symbol:
//   * macOS: libSystem, with the leading underscore Mach-O wants.
//   * Linux: libc.so.6.
//   * Windows: ws2_32.dll. WSAStartup *must* be called before any
//     other socket call on Windows -- the header doesn't paper over
//     that.
//
// All three platforms ship sockaddr_in at 16 bytes with sin_family
// at offset 0 / sin_port at offset 2 / sin_addr at offset 4 -- the
// odd one out is macOS which puts a 1-byte sin_len at offset 0 and
// sin_family at offset 1. Cross-platform code should:
//
//   memset(addr, 0, 16);
//   #ifdef __APPLE__
//   *addr = 16;            // sin_len
//   *(addr + 1) = AF_INET;
//   #else
//   *addr = AF_INET;       // sin_family low byte, high byte is zero
//   #endif
//   // sin_port (network byte order)
//   *(addr + 2) = port_high;
//   *(addr + 3) = port_low;
//
// The numeric option constants (SOL_SOCKET, SO_REUSEADDR, ...) are
// gated per-target since the BSD vs Linux numberings disagree.
// AF_INET / SOCK_STREAM line up across all three platforms so they
// live outside the gates.

#pragma once

#define AF_UNSPEC   0
#define AF_UNIX     1
#define AF_LOCAL    AF_UNIX
#define AF_INET     2
#ifdef __APPLE__
#define AF_INET6    30
#elif defined(_WIN32)
#define AF_INET6    23
#elif defined(__linux__)
#define AF_INET6    10
#define AF_CAN      29
#define AF_VSOCK    40
#endif
#define SOCK_STREAM 1
#define SOCK_DGRAM  2
#define SOCK_RAW    3
#define SOCK_RDM    4
#define SOCK_SEQPACKET 5
#define SHUT_RD     0
#define SHUT_WR     1
#define SHUT_RDWR   2
#define IPPROTO_TCP 6
#define IPPROTO_UDP 17
#define INADDR_ANY  0
#define SOMAXCONN   128

// Protocol families. POSIX PF_* mirror the AF_* address families; every
// current target defines them with equal values.
#define PF_UNSPEC AF_UNSPEC
#define PF_UNIX   AF_UNIX
#define PF_LOCAL  AF_UNIX
#define PF_INET   AF_INET
#define PF_INET6  AF_INET6
#ifdef __linux__
#define PF_CAN    AF_CAN
#define PF_VSOCK  AF_VSOCK
#endif

// Address-family field type. macOS holds it in one byte (sin_len precedes
// it); Linux and Winsock use a 16-bit field.
#ifdef __APPLE__
typedef unsigned char sa_family_t;
#else
typedef unsigned short sa_family_t;
#endif

// setsockopt / getsockopt levels and option names. The numeric values differ
// between Linux and the BSD-derived set; Winsock inherited the BSD values, so
// macOS and Windows share them.
#if defined(__APPLE__) || defined(_WIN32)
#define SOL_SOCKET    0xffff
#define SO_REUSEADDR  0x0004
#define SO_KEEPALIVE  0x0008
#define SO_OOBINLINE  0x0100
#define SO_SNDBUF     0x1001
#define SO_RCVBUF     0x1002
#define SO_ERROR      0x1007
#elif defined(__linux__)
#define SOL_SOCKET    1
#define SO_REUSEADDR  2
#define SO_TYPE       3
#define SO_ERROR      4
#define SO_BROADCAST  6
#define SO_SNDBUF     7
#define SO_RCVBUF     8
#define SO_KEEPALIVE  9
#define SO_OOBINLINE  10
#define SO_REUSEPORT  15
#define SO_PASSCRED   16
#define SO_PEERCRED   17
// Receive/send timeout option names. aarch64 and x86_64 have a natively
// 64-bit time_t, so glibc selects the timeval-based "_OLD" numbers.
#define SO_RCVTIMEO   20
#define SO_SNDTIMEO   21
// SO_PEERCRED fills the peer's credentials. glibc's `struct ucred` holds a
// pid_t and two uid_t/gid_t, all 32-bit on Linux.
struct ucred {
    int pid;
    unsigned int uid;
    unsigned int gid;
};
#endif

// `struct sockaddr` is the address header passed by reference to bind /
// connect / accept and pointed at by `addrinfo.ai_addr`. It is 16 bytes on
// all three targets; the leading family field differs (BSD/macOS prefix a
// 1-byte length).
#ifdef __APPLE__
struct sockaddr {
    unsigned char sa_len;
    unsigned char sa_family;
    char sa_data[14];
};
#elif defined(__linux__) || defined(_WIN32)
struct sockaddr {
    unsigned short sa_family;
    char sa_data[14];
};
#endif

// `struct sockaddr_storage` is the 128-byte buffer large enough for any
// address family; callers pass its address where an address of unknown
// family is filled in (e.g. accept / getnameinfo).
struct sockaddr_storage {
#ifdef __APPLE__
    unsigned char ss_len;
    unsigned char ss_family;
    char ss_pad[126];
#elif defined(__linux__) || defined(_WIN32)
    unsigned short ss_family;
    char ss_pad[126];
#endif
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::socket,     "_socket")
#pragma binding(libc::bind,       "_bind")
#pragma binding(libc::listen,     "_listen")
#pragma binding(libc::accept,     "_accept")
#pragma binding(libc::connect,    "_connect")
#pragma binding(libc::setsockopt, "_setsockopt")
#pragma binding(libc::getsockopt, "_getsockopt")
#pragma binding(libc::getpeername, "_getpeername")
#pragma binding(libc::getsockname, "_getsockname")
#pragma binding(libc::recv,       "_recv")
#pragma binding(libc::send,       "_send")
#pragma binding(libc::recvfrom,   "_recvfrom")
#pragma binding(libc::sendto,     "_sendto")
#pragma binding(libc::shutdown,   "_shutdown")
#pragma binding(libc::socketpair, "_socketpair")
#pragma binding(libc::sendfile,   "_sendfile")

// Optional header / trailer iovecs for Darwin's sendfile(). `struct
// iovec` is from <sys/uio.h>; only a pointer to it is needed here.
struct iovec;
struct sf_hdtr {
    struct iovec *headers;
    int hdr_cnt;
    struct iovec *trailers;
    int trl_cnt;
};
// Darwin sendfile: send `*len` bytes of `fd` from `offset` to socket `s`,
// updating `*len` with the count actually sent.
int sendfile(int fd, int s, long offset, long *len, struct sf_hdtr *hdtr,
             int flags);

#define SOL_SOCKET    0xffff
#define SO_REUSEADDR  0x0004
#define SO_KEEPALIVE  0x0008
#define SO_BROADCAST  0x0020
#define SO_NOSIGPIPE  0x1022  // suppress SIGPIPE on writes to a broken socket
#define SHUT_RD       0
#define SHUT_WR       1
#define SHUT_RDWR     2

// macOS sockaddr_in includes a 1-byte sin_len at offset 0; the
// portable thing is to memset to zero and then set bytes by name.
#define SOCKADDR_IN_SIZE 16
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::socket,     "socket")
#pragma binding(libc::bind,       "bind")
#pragma binding(libc::listen,     "listen")
#pragma binding(libc::accept,     "accept")
#pragma binding(libc::connect,    "connect")
#pragma binding(libc::setsockopt, "setsockopt")
#pragma binding(libc::getsockopt, "getsockopt")
#pragma binding(libc::getpeername, "getpeername")
#pragma binding(libc::getsockname, "getsockname")
#pragma binding(libc::recv,       "recv")
#pragma binding(libc::send,       "send")
#pragma binding(libc::recvfrom,   "recvfrom")
#pragma binding(libc::sendto,     "sendto")
#pragma binding(libc::shutdown,   "shutdown")
#pragma binding(libc::socketpair, "socketpair")
#pragma binding(libc::sendmsg,    "sendmsg")
#pragma binding(libc::recvmsg,    "recvmsg")
#pragma binding(libc::accept4,    "accept4")

#define SOL_SOCKET    1
#define SO_REUSEADDR  2
#define SO_KEEPALIVE  9
#define SO_BROADCAST  6
#define SHUT_RD       0
#define SHUT_WR       1
#define SHUT_RDWR     2

// send()/recv() flag bits (bits/socket.h).
#define MSG_OOB          0x01
#define MSG_PEEK         0x02
#define MSG_DONTROUTE    0x04
#define MSG_CTRUNC       0x08
#define MSG_TRUNC        0x20
#define MSG_DONTWAIT     0x40
#define MSG_EOR          0x80
#define MSG_WAITALL      0x100
#define MSG_CONFIRM      0x800
#define MSG_ERRQUEUE     0x2000
#define MSG_NOSIGNAL     0x4000
#define MSG_MORE         0x8000
#define MSG_WAITFORONE   0x10000
#define MSG_CMSG_CLOEXEC 0x40000000

// socket() type flag bits OR-ed into the type argument (bits/socket_type.h).
#define SOCK_CLOEXEC  02000000
#define SOCK_NONBLOCK 00004000

#define SOCKADDR_IN_SIZE 16

// Scatter/gather messaging with ancillary data (sendmsg/recvmsg).
// struct iovec is from <sys/uio.h>; layout matches glibc aarch64.
#include <sys/uio.h>
struct msghdr {
    void *msg_name;
    socklen_t msg_namelen;
    struct iovec *msg_iov;
    size_t msg_iovlen;
    void *msg_control;
    size_t msg_controllen;
    int msg_flags;
};
struct cmsghdr {
    size_t cmsg_len;
    int cmsg_level;
    int cmsg_type;
};
#define SCM_RIGHTS 1

// CMSG_* accessors; CMSG_SPACE/CMSG_LEN are constant expressions.
#define CMSG_ALIGN(len) (((len) + sizeof(size_t) - 1) & (size_t)~(sizeof(size_t) - 1))
#define CMSG_SPACE(len) (CMSG_ALIGN(len) + CMSG_ALIGN(sizeof(struct cmsghdr)))
#define CMSG_LEN(len)   (CMSG_ALIGN(sizeof(struct cmsghdr)) + (len))
#define CMSG_DATA(cmsg) ((unsigned char *)((struct cmsghdr *)(cmsg) + 1))
#define CMSG_FIRSTHDR(mhdr) \
    ((size_t)(mhdr)->msg_controllen >= sizeof(struct cmsghdr) \
     ? (struct cmsghdr *)(mhdr)->msg_control : (struct cmsghdr *)0)
#define CMSG_NXTHDR(mhdr, cmsg) \
    (((unsigned char *)(cmsg) + CMSG_ALIGN((cmsg)->cmsg_len) + sizeof(struct cmsghdr) \
      > (unsigned char *)(mhdr)->msg_control + (mhdr)->msg_controllen) \
     ? (struct cmsghdr *)0 \
     : (struct cmsghdr *)((unsigned char *)(cmsg) + CMSG_ALIGN((cmsg)->cmsg_len)))

long sendmsg(int fd, const struct msghdr *msg, int flags);
long recvmsg(int fd, struct msghdr *msg, int flags);

// Batched socket I/O (GNU/Linux): recvmmsg/sendmmsg transfer an array of
// mmsghdr in one call, each pairing a msghdr with the byte count moved.
struct mmsghdr {
    struct msghdr msg_hdr;
    unsigned int msg_len;
};
struct timespec;
int recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen, int flags,
             struct timespec *timeout);
int sendmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen, int flags);
#endif

#ifdef _WIN32
#pragma dylib(ws2_32, "ws2_32.dll")
#pragma binding(ws2_32::WSAStartup,  "WSAStartup")
#pragma binding(ws2_32::WSACleanup,  "WSACleanup")
#pragma binding(ws2_32::socket,      "socket")
#pragma binding(ws2_32::bind,        "bind")
#pragma binding(ws2_32::listen,      "listen")
#pragma binding(ws2_32::accept,      "accept")
#pragma binding(ws2_32::connect,     "connect")
#pragma binding(ws2_32::getpeername, "getpeername")
#pragma binding(ws2_32::getsockname, "getsockname")
#pragma binding(ws2_32::setsockopt,  "setsockopt")
#pragma binding(ws2_32::getsockopt,  "getsockopt")
#pragma binding(ws2_32::recv,        "recv")
#pragma binding(ws2_32::send,        "send")
#pragma binding(ws2_32::recvfrom,    "recvfrom")
#pragma binding(ws2_32::sendto,      "sendto")
#pragma binding(ws2_32::shutdown,    "shutdown")
#pragma binding(ws2_32::closesocket, "closesocket")
#pragma binding(ws2_32::ioctlsocket, "ioctlsocket")
#pragma binding(ws2_32::WSAGetLastError, "WSAGetLastError")
#pragma binding(ws2_32::WSASetLastError, "WSASetLastError")
int  WSAGetLastError(void);
void WSASetLastError(int err);

#define SOL_SOCKET    0xffff
#define SO_REUSEADDR  0x0004
#define SO_KEEPALIVE  0x0008
#define SO_BROADCAST  0x0020
#define SHUT_RD       0
#define SHUT_WR       1
#define SHUT_RDWR     2

// On Windows close()/read()/write() don't work on socket handles --
// you must use closesocket() / recv() / send() instead. The header
// declares closesocket so cross-platform code can `#ifdef _WIN32`
// over which spelling to call.
#define SOCKADDR_IN_SIZE 16
#define FIONBIO 0x8004667e          // ioctlsocket cmd: set non-blocking

int WSAStartup(int version_word, char *wsadata);
int WSACleanup();
int closesocket(int fd);
int ioctlsocket(int fd, int cmd, int *arg);
#endif

// Common prototypes -- portable across the three platforms.
int socket(int domain, int type, int protocol);
int bind(int fd, char *addr, int addrlen);
int listen(int fd, int backlog);
int accept(int fd, char *addr, int *addrlen);
int accept4(int fd, struct sockaddr *addr, socklen_t *addrlen, int flags);
int connect(int fd, char *addr, int addrlen);
int setsockopt(int fd, int level, int optname, char *optval, int optlen);
int getsockopt(int fd, int level, int optname, char *optval, int *optlen);
int recv(int fd, char *buf, int n, int flags);
int send(int fd, char *buf, int n, int flags);
int shutdown(int fd, int how);
int socketpair(int domain, int type, int protocol, int *sv);
int getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen);
int getsockname(int fd, struct sockaddr *addr, socklen_t *addrlen);
long recvfrom(int fd, char *buf, long n, int flags, struct sockaddr *addr, socklen_t *addrlen);
long sendto(int fd, char *buf, long n, int flags, struct sockaddr *addr, socklen_t addrlen);
