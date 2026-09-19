
epoll_event_array_readback.x64:	file format elf64-x86-64

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

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x80000, %edi          # imm = 0x80000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	testl	%r14d, %r14d
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movabsq	$0x1122334455667788, %r12 # imm = 0x1122334455667788
               	movabsq	$-0x778899aabbccddef, %r13 # imm = 0x8877665544332211
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x1, %esi
               	movl	%esi, (%rcx)
               	leaq	0x4(%rcx), %rax
               	movq	%r12, (%rax)
               	movslq	%r14d, %rdi
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	leaq	0x4(%rcx), %rax
               	movq	%r13, (%rax)
               	movslq	%r14d, %rdi
               	movl	$0x1, %esi
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%r14d, %rdi
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x2, %edx
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	leaq	-0x18(%rbp), %rsi
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movl	(%rdi), %edx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	0x4(%rdi), %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r12, %rdx
               	jne	<addr>
               	orq	$0x1, %rbx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r13, %rcx
               	jne	<addr>
               	orq	$0x2, %rbx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%r14d, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
