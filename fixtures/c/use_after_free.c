int main() {
    int *p;
    p = malloc(8);
    *p = 42;
    free(p);
    return *p; // dangling — VM should refuse this read under pointer tracking
}
