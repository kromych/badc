// A counted loop. The block layout pass rotates it to bottom-test
// form: the body and step fall through in layout order and the back
// edge is a single conditional branch to the loop top.
int main(void) {
    int sum = 0;
    int i;
    for (i = 0; i < 10; i++) {
        sum += i;
    }
    return sum;
}
