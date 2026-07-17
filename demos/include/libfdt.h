/* Minimal <libfdt.h> for building against the system libfdt. Self-contained
 * (folds in fdt.h and libfdt_env.h): declares only the flat-device-tree types,
 * error codes, big-endian access helpers, and the read/write/create entry
 * points that consuming code here uses. The upstream doc comments, the getter/
 * setter families for header fields other than totalsize, the overlay/check
 * and iteration helpers not referenced here, and the __ASSEMBLER__ and
 * sparse-checker machinery are omitted. Struct layout, tag/error values, and
 * signatures match upstream libfdt; the implementation is the system libfdt,
 * linked in as usual. */
#ifndef LIBFDT_H
#define LIBFDT_H

#include <stddef.h>
#include <stdint.h>
#include <string.h> /* strlen, for fdt_setprop_string */

typedef uint16_t fdt16_t;
typedef uint32_t fdt32_t;
typedef uint64_t fdt64_t;

struct fdt_header {
    fdt32_t magic;             /* magic word FDT_MAGIC */
    fdt32_t totalsize;         /* total size of DT block */
    fdt32_t off_dt_struct;     /* offset to structure */
    fdt32_t off_dt_strings;    /* offset to strings */
    fdt32_t off_mem_rsvmap;    /* offset to memory reserve map */
    fdt32_t version;           /* format version */
    fdt32_t last_comp_version; /* last compatible version */
    fdt32_t boot_cpuid_phys;   /* version 2: physical boot CPU id */
    fdt32_t size_dt_strings;   /* version 3: size of the strings block */
    fdt32_t size_dt_struct;    /* version 17: size of the structure block */
};

struct fdt_reserve_entry {
    fdt64_t address;
    fdt64_t size;
};

struct fdt_node_header {
    fdt32_t tag;
    char name[];
};

struct fdt_property {
    fdt32_t tag;
    fdt32_t len;
    fdt32_t nameoff;
    char data[];
};

#define FDT_MAGIC 0xd00dfeed
#define FDT_TAGSIZE sizeof(fdt32_t)
#define FDT_BEGIN_NODE 0x1 /* Start node: full name */
#define FDT_END_NODE 0x2   /* End node */
#define FDT_PROP 0x3       /* Property: name off, size, content */
#define FDT_NOP 0x4        /* nop */
#define FDT_END 0x9

/* Error codes: functions returning an int negate one of these on failure. */
#define FDT_ERR_NOTFOUND 1
#define FDT_ERR_EXISTS 2
#define FDT_ERR_NOSPACE 3
#define FDT_ERR_BADOFFSET 4
#define FDT_ERR_BADPATH 5
#define FDT_ERR_BADPHANDLE 6
#define FDT_ERR_BADSTATE 7
#define FDT_ERR_TRUNCATED 8
#define FDT_ERR_BADMAGIC 9
#define FDT_ERR_BADVERSION 10
#define FDT_ERR_BADSTRUCTURE 11
#define FDT_ERR_BADLAYOUT 12
#define FDT_ERR_INTERNAL 13
#define FDT_ERR_BADNCELLS 14
#define FDT_ERR_BADVALUE 15
#define FDT_ERR_BADOVERLAY 16
#define FDT_ERR_NOPHANDLES 17
#define FDT_ERR_BADFLAGS 18
#define FDT_ERR_ALIGNMENT 19
#define FDT_ERR_MAX 19

/* Device-tree integers are stored big-endian; these load/store one at an
 * arbitrary (possibly unaligned) address a byte at a time. */
static inline uint16_t fdt16_ld(const fdt16_t *p) {
    const uint8_t *bp = (const uint8_t *)p;
    return ((uint16_t)bp[0] << 8) | bp[1];
}
static inline uint32_t fdt32_ld(const fdt32_t *p) {
    const uint8_t *bp = (const uint8_t *)p;
    return ((uint32_t)bp[0] << 24) | ((uint32_t)bp[1] << 16) |
           ((uint32_t)bp[2] << 8) | bp[3];
}
static inline uint64_t fdt64_ld(const fdt64_t *p) {
    const uint8_t *bp = (const uint8_t *)p;
    return ((uint64_t)bp[0] << 56) | ((uint64_t)bp[1] << 48) |
           ((uint64_t)bp[2] << 40) | ((uint64_t)bp[3] << 32) |
           ((uint64_t)bp[4] << 24) | ((uint64_t)bp[5] << 16) |
           ((uint64_t)bp[6] << 8) | bp[7];
}
static inline void fdt32_st(void *property, uint32_t value) {
    uint8_t *bp = (uint8_t *)property;
    bp[0] = value >> 24;
    bp[1] = (value >> 16) & 0xff;
    bp[2] = (value >> 8) & 0xff;
    bp[3] = value & 0xff;
}
static inline void fdt64_st(void *property, uint64_t value) {
    uint8_t *bp = (uint8_t *)property;
    bp[0] = value >> 56;
    bp[1] = (value >> 48) & 0xff;
    bp[2] = (value >> 40) & 0xff;
    bp[3] = (value >> 32) & 0xff;
    bp[4] = (value >> 24) & 0xff;
    bp[5] = (value >> 16) & 0xff;
    bp[6] = (value >> 8) & 0xff;
    bp[7] = value & 0xff;
}
static inline fdt32_t cpu_to_fdt32(uint32_t x) {
    fdt32_t v;
    fdt32_st(&v, x);
    return v;
}
static inline uint32_t fdt32_to_cpu(fdt32_t x) { return fdt32_ld(&x); }
static inline fdt64_t cpu_to_fdt64(uint64_t x) {
    fdt64_t v;
    fdt64_st(&v, x);
    return v;
}
static inline uint64_t fdt64_to_cpu(fdt64_t x) { return fdt64_ld(&x); }

