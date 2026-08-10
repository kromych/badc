// A struct whose only member is an anonymous struct holding an empty
// struct and a flexible array has size 0, and keeps it when `packed`
// follows the body and re-lays the members. This is what the kernel's
// `__DECLARE_FLEX_ARRAY` macro expands to; btrfs uses it for the on-disk
// stripe extent header, whose item size is computed as
// `sizeof(header) + n * sizeof(entry)`. Values come from gcc 16 on
// linux/x86_64 and linux/aarch64.

#include <stddef.h>

#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
    struct {                           \
        struct {                       \
        } __empty_##NAME;              \
        TYPE NAME[];                   \
    }

struct raid_stride {
    unsigned long long devid;
    unsigned long long offset;
};

struct stripe_extent {
    DECLARE_FLEX_ARRAY(struct raid_stride, strides);
} __attribute__((packed));

// The same shape without `packed`.
struct stripe_extent_unpacked {
    DECLARE_FLEX_ARRAY(struct raid_stride, strides);
};

// The pieces on their own.
struct empty {
};
struct empty_packed {
} __attribute__((packed));
struct empty_and_flex {
    struct {
    } pad;
    int a[];
};
struct empty_and_flex_packed {
    struct {
    } pad;
    int a[];
} __attribute__((packed));

// The macro after a real member, and inside a union.
struct with_header {
    int hdr;
    DECLARE_FLEX_ARRAY(int, tail);
};
union flex_union {
    int x;
    DECLARE_FLEX_ARRAY(int, tail);
};
union flex_union_packed {
    int x;
    DECLARE_FLEX_ARRAY(int, tail);
} __attribute__((packed));

// `packed` removes the padding between a struct's own members, not the
// padding inside a member's type: the anonymous union below keeps the
// 4-byte alignment its widest arm gives it and stays 12 bytes wide, so
// the enclosing struct is 13. The shape is the ChromeOS EC host-command
// parameter block, whose arms mix packed and unpacked structs.
struct arm_packed {
    unsigned char sensor_num;
    unsigned short flags;
    short temp;
    short offset[3];
} __attribute__((packed));
struct arm_aligned {
    unsigned char sensor_num;
    unsigned char roundup;
    unsigned short reserved;
    int data;
};
struct ec_params {
    unsigned char cmd;
    union {
        struct arm_packed sensor_offset;
        struct arm_aligned ec_rate;
    };
} __attribute__((packed));

int main(void) {
    if (sizeof(struct arm_packed) != 11) return 16;
    if (sizeof(struct arm_aligned) != 8) return 17;
    if (_Alignof(struct arm_aligned) != 4) return 18;
    if (sizeof(struct ec_params) != 13) return 19;
    if (offsetof(struct ec_params, sensor_offset) != 1) return 20;
    if (offsetof(struct ec_params, ec_rate) != 1) return 21;

    if (sizeof(struct stripe_extent) != 0) return 1;
    if (_Alignof(struct stripe_extent) != 1) return 2;
    if (sizeof(struct stripe_extent_unpacked) != 0) return 3;
    if (_Alignof(struct stripe_extent_unpacked) != 8) return 4;

    if (sizeof(struct empty) != 0) return 5;
    if (sizeof(struct empty_packed) != 0) return 6;
    if (sizeof(struct empty_and_flex) != 0) return 7;
    if (sizeof(struct empty_and_flex_packed) != 0) return 8;

    if (sizeof(struct with_header) != 4) return 9;
    if (offsetof(struct with_header, tail) != 4) return 10;
    if (sizeof(union flex_union) != 4) return 11;
    if (sizeof(union flex_union_packed) != 4) return 12;

    // The on-disk item size an allocator computes for n strides is
    // exactly n entries: the header contributes nothing.
    if (sizeof(struct stripe_extent) + 3 * sizeof(struct raid_stride) != 48) return 13;

    // The flexible array starts at offset 0 and is addressable through
    // a buffer sized that way.
    {
        static unsigned char buf[2 * sizeof(struct raid_stride)];
        struct stripe_extent *se = (struct stripe_extent *) buf;
        se->strides[0].devid = 1;
        se->strides[0].offset = 2;
        se->strides[1].devid = 3;
        se->strides[1].offset = 4;
        if ((unsigned char *) &se->strides[0] != buf) return 14;
        if (se->strides[1].devid != 3 || se->strides[1].offset != 4) return 15;
    }
    return 0;
}
