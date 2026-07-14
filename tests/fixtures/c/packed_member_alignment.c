/* A member-level `__attribute__((packed))` clamps that field's alignment to 1
   (GCC semantics): it removes the field's leading padding and does not raise
   the aggregate's alignment. This is independent of a struct-level `packed`.
   The zero-length packed pointer-array member is the qemu COMPAT_HANDLE idiom:
   it must contribute neither storage nor alignment. Sizes use fixed-width
   types so the layout is data-model portable. Returns 0 on success. */
#include <stdint.h>

struct pm {
    uint8_t a;                             /* offset 0 */
    uint32_t b __attribute__((packed));    /* offset 1: no leading padding */
};

struct handle {
    uint32_t c;                             /* offset 0 */
    uint64_t *slot[0] __attribute__((packed)); /* no storage, no alignment */
};

int main(void) {
    if (sizeof(struct pm) != 5) return 1;
    if (__builtin_offsetof(struct pm, b) != 1) return 2;
    if (sizeof(struct handle) != 4) return 3;
    if (__builtin_offsetof(struct handle, c) != 0) return 4;

    /* Runtime read/write of the unaligned packed member. */
    struct pm s;
    s.a = 0xAA;
    s.b = 0x11223344u;
    if (s.a != 0xAA) return 5;
    if (s.b != 0x11223344u) return 6;
    return 0;
}
