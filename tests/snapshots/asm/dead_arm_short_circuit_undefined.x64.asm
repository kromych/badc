
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
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	movq	%rax, %rsi
               	movl	$0x1, %esi
               	movq	%rsi, %rdi
               	movq	%rax, %rdi
               	movq	(%rcx), %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rsi, %rcx
               	movq	(%rdx), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x1, %rax
               	setbe	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	movl	$0x7, %edx
               	movq	%rdx, %rcx
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
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
               	movl	$0x7, %ecx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x1, %rdx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x2, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	movl	$0x3, %ecx
               	movq	%rcx, 0x8(%rax)
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
               	movq	%rdx, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x4, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rdx
               	movl	$0x7, %esi
               	movq	%rsi, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x8(%rax)
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
               	movq	%rdx, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x6, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rax
               	movl	$0x1, %eax
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rdx
               	movl	$0x7, %edx
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	movl	$0x7, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	(%rax), %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	setbe	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rcx), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rcx), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rdx), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x8(%rcx), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
