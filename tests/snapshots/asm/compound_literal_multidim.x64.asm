
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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	addq	$0x0, %rax
               	addq	$0x0, %rax
               	movsbq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x0, %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x0, %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x3, %rdx
               	addq	$0x0, %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
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
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xe, %eax
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
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x16, %eax
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
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
