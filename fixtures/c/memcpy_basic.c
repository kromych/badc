int main() {
    char *src;
    char *dst;
    src = malloc(8);
    dst = malloc(8);
    memset(src, 65, 8); // 'AAAAAAAA'
    memcpy(dst, src, 8);
    return dst[0]; // 'A' = 65
}
