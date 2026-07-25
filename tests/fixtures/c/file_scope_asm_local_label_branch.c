/* File-scope asm function with a `lock`-prefixed replacement, a
 * conditional branch to a section-local label defined later in the same
 * pushed section, and a call out to C past that label. */

unsigned int lockv;
unsigned int slow_calls;

void slowpath_handler(unsigned int *lock, unsigned char val) {
    slow_calls += 1;
    *lock = 0;
    (void)val;
}

__asm__(".pushsection .spinlock.text, \"ax\"\n"
        ".globl pv_unlock\n\t"
        ".type pv_unlock, @function\n\t"
        "pv_unlock:\n\t"
        "push  %rdx\n\t"
        "mov   $1,%eax\n\t"
        "xor   %edx,%edx\n\t"
        "lock cmpxchg %dl,(%rdi)\n\t"
        "jne   .slowpath\n\t"
        "pop   %rdx\n\t"
        "ret\n\t"
        ".slowpath:\n\t"
        "push   %rsi\n\t"
        "movzbl %al,%esi\n\t"
        "call slowpath_handler\n\t"
        "pop    %rsi\n\t"
        "pop    %rdx\n\t"
        "ret\n\t"
        ".size pv_unlock, . - pv_unlock\n\t"
        ".popsection");

extern void pv_unlock(unsigned int *lock);

int main(void) {
    lockv = 1;
    pv_unlock(&lockv); /* cmpxchg 1 -> 0: fast path */
    if (lockv != 0 || slow_calls != 0)
        return 1;
    lockv = 3;
    pv_unlock(&lockv); /* mismatch: slowpath clears the lock */
    if (lockv != 0 || slow_calls != 1)
        return 2;
    return 42;
}
