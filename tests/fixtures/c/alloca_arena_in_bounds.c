/* #212 regression: the alloca underflow trap must fire only past the
 * per-frame arena floor, so an allocation that nearly fills the arena
 * (just under ALLOCA_ARENA_SLOTS*8 = 8192 bytes) still succeeds. An
 * over-tight floor would wrongly trap this valid allocation. */

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
