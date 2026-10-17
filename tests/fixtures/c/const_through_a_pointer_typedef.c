/* A `const` that applies to a pointer typedef qualifies the object itself
 * (C99 6.7.3, 6.7.7), whatever the spelling: a later initializer reads it
 * as it reads `T *const p`, an element of an array of such pointers reads
 * as one, code reads them as constants, and a typedef'd `const int` sizes
 * an array as `const int` does. A pointer to const through a typedef stays
 * writable. Returns 0. */
typedef long (*fn)(void);
typedef char *cp_t;
typedef char *const ccp_t;
typedef const int ci_t;
typedef const char *cstr_t;
typedef int (*handler)(int);
struct S {
    int a;
};
typedef struct S *sp_t;

static long fb(void) { return 2; }
static int h0(int x) { return x + 1; }
static int h1(int x) { return x + 2; }

static char s[] = "ab";
static struct S st = {5};

static const fn c1 = fb;
static fn const c2 = fb;
static const cp_t c3 = s;
static ccp_t c4 = s + 1;
static const sp_t c5 = &st;
static handler const tab[2] = {h0, h1};
static ci_t n = 3;
static char buf[n];
static cstr_t names[2] = {"x", "y"};

static fn q1 = c1;
static fn q2 = c2;
static char *q3 = c3;
static char *q4 = c4;
static struct S *q5 = c5;
static handler q6 = tab[1];

int main(void) {
    static const fn l1 = fb;
    static fn lq = l1;
    static handler const ltab[1] = {h1};
    static handler lh = ltab[0];
    if (q1() + q2() + lq() != 6 || q3[0] != 'a' || *q4 != 'b' || q5->a != 5) {
        return 1;
    }
    if (q6(1) != 3 || lh(2) != 4 || sizeof buf != 3) {
        return 2;
    }
    if (c1() + c2() != 4 || c3[1] != 'b' || c5->a != 5 || tab[0](1) != 2) {
        return 3;
    }
    names[0] = "z";
    return names[0][0] == 'z' && names[1][0] == 'y' ? 0 : 4;
}
