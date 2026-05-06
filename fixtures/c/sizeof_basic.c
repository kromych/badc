int main() {
    if (sizeof(char) != 1) return 1;
    if (sizeof(int) != 4) return 2;       // real i32 storage
    if (sizeof(long) != 8) return 3;
    if (sizeof(int*) != 8) return 4;
    if (sizeof(char*) != 8) return 5;
    if (sizeof(int**) != 8) return 6;
    if (sizeof(long*) != 8) return 7;
    return 0;
}
