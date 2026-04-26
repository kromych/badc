int main() {
    char *p;
    p = malloc(16);
    p[0] = 'X';
    mprotect(p, 16, PROT_READ); // reads still allowed
    return p[0];        // 'X' = 88
}
