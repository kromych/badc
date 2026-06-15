// A struct passed by value to a libc binding is packed into the platform-ABI
// argument registers (SysV / AAPCS64), not passed by the c5 address
// convention. inet_ntoa takes a 4-byte `struct in_addr` by value -- a single
// integer-class eightbyte -- and formats it. Asserted by return code.
//
// Run under the native and JIT paths. The SSA interpreter does not marshal a
// by-value struct argument into the host-ABI registers.

#include <arpa/inet.h>
#include <string.h>

int main(void) {
    struct in_addr a;
    a.s_addr = 0x0100007f; // bytes 7f 00 00 01 -> 127.0.0.1 (network order)
    if (strcmp(inet_ntoa(a), "127.0.0.1") != 0) return 1;
    // inet_ntoa returns a static buffer, so finish using the first result
    // before the next call overwrites it.
    struct in_addr b;
    b.s_addr = 0x0101a8c0; // 192.168.1.1
    if (strcmp(inet_ntoa(b), "192.168.1.1") != 0) return 2;
    return 0;
}
