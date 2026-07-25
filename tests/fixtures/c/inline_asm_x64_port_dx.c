/* x86-64 port operand `(%%dx)`: the parenthesized DX spelling of the
 * variable-port in/out family, equivalent to the bare `%%dx` form. Port
 * access faults outside ring 0, so the calls sit behind a volatile guard
 * that stays closed at run time; the encodings are locked by snapshot. */

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

static u8 in8(u16 port) {
    u8 v;
    __asm__ volatile("inb (%%dx), %b0" : "=a"(v) : "d"(port));
    return v;
}
static u16 in16(u16 port) {
    u16 v;
    __asm__ volatile("inw (%%dx), %w0" : "=a"(v) : "d"(port));
    return v;
}
static u32 in32(u16 port) {
    u32 v;
    __asm__ volatile("inl (%%dx), %0" : "=a"(v) : "d"(port));
    return v;
}
static void out8(u8 value, u16 port) {
    __asm__ volatile("outb %b0, (%%dx)" : : "a"(value), "d"(port));
}
static void out16(u16 value, u16 port) {
    __asm__ volatile("outw %w0, (%%dx)" : : "a"(value), "d"(port));
}
static void out32(u32 value, u16 port) {
    __asm__ volatile("outl %0, (%%dx)" : : "a"(value), "d"(port));
}

static volatile int touch_ports = 0;

int main(void) {
    if (touch_ports) {
        out8(in8(0x70), 0x70);
        out16(in16(0x70), 0x70);
        out32(in32(0x70), 0x70);
    }
    return 42;
}
