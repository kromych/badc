int main() {
    char *v;
    v = getenv("C4RS_TEST_GETENV");
    if (v == 0) return 1;
    return v[0]; // first byte of the value
}
