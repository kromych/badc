int main() {
    int *p;
    p = (int *)100;
    return p + 1; // Should return 108, not 101
}
