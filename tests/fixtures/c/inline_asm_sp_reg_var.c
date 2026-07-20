/* A `register T v asm("<stack pointer>")` variable names the register
 * itself and has no storage behind it. Naming one as an inline-asm
 * output operand is how a template declares that it perturbs the
 * register; it is accepted, and the code around it keeps working.
 *
 * What the variable reads back afterwards is not fixed -- the operand
 * denotes the register, not an object -- so only the surrounding state
 * is checked. The read-write form is exercised on x86-64 only: on
 * AArch64 the stack pointer is not encodable where a general register
 * is, and that shape faults under gcc and clang there. */

static int helper_calls = 0;

static void helper(void) { helper_calls++; }

static int sp_output_operands(void) {
    int a = 17, b = 25;
#if defined(__x86_64__)
    register unsigned long stack_pointer asm("rsp");
    __asm__ __volatile__("" : "+r"(stack_pointer) : : "memory");
    __asm__ __volatile__("" : "=r"(stack_pointer) : : "memory");
#elif defined(__aarch64__)
    /* AArch64 diagnoses a stack-pointer register-variable operand rather
       than binding it, so only the read is exercised here. */
    register unsigned long stack_pointer asm("sp");
    if (stack_pointer == 0)
        return 0;
#endif
    helper();
    if (helper_calls != 1)
        return 0;
    return a + b;
}

int main(void) {
    if (sp_output_operands() != 42)
        return 1;
    return 42;
}
