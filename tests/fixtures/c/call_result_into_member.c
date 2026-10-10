// A small aggregate a call returns in registers, assigned to the leading
// member of a larger object: the assignment writes the member's bytes alone
// (C99 6.5.16.1p2), so the member after it keeps its value, whether the
// object is a local whose address escapes later or a by-value parameter.
// Unions, bit-fields and floats sharing an eightbyte keep the result in the
// call's result object rather than in its fields. The sizes cover a
// register's low 1 to 7 bytes and a partial second register, in integer and
// floating-point classes. The exit code names the first failing shape.

#define NOINLINE __attribute__((noinline))

union U1 { unsigned char a; signed char b; };
union U2 { unsigned short a; unsigned char b[2]; };
union U3 { unsigned char a[3]; signed char b; };
struct B4 { unsigned a : 20, b : 10; };
union U5 { unsigned char a[5]; signed char b; };
union U6 { unsigned short a[3]; unsigned char b[6]; };
union U7 { unsigned char a[7]; signed char b; };
union U12 { int a[3]; short b; };
struct F3 { float a, b, c; };
struct FI { float a; int b; char c; };

#define OUTER(T)                                                                  \
    struct L##T {                                                                 \
        T m0;                                                                     \
        unsigned char m1;                                                         \
    };                                                                            \
    struct P##T {                                                                 \
        T m0;                                                                     \
        unsigned char m1;                                                         \
        unsigned long long pad[5];                                                \
    }

typedef union U1 U1;
typedef union U2 U2;
typedef union U3 U3;
typedef struct B4 B4;
typedef union U5 U5;
typedef union U6 U6;
typedef union U7 U7;
typedef union U12 U12;
typedef struct F3 F3;
typedef struct FI FI;
OUTER(U1);
OUTER(U2);
OUTER(U3);
OUTER(B4);
OUTER(U5);
OUTER(U6);
OUTER(U7);
OUTER(U12);
OUTER(F3);
OUTER(FI);

static void *escaped;

NOINLINE static void keep(void *p) { escaped = p; }

NOINLINE static U1 mk_U1(int n) { U1 v = {(unsigned char)n}; return v; }
NOINLINE static U2 mk_U2(int n) { U2 v = {(unsigned short)n}; return v; }
NOINLINE static U3 mk_U3(int n) { U3 v = {{(unsigned char)n, 2, 3}}; return v; }
NOINLINE static B4 mk_B4(int n) { B4 v = {(unsigned)n, 1023}; return v; }
NOINLINE static U5 mk_U5(int n) { U5 v = {{(unsigned char)n, 2, 3, 4, 5}}; return v; }
NOINLINE static U6 mk_U6(int n) { U6 v = {{(unsigned short)n, 2, 3}}; return v; }
NOINLINE static U7 mk_U7(int n) { U7 v = {{(unsigned char)n, 2, 3, 4, 5, 6, 7}}; return v; }
NOINLINE static U12 mk_U12(int n) { U12 v = {{n, 2, 3}}; return v; }
NOINLINE static F3 mk_F3(int n) { F3 v = {(float)n, 2, 3}; return v; }
NOINLINE static FI mk_FI(int n) { FI v = {(float)n, 2, 3}; return v; }

// A local whose address escapes after the assignment.
#define LOCAL(T, FIRST)                                                           \
    NOINLINE static int local_##T(int n)                                          \
    {                                                                             \
        struct L##T a;                                                            \
        a.m1 = 0x55;                                                              \
        a.m0 = mk_##T(n);                                                         \
        keep(&a);                                                                 \
        return ((struct L##T *)escaped)->m1 == 0x55 && (int)a.m0.FIRST == n;      \
    }

// A by-value parameter too large for registers, assigned and returned.
#define PARAM(T, FIRST)                                                           \
    NOINLINE static struct P##T param_##T(struct P##T a, int n)                   \
    {                                                                             \
        a.m0 = mk_##T(n);                                                         \
        return a;                                                                 \
    }                                                                             \
    NOINLINE static int check_param_##T(int n)                                    \
    {                                                                             \
        struct P##T a = {0};                                                      \
        a.m1 = 0x55;                                                              \
        struct P##T r = param_##T(a, n);                                          \
        return r.m1 == 0x55 && (int)r.m0.FIRST == n;                              \
    }

#define BOTH(T, FIRST) LOCAL(T, FIRST) PARAM(T, FIRST)

BOTH(U1, a)
BOTH(U2, a)
BOTH(U3, a[0])
BOTH(B4, a)
BOTH(U5, a[0])
BOTH(U6, a[0])
BOTH(U7, a[0])
BOTH(U12, a[0])
BOTH(F3, a)
BOTH(FI, a)

int main(void)
{
    int (*const checks[])(int) = {
        local_U1, check_param_U1, local_U2,  check_param_U2,  local_U3, check_param_U3,
        local_B4, check_param_B4, local_U5,  check_param_U5,  local_U6, check_param_U6,
        local_U7, check_param_U7, local_U12, check_param_U12, local_F3, check_param_F3,
        local_FI, check_param_FI,
    };
    for (unsigned i = 0; i < sizeof checks / sizeof checks[0]; i++)
        if (!checks[i](39))
            return (int)i + 1;
    return 0;
}
