// A GNU `__attribute__((aligned(N)))` on a typedef sets the alignment of
// the aliased type (C11 6.2.8 / GNU type attribute). Unlike `_Alignas` on
// an object or member, a type attribute may lower the alignment below the
// natural value, and it is honored by `__alignof__`, `sizeof`, struct /
// union field layout, and array element alignment. The values match
// gcc -O2 and clang and are target-independent (`unsigned long long` is
// 8-byte and `int` 4-byte on every supported data model).

typedef unsigned long long __attribute__((aligned(4))) u64a4; // reduce 8 -> 4
typedef int __attribute__((aligned(16))) i16;                 // increase 4 -> 16
typedef u64a4 u64a4_alias;                                    // propagates
typedef unsigned long long u64a2 __attribute__((aligned(2))); // post-declarator

struct SR { int a; u64a4 b; };
struct SI { char a; i16 b; };
struct SA { int a; u64a4_alias b; };
union UR { char a; u64a4 b; };
struct Nest { int a; u64a4 b; };
struct Outer { char c; struct Nest n; };

_Static_assert(__alignof__(u64a4) == 4, "reduced type alignment");
_Static_assert(sizeof(u64a4) == 8, "size is unchanged by the attribute");
_Static_assert(__alignof__(i16) == 16, "increased type alignment");
_Static_assert(sizeof(i16) == 4, "size is unchanged by the attribute");
_Static_assert(__alignof__(u64a4_alias) == 4, "propagated through a typedef");
_Static_assert(__alignof__(u64a2) == 2, "attribute after the declarator");
_Static_assert(__alignof__(u64a4 *) == 8, "a pointer keeps pointer alignment");
_Static_assert(__alignof__(u64a4[3]) == 4, "an array keeps element alignment");

_Static_assert(sizeof(struct SR) == 12, "reduced field lowers the struct size");
_Static_assert(__builtin_offsetof(struct SR, b) == 4, "reduced field offset");
_Static_assert(__alignof__(struct SR) == 4, "reduced field lowers struct align");
_Static_assert(sizeof(struct SI) == 32, "increased field raises the struct size");
_Static_assert(__builtin_offsetof(struct SI, b) == 16, "increased field offset");
_Static_assert(__alignof__(struct SI) == 16, "increased field raises struct align");
_Static_assert(sizeof(struct SA) == 12 && __builtin_offsetof(struct SA, b) == 4,
               "propagated field layout");
_Static_assert(sizeof(union UR) == 8 && __alignof__(union UR) == 4, "union alignment");
_Static_assert(sizeof(struct Outer) == 16 && __builtin_offsetof(struct Outer, n) == 4,
               "nested struct alignment");

int main(void) {
    // The reduced element is 8 bytes but 4-aligned, so an array of it is
    // contiguous with an 8-byte stride (align 4 divides size 8).
    u64a4 arr[3];
    if (sizeof(arr) != 24) return 1;
    if ((unsigned char *)&arr[1] - (unsigned char *)&arr[0] != 8) return 2;
    // The reduced field is reachable and round-trips its value.
    struct SR s;
    s.a = 7;
    s.b = 0x1122334455667788ULL;
    if (s.a != 7) return 3;
    if (s.b != 0x1122334455667788ULL) return 4;

    // A block-scope aligned typedef behaves the same, and its attribute
    // does not leak onto a following declaration.
    typedef unsigned long long __attribute__((aligned(4))) lu64a4;
    struct BR { int a; lu64a4 b; };
    struct After { int a; unsigned long long b; }; // no attribute in sight
    _Static_assert(__alignof__(lu64a4) == 4, "block-scope reduce");
    _Static_assert(sizeof(struct BR) == 12, "block-scope struct size");
    _Static_assert(__builtin_offsetof(struct BR, b) == 4, "block-scope offset");
    _Static_assert(sizeof(struct After) == 16, "no leak onto the next struct");
    _Static_assert(__builtin_offsetof(struct After, b) == 8, "no leak onto the offset");
    return 0;
}
