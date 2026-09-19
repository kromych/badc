
atomic_operand_in_working_regs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %rbx
               	movq	$0x64, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x5, %r12d
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%r12, %r10
               	movq	(%rcx), %rax
               	lock
               	cmpxchgq	%r10, (%r11)
               	je	<addr>
               	movq	%rax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %r12
               	leaq	(%rdi,%rsi), %rcx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	testl	%r12d, %r12d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x8(%rbp), %r12
               	cmpq	$0x9, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x9, %rdi
               	addq	%rdi, %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	(%rcx,%rdx), %rax
               	addq	%rbx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x24, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
