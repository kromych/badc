
memset_oob.x64:	file format elf64-x86-64

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
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%esi, %esi
               	movl	$0x64, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
