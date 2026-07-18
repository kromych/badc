
constfold_or_dispatch_inline.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<c0>:
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x0, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq

<c1>:
               	xorq	%rax, %rax
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq

<c2>:
               	movl	$0x1, %eax
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x2, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq

<c3>:
               	xorq	%rax, %rax
               	leaq	0x4(%rdi), %rax
               	movslq	%eax, %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x1, %eax
               	movl	$0xb, %eax
               	xorq	%rax, %rax
               	movl	$0xc, %eax
               	movl	$0x1, %eax
               	movl	$0xb, %eax
               	xorq	%rax, %rax
               	movl	$0xe, %eax
               	movl	$0x1, %eax
               	movabsq	$-0x4, %rax
               	xorq	%rax, %rax
               	movabsq	$-0x3, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x4, %rax
               	xorq	%rax, %rax
               	movabsq	$-0x1, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x3, %rax
               	xorq	%rax, %rax
               	movabsq	$-0x2, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x3, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x2, %rax
               	xorq	%rax, %rax
               	movabsq	$-0x1, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x2, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x3, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x4, %eax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x3, %eax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x5, %eax
               	movl	$0x1, %eax
               	movl	$0x3, %eax
               	xorq	%rax, %rax
               	movl	$0x4, %eax
               	movl	$0x1, %eax
               	movl	$0x3, %eax
               	xorq	%rax, %rax
               	movl	$0x6, %eax
               	movl	$0x1, %eax
               	movl	$0x4, %eax
               	xorq	%rax, %rax
               	movl	$0x5, %eax
               	movl	$0x1, %eax
               	movl	$0x4, %eax
               	xorq	%rax, %rax
               	movl	$0x7, %eax
               	movl	$0x1, %eax
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	movl	$0x6, %eax
               	movl	$0x1, %eax
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	movl	$0x8, %eax
               	movl	$0x1, %eax
               	movl	$0x6, %eax
               	xorq	%rax, %rax
               	movl	$0x7, %eax
               	movl	$0x1, %eax
               	movl	$0x6, %eax
               	xorq	%rax, %rax
               	movl	$0x9, %eax
               	xorq	%rax, %rax
               	retq
