
file_scope_asm_weak_set.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sys_alias_two>:
               	movabsq	$-0x26, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
