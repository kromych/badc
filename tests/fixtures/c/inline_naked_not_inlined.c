/* A naked function's body is raw asm implementing its own calling
 * convention -- the `ret` is the actual return. The inliner must never
 * splice it into a caller: doing so would transfer control via the
 * inlined `ret` and corrupt the caller's frame (the coroutine
 * context-switch hang). -O0 and -O must produce the same result. */
static __attribute__((naked)) long identity_asm(long x) {
#if defined(__x86_64__)
    __asm__("movq %rdi, %rax\n\tret\n");
#elif defined(__aarch64__)
    __asm__("ret x30\n");
#endif
}

long use_identity(long v) { return identity_asm(v) + 1; }

int main(void) { return use_identity(41) == 42 ? 0 : 1; }
