
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
               	movq	0x18(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0xc8, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x20(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0xc8, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x28(%rax), %rdx
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
               	addq	$0x20, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	addq	$0x40, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x30, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	subq	%rdx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rdx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
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
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
