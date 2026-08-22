
global_mutual_reference_init.x64:	file format elf64-x86-64

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
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rcx), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	(%rcx), %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
