
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
               	leaq	-0x30(%rbp), %rax
               	movb	$0x0, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movb	$0x2, 0x2(%rax)
               	movb	$0x3, 0x3(%rax)
               	movb	$0x4, 0x4(%rax)
               	movb	$0x5, 0x5(%rax)
               	movb	$0x6, 0x6(%rax)
               	leaq	-0x30(%rbp), %rax
               	movb	$0x7, 0x7(%rax)
               	movb	$0x8, 0x8(%rax)
               	movb	$0x9, 0x9(%rax)
               	movb	$0xa, 0xa(%rax)
               	movb	$0xb, 0xb(%rax)
               	movb	$0xc, 0xc(%rax)
               	movb	$0xd, 0xd(%rax)
               	leaq	-0x30(%rbp), %rax
               	movb	$0xe, 0xe(%rax)
               	movb	$0xf, 0xf(%rax)
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movzbq	(%rax), %rax
               	leave
               	retq
