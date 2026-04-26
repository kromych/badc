int main() {
    char *p;
    p = malloc(16);
    p[0] = 'A';
    mprotect(p, 16, PROT_WRITE); // reads refused
    return p[0];        // VM should refuse this load
}
