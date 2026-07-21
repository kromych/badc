
switch_binary_search.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0x3, %eax
               	movl	$0x4, %eax
               	movl	$0x5, %eax
               	movl	$0x6, %eax
               	movl	$0x7, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0x3, %eax
               	movl	$0x4, %eax
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
