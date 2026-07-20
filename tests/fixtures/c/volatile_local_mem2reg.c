/* C99 6.7.3p6: a volatile automatic object stays memory-resident.
   Promotion of locals to registers skips it, and each read and write
   below performs a frame access. */
int main(void) {
    volatile int keep = 1;
    keep = 2;
    int r = keep;
    return (r == 2 && keep == 2) ? 0 : 1;
}
