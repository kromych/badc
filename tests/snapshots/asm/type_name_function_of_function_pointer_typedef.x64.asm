
type_name_function_of_function_pointer_typedef.x64:	file format elf64-x86-64

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
               	addq	$0x3, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	addq	$0x4, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
