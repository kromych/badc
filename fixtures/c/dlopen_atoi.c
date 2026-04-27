// Runtime dynamic linking smoke test: open the global symbol table,
// look up libc atoi, call it with "123", and exit with the parsed
// value as the process exit code. Verifies that:
//   * dlopen(NULL, RTLD_NOW) returns a non-zero handle
//   * dlsym(handle, "atoi") returns a valid function pointer
//   * Op::Jsri through that pointer correctly passes the string in x0
//     and reads the int return from x0
//   * dlclose tears down without errors
//
// Native binaries link this through libc / libdl. The VM rejects the
// final indirect call because Op::Jsri's decode_pc validates against
// the c4 bytecode range -- a real libc address fails that check, and
// the VM's runtime-error path is the documented behaviour.

int main() {
    int *handle;
    int *atoi_fn;
    int n;

    // RTLD_NOW = 2. NULL handle = the calling process's symbol scope.
    handle = dlopen(0, 2);
    if (handle == 0) return 1;

    atoi_fn = dlsym(handle, "atoi");
    if (atoi_fn == 0) {
        dlclose(handle);
        return 2;
    }

    n = atoi_fn("123");
    dlclose(handle);
    return n;
}
