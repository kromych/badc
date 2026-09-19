
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
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	movq	(%rax), %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x1(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rdx
               	addq	$0x3, %rdx
               	movsbq	0x2(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	movb	%dl, 0x5(%rcx)
               	popq	%rdx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rax), %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rax), %rdx
               	movb	%dl, 0x5(%rcx)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x15, %edx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x16, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x18, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
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
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
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
