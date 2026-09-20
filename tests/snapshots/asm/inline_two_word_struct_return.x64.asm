
inline_two_word_struct_return.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xa, %rax, %rdx
               	movl	%edx, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rdx
               	leaq	0x10(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x20(%rax), %rdx
               	leaq	0x20(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x30(%rax), %rdx
               	leaq	-0x80(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x40(%rax), %rdx
               	leaq	0x40(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x50(%rax), %rdx
               	leaq	0x50(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x60(%rax), %rdx
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movslq	0x70(%rax), %rdx
               	addq	$0x70, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	$0x16665, %rax          # imm = 0x16665
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
