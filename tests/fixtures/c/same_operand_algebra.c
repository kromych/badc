/* Integer operations whose result one operand decides: an operand
   combined with itself (`x ^ x`, `x - x` are 0; `x & x`, `x | x` are
   `x`) and an `|` whose constant sets every bit the result keeps. */

int xor_self(int x) { return x ^ x; }
int sub_self(int x) { return x - x; }
int and_self(int x) { return x & x; }
int or_self(int x) { return x | x; }
int or_all_ones(int x) { return x | -1; }
unsigned or_all_ones_unsigned(unsigned x) { return x | 0xFFFFFFFFu; }
unsigned char or_all_ones_char(unsigned char x) { return x | 0xFF; }
int or_then_mask(int x) { return (x | 0xF0) & 0x30; }
int or_then_wider_mask(int x) { return (x | 0xF0) & 0x1F0; }

int main(void) {
    volatile int seed = 0x1234;
    int x = seed;
    if (xor_self(x) != 0 || sub_self(x) != 0) return 1;
    if (and_self(x) != x || or_self(x) != x) return 2;
    if (or_all_ones(x) != -1 || or_all_ones_unsigned(x) != 0xFFFFFFFFu) return 3;
    if (or_all_ones_char((unsigned char)x) != 0xFF) return 4;
    if (or_then_mask(x) != 0x30) return 5;
    if (or_then_wider_mask(x) != ((0x1234 & 0x100) | 0xF0)) return 6;
    return 0;
}
