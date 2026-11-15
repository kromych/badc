
tag_scopes.x64:	file format elf64-x86-64

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
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
