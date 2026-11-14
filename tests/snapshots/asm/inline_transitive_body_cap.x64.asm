
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdi
               	callq	<addr>
               	addq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rdi
               	callq	<addr>
               	addq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x3(%rax), %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movabsq	$0x1ac628adc, %r11      # imm = 0x1AC628ADC
               	cmpq	%r11, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
