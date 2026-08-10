
range_unproved_comparisons_stay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rcx
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movq	(%rcx), %rcx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	movq	%rcx, %rsi
               	xorq	$0x2, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	$0x2, %rcx
               	ja	<addr>
               	movl	$0x2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ecx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rdx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movq	(%rdx), %rcx
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x64, %rcx
               	jge	<addr>
               	movl	$0x3, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rdx
               	testq	%rdx, %rdx
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x11(%rdx), %rcx
               	cmpq	$-0x11, %rcx
               	jbe	<addr>
               	movl	$0x4, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
