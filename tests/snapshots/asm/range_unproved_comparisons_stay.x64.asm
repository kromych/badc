
range_unproved_comparisons_stay.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movq	(%rax), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	movq	%rax, %rsi
               	xorq	$0x2, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	$0x2, %rax
               	ja	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, (%rdx)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x64, %rax
               	jge	<addr>
               	movq	(%rdx), %rax
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x64, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x11(%rdx), %rax
               	cmpq	$-0x11, %rax
               	jbe	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	shlq	$0x37, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
