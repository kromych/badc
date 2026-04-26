int main() {
    char *src;
    char *dst;
    src = malloc(sizeof(int));
    dst = malloc(sizeof(int));
    memset(src, 65, sizeof(int)); // fill with 'A'
    memcpy(dst, src, sizeof(int));
    return dst[0]; // 'A' = 65
}
