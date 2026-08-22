
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
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %esi
               	movb	%sil, 0x7(%rax)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rsi, -0x18(%rbp)
               	movl	-0x18(%rbp), %ecx
               	decq	%rcx
               	movl	%ecx, %ecx
               	addq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rdx
               	leaq	0x1(%rax), %r8
               	movsbq	(%rax), %rax
               	movb	%al, (%rcx)
               	movq	%rdx, %rcx
               	movq	%r8, %rax
               	movl	-0x18(%rbp), %edx
               	leaq	-0x1(%rdx), %r8
               	movl	%r8d, -0x18(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movsbq	(%rdx), %r8
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	movslq	%edx, %r9
               	movsbq	%r9b, %rdx
               	cmpq	%rdx, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x8, %edx
               	xorq	%rax, %rax
               	movq	%rdx, -0x18(%rbp)
               	movl	-0x18(%rbp), %edx
               	movq	%rdx, -0x18(%rbp)
               	movq	%rsi, %rdi
               	jmp	<addr>
               	leaq	0x1(%rdi), %rdx
               	leaq	0x1(%rcx), %r8
               	movsbq	(%rcx), %rcx
               	movb	%cl, (%rdi)
               	movq	%rdx, %rdi
               	movq	%r8, %rcx
               	movl	-0x18(%rbp), %edx
               	leaq	-0x1(%rdx), %r8
               	movl	%r8d, -0x18(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdx
               	movsbq	(%rdx), %rdi
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %r8
               	movsbq	%r8b, %rdx
               	cmpq	%rdx, %rdi
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
