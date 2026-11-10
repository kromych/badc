// Winsock's 64-bit servent (s_proto ahead of a short s_port) and hostent
// (short h_addrtype and h_length), as getservbyname and gethostbyname fill
// them.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <string.h>
#include <winsock2.h>
#include <ws2tcpip.h>

int main(void) {
    WSADATA wsa;
    if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) {
        return 1;
    }
    int rc = 0;
    struct servent *s = getservbyname("http", "tcp");
    if (!s || ntohs((unsigned short)s->s_port) != 80 || strcmp(s->s_proto, "tcp") != 0) {
        rc = 2;
    }
    struct hostent *h = rc ? 0 : gethostbyname("localhost");
    if (!rc && (!h || h->h_addrtype != AF_INET || h->h_length != 4)) {
        rc = 3;
    }
    WSACleanup();
    return rc;
}
