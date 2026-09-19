
static_function_pointer_identity.x64:	file format elf64-x86-64

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

<f>:
               	movl	$0x7, %eax
               	retq

<g>:
               	movl	$0x9, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-<rip>, %rsi       # <addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdx       # <addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, (%rax)
               	cmpq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	leaq	-<rip>, %rcx      # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
