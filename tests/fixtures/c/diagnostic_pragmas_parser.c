// snapshot-flags: -Wall -Werror

/* The diagnostic pragmas govern the parser's diagnostics, not only the
   preprocessor's. Under `-Wall -Werror` each declaration below reports
   as an error unless the pragma in force at its position says
   otherwise, so the unit compiles and returns 0 only while every form
   reaches the parser: the plain form, a `push` / `pop` region, and the
   MSVC number that maps onto the same row. */

#pragma GCC diagnostic ignored "-Wunused-function"
static int never_called(void) { return 1; }

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-variable"
static int scoped(void) {
    int inside = 1;
    return 0;
}
#pragma GCC diagnostic pop

/* The `pop` put `unused-variable` back at the level `-Wall` left, so
   this block needs a pragma of its own. */
#pragma warning(disable : 4101)
static int msvc_spelled(void) {
    int inside = 1;
    return 0;
}

int main(void) { return scoped() + msvc_spelled(); }
