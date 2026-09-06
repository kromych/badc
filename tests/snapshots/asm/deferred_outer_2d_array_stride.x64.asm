
deferred_outer_2d_array_stride.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x20(%rax), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x41, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x42, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x43, %ecx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	0x20(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x28(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x44, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x2c(%rax), %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorq	%rax, %rax
               	retq
