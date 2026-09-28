// C99 6.6p9: an integer constant cast to a pointer type is an address
// constant, so constant pointer arithmetic on it strides by the pointee
// (6.5.6p8), a difference divides by the element size (6.5.6p9), and
// relational operators order it by unsigned magnitude (6.5.8p5), whether
// the expression initializes a static object or a const one is read back.
// Each check exits with its own code; success returns 0.

#include <stdint.h>

struct node {
    struct node *next;
    long pad;
};

static void *v = (void *)0x300 + 0x10UL;
static int *ip = (int *)0x300 + 1;
static long long *lp = (long long *)0x300 - 2;
static struct node n = {.next = (void *)0x300 + 0x10UL};
static char *cp = 1 + (char *)0x300;
static intptr_t d = (int *)0x310 - (int *)0x300;
static struct node *np = (struct node *)0x1000 + 2;
static int above = (char *)0xffff888005800248ULL > (char *)3ULL;
static int below = (int *)0x10 < (int *)0x20;
static int *const base = (int *)0x400;
static int *past = base + 3;
static int (*rows)[4] = (int (*)[4])0x100 + 1;

int main(void) {
    if ((uintptr_t)v != 0x310) return 1;
    if ((uintptr_t)ip != 0x300 + sizeof(int)) return 2;
    if ((uintptr_t)lp != 0x300 - 2 * sizeof(long long)) return 3;
    if ((uintptr_t)n.next != 0x310) return 4;
    if ((uintptr_t)cp != 0x301) return 5;
    if (d != 0x10 / (intptr_t)sizeof(int)) return 6;
    if ((uintptr_t)np != 0x1000 + 2 * sizeof(struct node)) return 7;
    if (!above || !below) return 8;
    if ((uintptr_t)past != 0x400 + 3 * sizeof(int)) return 9;
    if ((uintptr_t)rows != 0x100 + 4 * sizeof(int)) return 10;
    return 0;
}
