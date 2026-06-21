// Locks C99 6.7.2.1: a union with a named bitfield member sizes and
// aligns to that member's declared storage unit. The earlier layout
// gave such a union sizeof 0 and alignment 1, so a bitfield store wrote
// past the union and arrays of it overlapped.
//
// Each failure returns a distinct nonzero code.

union u1 { int a : 4; };
union u2 { char c; int a : 20; };
union u3 { long long a : 40; char c; };
union u4 { char c; int a : 4; };

struct probe { char c; union u1 u; };

int main(void) {
    if (sizeof(union u1) != 4) return 11;
    if (sizeof(union u2) != 4) return 12;
    if (sizeof(union u3) != 8) return 13;
    if (sizeof(union u4) != 4) return 14;

    // Alignment: a char before the union must pad to the union's
    // 4-byte alignment (1 + 3 pad + 4 == 8); align-1 would give 5.
    if (sizeof(struct probe) != 8) return 21;

    // A store through the bitfield stays inside the union; an array
    // must not overlap (stride == sizeof).
    union u1 arr[2];
    arr[0].a = 5;
    arr[1].a = 3;
    if (arr[0].a != 5) return 31;
    if (arr[1].a != 3) return 32;
    return 0;
}
