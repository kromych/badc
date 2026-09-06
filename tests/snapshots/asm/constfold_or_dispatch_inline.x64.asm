
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
               	movl	$0xb, %ecx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	movl	$0xc, %eax
               	movl	$0x1, %eax
               	movl	$0xe, %eax
               	movabsq	$-0x4, %rax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movabsq	$-0x3, %rdx
               	movq	%rdx, %rsi
               	movl	$0x1, %esi
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movabsq	$-0x2, %rcx
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movabsq	$-0x3, %rdx
               	movq	%rax, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movabsq	$-0x1, %rdx
               	movq	%rdx, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	movabsq	$-0x2, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rcx
               	movl	$0x2, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movl	$0x3, %eax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movl	$0x2, %edx
               	movq	%rdx, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	movl	$0x4, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x3, %ecx
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movl	$0x2, %edx
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x4, %ecx
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movl	$0x3, %edx
               	movl	$0x6, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x5, %ecx
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movl	$0x4, %edx
               	movl	$0x7, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x6, %ecx
               	movq	%rcx, %rdx
               	movl	$0x1, %edx
               	movl	$0x5, %edx
               	movl	$0x8, %eax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movl	$0x7, %eax
               	movl	$0x1, %eax
               	movl	$0x6, %eax
               	movl	$0x9, %eax
               	xorq	%rax, %rax
               	retq