#define fdt_get_header(fdt, field) \
    (fdt32_ld(&((const struct fdt_header *)(fdt))->field))
#define fdt_totalsize(fdt) (fdt_get_header(fdt, totalsize))

/* Traversal and read-only access. */
int fdt_check_header(const void *fdt);
int fdt_check_full(const void *fdt, size_t bufsize);
uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
int fdt_next_node(const void *fdt, int offset, int *depth);
int fdt_first_subnode(const void *fdt, int offset);
int fdt_next_subnode(const void *fdt, int offset);
const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
int fdt_first_property_offset(const void *fdt, int nodeoffset);
int fdt_next_property_offset(const void *fdt, int offset);
const struct fdt_property *fdt_get_property_by_offset(const void *fdt, int offset,
                                                      int *lenp);
const void *fdt_getprop_by_offset(const void *fdt, int offset,
                                  const char **namep, int *lenp);
const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
                                            const char *name, int *lenp);
const void *fdt_getprop(const void *fdt, int nodeoffset, const char *name,
                        int *lenp);
uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
int fdt_parent_offset(const void *fdt, int nodeoffset);
int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
                               const char *name, int namelen);
int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
int fdt_path_offset(const void *fdt, const char *path);
int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
                                  const char *compatible);
int fdt_node_check_compatible(const void *fdt, int nodeoffset,
                              const char *compatible);
int fdt_address_cells(const void *fdt, int nodeoffset);
int fdt_size_cells(const void *fdt, int nodeoffset);
int fdt_find_max_phandle(const void *fdt, uint32_t *phandle);
const char *fdt_strerror(int errval);

/* Sequential-write construction (fdt_create ... fdt_finish). */
int fdt_create(void *buf, int bufsize);
int fdt_create_empty_tree(void *buf, int bufsize);
int fdt_open_into(const void *fdt, void *buf, int bufsize);
int fdt_finish_reservemap(void *fdt);
int fdt_begin_node(void *fdt, const char *name);
int fdt_end_node(void *fdt);
int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
int fdt_finish(void *fdt);
int fdt_pack(void *fdt);

/* Read-write modification of a fully-built tree. */
int fdt_setprop(void *fdt, int nodeoffset, const char *name, const void *val,
                int len);
int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
int fdt_nop_node(void *fdt, int nodeoffset);
int fdt_add_subnode_namelen(void *fdt, int parentoffset, const char *name,
                            int namelen);
int fdt_add_subnode(void *fdt, int parentoffset, const char *name);

/* Typed convenience wrappers over fdt_setprop. */
static inline int fdt_setprop_u32(void *fdt, int nodeoffset, const char *name,
                                  uint32_t val) {
    fdt32_t tmp = cpu_to_fdt32(val);
    return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_u64(void *fdt, int nodeoffset, const char *name,
                                  uint64_t val) {
    fdt64_t tmp = cpu_to_fdt64(val);
    return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
}
static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
                                   uint32_t val) {
    return fdt_setprop_u32(fdt, nodeoffset, name, val);
}
#define fdt_setprop_string(fdt, nodeoffset, name, str) \
    fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str) + 1)

static inline uint32_t fdt_get_max_phandle(const void *fdt) {
    uint32_t phandle;
    if (fdt_find_max_phandle(fdt, &phandle) < 0)
        return (uint32_t)-1;
    return phandle;
}

#define fdt_for_each_property_offset(property, fdt, node) \
    for (property = fdt_first_property_offset(fdt, node);  \
         property >= 0;                                    \
         property = fdt_next_property_offset(fdt, property))

#endif /* LIBFDT_H */
