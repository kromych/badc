int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int main() {
    int *fp;
    int res1;
    int res2;
    fp = add;
    res1 = fp(10, 20);
    fp = sub;
    res2 = fp(10, 5);
    return res1 * res2;
}
