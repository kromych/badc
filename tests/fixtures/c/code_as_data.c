int target() { return 7; }

int main() {
    int *fp;
    fp = (int *)target;
    // Dereferencing a function pointer treats code as data -- refused.
    return *fp;
}
