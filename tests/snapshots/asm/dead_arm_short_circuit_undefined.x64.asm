
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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rcx, %rax
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	jbe	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	jbe	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x2, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movl	$0x7, %edx
               	movq	%rdx, %rcx
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	(%rax), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	cmpq	$0x1, %rsi
               	jbe	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	movl	$0x5, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	(%rax), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	cmpq	$0x1, %rsi
               	jbe	<addr>
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	xorq	%rax, %rax
               	movl	$0x7, %edx
               	movq	%rdx, %rax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x6, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, %rsi
               	movq	%rcx, %rsi
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$0x1, %rcx
               	jbe	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rsi
               	andq	$0xff, %rsi
               	jmp	<addr>
               	movq	0x8(%rax), %rsi
               	andq	$0xff, %rsi
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
