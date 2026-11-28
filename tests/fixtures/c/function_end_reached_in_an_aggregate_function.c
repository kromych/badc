// A function whose `}` is reached returns no value, and that is undefined
// only if the caller uses the value (C17 6.9.1p12). For a function that
// returns a structure the callee has no object to return then: it returns
// without reading one, whichever way the ABI returns the type -- in
// memory, in integer registers, or in floating-point registers.

struct in_memory {
    long a, b, c;
};
struct in_a_register {
    long a;
};
struct in_fp_registers {
    double x, y;
};

__attribute__((noinline)) struct in_memory memory(int have) {
    if (have) {
        struct in_memory s = {1, 2, 3};
        return s;
    }
}

__attribute__((noinline)) struct in_a_register integer(int have) {
    if (have) {
        struct in_a_register s = {4};
        return s;
    }
}

__attribute__((noinline)) struct in_fp_registers floating(int have) {
    if (have) {
        struct in_fp_registers s = {5, 6};
        return s;
    }
}

volatile int zero = 0;

int main(void) {
    memory(zero);
    integer(zero);
    floating(zero);
    if (memory(!zero).c != 3 || integer(!zero).a != 4 || floating(!zero).y != 6)
        return 1;
    return 0;
}
