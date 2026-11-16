
global_struct_return_indirect.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %edx # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
