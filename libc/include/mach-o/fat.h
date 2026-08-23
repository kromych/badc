// mach-o/fat.h -- the universal (fat) binary header. Values and field
// layout match the macOS SDK header of the same name. The format is
// fixed, so the definitions are usable on any host. No bindings -- data
// layout only.
//
// A fat file stores its header and arch table big-endian regardless of
// the slices it carries; FAT_CIGAM is FAT_MAGIC seen byte-swapped.

#pragma once

#include <stdint.h>
#include <mach/machine.h>

#define FAT_MAGIC 0xcafebabe
#define FAT_CIGAM 0xbebafeca

struct fat_header {
    uint32_t magic;
    uint32_t nfat_arch;
};

struct fat_arch {
    int32_t  cputype;
    int32_t  cpusubtype;
    uint32_t offset;
    uint32_t size;
    uint32_t align;
};

// Used when a slice, or the offset to one, exceeds 4GB.
#define FAT_MAGIC_64 0xcafebabf
#define FAT_CIGAM_64 0xbfbafeca

struct fat_arch_64 {
    int32_t  cputype;
    int32_t  cpusubtype;
    uint64_t offset;
    uint64_t size;
    uint32_t align;
    uint32_t reserved;
};
