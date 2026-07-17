// C99 6.8.4.2p4: case labels are scoped to the nearest enclosing
// switch regardless of nesting depth. A `case` label sitting
// inside a sub-block whose enclosing switch is the outer one is
// reachable from the outer dispatch. A real-world shape uses this
// to share a tail between two handlers:
//
//   case A: {
//       int n; ...
//       if (cond) goto target;
//   case B:                     // <-- label INSIDE the outer
//   case C:                     //     `case A`'s block
//       body...
//       break;
//   }
//
// The bytecode tier folds case labels to absolute PC targets and
// handles this naturally. Walker's switch dispatcher used to look
// only at the top-level items of the switch body Compound; any
// case sitting inside a sub-Compound was invisible, so the
// dispatch fell through to the next visible partition. The inner
// handler was therefore skipped and later code crashed
// dereferencing a NULL slot.
//
// The pin: a `case 1: { ...; case 2: body; }` shape where
// `sel == 2` dispatches directly to the inner case body. The
// dispatch into the nested case must NOT execute case 1's body
// and must reach the case 2 body.

#include <stdio.h>

int main(void) {
    int seen = 0;
    int sel = 2;
    switch (sel) {
        case 1: {
            int local_a = 100;
            seen += local_a;
            if (local_a == 100) {
                seen |= 0x1000;
            } else {
                seen |= 0x2000;
                break;
            }
        case 2:
            seen += 1;
            seen += 2;
            seen += 4;
            break;
        }
        case 3:
            seen |= 0x4000;
            break;
    }
    if (seen != 7) {
        printf("FAIL sel=2: seen=%d\n", seen);
        return 1;
    }

    seen = 0;
    sel = 1;
    switch (sel) {
        case 1: {
            int local_a = 100;
            seen += local_a;
            if (local_a == 100) {
                seen |= 0x1000;
            } else {
                seen |= 0x2000;
                break;
            }
        case 2:
            seen += 1;
            seen += 2;
            seen += 4;
            break;
        }
        case 3:
            seen |= 0x4000;
            break;
    }
    // sel=1 path: local_a=100, seen=100, |0x1000=4196, then fall
    // through to case 2 body: +1+2+4 = 4203.
    if (seen != 4203) {
        printf("FAIL sel=1: seen=%d\n", seen);
        return 2;
    }
    return 0;
}
