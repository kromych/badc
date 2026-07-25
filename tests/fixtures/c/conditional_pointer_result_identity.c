/* C99 6.5.15p6 result-type identity for pointer-armed conditionals,
 * observed through _Generic: a null pointer constant arm takes the
 * other arm's type; otherwise a `void *` arm wins over any object
 * pointer, character pointers included. `void` is a distinct type
 * (6.2.5p19), so `void *` never matches a character-pointer
 * association, while its representation keeps the GNU extensions:
 * sizeof(void) == 1 and one-byte `void *` arithmetic. */

static int g;

#define IS(e, T) _Generic((e), T: 1, default: 0)

typedef void V;

int main(void) {
    void *vp = &g;
    char *cp = 0;
    unsigned char *ucp = 0;
    int *ip = &g;
    long *lp = 0;
    V *tp = &g;

    /* void* vs object pointer: pointer-to-void, either arm order. */
    if (!IS(1 ? vp : ip, void *))
        return 1;
    if (!IS(1 ? ip : vp, void *))
        return 2;
    if (!IS(1 ? vp : cp, void *))
        return 3;
    if (!IS(1 ? cp : vp, void *))
        return 4;
    if (!IS(1 ? vp : ucp, void *))
        return 5;
    if (!IS(1 ? vp : lp, void *))
        return 6;

    /* A null pointer constant arm takes the other arm's type. */
    if (!IS(1 ? 0 : ip, int *))
        return 7;
    if (!IS(1 ? ip : 0, int *))
        return 8;
    if (!IS(1 ? (void *)0 : ip, int *))
        return 9;
    if (!IS(1 ? ip : (void *)0, int *))
        return 10;
    if (!IS(1 ? (void *)0 : cp, char *))
        return 11;
    if (!IS(1 ? (void *)0 : ucp, unsigned char *))
        return 12;

    /* Null pointer constant against void*: still void*. */
    if (!IS(1 ? 0 : vp, void *))
        return 13;
    if (!IS(1 ? (void *)0 : vp, void *))
        return 14;
    if (!IS(1 ? vp : vp, void *))
        return 15;

    /* void* and the character pointers are distinct types. */
    if (IS(vp, char *) || IS(vp, unsigned char *))
        return 16;
    if (IS(cp, void *) || IS(ucp, void *))
        return 17;
    /* A typedef of void carries the identity. */
    if (!IS(tp, void *))
        return 18;

    /* GNU representation is unchanged. */
    if (sizeof(void) != 1)
        return 19;
    if (sizeof(*(1 ? vp : ip)) != 1)
        return 20;
    void *q = vp;
    q = q + 3;
    if ((char *)q - (char *)vp != 3)
        return 21;

    /* Deref through the NPC-arm result keeps the object type. */
    *(1 ? ip : (void *)0) = 42;
    if (g != 42)
        return 22;
    return 0;
}
