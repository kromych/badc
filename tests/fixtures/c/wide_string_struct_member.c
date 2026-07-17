/* C99 6.7.8p15: a wide string literal initializes a wchar_t-typed array
   member at the target's wchar_t stride (4 bytes on Linux/macOS, 2 on
   Windows). The member path handled only narrow char[] members, so a
   wide-string member was a silent miscompile on the constant path (it
   stored the string pointer) and a rejection on the runtime path. Both
   now store the code points at the element stride. The checks compare
   code points, which hold at either width. */

#include <stddef.h>

struct WS { int a; wchar_t w[4]; };
static struct WS g = { 5, L"hi" };            /* file-scope constant */

static int check_runtime(int tag) {           /* runtime: non-const tag */
    struct { int tag; wchar_t w[4]; } s = { tag, L"hi" };
    return (s.tag == tag && s.w[0] == 'h' && s.w[1] == 'i'
            && s.w[2] == 0 && s.w[3] == 0)
        ? 0
        : 1;
}

int main(void) {
    if (!(g.a == 5 && g.w[0] == 'h' && g.w[1] == 'i' && g.w[2] == 0 && g.w[3] == 0))
        return 2;

    struct WS c = { 6, L"ab" };                /* local constant, padded */
    if (!(c.a == 6 && c.w[0] == 'a' && c.w[1] == 'b' && c.w[2] == 0 && c.w[3] == 0))
        return 3;

    struct { wchar_t w[2]; } exact = { L"hi" };    /* exact fit, NUL dropped */
    if (!(exact.w[0] == 'h' && exact.w[1] == 'i'))
        return 4;

    return check_runtime(9);
}
