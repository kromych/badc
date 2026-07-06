
commutative_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x1c, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %rcx
               	andq	$0xf0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %rcx
               	orq	$0x10, %rcx
               	cmpq	$0x17, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rax, %rcx
               	xorq	$0xff, %rcx
               	cmpq	$0xf8, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0xa, %ecx
               	subq	%rax, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpq	$0x8, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
