
array_typedef_derivations.x64:	file format elf64-x86-64

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

<get>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	leaq	0xc(%rax), %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
