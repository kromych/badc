
volatile_member_store.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	$0x29, (%rcx)
               	movq	(%rcx), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rcx), %rax
               	addq	$0x3, %rax
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rax
               	incq	%rax
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rax
               	incq	%rax
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rax
               	decq	%rax
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rax
               	cmpq	$0x2d, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	$0x7, 0x8(%rcx)
               	movq	0x8(%rcx), %rax
               	addq	$0x7, %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x8(%rcx), %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x5, %eax
               	leaq	0x10(%rcx), %rdx
               	movq	%rax, 0x8(%rdx)
               	movq	0x8(%rdx), %rsi
               	addq	$0x5, %rsi
               	movq	%rsi, 0x8(%rdx)
               	movq	0x8(%rdx), %rdx
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	0x20(%rcx), %edx
               	andq	$-0x20, %rdx
               	orq	$0x9, %rdx
               	movl	%edx, 0x20(%rcx)
               	movl	0x20(%rcx), %edx
               	andq	$0x1f, %rdx
               	incq	%rdx
               	andq	$0x1f, %rdx
               	movl	0x20(%rcx), %esi
               	andq	$-0x20, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, 0x20(%rcx)
               	movl	0x20(%rcx), %ecx
               	andq	$0x1f, %rcx
               	xorq	$0xa, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
