
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
               	leaq	(%rdi,%rax), %rcx
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rax
               	leaq	0x1(%rsi), %rdx
               	movsbq	(%rsi), %rsi
               	movb	%sil, (%rcx)
               	movq	%rax, %rcx
               	movq	%rdx, %rsi
               	movl	0x30(%rbp), %eax
               	leaq	-0x1(%rax), %rdx
               	movl	%edx, 0x30(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	incq	%rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rax)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	movl	$0x8, %esi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %rsi
               	movsbq	%sil, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rax
               	incq	%rcx
               	movslq	%ecx, %rdx
               	movsbq	%dl, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movslq	%ebx, %rax
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
               	leaq	0xa(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
