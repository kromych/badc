
int128_return_scalar.x64:	file format elf64-x86-64

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
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rdx, %rcx
               	xorq	$-0x3, %rcx
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rax), %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rdx, %rcx
               	xorq	$-0x3, %rcx
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	(%rax), %rax
               	leaq	0x4(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
