
param_incoming_reg_clobber.x64:	file format elf64-x86-64

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
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %edx
               	movq	%rdx, -0x18(%rbp)
               	movl	-0x18(%rbp), %edx
               	decq	%rdx
               	movl	%edx, %edx
               	addq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x1(%rax), %rdx
               	leaq	0x1(%rcx), %rsi
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rax)
               	movq	%rdx, %rax
               	movq	%rsi, %rcx
               	movl	-0x18(%rbp), %edx
               	leaq	-0x1(%rdx), %rsi
               	movl	%esi, -0x18(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rsi
               	movl	$0x8, %edx
               	subq	%rcx, %rdx
               	movslq	%edx, %rdi
               	movsbq	%dil, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x8, %esi
               	xorq	%rax, %rax
               	movq	%rsi, -0x18(%rbp)
               	movl	-0x18(%rbp), %esi
               	movq	%rsi, -0x18(%rbp)
               	jmp	<addr>
               	leaq	0x1(%rcx), %rsi
               	leaq	0x1(%rdx), %rdi
               	movsbq	(%rdx), %rdx
               	movb	%dl, (%rcx)
               	movq	%rsi, %rcx
               	movq	%rdi, %rdx
               	movl	-0x18(%rbp), %esi
               	leaq	-0x1(%rsi), %rdi
               	movl	%edi, -0x18(%rbp)
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rsi
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdi
               	movsbq	%dil, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
