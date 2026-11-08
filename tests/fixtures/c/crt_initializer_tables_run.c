// The C runtime's tables a unit fills through `#pragma section` and
// `__declspec(allocate)`, as the MSVC runtime calls them: the `.CRT$XI*`
// initializers before the `.CRT$XC*` ones, both before `main`, and the
// `.CRT$XT*` terminators at exit, after the `.CRT$XP*` ones. The last
// terminator exits 0 when every entry ran in that order; `main` itself
// returns 3. Off Windows the unit checks nothing.

#ifdef _WIN32
#include <windows.h>

static volatile int order;
static void constructor(void) { order = order * 10 + 2; }
static int initializer(void) { order = order * 10 + 1; return 0; }
static void pre_terminator(void) { order = order * 10 + 3; }
static void terminator(void) { ExitProcess(order == 123 ? 0 : 4); }

#pragma section(".CRT$XCU", read)
#pragma section(".CRT$XIU", read)
#pragma section(".CRT$XTU", read)
#pragma section(".CRT$XPU", read)
__declspec(allocate(".CRT$XCU")) void (*p_constructor)(void) = constructor;
__declspec(allocate(".CRT$XIU")) int (*p_initializer)(void) = initializer;
__declspec(allocate(".CRT$XTU")) void (*p_terminator)(void) = terminator;
__declspec(allocate(".CRT$XPU")) void (*p_pre_terminator)(void) = pre_terminator;

int main(void) { return order == 12 ? 3 : 5; }
#else
int main(void) { return 0; }
#endif
