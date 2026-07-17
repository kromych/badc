// A floating-point parameter consumes a floating-point argument register
// and does not advance the integer argument bank (System V AMD64 3.2.3 /
// AAPCS64 6.4.1), so an integer parameter's incoming register is its rank
// within the integer bank, not its declared position. The allocator's
// ParamRef hint must target that integer-bank register; hinting by
// declared position points a later integer parameter at a register an
// earlier one actually arrives in, and under register pressure the
// allocator then reuses a still-live incoming parameter register as
// scratch -- clobbering, in `draw` below, the `d` pointer before it is
// stored.
//
// `draw` mirrors an inner writer: two leading float
// parameters then six integer parameters, one of them a pointer that is
// dereferenced and used as a store base. Under a capped register bank the
// pre-fix allocator wrote a non-pointer parameter into the pointer's slot,
// producing a wrong count and an out-of-bounds store. The values are
// chosen so each parameter occupies a distinct decimal digit; any
// cross-clobber changes the result.

static int draw(float fx, float fy, int a, int b, int c, int *d, int e, int g) {
    (void) fx;
    (void) fy;
    return a * 100000 + b * 10000 + c * 1000 + (*d) * 100 + e * 10 + g;
}

int main(void) {
    int val = 7;
    // a=1 b=2 c=3 *d=7 e=4 g=5 -> 123745.
    if (draw(0.0f, 0.0f, 1, 2, 3, &val, 4, 5) != 123745) {
        return 1;
    }
    return 0;
}
