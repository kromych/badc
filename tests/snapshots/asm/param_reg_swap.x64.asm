
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	leaq	(%rcx), %rax
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	movl	0x4(%rcx), %edi
               	movl	%edi, %edi
               	movl	0x8(%rcx), %r8d
               	movl	%r8d, %r8d
               	movl	0xc(%rcx), %ecx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rdx
               	movl	%eax, %eax
               	movl	%edi, %esi
               	xorq	%rsi, %rax
               	movl	%r8d, %esi
               	xorq	%rsi, %rax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rbx)
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movb	%dl, (%rcx)
               	movl	$0x1, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x2, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x8(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	movl	$0xd, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0xe, %ecx
               	movb	%cl, 0xe(%rax)
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movzbq	(%rax), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
