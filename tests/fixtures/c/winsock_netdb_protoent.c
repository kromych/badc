/* On Windows <winsock2.h> defines struct protoent, and <ws2tcpip.h> pulls in
   <netdb.h>; netdb.h must not redefine protoent or the two headers conflict.
   servent and hostent are declared by netdb.h on every target. This exercises
   the no-redefinition on the Windows backends; on the POSIX targets the guarded
   block is inactive. */

#ifdef _WIN32
#include <ws2tcpip.h>
static struct protoent *proto;
static struct servent *serv;
static struct hostent *host;
#endif

int main(void) {
#ifdef _WIN32
    return (proto || serv || host) ? 1 : 0;
#else
    return 0;
#endif
}
