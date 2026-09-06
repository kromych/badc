
three_dim_array_indexing.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x3(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movzbq	0x3(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x1(%rcx), %rsi
               	addq	%rsi, %rdx
               	movzbq	0x2(%rcx), %rsi
               	addq	%rsi, %rdx
               	movzbq	0x3(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x4a, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movzbq	0xb(%rax), %rcx
               	xorq	$0xc, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movzbq	0x17(%rax), %rcx
               	xorq	$0x18, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rcx
               	movzbq	(%rax), %rdx
               	subq	%rdx, %rcx
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movzbq	0x4(%rax), %rcx
               	movzbq	(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
