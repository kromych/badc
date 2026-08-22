
inline_byte_access_leaf.x64:	file format elf64-x86-64

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

<mix>:
               	leaq	(%rdi), %rax
               	movq	(%rax), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	leaq	(%rsi), %rax
               	movq	(%rax), %rax
               	movq	%rax, %r8
               	bswapq	%r8
               	leaq	(%rdi), %rax
               	leaq	(%rsi), %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, %ecx
               	addq	%r8, %rcx
               	xorq	%rdx, %rcx
               	bswapq	%rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x8(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x4(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x10(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x8(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x18(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0xc(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x20(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x10(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x28(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x14(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x28(%rdi)
               	movq	0x30(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x30(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x18(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x30(%rdi)
               	movq	0x38(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x38(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x1c(%rsi), %eax
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x38(%rdi)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movl	%eax, %ecx
               	addq	%rcx, %rdx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx)
               	leaq	-0x40(%rbp), %rdx
               	movl	%eax, %ecx
               	addq	%rcx, %rdx
               	imulq	$0xd, %rcx, %rcx
               	movl	%ecx, %ecx
               	addq	$0x5, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx)
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x5121f2c39465360, %r11 # imm = 0x5121F2C39465360
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	cmpq	$0x2c1f1205, %rax       # imm = 0x2C1F1205
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movabsq	$0x807060504030201, %rcx # imm = 0x807060504030201
               	movq	%rcx, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x4101c286063626d, %r11 # imm = 0x4101C286063626D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x2, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x3, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x4, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x5, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x6, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x8, %rdx
               	movl	%eax, %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x7, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	%eax, %esi
               	shlq	$0x3, %rsi
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, %r8
               	bswapq	%r8
               	leaq	-0x40(%rbp), %rdx
               	movl	%eax, %esi
               	shlq	$0x2, %rsi
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	movl	%edx, %edx
               	leaq	-0x80(%rbp), %rsi
               	movl	%eax, %edi
               	shlq	$0x3, %rdi
               	movl	%edi, %edi
               	addq	%rdi, %rsi
               	movq	(%rsi), %rsi
               	bswapq	%rsi
               	movl	%edx, %edx
               	addq	%r8, %rdx
               	xorq	%rdx, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x8, %rcx
               	jb	<addr>
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
