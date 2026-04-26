int main() {
    int i;
    int sum;
    sum = 0;
    for (i = 0; i < 10; i++) {
        if (i == 5) break;
        if (i % 2 == 0) continue;
        sum = sum + i;
    }
    return sum; // Should be 1 + 3 = 4
}
