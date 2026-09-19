
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x80000, %edi          # imm = 0x80000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	testl	%r14d, %r14d
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rbx
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movslq	%eax, %rcx
               	imulq	$0xc, %rcx, %rdx
               	addq	%rdx, %rsi
               	movl	(%rsi), %esi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rsi
               	addq	%rdx, %rsi
               	addq	$0x4, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%r12, %rsi
               	jne	<addr>
               	orq	$0x1, %rbx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rsi
               	leaq	(%rsi,%rdx), %rcx
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
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
