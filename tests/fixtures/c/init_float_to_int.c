// Locks C99 6.3.1.4: a floating constant initializing an integer
// aggregate element converts (truncating toward zero) rather than
// storing the raw IEEE-754 bit pattern. The int -> double direction
// must stay exact.
//
// Each failure returns a distinct nonzero code.

int ai[] = {1.5, 2.5, -3.9};
long al[] = {7.9, -7.9};
unsigned au[] = {3.9};
double ad[] = {1, 2};

int main(void) {
    if (ai[0] != 1 || ai[1] != 2 || ai[2] != -3) return 1;
    if (al[0] != 7 || al[1] != -7) return 2;
    if (au[0] != 3) return 3;
    if (ad[0] != 1.0 || ad[1] != 2.0) return 4;
    return 0;
}
