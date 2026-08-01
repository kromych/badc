// `__has_attribute` and `__has_builtin` are macro-expanded wherever they
// appear, not only inside a conditional directive, so an ordinary
// expression can gate on a capability:
//
//     if (IS_ENABLED(X) && __has_attribute(some_attr)) ...
//
// The verdict is the one the `#if` path reports for the same operand, so
// a header and the code it guards cannot disagree. Only the truth of the
// verdict is checked here: gcc answers a standard C23 attribute with its
// version number rather than 1, and this asserts nothing about which
// non-zero value an implementation picks.

#include <stdio.h>

#if __has_attribute(noreturn)
#define DIRECTIVE_KNOWN 1
#else
#define DIRECTIVE_KNOWN 0
#endif

#if __has_attribute(no_such_attribute_at_all)
#define DIRECTIVE_UNKNOWN 1
#else
#define DIRECTIVE_UNKNOWN 0
#endif

#if __has_builtin(__builtin_expect)
#define DIRECTIVE_BUILTIN 1
#else
#define DIRECTIVE_BUILTIN 0
#endif

static int known = __has_attribute(noreturn);
static int unknown = __has_attribute(no_such_attribute_at_all);

int main(void) {
    // The directive and the expression agree.
    if (!DIRECTIVE_KNOWN) return 1;
    if (DIRECTIVE_UNKNOWN) return 2;
    if (!DIRECTIVE_BUILTIN) return 3;

    if (__has_attribute(noreturn) == 0) return 10;
    if (__has_attribute(no_such_attribute_at_all) != 0) return 11;
    if (__has_builtin(__builtin_expect) == 0) return 12;
    if (__has_builtin(no_such_builtin_at_all) != 0) return 13;

    // Spelled with the surrounding underscores, and with white space.
    if (__has_attribute(__packed__) == 0) return 20;
    if (__has_attribute ( aligned ) == 0) return 21;

    // As an operand of a larger expression, which is how a capability
    // gate is normally written.
    if (!(1 && __has_attribute(unused))) return 30;
    if (0 || __has_attribute(no_such_attribute_at_all)) return 31;

    // In a static initializer.
    if (known == 0) return 40;
    if (unknown != 0) return 41;

    printf("ok\n");
    return 0;
}
