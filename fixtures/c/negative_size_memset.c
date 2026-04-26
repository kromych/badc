int main() {
    char *p;
    p = malloc(8);
    memset(p, 0, -1); // negative size -- VM should refuse, not loop forever
    return 0;
}
