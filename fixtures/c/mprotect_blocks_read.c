int main() {
    char *p;
    p = malloc(16);
    p[0] = 'A';
    mprotect(p, 16, 2); // PROT_WRITE only — reads refused
    return p[0];        // VM should refuse this load
}
