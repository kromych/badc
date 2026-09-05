
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
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
               	xorq	%rcx, %rcx
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, (%rax)
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movzbq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
