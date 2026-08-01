// Static initialization of a multi-dimensional flexible array member
// (a GCC/clang extension over C99 6.7.2.1p18): each top-level entry
// is a row of inner-dimension struct elements, filled through the
// shared struct-array walker; the object's tail grows per row.

struct pair { unsigned char idx, shift; };
struct legacy {
    int len;
    struct pair sp[][2];
};

static struct legacy leg = {
    .len = 3,
    .sp = {
        { { 0, 7 }, { 0, 12 } },
        { { 0, 17 }, { 1, 22 } },
        { { 1, 5 }, { 1, 10 } },
    },
};

int main(void) {
    if (leg.len != 3) return 1;
    if (leg.sp[0][0].shift != 7 || leg.sp[0][1].shift != 12) return 2;
    if (leg.sp[1][1].idx != 1 || leg.sp[1][1].shift != 22) return 3;
    if (leg.sp[2][0].idx != 1 || leg.sp[2][0].shift != 5) return 4;
    if (leg.sp[2][1].shift != 10) return 5;
    return 0;
}
