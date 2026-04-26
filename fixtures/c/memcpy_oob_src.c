int main() {
    char *src;
    char *dst;
    src = malloc(8);
    dst = malloc(100);
    memcpy(dst, src, 100); // reads 92 bytes past src
    return 0;
}
