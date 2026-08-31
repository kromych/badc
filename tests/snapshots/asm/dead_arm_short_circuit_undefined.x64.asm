
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
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movl	$0x5, %edx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x7, %ecx
               	movq	%rcx, %rdx
               	movl	$0x5, %edx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
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
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movl	$0x2, %edx
               	movq	%rdx, 0x8(%rcx)
               	movq	%rax, %rdx
               	movl	$0x1, %edx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rax
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
               	movl	$0x4, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rax
               	movl	$0x1, %eax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	movl	$0x5, %edi
               	movq	%rdi, 0x8(%rax)
               	movq	(%rax), %rdi
               	andq	$0x1, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
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
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movl	$0x6, %edx
               	movq	%rdx, 0x8(%rcx)
               	movq	%rax, %rdx
               	movl	$0x1, %edx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x7, %eax
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %esi
               	movq	%rsi, 0x8(%rax)
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
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
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
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
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
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
