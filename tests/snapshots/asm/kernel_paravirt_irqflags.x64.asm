
kernel_paravirt_irqflags.x64:	file format elf64-x86-64

Disassembly of section .text:

<spin_lock_irqsave>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%rdi, %r12
               	leaq	-0x10(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	pv_ops
               	movq	%rbx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	-0x48(%rbp), %rbx
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops-0x4
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rbx
               	movq	-0x10(%rbp), %r13
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	pv_ops
               	addq	$0x8, %rdx
               	movq	%rbx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rbx
               	movq	%r12, %rdi
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_trylock-0x4
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
		R_X86_64_PLT32	queued_spin_lock_slowpath-0x4
               	movq	%r13, %rax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	leave
               	retq

<spin_unlock_irqrestore>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsi, %rbx
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_unlock-0x4
               	movq	%rbx, %rax
               	andq	$0x200, %rax            # imm = 0x200
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	pv_ops
               	addq	$0x10, %rdx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<local_irq_enable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	pv_ops
               	addq	$0x10, %rdx
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	xorq	%rax, %rax
               	leave
               	retq

<local_irq_disable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	$0x0, %rdx
		R_X86_64_32S	pv_ops
               	addq	$0x8, %rdx
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	movq	-0x28(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %rbx
               	xorq	%rax, %rax
               	leave
               	retq
