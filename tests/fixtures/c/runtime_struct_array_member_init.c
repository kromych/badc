// A struct whose member is an array of structs, brace-initialized with at
// least one non-constant element value (`&g[i]`, an address that is only
// known at run time), takes the per-element runtime store path. Each array
// element must recurse into the struct initializer rather than be treated
// as a scalar leaf; trailing aggregate members and omitted elements keep the
// zero seed (C99 6.7.8p17/p20/p21). The values are read back to confirm the
// stores land at the right offsets.

static int g[4] = { 10, 20, 30, 40 };

typedef struct {
    const char *name;
    int *p;
    long addr;
    int t[3];
} Port;

typedef struct {
    const char *name;
    Port ports[4];
} Info;

int main(void) {
    Info x = { .name = "top", .ports = {
        { "p0", &g[0], 0x1000, { 1, 2, 3 } },
        { "p1", &g[2], 0x2000 },
    } };
    if (x.ports[0].p != &g[0]) return 1;
    if (*x.ports[0].p != 10) return 2;
    if (x.ports[0].addr != 0x1000) return 3;
    if (x.ports[0].t[0] != 1 || x.ports[0].t[2] != 3) return 4;
    if (x.ports[1].p != &g[2]) return 5;
    if (*x.ports[1].p != 30) return 6;
    if (x.ports[1].addr != 0x2000) return 7;
    if (x.ports[1].t[0] != 0) return 8;   /* elided trailing array stays zero */
    if (x.ports[1].name[0] != 'p') return 9;
    if (x.ports[2].name != 0) return 10;  /* omitted element stays zero */
    return 0;
}
