/* C99 6.7.3p6: a volatile store followed by a volatile load performs
   both accesses; the load reads memory rather than reusing the stored
   value. */
volatile int cell;

int main(void) {
    cell = 5;
    int r = cell;
    return r == 5 ? 0 : 1;
}
