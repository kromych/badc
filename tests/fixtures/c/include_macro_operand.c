/* Regression: C99 6.10.2p4 `#include <pp-tokens>` -- when the
 * include operand isn't already in `<...>` or `"..."` literal
 * form, the preprocessor must macro-expand the tokens and then
 * reparse the result. The typical real-world shape is a
 * project-wide alias for a configuration header:
 *
 *   #define PROJECT_CONFIG_HEADER <stdint.h>
 *   #include PROJECT_CONFIG_HEADER
 *
 * The construct also drives X-macro patterns where the same
 * header is re-included with different parameter macros each
 * pass (c5's cycle guard still rejects self-recursive
 * X-includes; that's a separate gap).
 */

#define ALIAS_FOR_STDINT <stdint.h>
#include ALIAS_FOR_STDINT

#define USERHDR "stdlib.h"
#include USERHDR

int main(void) {
    int8_t  s8  = -1;        /* from stdint.h via the angle alias  */
    int32_t s32 = 42;        /* same */
    void *p = malloc(8);     /* from stdlib.h via the quote alias  */
    if (!p) return 1;
    free(p);
    if (s8 != -1) return 2;
    if (s32 != 42) return 3;
    return 0;
}
