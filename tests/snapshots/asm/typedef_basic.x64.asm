
typedef_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_u32>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	$0x7, %edx
               	movl	%edx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0xb, %edx
               	movl	%edx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0x16, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x2, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x3, %edx
               	movl	%edx, 0x8(%rax)
               	movsbq	(%rcx), %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x48(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x48(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
