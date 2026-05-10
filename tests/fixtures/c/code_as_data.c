int target() { return 7; }

int main() {
    int *fp;
    fp = target;
    // Dereferencing a function pointer treats code as data -- refused.
    return *fp;
}
