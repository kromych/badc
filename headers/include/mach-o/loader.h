// mach-o/loader.h -- Mach-O file-format structures and constants, the
// subset consumers reach for (headers, segment/section layout). Values
// match the macOS SDK's <mach-o/loader.h>; the format is fixed, so the
// definitions are usable on any host. No bindings -- data layout only.

#pragma once

#include <stdint.h>

// <mach/machine.h> integer_t-based ids; <mach/vm_prot.h> protection bits.
typedef int cpu_type_t;
typedef int cpu_subtype_t;
typedef int vm_prot_t;

struct mach_header {
    uint32_t magic;
    cpu_type_t cputype;
    cpu_subtype_t cpusubtype;
    uint32_t filetype;
    uint32_t ncmds;
    uint32_t sizeofcmds;
    uint32_t flags;
};

#define MH_MAGIC 0xfeedface
#define MH_CIGAM 0xcefaedfe

struct mach_header_64 {
    uint32_t magic;
    cpu_type_t cputype;
    cpu_subtype_t cpusubtype;
    uint32_t filetype;
    uint32_t ncmds;
    uint32_t sizeofcmds;
    uint32_t flags;
    uint32_t reserved;
};

#define MH_MAGIC_64 0xfeedfacf
#define MH_CIGAM_64 0xcffaedfe

// mach_header filetype values.
#define MH_OBJECT 0x1
#define MH_EXECUTE 0x2
#define MH_DYLIB 0x6
#define MH_DYLINKER 0x7
#define MH_BUNDLE 0x8
#define MH_DSYM 0xa

struct load_command {
    uint32_t cmd;
    uint32_t cmdsize;
};

#define LC_SEGMENT 0x1
#define LC_SYMTAB 0x2
#define LC_UUID 0x1b
#define LC_SEGMENT_64 0x19

struct segment_command {
    uint32_t cmd;
    uint32_t cmdsize;
    char segname[16];
    uint32_t vmaddr;
    uint32_t vmsize;
    uint32_t fileoff;
    uint32_t filesize;
    vm_prot_t maxprot;
    vm_prot_t initprot;
    uint32_t nsects;
    uint32_t flags;
};

struct segment_command_64 {
    uint32_t cmd;
    uint32_t cmdsize;
    char segname[16];
    uint64_t vmaddr;
    uint64_t vmsize;
    uint64_t fileoff;
    uint64_t filesize;
    vm_prot_t maxprot;
    vm_prot_t initprot;
    uint32_t nsects;
    uint32_t flags;
};

struct section {
    char sectname[16];
    char segname[16];
    uint32_t addr;
    uint32_t size;
    uint32_t offset;
    uint32_t align;
    uint32_t reloff;
    uint32_t nreloc;
    uint32_t flags;
    uint32_t reserved1;
    uint32_t reserved2;
};

struct section_64 {
    char sectname[16];
    char segname[16];
    uint64_t addr;
    uint64_t size;
    uint32_t offset;
    uint32_t align;
    uint32_t reloff;
    uint32_t nreloc;
    uint32_t flags;
    uint32_t reserved1;
    uint32_t reserved2;
    uint32_t reserved3;
};

struct symtab_command {
    uint32_t cmd;
    uint32_t cmdsize;
    uint32_t symoff;
    uint32_t nsyms;
    uint32_t stroff;
    uint32_t strsize;
};

#define SEG_PAGEZERO "__PAGEZERO"
#define SEG_TEXT "__TEXT"
#define SECT_TEXT "__text"
#define SEG_DATA "__DATA"
#define SECT_DATA "__data"
#define SECT_BSS "__bss"
#define SECT_COMMON "__common"
#define SEG_LINKEDIT "__LINKEDIT"
