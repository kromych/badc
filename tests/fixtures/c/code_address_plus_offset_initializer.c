/* A static initializer's function address plus a byte offset keeps the
 * offset (GNU arithmetic on a function address converted to `char *`):
 * scalar, array element and struct member, the function defined before
 * or after the object. */
static long before(void) { return 1; }
static long after(void);

static char *s = (char *)before + 4;
static char *tab[2] = {(char *)before + 8, (char *)after - 2};
static struct {
    int k;
    char *p;
} st = {3, (char *)after + 16};

static long after(void) { return 2; }

int main(void) {
    return !(s - (char *)before == 4 && tab[0] - (char *)before == 8 &&
             tab[1] - (char *)after == -2 && st.k == 3 && st.p - (char *)after == 16 &&
             before() + after() == 3);
}
