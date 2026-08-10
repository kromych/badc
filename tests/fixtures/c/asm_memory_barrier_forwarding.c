/* An asm statement with a "memory" clobber is an ordering barrier for
   memory accesses (GCC extended-asm practice): a store before the
   barrier may not satisfy a load after it, so each load below reads
   memory. */
int shared = 3;

int main(void) {
    shared = 7;
    __asm__ volatile("" : : : "memory");
    int r = shared;
    shared = r + 1;
    __asm__ volatile("" : : : "memory");
    return shared == 8 ? 0 : 1;
}
