// snapshot-flags: -c -mcmodel=kernel -fcf-protection=branch

// Interrupt-flag accessors, each an always_inline body whose one statement
// is an asm call site: an indirect call through a member of a table of
// function pointers, with a `"+r" (stack_pointer)` register-variable
// operand ordering it. badc read that operand as a frame-bound
// stack-pointer intrinsic and declined the body, so every site that read
// or wrote the interrupt flag called a 166-byte out-of-line copy with its
// own frame and stack-protector prologue. The accessors have to inline: no
// out-of-line copy of one may survive, and each call site carries the
// indirect call itself. The replacement sections such a site may also emit
// are `inline_asm_pushed_replacement`'s subject, not this one's.

typedef unsigned long ulong;

struct irq_ops {
	ulong (*save_fl)(void);
	void (*irq_disable)(void);
	void (*irq_enable)(void);
};

struct op_table {
	struct irq_ops irq;
};

extern struct op_table ops_table;
register unsigned long stack_pointer asm("rsp");

static inline __attribute__((always_inline)) ulong save_flags(void)
{
	ulong __eax;

	asm volatile("call *%[opptr]"
		     : "=a"(__eax), "+r"(stack_pointer)
		     : [opptr] "m"(ops_table.irq.save_fl)
		     : "memory", "cc");
	return __eax;
}

static inline __attribute__((always_inline)) void irq_off(void)
{
	ulong __eax;

	asm volatile("call *%[opptr]"
		     : "=a"(__eax), "+r"(stack_pointer)
		     : [opptr] "m"(ops_table.irq.irq_disable)
		     : "memory", "cc");
	(void)__eax;
}

static inline __attribute__((always_inline)) void irq_on(void)
{
	ulong __eax;

	asm volatile("call *%[opptr]"
		     : "=a"(__eax), "+r"(stack_pointer)
		     : [opptr] "m"(ops_table.irq.irq_enable)
		     : "memory", "cc");
	(void)__eax;
}

static inline __attribute__((always_inline)) int
flags_disabled(ulong flags)
{
	return !(flags & (1UL << 9));
}

static inline __attribute__((always_inline)) ulong irq_save(void)
{
	ulong flags = save_flags();

	irq_off();
	return flags;
}

static inline __attribute__((always_inline)) void
irq_restore(ulong flags)
{
	if (!flags_disabled(flags))
		irq_on();
}

extern int lock_try(void *lock);
extern void lock_slowpath(void *lock);
extern void lock_release(void *lock);

ulong lock_irqsave(void *lock)
{
	ulong flags = irq_save();

	if (!lock_try(lock))
		lock_slowpath(lock);
	return flags;
}

void unlock_irqrestore(void *lock, ulong flags)
{
	lock_release(lock);
	irq_restore(flags);
}

void enable_irqs(void)
{
	irq_on();
}

void disable_irqs(void)
{
	irq_off();
}
