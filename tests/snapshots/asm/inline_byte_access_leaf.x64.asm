
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
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	(%rsi), %eax
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdi), %rax
               	movq	%rax, %rcx
               	bswapq	%rcx
               	movq	0x8(%rsi), %rax
               	movq	%rax, %rdx
               	bswapq	%rdx
               	movl	0x4(%rsi), %eax
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
               	addq	%rdx, %rax
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x38(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jae	<addr>
               	leaq	-0x80(%rbp), %rcx
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	leaq	-0x40(%rbp), %rcx
               	imulq	$0xd, %rax, %rdx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movq	(%rsi), %rax
               	bswapq	%rax
               	movabsq	$0x5121f2c39465360, %r11 # imm = 0x5121F2C39465360
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	(%rsi), %eax
               	cmpl	$0x2c1f1205, %eax       # imm = 0x2C1F1205
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movabsq	$0x807060504030201, %rax # imm = 0x807060504030201
               	movq	%rax, (%rdi)
               	bswapq	%rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	(%rdi), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	0x7(%rdi), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x4101c286063626d, %r11 # imm = 0x4101C286063626D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	cmpl	$0x8, %eax
               	jae	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	imulq	$0x7, %rcx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x1(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x2(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x3(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x4(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x5(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x8, %rsi
               	leaq	0x6(%rcx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	addq	$0x7, %rcx
               	imulq	$0x7, %rcx, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %rdi
               	orq	%rcx, %rdi
               	leaq	-0x40(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, %r8
               	bswapq	%r8
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	leaq	-0x80(%rbp), %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	bswapq	%rcx
               	addq	%r8, %rdx
               	xorq	%rdi, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
