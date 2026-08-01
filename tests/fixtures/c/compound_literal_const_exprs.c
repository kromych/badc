// C99 6.5.2.5 compound literals in constant-expression positions:
// a scalar-typed literal's value (converted to the type, relocations
// kept), an array-typed literal subscripted (the staged element read
// back, at file scope and as an enum value), and the address of a
// member designated inside a struct literal (6.6p9).

static int s1 = ((const unsigned short []){ 10, 20, 30 })[2];
static int s2 = (int []){ 7, 8, 9 }[1];
enum { E1 = ((int []){ 7, 8, 9 })[1] };
static int s3 = ((signed char []){ -5, -6 })[1];

static int target;
struct gate { int id; };
static struct gate g1;
static struct gate *pg = (struct gate *) { &(g1) };
static int *pi = (int *){ &target };
static int s4 = (int){ 40 } + (short){ 2 };
static unsigned char s5 = (unsigned char){ 0x1ff };

struct inner { int x; int y; };
struct outer { struct inner in; int tail; };
static int *pm = &((struct outer){ { 31, 32 }, 33 }).in.y;

struct tn { int t; };
static int empty_sz = (int)sizeof((struct tn[]){});

int main(void) {
    if (s1 != 30 || s2 != 8 || E1 != 8 || s3 != -6) return 1;
    if (pg != &g1 || pi != &target) return 2;
    if (s4 != 42 || s5 != 255) return 3;
    if (*pm != 32) return 4;
    if (empty_sz != 0) return 5;
    return 0;
}
