int add(int a, int b) { return a + b; }
int main() {
    int x;
    x = add(1);          // warn: too few arguments
    x = add(1, 2, 3, 4); // warn: too many arguments
    return 0;
}
