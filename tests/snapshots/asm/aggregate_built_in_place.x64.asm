
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
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x7, -0x10(%rbp)
               	movq	$0x8, -0x8(%rbp)
               	leaq	0x8(%rdx), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rax, (%rcx)
               	movq	(%rax), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
