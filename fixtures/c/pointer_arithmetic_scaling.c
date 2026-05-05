int main() {
    int *p;
    p = (int *)100;
    return p + 1; // Should return 104 (sizeof(int) = 4 under M31).
}
