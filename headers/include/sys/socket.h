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
#define AF_INET     2
#ifdef __APPLE__
#define AF_INET6    30
#elif defined(_WIN32)
#define AF_INET6    23
#elif defined(__linux__)
#define AF_INET6    10
#endif
#define SOCK_STREAM 1
#define SOCK_DGRAM  2
#define SHUT_RD     0
#define SHUT_WR     1
#define SHUT_RDWR   2
#define IPPROTO_TCP 6
#define IPPROTO_UDP 17
#define INADDR_ANY  0
#define SOMAXCONN   128

// setsockopt / getsockopt levels and option names. The numeric values differ
// between Linux and the BSD-derived set; Winsock inherited the BSD values, so
// macOS and Windows share them.
#if defined(__APPLE__) || defined(_WIN32)
#define SOL_SOCKET    0xffff
#define SO_REUSEADDR  0x0004
#define SO_KEEPALIVE  0x0008
#define SO_SNDBUF     0x1001
#define SO_RCVBUF     0x1002
#define SO_ERROR      0x1007
#elif defined(__linux__)
#define SOL_SOCKET    1
#define SO_REUSEADDR  2
#define SO_KEEPALIVE  9
#define SO_SNDBUF     7
#define SO_RCVBUF     8
#define SO_ERROR      4
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

#define SOL_SOCKET    1
#define SO_REUSEADDR  2
#define SO_KEEPALIVE  9
#define SO_BROADCAST  6
#define SHUT_RD       0
#define SHUT_WR       1
#define SHUT_RDWR     2

#define SOCKADDR_IN_SIZE 16
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
int connect(int fd, char *addr, int addrlen);
int setsockopt(int fd, int level, int optname, char *optval, int optlen);
int getsockopt(int fd, int level, int optname, char *optval, int *optlen);
int recv(int fd, char *buf, int n, int flags);
int send(int fd, char *buf, int n, int flags);
int shutdown(int fd, int how);
int getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen);
int getsockname(int fd, struct sockaddr *addr, socklen_t *addrlen);
long recvfrom(int fd, char *buf, long n, int flags, struct sockaddr *addr, socklen_t *addrlen);
long sendto(int fd, char *buf, long n, int flags, struct sockaddr *addr, socklen_t addrlen);
