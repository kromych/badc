
address_constant_array_strides.x64:	file format elf64-x86-64

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
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	leaq	0x10(%rcx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rax
               	leaq	0x20(%rax), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	0x30(%rax), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	leaq	0x14(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	addq	$0x28, %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$-0x3, %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x62, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpl	$0x65, %esi
               	jne	<addr>
               	movq	(%rdx), %rdx
               	movsbq	0x3(%rdx), %rdx
               	cmpl	$0x68, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x61, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x62, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x10, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
