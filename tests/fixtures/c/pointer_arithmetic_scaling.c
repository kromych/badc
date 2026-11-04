int main() {
    int *p;
    p = (int *)100;
    return (int)(long long)(p + 1); // Should return 104 (sizeof(int) = 4).
}
