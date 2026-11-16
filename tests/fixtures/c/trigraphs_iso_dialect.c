// snapshot-flags: -std=c17
/* C17 5.2.1.1: under an ISO dialect before C23 translation phase 1 replaces
 * the nine trigraphs, in string literals too, and `??/` before a newline is
 * a line splice. */
#include <string.h>

??=define TWO 1 ??/
+ 1

static const char text[] = "??=??(??/??/??)??'??<??!??>??-???=";
static const char want[] = { '#', '[', '\\', ']', '^', '{', '|', '}', '~', '?', '#', 0 };

int main(void) {
    int a??(TWO??) = ??< 1, 2 ??>;
    if (strcmp(text, want) != 0) return 1;
    return a??(1??) != TWO ??!??! a??(0??) != 1 ? 2 : 0;
}
