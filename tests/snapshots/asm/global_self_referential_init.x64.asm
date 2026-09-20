
global_self_referential_init.x64:	file format elf64-x86-64

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

<drop>:
               	movq	%rdi, %rax
               	negq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	0x18(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	0x30(%rax), %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	0x28(%rax), %rdx
               	leaq	0x50(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	0x48(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	0x28(%rax), %rcx
               	subq	%rax, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x54(%rax), %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
