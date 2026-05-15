// Locks C99 6.7.2.1 paragraph 11: a bitfield's addressable
// storage unit width is implementation-defined, but consecutive
// bitfields of the same base type must share a unit, and the
// struct's size respects the base type's width. The 8 / 16 / 32
// / 64-bit base types each pick a unit of their own width.
//
// Treating every bitfield as if it lived in an 8-byte unit
// inflates the size of a uint32_t-based struct from 4 to 8 (and
// uint8_t / uint16_t analogously); a downstream `array[idx]`
// then strides by the wrong amount, and a downstream
// `read-modify-write` on the underlying word reads / writes
// past the unit and clobbers adjacent fields.
//
// Each failure returns a distinct nonzero code.

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

struct s8  { uint8_t  a : 4, b : 4; };
struct s16 { uint16_t a : 8, b : 8; };
struct s32 { uint32_t a : 8, b : 1, c : 23; };
struct s64 { uint64_t a : 36, b : 28; };

int main(void) {
    // Each base type sizes its struct to its own width.
    if (sizeof(struct s8)  != 1) return 11;
    if (sizeof(struct s16) != 2) return 12;
    if (sizeof(struct s32) != 4) return 13;
    if (sizeof(struct s64) != 8) return 14;

    // Array stride matches sizeof.
    {
        struct s32 arr[3];
        if ((char*)&arr[1] - (char*)&arr[0] != 4) return 15;
        if ((char*)&arr[2] - (char*)&arr[0] != 8) return 16;
    }

    // RMW on one field must not disturb adjacent fields.
    {
        struct s32 v;
        v.a = 0xab;
        v.b = 1;
        v.c = 0x12345;
        if (v.a != 0xab) return 17;
        if (v.b != 1) return 18;
        if (v.c != 0x12345) return 19;
        // Mutating one field must preserve the others.
        v.a = 0x55;
        if (v.a != 0x55) return 20;
        if (v.b != 1) return 21;
        if (v.c != 0x12345) return 22;
    }

    // Two adjacent uint32_t-based structs must not share storage:
    // a write into one's bitfield does not bleed into the other.
    {
        struct { struct s32 x; struct s32 y; } pair;
        pair.x.a = 0xff;
        pair.x.b = 1;
        pair.x.c = 0x7FFFFF;
        pair.y.a = 0;
        pair.y.b = 0;
        pair.y.c = 0;
        if (pair.y.a != 0) return 23;
        if (pair.y.b != 0) return 24;
        if (pair.y.c != 0) return 25;
    }

    return 0;
}
