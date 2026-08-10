/* C99 6.5.3.4p4: sizeof and _Alignof yield size_t, an unsigned integer
 * type -- pointer-wide on both LP64 (unsigned long) and LLP64
 * (unsigned long long). The signedness is observable through the usual
 * arithmetic conversions and through typeof. */

typedef struct {
    unsigned long long w;
} entry_t;

static int g;

#define IS_SIGNED_TYPE(type) (((type)(-1)) < ((type)1))

int main(void) {
    int pos = 3;

    /* Unsigned result: arithmetic with negative ints wraps high. */
    if (!(sizeof(int) * -1 > 0))
        return 1;
    if (!(sizeof(char) - 2 > 0))
        return 2;
    if (!(_Alignof(long long) * -1 > 0))
        return 3;

    /* size_t identity: unsigned, per the target's data model. */
    if (!_Generic(sizeof(0), unsigned long: 1, unsigned long long: 1, default: 0))
        return 4;
    if (!_Generic(_Alignof(int), unsigned long: 1, unsigned long long: 1, default: 0))
        return 5;
    if (sizeof(sizeof(0)) != sizeof(void *))
        return 6;

    /* typeof carries the unsignedness. */
    if (IS_SIGNED_TYPE(typeof(sizeof(g))))
        return 7;
    if (IS_SIGNED_TYPE(typeof(sizeof(entry_t) * pos)))
        return 8;
    if (IS_SIGNED_TYPE(typeof(sizeof(g) + 0)))
        return 9;
    typeof(sizeof(0)) v = (typeof(sizeof(0)))-1;
    if (!(v > 0))
        return 10;

    /* Mixed expressions convert to the unsigned common type. */
    if (sizeof(entry_t) * pos != 24)
        return 11;
    if ((sizeof(entry_t) * -pos > 0) != 1)
        return 12;
    return 0;
}
