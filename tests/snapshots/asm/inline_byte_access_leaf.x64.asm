
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
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	bswapq	%rdx
               	leaq	(%rsi), %rcx
               	movq	(%rcx), %r8
               	bswapq	%r8
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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0x7, %rcx, %rdx
               	movl	%edx, %edx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x40(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0xd, %rcx, %rdx
               	movl	%edx, %edx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x40, %ecx
               	jb	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rax
               	bswapq	%rax
               	movabsq	$0x5121f2c39465360, %r11 # imm = 0x5121F2C39465360
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	(%rcx), %eax
               	movl	%eax, %eax
               	cmpl	$0x2c1f1205, %eax       # imm = 0x2C1F1205
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	movabsq	$0x807060504030201, %rdx # imm = 0x807060504030201
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdx
               	bswapq	%rdx
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movzbq	(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x7(%rax), %rdx
               	xorq	$0x8, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x4101c286063626d, %r11 # imm = 0x4101C286063626D
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movl	%edx, %esi
               	imulq	$0x7, %rsi, %rdi
               	movl	%edi, %edi
               	incq	%rdi
               	andq	$0xff, %rdi
               	movq	%rdi, %r8
               	shlq	$0x8, %r8
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, %edi
               	imulq	$0x7, %rdi, %rdi
               	movl	%edi, %edi
               	incq	%rdi
               	andq	$0xff, %rdi
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	leaq	0x2(%rsi), %rdx
               	movl	%edx, %edx
               	imulq	$0x7, %rdx, %rdx
               	movl	%edx, %edx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rdi, %rdx
               	shlq	$0x8, %rdx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x3, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %r8
               	shlq	$0x8, %r8
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movl	%edx, %esi
               	leaq	0x4(%rsi), %rdi
               	movl	%edi, %edi
               	imulq	$0x7, %rdi, %rdi
               	movl	%edi, %edi
               	incq	%rdi
               	andq	$0xff, %rdi
               	orq	%r8, %rdi
               	movq	%rdi, %r8
               	shlq	$0x8, %r8
               	leaq	0x5(%rsi), %rdi
               	movl	%edi, %edi
               	imulq	$0x7, %rdi, %rdi
               	movl	%edi, %edi
               	incq	%rdi
               	andq	$0xff, %rdi
               	orq	%r8, %rdi
               	shlq	$0x8, %rdi
               	leaq	0x6(%rsi), %rdx
               	movl	%edx, %edx
               	imulq	$0x7, %rdx, %rdx
               	movl	%edx, %edx
               	incq	%rdx
               	andq	$0xff, %rdx
               	orq	%rdi, %rdx
               	shlq	$0x8, %rdx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	addq	$0x7, %rcx
               	movl	%ecx, %ecx
               	imulq	$0x7, %rcx, %rcx
               	movl	%ecx, %ecx
               	incq	%rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r8
               	orq	%rcx, %r8
               	leaq	-0x40(%rbp), %rdx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movl	%esi, %edi
               	leaq	(%rdx,%rdi), %r9
               	movq	(%r9), %r9
               	movq	%r9, %rbx
               	bswapq	%rbx
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	movl	%r9d, %r9d
               	addq	%r9, %rdx
               	movl	(%rdx), %edx
               	movl	%edx, %edx
               	leaq	-0x80(%rbp), %r9
               	leaq	(%r9,%rdi), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %rsi
               	bswapq	%rsi
               	movl	%edx, %ecx
               	addq	%rbx, %rcx
               	xorq	%r8, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpl	$0x8, %ecx
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
