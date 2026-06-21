// C23 6.8.1 / universal compiler practice: a declaration may immediately
// follow a `case` or `default` label. The declaration has the switch
// block's scope, and a preceding case falls through into it. Exit 0 only
// when each branch's declared value is used correctly.

static int classify(int x) {
    int r = 0;
    switch (x) {
    case 1:
        int a = 10;       // declaration directly after a case label
        r += a;
        break;
    case 2: {
        int b = 20;
        r += b;
        break;
    }
    default:
        int c = 30;       // declaration directly after the default label
        r += c;
    }
    return r;
}

int main(void) {
    if (classify(1) != 10) return 1;
    if (classify(2) != 20) return 2;
    if (classify(3) != 30) return 3;  // default path
    return 0;
}
