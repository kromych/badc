
builtin_choose_expr.x64:	file format elf64-x86-64

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
               	subq	$0xc8, %rsp
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movb	$0x0, 0x38(%rax)
               	xorl	%eax, %eax
               	leaq	0x40(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	$-0x1, (%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x38, %rax
               	movzbq	(%rax), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xc8, %rsp
               	retq
               	leaq	(%rsp), %rax
               	movb	$0x1, 0x38(%rsp)
               	addq	$0x38, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xc8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xc8, %rsp
               	retq
