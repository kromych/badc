
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x80(%rbp,%rax)
               	imulq	$0xd, %rax, %rdx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	movq	-0x40(%rbp), %rax
               	bswapq	%rax
               	movabsq	$0x5121f2c39465360, %r11 # imm = 0x5121F2C39465360
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	-0x40(%rbp), %eax
               	cmpl	$0x2c1f1205, %eax       # imm = 0x2C1F1205
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$0x807060504030201, %rax # imm = 0x807060504030201
               	movq	%rax, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x79(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x40(%rbp), %rax
               	bswapq	%rax
               	movl	-0x40(%rbp), %ecx
               	addq	%rcx, %rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	xorq	%r11, %rax
               	bswapq	%rax
               	movq	%rax, -0x80(%rbp)
               	movq	-0x78(%rbp), %rax
               	bswapq	%rax
               	movq	-0x38(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x3c(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x78(%rbp)
               	movq	-0x70(%rbp), %rax
               	bswapq	%rax
               	movq	-0x30(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x38(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x70(%rbp)
               	movq	-0x68(%rbp), %rax
               	bswapq	%rax
               	movq	-0x28(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x34(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x68(%rbp)
               	movq	-0x60(%rbp), %rax
               	bswapq	%rax
               	movq	-0x20(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x30(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x60(%rbp)
               	movq	-0x58(%rbp), %rax
               	bswapq	%rax
               	movq	-0x18(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x2c(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x58(%rbp)
               	movq	-0x50(%rbp), %rax
               	bswapq	%rax
               	movq	-0x10(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x28(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x50(%rbp)
               	movq	-0x48(%rbp), %rax
               	bswapq	%rax
               	movq	-0x8(%rbp), %rcx
               	bswapq	%rcx
               	movl	-0x24(%rbp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x80(%rbp), %rax
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
