// A static initializer reads a scalar that a `[i]` / `.field` chain reaches
// in a `const` array or aggregate with static storage: the value, as GCC and
// Clang fold it (C99 6.6p10), not the element's address. A chain that stops
// at a row still decays to its address. Every value is checked at run time.

typedef unsigned long long hwaddr;
enum { RAM, UART1, UART2, NMAP };

static const struct {
    hwaddr addr;
    unsigned long size;
    const char *name;
} memmap[NMAP] = {
    [RAM] = {0x40000000, 0x1000, "ram"},
    [UART1] = {0x30860000, 0x10000, "uart1"},
    [UART2] = {0x30890000, 0x10000, "uart2"},
};
static const int arr[] = {10, 20, 30};
static const int m[2][3] = {{1, 2, 3}, {4, 5, 6}};
static const unsigned char uc[] = {200};
static const signed char sc[] = {-5};
static const struct {
    float f;
    double d;
} fd[] = {{1.5f, 2.25}};
static const union {
    int i;
    unsigned char c[4];
} u = {0x01020304};
static const struct {
    struct {
        int a[3];
    } in;
} ns[2] = {{{{1, 2, 3}}}, {{{4, 5, 6}}}};

int b = arr[1];
long k = arr[1] * 2 + (long)(memmap[UART1].addr / 0x10000);
int e = m[1][0];
const int *row = m[1];
const int *elem = &arr[2];
int ucv = uc[0], scv = sc[0];
double fsum = fd[0].f + fd[0].d;
int uv = u.i;
int nsv = ns[1].in.a[2];

int main(void) {
    static const struct {
        hwaddr addr;
        unsigned int irq;
    } table[2] = {
        {memmap[UART1].addr, 26},
        {memmap[UART2].addr + 4, 27},
    };
    static const short lm[2][2] = {{7, 8}, {9, 10}};
    static int local = arr[2] - arr[0] + lm[1][1];
    char buf[arr[2]];
    int bad = 0;
    if (table[0].addr != 0x30860000 || table[1].addr != 0x30890004 || table[1].irq != 27)
        bad |= 1;
    if (b != 20 || k != 40 + 0x3086)
        bad |= 2;
    if (e != 4 || row[2] != 6 || *elem != 30)
        bad |= 4;
    if (ucv != 200 || scv != -5)
        bad |= 8;
    if (fsum != 3.75)
        bad |= 16;
    if (uv != 0x01020304 || nsv != 6)
        bad |= 32;
    if (local != 30 || sizeof buf != 30)
        bad |= 64;
    return bad;
}
