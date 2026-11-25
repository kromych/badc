
inline_byte_access_leaf.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x88, %rsp
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%rax)
               	imulq	$0xd, %rax, %rcx
               	addq	$0x5, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x40(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	movq	0x40(%rsp), %rax
               	bswapq	%rax
               	movabsq	$0x5121f2c39465360, %r11 # imm = 0x5121F2C39465360
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	0x40(%rsp), %eax
               	cmpl	$0x2c1f1205, %eax       # imm = 0x2C1F1205
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x807060504030201, %rax # imm = 0x807060504030201
               	movq	%rax, (%rsp)
               	movzbq	(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	0x7(%rsp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x88, %rsp
               	retq
               	movq	0x40(%rsp), %rax
               	bswapq	%rax
               	movl	0x40(%rsp), %ecx
               	addq	%rcx, %rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	xorq	%r11, %rax
               	bswapq	%rax
               	movq	%rax, (%rsp)
               	movq	0x8(%rsp), %rax
               	bswapq	%rax
               	movq	0x48(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x44(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x10(%rsp), %rax
               	bswapq	%rax
               	movq	0x50(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x48(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x18(%rsp), %rax
               	bswapq	%rax
               	movq	0x58(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x4c(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x20(%rsp), %rax
               	bswapq	%rax
               	movq	0x60(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x50(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x28(%rsp), %rax
               	bswapq	%rax
               	movq	0x68(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x54(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x28(%rsp)
               	movq	0x30(%rsp), %rax
               	bswapq	%rax
               	movq	0x70(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x58(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x30(%rsp)
               	movq	0x38(%rsp), %rax
               	bswapq	%rax
               	movq	0x78(%rsp), %rcx
               	bswapq	%rcx
               	movl	0x5c(%rsp), %edx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	bswapq	%rax
               	movq	%rax, 0x38(%rsp)
               	movq	(%rsp), %rax
               	bswapq	%rax
               	movabsq	$0x4101c286063626d, %r11 # imm = 0x4101C286063626D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	imulq	$0x7, %rcx, %rax
               	incq	%rax
               	andq	$0xff, %rax
               	shlq	$0x8, %rax
               	leaq	0x1(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x2(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x3(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x4(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x5(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x6(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	shlq	$0x8, %rax
               	leaq	0x7(%rcx), %rsi
               	imulq	$0x7, %rsi, %rsi
               	incq	%rsi
               	andq	$0xff, %rsi
               	orq	%rsi, %rax
               	leaq	0x40(%rsp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	(%rdi), %rdi
               	bswapq	%rdi
               	movq	%rdx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rsi
               	movl	(%rsi), %esi
               	leaq	(%rsp), %r8
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	bswapq	%rcx
               	addq	%rdi, %rsi
               	xorq	%rsi, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jb	<addr>
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
