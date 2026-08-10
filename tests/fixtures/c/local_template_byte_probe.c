// A byte-level layout probe: a designated-init compound literal (and a
// union initialized through a nested member) is filled from a staged
// constant template, so reading a byte of it before any other write
// yields the template byte -- including a baked bitfield -- and the
// guard on it decides; the arm calling a never-defined helper drops.
// A write between the fill and the read takes the runtime path with the
// same values. -O only: const-object loads are an optimizer capability.

typedef unsigned char u8;
extern void absent_layout_arm(void);
extern void absent_union_arm(void);

struct hdr {
    u8 tag;
    u8 len;
    u8 low : 7;
    u8 top : 1;
    unsigned int body;
};

int main(void) {
    if (((u8 *)&(struct hdr){.tag = 3})[0] != 3)
        absent_layout_arm();
    if (((u8 *)&(struct hdr){.top = 1})[2] != 0x80)
        absent_layout_arm();
    union {
        unsigned int val;
        struct {
            unsigned int inner;
        } lock;
    } u = {.lock = {0}};
    if (u.val != 0)
        absent_union_arm();

    struct hdr h = {.tag = 3, .len = 9};
    u8 *p = (u8 *)&h;
    p[1] = 5;
    if (p[0] != 3)
        return 1;
    if (p[1] != 5)
        return 2;
    return u.val == 0 ? 0 : 3;
}
