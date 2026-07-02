// net/ethernet.h -- Ethernet frame constants and address structures.

#pragma once

#if defined(__APPLE__) || defined(__linux__)

#include <stdint.h>

// Octet counts and frame limits; identical in glibc <net/ethernet.h>
// (via <linux/if_ether.h>) and Darwin <net/ethernet.h>.
#define ETHER_ADDR_LEN 6
#define ETHER_TYPE_LEN 2
#define ETHER_CRC_LEN 4
#define ETHER_HDR_LEN (ETHER_ADDR_LEN * 2 + ETHER_TYPE_LEN)
#define ETHER_MIN_LEN 64
#define ETHER_MAX_LEN 1518

#define ETHERTYPE_IP 0x0800
#define ETHERTYPE_ARP 0x0806
#define ETHERTYPE_REVARP 0x8035
#define ETHERTYPE_VLAN 0x8100
#define ETHERTYPE_IPV6 0x86dd

struct ether_addr {
    uint8_t ether_addr_octet[ETHER_ADDR_LEN];
};

struct ether_header {
    uint8_t ether_dhost[ETHER_ADDR_LEN];
    uint8_t ether_shost[ETHER_ADDR_LEN];
    uint16_t ether_type;
};

#ifdef __linux__
// glibc's header pulls these from <linux/if_ether.h>.
#define ETH_ALEN 6
#define ETH_HLEN 14
#define ETH_ZLEN 60
#define ETH_DATA_LEN 1500
#define ETH_FRAME_LEN 1514
#define ETH_P_ALL 0x0003
#define ETH_P_IP 0x0800
#define ETH_P_ARP 0x0806
#define ETH_P_IPV6 0x86dd
#endif

#endif
