// C99 6.5.6: `ptr - ptr` produces a ptrdiff_t (element distance),
// `int + ptr` produces a pointer (the int is scaled by the
// pointee size, then added). The parser's int+ptr arm emits the
// scaling through a bytecode dance -- `Op::StLocI` /
// `Op::Imm 0` / `Op::Or` / `Op::Mul scale` / `Op::Psh` /
// `Op::Lea temp` / `Op::Li` -- whose `Op::Or` / `Op::Li` route
// through `ast_track_emit_op` and pop the AST vstack on each
// step. The outer expression's lvalue was riding the vstack and
// got consumed by the inner pops, so the wrapping assignment's
// AST went missing and the walker emitted no code for the
// declaration's initializer.
//
// The shape sits behind lua's `correctstack`:
// `L->top.p = L->top.p - oldstack + newstack;` lowers to
// `(L->top.p - oldstack) + newstack`. Without the fix the
// reallocated-stack adjustment was a no-op and every
// downstream lua C API call read its stack indices against
// the unrelocated stack -- the `idx <= ci->top.p -
// (ci->func.p + 1)` assertion fired on the first push.

#include <stdio.h>

typedef struct { long a; long b; } Big;

int main(void) {
    Big arr[3] = {{0,0},{1,1},{2,2}};
    Big *old  = &arr[0];
    Big *neww = &arr[0];
    Big *p    = &arr[2];
    // `p - old` is 2 (element distance); `2 + neww` scales by
    // sizeof(Big) and yields `&arr[2]`. A second arrangement
    // with non-zero `neww` checks the scaling isn't dropped.
    Big *moved = p - old + neww;
    if (moved != &arr[2]) return 1;
    Big *moved2 = (p - old) + (neww + 1);
    if (moved2 != &arr[3]) return 2;
    // Plain `int + ptr` with a literal int.
    Big *moved3 = 2 + neww;
    if (moved3 != &arr[2]) return 3;
    return 0;
}
