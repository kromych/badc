/* <netinet/in.h> IPPROTO_* protocol numbers are integer constant
 * expressions usable as case labels (the IANA-assigned values are
 * identical across platforms). */
#include <netinet/in.h>

static int classify(int proto) {
    switch (proto) {
    case IPPROTO_ICMP:
        return 1;
    case IPPROTO_TCP:
        return 2;
    case IPPROTO_UDP:
        return 3;
    case IPPROTO_ESP:
        return 4;
    case IPPROTO_AH:
        return 5;
    case IPPROTO_SCTP:
        return 6;
    case IPPROTO_ICMPV6:
        return 7;
    default:
        return 0;
    }
}

int main(void) {
    if (classify(1) != 1)
        return 1;
    if (classify(6) != 2)
        return 2;
    if (classify(17) != 3)
        return 3;
    if (classify(50) != 4)
        return 4;
    if (classify(51) != 5)
        return 5;
    if (classify(132) != 6)
        return 6;
    if (classify(58) != 7)
        return 7;
    if (classify(200) != 0)
        return 8;
    return 0;
}
