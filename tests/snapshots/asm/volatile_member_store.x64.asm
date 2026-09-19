
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
               	leaq	<rip>, %rax
               	movq	$0x29, (%rax)
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
               	movq	$0x7, 0x8(%rax)
               	movq	0x8(%rax), %rcx
               	addq	$0x7, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x8(%rax), %rcx
               	cmpq	$0xe, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x5, %edx
               	leaq	0x10(%rax), %rcx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x8(%rcx), %rsi
               	addq	$0x5, %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	0x8(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	0x20(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x9, %rcx
               	movl	%ecx, 0x20(%rax)
               	movl	0x20(%rax), %ecx
               	andq	$0x1f, %rcx
               	incq	%rcx
               	andq	$0x1f, %rcx
               	movl	0x20(%rax), %esi
               	andq	$-0x20, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, 0x20(%rax)
               	movl	0x20(%rax), %eax
               	andq	$0x1f, %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	xorl	%eax, %eax
               	retq
