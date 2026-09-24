
struct_by_value_param.x64:	file format elf64-x86-64

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

<sum_pair>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	addq	%rdi, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
