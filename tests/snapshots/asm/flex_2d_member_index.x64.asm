
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
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	addq	%rcx, %rsi
               	xorq	%rdi, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x1c, %rcx
               	jl	<addr>
               	movl	$0x4, %eax
               	movl	%eax, (%rdx)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi), %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x0, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rsi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x1(%rdi)
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rsi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x2, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x2(%rdi)
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rsi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x3, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x3(%rdi)
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rsi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x4, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x4(%rdi)
               	leaq	0x4(%rdx), %rsi
               	imulq	$0x6, %rax, %rdi
               	addq	%rsi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x5, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, 0x5(%rdi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movzbq	0x15(%rdx), %rax
               	xorq	$0x25, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x16(%rdx), %rax
               	xorq	$0x30, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rdx), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x21, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xab, %ecx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x11(%rdx), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rdx), %rax
               	leaq	0x16(%rdx), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rdx), %rax
               	movslq	(%rdx), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rdx), %rax
               	addq	$0x0, %rax
               	movl	$0x77, %ecx
               	movb	%cl, 0x4(%rax)
               	movzbq	0x8(%rdx), %rax
               	xorq	$0x77, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x0, %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x2(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x4(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x6(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0xa(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0xc(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0xe(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x12(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x14(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x16(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x18(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movw	%dx, 0x1a(%rcx)
               	movl	$0x4d, %ecx
               	movw	%cx, 0x18(%rax)
               	movswq	%cx, %rcx
               	cmpq	$0x4d, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x2(%rax), %rcx
               	addq	$0x18, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
