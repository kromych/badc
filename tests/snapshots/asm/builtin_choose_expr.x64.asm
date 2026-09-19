
builtin_choose_expr.x64:	file format elf64-x86-64

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

<is_ready>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0x38(%rdi), %rax
               	movzbq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, (%rcx)
               	movzbq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xc0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movb	$0x0, 0x38(%rax)
               	xorl	%eax, %eax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	$-0x1, (%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	movb	$0x1, 0x38(%rdi)
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
