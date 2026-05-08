int main() {
    if (sizeof(char) != 1) return 1;
    if (sizeof(int) != 4) return 2;       // real i32 storage
    // long is 8 on LP64, 4 on LLP64 (Windows).
#ifdef __BADC_WINDOWS__
    if (sizeof(long) != 4) return 3;
#else
    if (sizeof(long) != 8) return 3;
#endif
    if (sizeof(int*) != 8) return 4;
    if (sizeof(char*) != 8) return 5;
    if (sizeof(int**) != 8) return 6;
    // sizeof(long*) is 8 always (pointer width); long itself is target-
    // dependent.
    if (sizeof(long*) != 8) return 7;
    return 0;
}
