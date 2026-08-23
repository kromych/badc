
inline_asm_x64_constraint_a.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movl	$0x14, %eax
               	movl	$0x16, %edx
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %ecx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %rax
               	addq	%rax, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x38(%rbp), %r10
               	movq	(%r10), %rax
               	addq	%rax, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %edx           # imm = 0x1234
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x34, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %ecx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0xff, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
