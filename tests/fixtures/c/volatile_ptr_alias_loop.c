/* C99 6.7.3p6: a loop whose controlling expression reads a volatile
   flag must re-read it on every iteration; the body writes the flag
   through a pointer alias, so any cached read diverges. */
int main(void) {
    volatile int flag = 0;
    volatile int *p = &flag;
    int iters = 0;
    while (flag < 3) {
        *p = flag + 1;
        iters++;
        if (iters > 10) {
            return 1;
        }
    }
    return iters == 3 ? 0 : 2;
}
