int main() {
    char *p;
    p = malloc(16);
    p[0] = 'X';
    // mprotect is POSIX-only. Windows offers VirtualProtect with a
    // different shape (4 args, BOOL return, &oldProtect out-param)
    // and the c4 compiler no longer ships an in-text translation
    // thunk; cross-platform sources have to gate the call.
#ifndef BADC_WINDOWS
    mprotect(p, 16, PROT_READ); // reads still allowed on POSIX
#endif
    return p[0];        // 'X' = 88
}
