int main() {
    if (sizeof(char) != 1) return 1;
    if (sizeof(int) != 8) return 2;
    if (sizeof(int*) != 8) return 3;
    if (sizeof(char*) != 8) return 4;
    if (sizeof(int**) != 8) return 5;
    return 0;
}
