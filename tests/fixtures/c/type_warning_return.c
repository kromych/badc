// `return <expr>;` whose expression type doesn't match the function
// return type warns the same way an assignment does (C99 6.8.6.4p3:
// the value is converted as if by assignment). Pointer-vs-integer and
// incompatible-struct mismatches warn; the NULL idiom, a matching
// return, and char*/void* interconversion stay silent.

struct A {
    int a;
};
struct B {
    int b;
};

static int *g;

int ret_ptr_as_int(void) {
    return g; // warn: pointer returned where int declared
}

int *ret_int_as_ptr(int x) {
    return x; // warn: integer returned where pointer declared
}

struct A ret_wrong_struct(struct B b) {
    return b; // warn: incompatible struct types
}

int *ret_null(void) {
    return 0; // NULL idiom -- silent
}

int ret_ok(int x) {
    return x; // matching type -- silent
}

int main(void) {
    return 0;
}
