int main(int argc, char **argv) {
    if (argc < 2) return 0;
    // argv[1] is a char*, argv[1][0] is its first byte.
    return argv[1][0];
}
