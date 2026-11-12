
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
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x20(%rdx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x40(%rcx), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x40, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rsi # <addr>
               	subq	%rsi, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	subq	%rdx, %rax
               	cmpq	$0x30, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x10, %rdx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	subq	%rcx, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	subq	%rdx, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	addq	$0x18, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
