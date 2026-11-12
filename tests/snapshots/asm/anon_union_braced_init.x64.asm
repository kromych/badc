
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
               	subq	$0x60, %rsp
               	movl	$0x7, -0x20(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x18(%rbp)
               	movl	-0x20(%rbp), %r10d
               	movq	%r10, 0x8(%rsp)
               	movq	-0x18(%rbp), %r10
               	movq	%r10, (%rsp)
               	leaq	-0x10(%rbp), %rdi
               	movq	0x8(%rsp), %r10
               	movl	%r10d, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movq	(%rsp), %r10
               	movq	%r10, -0x8(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	0x8(%rsp), %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	(%rsp), %rax
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x1, -0x50(%rbp)
               	movl	$0x0, -0x4c(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x5, -0x30(%rbp)
               	movl	$0x0, -0x2c(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
