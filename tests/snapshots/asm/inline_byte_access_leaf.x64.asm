
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
               	bswapq	%rax
               	movq	(%rsi), %rcx
               	bswapq	%rcx
               	movl	(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdi), %rax
               	bswapq	%rax
               	movq	0x8(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x4(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%rdi), %rax
               	bswapq	%rax
               	movq	0x10(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x8(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%rdi), %rax
               	bswapq	%rax
               	movq	0x18(%rsi), %rcx
               	bswapq	%rcx
               	movl	0xc(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%rdi), %rax
               	bswapq	%rax
               	movq	0x20(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x10(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%rdi), %rax
               	bswapq	%rax
               	movq	0x28(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x14(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x28(%rdi)
               	movq	0x30(%rdi), %rax
               	bswapq	%rax
               	movq	0x30(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x18(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x30(%rdi)
               	movq	0x38(%rdi), %rax
               	bswapq	%rax
               	movq	0x38(%rsi), %rcx
               	bswapq	%rcx
               	movl	0x1c(%rsi), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x38(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
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
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x1(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x2(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x3(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x5(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	leaq	0x6(%rax), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x8, %rdx
               	addq	$0x7, %rax
               	imulq	$0x7, %rax, %rax
               	incq	%rax
               	andq	$0xff, %rax
               	movq	%rdx, %rsi
               	orq	%rax, %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	(%rdi), %rdi
               	bswapq	%rdi
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rax
               	movl	(%rax), %eax
               	leaq	-0x80(%rbp), %r8
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	bswapq	%rdx
               	addq	%rdi, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jb	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
