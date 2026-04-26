int main() {
    char *v;
    setenv("C4RS_TEST_SETENV", "Z", 1);
    v = getenv("C4RS_TEST_SETENV");
    if (v == 0) return 1;
    return v[0]; // 'Z' = 90
}
