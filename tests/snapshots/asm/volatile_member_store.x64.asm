
volatile_member_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movl	$0x29, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	cmpq	$0x29, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	addq	$0x3, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	decq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	cmpq	$0x2d, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x7, %ecx
               	leaq	0x8(%rax), %rdx
               	movq	%rcx, (%rdx)
               	leaq	0x8(%rax), %rcx
               	movq	(%rcx), %rdx
               	addq	$0x7, %rdx
               	movq	%rdx, (%rcx)
               	leaq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xe, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x5, %ecx
               	leaq	0x10(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rcx, (%rdx)
               	leaq	0x10(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x5, %rdx
               	movq	%rdx, (%rcx)
               	leaq	0x10(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x20(%rax), %rcx
               	movl	(%rcx), %edx
               	andq	$-0x20, %rdx
               	orq	$0x9, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movl	(%rcx), %edx
               	andq	$0x1f, %rdx
               	incq	%rdx
               	andq	$0x1f, %rdx
               	movl	(%rcx), %esi
               	andq	$-0x20, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	addq	$0x20, %rax
               	movl	(%rax), %eax
               	andq	$0x1f, %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
