// The IPv6 address predicates: the IN6_IS_ADDR_* tests of RFC 3493 and
// IN6_ARE_ADDR_EQUAL, from <netinet/in.h>, and on Windows from <ws2tcpip.h>
// as mingw-w64 and the Windows SDK define them. Each holds for an address of
// its class and not for one outside it. Asserted by return code.

#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <netinet/in.h>
#endif

static struct in6_addr in6(unsigned char b0, unsigned char b1, unsigned char b10,
                           unsigned char b11, unsigned char b15) {
    struct in6_addr a;
    for (int i = 0; i < 16; i++)
        a.s6_addr[i] = 0;
    a.s6_addr[0] = b0;
    a.s6_addr[1] = b1;
    a.s6_addr[10] = b10;
    a.s6_addr[11] = b11;
    a.s6_addr[15] = b15;
    return a;
}

int main(void) {
    struct in6_addr any = in6(0, 0, 0, 0, 0);
    struct in6_addr loopback = in6(0, 0, 0, 0, 1);
    struct in6_addr link = in6(0xfe, 0x80, 0, 0, 1);
    struct in6_addr site = in6(0xfe, 0xc0, 0, 0, 1);
    struct in6_addr mapped = in6(0, 0, 0xff, 0xff, 1);
    struct in6_addr compat = in6(0, 0, 0, 0, 2);
    struct in6_addr mc_node = in6(0xff, 0x01, 0, 0, 1);
    struct in6_addr mc_link = in6(0xff, 0x02, 0, 0, 1);
    struct in6_addr mc_site = in6(0xff, 0x05, 0, 0, 1);
    struct in6_addr mc_org = in6(0xff, 0x08, 0, 0, 1);
    struct in6_addr mc_global = in6(0xff, 0x0e, 0, 0, 1);

    if (!IN6_IS_ADDR_UNSPECIFIED(&any) || IN6_IS_ADDR_UNSPECIFIED(&loopback)) return 1;
    if (!IN6_IS_ADDR_LOOPBACK(&loopback) || IN6_IS_ADDR_LOOPBACK(&any)) return 2;
    if (!IN6_IS_ADDR_LINKLOCAL(&link) || IN6_IS_ADDR_LINKLOCAL(&site)) return 3;
    if (!IN6_IS_ADDR_SITELOCAL(&site) || IN6_IS_ADDR_SITELOCAL(&link)) return 4;
    if (!IN6_IS_ADDR_V4MAPPED(&mapped) || IN6_IS_ADDR_V4MAPPED(&loopback)) return 5;
    if (!IN6_IS_ADDR_V4COMPAT(&compat) || IN6_IS_ADDR_V4COMPAT(&loopback)) return 6;
    if (!IN6_IS_ADDR_MULTICAST(&mc_link) || IN6_IS_ADDR_MULTICAST(&link)) return 7;
    if (!IN6_IS_ADDR_MC_NODELOCAL(&mc_node) || IN6_IS_ADDR_MC_NODELOCAL(&mc_link)) return 8;
    if (!IN6_IS_ADDR_MC_LINKLOCAL(&mc_link) || IN6_IS_ADDR_MC_LINKLOCAL(&mc_site)) return 9;
    if (!IN6_IS_ADDR_MC_SITELOCAL(&mc_site) || IN6_IS_ADDR_MC_SITELOCAL(&mc_org)) return 10;
    if (!IN6_IS_ADDR_MC_ORGLOCAL(&mc_org) || IN6_IS_ADDR_MC_ORGLOCAL(&mc_global)) return 11;
    if (!IN6_IS_ADDR_MC_GLOBAL(&mc_global) || IN6_IS_ADDR_MC_GLOBAL(&mc_node)) return 12;
    if (!IN6_ARE_ADDR_EQUAL(&link, &link) || IN6_ARE_ADDR_EQUAL(&link, &site)) return 13;
    return 0;
}
