
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
               	leaq	0x8(%rax), %rcx
               	movq	$0x7, (%rcx)
               	movq	(%rcx), %rdx
               	addq	$0x7, %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rcx), %rcx
               	cmpq	$0xe, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	0x10(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	$0x5, (%rcx)
               	movq	(%rcx), %rdx
               	addq	$0x5, %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	addq	$0x20, %rax
               	movl	(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x9, %rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	andq	$0x1f, %rcx
               	incq	%rcx
               	andq	$0x1f, %rcx
               	movl	(%rax), %edx
               	andq	$-0x20, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %eax
               	andq	$0x1f, %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
