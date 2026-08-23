
constfold_or_dispatch_inline.x64:	file format elf64-x86-64

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

<c0>:
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x0, %rax
               	movslq	%eax, %rax
               	retq

<c1>:
               	xorq	%rax, %rax
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<c2>:
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	retq

<c3>:
               	xorq	%rax, %rax
               	leaq	0x4(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	movl	$0xb, %edx
               	movq	%rdx, %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	movl	$0xc, %eax
               	movl	$0xe, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movabsq	$-0x4, %rcx
               	movq	%rcx, %rdx
               	xorq	%rdx, %rdx
               	movq	%rdx, %rsi
               	movabsq	$-0x3, %rsi
               	movq	%rsi, %rdi
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movabsq	$-0x2, %rdx
               	movq	%rdx, %rsi
               	movabsq	$-0x3, %rcx
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movabsq	$-0x1, %rdx
               	movq	%rdx, %rsi
               	movq	%rax, %rsi
               	movabsq	$-0x2, %rsi
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rcx
               	movl	$0x2, %ecx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rcx, %rdx
               	movq	%rax, %rcx
               	movl	$0x3, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0x2, %edx
               	movq	%rdx, %rsi
               	movq	%rax, %rsi
               	movl	$0x4, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0x3, %edx
               	movq	%rdx, %rsi
               	movl	$0x2, %eax
               	movl	$0x5, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0x4, %edx
               	movq	%rdx, %rsi
               	movl	$0x3, %eax
               	movl	$0x6, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0x5, %edx
               	movq	%rdx, %rsi
               	movl	$0x4, %eax
               	movl	$0x7, %eax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movl	$0x6, %edx
               	movq	%rdx, %rsi
               	movl	$0x5, %eax
               	movl	$0x8, %eax
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	movl	$0x7, %eax
               	movl	$0x6, %eax
               	movl	$0x9, %eax
               	xorq	%rax, %rax
               	retq
