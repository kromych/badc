
static_initializer_address_casts.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	retq

<main>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	-<rip>, %rcx       # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	leaq	0x4(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	$0x4, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	$0x8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x8(%rdx), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movq	0x10(%rdx), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x8(%rdx), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movq	0x10(%rdx), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
