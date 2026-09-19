
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
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	%rax, 0x10(%rdx)
               	movl	%eax, 0x18(%rdx)
               	movl	$0x4, (%rdx)
               	leaq	0x4(%rdx), %rcx
               	imulq	$0x6, %rax, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movb	%r8b, (%rdi)
               	incq	%r8
               	movb	%r8b, 0x1(%rdi)
               	leaq	(%rcx,%rsi), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movb	%r8b, 0x2(%rdi)
               	leaq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	leaq	0x3(%rcx), %r8
               	movb	%r8b, 0x3(%rsi)
               	imulq	$0x6, %rax, %rsi
               	addq	%rdi, %rsi
               	leaq	0x4(%rcx), %rdi
               	movb	%dil, 0x4(%rsi)
               	addq	$0x5, %rcx
               	movb	%cl, 0x5(%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movzbq	0x15(%rdx), %rax
               	xorq	$0x25, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x16(%rdx), %rax
               	xorq	$0x30, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	0x10(%rdx), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x21, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movb	$-0x55, 0x1(%rax)
               	leaq	0x4(%rdx), %rcx
               	leaq	0x16(%rdx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	(%rdx), %rax
               	imulq	$0x6, %rax, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	subq	%rax, %rdx
               	cmpq	$0x1c, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$0x77, 0x4(%rcx)
               	movw	$0x0, (%rax)
               	movw	$0x0, 0x2(%rax)
               	movw	$0x0, 0x4(%rax)
               	leaq	-0x20(%rbp), %rcx
               	movw	$0x0, 0x6(%rcx)
               	movw	$0x0, 0x8(%rcx)
               	movw	$0x0, 0xa(%rcx)
               	movw	$0x0, 0xc(%rcx)
               	movw	$0x0, 0xe(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movw	$0x0, 0x10(%rcx)
               	movw	$0x0, 0x12(%rcx)
               	movw	$0x0, 0x14(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movw	%cx, 0x16(%rdx)
               	movw	%cx, 0x18(%rdx)
               	movw	%cx, 0x1a(%rdx)
               	movw	$0x4d, 0x18(%rax)
               	leaq	0x2(%rax), %rdx
               	addq	$0x18, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	sarq	%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
