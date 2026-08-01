/* C99 6.3.2.1p4 + 6.2.2p4: a name declared at block scope as `extern`
 * through a function-type typedef designates the file-scope function; a
 * value use converts to a pointer to the function. Classifying the name
 * as a data object instead made every use load the code bytes at the
 * function's address. */

typedef unsigned long uptr;

int scale(int n) { return n * 2 + 1; }

/* Block-scope function typedef + extern: a cast of the designator. */
static uptr addr_via_block_extern(void) {
    typedef int (op_fn)(int);
    extern op_fn scale;
    return (uptr)scale;
}

/* The same through a block-scope alias of the function typedef. */
static uptr addr_via_typedef_alias(void) {
    typedef int (op_fn)(int);
    typedef op_fn op_alias;
    extern op_alias scale;
    return (uptr)scale;
}

/* File-scope alias of a function typedef redeclaring the definition. */
typedef int (g_fn)(int);
typedef g_fn g_alias;
extern g_alias scale;
static uptr addr_via_file_alias(void) {
    return (uptr)scale;
}

/* Designator-to-pointer assignment and a call through it. */
static int call_via_block_extern(int n) {
    typedef int (op_fn)(int);
    extern op_fn scale;
    op_fn *fp = scale;
    return fp(n);
}

int main(void) {
    uptr direct = (uptr)&scale;
    if (addr_via_block_extern() != direct) return 1;
    if (addr_via_typedef_alias() != direct) return 2;
    if (addr_via_file_alias() != direct) return 3;
    if (call_via_block_extern(20) != 41) return 4;
    return 0;
}
