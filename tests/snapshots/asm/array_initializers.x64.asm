
array_initializers.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movb	%dl, 0x5(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x10(%rbp), %rcx
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
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movsbq	0x5(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x1c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	0xf(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
