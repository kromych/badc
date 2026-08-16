
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
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<echo_small>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movl	$0x7, %eax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x78(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x78(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xc0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x5, %ecx
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movl	$0x6, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x7, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
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
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
