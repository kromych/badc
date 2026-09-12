
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
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, (%rcx)
               	movzbq	-0x10(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0xc0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movb	$0x0, 0x38(%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
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
               	movl	$0x1, %eax
               	movb	%al, 0x38(%rdi)
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
