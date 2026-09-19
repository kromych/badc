
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movq	0x8(%rsi), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rax
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
               	leaq	-<rip>, %rcx       # <addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rdx), %rdx
               	cmpq	%rdx, %rcx
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
