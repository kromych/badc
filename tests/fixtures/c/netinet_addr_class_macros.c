// Regression: <netinet/in.h> / <sys/socket.h> provide the IPv6 address-class
// predicates (IN6_IS_ADDR_*), the IPv4 class-network masks (IN_CLASS*_NET), and
// the TTL / hop-limit / OOB socket-option names that real networking code (a
// user-mode TCP/IP stack, e.g. slirp) names by macro. A missing macro parses as
// an unknown function or identifier, so their absence is a compile failure.

#include <netinet/in.h>
#include <sys/socket.h>

int main(void) {
    struct in6_addr mc = (struct in6_addr){ .s6_addr = { 0xff, 0x02, [15] = 1 } };
    struct in6_addr lo = (struct in6_addr){ .s6_addr = { [15] = 1 } };

    if (!IN6_IS_ADDR_MULTICAST(&mc)) return 1;
    if (IN6_IS_ADDR_MULTICAST(&lo)) return 2;
    if (!IN6_IS_ADDR_LOOPBACK(&lo)) return 3;
    if (IN6_IS_ADDR_LOOPBACK(&mc)) return 4;
    if (!IN6_IS_ADDR_MC_LINKLOCAL(&mc)) return 5;
    if (!IN6_IS_ADDR_UNSPECIFIED(&(struct in6_addr){ 0 })) return 6;

    if (IN_CLASSA_NET != 0xff000000U) return 7;
    if (IN_CLASSB_NET != 0xffff0000U) return 8;
    if (IN_CLASSC_NET != 0xffffff00U) return 9;

    // Option names must resolve to integer constants, not unknown identifiers.
    int opts = IP_TTL + IPV6_UNICAST_HOPS + SO_OOBINLINE;
#ifdef __linux__
    opts += IP_RECVERR; // Linux error-queue option, absent on the BSD targets
#endif
    if (opts <= 0) return 10;
    return 0;
}
