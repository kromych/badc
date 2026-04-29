int main() {
    char *p;
    p = malloc(16);
    p[0] = 'A';
#ifndef BADC_WINDOWS
    mprotect(p, 16, PROT_WRITE); // reads refused on POSIX
#endif
    return p[0];        // VM should refuse this load on POSIX
}
