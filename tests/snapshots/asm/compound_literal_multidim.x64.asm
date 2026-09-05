
compound_literal_multidim.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x0, %rax
               	addq	$0x0, %rax
               	movsbq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x0, %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x0, %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x3, %rcx
               	addq	$0x0, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x3, %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x3, %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xd, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xe, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%rdx)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rdx)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%rdx)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%rdx)
               	movzbq	0x4(%rax), %rcx
               	movb	%cl, 0x4(%rdx)
               	movzbq	0x5(%rax), %rcx
               	movb	%cl, 0x5(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movzbq	(%rcx), %rax
               	movb	%al, (%rdx)
               	movzbq	0x1(%rcx), %rax
               	movb	%al, 0x1(%rdx)
               	movzbq	0x2(%rcx), %rax
               	movb	%al, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rax
               	movb	%al, 0x3(%rdx)
               	movzbq	0x4(%rcx), %rax
               	movb	%al, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rax
               	movb	%al, 0x5(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movq	%rax, %rsi
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rcx, %rsi
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x16, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leave
               	retq
