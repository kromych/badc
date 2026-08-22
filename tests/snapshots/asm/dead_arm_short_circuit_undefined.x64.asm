
dead_arm_short_circuit_undefined.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x8(%rax)
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x7, %eax
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
