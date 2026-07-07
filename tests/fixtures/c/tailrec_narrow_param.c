// C99 6.3.1.3: a self-tail-recursive integer accumulator whose
// parameter is narrower than int must re-narrow the recursive argument
// on the synthesized loop back edge. On the first call the parameter
// load sign-extends the incoming `signed char`; on later iterations that
// load no longer runs, so the back edge carries an explicit sign-extend
// of `n - 1` to keep the value canonical.

long sum_to(signed char n) {
    if (n <= 0) return 0;
    return (long) n + sum_to(n - 1);
}

int main(void) {
    // 100 + 99 + ... + 1 = 5050; every `n - 1` stays within signed char.
    return sum_to(100) == 5050 ? 0 : 1;
}
