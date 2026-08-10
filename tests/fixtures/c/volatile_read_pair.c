/* C99 6.7.3p6 with 5.1.2.3p2: each read of a volatile object is an
   access the abstract machine performs; two consecutive reads of the
   same object stay two loads and never collapse into one. */
volatile int src = 9;

int main(void) {
    int a = src;
    int b = src;
    return (a == 9 && b == 9) ? 0 : 1;
}
