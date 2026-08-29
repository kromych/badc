/* C99 6.5.2.5p5-6: a compound literal outside a function body has static
 * storage duration, and 6.6p9 makes its address an address constant, so it
 * can initialize static storage. The kernel's WMI id tables take the
 * address of an enum literal as a `void *` context. A literal inside a
 * function has automatic storage; its address is not a constant there. */
enum e { A = 7, B = 3 };

static const struct id { const char *guid; void *ctx; } table[] = {
    { "D320289E", &(enum e){ A } },
    { "8FEA41E0", &(enum e){ B } },
    { 0, 0 },
};

/* The unary & form, the array decay, and const selecting read-only. */
static int *ip = &(int){ 5 };
static int *ap = (int[]){ 1, 2, 3 };
static const int *cp = &(const int){ 9 };

int main(void)
{
    int r = *(enum e *)table[0].ctx * 10 + *(enum e *)table[1].ctx; /* 73 */
    *ip += 1;   /* the non-const literal is writable: 6 */
    ap[1] += 10; /* 12 */
    if (table[2].guid || table[2].ctx)
        return 1;
    return r + *ip + ap[0] + ap[1] + *cp - 100; /* 73+6+1+12+9-100 = 1 */
}
