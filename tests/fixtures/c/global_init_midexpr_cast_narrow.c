// Locks C99 6.3.1.3: a narrowing cast that is a sub-operand of a
// file-scope constant initializer narrows the operand rather than being
// discarded. Relocation casts (&x, a function name) must still resolve.
//
// Each failure returns a distinct nonzero code.

extern int gv;
int gv = 99;
int *pg = (int *)&gv; /* reloc cast: must still point at gv */

typedef int (*F)(void);
int seven(void) { return 7; }
F fp = ((F)((seven))); /* function-pointer reloc cast */

int g = ((int)4294967295U == -1);            /* 1 */
int h = (int)4294967295U;                     /* -1 */
unsigned u = ((unsigned)-1 == 0xFFFFFFFFu);   /* 1 */
int c = ((signed char)0x80 == -128);          /* 1 */
int z = ((short)0x10000 == 0);                /* 1 */

int main(void) {
    if (g != 1) return 1;
    if (h != -1) return 2;
    if (u != 1) return 3;
    if (c != 1) return 4;
    if (z != 1) return 5;
    if (pg != &gv || *pg != 99) return 6;
    if (fp() != 7) return 7;
    return 0;
}
