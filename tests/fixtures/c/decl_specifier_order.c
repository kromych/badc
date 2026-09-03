/* C99 6.7.1: the specifiers of a declaration -- storage-class, type,
   type-qualifier, function-specifier -- may appear in any order, and
   6.7.2p2 makes the type specifiers of one declaration a multiset. File
   scope, block scope and a parameter list read the same spellings, so
   every order below declares the same object and folds the same value.
   Comparisons check the values and that internal linkage still applies. */

typedef long INTN;

INTN static file_fn(void) {              /* type before storage-class */
    return 7;
}

int static file_i = 3;                   /* type before storage-class */
unsigned const static int file_u = 5;    /* storage-class amid specifiers */
int const file_c = 9;                    /* qualifier after type */

static int block(void) {
    int static s = 4;                    /* block-scope, type first */
    unsigned static u = 6;               /* block-scope, type first */
    int const q = 2;                     /* block-scope qualifier after type */
    return s + (int)u + q;               /* 12 */
}

/* A trailing int modifier belongs to the base type at file scope as it
   does at block scope. */
int unsigned file_tu = 4294967295u;
int long file_tl = 4;
char unsigned file_tc = 200;
int static unsigned file_tsu = 4;

/* `typedef` is a storage-class specifier and takes any position. */
int typedef word;
struct pair {
    int a;
    int b;
} typedef pair;
enum { four = 4 } typedef digit;

/* A `const` object folds its initializer into a later constant
   expression whatever the order of the specifiers around it. */
static int const bound_a = 4;
static const int bound_b = 4;
int const static bound_c = 4;
int static const bound_d = 4;
static int fold_a[bound_a];
static int fold_b[bound_b];
static int fold_c[bound_c];
static int fold_d[bound_d];

/* Qualifiers that fold no value still qualify the object. */
static volatile int file_v = 4;
int volatile static file_w = 4;
static _Atomic int file_at = 4;
int _Atomic static file_au = 4;
int static _Atomic file_av = 4;

/* C99 6.7.5.1: `restrict` qualifies the pointer, so it follows the `*`
   while the storage class stays among the declaration specifiers. */
static int target = 4;
static int *restrict file_p = &target;
int static *restrict const file_q = &target;

/* A function specifier is one more specifier of the declaration. */
int static inline four_a(void) { return 4; }
inline static int four_b(void) { return 4; }
int inline static four_c(void) { return 4; }

/* C99 6.7.5.3p2: `register` is the only storage class a parameter takes;
   a qualifier may precede or follow the type. */
static int takes_register(register const int k) { return k; }
static int takes_qualified(const int a, int const b, volatile int c, int _Atomic d) {
    return a + b + c + d;
}

int main(void) {
    if (file_fn() != 7)
        return 1;
    if (file_i != 3)
        return 2;
    if (file_u != 5)
        return 3;
    if (file_c != 9)
        return 4;
    if (block() != 12)
        return 5;

    if (file_tu <= 0)                    /* signed int would compare below 0 */
        return 6;
    if (sizeof file_tl != sizeof(long))
        return 7;
    if (file_tc <= 100)                  /* signed char would be negative */
        return 8;
    if (file_tsu != 4u)
        return 9;

    word w = 4;
    pair p = {1, 3};
    digit d = four;
    if (w + p.a + p.b + (int)d != 12)
        return 10;

    if (sizeof fold_a / sizeof fold_a[0] != 4)
        return 11;
    if (sizeof fold_b / sizeof fold_b[0] != 4)
        return 12;
    if (sizeof fold_c / sizeof fold_c[0] != 4)
        return 13;
    if (sizeof fold_d / sizeof fold_d[0] != 4)
        return 14;

    static int const block_bound = 4;
    int block_fold[block_bound];
    if (sizeof block_fold / sizeof block_fold[0] != 4)
        return 15;

    if (file_v + file_w + file_at + file_au + file_av != 20)
        return 16;
    if (*file_p + *file_q != 8)
        return 17;
    if (four_a() + four_b() + four_c() != 12)
        return 18;
    if (takes_register(4) != 4)
        return 19;
    if (takes_qualified(1, 1, 1, 1) != 4)
        return 20;

    volatile int bv = 4;
    int volatile bw = 4;
    _Atomic int ba = 4;
    int _Atomic bb = 4;
    register const int br = 4;
    if (bv + bw + ba + bb + br != 20)
        return 21;
    return 0;
}
