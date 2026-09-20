
aggregate_built_in_place.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	$0x7, (%rax)
               	movq	$0x8, 0x8(%rax)
               	leaq	0x8(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	%rcx, (%rdx)
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
