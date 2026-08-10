// A declarator may carry attributes between its name and its
// initializer, and `__auto_type` is no exception:
//
//     __auto_type p __attribute__((cleanup(f))) = q;
//
// The type is still recovered from the initializer, and the attributes
// still apply to the declared object -- here the cleanup handler runs at
// scope exit, in reverse declaration order.

#include <stdio.h>

static int closed;

static void closer(void *p) { (void)p; closed++; }

static int slot = 42;
static int *begin(void) { return &slot; }

int main(void) {
    __auto_type a = begin();
    if (*a != 42) return 1;

    const __auto_type b = begin();
    if (*b != 42) return 2;

    // The attribute sits between the declarator and the initializer.
    {
        const __auto_type c __attribute__((cleanup(closer))) = begin();
        if (*c != 42) return 3;
        if (closed != 0) return 4;
    }
    if (closed != 1) return 5;

    // Several attributes in a row, and one with no operand.
    {
        __auto_type d __attribute__((unused)) __attribute__((cleanup(closer)))
            = begin();
        if (*d != 42) return 6;
    }
    if (closed != 2) return 7;

    // The shape a scoped-access macro expands to: three nested for-init
    // declarations, the innermost carrying a cleanup attribute.
    for (int done = 0; !done; done = 1)
        for (__auto_type t = begin(); !done; done = 1)
            for (const __auto_type u __attribute__((cleanup(closer))) = t;
                 !done; done = 1) {
                if (*u != 42) return 8;
            }
    if (closed != 3) return 9;

    // A non-pointer initializer keeps working alongside the attribute.
    {
        __auto_type n __attribute__((cleanup(closer))) = 7 * 3;
        if (n != 21) return 10;
    }
    if (closed != 4) return 11;

    printf("ok\n");
    return 0;
}
