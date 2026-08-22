
static_init_once_guard.x64:	file format elf64-x86-64

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

<step>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	%edi, 0x10(%rbp)
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, (%rax)
               	jmpq	*%rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmpq	*%rcx
               	movl	$0xa, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
