/* A C-library function's address is one pointer wherever it is taken: in
 * code, in a static slot and in a const slot (C99 6.5.9p6); a call through
 * each reaches the function. Returns 0. */
#include <string.h>

typedef size_t (*lenfn)(const char *);

static lenfn s = strlen;
static lenfn const c = strlen;

static lenfn pick(int i) { return i ? strlen : s; }

int main(void) {
    lenfn d = strlen;
    if (s != d || c != d || pick(1) != pick(0)) {
        return 1;
    }
    return s("abc") + c("ab") + d("a") == 6 ? 0 : 2;
}
