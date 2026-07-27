
local_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<use_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x5, %ecx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movzbq	0x20(%rdx), %rcx
               	movb	%cl, 0x20(%rax)
               	movzbq	0x21(%rdx), %rcx
               	movb	%cl, 0x21(%rax)
               	movzbq	0x22(%rdx), %rcx
               	movb	%cl, 0x22(%rax)
               	movzbq	0x23(%rdx), %rcx
               	movb	%cl, 0x23(%rax)
               	popq	%rcx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x18(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x1c(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x20(%rax)
               	movl	$0xa, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0xb, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0xc, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x28(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<use_fixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x7, %ecx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rdx), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rdx), %rcx
               	movq	%rcx, 0x28(%rax)
               	popq	%rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x24(%rax)
               	movl	$0x8, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x28(%rax)
               	xorq	%rcx, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x2c(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0xc(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	%ecx, 0x14(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
