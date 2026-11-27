
anon_member_designated_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0xb0, %rsp
               	pushq	%rbx
               	movl	$0x0, 0x28(%rsp)
               	movl	$0x7, 0x80(%rsp)
               	movq	$0x10, 0x88(%rsp)
               	leaq	0x28(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movl	0x80(%rsp), %ebx
               	movq	0x90(%rsp), %rcx
               	movq	0x88(%rsp), %rdx
               	leaq	0x98(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	%ebx, 0x98(%rsp)
               	movq	%rcx, 0xa0(%rsp)
               	movq	%rdx, 0xa8(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movl	(%rax), %esi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movq	0x8(%rax), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	0x30(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	$0x3, 0x30(%rsp)
               	leaq	0x28(%rsp), %rax
               	movq	%rax, 0x38(%rsp)
               	movq	$0x8, 0x40(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	leaq	0x28(%rsp), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x5, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	$0x4, 0x70(%rsp)
               	movl	$0x9, 0x78(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	leaq	0x28(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	movl	0x18(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x48(%rsp), %rdi
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
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
