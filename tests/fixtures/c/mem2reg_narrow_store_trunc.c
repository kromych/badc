// Assigning a wider value to a narrow local truncates to the local's
// width (C99 6.5.16.1p2): char c = 300 yields 44. The conversion is
// realized by the StoreLocal / LoadLocal width pair, so the stored
// register still holds 300; a promotion that redirected the load to
// that register would read 300 and diverge. Returning 0 only when
// the truncated read is correct keeps the check off the exit-code
// low byte, where 300 and 44 would otherwise alias.
int check(int n) {
    char c = n;
    return (c == 44) ? 0 : 1;
}
int main(void) {
    return check(300);
}
