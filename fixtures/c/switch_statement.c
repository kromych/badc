int main() {
    int a; int res;
    a = 2; res = 0;
    switch(a) {
        case 1: res = 10; break;
        case 2: res = 20; // Tests fallthrough
        case 3: res = res + 5; break;
        default: res = 100; break;
    }
    return res;
}
