int main() {
    int *fp;
    // 42 is not a code pointer (no CODE_BASE bias) -- calling through it
    // must be refused.
    fp = (int *)42;
    return fp(0);
}
