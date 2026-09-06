// snapshot-flags: -c -mcmodel=kernel -fcf-protection=branch

// arch/x86/include/asm/paravirt.h under CONFIG_PARAVIRT_XXL. Each
// interrupt-flag accessor is an always_inline body whose one statement is a
// paravirt call site: an indirect call through `pv_ops`, patched to the
// native instruction at boot, with ASM_CALL_CONSTRAINT -- `"+r"
// (current_stack_pointer)` -- among its operands. badc read that operand as
// a frame-bound stack-pointer intrinsic and declined the body, so every site
// that read or wrote the interrupt flag called a 166-byte out-of-line copy
// with its own frame and stack-protector prologue. The accessors have to
// inline: no out-of-line copy of one may survive, and each call site carries
// the indirect call itself. The alternative sections such a site also emits
// are `inline_asm_alternative_replacement`'s subject, not this one's.

typedef unsigned long ulong;

struct pv_irq_ops {
	ulong (*save_fl)(void);
	void (*irq_disable)(void);
	void (*irq_enable)(void);
};

struct paravirt_patch_template {
	struct pv_irq_ops irq;
};

extern struct paravirt_patch_template pv_ops;
register unsigned long current_stack_pointer asm("rsp");

static inline __attribute__((always_inline)) ulong arch_local_save_flags(void)
{
	ulong __eax;

	asm volatile("call *%[paravirt_opptr]"
		     : "=a"(__eax), "+r"(current_stack_pointer)
		     : [paravirt_opptr] "m"(pv_ops.irq.save_fl)
		     : "memory", "cc");
	return __eax;
}

static inline __attribute__((always_inline)) void arch_local_irq_disable(void)
{
	ulong __eax;

	asm volatile("call *%[paravirt_opptr]"
		     : "=a"(__eax), "+r"(current_stack_pointer)
		     : [paravirt_opptr] "m"(pv_ops.irq.irq_disable)
		     : "memory", "cc");
	(void)__eax;
}

static inline __attribute__((always_inline)) void arch_local_irq_enable(void)
{
	ulong __eax;

	asm volatile("call *%[paravirt_opptr]"
		     : "=a"(__eax), "+r"(current_stack_pointer)
		     : [paravirt_opptr] "m"(pv_ops.irq.irq_enable)
		     : "memory", "cc");
	(void)__eax;
}

static inline __attribute__((always_inline)) int
arch_irqs_disabled_flags(ulong flags)
{
	return !(flags & (1UL << 9));
}

static inline __attribute__((always_inline)) ulong arch_local_irq_save(void)
{
	ulong flags = arch_local_save_flags();

	arch_local_irq_disable();
	return flags;
}

static inline __attribute__((always_inline)) void
arch_local_irq_restore(ulong flags)
{
	if (!arch_irqs_disabled_flags(flags))
		arch_local_irq_enable();
}

extern int raw_spin_trylock(void *lock);
extern void queued_spin_lock_slowpath(void *lock);
extern void raw_spin_unlock(void *lock);

ulong spin_lock_irqsave(void *lock)
{
	ulong flags = arch_local_irq_save();

	if (!raw_spin_trylock(lock))
		queued_spin_lock_slowpath(lock);
	return flags;
}

void spin_unlock_irqrestore(void *lock, ulong flags)
{
	raw_spin_unlock(lock);
	arch_local_irq_restore(flags);
}

void local_irq_enable(void)
{
	arch_local_irq_enable();
}

void local_irq_disable(void)
{
	arch_local_irq_disable();
}
