
struct_return_by_value.x64:	file format elf64-x86-64

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

<sum_big>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<echo_small>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x7, %edx
               	leaq	-0x40(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	$0x8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x58(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movl	$0x6, %eax
               	movq	%rax, 0x8(%rdi)
               	movq	%rdx, 0x10(%rdi)
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	cmpl	$0x7, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x8, %edx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
