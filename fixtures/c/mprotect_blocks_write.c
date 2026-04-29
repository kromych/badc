int main() {
    char *p;
    p = malloc(16);
    p[0] = 'A';
#ifndef BADC_WINDOWS
    mprotect(p, 16, PROT_READ); // writes refused on POSIX
#endif
    p[0] = 'B';         // VM should refuse this store on POSIX
    return 0;
}
