
local_array_runtime_nested_init.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movl	$0x5, %eax
               	movl	%eax, -0x50(%rbp)
               	movl	$0x6, %eax
               	movl	%eax, -0x48(%rbp)
               	movl	$0x7, %eax
               	movl	%eax, -0x40(%rbp)
               	movl	$0x8, %eax
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x48(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x38(%rbp), %rsi
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rsi), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	(%rsi), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movslq	(%rdx), %rcx
               	cmpl	$0x6, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
