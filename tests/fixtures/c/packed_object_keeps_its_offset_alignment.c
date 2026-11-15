// A packed object's member read through a pointer of the member's type:
// the access is folded into its address by the object's offset in the
// unit's data, and the link then compacts that data, moving the object.
// The read must stay addressable at its width. `read_member` is defined,
// never called: run, its read would be misaligned. Returns 0 when the
// object keeps its value.

#pragma pack(1)
struct inner {
    long b;
};
union outer {
    struct inner d;
};
#pragma pack()

union outer e = {{9}};
const union outer f;
int g;

void read_member(void) {
    long *i = &e.d.b;
    g = (int)*i;
}

int main(void) {
    return e.d.b == 9 ? 0 : 1;
}
