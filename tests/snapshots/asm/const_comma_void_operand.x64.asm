
const_comma_void_operand.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
