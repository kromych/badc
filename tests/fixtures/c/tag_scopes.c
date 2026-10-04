// C99 6.2.1p4, 6.2.3, 6.7.2.3: struct, union and enum tags share one name
// space with block scope. A tag declared in a block names a type distinct
// from any outer tag of that name and hides it until the block ends; a
// block that declares no tag of the name uses the visible one. Each check
// exits with its own code; success returns 0.

enum E; /* completed after the functions below */
enum K { K_OUT = 1 };
struct S { int a; };

static int shadow_incomplete(void) {
    enum E { E_IN = 7 }; /* a new type: the file-scope E stays incomplete */
    enum E e = E_IN;
    return e;
}

static int shadow_complete(void) {
    enum K { K_IN = -1 }; /* hides the file-scope K */
    enum K k = K_IN;
    {
        enum K { K_NEST = -5 }; /* hides the function's K in turn */
        enum K n = K_NEST;
        if (n != -5) return 0;
    }
    enum K after = K_IN; /* the function's K again */
    return k < 0 && after < 0;
}

static int forward_in_block(void) {
    enum F *p = 0;               /* no F is visible: declares one here */
    enum F { F_A = 3 } f = F_A;  /* completes it */
    p = &f;
    return *p;
}

static int standalone_struct(void) {
    struct S; /* 6.7.2.3p7: a new S in this block, whatever is outside */
    struct S *p;
    struct S { char c[3]; } x = {{1, 2, 3}};
    p = &x;
    return (int)sizeof *p + p->c[2];
}

enum E { E_OUT = 40 };
enum F { F_OUT = 50 }; /* the block's F went out of scope with it */

int main(void) {
    if (shadow_incomplete() != 7) return 1;
    if (!shadow_complete()) return 2;
    if (forward_in_block() != 3) return 3;
    if (standalone_struct() != 6 || sizeof(struct S) != sizeof(int)) return 4;
    enum E e = E_OUT;
    enum K k = K_OUT;
    if (e + F_OUT != 90 || k != 1) return 5;
    /* gcc's rule gives an enum with no negative enumerator unsigned int;
       the blocks' signed K does not reach file scope. */
    if (!_Generic(k, unsigned int: 1, default: 0)) return 6;
    return 0;
}
