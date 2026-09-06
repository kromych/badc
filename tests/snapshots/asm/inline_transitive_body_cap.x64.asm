
inline_transitive_body_cap.x64:	file format elf64-x86-64

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

<mix>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x5, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x7, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0xb, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x11, %rcx
               	xorq	%rax, %rcx
               	leaq	0x1(%rdi), %rax
               	leaq	(%rax,%rax,4), %rax
               	incq	%rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x5, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0xb, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x11, %rdx
               	xorq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	0x2(%rdi), %rax
               	imulq	$0x7, %rax, %rax
               	incq	%rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x5, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0xb, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x11, %rdx
               	xorq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	0x3(%rdi), %rax
               	imulq	$0xb, %rax, %rax
               	incq	%rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x5, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0xb, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x11, %rdx
               	xorq	%rdx, %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	(%rbx), %rax
               	leaq	0x1(%rax), %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	movq	(%rbx), %rax
               	leaq	0x2(%rax), %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	movq	(%rbx), %rax
               	leaq	0x3(%rax), %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	movabsq	$0x1ac628adc, %r11      # imm = 0x1AC628ADC
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
