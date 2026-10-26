// Unnamed members spelled with a typedef name of a structure or union
// type: the `-fms-extensions` form gcc and clang accept, and MSVC by
// default, with the same promotion as a tagged type used with no
// declarator. The members of the named type become members of the
// enclosing aggregate at the unnamed member's offset. A typedef of a
// pointer is no aggregate and declares a named member as before.
//
// Each check returns a unique non-zero id so the FIRST mismatch points
// to its scenario.

#include <stddef.h>

typedef struct tagPOINT { long x, y; } POINT;
typedef struct tagHOOK { POINT pt; int hwnd; } HOOK;
typedef struct tagHOOKEX {
    HOOK;
    unsigned long mouseData;
} HOOKEX;

typedef union { int i; float f; } NUM;
struct with_union { NUM; int tail; };

typedef const struct tagHOOK CHOOK;
struct with_const { int lead; CHOOK; };

typedef struct tagHOOK *PHOOK;
struct with_pointer { PHOOK next; };

static HOOKEX g = { { { 1, 2 }, 3 }, 4 };
static HOOKEX gd = { .hwnd = 5, .mouseData = 6 };

int main(void) {
    if (sizeof(HOOKEX) != sizeof(HOOK) + sizeof(long)) return 1;
    if (offsetof(HOOKEX, pt) != 0) return 2;
    if (offsetof(HOOKEX, hwnd) != offsetof(HOOK, hwnd)) return 3;
    if (offsetof(HOOKEX, mouseData) != sizeof(HOOK)) return 4;

    HOOKEX h;
    h.pt.x = 3;
    h.pt.y = 30;
    h.hwnd = 4;
    h.mouseData = 5;
    if (h.pt.x + h.hwnd + h.mouseData != 12 || h.pt.y != 30) return 5;

    if (sizeof(struct with_union) != 8 || offsetof(struct with_union, f) != 0) return 10;
    struct with_union w;
    w.i = 7;
    w.tail = 1;
    if (w.i + w.tail != 8) return 11;

    if (offsetof(struct with_const, pt) != sizeof(long)) return 20;

    HOOK one = { { 0, 0 }, 9 };
    struct with_pointer p = { &one };
    if (p.next->hwnd != 9) return 30;

    if (g.pt.x != 1 || g.pt.y != 2 || g.hwnd != 3 || g.mouseData != 4) return 40;
    if (gd.hwnd != 5 || gd.mouseData != 6 || gd.pt.x != 0) return 41;
    return 0;
}
