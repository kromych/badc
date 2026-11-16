// A `_P_NOWAIT` spawn returns the child's process handle as an `intptr_t`;
// `_cwait` takes that handle, returns it, and stores the child's exit code.
#ifdef _WIN32
#include <process.h>
#include <stdint.h>
#include <stdlib.h>

_Static_assert(_Generic(&_cwait, intptr_t (*)(int *, intptr_t, int): 1, default: 0),
               "_cwait handle type");
_Static_assert(_Generic(&_spawnl, intptr_t (*)(int, const char *, const char *, ...): 1,
                        default: 0),
               "_spawnl result type");
_Static_assert(_Generic(&_spawnvpe,
                        intptr_t (*)(int, const char *, const char *const *,
                                     const char *const *): 1,
                        default: 0),
               "_spawnvpe result type");
_Static_assert(_Generic(&_execv, intptr_t (*)(const char *, const char *const *): 1,
                        default: 0),
               "_execv result type");

int main(void) {
    const char *shell = getenv("ComSpec");
    if (!shell)
        return 1;
    intptr_t child = _spawnl(_P_NOWAIT, shell, shell, "/c", "exit 7", NULL);
    if (child == -1)
        return 2;
    int status = -1;
    if (_cwait(&status, child, _WAIT_CHILD) != child)
        return 3;
    return status == 7 ? 0 : 4;
}
#else
int main(void) { return 0; }
#endif
