// C99 6.9.1p7: an old-style definition gives its function no prototype, so a
// call with another argument count violates no constraint; it warns.
int add(a, b) int a, b; { return a + b; }
int main() {
    int x;
    x = add(1);          // warn: too few arguments
    x = add(1, 2, 3, 4); // warn: too many arguments
    return 0;
}
