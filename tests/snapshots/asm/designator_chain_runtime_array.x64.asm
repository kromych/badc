
designator_chain_runtime_array.x64:	file format elf64-x86-64

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

<build>:
               	xorq	%rdx, %rdx
               	movq	(%rdi), %r8
               	movq	0x8(%rdi), %rcx
               	movq	(%rdi), %rax
               	leaq	(%rax,%rcx), %rdi
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	%rdx, 0x10(%rsi)
               	movq	%rdi, 0x18(%rsi)
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x28, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	0x18(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
