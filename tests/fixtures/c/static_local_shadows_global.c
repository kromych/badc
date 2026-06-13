// C99 6.2.1 + 6.2.4p3: a block-scope `static` local has static
// storage duration but block scope; a file-scope object of the same
// name is a distinct object that the local shadows only inside the
// function. The local must not share the global's storage, and the
// global must reappear once the function returns.
static int fred = 1234;

static int henry(void) {
    static int fred = 4567; // distinct object from the file-scope fred
    int r = fred;
    fred++; // mutates the local, not the global
    return r;
}

int main(void) {
    if (fred != 1234) return 1;    // file-scope fred
    if (henry() != 4567) return 2; // local fred, first call
    if (henry() != 4568) return 3; // local persists and incremented
    if (fred != 1234) return 4;    // file-scope fred untouched
    return 0;
}
