// C99 6.9.2p2: a tentative definition defines its object with the type the
// unit ends with. An object declared while its struct, union or enum type
// was incomplete is sized and aligned by the completed type, so the objects
// declared after it keep their own storage, and the references made before
// the completion denote the same object. Returns 0, distinct non-zero per
// failure.

enum E;
enum P;

struct S first;
long long guard = 0x1122334455667788LL;
struct S *first_ref = &first;
int w1;

struct S pair1, pair2;
int w2;

union U u;
int w3;

typedef struct S S_t;
S_t via_typedef;
int w4;

static struct S internal;
static int w5;

char c1;
struct A over;
char c2;

enum E wide;
int w6;

enum P narrow;
char c3;

struct S redeclared;
struct S defined;

static struct S *first_early(void) { return &first; }
static struct S *redeclared_early(void) { return &redeclared; }
static struct S *defined_early(void) { return &defined; }

struct S { long a, b, c; };
union U { long l; char bytes[24]; };
struct A { _Alignas(32) long x; long y; };
enum E { E_LO = -1, E_HI = 0x100000000LL };
enum P { P_A = 1, P_B = 2 } __attribute__((packed));

struct S redeclared;
struct S defined = { 7, 8, 9 };
long *first_c = &first.c;

int main(void) {
    if (first.a || first.b || first.c || pair2.c || u.l || over.y) return 1;
    first.a = 1;
    first.b = 2;
    first.c = 3;
    w1 = 0;
    if (first.b != 2 || first.c != 3 || guard != 0x1122334455667788LL) return 2;
    if (first_ref != &first || first_early() != &first || first_c != &first.c) return 3;
    pair1.c = 4;
    pair2.a = 5;
    pair2.c = 6;
    w2 = 0;
    if (pair1.c != 4 || pair2.a != 5 || pair2.c != 6) return 4;
    u.bytes[23] = 7;
    w3 = 0;
    if (u.bytes[23] != 7 || sizeof u != 24) return 5;
    via_typedef.c = 8;
    w4 = 0;
    if (via_typedef.c != 8) return 6;
    internal.c = 9;
    w5 = 0;
    if (internal.c != 9) return 7;
    over.y = 10;
    c1 = c2 = 11;
    if ((unsigned long)&over % 32 != 0 || over.y != 10) return 8;
    wide = E_HI;
    w6 = 0;
    if (sizeof wide != sizeof(enum E) || wide != E_HI) return 9;
    wide = E_LO;
    if (wide != E_LO) return 10;
    narrow = P_B;
    c3 = 12;
    if (sizeof narrow != sizeof(enum P) || narrow != P_B || c3 != 12) return 11;
    redeclared.c = 13;
    if (redeclared_early() != &redeclared || redeclared_early()->c != 13) return 12;
    if (defined_early() != &defined || defined_early()->b != 8 || defined.c != 9) return 13;
    return 0;
}
