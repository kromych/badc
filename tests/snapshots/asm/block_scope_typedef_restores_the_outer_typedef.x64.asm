
block_scope_typedef_restores_the_outer_typedef.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	popq	%r11
               	retq
