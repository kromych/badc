
anon_member_designated_init.x64:	file format elf64-x86-64

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
               	subq	$0x98, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x0, -0x88(%rbp)
               	movl	$0x7, -0x30(%rbp)
               	movq	$0x10, -0x28(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movslq	-0x30(%rbp), %rbx
               	movq	-0x20(%rbp), %r12
               	movq	-0x28(%rbp), %r13
               	leaq	-0x18(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	%ebx, (%rdi)
               	movq	%r12, 0x8(%rdi)
               	movq	%r13, 0x10(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	%ebx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%r12, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	$0x3, (%rdi)
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	$0x8, 0x10(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	leaq	-0x88(%rbp), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x5, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movq	$0x4, 0x10(%rdi)
               	movl	$0x9, 0x18(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	leaq	-0x88(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
