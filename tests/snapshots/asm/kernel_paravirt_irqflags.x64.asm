
kernel_paravirt_irqflags.x64:	file format elf64-x86-64

Disassembly of section .text:

<spin_lock_irqsave>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops-0x4
               	movq	%rax, %r12
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_trylock-0x4
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	queued_spin_lock_slowpath-0x4
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<spin_unlock_irqrestore>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rsi, %rbx
               	callq	<addr>
		R_X86_64_PLT32	raw_spin_unlock-0x4
               	testl	$0x200, %ebx            # imm = 0x200
               	je	<addr>
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	popq	%rbx
               	leave
               	retq

<local_irq_enable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0xc
               	popq	%rbp
               	retq

<local_irq_disable>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	pv_ops+0x4
               	popq	%rbp
               	retq
