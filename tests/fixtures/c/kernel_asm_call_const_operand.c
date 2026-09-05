// snapshot-flags: -c -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mfunction-return=thunk-extern -fcf-protection=branch
// An `"i"` operand naming a function, branched to as `call %c[N]` /
// `jmp %P0` (the kernel's `call_on_stack`): the branch is direct -- a
// call relocation against an external name, a resolved displacement to
// a function of this unit -- never an indirect branch through a
// register, which a retpoline build forbids outside the thunks and an
// IBT build lands on no `endbr64`.

void external_target(void);
static void local_target(void) {}
register unsigned long current_stack_pointer asm("rsp");
extern void *irq_stack_ptr;

#define call_on_stack(func)                                              \
	do {                                                             \
		register void *tos asm("r11");                           \
		tos = irq_stack_ptr;                                     \
		asm volatile("movq %%rsp, (%[tos])\n\t"                  \
			     "movq %[tos], %%rsp\n\t"                    \
			     "call %c[__func]\n\t"                       \
			     "popq %%rsp"                                \
			     : "+r"(tos), "+r"(current_stack_pointer)    \
			     : [__func] "i"(func), [tos] "r"(tos)        \
			     : "cc", "rax", "rcx", "rdx", "rsi", "rdi",  \
			       "r8", "r9", "r10", "memory");             \
	} while (0)

void run_external(void)
{
	call_on_stack(external_target);
}

void run_local(void)
{
	call_on_stack(local_target);
}

void jump_external(void)
{
	asm volatile("jmp %P0" : : "i"(external_target));
}
