// C99 6.3.2.1p4: applying `&` to a function designator yields the same
// function-pointer value as the bare name. A scalar function-pointer
// global initialized with the address-of form must behave like the
// bare-name form.
static int inc(int x) { return x + 1; }

static int (*pa)(int) = &inc; // address-of form
static int (*pb)(int) = inc;  // bare-name form

int main(void) {
    if (pa(41) != 42) return 1;
    if (pb(20) != 21) return 2;
    if (pa != pb) return 3; // same function-pointer value
    return 0;
}
