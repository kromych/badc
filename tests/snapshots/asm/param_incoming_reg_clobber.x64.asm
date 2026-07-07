
param_incoming_reg_clobber.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<byte_copy>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdx, 0x30(%rbp)
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	leaq	0x1(%rsi), %rcx
               	movsbq	(%rsi), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	movl	0x30(%rbp), %eax
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0x30(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<swap_or_copy>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%ecx, %rcx
               	movq	%rdx, 0x30(%rbp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x30(%rbp), %edx
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movl	0x30(%rbp), %eax
               	decq	%rax
               	movl	%eax, %eax
               	addq	%rdi, %rax
               	jmp	<addr>
               	leaq	-0x1(%rax), %rcx
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rax)
               	movq	%rcx, %rax
               	movq	%rdx, %rsi
               	movl	0x30(%rbp), %ecx
               	leaq	-0x1(%rcx), %rdx
               	movl	%edx, 0x30(%rbp)
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
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
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	addq	%rax, %rcx
               	movsbq	(%rcx), %rdx
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rsi
               	movsbq	%sil, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
