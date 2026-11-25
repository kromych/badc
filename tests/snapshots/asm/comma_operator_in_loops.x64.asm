
comma_operator_in_loops.x64:	file format elf64-x86-64

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

<main>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3, %eax
               	retq
