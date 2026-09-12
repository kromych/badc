
kernel_paravirt_irqflags.x64:	file format elf64-x86-64

Disassembly of section .text:

<spin_lock_irqsave>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops-0x4
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r12
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	movq	%rax, -0x8(%rbp)
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_trylock-0x4
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	queued_spin_lock_slowpath-0x4
               	movq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<spin_unlock_irqrestore>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsi, %rbx
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_unlock-0x4
               	movq	%rbx, %rax
               	andq	$0x200, %rax            # imm = 0x200
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	movq	%rax, -0x8(%rbp)
               	movq	(%rsp), %rbx
               	leave
               	retq

<local_irq_enable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	movq	%rax, -0x8(%rbp)
               	leave
               	retq

<local_irq_disable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	movq	%rax, -0x8(%rbp)
               	leave
               	retq
