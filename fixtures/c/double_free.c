int main() {
    int *p;
    p = malloc(8);
    free(p);
    free(p); // second free of the same pointer
    return 0;
}
