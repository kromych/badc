
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
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %r12
               	leaq	(%rcx), %rax
               	movzbq	0x3(%rax), %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	0x2(%rax), %r8
               	orq	%r8, %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	0x1(%rax), %r8
               	orq	%r8, %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	(%rax), %rax
               	orq	%rdi, %rax
               	movl	%eax, %edi
               	leaq	0x4(%rcx), %rax
               	movzbq	0x3(%rax), %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	0x2(%rax), %r9
               	orq	%r9, %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	0x1(%rax), %r9
               	orq	%r9, %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	(%rax), %rax
               	orq	%r8, %rax
               	movl	%eax, %r8d
               	leaq	0x8(%rcx), %rax
               	movzbq	0x3(%rax), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rax), %rbx
               	orq	%rbx, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rax), %rbx
               	orq	%rbx, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rax), %rax
               	orq	%r9, %rax
               	movl	%eax, %r9d
               	leaq	0xc(%rcx), %rax
               	movzbq	0x3(%rax), %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	0x2(%rax), %rbx
               	orq	%rbx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	0x1(%rax), %rbx
               	orq	%rbx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rax), %rax
               	orq	%rcx, %rax
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	movl	%edi, %edx
               	movl	%r8d, %esi
               	xorq	%rsi, %rdx
               	movl	%r9d, %esi
               	xorq	%rsi, %rdx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r12)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x18(%rbp), %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, 0x9(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xa, %ecx
               	movb	%cl, 0xa(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xb, %ecx
               	movb	%cl, 0xb(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xc, %ecx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xd, %ecx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xe, %ecx
               	movb	%cl, 0xe(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xf, %ecx
               	movb	%cl, 0xf(%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rcx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
