// linux/mman.h -- the kernel's memory-mapping flags (Linux UAPI), as
// <linux/mman.h> and the <asm/mman.h> chain it includes leave them defined.
// A macro <sys/mman.h> also defines is spelled as it spells it, so the
// two headers may come in either order.

#pragma once

#include <linux/types.h>

#define PROT_EXEC                 4
#define PROT_GROWSDOWN            0x01000000
#define PROT_GROWSUP              0x02000000
#define PROT_NONE                 0
#define PROT_READ                 1
#define PROT_SEM                  0x8
#define PROT_WRITE                2
#define PKEY_DISABLE_ACCESS       0x1
#define PKEY_DISABLE_WRITE        0x2
#define PKEY_UNRESTRICTED         0x0
#define MAP_HUGE_16GB             HUGETLB_FLAG_ENCODE_16GB
#define MAP_HUGE_16KB             HUGETLB_FLAG_ENCODE_16KB
#define MAP_HUGE_16MB             HUGETLB_FLAG_ENCODE_16MB
#define MAP_HUGE_1GB              HUGETLB_FLAG_ENCODE_1GB
#define MAP_HUGE_1MB              HUGETLB_FLAG_ENCODE_1MB
#define MAP_HUGE_256MB            HUGETLB_FLAG_ENCODE_256MB
#define MAP_HUGE_2GB              HUGETLB_FLAG_ENCODE_2GB
#define MAP_HUGE_2MB              HUGETLB_FLAG_ENCODE_2MB
#define MAP_HUGE_32MB             HUGETLB_FLAG_ENCODE_32MB
#define MAP_HUGE_512KB            HUGETLB_FLAG_ENCODE_512KB
#define MAP_HUGE_512MB            HUGETLB_FLAG_ENCODE_512MB
#define MAP_HUGE_64KB             HUGETLB_FLAG_ENCODE_64KB
#define MAP_HUGE_8MB              HUGETLB_FLAG_ENCODE_8MB
#define MAP_HUGE_MASK             HUGETLB_FLAG_ENCODE_MASK
#define MAP_HUGE_SHIFT            HUGETLB_FLAG_ENCODE_SHIFT
#define MAP_ANONYMOUS             0x20
#define MAP_DENYWRITE             0x0800
#define MAP_DROPPABLE             0x08
#define MAP_EXECUTABLE            0x1000
#define MAP_FILE                  0
#define MAP_FIXED                 0x10
#define MAP_FIXED_NOREPLACE       0x100000
#define MAP_GROWSDOWN             0x0100
#define MAP_HUGETLB               0x40000
#define MAP_LOCKED                0x2000
#define MAP_NONBLOCK              0x10000
#define MAP_NORESERVE             0x4000
#define MAP_POPULATE              0x8000
#define MAP_PRIVATE               0x02
#define MAP_SHARED                0x01
#define MAP_SHARED_VALIDATE       0x03
#define MAP_STACK                 0x20000
#define MAP_SYNC                  0x080000
#define MAP_TYPE                  0x0f
#define MAP_UNINITIALIZED         0x4000000
#define MLOCK_ONFAULT             0x01
#define MCL_CURRENT               1
#define MCL_FUTURE                2
#define MCL_ONFAULT               4
#define MS_ASYNC                  1
#define MS_INVALIDATE             2
#define MS_SYNC                   4
#define MADV_COLD                 20
#define MADV_COLLAPSE             25
#define MADV_DODUMP               17
#define MADV_DOFORK               11
#define MADV_DONTDUMP             16
#define MADV_DONTFORK             10
#define MADV_DONTNEED             4
#define MADV_DONTNEED_LOCKED      24
#define MADV_FREE                 8
#define MADV_GUARD_INSTALL        102
#define MADV_GUARD_REMOVE         103
#define MADV_HUGEPAGE             14
#define MADV_HWPOISON             100
#define MADV_KEEPONFORK           19
#define MADV_MERGEABLE            12
#define MADV_NOHUGEPAGE           15
#define MADV_NORMAL               0
#define MADV_PAGEOUT              21
#define MADV_POPULATE_READ        22
#define MADV_POPULATE_WRITE       23
#define MADV_RANDOM               1
#define MADV_REMOVE               9
#define MADV_SEQUENTIAL           2
#define MADV_SOFT_OFFLINE         101
#define MADV_UNMERGEABLE          13
#define MADV_WILLNEED             3
#define MADV_WIPEONFORK           18
#define MREMAP_DONTUNMAP          4
#define MREMAP_FIXED              2
#define MREMAP_MAYMOVE            1
#define OVERCOMMIT_ALWAYS         1
#define OVERCOMMIT_GUESS          0
#define OVERCOMMIT_NEVER          2
#define HUGETLB_FLAG_ENCODE_16GB  (34U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_16KB  (14U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_16MB  (24U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_1GB   (30U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_1MB   (20U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_256MB (28U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_2GB   (31U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_2MB   (21U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_32MB  (25U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_512KB (19U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_512MB (29U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_64KB  (16U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_8MB   (23U << HUGETLB_FLAG_ENCODE_SHIFT)
#define HUGETLB_FLAG_ENCODE_MASK  0x3f
#define HUGETLB_FLAG_ENCODE_SHIFT 26
#define SHADOW_STACK_SET_MARKER   (1ULL << 1)
#define SHADOW_STACK_SET_TOKEN    (1ULL << 0)

#if defined(__x86_64__)
#define PKEY_ACCESS_MASK          (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
#define MAP_32BIT                 0x40
#define MAP_ABOVE4G               0x80
#elif defined(__aarch64__)
#define PROT_BTI                  0x10
#define PROT_MTE                  0x20
#define PKEY_ACCESS_MASK          (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE | PKEY_DISABLE_READ | PKEY_DISABLE_EXECUTE)
#define PKEY_DISABLE_EXECUTE      0x4
#define PKEY_DISABLE_READ         0x8
#endif

struct cachestat_range {
    __u64 off;
    __u64 len;
};

struct cachestat {
    __u64 nr_cache;
    __u64 nr_dirty;
    __u64 nr_writeback;
    __u64 nr_evicted;
    __u64 nr_recently_evicted;
};
