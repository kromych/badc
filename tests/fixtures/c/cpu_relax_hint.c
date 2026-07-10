// The CPU spin-loop hint: the x86 `pause` spelled either `pause` or its
// `rep; nop` byte encoding, and the arm `yield`. All normalize to the
// relax hint and have no effect on the program's result; this exercises
// the accepted spellings (the `rep; nop` form is a common encoding for
// the spin-loop hint on x86 hosts).
int main(void) {
    for (int i = 0; i < 4; i++) {
        __asm__ volatile("rep; nop" ::: "memory");
        __asm__ volatile("rep;nop");
        __asm__ volatile("pause");
        __asm__ volatile("yield");
    }
    return 0;
}
