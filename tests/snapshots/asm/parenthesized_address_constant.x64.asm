
parenthesized_address_constant.x64:	file format elf64-x86-64

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

<fn>:
               	leaq	0x64(%rdi), %rax
               	retq

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x4, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	leaq	0x4(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rdx
               	leaq	0x8(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi
               	addq	$0x14, %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx      # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	$0x2, %edi
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x4, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	leaq	0x4(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rdx
               	leaq	0x8(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x14, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi
               	addq	$0x14, %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx      # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x65, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4d, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x58, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
