// `-O` does not define `NDEBUG`, so a false assertion still fires and the
// program traps (C99 7.2p1); `-DNDEBUG` compiles it out.

#include <assert.h>

int main(void) {
    assert(0);
    return 0;
}
