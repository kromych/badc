int main() {
    char *p;
    p = malloc(16);
    p[0] = 'A';
    mprotect(p, 16, PROT_READ); // writes refused
    p[0] = 'B';         // VM should refuse this store
    return 0;
}
