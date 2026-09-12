
pointer_difference_qualified.x64:	file format elf64-x86-64

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

<pc_relative>:
               	movq	(%rsi), %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	subq	$0x4, %rax
               	retq

<unqualified_left>:
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	retq

<volatile_right>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<wide_elements>:
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	retq

<back>:
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	0x18(%rax), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	subq	%rcx, %rdx
               	subq	$0x4, %rdx
               	subq	$0x5, %rdx
               	leaq	0xc(%rax), %rsi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	subq	$0x3, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	leaq	0x5(%rcx), %rsi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	subq	$0x5, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x28(%rbp), %rcx
               	leaq	0x10(%rcx), %rsi
               	shlq	$0x3, %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	subq	$0x2, %rcx
               	addq	%rdx, %rcx
               	leaq	0x10(%rax), %rdx
               	subq	$0x10, %rdx
               	cmpq	%rax, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leave
               	retq
