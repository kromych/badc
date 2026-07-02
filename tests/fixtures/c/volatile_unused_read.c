/* C99 5.1.2.3p2: reading a volatile object is a side effect; an
   expression statement consisting of just that read still performs
   the access at every optimization level. The values are checked
   afterward so the program also exercises the load results. */
volatile int ready = 5;

int main(void) {
    ready;
    volatile int local = 7;
    local;
    return (ready == 5 && local == 7) ? 0 : 1;
}
