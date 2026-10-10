
flex_2d_member_index.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rax
               	movq	$0x0, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x4, -0x20(%rbp)
               	leaq	0x4(%rax), %rcx
               	movb	$0x0, (%rcx)
               	movb	$0x1, 0x1(%rcx)
               	movb	$0x2, 0x2(%rcx)
               	movb	$0x3, 0x3(%rcx)
               	movb	$0x4, 0x4(%rcx)
               	movb	$0x5, 0x5(%rcx)
               	addq	$0x6, %rcx
               	movb	$0x10, (%rcx)
               	leaq	0x4(%rax), %rdx
               	leaq	0x6(%rdx), %rcx
               	movb	$0x11, 0x1(%rcx)
               	movb	$0x12, 0x2(%rcx)
               	movb	$0x13, 0x3(%rcx)
               	movb	$0x14, 0x4(%rcx)
               	leaq	0x6(%rdx), %rcx
               	movb	$0x15, 0x5(%rcx)
               	leaq	0x4(%rax), %rdx
               	leaq	0xc(%rdx), %rcx
               	movb	$0x20, (%rcx)
               	movb	$0x21, 0x1(%rcx)
               	movb	$0x22, 0x2(%rcx)
               	movb	$0x23, 0x3(%rcx)
               	leaq	0xc(%rdx), %rcx
               	movb	$0x24, 0x4(%rcx)
               	leaq	0x4(%rax), %rdx
               	leaq	0xc(%rdx), %rcx
               	movb	$0x25, 0x5(%rcx)
               	leaq	0x12(%rdx), %rcx
               	movb	$0x30, (%rcx)
               	movb	$0x31, 0x1(%rcx)
               	movb	$0x32, 0x2(%rcx)
               	movb	$0x33, 0x3(%rcx)
               	leaq	0x12(%rdx), %rcx
               	movb	$0x34, 0x4(%rcx)
               	leaq	0x4(%rax), %rcx
               	leaq	0x12(%rcx), %rdx
               	movb	$0x35, 0x5(%rdx)
               	leaq	0x10(%rax), %rdx
               	movb	$-0x55, 0x1(%rdx)
               	addq	$0x16, %rax
               	subq	%rcx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	0x18(%rcx), %rax
               	leaq	-0x20(%rbp), %rdx
               	subq	%rdx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$0x77, 0x4(%rcx)
               	movw	$0x0, -0x20(%rbp)
               	movw	$0x0, -0x1e(%rbp)
               	movw	$0x0, -0x1c(%rbp)
               	movw	$0x0, -0x1a(%rbp)
               	movw	$0x0, -0x18(%rbp)
               	movw	$0x0, -0x16(%rbp)
               	movw	$0x0, -0x14(%rbp)
               	movw	$0x0, -0x12(%rbp)
               	movw	$0x0, -0x10(%rbp)
               	movw	$0x0, -0xe(%rbp)
               	movw	$0x0, -0xc(%rbp)
               	xorl	%eax, %eax
               	movw	%ax, -0xa(%rbp)
               	movw	%ax, -0x8(%rbp)
               	movw	%ax, -0x6(%rbp)
               	movw	$0x4d, -0x8(%rbp)
               	leaq	0x2(%rdx), %rsi
               	leaq	0x18(%rdx), %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	sarq	%rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leave
               	retq
