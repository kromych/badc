int main() {
    char *s1;
    char *s2;
    s1 = malloc(10);
    s2 = malloc(10);
    memset(s1, 'A', 9);
    s1[9] = 0;
    memset(s2, 'A', 9);
    s2[9] = 0;
    if (memcmp(s1, s2, 10) != 0) return 1;
    s2[5] = 'B';
    if (memcmp(s1, s2, 10) == 0) return 2;
    return 0;
}
