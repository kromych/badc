
struct_value_basics.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movl	%eax, (%rbx)
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movl	%eax, 0x4(%rbx)
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1e, %edi
               	callq	<addr>
               	movl	%eax, (%rbx)
               	movl	$0x28, %edi
               	callq	<addr>
               	movl	%eax, 0x4(%rbx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x64, %edi
               	callq	<addr>
               	movl	%eax, (%rbx)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movl	%eax, 0x4(%rbx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rax
               	addq	%rdx, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x172, %eax            # imm = 0x172
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%r12), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movslq	0x4(%r12), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%r13), %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	0x4(%r13), %rax
               	cmpl	$0xc8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
