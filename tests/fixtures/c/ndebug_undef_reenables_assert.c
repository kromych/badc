// With `-O` the implied `NDEBUG` compiles the assert out and the
// program exits 0; `-U NDEBUG` on top of `-O` removes the predefine,
// so the false assertion fires and the program traps.

#include <assert.h>

int main(void) {
    assert(0);
    return 0;
}
