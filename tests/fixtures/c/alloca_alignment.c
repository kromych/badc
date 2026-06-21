/* alloca returns storage suitably aligned for any object: the established
   practice is the platform's maximum scalar alignment, 16 bytes. The arena
   bump rounds the request up to a 16-byte multiple so successive results stay
   aligned. Distinct non-multiple-of-16 sizes exercise the rounding. Returns 0
   on success. */
static void *sink(void *p){ return p; }
int main(void){
    char *a = __builtin_alloca(1);
    char *b = __builtin_alloca(7);
    char *c = __builtin_alloca(33);
    char *d = __builtin_alloca(100);
    sink(a); sink(b); sink(c); sink(d);
    if (((unsigned long)a & 15) | ((unsigned long)b & 15) |
        ((unsigned long)c & 15) | ((unsigned long)d & 15))
        return 1;
    a[0] = 11; b[6] = 22; c[32] = 33; d[99] = 44;
    return (a[0] == 11 && b[6] == 22 && c[32] == 33 && d[99] == 44) ? 0 : 1;
}
