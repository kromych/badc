// The bundled socket headers (sys/socket.h, netinet/in.h, arpa/inet.h,
// netdb.h) expose the address structures with the platform's ABI. The sizes
// and the sin_port / sin_addr offsets below are identical on every supported
// target; the family-region shape (the BSD/macOS length byte) differs but does
// not move these fields. Asserted by return code.

#include <stddef.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

int main(void) {
    if (sizeof(struct in_addr) != 4) return 1;
    if (sizeof(struct sockaddr) != 16) return 2;
    if (sizeof(struct sockaddr_in) != 16) return 3;
    if (sizeof(struct in6_addr) != 16) return 4;
    if (sizeof(struct sockaddr_in6) != 28) return 5;
    if (offsetof(struct sockaddr_in, sin_port) != 2) return 6;
    if (offsetof(struct sockaddr_in, sin_addr) != 4) return 7;
    if (offsetof(struct sockaddr_in6, sin6_addr) != 8) return 8;
    if (offsetof(struct sockaddr_in6, sin6_scope_id) != 24) return 9;
    if (sizeof(struct addrinfo) != 48) return 10;
    if (sizeof(struct servent) != 32) return 11;
    if (AI_PASSIVE != 1 || NI_MAXHOST != 1025 || NI_MAXSERV != 32) return 12;

    // The structures are usable: set and read back a field.
    struct sockaddr_in a;
    a.sin_family = AF_INET;
    a.sin_port = 0x1234;
    if (a.sin_port != 0x1234) return 13;
    struct addrinfo h;
    h.ai_family = AF_UNSPEC;
    h.ai_socktype = SOCK_STREAM;
    if (h.ai_family != 0 || h.ai_socktype != 1) return 14;
    return 0;
}
