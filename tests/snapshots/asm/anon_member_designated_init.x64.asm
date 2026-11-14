
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
               	subq	$0xb0, %rsp
               	movl	$0x0, -0x88(%rbp)
               	movl	$0x7, -0x30(%rbp)
               	movq	$0x10, -0x28(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movl	-0x30(%rbp), %ecx
               	movq	-0x20(%rbp), %rdx
               	movq	-0x28(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	%ecx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x8(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x8(%rsp), %rsi
               	movl	(%rax), %edi
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	$0x3, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x78(%rbp)
               	movq	$0x8, -0x70(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
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
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x5, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	$0x4, -0x40(%rbp)
               	movl	$0x9, -0x38(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	leaq	-0x88(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	movl	0x18(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2a, %rax
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
