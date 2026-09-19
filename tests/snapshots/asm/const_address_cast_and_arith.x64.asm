
const_address_cast_and_arith.x64:	file format elf64-x86-64

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
               	movq	(%rax), %rdx
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x18(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x20(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rdx
               	leaq	<rip>, %rcx
               	leaq	0x4(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x30(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	0x38(%rax), %rax
               	leaq	<rip>, %rdx
               	leaq	0x20(%rdx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rcx
               	leaq	0x40(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	(%rax), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x40, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	(%rax), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	(%rax), %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rsi
               	subq	%rsi, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	%rdx, %rax
               	cmpq	$0x30, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x18, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
