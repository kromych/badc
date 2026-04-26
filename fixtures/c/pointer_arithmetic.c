int main() {
    int *p;
    p = malloc(16);
    *p = 1;
    *(p + 1) = 2;
    return *p + *(p + 1);
}
