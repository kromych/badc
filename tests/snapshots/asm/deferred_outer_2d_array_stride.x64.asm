
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
               	subq	%rcx, %rdx
               	cmpq	$0x10, %rdx
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
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x43, %ecx
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x20(%rax)
               	jne	<addr>
               	movq	0x28(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x44, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x2c(%rax), %rcx
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
