/* A packed __int128 member at an odd address: each read and write of the
 * 128-bit value, the low-half narrowing, and a constant global placed after
 * a one-byte object. */
#pragma pack(push, 1)
struct s {
    __int128 b;
    long c;
    short d;
    int e;
};
#pragma pack(pop)

const struct s f;
const char g;
const struct s h = {((__int128)7 << 64) | 5, 9, 1, 2};
char pad;
struct s m = {((__int128)3 << 64) | 11, 0, 0, 0};

int main(void) {
    if ((int)h.b != 5) return 1;
    if ((long)(h.b >> 64) != 7) return 2;
    if (!h.b) return 3;
    if ((double)h.b != 129127208515966861317.0) return 4;
    if (h.b ? 0 : 1) return 5;
    switch (m.b) {
    case 11: return 6;
    default: break;
    }
    m.b += 1;
    if ((int)m.b != 12 || (long)(m.b >> 64) != 3) return 7;
    m.b++;
    if ((int)m.b != 13) return 8;
    m.b = h.b * 2;
    if ((int)m.b != 10 || (long)(m.b >> 64) != 14) return 9;
    return f.c + g;
}
