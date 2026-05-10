int add(int a, int b) {
    return a + b;
}
int main() {
    return add(add(10, 20), add(30, 40));
}
