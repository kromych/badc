
param_reg_swap.x64:	file format elf64-x86-64

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

<core>:
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %edx
               	movl	0x8(%rcx), %esi
               	movl	0xc(%rcx), %ecx
               	xorq	%rdx, %rax
               	xorq	%rsi, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movb	$0x0, -0x30(%rbp)
               	movb	$0x1, -0x2f(%rbp)
               	movb	$0x2, -0x2e(%rbp)
               	movb	$0x3, -0x2d(%rbp)
               	movb	$0x4, -0x2c(%rbp)
               	movb	$0x5, -0x2b(%rbp)
               	movb	$0x6, -0x2a(%rbp)
               	movb	$0x7, -0x29(%rbp)
               	movb	$0x8, -0x28(%rbp)
               	movb	$0x9, -0x27(%rbp)
               	movb	$0xa, -0x26(%rbp)
               	movb	$0xb, -0x25(%rbp)
               	movb	$0xc, -0x24(%rbp)
               	movb	$0xd, -0x23(%rbp)
               	movb	$0xe, -0x22(%rbp)
               	movb	$0xf, -0x21(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx       # <addr>
               	callq	<addr>
               	movzbq	-0x38(%rbp), %rax
               	leave
               	retq
