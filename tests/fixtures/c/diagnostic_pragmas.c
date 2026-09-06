/* The diagnostic pragmas decide a diagnostic's level at each source
   position. `frobnicate` is no pragma badc implements, so every
   occurrence below would report `unknown-pragmas`; the pragma in force
   at that position silences it. Each block restores the default level,
   so the forms are independent and the unit compiles with no
   diagnostic at all. */

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunknown-pragmas"
#pragma frobnicate
#pragma GCC diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma frobnicate
#pragma clang diagnostic pop

#pragma warning(push)
#pragma warning(disable : 4068)
#pragma frobnicate
#pragma warning(pop)

#pragma warning(suppress : 4068)
#pragma frobnicate

int main(void) { return 0; }
