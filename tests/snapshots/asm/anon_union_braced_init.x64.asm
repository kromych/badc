
anon_union_braced_init.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x7, -0x20(%rbp)
               	leaq	<rip>, %rax
               	movq	%rax, -0x18(%rbp)
               	movslq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %r12
               	leaq	-0x10(%rbp), %rdi
               	movl	%ebx, (%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	%r12, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	%ebx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%r12, %rax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x1, (%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	%rdx, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdx
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x5, (%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	%rdx, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
