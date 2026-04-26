int main() {
    int a;
    a = 0;
start:
    a = a + 1;
    if (a < 5) goto start;
    goto end;
    a = a + 100;
end:
    return a;
}
