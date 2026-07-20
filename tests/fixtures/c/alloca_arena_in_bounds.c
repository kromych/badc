/* Historical regression: alloca once drew from a fixed 8192-byte
 * per-frame arena whose bounds check could trap a valid allocation
 * just under the limit. alloca now moves the stack pointer, but the
 * near-8K allocation stays locked in as a size regression. */

#include <string.h>
#include <alloca.h>

int main(void) {
    /* 8000 < 8192: in bounds. Touch every byte so the buffer is live. */
    unsigned char *p = (unsigned char *)alloca(8000);
    memset(p, 3, 8000);
    int sum = 0;
    int i;
    for (i = 0; i < 8000; i++) sum += p[i];
    return sum == 24000 ? 0 : 1;
}
